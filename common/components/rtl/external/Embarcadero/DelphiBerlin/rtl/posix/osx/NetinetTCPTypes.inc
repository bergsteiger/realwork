{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type
  tcp_seq = UInt32;
  {$EXTERNALSYM tcp_seq}
  tcp_cc  = UInt32;		// connection count per rfc1644
  {$EXTERNALSYM tcp_cc}
  tcp6_seq = tcp_seq;	// for KAME src sync over BSD*'s
  {$EXTERNALSYM tcp6_seq}

  tcphdr = record
  const
    _TH_FIN = $01;
    _TH_SYN = $02;
    _TH_RST = $04;
    _TH_PUSH= $08;
    _TH_ACK = $10;
    _TH_URG = $20;
    _TH_ECE = $40;
    _TH_CWR = $80;
    _TH_FLAGS = (_TH_FIN or _TH_SYN or _TH_RST or _TH_ACK or _TH_URG or _TH_ECE or _TH_CWR);
  var
    th_sport  : Byte;	    // source port
    th_dport  : Byte;	    // destination port
    th_seq    : tcp_seq;  // sequence number
    th_ack    : tcp_seq;  // acknowledgement number
    {$IFNDEF CPUARM}  // __DARWIN_LITTLE_ENDIAN
    th_x2     : UInt32;   // :4,	// (unused)
    th_off    : UInt32;   //:4;	    // data offset
    {$ELSE} //__DARWIN_BIG_ENDIAN
    th_off    : UInt32;   //4,	// data offset
    th_x2     : UInt32;   //:4;	    // (unused)
    {$ENDIF}
    th_flags  : Byte;
    th_win    : UInt16;		// window
    th_sum    : UInt16;		// checksum
    th_urp    : UInt16;		// urgent pointer
  end;
  {$EXTERNALSYM tcphdr}

  tcp6hdr = tcphdr;	  // for KAME src sync over BSD*'s
  {$EXTERNALSYM tcp6hdr}

const
  TCPOPT_EOL	            =	0 platform;
  {$EXTERNALSYM TCPOPT_EOL}
  TCPOPT_NOP	            =	1 platform;
  {$EXTERNALSYM TCPOPT_NOP}
  TCPOPT_MAXSEG	          = 2 platform;
  {$EXTERNALSYM TCPOPT_MAXSEG}
  TCPOLEN_MAXSEG	        = 4 platform;
  {$EXTERNALSYM TCPOLEN_MAXSEG}
  TCPOPT_WINDOW	          = 3 platform;
  {$EXTERNALSYM TCPOPT_WINDOW}
  TCPOLEN_WINDOW          = 3 platform;
  {$EXTERNALSYM TCPOLEN_WINDOW}
  TCPOPT_SACK_PERMITTED	  = 4 platform;		// Experimental
  {$EXTERNALSYM TCPOPT_SACK_PERMITTED}
  TCPOLEN_SACK_PERMITTED  = 2 platform;
  {$EXTERNALSYM TCPOLEN_SACK_PERMITTED}
  TCPOPT_SACK	            = 5 platform;		// Experimental
  {$EXTERNALSYM TCPOPT_SACK}
  TCPOLEN_SACK            =	8 platform;		// len of sack block
  {$EXTERNALSYM TCPOLEN_SACK}
  TCPOPT_TIMESTAMP        = 8 platform;
  {$EXTERNALSYM TCPOPT_TIMESTAMP}
  TCPOLEN_TIMESTAMP       = 10 platform;
  {$EXTERNALSYM TCPOLEN_TIMESTAMP}
  TCPOLEN_TSTAMP_APPA	    =	(TCPOLEN_TIMESTAMP + 2) platform; // appendix A
  {$EXTERNALSYM TCPOLEN_TSTAMP_APPA}
  TCPOPT_TSTAMP_HDR	      = ((TCPOPT_NOP shl 24) or (TCPOPT_NOP shl 16) or
                            (TCPOPT_TIMESTAMP shl 8) or
                            (TCPOLEN_TIMESTAMP)) platform;
  {$EXTERNALSYM TCPOPT_TSTAMP_HDR}
  MAX_TCPOPTLEN	          =	40 platform;	// Absolute maximum TCP options len
  {$EXTERNALSYM MAX_TCPOPTLEN}
  TCPOPT_CC	              =	11 platform;	// CC options: RFC-1644
  {$EXTERNALSYM TCPOPT_CC}
  TCPOPT_CCNEW            = 12 platform;
  {$EXTERNALSYM TCPOPT_CCNEW}
  TCPOPT_CCECHO	          =	13 platform;
  {$EXTERNALSYM TCPOPT_CCECHO}
  TCPOLEN_CC		          =	6 platform;
  {$EXTERNALSYM TCPOLEN_CC}
  TCPOLEN_CC_APPA	        =	(TCPOLEN_CC+2);
  {$EXTERNALSYM TCPOLEN_CC_APPA}

	TCPOPT_SIGNATURE	      =	19 platform;	// Keyed MD5: RFC 2385
  {$EXTERNALSYM TCPOPT_SIGNATURE}
  TCPOLEN_SIGNATURE	      = 18 platform;
  {$EXTERNALSYM TCPOLEN_SIGNATURE}

  // Option definitions
  TCPOPT_SACK_PERMIT_HDR	= ((TCPOPT_NOP shl 24) or (TCPOPT_NOP shl 16) or
                            (TCPOPT_SACK_PERMITTED shl 8) or
                            TCPOLEN_SACK_PERMITTED) platform;
  {$EXTERNALSYM TCPOPT_SACK_PERMIT_HDR}
  TCPOPT_SACK_HDR         = ((TCPOPT_NOP shl 24) or (TCPOPT_NOP shl 16) or
                            (TCPOPT_SACK shl 8)) platform;
  {$EXTERNALSYM TCPOPT_SACK_HDR}

// Miscellaneous constants
  MAX_SACK_BLKS	= 6 platform; // Max # SACK blocks stored at sender side
  {$EXTERNALSYM MAX_SACK_BLKS}
  TCP_MAX_SACK	= 3 platform;	// MAX # SACKs sent in any segment
  {$EXTERNALSYM TCP_MAX_SACK}

//  Default maximum segment size for TCP.
//  With an IP MTU of 576, this is 536,
//  but 512 is probably more convenient.
//  This should be defined as MIN(512, IP_MSS - sizeof (struct tcpiphdr)).
  TCP_MSS	= 512 platform;
  {$EXTERNALSYM TCP_MSS}

// TCP_MINMSS is defined to be 216 which is fine for the smallest
// link MTU (256 bytes, SLIP interface) in the Internet.
// However it is very unlikely to come across such low MTU interfaces
// these days (anno dato 2004).
// Probably it can be set to 512 without ill effects. But we play safe.
// See tcp_subr.c tcp_minmss SYSCTL declaration for more comments.
// Setting this to "0" disables the minmss check.
  TCP_MINMSS = 216 platform;
  {$EXTERNALSYM TCP_MINMSS}

// TCP_MINMSSOVERLOAD is defined to be 1000 which should cover any type
// of interactive TCP session.
// See tcp_subr.c tcp_minmssoverload SYSCTL declaration and tcp_input.c
// for more comments.
// Setting this to "0" disables the minmssoverload check.
  TCP_MINMSSOVERLOAD = 1000 platform;
  {$EXTERNALSYM TCP_MINMSSOVERLOAD}

// Default maximum segment size for TCP6.
// With an IP6 MSS of 1280, this is 1220,
// but 1024 is probably more convenient. (xxx kazu in doubt)
// This should be defined as MIN(1024, IP6_MSS - sizeof (struct tcpip6hdr))
  TCP6_MSS            = 1024 platform;
  {$EXTERNALSYM TCP6_MSS}
  TCP_MAXWIN          = 65535 platform;	      // largest value for (unscaled) window
  {$EXTERNALSYM TCP_MAXWIN}
  TTCP_CLIENT_SND_WND	= 4096 platform;	      // dflt send window for T/TCP client
  {$EXTERNALSYM TTCP_CLIENT_SND_WND}
  TCP_MAX_WINSHIFT    = 14 platform;	        // maximum window shift
  {$EXTERNALSYM TCP_MAX_WINSHIFT}
  TCP_MAXBURST        =	4 platform;	          // maximum segments in a burst
  {$EXTERNALSYM TCP_MAXBURST}
  TCP_MAXHLEN         = ($f shl 2) platform;	// max length of header in bytes
  {$EXTERNALSYM TCP_MAXHLEN}
  TCP_MAXOLEN         =	(TCP_MAXHLEN - sizeof(tcphdr));
  {$EXTERNALSYM TCP_MAXOLEN}


// User-settable options (used with setsockopt).
  TCP_NODELAY             = $01;          // don't delay send to coalesce packets
  {$EXTERNALSYM TCP_NODELAY}
	TCP_MAXSEG              = $02;          // set maximum segment size
  {$EXTERNALSYM TCP_MAXSEG}
  TCP_NOPUSH              = $04 platform; // don't push last block of write
  {$EXTERNALSYM TCP_NOPUSH}
  TCP_NOOPT               = $08;          // don't use TCP options
  {$EXTERNALSYM TCP_NOOPT}
  TCP_KEEPALIVE           = $10 platform; // idle time used when SO_KEEPALIVE is enabled
  {$EXTERNALSYM TCP_KEEPALIVE}
  TCP_CONNECTIONTIMEOUT   = $20 platform; // connection timeout
  {$EXTERNALSYM TCP_CONNECTIONTIMEOUT}
