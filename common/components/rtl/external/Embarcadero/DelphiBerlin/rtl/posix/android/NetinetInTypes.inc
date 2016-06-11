{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type
  in_port_t = UInt16;
  {$EXTERNALSYM in_port_t}
  in_addr_t = UInt32;
  {$EXTERNALSYM in_addr_t}

  in_addr = record
    s_addr: in_addr_t;
  end;
  {$EXTERNALSYM in_addr}
  Pin_addr = ^in_addr;

{ Standard well-defined IP protocols.  }
const
  IPPROTO_IP = 0;               // Dummy protocol for TCP.
  {$EXTERNALSYM IPPROTO_IP}
  IPPROTO_HOPOPTS = 0 platform; // IPv6 Hop-by-Hop options.
  {$EXTERNALSYM IPPROTO_HOPOPTS}
  IPPROTO_ICMP = 1;             // Internet Control Message Protocol.
  {$EXTERNALSYM IPPROTO_ICMP}
  IPPROTO_IGMP = 2 platform;    // Internet Group Management Protocol.
  {$EXTERNALSYM IPPROTO_IGMP}
  IPPROTO_IPIP = 4 platform;    // IPIP tunnels (older KA9Q tunnels use 94).
  {$EXTERNALSYM IPPROTO_IPIP}
  IPPROTO_TCP = 6;              // Transmission Control Protocol.
  {$EXTERNALSYM IPPROTO_TCP}
  IPPROTO_EGP = 8 platform;     // Exterior Gateway Protocol.
  {$EXTERNALSYM IPPROTO_EGP}
  IPPROTO_PUP = 12 platform;    // PUP protocol.
  {$EXTERNALSYM IPPROTO_PUP}
  IPPROTO_UDP = 17;             // User Datagram Protocol.
  {$EXTERNALSYM IPPROTO_UDP}
  IPPROTO_IDP = 22 platform;    // XNS IDP protocol.
  {$EXTERNALSYM IPPROTO_IDP}  
  IPPROTO_TP = 29 platform;     // SO Transport Protocol Class 4.
  {$EXTERNALSYM IPPROTO_TP}  
  IPPROTO_DCCP = 33 platform;   // (DCCP) Datagram Congestion Control Protocol  (#NOPOSIX#)
  {$EXTERNALSYM IPPROTO_DCCP}  
  IPPROTO_IPV6 = 41;            // IPv6 header.
  {$EXTERNALSYM IPPROTO_IPV6}
  IPPROTO_ROUTING = 43 platform;// IPv6 routing header.
  {$EXTERNALSYM IPPROTO_ROUTING}
  IPPROTO_FRAGMENT = 44 platform;// IPv6 fragmentation header.
  {$EXTERNALSYM IPPROTO_FRAGMENT}
  IPPROTO_RSVP = 46 platform;   // Reservation Protocol.
  {$EXTERNALSYM IPPROTO_RSVP}
  IPPROTO_GRE = 47 platform;    // General Routing Encapsulation.
  {$EXTERNALSYM IPPROTO_GRE}
  IPPROTO_ESP = 50 platform;    // encapsulating security payload.
  {$EXTERNALSYM IPPROTO_ESP}
  IPPROTO_AH = 51 platform;     // authentication header.
  {$EXTERNALSYM IPPROTO_AH}
  IPPROTO_ICMPV6 = 58 platform; // ICMPv6.
  {$EXTERNALSYM IPPROTO_ICMPV6}
  IPPROTO_NONE = 59 platform;   // IPv6 no next header.
  {$EXTERNALSYM IPPROTO_NONE}
  IPPROTO_DSTOPTS = 60 platform;// IPv6 destination options.
  {$EXTERNALSYM IPPROTO_DSTOPTS}
  IPPROTO_MTP = 92 platform;    // Multicast Transport Protocol.
  {$EXTERNALSYM IPPROTO_MTP}
  IPPROTO_ENCAP = 98 platform;  // Encapsulation Header.
  {$EXTERNALSYM IPPROTO_ENCAP}
  IPPROTO_PIM = 103 platform;   // Protocol Independent Multicast.
  {$EXTERNALSYM IPPROTO_PIM}
  IPPROTO_COMP = 108 platform;  // Compression Header Protocol.
  {$EXTERNALSYM IPPROTO_COMP}
  IPPROTO_RAW = 255;            // Raw IP packets.
  {$EXTERNALSYM IPPROTO_RAW}
  IPPROTO_MAX = 256 platform;
  {$EXTERNALSYM IPPROTO_MAX}

{ Standard well-known ports.  }
const
  IPPORT_ECHO    =   7 platform;     { Echo service.  }
  {$EXTERNALSYM IPPORT_ECHO}
  IPPORT_DISCARD =   9 platform;     { Discard transmissions service.  }
  {$EXTERNALSYM IPPORT_DISCARD}
  IPPORT_SYSTAT  =   11 platform;    { System status service.  }
  {$EXTERNALSYM IPPORT_SYSTAT}
  IPPORT_DAYTIME =   13 platform;    { Time of day service.  }
  {$EXTERNALSYM IPPORT_DAYTIME}
  IPPORT_NETSTAT =   15 platform;    { Network status service.  }
  {$EXTERNALSYM IPPORT_NETSTAT}
  IPPORT_FTP     =   21 platform;    { File Transfer Protocol.  }
  {$EXTERNALSYM IPPORT_FTP}
  IPPORT_TELNET  =   23 platform;    { Telnet protocol.  }
  {$EXTERNALSYM IPPORT_TELNET}
  IPPORT_SMTP    =   25 platform;    { Simple Mail Transfer Protocol.  }
  {$EXTERNALSYM IPPORT_SMTP}
  IPPORT_TIMESERVER  =  37 platform; { Timeserver service.  }
  {$EXTERNALSYM IPPORT_TIMESERVER}
  IPPORT_NAMESERVER  =  42 platform; { Domain Name Service.  }
  {$EXTERNALSYM IPPORT_NAMESERVER}
  IPPORT_WHOIS       =  43 platform; { Internet Whois service.  }
  {$EXTERNALSYM IPPORT_WHOIS}
  IPPORT_MTP         =  57 platform;
  {$EXTERNALSYM IPPORT_MTP}

  IPPORT_TFTP        =  69 platform; { Trivial File Transfer Protocol.  }
  {$EXTERNALSYM IPPORT_TFTP}
  IPPORT_RJE         =  77 platform;
  {$EXTERNALSYM IPPORT_RJE}
  IPPORT_FINGER      =  79 platform; { Finger service.  }
  {$EXTERNALSYM IPPORT_FINGER}
  IPPORT_TTYLINK     =  87 platform;
  {$EXTERNALSYM IPPORT_TTYLINK}
  IPPORT_SUPDUP      =  95 platform; { SUPDUP protocol.  }
  {$EXTERNALSYM IPPORT_SUPDUP}

  IPPORT_EXECSERVER  =  512 platform;{ execd service.  }
  {$EXTERNALSYM IPPORT_EXECSERVER}
  IPPORT_LOGINSERVER =  513 platform;{ rlogind service.  }
  {$EXTERNALSYM IPPORT_LOGINSERVER}
  IPPORT_CMDSERVER   =  514 platform;
  {$EXTERNALSYM IPPORT_CMDSERVER}
  IPPORT_EFSSERVER   =  520 platform;
  {$EXTERNALSYM IPPORT_EFSSERVER}
  { UDP ports.  }
  IPPORT_BIFFUDP     =  512 platform;
  {$EXTERNALSYM IPPORT_BIFFUDP}
  IPPORT_WHOSERVER   =  513 platform;
  {$EXTERNALSYM IPPORT_WHOSERVER}
  IPPORT_ROUTESERVER =  520 platform;
  {$EXTERNALSYM IPPORT_ROUTESERVER}
  { Ports less than this value are reserved for privileged processes.  }
  IPPORT_RESERVED    =  1024 platform;
  {$EXTERNALSYM IPPORT_RESERVED}
  { Ports greater this value are reserved for (non-privileged) servers.  }
  IPPORT_USERRESERVED = 5000 platform;
  {$EXTERNALSYM IPPORT_USERRESERVED}

{ Address to accept any incoming messages.  }
  INADDR_ANY        = in_addr_t($00000000);
  {$EXTERNALSYM INADDR_ANY}
{ Address to send to all hosts.  }
  INADDR_BROADCAST  = in_addr_t($ffffffff);
  {$EXTERNALSYM INADDR_BROADCAST}
{ Address indicating an error return.  }
  INADDR_NONE       = in_addr_t($ffffffff) platform;
  {$EXTERNALSYM INADDR_NONE}

{ Network number for local host loopback.  }
  IN_LOOPBACKNET = 127 platform;
  {$EXTERNALSYM IN_LOOPBACKNET}
{ Address to loopback in software to local host.  }
  INADDR_LOOPBACK = in_addr_t($7f000001) platform; { Inet 127.0.0.1.  }
  {$EXTERNALSYM INADDR_LOOPBACK}

{ Defines for Multicast INADDR.  }
  INADDR_UNSPEC_GROUP = in_addr_t($e0000000) platform; { 224.0.0.0 }
  {$EXTERNALSYM INADDR_UNSPEC_GROUP}
  INADDR_ALLHOSTS_GROUP = in_addr_t($e0000001) platform; { 224.0.0.1 }
  {$EXTERNALSYM INADDR_ALLHOSTS_GROUP}
  INADDR_ALLRTRS_GROUP = in_addr_t($0000002) platform; { 224.0.0.2 }
  {$EXTERNALSYM INADDR_ALLRTRS_GROUP}
  INADDR_MAX_LOCAL_GROUP = in_addr_t($e00000ff) platform; { 224.0.0.255 }
  {$EXTERNALSYM INADDR_MAX_LOCAL_GROUP}

  INET_ADDRSTRLEN     = 16;
  {$EXTERNALSYM INET_ADDRSTRLEN}

type
  sockaddr_in = record
    sin_family: sa_family_t;
    sin_port: in_port_t;
    sin_addr: in_addr;
    sin_zero: packed array [0..7] of Byte;
  end;
  {$EXTERNALSYM sockaddr_in}
  Psockaddr_in = ^sockaddr_in;


{ Options for use with `getsockopt' and `setsockopt' at the IP level.
   The first word in the comment at the right is the data type used;
   "bool" means a boolean value stored in an `int'.  }
const
  IP_OPTIONS                = 4 platform; { ip_opts; IP per-packet options.  }
  {$EXTERNALSYM IP_OPTIONS}
  IP_HDRINCL                = 3 platform; { int; Header is included with data.  }
  {$EXTERNALSYM IP_HDRINCL}
  IP_TOS                    = 1 platform; { int; IP type of service and precedence.  }
  {$EXTERNALSYM IP_TOS}
  IP_TTL                    = 2 platform; { int; IP time to live.  }
  {$EXTERNALSYM IP_TTL}
  IP_RECVOPTS               = 6 platform; { bool; Receive all IP options w/datagram.  }
  {$EXTERNALSYM IP_RECVOPTS}
  IP_RETOPTS                = 7 platform; { ip_opts; Set/get IP per-packet options.  }
  {$EXTERNALSYM IP_RETOPTS}
{ For BSD compatibility. }
  IP_RECVRETOPTS            = IP_RETOPTS platform; { bool; Receive IP options for response.  }
  {$EXTERNALSYM IP_RECVRETOPTS}
  IP_MULTICAST_IF           = 32 platform; { in_addr; set/get IP multicast i/f }
  {$EXTERNALSYM IP_MULTICAST_IF}
  IP_MULTICAST_TTL          = 33 platform; { u_char; set/get IP multicast ttl }
  {$EXTERNALSYM IP_MULTICAST_TTL}
  IP_MULTICAST_LOOP         = 34 platform; { i_char; set/get IP multicast loopback }
  {$EXTERNALSYM IP_MULTICAST_LOOP}
  IP_ADD_MEMBERSHIP         = 35 platform; { ip_mreq; add an IP group membership }
  {$EXTERNALSYM IP_ADD_MEMBERSHIP}
  IP_DROP_MEMBERSHIP        = 36 platform; { ip_mreq; drop an IP group membership }
  {$EXTERNALSYM IP_DROP_MEMBERSHIP}
  IP_UNBLOCK_SOURCE         = 37 platform; { ip_mreq_source: unblock data from source }
  {$EXTERNALSYM IP_UNBLOCK_SOURCE}
  IP_BLOCK_SOURCE           = 38 platform; { ip_mreq_source: block data from source }
  {$EXTERNALSYM IP_BLOCK_SOURCE}
  IP_ADD_SOURCE_MEMBERSHIP  = 39 platform; { ip_mreq_source: join source group }
  {$EXTERNALSYM IP_ADD_SOURCE_MEMBERSHIP}
  IP_DROP_SOURCE_MEMBERSHIP = 40 platform; { ip_mreq_source: leave source group }
  {$EXTERNALSYM IP_DROP_SOURCE_MEMBERSHIP}
  IP_MSFILTER               = 41 platform;
  {$EXTERNALSYM IP_MSFILTER}

  MCAST_JOIN_GROUP          = 42  platform; { group_req: join any-source group }
  {$EXTERNALSYM MCAST_JOIN_GROUP}
  MCAST_BLOCK_SOURCE        = 43  platform; { group_source_req: block from given group }
  {$EXTERNALSYM MCAST_BLOCK_SOURCE}
  MCAST_UNBLOCK_SOURCE      = 44 platform; { group_source_req: unblock from given group}
  {$EXTERNALSYM MCAST_UNBLOCK_SOURCE}
  MCAST_LEAVE_GROUP         = 45  platform; { group_req: leave any-source group }
  {$EXTERNALSYM MCAST_LEAVE_GROUP}
  MCAST_JOIN_SOURCE_GROUP   = 46 platform; { group_source_req: join source-spec gr }
  {$EXTERNALSYM MCAST_JOIN_SOURCE_GROUP}
  MCAST_LEAVE_SOURCE_GROUP  = 47 platform; { group_source_req: leave source-spec gr}
  {$EXTERNALSYM MCAST_LEAVE_SOURCE_GROUP}
  MCAST_MSFILTER            = 48 platform;
  {$EXTERNALSYM MCAST_MSFILTER}

  MCAST_EXCLUDE   = 0 platform;
  {$EXTERNALSYM MCAST_EXCLUDE  }
  MCAST_INCLUDE   = 1 platform;
  {$EXTERNALSYM MCAST_INCLUDE  }

  IP_ROUTER_ALERT           = 5  platform; { bool }
  {$EXTERNALSYM IP_ROUTER_ALERT}
  IP_PKTINFO                = 8  platform; { bool }
  {$EXTERNALSYM IP_PKTINFO}
  IP_PKTOPTIONS             = 9 platform;
  {$EXTERNALSYM IP_PKTOPTIONS}
  IP_PMTUDISC               = 10  platform; { obsolete name? }
  {$EXTERNALSYM IP_PMTUDISC}
  IP_MTU_DISCOVER           = 10  platform; { int; see below }
  {$EXTERNALSYM IP_MTU_DISCOVER}
  IP_RECVERR                = 11  platform; { bool }
  {$EXTERNALSYM IP_RECVERR}
  IP_RECVTTL                = 12  platform; { bool }
  {$EXTERNALSYM IP_RECVTTL}
  IP_RECVTOS                = 13  platform; { bool }
  {$EXTERNALSYM IP_RECVTOS}


{ IP_MTU_DISCOVER arguments. }
  IP_PMTUDISC_DONT          = 0  platform; { Never send DF frames.  }
  {$EXTERNALSYM IP_PMTUDISC_DONT}
  IP_PMTUDISC_WANT          = 1  platform; { Use per route hints.  }
  {$EXTERNALSYM IP_PMTUDISC_WANT}
  IP_PMTUDISC_DO            = 2  platform; { Always DF.  }
  {$EXTERNALSYM IP_PMTUDISC_DO}
  IP_PMTUDISC_PROBE         = 3  platform; { Ignore dst pmtu.  }
  {$EXTERNALSYM IP_PMTUDISC_PROBE}
{ To select the IP level.  }
  SOL_IP = 0 platform;
  {$EXTERNALSYM SOL_IP}

  IP_DEFAULT_MULTICAST_TTL        = 1 platform;
  {$EXTERNALSYM IP_DEFAULT_MULTICAST_TTL}
  IP_DEFAULT_MULTICAST_LOOP       = 1 platform;
  {$EXTERNALSYM IP_DEFAULT_MULTICAST_LOOP}
  IP_MAX_MEMBERSHIPS              = 20 platform;
  {$EXTERNALSYM IP_MAX_MEMBERSHIPS}

type
{ Structure used to describe IP options for IP_OPTIONS. The `ip_dst'
   field is used for the first-hop gateway when using a source route
   (this gets put into the header proper).  }
  ip_opts = record
    ip_dst: in_addr;                         { First hop; zero without source route.  }
    ip_opts: packed array [0..40-1] of Byte;   { Actually variable in size.  }
  end platform;
  {$EXTERNALSYM ip_opts}
  Pip_opts = ^ip_opts;
  {$EXTERNALSYM Pip_opts}

{ Structure used for IP_ADD_MEMBERSHIP and IP_DROP_MEMBERSHIP. }
  ip_mreq = record
    imr_multiaddr: in_addr;     { IP multicast address of group }
    imr_interface: in_addr;     { local IP address of interface }
  end platform;
  {$EXTERNALSYM ip_mreq}
  Pip_mreq = ^ip_mreq;

{ As above but including interface specification by index.  }
  ip_mreqn = record
    imr_multiaddr: in_addr;         { IP multicast address of group }
    imr_address: in_addr;           { local IP address of interface }
    imr_ifindex: Integer;       { Interface index }
  end platform;
  {$EXTERNALSYM ip_mreqn}
  Pip_mreqn = ^ip_mreqn;

{ Structure used for IP_PKTINFO.  }
  in_pktinfo = record
    ipi_ifindex: Integer;               { Interface index  }
    ipi_spec_dst: in_addr;              { Routing destination address  }
    ipi_addr: in_addr;                  { Header destination address  }
  end platform;
  {$EXTERNALSYM in_pktinfo}
  Pin_pktinfo = ^in_pktinfo;


{ IPV6 }
type
  in6_addr = record
    case Integer of
      0: (s6_addr: packed array [0..16-1] of UInt8);
      1: (s6_addr16: packed array [0..8-1] of UInt16);
      2: (s6_addr32: packed array [0..4-1] of UInt32);
  end;
  {$EXTERNALSYM in6_addr}
  Pin6_addr = ^in6_addr;

  sockaddr_in6 = record
    sin6_family: sa_family_t;
    sin6_port: in_port_t;
    sin6_flowinfo: UInt32;
    sin6_addr: in6_addr;
    sin6_scope_id: UInt32;
  end;
  {$EXTERNALSYM sockaddr_in6}
  Psockaddr_in6 = ^sockaddr_in6;

{ IPv6 packet information.  }
  in6_pktinfo = record
    ipi6_addr: in6_addr;         { src/dst IPv6 address }
    ipi6_ifindex: Cardinal;      { send/recv interface index }
  end;
  {$EXTERNALSYM in6_pktinfo}
  Pin6_pktinfo = ^in6_pktinfo;

  ip6_mtuinfo = record
    ip6m_addr: sockaddr_in6;
    ip6m_mtu: UInt32;
  end;
  {$EXTERNALSYM ip6_mtuinfo}
  Pip6_mtuinfo = ^ip6_mtuinfo;

const
  IN6ADDR_ANY_INIT: in6_addr      = (s6_addr: ( 0, 0, 0, 0, 0, 0, 0, 0,
                                                0, 0, 0, 0, 0, 0, 0, 0 ));
  {$EXTERNALSYM IN6ADDR_ANY_INIT}
  IN6ADDR_LOOPBACK_INIT: in6_addr = (s6_addr: ( 0, 0, 0, 0, 0, 0, 0, 0,
                                                0, 0, 0, 0, 0, 0, 0, 1 ));
  {$EXTERNALSYM IN6ADDR_LOOPBACK_INIT}
  in6addr_any:      in6_addr      = (s6_addr: ( 0, 0, 0, 0, 0, 0, 0, 0,
                                                0, 0, 0, 0, 0, 0, 0, 0 ));
  {$EXTERNALSYM in6addr_any}
  in6addr_loopback: in6_addr      = (s6_addr: ( 0, 0, 0, 0, 0, 0, 0, 0,
                                                0, 0, 0, 0, 0, 0, 0, 1 ));
  {$EXTERNALSYM in6addr_loopback}

type
  ipv6_mreq = record
    ipv6mr_multiaddr: in6_addr;
    ipv6mr_interface: Cardinal;
  end;
  {$EXTERNALSYM ipv6_mreq}
  pipv6_mreq = ^ipv6_mreq;

const 
  INET6_ADDRSTRLEN    = 46;
  {$EXTERNALSYM INET6_ADDRSTRLEN}
{ Options for use with `getsockopt' and `setsockopt' at the IPv6 level.
   The first word in the comment at the right is the data type used;
   "bool" means a boolean value stored in an `int'. }

  IPV6_ADDRFORM      = 1 platform;
  {$EXTERNALSYM IPV6_ADDRFORM}
  IPV6_2292PKTINFO    = 2 platform;
  {$EXTERNALSYM IPV6_2292PKTINFO}
  IPV6_2292HOPOPTS    = 3 platform;
  {$EXTERNALSYM IPV6_2292HOPOPTS}
  IPV6_2292DSTOPTS    = 4 platform;
  {$EXTERNALSYM IPV6_2292DSTOPTS}
  IPV6_2292RTHDR    = 5 platform;
  {$EXTERNALSYM IPV6_2292RTHDR}
  IPV6_2292PKTOPTIONS = 6 platform;
  {$EXTERNALSYM IPV6_2292PKTOPTIONS}
  IPV6_CHECKSUM      = 7 platform;
  {$EXTERNALSYM IPV6_CHECKSUM}
  IPV6_2292HOPLIMIT   = 8 platform;
  {$EXTERNALSYM IPV6_2292HOPLIMIT}
(* IPV6_RXSRCRT completely undefined.  Bug in glibc?
  SCM_SRCRT          = IPV6_RXSRCRT platform;
  {$EXTERNALSYM SCM_SRCRT}
*)
  IPV6_NEXTHOP      = 9 platform;
  {$EXTERNALSYM IPV6_NEXTHOP}
  IPV6_AUTHHDR      = 10 platform;
  {$EXTERNALSYM IPV6_AUTHHDR}
  IPV6_UNICAST_HOPS   = 16;
  {$EXTERNALSYM IPV6_UNICAST_HOPS}
  IPV6_MULTICAST_IF   = 17;
  {$EXTERNALSYM IPV6_MULTICAST_IF}
  IPV6_MULTICAST_HOPS = 18;
  {$EXTERNALSYM IPV6_MULTICAST_HOPS}
  IPV6_MULTICAST_LOOP = 19;
  {$EXTERNALSYM IPV6_MULTICAST_LOOP}
  IPV6_JOIN_GROUP    = 20;
  {$EXTERNALSYM IPV6_JOIN_GROUP}
  IPV6_LEAVE_GROUP    = 21;
  {$EXTERNALSYM IPV6_LEAVE_GROUP}
  IPV6_ROUTER_ALERT   = 22 platform;
  {$EXTERNALSYM IPV6_ROUTER_ALERT}
  IPV6_MTU_DISCOVER   = 23 platform;
  {$EXTERNALSYM IPV6_MTU_DISCOVER}
  IPV6_MTU          = 24 platform;
  {$EXTERNALSYM IPV6_MTU}
  IPV6_RECVERR      = 25 platform;
  {$EXTERNALSYM IPV6_RECVERR}
  IPV6_V6ONLY        = 26;
  {$EXTERNALSYM IPV6_V6ONLY}
  IPV6_JOIN_ANYCAST   = 27 platform;
  {$EXTERNALSYM IPV6_JOIN_ANYCAST}
  IPV6_LEAVE_ANYCAST  = 28 platform;
  {$EXTERNALSYM IPV6_LEAVE_ANYCAST}
  IPV6_IPSEC_POLICY   = 34 platform;
  {$EXTERNALSYM IPV6_IPSEC_POLICY}
  IPV6_XFRM_POLICY    = 35 platform;
  {$EXTERNALSYM IPV6_XFRM_POLICY}

  IPV6_RECVPKTINFO    = 49 platform;
  {$EXTERNALSYM IPV6_RECVPKTINFO}
  IPV6_PKTINFO      = 50 platform;
  {$EXTERNALSYM IPV6_PKTINFO}
  IPV6_RECVHOPLIMIT   = 51 platform;
  {$EXTERNALSYM IPV6_RECVHOPLIMIT}
  IPV6_HOPLIMIT      = 52 platform;
  {$EXTERNALSYM IPV6_HOPLIMIT}
  IPV6_RECVHOPOPTS    = 53 platform;
  {$EXTERNALSYM IPV6_RECVHOPOPTS}
  IPV6_HOPOPTS      = 54 platform;
  {$EXTERNALSYM IPV6_HOPOPTS}
  IPV6_RTHDRDSTOPTS   = 55 platform;
  {$EXTERNALSYM IPV6_RTHDRDSTOPTS}
  IPV6_RECVRTHDR    = 56 platform;
  {$EXTERNALSYM IPV6_RECVRTHDR}
  IPV6_RTHDR        = 57 platform;
  {$EXTERNALSYM IPV6_RTHDR}
  IPV6_RECVDSTOPTS    = 58 platform;
  {$EXTERNALSYM IPV6_RECVDSTOPTS}
  IPV6_DSTOPTS    = 59 platform;
  {$EXTERNALSYM IPV6_DSTOPTS}

  IPV6_RECVTCLASS  = 66 platform;
  {$EXTERNALSYM IPV6_RECVTCLASS}
  IPV6_TCLASS      = 67 platform;
  {$EXTERNALSYM IPV6_TCLASS}

{ Obsolete synonyms for the above.  }
  IPV6_ADD_MEMBERSHIP = IPV6_JOIN_GROUP platform;
  {$EXTERNALSYM IPV6_ADD_MEMBERSHIP}
  IPV6_DROP_MEMBERSHIP = IPV6_LEAVE_GROUP platform;
  {$EXTERNALSYM IPV6_DROP_MEMBERSHIP}
  IPV6_RXHOPOPTS = IPV6_HOPOPTS platform;
  {$EXTERNALSYM IPV6_RXHOPOPTS}
  IPV6_RXDSTOPTS = IPV6_DSTOPTS platform;
  {$EXTERNALSYM IPV6_RXDSTOPTS}

{ IPV6_MTU_DISCOVER values. }
  IPV6_PMTUDISC_DONT  = 0 platform; { Never send DF frames.  }
  {$EXTERNALSYM IPV6_PMTUDISC_DONT}
  IPV6_PMTUDISC_WANT  = 1 platform; { Use per route hints.  }
  {$EXTERNALSYM IPV6_PMTUDISC_WANT}
  IPV6_PMTUDISC_DO    = 2 platform; { Always DF.  }
  {$EXTERNALSYM IPV6_PMTUDISC_DO}
  IPV6_PMTUDISC_PROBE = 3 platform; { Ignore dst pmtu.  }
  {$EXTERNALSYM IPV6_PMTUDISC_PROBE}

{ Socket level values for IPv6. }
  SOL_IPV6        = 41 platform;
  {$EXTERNALSYM SOL_IPV6       }
  SOL_ICMPV6      = 58 platform;
  {$EXTERNALSYM SOL_ICMPV6     }

{ Routing header options for IPv6. }
  IPV6_RTHDR_LOOSE  = 0 platform; { Hop doesn't need to be neighbour. }
  {$EXTERNALSYM IPV6_RTHDR_LOOSE}
  IPV6_RTHDR_STRICT = 1 platform; { Hop must be a neighbour.  }
  {$EXTERNALSYM IPV6_RTHDR_STRICT}

  IPV6_RTHDR_TYPE_0 = 0 platform; { IPv6 Routing header type 0.  }
  {$EXTERNALSYM IPV6_RTHDR_TYPE_0}
