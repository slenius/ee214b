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
MN1   n_d   n_g   0     0     nmos214       w=20u  l=0.7u


* Sources
vd n_d 0 DC 1.5
vg n_g 0 DC 0.75

.op
.option post brief nomod

.end