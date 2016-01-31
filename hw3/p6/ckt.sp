* EE214B Homework 2 Problem 3
* Samuel Lenius 2015

* ee114 device models
.include /usr/class/ee214/hspice/ee214_hspice.sp

* Resistors
* rx t1 t1 value


* Capacitors
* Cx t1 t1 value

* BJTs
* qnx collector base emitter model n

* MOSFETs
*MNx  d     g     s     b     n/pmos214     w     l
MP1   0     in    out   out   pmos214       10u    0.18u

* Diodes
*Dx   a     k       dwell     37.4p
D1    0     out     dwell    37.4p

* Sources
vds   out   0     DC    0.5
vgs   in    0     DC    0.0

.op
.option post brief nomod

.end
