### Initial Exploration

For my [previous project](https://github.com/fullerf/EPICS-SRSPS365) I was following a cookbook for generating serial ioc applications for devices which operate on a SCPI-like system.  In the process of doing that I found the procedure was both very fragile (easy to screw up and hard to diagnose) and tedious.  So I wrote a perl script which automated the tasks.  Much of the work from that recipe is now eliminated and one can simply write out the recipe into a PARAMS file that the script reads.

Gratefully we need to change very little: just the address of the serial driver `/dev/cu.***` in the st.cmd file.

After that was done I attempted to communicate, as I did manually, with two basic "get Identity" records, which essentially send the `ver` command and report back what they hear.  Some details were learned in getting this to work:

1.  The device returns a multi-line response, beginning with a line-feed `\n`, and ends with a "prompt" character which is either: `:`, `>`, `<`, or `T*`.  Corresponding to, respectively, "idle", "infusing", "withdrawing", or "target reached". The final prompt character is returned after a carriage return and line feed `\r\n`.  This means that the input terminator needs to be set to `\n` so that the stream driver knows the end of the input has been reached.  Second, one needs to expect the initial line feed when parsing the input.  So, an input command in the `.proto` file should read: `in "\n<expected return>"` and the next line (which gives the prompt), must either be ignored via `ExtraInput = Ignore;` or by collecting it with a second `in` command in the `.proto`.

2.  Mysteriously, if you format the output of `ver` with a `stringin` record, it reads just the same as it does on Minicom.  However formatting it with a `waveform` record results (after decoding the ASCII code) to the same output with a `Q` pre-pended to the string.

3.  You must have a record with an `@init` macro, otherwise the device sends nothing and the communication will time-out and disconnect.  Alternatively you can turn up the reply timeout to a human-reactible number of seconds so that you can get a caget command in and keep the connection alive.  Once you connect, it stays open for hours.  Note: the PINI field does not need to be set to "YES", as the stream driver supercedes PINI when an `@init` macro is present. 
