import math,sys
PLATE_R=72.5; RIM=3.5
ZONE_HW, ZONE_HH, ZONE_M = 36.0, 18.5, 4.0
BOLT_R, BOLT_M = 2.6, 4.0
bolts=[(64*math.cos(math.radians(a)),64*math.sin(math.radians(a))) for a in (0,90,180,270)] + \
      [(51*math.cos(math.radians(a)),51*math.sin(math.radians(a))) for a in (45,135,225,315)]
def seg_d(p,a,b):
    dx,dy=b[0]-a[0],b[1]-a[1]; L2=dx*dx+dy*dy
    t=0 if L2==0 else max(0,min(1,((p[0]-a[0])*dx+(p[1]-a[1])*dy)/L2))
    return math.hypot(p[0]-(a[0]+t*dx), p[1]-(a[1]+t*dy))
def poly_d(p,poly):
    n=len(poly); inside=False; j=n-1
    for i in range(n):
        if ((poly[i][1]>p[1])!=(poly[j][1]>p[1])) and \
           (p[0]<(poly[j][0]-poly[i][0])*(p[1]-poly[i][1])/(poly[j][1]-poly[i][1])+poly[i][0]):
            inside=not inside
        j=i
    return 0.0 if inside else min(seg_d(p,poly[i],poly[(i+1)%n]) for i in range(n))
def rect_d(poly,hw,hh):
    best=1e9
    for i in range(len(poly)):
        a,b=poly[i],poly[(i+1)%len(poly)]
        for k in range(81):
            t=k/80; p=(a[0]+t*(b[0]-a[0]), a[1]+t*(b[1]-a[1]))
            best=min(best, math.hypot(max(abs(p[0])-hw,0), max(abs(p[1])-hh,0)))
    return best
def check(name,poly,r):
    z=rect_d(poly,ZONE_HW,ZONE_HH)-r
    b=min(poly_d(p,poly) for p in bolts)-r
    m=PLATE_R-(max(math.hypot(*v) for v in poly)+r)
    ok=z>=ZONE_M and b>=BOLT_R+BOLT_M and m>=RIM
    print("  %-7s %-4s  zone %5.2f/%.1f   bolt %5.2f/%.1f   rim %5.2f/%.1f"
          %(name,"PASS" if ok else "FAIL",z,ZONE_M,b,BOLT_R+BOLT_M,m,RIM))
    return ok
def area(poly,r,n=260):
    step=145/n; a=0
    for i in range(n+1):
        x=-72.5+i*step
        for j in range(n+1):
            y=-72.5+j*step
            if poly_d((x,y),poly)<=r: a+=step*step
    return a
R_TB=6.0; R_LR=5.0
TOP =[(-22,29),(22,29),(24,45),(16,51),(-16,51),(-24,45)]
LEFT=[(-45.5,-28),(-45.5,28),(-51.9,30),(-51.9,-30)]
my=lambda p:[(x,-y) for x,y in p][::-1]
mx=lambda p:[(-x,y) for x,y in p][::-1]
cuts=[("top",TOP,R_TB),("bottom",my(TOP),R_TB),("left",LEFT,R_LR),("right",mx(LEFT),R_LR)]
ok=all(check(n,p,r) for n,p,r in cuts)
tot=sum(area(p,r) for _,p,r in cuts)
print("\n  cutout area %.0f mm2 = %.0f%% of the disc"%(tot,100*tot/(math.pi*PLATE_R**2)))
print("  ALL PASS" if ok else "  SOME FAIL"); sys.exit(0 if ok else 1)
