* EE214B Homework 2 Problem 2
* Samuel Lenius 2015

* ee114 device models
.include /usr/class/ee214/hspice/ee214_hspice.sp

* Resistors
* rx t1 t1 value
rb1   vcc   vb    1k
rb2   vb    0     1k
rc    vcc   vo    500
re1   ve    ve1   100
re2   ve1   0     900


* Capacitors
* Cx t1 t1 value
ce    ve1    0   1

* Transistors
* Mx drain gate source bulk model params...
qn1 vo vb ve npn214

* Sources
vcc vcc 0 DC 3
iin vb 0 AC 1

.op
*.dc ds 0 5 0.01 gs 0.25 5 0.5
.ac dec 10000 1 100G
.option post brief nomod

.measure  ac  gainmax_vout  max   vdb(vo)
.measure  ac  f3db_vout     when  vdb(vo)='gainmax_vout - 3'
.measure  ac  gainmax_ve    max   vdb(ve)
.measure  ac  f3db_ve       when  vdb(ve)='gainmax_ve - 3'


.end
