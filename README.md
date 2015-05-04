EPICS-KDSLegato130
==============

Using the template I made for making [SCPI control iocs](https://github.com/fullerf/EPICS-SCPI-Template) I am now making a control IOC for a KD Scientific Legato 130 Syringe pump. Refer there for more information on the template and its use.

## Installation Instructions:

```
cd <Directory Where you Keep IOC apps>
git clone https://github.com/fullerf/EPICS-KDSLegato130.git <desired application name>
./genSCPItemplate.pl
```

You have to hit enter once in that perl script when it prompts you for an application name.  Just hit enter and the application will be named the same as the folder you ran the script in.

So far tested to work on the following operating systems with EPICS base 3.14.12 installed.

* OS X Mavericks
* OS X Yosemite

## Current Status:

* Maps infuse withdraw to +/- rate respectively
* allows direction change without mode change
* bound checking on the input rates (code is ugly for this)
* stop when reached target volume
* monitor infused/withdrawn volume.

## Known Bugs/Features

* When the target volume is reached, the "Go" status will remain on, but the syringe has stopped.  This is because the machine does not report its status unless queried.  Executing any command, like updating the speed (even to the same value) will update the ioc's knowledge of the machine status.  Could be easily fixed by adding a periodic scan to probe the status, but I didn't want to add unnecessary I/O.
* genSCPItemplate.pl does not make st.cmd executable.  You have to do this manually by browsing to the st.cmd directory and executing `chmod u+x st.cmd`.
