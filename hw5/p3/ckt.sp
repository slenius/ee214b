* EE214B Homework 4 Problem 2
* Samuel Lenius 2016

* ee114 device models
.include /usr/class/ee214/hspice/ee214_hspice.sp


* Resistors
* rx t1 t1 value
rsp vip vgp 10k
rsm vim vgm 10k
rlp vop vdd 1k
rlm vom vdd 1k
rdum vod 0 1e9

* Capacitors
* Cx t1 t1 value
clp vop 0 50f
clm vom 0 50f

* BJTs
* qnx collector base emitter model n

* MOSFETs
*MNx  d     g     s     b     n/pmos214     w     l
m1    vop   vgp   t     0     nmos214       w=11.0u l=0.18u
m2    vom   vgm   t     0     nmos214       w=11.0u l=0.18u

* Diodes
*Dx   a     k       dwell     37.4p

* Sources
vdd vdd 0 1.8
vic vic 0 1
vid vid 0 ac 1
x1 vid vic vip vim balun
x2 vod voc vop vom balun

it t 0 1142u

*itail n_s   0     DC    571u

.op
.ac dec 100 100 10G
.pz v(vod) vid
.noise v(vod) vid
.option post brief accurate
.end
