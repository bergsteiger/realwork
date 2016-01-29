{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type 
  socklen_t = UInt32;
  {$EXTERNALSYM socklen_t}
  Psocklen_t = ^socklen_t;

  sa_family_t = UInt8;
  {$EXTERNALSYM sa_family_t}

  sockaddr = record
    sa_len: UInt8; 
    sa_family: sa_family_t;
    sa_data: array [0..13] of Byte;
  end;
  {$EXTERNALSYM sockaddr}
  psockaddr = ^sockaddr;

  msghdr = record
    msg_name: Pointer;
    msg_namelen: socklen_t;
    msg_iov: Piovec;
    msg_iovlen: Integer;
    msg_control: Pointer;
    msg_controllen: socklen_t;
    msg_flags: Integer;
  end;
  {$EXTERNALSYM msghdr}
  Pmsghdr = ^msghdr;

  cmsghdr = record
    cmsg_len: socklen_t;
    cmsg_level: Integer;
    cmsg_type: Integer;
  end;
  {$EXTERNALSYM cmsghdr}
  pcmsghdr = ^cmsghdr;

  linger = record
    l_onoff: Integer;
    l_linger: Integer;
  end;
  {$EXTERNALSYM linger}
  PLinger = ^linger;

const
  SOCK_STREAM     = 1;
  {$EXTERNALSYM SOCK_STREAM}
  SOCK_DGRAM      = 2;
  {$EXTERNALSYM SOCK_DGRAM}
  SOCK_RAW        = 3;
  {$EXTERNALSYM SOCK_RAW}
  SOCK_RDM        = 4; 
  {$EXTERNALSYM SOCK_RDM}
  SOCK_SEQPACKET  = 5;
  {$EXTERNALSYM SOCK_SEQPACKET}

  SOL_SOCKET      = $FFFF;
  {$EXTERNALSYM SOL_SOCKET}

  SO_DEBUG        = $0001;
  {$EXTERNALSYM SO_DEBUG}
  SO_ACCEPTCONN   = $0002;
  {$EXTERNALSYM SO_ACCEPTCONN}
  SO_REUSEADDR    = $0004;
  {$EXTERNALSYM SO_REUSEADDR}
  SO_KEEPALIVE    = $0008;
  {$EXTERNALSYM SO_KEEPALIVE}
  SO_DONTROUTE    = $0010;
  {$EXTERNALSYM SO_DONTROUTE}
  SO_BROADCAST    = $0020;
  {$EXTERNALSYM SO_BROADCAST}
  SO_LINGER       = $0080; //TODO: verify !_Posix_C_Source || _Darwin_CSource ($1080 otherwise)
  {$EXTERNALSYM SO_LINGER}
  SO_OOBINLINE    = $0100;
  {$EXTERNALSYM SO_OOBINLINE}

  SO_SNDBUF       = $1001;
  {$EXTERNALSYM SO_SNDBUF}
  SO_RCVBUF       = $1002;
  {$EXTERNALSYM SO_RCVBUF}
  SO_SNDLOWAT     = $1003;
  {$EXTERNALSYM SO_SNDLOWAT}
  SO_RCVLOWAT     = $1004;
  {$EXTERNALSYM SO_RCVLOWAT}
  SO_SNDTIMEO     = $1005;
  {$EXTERNALSYM SO_SNDTIMEO}
  SO_RCVTIMEO     = $1006;
  {$EXTERNALSYM SO_RCVTIMEO}
  SO_ERROR        = $1007;
  {$EXTERNALSYM SO_ERROR}
  SO_TYPE         = $1008;
  {$EXTERNALSYM SO_TYPE}

  SO_USELOOPBACK  = $0040;
  {$EXTERNALSYM SO_USELOOPBACK}
  SO_REUSEPORT    = $0200 platform;
  {$EXTERNALSYM SO_REUSEPORT}
  SO_TIMESTAMP    = $0400 platform;
  {$EXTERNALSYM SO_TIMESTAMP}
  SO_ACCEPTFILTER = $1000 platform;
  {$EXTERNALSYM SO_ACCEPTFILTER}
  SO_DONTTRUNC    = $2000 platform;
  {$EXTERNALSYM SO_DONTTRUNC}
  SO_WANTMORE     = $4000 platform;
  {$EXTERNALSYM SO_WANTMORE}
  SO_WANTTOOBFLAG = $8000 platform;
  {$EXTERNALSYM SO_WANTTOOBFLAG}
  SO_NREAD            = $1020 platform; (* APPLE: get 1st-packet byte count *)
  {$EXTERNALSYM SO_NREAD}
  SO_NKE              = $1021 platform; (* APPLE: Install socket-level NKE *)
  {$EXTERNALSYM SO_NKE}
  SO_NOSIGPIPE        = $1022 platform; (* APPLE: No SIGPIPE on EPIPE *)
  {$EXTERNALSYM SO_NOSIGPIPE}
  SO_NOADDRERR        = $1023 platform; (* APPLE: Returns EADDRNOTAVAIL when src is not available anymore *)
  {$EXTERNALSYM SO_NOADDRERR}
  SO_NWRITE           = $1024 platform; (* APPLE: Get number of bytes currently in send socket buffer *)
  {$EXTERNALSYM SO_NWRITE}
  SO_REUSESHAREUID    = $1025 platform; (* APPLE: Allow reuse of port)socket by different userids *)
  {$EXTERNALSYM SO_REUSESHAREUID}

  SO_NOTIFYCONFLICT   = $1026 platform; (* APPLE: send notification if there is a bind on a port which is already in use *)
  {$EXTERNALSYM SO_NOTIFYCONFLICT}
  SO_UPCALLCLOSEWAIT  = $1027 platform; (* APPLE: block on close until an upcall returns *)
  {$EXTERNALSYM SO_UPCALLCLOSEWAIT}

  SO_LINGER_SEC       = $1080 platform; (* linger on close if data present (in seconds) *)
  {$EXTERNALSYM SO_LINGER_SEC}
  SO_RESTRICTIONS     = $1081 platform; (* APPLE: deny inbound)outbound)both)flag set *)
  {$EXTERNALSYM SO_RESTRICTIONS}
  SO_RESTRICT_DENYIN  = $00000001 platform;  (* flag for SO_RESTRICTIONS - deny inbound *)
  {$EXTERNALSYM SO_RESTRICT_DENYIN}
  SO_RESTRICT_DENYOUT = $00000002 platform;  (* flag for SO_RESTRICTIONS - deny outbound *)
  {$EXTERNALSYM SO_RESTRICT_DENYOUT}
  SO_RESTRICT_DENYSET = $80000000 platform;  (* flag for SO_RESTRICTIONS - deny has been set *)
  {$EXTERNALSYM SO_RESTRICT_DENYSET}
  SO_RANDOMPORT       = $1082 platform; (* APPLE: request local port randomization *)
  {$EXTERNALSYM SO_RANDOMPORT}
  SO_NP_EXTENSIONS    = $1083 platform; (* To turn off some POSIX behavior *)
  {$EXTERNALSYM SO_NP_EXTENSIONS}

  SO_LABEL            = $1010 platform; (* socket's MAC label *)
  {$EXTERNALSYM SO_LABEL}
  SO_PEERLABEL        = $1011 platform; (* socket's peer MAC label *)
  {$EXTERNALSYM SO_PEERLABEL}

  SOMAXCONN       = 128;
  {$EXTERNALSYM SOMAXCONN}

  MSG_OOB         = $0001;
  {$EXTERNALSYM MSG_OOB}
  MSG_PEEK        = $0002;
  {$EXTERNALSYM MSG_PEEK}
  MSG_DONTROUTE   = $0004;
  {$EXTERNALSYM MSG_DONTROUTE}
  MSG_EOR         = $0008;
  {$EXTERNALSYM MSG_EOR}
  MSG_TRUNC       = $0010;
  {$EXTERNALSYM MSG_TRUNC}
  MSG_CTRUNC      = $0020;
  {$EXTERNALSYM MSG_CTRUNC}
  MSG_WAITALL     = $0040;
  {$EXTERNALSYM MSG_WAITALL}

  MSG_DONTWAIT    = $80 platform; { this message should be nonblocking }
  {$EXTERNALSYM MSG_DONTWAIT}
  MSG_EOF         = $100 platform; { data completes connection }
  {$EXTERNALSYM MSG_EOF}

  MSG_WAITSTREAM  = $200 platform; { wait up to full request.. may return partial }
  {$EXTERNALSYM MSG_WAITSTREAM}
  MSG_FLUSH       = $400 platform; { Start of 'hold' seq; dump so_temp }
  {$EXTERNALSYM MSG_FLUSH}
  MSG_HOLD        = $800 platform; { Hold frag in so_temp }
  {$EXTERNALSYM MSG_HOLD}
  MSG_SEND        = $1000 platform; { Send the packet in so_temp }
  {$EXTERNALSYM MSG_SEND}
  MSG_HAVEMORE    = $2000 platform; { Data ready to be read }
  {$EXTERNALSYM MSG_HAVEMORE}
  MSG_RCVMORE     = $4000 platform; { Data remains in current pkt }
  {$EXTERNALSYM MSG_RCVMORE}
  MSG_NEEDSA      = $10000 platform; { Fail receive if socket address cannot be allocated }
  {$EXTERNALSYM MSG_NEEDSA}

  { Address familes } 

  AF_UNSPEC       = 0;
  {$EXTERNALSYM AF_UNSPEC}
  AF_UNIX         = 1;
  {$EXTERNALSYM AF_UNIX}
  AF_LOCAL        = AF_UNIX deprecated;
  {$EXTERNALSYM AF_LOCAL}
  AF_INET         = 2;
  {$EXTERNALSYM AF_INET}
  AF_INET6        = 30;
  {$EXTERNALSYM AF_INET6}

  AF_IMPLINK      = 3; { arpanet imp addresses }
  {$EXTERNALSYM AF_IMPLINK}
  AF_PUP          = 4; { pup protocols: e.g. BSP }
  {$EXTERNALSYM AF_PUP}
  AF_CHAOS        = 5; { mit CHAOS protocols }
  {$EXTERNALSYM AF_CHAOS}
  AF_NS           = 6; { XEROX NS protocols }
  {$EXTERNALSYM AF_NS}
  AF_ISO          = 7; { ISO protocols }
  {$EXTERNALSYM AF_ISO}
  AF_ECMA         = 8; { European computer manufacturers }
  {$EXTERNALSYM AF_ECMA}
  AF_DATAKIT      = 9; { datakit protocols }
  {$EXTERNALSYM AF_DATAKIT}
  AF_CCITT        = 10; { CCITT protocols, X.25 etc }
  {$EXTERNALSYM AF_CCITT}
  AF_SNA          = 11; { IBM SNA }
  {$EXTERNALSYM AF_SNA}
  AF_DECnet       = 12; { DECnet }
  {$EXTERNALSYM AF_DECnet}
  AF_DLI          = 13; { DEC Direct data link interface }
  {$EXTERNALSYM AF_DLI}
  AF_LAT          = 14; { LAT }
  {$EXTERNALSYM AF_LAT}
  AF_HYLINK       = 15; { NSC Hyperchannel }
  {$EXTERNALSYM AF_HYLINK}
  AF_APPLETALK    = 16; { Apple Talk }
  {$EXTERNALSYM AF_APPLETALK}
  AF_ROUTE        = 17 platform; { Internal Routing Protocol }
  {$EXTERNALSYM AF_ROUTE}
  AF_LINK         = 18; { Link layer interface }
  {$EXTERNALSYM AF_LINK}
  pseudo_AF_XTP   = 19 platform; { eXpress Transfer Protocol (no AF) }
  {$EXTERNALSYM pseudo_AF_XTP}
  AF_COIP         = 20 platform; { connection-oriented IP, aka ST II }
  {$EXTERNALSYM AF_COIP}
  AF_CNT          = 21 platform; { Computer Network Technology }
  {$EXTERNALSYM AF_CNT}
  pseudo_AF_RTIP  = 22 platform; { Help Identify RTIP packets }
  {$EXTERNALSYM pseudo_AF_RTIP}
  AF_IPX          = 23; { Novell Internet Protocol }
  {$EXTERNALSYM AF_IPX}
  AF_SIP          = 24 platform; { Simple Internet Protocol }
  {$EXTERNALSYM AF_SIP}
  pseudo_AF_PIP   = 25 platform; { Help Identify PIP packets }
  {$EXTERNALSYM pseudo_AF_PIP}
  AF_NDRV         = 27 platform; { Network Driver 'raw' access }
  {$EXTERNALSYM AF_NDRV}
  AF_ISDN         = 28 platform;    { Integrated Services Digital Network }
  {$EXTERNALSYM AF_ISDN}
  AF_E164         = AF_ISDN platform;    { CCITT E.164 recommendation }
  {$EXTERNALSYM AF_E164}
  pseudo_AF_KEY   = 29 platform; { Internal key-management function }
  {$EXTERNALSYM pseudo_AF_KEY}
  AF_NATM         = 31 platform; { native ATM access }
  {$EXTERNALSYM AF_NATM}
  AF_SYSTEM       = 32 platform; { Kernel event messages }
  {$EXTERNALSYM AF_SYSTEM}
  AF_NETBIOS      = 33; { NetBIOS }
  {$EXTERNALSYM AF_NETBIOS}
  AF_PPP          = 34 platform; { PPP communication protocol }
  {$EXTERNALSYM AF_PPP}
  AF_ATM          = 30; { ATM }
  {$EXTERNALSYM AF_ATM}
  pseudo_AF_HDRCMPLT = 35 platform; { Used by BPF to not rewrite headers
                                      in interface output routine }
  {$EXTERNALSYM pseudo_AF_HDRCMPLT}
  AF_RESERVED_36  = 36 platform; { Reserved for internal usage }
  {$EXTERNALSYM AF_RESERVED_36}
  AF_NETGRAPH     = 32 platform; { Netgraph sockets }
  {$EXTERNALSYM AF_NETGRAPH}
  AF_IEEE80211    = 37 platform; { IEEE 802.11 protocol }
  {$EXTERNALSYM AF_IEEE80211}
{$IFDEF IOS}
  AF_UTUN         = 38 platform;
  {$EXTERNALSYM AF_UTUN}
  AF_MAX          = 39;
{$ELSE !IOS}
  AF_MAX          = 38;
{$ENDIF}
  {$EXTERNALSYM AF_MAX}

const
  _SS_MAXSIZE = 128;
  {$EXTERNALSYM _SS_MAXSIZE}
  _SS_ALIGNSIZE = SizeOf(Int64);
  {$EXTERNALSYM _SS_ALIGNSIZE}
  _SS_PAD1SIZE = (_SS_ALIGNSIZE - SizeOf(UInt8) - SizeOf(sa_family_t));
  {$EXTERNALSYM _SS_PAD1SIZE}
  _SS_PAD2SIZE = (_SS_MAXSIZE - SizeOf(UInt8) - SizeOf(sa_family_t) -
                   _SS_PAD1SIZE - _SS_ALIGNSIZE);
  {$EXTERNALSYM _SS_PAD2SIZE}

type
  sockaddr_storage = record
    ss_len: UInt8;
    ss_family: sa_family_t;
    ss_pad1: array [0.._SS_PAD1SIZE-1] of UInt8;
    ss_align: Int64; { force structure storage alignment }
    ss_pad2: array [0.._SS_PAD2SIZE-1] of UInt8;
  end;
  {$EXTERNALSYM sockaddr_storage}
  Psockaddr_storage = ^sockaddr_storage;

const
  { Protocol Families }
  PF_UNSPEC     = AF_UNSPEC;
  {$EXTERNALSYM PF_UNSPEC}
  PF_LOCAL      = AF_LOCAL;
  {$EXTERNALSYM PF_LOCAL}
  PF_UNIX       = PF_LOCAL;  { backward compatibility }
  {$EXTERNALSYM PF_UNIX}
  PF_INET       = AF_INET;
  {$EXTERNALSYM PF_INET}
  PF_IMPLINK    = AF_IMPLINK;
  {$EXTERNALSYM PF_IMPLINK}
  PF_PUP        = AF_PUP;
  {$EXTERNALSYM PF_PUP}
  PF_CHAOS      = AF_CHAOS;
  {$EXTERNALSYM PF_CHAOS}
  PF_NS         = AF_NS;
  {$EXTERNALSYM PF_NS}
  PF_ISO        = AF_ISO;
  {$EXTERNALSYM PF_ISO}
  PF_OSI        = AF_ISO;
  {$EXTERNALSYM PF_OSI}
  PF_ECMA       = AF_ECMA;
  {$EXTERNALSYM PF_ECMA}
  PF_DATAKIT    = AF_DATAKIT;
  {$EXTERNALSYM PF_DATAKIT}
  PF_CCITT      = AF_CCITT;
  {$EXTERNALSYM PF_CCITT}
  PF_SNA        = AF_SNA;
  {$EXTERNALSYM PF_SNA}
  PF_DECnet     = AF_DECnet;
  {$EXTERNALSYM PF_DECnet}
  PF_DLI        = AF_DLI;
  {$EXTERNALSYM PF_DLI}
  PF_LAT        = AF_LAT;
  {$EXTERNALSYM PF_LAT}
  PF_HYLINK     = AF_HYLINK;
  {$EXTERNALSYM PF_HYLINK}
  PF_APPLETALK  = AF_APPLETALK;
  {$EXTERNALSYM PF_APPLETALK}
  PF_ROUTE      = AF_ROUTE platform;
  {$EXTERNALSYM PF_ROUTE}
  PF_LINK       = AF_LINK platform;
  {$EXTERNALSYM PF_LINK}
  PF_XTP        = pseudo_AF_XTP platform;   { really just proto family, no AF }
  {$EXTERNALSYM PF_XTP}
  PF_COIP       = AF_COIP platform;
  {$EXTERNALSYM PF_COIP}
  PF_CNT        = AF_CNT platform;
  {$EXTERNALSYM PF_CNT}
  PF_SIP        = AF_SIP platform;
  {$EXTERNALSYM PF_SIP}
  PF_IPX        = AF_IPX platform; { same format as AF_NS }
  {$EXTERNALSYM PF_IPX}
  PF_RTIP       = pseudo_AF_RTIP platform; { same format as AF_INET }
  {$EXTERNALSYM PF_RTIP}
  PF_PIP = pseudo_AF_PIP platform;
  {$EXTERNALSYM PF_PIP}
  PF_NDRV       = AF_NDRV platform;
  {$EXTERNALSYM PF_NDRV}
  PF_ISDN       = AF_ISDN platform;
  {$EXTERNALSYM PF_ISDN}
  PF_KEY        = pseudo_AF_KEY platform;
  {$EXTERNALSYM PF_KEY}
  PF_INET6      = AF_INET6;
  {$EXTERNALSYM PF_INET6}
  PF_NATM       = AF_NATM platform;
  {$EXTERNALSYM PF_NATM}
  PF_SYSTEM     = AF_SYSTEM platform;
  {$EXTERNALSYM PF_SYSTEM}
  PF_NETBIOS    = AF_NETBIOS platform;
  {$EXTERNALSYM PF_NETBIOS}
  PF_PPP        = AF_PPP platform;
  {$EXTERNALSYM PF_PPP}
  PF_RESERVED_36 = AF_RESERVED_36 platform;
  {$EXTERNALSYM PF_RESERVED_36}
  PF_ATM        = AF_ATM;
  {$EXTERNALSYM PF_ATM}
  PF_NETGRAPH   = AF_NETGRAPH platform;
  {$EXTERNALSYM PF_NETGRAPH}
  PF_VLAN       = $766c616e platform; { 'vlan' }
  {$EXTERNALSYM PF_VLAN}
  PF_BOND       = $626f6e64 platform; { 'bond' }
  {$EXTERNALSYM PF_BOND}

  SHUT_RD         = 0;
  {$EXTERNALSYM SHUT_RD}
  SHUT_WR       = 1;
  {$EXTERNALSYM SHUT_RDWR}
  SHUT_RDWR         = 2;
  {$EXTERNALSYM SHUT_WR}

