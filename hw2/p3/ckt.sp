* EE214B Homework 2 Problem 3
* Samuel Lenius 2015

* ee114 device models
.include /usr/class/ee214/hspice/ee214_hspice.sp

* Resistors
* rx t1 t1 value
rs vi vb 100k


* Capacitors
* Cx t1 t1 value
cl vo 0 20f

* Transistors
* Mx collector base emitter model n
qn1 vcc vb vo npn214

* Sources
vcc vcc 0 DC 3
vii vii 0 DC 1.5
ib vo 0 DC 0.5m
vi vi vii AC 1



.op
*.dc ds 0 5 0.01 gs 0.25 5 0.5
.ac dec 10000 1 100G
.option post brief nomod

.measure  ac  gainmax_vout  max   vdb(vo)
.measure  ac  f3db_vout     when  vdb(vo)='gainmax_vout - 3'

.pz v(vo) vi


.end
