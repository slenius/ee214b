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
MP1   0   n_g   n_s   n_s     pmos214       w=5u  l=0.18u


* Sources
vds n_s 0 DC 1.8
vgs n_g n_s DC -0.1

.op
.option post brief nomod

.end
