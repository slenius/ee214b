* EE214B Homework 4 Problem 2
* Samuel Lenius 2016

* ee114 device models
.include /usr/class/ee214/hspice/ee214_hspice.sp

* Resistors
* rx t1 t1 value
rl  n_vdd   n_o    6k

* Capacitors
* Cx t1 t1 value
cl n_o 0 100f

* BJTs
* qnx collector base emitter model n

* MOSFETs
*MNx  d     g     s     b     n/pmos214     w     l
mn1   n_o   n_g   n_s   0     nmos214       w=2.76u l=0.18u

* Diodes
*Dx   a     k       dwell     37.4p

* Sources
vdd     n_vdd 0   dc  1.8
vbias   n_g   0   dc  0.9

ib      n_s   0   dc  100u
is      n_s   0   ac  1

.op
.ac dec 100 1e6 1000e9
.pz v(n_o) is
.option post brief accurate
.end
