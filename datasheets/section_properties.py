#!/usr/bin/env python3
"""Section properties of an extrusion profile, straight from its DXF.

Parses LINE and ARC entities, chains them into closed loops, treats the
largest loop as the outer profile and the rest as holes, then integrates
area and second moments via Green's theorem and shifts to the centroid.

    python3 section_properties.py openbuilds-vslot-20x20.dxf [density_g_cm3]

Sanity-check the bounding box and centroid it prints before trusting the
numbers: a profile that fails to chain cleanly shows up as a wrong box or an
off-centre centroid on a symmetric section.
"""
import io, math, sys

def parse(path):
    L = [l.strip() for l in io.open(path, encoding='utf-8', errors='replace')]
    segs, i = [], 0
    while i < len(L) - 1:
        if L[i] == '0' and L[i+1] in ('LINE', 'ARC'):
            kind, j, g = L[i+1], i + 2, {}
            while j < len(L) - 1 and L[j] != '0':
                try: g[int(L[j])] = float(L[j+1])
                except ValueError: pass
                j += 2
            if kind == 'LINE':
                segs.append([(g[10], g[20]), (g[11], g[21])])
            else:
                cx, cy, r, a0, a1 = g[10], g[20], g[40], g[50], g[51]
                if a1 <= a0: a1 += 360
                n = max(8, int(abs(a1 - a0) / 2))
                segs.append([(cx + r*math.cos(math.radians(a0 + (a1-a0)*k/n)),
                              cy + r*math.sin(math.radians(a0 + (a1-a0)*k/n)))
                             for k in range(n + 1)])
            i = j
        else:
            i += 1
    return segs

def chain(segs, tol=1e-4):
    near = lambda p, q: abs(p[0]-q[0]) < tol and abs(p[1]-q[1]) < tol
    segs, loops = segs[:], []
    while segs:
        cur, grew = segs.pop(0), True
        while grew and not near(cur[0], cur[-1]):
            grew = False
            for k, s in enumerate(segs):
                if   near(cur[-1], s[0]):  cur += s[1:]
                elif near(cur[-1], s[-1]): cur += s[::-1][1:]
                elif near(cur[0],  s[-1]): cur = s[:-1] + cur
                elif near(cur[0],  s[0]):  cur = s[::-1][:-1] + cur
                else: continue
                segs.pop(k); grew = True; break
        loops.append(cur)
    return loops

def props(P):
    near = lambda p, q: abs(p[0]-q[0]) < 1e-4 and abs(p[1]-q[1]) < 1e-4
    if near(P[0], P[-1]): P = P[:-1]
    A = Cx = Cy = Ix = Iy = 0.0
    n = len(P)
    for k in range(n):
        x0, y0 = P[k]; x1, y1 = P[(k+1) % n]
        c = x0*y1 - x1*y0
        A  += c
        Cx += (x0 + x1)*c;  Cy += (y0 + y1)*c
        Ix += (y0*y0 + y0*y1 + y1*y1)*c
        Iy += (x0*x0 + x0*x1 + x1*x1)*c
    A /= 2.0
    if abs(A) < 1e-12: return None
    return dict(A=A, Cx=Cx/(6*A), Cy=Cy/(6*A), Ix=Ix/12.0, Iy=Iy/12.0)

def main(path, rho=2.70):
    loops = chain(parse(path))
    pr = sorted((p for L in loops if (p := props(L))),
                key=lambda p: -abs(p['A']))
    if not pr: sys.exit("no closed loops — check the DXF")
    pts = [p for L in loops for p in L]
    xs = [p[0] for p in pts]; ys = [p[1] for p in pts]
    sgn = lambda d: 1 if d['A'] > 0 else -1
    out, holes = pr[0], pr[1:]
    den = sgn(out)*out['A'] - sum(sgn(h)*h['A'] for h in holes)
    A   = abs(out['A']) - sum(abs(h['A']) for h in holes)
    Cx  = (sgn(out)*out['A']*out['Cx'] - sum(sgn(h)*h['A']*h['Cx'] for h in holes))/den
    Cy  = (sgn(out)*out['A']*out['Cy'] - sum(sgn(h)*h['A']*h['Cy'] for h in holes))/den
    Ix  = abs(sgn(out)*out['Ix'] - sum(sgn(h)*h['Ix'] for h in holes)) - A*Cy*Cy
    Iy  = abs(sgn(out)*out['Iy'] - sum(sgn(h)*h['Iy'] for h in holes)) - A*Cx*Cx

    print(f"loops            : {len(pr)}  areas mm^2: "
          + ", ".join(f"{abs(p['A']):.2f}" for p in pr))
    print(f"bounding box     : {max(xs)-min(xs):.2f} x {max(ys)-min(ys):.2f} mm")
    print(f"centroid         : ({Cx:.3f}, {Cy:.3f}) mm")
    print(f"area             : {A:.2f} mm^2 = {A/100:.4f} cm^2")
    print(f"mass @ {rho} g/cm3: {A/100*100*rho:.1f} g/m")
    print(f"Ix               : {Ix:.0f} mm^4 = {Ix/1e4:.4f} cm^4")
    print(f"Iy               : {Iy:.0f} mm^4 = {Iy/1e4:.4f} cm^4")
    print(f"S (c = 10 mm)    : {Ix/10:.0f} mm^3")

if __name__ == '__main__':
    if len(sys.argv) < 2: sys.exit(__doc__)
    main(sys.argv[1], float(sys.argv[2]) if len(sys.argv) > 2 else 2.70)
