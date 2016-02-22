* EE214B Homework 6 Problem 5
* Samuel Lenius 2016

* ee114 device models
.include /usr/class/ee214/hspice/ee214_hspice.sp

* Resistors
* rx t1 t1 value
rf  vo  vin 5000

* Capacitors
* Cx t1 t1 value
cin   vin 0 10p

* BJTs
* qnx collector base emitter model n
qn1   vdd       vb   vo      npn214 1

* MOSFETs
*MNx  d     g     s     b     n/pmos214     w     l
mn1   vb    vin   0     0     nmos214       w=9.4u l=0.24u

* Diodes
*Dx   a     k       dwell     37.4p

* Sources
vdd vdd 0 1.8

ib1 vdd vb 200u
ib2 vo 0   200u

is vin 0 AC 1

.op
.ac dec 100 1e6 1000e9
.option post brief accurate

.measure  ac  gainmax_vout  max   vdb(vo)
.measure  ac  f3db_vout     when  vdb(vo)='gainmax_vout - 3'

.end
