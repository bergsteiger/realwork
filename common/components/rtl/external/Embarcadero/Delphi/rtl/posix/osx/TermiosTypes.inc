{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  cc_t = Byte;
  {$EXTERNALSYM cc_t}
  speed_t = Cardinal;
  {$EXTERNALSYM speed_t}
  tcflag_t = Cardinal;
  {$EXTERNALSYM tcflag_t}

const
  NCCS = 20;
  {$EXTERNALSYM NCCS}
  _POSIX_VDISABLE: cc_t = $FF;
  {$EXTERNALSYM _POSIX_VDISABLE}

type
  termios = record
    c_iflag: tcflag_t;      { input mode flags }
    c_oflag: tcflag_t;      { output mode flags }
    c_cflag: tcflag_t;      { control mode flags }
    c_lflag: tcflag_t;      { local mode flags }
    c_cc: packed array[0..NCCS-1] of cc_t;    { control characters }
    c_ispeed: speed_t;      { input speed }
    c_ospeed: speed_t;      { output speed }
  end;
  {$EXTERNALSYM termios}

// Special Control characters
// Index into c_cc[] character array
const
//Name   Subscript  Enabled by
  VEOF     =  0;    // ICANON
  {$EXTERNALSYM VEOF}
  VEOL     =  1;    // ICANON
  {$EXTERNALSYM VEOL}
  VEOL2    =  2;    // ICANON together with IEXTEN
  {$EXTERNALSYM VEOL2}
  VERASE   =  3;    // ICANON
  {$EXTERNALSYM VERASE}
  VWERASE  =  4;    // ICANON together with IEXTEN
  {$EXTERNALSYM VWERASE}
  VKILL    =  5;    // ICANON
  {$EXTERNALSYM VKILL}
  VREPRINT =  6;    // ICANON together with IEXTEN
  {$EXTERNALSYM VREPRINT}
  // 7 spare 1
  VINTR    =  8;    // ISIG
  {$EXTERNALSYM VINTR}
  VQUIT    =  9;    // ISIG
  {$EXTERNALSYM VQUIT}
  VSUSP    = 10;    // ISIG
  {$EXTERNALSYM VSUSP}
  VDSUSP   = 11;    // ISIG together with IEXTEN
  {$EXTERNALSYM VDSUSP}
  VSTART   = 12;    // IXON, IXOFF
  {$EXTERNALSYM VSTART}
  VSTOP    = 13;    // IXON, IXOFF
  {$EXTERNALSYM VSTOP}
  VLNEXT   = 14;    // IEXTEN
  {$EXTERNALSYM VLNEXT}
  VDISCARD = 15;    // IEXTEN
  {$EXTERNALSYM VDISCARD}
  VMIN     = 16;    // !ICANON
  {$EXTERNALSYM VMIN}
  VTIME    = 17;    // !ICANON
  {$EXTERNALSYM VTIME}
  VSTATUS  = 18;    // ICANON together with IEXTEN
  {$EXTERNALSYM VSTATUS}
  // 19 spare 2

// Input flags - software input processing
  IGNBRK    = $0000001;
  {$EXTERNALSYM IGNBRK}
  BRKINT    = $0000002;
  {$EXTERNALSYM BRKINT}
  IGNPAR    = $0000004;
  {$EXTERNALSYM IGNPAR}
  PARMRK    = $0000008;
  {$EXTERNALSYM PARMRK}
  INPCK     = $0000010;
  {$EXTERNALSYM INPCK}
  ISTRIP    = $0000020;
  {$EXTERNALSYM ISTRIP}
  INLCR     = $0000040;
  {$EXTERNALSYM INLCR}
  IGNCR     = $0000080;
  {$EXTERNALSYM IGNCR}
  ICRNL     = $0000100;
  {$EXTERNALSYM ICRNL}
  IXON      = $0000200;
  {$EXTERNALSYM IXON}
  IXOFF     = $0000400;
  {$EXTERNALSYM IXOFF}
  IXANY     = $0000800;
  {$EXTERNALSYM IXANY}
  IMAXBEL   = $0002000 platform;
  {$EXTERNALSYM IMAXBEL}
  IUTF8     = $0004000 platform;
  {$EXTERNALSYM IUTF8}

  // Output flags - software output processing

   OPOST  = $00000001;  //  enable following output processing 
  {$EXTERNALSYM OPOST}
   ONLCR  = $00000002;  //  map NL to CR-NL (ala CRMOD) 
  {$EXTERNALSYM ONLCR}

   OXTABS = $00000004;  //  expand tabs to spaces 
  {$EXTERNALSYM OXTABS}
   ONOEOT = $00000008;  //  discard EOT's (^D) on output) 
  {$EXTERNALSYM ONOEOT}

 // The following block of features is unimplemented.  Use of these flags in
 // programs will currently result in unexpected behaviour.

 // - Begin unimplemented features
   OCRNL  = $00000010;  //  map CR to NL on output 
  {$EXTERNALSYM OCRNL}
   ONOCR  = $00000020;  //  no CR output at column 0 
  {$EXTERNALSYM ONOCR}
   ONLRET = $00000040;  //  NL performs CR function 
  {$EXTERNALSYM ONLRET}
   OFILL  = $00000080;  //  use fill characters for delay 
  {$EXTERNALSYM OFILL}
   NLDLY  = $00000300;  //  \n delay 
  {$EXTERNALSYM NLDLY}
   TABDLY = $00000c04;  //  horizontal tab delay 
  {$EXTERNALSYM TABDLY}
   CRDLY  = $00003000;  //  \r delay 
  {$EXTERNALSYM CRDLY}
   FFDLY  = $00004000;  //  form feed delay 
  {$EXTERNALSYM FFDLY}
   BSDLY  = $00008000;  //  \b delay 
  {$EXTERNALSYM BSDLY}
   VTDLY  = $00010000;  //  vertical tab delay 
  {$EXTERNALSYM VTDLY}
   OFDEL  = $00020000;  //  fill is DEL, else NUL 
  {$EXTERNALSYM OFDEL}

// These manifest constants have the same names as those in the header
// <sys/ioctl_compat.h>, so you are not permitted to have both definitions
// in scope simultaneously in the same compilation unit.  Nevertheless,
// they are required to be in scope when _POSIX_C_SOURCE is requested;
// this means that including the <sys/ioctl_compat.h> header before this
// one when _POSIX_C_SOURCE is in scope will result in redefintions.  We
// attempt to maintain these as the same values so as to avoid this being
// an outright error in most compilers.
  NL0  = $00000000;
  {$EXTERNALSYM NL0}
  NL1  = $00000100;
  {$EXTERNALSYM NL1}

  NL2  = $00000200;
  {$EXTERNALSYM NL2}
  NL3  = $00000300;
  {$EXTERNALSYM NL3}

  TAB0 = $00000000;
  {$EXTERNALSYM TAB0}
  TAB1 = $00000400;
  {$EXTERNALSYM TAB1}
  TAB2 = $00000800;
  {$EXTERNALSYM TAB2}
// not in sys/ioctl_compat.h, use OXTABS value
  TAB3 = $00000004;
  {$EXTERNALSYM TAB3}
  CR0  = $00000000;
  {$EXTERNALSYM CR0}
  CR1  = $00001000;
  {$EXTERNALSYM CR1}
  CR2  = $00002000;
  {$EXTERNALSYM CR2}
  CR3  = $00003000;
  {$EXTERNALSYM CR3}
  FF0  = $00000000;
  {$EXTERNALSYM FF0}
  FF1  = $00004000;
  {$EXTERNALSYM FF1}
  BS0  = $00000000;
  {$EXTERNALSYM BS0}
  BS1  = $00008000;
  {$EXTERNALSYM BS1}
  VT0  = $00000000;
  {$EXTERNALSYM VT0}
  VT1  = $00010000;
  {$EXTERNALSYM VT1}

// End unimplemented features

// 
// Control flags - hardware control of terminal
// 

  CIGNORE    = $00000001; // ignore control flags 
  {$EXTERNALSYM CIGNORE}

  CSIZE      = $00000300; // character size mask 
  {$EXTERNALSYM CSIZE}
  CS5        = $00000000;     // 5 bits (pseudo) 
  {$EXTERNALSYM CS5}
  CS6        = $00000100;     // 6 bits 
  {$EXTERNALSYM CS6}
  CS7        = $00000200;     // 7 bits 
  {$EXTERNALSYM CS7}
  CS8        = $00000300;     // 8 bits 
  {$EXTERNALSYM CS8}

  CSTOPB     = $00000400; // send 2 stop bits 
  {$EXTERNALSYM CSTOPB}
  CREAD      = $00000800; // enable receiver 
  {$EXTERNALSYM CREAD}
  PARENB     = $00001000; // parity enable 
  {$EXTERNALSYM PARENB}
  PARODD     = $00002000; // odd parity, else even 
  {$EXTERNALSYM PARODD}
  HUPCL      = $00004000; // hang up on last close 
  {$EXTERNALSYM HUPCL}
  CLOCAL     = $00008000; // ignore modem status lines 
  {$EXTERNALSYM CLOCAL}

  CCTS_OFLOW = $00010000; // CTS flow control of output 
  {$EXTERNALSYM CCTS_OFLOW}
  CRTS_IFLOW = $00020000; // RTS flow control of input 
  {$EXTERNALSYM CRTS_IFLOW}
  CDTR_IFLOW = $00040000; // DTR flow control of input 
  {$EXTERNALSYM CDTR_IFLOW}
  CDSR_OFLOW = $00080000; // DSR flow control of output 
  {$EXTERNALSYM CDSR_OFLOW}
  CCAR_OFLOW = $00100000; // DCD flow control of output 
  {$EXTERNALSYM CCAR_OFLOW}
  MDMBUF     = $00100000; // old name for CCAR_OFLOW 
  {$EXTERNALSYM MDMBUF}

  CRTSCTS    = (CCTS_OFLOW or CRTS_IFLOW);
  {$EXTERNALSYM CRTSCTS}

// 
// "Local" flags - dumping ground for other state
// 
// Warning: some flags in this structure begin with
// the letter "I" and look like they belong in the
// input flag.
// 

  ECHOKE     = $00000001; // visual erase for line kill 
  {$EXTERNALSYM ECHOKE}

  ECHOE      = $00000002; // visually erase chars 
  {$EXTERNALSYM ECHOE}
  ECHOK      = $00000004; // echo NL after line kill 
  {$EXTERNALSYM ECHOK}
  ECHO       = $00000008; // enable echoing 
  {$EXTERNALSYM ECHO}
  ECHONL     = $00000010; // echo NL even if ECHO is off 
  {$EXTERNALSYM ECHONL}

  ECHOPRT    = $00000020; // visual erase mode for hardcopy 
  {$EXTERNALSYM ECHOPRT}
  ECHOCTL    = $00000040; // echo control chars as ^(Char) 
  {$EXTERNALSYM ECHOCTL}

  ISIG       = $00000080; // enable signals INTR, QUIT, [D]SUSP 
  {$EXTERNALSYM ISIG}
  ICANON     = $00000100; // canonicalize input lines 
  {$EXTERNALSYM ICANON}

  ALTWERASE  = $00000200; // use alternate WERASE algorithm 
  {$EXTERNALSYM ALTWERASE}

  IEXTEN     = $00000400; // enable DISCARD and LNEXT 
  {$EXTERNALSYM IEXTEN}

  EXTPROC    = $00000800; // external processing 
  {$EXTERNALSYM EXTPROC}

  TOSTOP     = $00400000; // stop background jobs from output 
  {$EXTERNALSYM TOSTOP}

  FLUSHO     = $00800000; // output being flushed (state) 
  {$EXTERNALSYM FLUSHO}
  NOKERNINFO = $02000000; // no kernel output from VSTATUS 
  {$EXTERNALSYM NOKERNINFO}
  PENDIN     = $20000000; // XXX retype pending input (state) 
  {$EXTERNALSYM PENDIN}

  NOFLSH     = $80000000; // don't flush after interrupt 
  {$EXTERNALSYM NOFLSH}

// 
// Commands passed to tcsetattr() for setting the termios structure.
// 
  TCSANOW   =   0; // make change immediate 
  {$EXTERNALSYM TCSANOW}
  TCSADRAIN =   1; // drain output, then change 
  {$EXTERNALSYM TCSADRAIN}
  TCSAFLUSH =   2; // drain output, flush input 
  {$EXTERNALSYM TCSAFLUSH}

  TCSASOFT  = $10; // flag - don't alter h.w. state 
  {$EXTERNALSYM TCSASOFT}

// 
// Standard speeds
// 
  B0     =     0;
  {$EXTERNALSYM B0}
  B50    =    50;
  {$EXTERNALSYM B50}
  B75    =    75;
  {$EXTERNALSYM B75}
  B110   =   110;
  {$EXTERNALSYM B110}
  B134   =   134;
  {$EXTERNALSYM B134}
  B150   =   150;
  {$EXTERNALSYM B150}
  B200   =   200;
  {$EXTERNALSYM B200}
  B300   =   300;
  {$EXTERNALSYM B300}
  B600   =   600;
  {$EXTERNALSYM B600}
  B1200  =  1200;
  {$EXTERNALSYM B1200}
  B1800  =  1800;
  {$EXTERNALSYM B1800}
  B2400  =  2400;
  {$EXTERNALSYM B2400}
  B4800  =  4800;
  {$EXTERNALSYM B4800}
  B9600  =  9600;
  {$EXTERNALSYM B9600}
  B19200 = 19200;
  {$EXTERNALSYM B19200}
  B38400 = 38400;
  {$EXTERNALSYM B38400}

  B7200   =  7200;
  {$EXTERNALSYM B7200}
  B14400  =  14400;
  {$EXTERNALSYM B14400}
  B28800  =  28800;
  {$EXTERNALSYM B28800}
  B57600  =  57600;
  {$EXTERNALSYM B57600}
  B76800  =  76800;
  {$EXTERNALSYM B76800}
  B115200 = 115200;
  {$EXTERNALSYM B115200}
  B230400 = 230400;
  {$EXTERNALSYM B230400}
  EXTA = 19200;
  {$EXTERNALSYM EXTA}
  EXTB = 38400;
  {$EXTERNALSYM EXTB}

  TCIFLUSH  = 1;
  {$EXTERNALSYM TCIFLUSH}
  TCOFLUSH  = 2;
  {$EXTERNALSYM TCOFLUSH}
  TCIOFLUSH = 3;
  {$EXTERNALSYM TCIOFLUSH}
  TCOOFF    = 1;
  {$EXTERNALSYM TCOOFF}
  TCOON     = 2;
  {$EXTERNALSYM TCOON}
  TCIOFF    = 3;
  {$EXTERNALSYM TCIOFF}
  TCION     = 4;
  {$EXTERNALSYM TCION}
