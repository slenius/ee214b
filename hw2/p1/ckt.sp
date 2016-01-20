* EE114 Homework 2 Problem 1
* Samuel Lenius 2015

* ee114 device models
.include /usr/class/ee114/hspice/ee114_hspice.sp

* Resistors
* rx t1 t1 value
r1 vin          ac_coupl  10k
r2 gate_mn1     0         30k
r3 vdd          gate_mn1  20k
r4 vdd          drain_mn1 2k
r5 source_mn1   0         300
r6 vout         0         3k

* Capacitors
* Cx t1 t1 value
c1 ac_coupl     gate_mn1  1.0
c2 drain_mn1    vout      1.0

* Transistors
* Mx drain gate source bulk model params...
mn1 drain_mn1 gate_mn1 source_mn1 source_mn1 nmos114 w=6.32u l=1u

* Sources
vdd vdd 0 DC 5
vin vin 0 AC 1

.op
*.dc ds 0 5 0.01 gs 0.25 5 0.5
.ac dec 1000 1k 1G
.option post brief nomod
.probe v(gate_mn1, 0)

.end
