# ZX81 List Remedy
Originally posted on [Sinclair ZX World](https://www.sinclairzxworld.com/viewtopic.php?f=5&t=1276) by user [GCHarder](https://www.sinclairzxworld.com/memberlist.php?mode=viewprofile&u=1558).

I modified it to:
- allow the display of lines longer than 255 bytes
- not be fooled by 7Eh's in REM statements
- work in either fast or slow mode

Will work on first edition ROM because it adjusts ROM calls.

The program will install the list tool at an address you specify when you RUN after loading. I recommend placing it above RAMTOP.

Example (16k RAM):
```
NEW
POKE 16389,127
NEW
LOAD ""
RUN
[Enter 32512 at the RELOCATE TO: input prompt.]
```

The program listing will be displayed using the newly relocated code. Now you can NEW and enter your program or LOAD a new program. To list it:
```
RAND USR 32512
```

Taken from a March 1983 article in Your Computer by Robert Pearlman.
![Copy of original article](https://github.com/stroebeljc/List-Remedy/blob/master/01-List%20Remedy.jpg)
