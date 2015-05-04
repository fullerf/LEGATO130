EPICS-KDSLegato130
==============

Using the template I made for making [SCPI control iocs](https://github.com/fullerf/EPICS-GenSCPITemplate) I am now making a control IOC for a KD Scientific Legato 130 Syringe pump.

## Installation Instructions:

```
cd <Directory Where you Keep IOC apps>
git clone https://github.com/fullerf/EPICS-KDSLegato130.git <desired application name>
./genSCPItemplate.pl
```

You have to hit enter once in that perl script.  I'll fix that later, but otherwise it builds the ioc and should result in a functional ioc.

So far tested to work on the following operating systems:

* OS X Mavericks

## Current Status:

* Maps infuse withdraw to +/- rate respectively
* allows direction change without mode change
* jog mode for quick bursts, run mode for continuous run.
* bound checking on the input rates (code is ugly for this)
* stop when reached target volume
* monitor infused/withdrawn volume.

## Known Bugs:

* Changing rate to 0 while running results in change of direction, moving at Jog speed. Need to fix bound checking code and rapid reversal code bofore fixing this bug is feasible.
* The first sign change to the velocity while running can result in no change.  Stopping the run and reinitiating it will fix it after.
* genSCPItemplate.pl does not make st.cmd executable.  You have to do this manually by `chmod u+x st.cmd`.
