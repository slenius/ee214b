* EE214 simulation example
* MOSFET I-V curves
* B. Murmann, Winter 2010

* ee214 device models
.include /usr/class/ee214/hspice/ee214_hspice.sp

.param gs=1 ds=1

mn1 dn gn 0 0 nmos214 w=5u l=0.18u
mp1 dp gp 0 0 pmos214 w=5u l=0.18u

vgn gn 0 'gs'
vdn dn 0 'ds'
vgp gp 0 '-gs'
vdp dp 0 '-ds'

.op
.dc ds 0 1.8 0.01 gs 0.2 1.8 0.2
.option post brief nomod
.probe i(mn1) i(mp1)

.end
