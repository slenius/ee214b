* EE214B Homework 4 Problem 2
* Samuel Lenius 2016

* ee114 device models
.include /usr/class/ee214/hspice/ee214_hspice.sp

.param k=1.268

* Resistors
* rx t1 t1 value

* Capacitors
* Cx t1 t1 value
clp vop 0 500f
clm vom 0 500f

* BJTs
* qnx collector base emitter model n

* MOSFETs
*MNx  d     g     s     b     n/pmos214     w     l
*mn1   vop   vip   t     0     nmos214       w='k*13.8u' l=0.24u
*mn2   vom   vim   t     0     nmos214       w='k*13.8u' l=0.24u

*mp1   vop   vop   vdd   vdd   pmos214       w='k*43.0u' l=0.24u
*mp2   vom   vom   vdd   vdd   pmos214       w='k*43.0u' l=0.24u

mn1   vop   vip   t     0     nmos214       w=38.2u l=0.24u
mn2   vom   vim   t     0     nmos214       w=38.2u l=0.24u

mp1   vop   vop   vdd   vdd   pmos214       w=124u l=0.24u
mp2   vom   vom   vdd   vdd   pmos214       w=124u l=0.24u

* Diodes
*Dx   a     k       dwell     37.4p

* Sources
vdd vdd 0 1.8
vic vic 0 1
vid vid 0 ac 1

x1 vip vim vid vic diffdrive
x2 vod voc vop vom diffsense

it t 0 884u

*itail n_s   0     DC    571u

.op
.ac dec 100 1e6 1000e9
.pz v(vod) vid
.option post brief accurate
.end
