{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
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

const
  IPPROTO_IP = 0; { dummy for IP }
  {$EXTERNALSYM IPPROTO_IP}
  IPPROTO_HOPOPTS = 0 platform; { IP6 hop-by-hop options }
  {$EXTERNALSYM IPPROTO_HOPOPTS}
  IPPROTO_ICMP = 1; { control message protocol }
  {$EXTERNALSYM IPPROTO_ICMP}
  IPPROTO_IGMP = 2 platform; { group mgmt protocol }
  {$EXTERNALSYM IPPROTO_IGMP}
  IPPROTO_GGP = 3 platform; { gateway^2 (deprecated) }
  {$EXTERNALSYM IPPROTO_GGP}
  IPPROTO_IPV4 = 4 platform; { IPv4 encapsulation }
  {$EXTERNALSYM IPPROTO_IPV4}
  IPPROTO_IPIP = IPPROTO_IPV4 platform; { for compatibility }
  {$EXTERNALSYM IPPROTO_IPIP}
  IPPROTO_TCP = 6; { tcp }
  {$EXTERNALSYM IPPROTO_TCP}
  IPPROTO_ST = 7 platform; { Stream protocol II }
  {$EXTERNALSYM IPPROTO_ST}
  IPPROTO_EGP = 8 platform; { exterior gateway protocol }
  {$EXTERNALSYM IPPROTO_EGP}
  IPPROTO_PIGP = 9 platform; { private interior gateway }
  {$EXTERNALSYM IPPROTO_PIGP}
  IPPROTO_RCCMON = 10 platform; { BBN RCC Monitoring }
  {$EXTERNALSYM IPPROTO_RCCMON}
  IPPROTO_NVPII = 11 platform; { network voice protocol}
  {$EXTERNALSYM IPPROTO_NVPII}
  IPPROTO_PUP = 12 platform; { pup }
  {$EXTERNALSYM IPPROTO_PUP}
  IPPROTO_ARGUS = 13 platform; { Argus }
  {$EXTERNALSYM IPPROTO_ARGUS}
  IPPROTO_EMCON = 14 platform; { EMCON }
  {$EXTERNALSYM IPPROTO_EMCON}
  IPPROTO_XNET = 15 platform; { Cross Net Debugger }
  {$EXTERNALSYM IPPROTO_XNET}
  IPPROTO_CHAOS = 16 platform; { Chaos}
  {$EXTERNALSYM IPPROTO_CHAOS}
  IPPROTO_UDP = 17; { user datagram protocol }
  {$EXTERNALSYM IPPROTO_UDP}
  IPPROTO_MUX = 18 platform; { Multiplexing }
  {$EXTERNALSYM IPPROTO_MUX}
  IPPROTO_MEAS = 19 platform; { DCN Measurement Subsystems }
  {$EXTERNALSYM IPPROTO_MEAS}
  IPPROTO_HMP = 20 platform; { Host Monitoring }
  {$EXTERNALSYM IPPROTO_HMP}
  IPPROTO_PRM = 21 platform; { Packet Radio Measurement }
  {$EXTERNALSYM IPPROTO_PRM}
  IPPROTO_IDP = 22 platform; { xns idp }
  {$EXTERNALSYM IPPROTO_IDP}
  IPPROTO_TRUNK1 = 23 platform; { Trunk-1 }
  {$EXTERNALSYM IPPROTO_TRUNK1}
  IPPROTO_TRUNK2 = 24 platform; { Trunk-2 }
  {$EXTERNALSYM IPPROTO_TRUNK2}
  IPPROTO_LEAF1 = 25 platform; { Leaf-1 }
  {$EXTERNALSYM IPPROTO_LEAF1}
  IPPROTO_LEAF2 = 26 platform; { Leaf-2 }
  {$EXTERNALSYM IPPROTO_LEAF2}
  IPPROTO_RDP = 27 platform; { Reliable Data }
  {$EXTERNALSYM IPPROTO_RDP}
  IPPROTO_IRTP = 28 platform; { Reliable Transaction }
  {$EXTERNALSYM IPPROTO_IRTP}
  IPPROTO_TP = 29 platform; { tp-4 w/ class negotiation }
  {$EXTERNALSYM IPPROTO_TP}
  IPPROTO_BLT = 30 platform; { Bulk Data Transfer }
  {$EXTERNALSYM IPPROTO_BLT}
  IPPROTO_NSP = 31 platform; { Network Services }
  {$EXTERNALSYM IPPROTO_NSP}
  IPPROTO_INP = 32 platform; { Merit Internodal }
  {$EXTERNALSYM IPPROTO_INP}
  IPPROTO_SEP = 33 platform; { Sequential Exchange }
  {$EXTERNALSYM IPPROTO_SEP}
  IPPROTO_3PC = 34 platform; { Third Party Connect }
  {$EXTERNALSYM IPPROTO_3PC}
  IPPROTO_IDPR = 35 platform; { InterDomain Policy Routing }
  {$EXTERNALSYM IPPROTO_IDPR}
  IPPROTO_XTP = 36 platform; { XTP }
  {$EXTERNALSYM IPPROTO_XTP}
  IPPROTO_DDP = 37 platform; { Datagram Delivery }
  {$EXTERNALSYM IPPROTO_DDP}
  IPPROTO_CMTP = 38 platform; { Control Message Transport }
  {$EXTERNALSYM IPPROTO_CMTP}
  IPPROTO_TPXX = 39 platform; { TP++ Transport }
  {$EXTERNALSYM IPPROTO_TPXX}
  IPPROTO_IL = 40 platform; { IL transport protocol }
  {$EXTERNALSYM IPPROTO_IL}
  IPPROTO_IPV6 = 41; { IP6 header }
  {$EXTERNALSYM IPPROTO_IPV6}
  IPPROTO_SDRP = 42 platform; { Source Demand Routing }
  {$EXTERNALSYM IPPROTO_SDRP}
  IPPROTO_ROUTING = 43 platform; { IP6 routing header }
  {$EXTERNALSYM IPPROTO_ROUTING}
  IPPROTO_FRAGMENT = 44 platform; { IP6 fragmentation header }
  {$EXTERNALSYM IPPROTO_FRAGMENT}
  IPPROTO_IDRP = 45 platform; { InterDomain Routing}
  {$EXTERNALSYM IPPROTO_IDRP}
  IPPROTO_RSVP = 46 platform; { resource reservation }
  {$EXTERNALSYM IPPROTO_RSVP}
  IPPROTO_GRE = 47 platform; { General Routing Encap. }
  {$EXTERNALSYM IPPROTO_GRE}
  IPPROTO_MHRP = 48 platform; { Mobile Host Routing }
  {$EXTERNALSYM IPPROTO_MHRP}
  IPPROTO_BHA = 49 platform; { BHA }
  {$EXTERNALSYM IPPROTO_BHA}
  IPPROTO_ESP = 50 platform; { IP6 Encap Sec. Payload }
  {$EXTERNALSYM IPPROTO_ESP}
  IPPROTO_AH = 51 platform; { IP6 Auth Header }
  {$EXTERNALSYM IPPROTO_AH}
  IPPROTO_INLSP = 52 platform; { Integ. Net Layer Security }
  {$EXTERNALSYM IPPROTO_INLSP}
  IPPROTO_SWIPE = 53 platform; { IP with encryption }
  {$EXTERNALSYM IPPROTO_SWIPE}
  IPPROTO_NHRP = 54 platform; { Next Hop Resolution }
  {$EXTERNALSYM IPPROTO_NHRP}
  { 55-57: Unassigned }
  IPPROTO_ICMPV6 = 58 platform; { ICMP6 }
  {$EXTERNALSYM IPPROTO_ICMPV6}
  IPPROTO_NONE = 59 platform; { IP6 no next header }
  {$EXTERNALSYM IPPROTO_NONE}
  IPPROTO_DSTOPTS = 60 platform; { IP6 destination option }
  {$EXTERNALSYM IPPROTO_DSTOPTS}
  IPPROTO_AHIP = 61 platform; { any host internal protocol }
  {$EXTERNALSYM IPPROTO_AHIP}
  IPPROTO_CFTP = 62 platform; { CFTP }
  {$EXTERNALSYM IPPROTO_CFTP}
  IPPROTO_HELLO = 63 platform; { "hello" routing protocol }
  {$EXTERNALSYM IPPROTO_HELLO}
  IPPROTO_SATEXPAK = 64 platform; { SATNET/Backroom EXPAK }
  {$EXTERNALSYM IPPROTO_SATEXPAK}
  IPPROTO_KRYPTOLAN = 65 platform; { Kryptolan }
  {$EXTERNALSYM IPPROTO_KRYPTOLAN}
  IPPROTO_RVD = 66 platform; { Remote Virtual Disk }
  {$EXTERNALSYM IPPROTO_RVD}
  IPPROTO_IPPC = 67 platform; { Pluribus Packet Core }
  {$EXTERNALSYM IPPROTO_IPPC}
  IPPROTO_ADFS = 68 platform; { Any distributed FS }
  {$EXTERNALSYM IPPROTO_ADFS}
  IPPROTO_SATMON = 69 platform; { Satnet Monitoring }
  {$EXTERNALSYM IPPROTO_SATMON}
  IPPROTO_VISA = 70 platform; { VISA Protocol }
  {$EXTERNALSYM IPPROTO_VISA}
  IPPROTO_IPCV = 71 platform; { Packet Core Utility }
  {$EXTERNALSYM IPPROTO_IPCV}
  IPPROTO_CPNX = 72 platform; { Comp. Prot. Net. Executive }
  {$EXTERNALSYM IPPROTO_CPNX}
  IPPROTO_CPHB = 73 platform; { Comp. Prot. HeartBeat }
  {$EXTERNALSYM IPPROTO_CPHB}
  IPPROTO_WSN = 74 platform; { Wang Span Network }
  {$EXTERNALSYM IPPROTO_WSN}
  IPPROTO_PVP = 75 platform; { Packet Video Protocol }
  {$EXTERNALSYM IPPROTO_PVP}
  IPPROTO_BRSATMON = 76 platform; { BackRoom SATNET Monitoring }
  {$EXTERNALSYM IPPROTO_BRSATMON}
  IPPROTO_ND = 77 platform; { Sun net disk proto (temp.) }
  {$EXTERNALSYM IPPROTO_ND}
  IPPROTO_WBMON = 78 platform; { WIDEBAND Monitoring }
  {$EXTERNALSYM IPPROTO_WBMON}
  IPPROTO_WBEXPAK = 79 platform; { WIDEBAND EXPAK }
  {$EXTERNALSYM IPPROTO_WBEXPAK}
  IPPROTO_EON = 80 platform; { ISO cnlp }
  {$EXTERNALSYM IPPROTO_EON}
  IPPROTO_VMTP = 81 platform; { VMTP }
  {$EXTERNALSYM IPPROTO_VMTP}
  IPPROTO_SVMTP = 82 platform; { Secure VMTP }
  {$EXTERNALSYM IPPROTO_SVMTP}
  IPPROTO_VINES = 83 platform; { Banyon VINES }
  {$EXTERNALSYM IPPROTO_VINES}
  IPPROTO_TTP = 84 platform; { TTP }
  {$EXTERNALSYM IPPROTO_TTP}
  IPPROTO_IGP = 85 platform; { NSFNET-IGP }
  {$EXTERNALSYM IPPROTO_IGP}
  IPPROTO_DGP = 86 platform; { dissimilar gateway prot. }
  {$EXTERNALSYM IPPROTO_DGP}
  IPPROTO_TCF = 87 platform; { TCF }
  {$EXTERNALSYM IPPROTO_TCF}
  IPPROTO_IGRP = 88 platform; { Cisco/GXS IGRP }
  {$EXTERNALSYM IPPROTO_IGRP}
  IPPROTO_OSPFIGP = 89 platform; { OSPFIGP }
  {$EXTERNALSYM IPPROTO_OSPFIGP}
  IPPROTO_SRPC = 90 platform; { Strite RPC protocol }
  {$EXTERNALSYM IPPROTO_SRPC}
  IPPROTO_LARP = 91 platform; { Locus Address Resoloution }
  {$EXTERNALSYM IPPROTO_LARP}
  IPPROTO_MTP = 92 platform; { Multicast Transport }
  {$EXTERNALSYM IPPROTO_MTP}
  IPPROTO_AX25 = 93 platform; { AX.25 Frames }
  {$EXTERNALSYM IPPROTO_AX25}
  IPPROTO_IPEIP = 94 platform; { IP encapsulated in IP }
  {$EXTERNALSYM IPPROTO_IPEIP}
  IPPROTO_MICP = 95 platform; { Mobile Int.ing control }
  {$EXTERNALSYM IPPROTO_MICP}
  IPPROTO_SCCSP = 96 platform; { Semaphore Comm. security }
  {$EXTERNALSYM IPPROTO_SCCSP}
  IPPROTO_ETHERIP = 97 platform; { Ethernet IP encapsulation }
  {$EXTERNALSYM IPPROTO_ETHERIP}
  IPPROTO_ENCAP = 98 platform; { encapsulation header }
  {$EXTERNALSYM IPPROTO_ENCAP}
  IPPROTO_APES = 99 platform; { any private encr. scheme }
  {$EXTERNALSYM IPPROTO_APES}
  IPPROTO_GMTP = 100 platform; { GMTP}
  {$EXTERNALSYM IPPROTO_GMTP}
  IPPROTO_IPCOMP = 108 platform; { payload compression (IPComp) }
  {$EXTERNALSYM IPPROTO_IPCOMP}
  { 101-254: Partly Unassigned }
  IPPROTO_PIM = 103 platform; { Protocol Independent Mcast }
  {$EXTERNALSYM IPPROTO_PIM}
  IPPROTO_PGM = 113 platform; { PGM }
  {$EXTERNALSYM IPPROTO_PGM}
  { 255: Reserved }
  { BSD Private, local use, namespace incursion }
  IPPROTO_DIVERT = 254 platform; { divert pseudo-protocol }
  {$EXTERNALSYM IPPROTO_DIVERT}
  IPPROTO_RAW = 255;  { raw IP packet }
  {$EXTERNALSYM IPPROTO_RAW}
  IPPROTO_MAX = 256 platform;
  {$EXTERNALSYM IPPROTO_MAX}
  { last return value of *_input(), meaning "all job for this pkt is done".  }
  IPPROTO_DONE = 257 platform;
  {$EXTERNALSYM IPPROTO_DONE}

  IPPORT_RESERVED      = 1024 platform;
  {$EXTERNALSYM IPPORT_RESERVED}
  IPPORT_USERRESERVED  = 5000 platform;
  {$EXTERNALSYM IPPORT_USERRESERVED}
  IPPORT_HIFIRSTAUTO   = 49152 platform;
  {$EXTERNALSYM IPPORT_HIFIRSTAUTO}
  IPPORT_HILASTAUTO    = 65535 platform;
  {$EXTERNALSYM IPPORT_HILASTAUTO}
  IPPORT_RESERVEDSTART = 600 platform;
  {$EXTERNALSYM IPPORT_RESERVEDSTART}

  INADDR_ANY : in_addr_t      = $00000000;
  {$EXTERNALSYM INADDR_ANY}
  INADDR_BROADCAST: in_addr_t = $FFFFFFFF;
  {$EXTERNALSYM INADDR_BROADCAST}

{ Network number for local host loopback.  }
  IN_LOOPBACKNET = 127 platform;
  {$EXTERNALSYM IN_LOOPBACKNET}
{ Address to loopback in software to local host.  }
  INADDR_LOOPBACK = in_addr_t($7f000001) platform; { Inet 127.0.0.1.  }
  {$EXTERNALSYM INADDR_LOOPBACK}
{ Address indicating an error return.  }
  INADDR_NONE = in_addr_t($ffffffff) platform;
  {$EXTERNALSYM INADDR_NONE}

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
  
  IN_LINKLOCALNETNUM = UInt32($A9FE0000) platform;
  {$EXTERNALSYM IN_LINKLOCALNETNUM}

type
  sockaddr_in = record
    sin_len: UInt8;
    sin_family: sa_family_t;
    sin_port: in_port_t;
    sin_addr: in_addr;
    sin_zero: array [0..8-1] of Byte;
  end;
  {$EXTERNALSYM sockaddr_in}
  Psockaddr_in = ^sockaddr_in;

{ Options for use with [gs]etsockopt at the IP level.
  First word of comment is data type; bool is stored in int.}
const
  IP_OPTIONS                = 1 platform; { buf/ip_opts; set/get IP options }
  {$EXTERNALSYM IP_OPTIONS}
  IP_HDRINCL                = 2 platform; { int; header is included with data }
  {$EXTERNALSYM IP_HDRINCL}
  IP_TOS                    = 3 platform; { int; IP type of service and preced. }
  {$EXTERNALSYM IP_TOS}
  IP_TTL                    = 4 platform; { int; IP time to live }
  {$EXTERNALSYM IP_TTL}
  IP_RECVOPTS               = 5 platform; { bool; receive all IP opts w/dgram }
  {$EXTERNALSYM IP_RECVOPTS}
  IP_RECVRETOPTS            = 6 platform; { bool; receive IP opts for response }
  {$EXTERNALSYM IP_RECVRETOPTS}
  IP_RECVDSTADDR            = 7 platform; { bool; receive IP dst addr w/dgram }
  {$EXTERNALSYM IP_RECVDSTADDR}
  IP_RETOPTS                = 8 platform; { ip_opts; set/get IP options }
  {$EXTERNALSYM IP_RETOPTS}
  IP_MULTICAST_IF           = 9 platform; { u_char; set/get IP multicast i/f  }
  {$EXTERNALSYM IP_MULTICAST_IF}
  IP_MULTICAST_TTL          = 10 platform; { u_char; set/get IP multicast ttl }
  {$EXTERNALSYM IP_MULTICAST_TTL}
  IP_MULTICAST_LOOP         = 11 platform; { u_char; set/get IP multicast loopback }
  {$EXTERNALSYM IP_MULTICAST_LOOP}
  IP_ADD_MEMBERSHIP         = 12 platform; { ip_mreq; add an IP group membership }
  {$EXTERNALSYM IP_ADD_MEMBERSHIP}
  IP_DROP_MEMBERSHIP        = 13 platform; { ip_mreq; drop an IP group membership }
  {$EXTERNALSYM IP_DROP_MEMBERSHIP}
  IP_MULTICAST_VIF          = 14 platform; { set/get IP mcast virt. iface }
  {$EXTERNALSYM IP_MULTICAST_VIF}
  IP_RSVP_ON                = 15 platform; { enable RSVP in kernel }
  {$EXTERNALSYM IP_RSVP_ON}
  IP_RSVP_OFF               = 16 platform; { disable RSVP in kernel }
  {$EXTERNALSYM IP_RSVP_OFF}
  IP_RSVP_VIF_ON            = 17 platform; { set RSVP per-vif socket }
  {$EXTERNALSYM IP_RSVP_VIF_ON}
  IP_RSVP_VIF_OFF           = 18 platform; { unset RSVP per-vif socket }
  {$EXTERNALSYM IP_RSVP_VIF_OFF}
  IP_PORTRANGE              = 19 platform; { int; range to choose for unspec port }
  {$EXTERNALSYM IP_PORTRANGE}
  IP_RECVIF                 = 20 platform; { bool; receive reception if w/dgram }
  {$EXTERNALSYM IP_RECVIF}
{ for IPSEC }
  IP_IPSEC_POLICY           = 21 platform; { int; set/get security policy }
  {$EXTERNALSYM IP_IPSEC_POLICY}
  IP_FAITH                  = 22 platform; { bool; accept FAITH'ed connections }
  {$EXTERNALSYM IP_FAITH}
  {#ifdef __APPLE__}
  IP_STRIPHDR               = 23 platform; { bool: drop receive of raw IP header }
  {$EXTERNALSYM IP_STRIPHDR}
  {#endif}
  IP_RECVTTL                = 24 platform; { bool; receive reception TTL w/dgram }
  {$EXTERNALSYM IP_RECVTTL}
  IP_BOUND_IF               = 25 platform; { set/get bound interface }
  {$EXTERNALSYM IP_BOUND_IF}

  IP_FW_ADD                 = 40 platform; { add a firewall rule to chain }
  {$EXTERNALSYM IP_FW_ADD}
  IP_FW_DEL                 = 41 platform; { delete a firewall rule from chain }
  {$EXTERNALSYM IP_FW_DEL}
  IP_FW_FLUSH               = 42 platform; { flush firewall rule chain }
  {$EXTERNALSYM IP_FW_FLUSH}
  IP_FW_ZERO                = 43 platform; { clear single/all firewall counter(s) }
  {$EXTERNALSYM IP_FW_ZERO}
  IP_FW_GET                 = 44 platform; { get entire firewall rule chain }
  {$EXTERNALSYM IP_FW_GET}
  IP_FW_RESETLOG            = 45 platform; { reset logging counters }
  {$EXTERNALSYM IP_FW_RESETLOG}

{ These older firewall socket option codes are maintained for backward compatibility. }
  IP_OLD_FW_ADD             = 50 platform; { add a firewall rule to chain }
  {$EXTERNALSYM IP_OLD_FW_ADD}
  IP_OLD_FW_DEL             = 51 platform; { delete a firewall rule from chain }
  {$EXTERNALSYM IP_OLD_FW_DEL}
  IP_OLD_FW_FLUSH           = 52 platform; { flush firewall rule chain }
  {$EXTERNALSYM IP_OLD_FW_FLUSH}
  IP_OLD_FW_ZERO            = 53 platform; { clear single/all firewall counter(s) }
  {$EXTERNALSYM IP_OLD_FW_ZERO}
  IP_OLD_FW_GET             = 54 platform; { get entire firewall rule chain }
  {$EXTERNALSYM IP_OLD_FW_GET}
  IP_NAT__XXX               = 55 platform; { set/get NAT opts XXX Deprecated, do not use }
  {$EXTERNALSYM IP_NAT__XXX}
  IP_OLD_FW_RESETLOG        = 56 platform; { reset logging counters }
  {$EXTERNALSYM IP_OLD_FW_RESETLOG}

  IP_DUMMYNET_CONFIGURE     = 60 platform; { add/configure a dummynet pipe }
  {$EXTERNALSYM IP_DUMMYNET_CONFIGURE}
  IP_DUMMYNET_DEL           = 61 platform; { delete a dummynet pipe from chain }
  {$EXTERNALSYM IP_DUMMYNET_DEL}
  IP_DUMMYNET_FLUSH         = 62 platform; { flush dummynet }
  {$EXTERNALSYM IP_DUMMYNET_FLUSH}
  IP_DUMMYNET_GET           = 64 platform; { get entire dummynet pipes }
  {$EXTERNALSYM IP_DUMMYNET_GET}

  IP_TRAFFIC_MGT_BACKGROUND = 65 platform; { int*; get background IO flags; set background IO }
  {$EXTERNALSYM IP_TRAFFIC_MGT_BACKGROUND}

{ Background socket configuration flags }
  {#ifdef __APPLE_API_UNSTABLE}
  TRAFFIC_MGT_SO_BACKGROUND     = $0001 platform;
  {$EXTERNALSYM TRAFFIC_MGT_SO_BACKGROUND}
  TRAFFIC_MGT_SO_BG_SUPPRESSED  = $0002 platform;
  {$EXTERNALSYM TRAFFIC_MGT_SO_BG_SUPPRESSED}
  {#endif /* __APPLE_API_UNSTABLE */}

{ Defaults and limits for options }
  IP_DEFAULT_MULTICAST_TTL  = 1 platform; { normally limit m'casts to 1 hop  }
  {$EXTERNALSYM IP_DEFAULT_MULTICAST_TTL}
  IP_DEFAULT_MULTICAST_LOOP = 1 platform; { normally hear sends if a member  }
  {$EXTERNALSYM IP_DEFAULT_MULTICAST_LOOP}
  IP_MAX_MEMBERSHIPS        = 20 platform; { per socket }
  {$EXTERNALSYM IP_MAX_MEMBERSHIPS}

{ Argument for IP_PORTRANGE:
 - which range to search when port is unspecified at bind() or connect() }
  IP_PORTRANGE_DEFAULT  = 0 platform; { default range }
  {$EXTERNALSYM IP_PORTRANGE_DEFAULT}
  IP_PORTRANGE_HIGH     = 1 platform; { "high" - request firewall bypass }
  {$EXTERNALSYM IP_PORTRANGE_HIGH}
  IP_PORTRANGE_LOW      = 2 platform; { "low" - vouchsafe security }
  {$EXTERNALSYM IP_PORTRANGE_LOW}

 { Definitions for inet sysctl operations.
 
  Third level is protocol number.
  Fourth level is desired variable within that protocol. }
  IPPROTO_MAXID = (IPPROTO_AH + 1) platform; { don't list to IPPROTO_MAX }
  {$EXTERNALSYM IPPROTO_MAXID}

{ Names for IP sysctl objects }
  IPCTL_FORWARDING        = 1 platform; { act as router }
  {$EXTERNALSYM IPCTL_FORWARDING}
  IPCTL_SENDREDIRECTS     = 2 platform; { may send redirects when forwarding }
  {$EXTERNALSYM IPCTL_SENDREDIRECTS}
  IPCTL_DEFTTL            = 3 platform; { default TTL }
  {$EXTERNALSYM IPCTL_DEFTTL}
  IPCTL_DEFMTU            = 4 platform; { default MTU }
  {$EXTERNALSYM IPCTL_DEFMTU}
  IPCTL_RTEXPIRE          = 5 platform; { cloned route expiration time }
  {$EXTERNALSYM IPCTL_RTEXPIRE}
  IPCTL_RTMINEXPIRE       = 6 platform; { min value for expiration time }
  {$EXTERNALSYM IPCTL_RTMINEXPIRE}
  IPCTL_RTMAXCACHE        = 7 platform; { trigger level for dynamic expire }
  {$EXTERNALSYM IPCTL_RTMAXCACHE}
  IPCTL_SOURCEROUTE       = 8 platform; { may perform source routes }
  {$EXTERNALSYM IPCTL_SOURCEROUTE}
  IPCTL_DIRECTEDBROADCAST = 9 platform; { may re-broadcast received packets }
  {$EXTERNALSYM IPCTL_DIRECTEDBROADCAST}
  IPCTL_INTRQMAXLEN       = 10 platform; { max length of netisr queue }
  {$EXTERNALSYM IPCTL_INTRQMAXLEN}
  IPCTL_INTRQDROPS        = 11 platform; { number of netisr q drops }
  {$EXTERNALSYM IPCTL_INTRQDROPS}
  IPCTL_STATS             = 12 platform; { ipstat structure }
  {$EXTERNALSYM IPCTL_STATS}
  IPCTL_ACCEPTSOURCEROUTE = 13 platform; { may accept source routed packets }
  {$EXTERNALSYM IPCTL_ACCEPTSOURCEROUTE}
  IPCTL_FASTFORWARDING    = 14 platform; { use fast IP forwarding code }
  {$EXTERNALSYM IPCTL_FASTFORWARDING}
  IPCTL_KEEPFAITH         = 15 platform; { FAITH IPv4->IPv6 translater ctl }
  {$EXTERNALSYM IPCTL_KEEPFAITH}
  IPCTL_GIF_TTL           = 16 platform; { default TTL for gif encap packet }
  {$EXTERNALSYM IPCTL_GIF_TTL}
  IPCTL_MAXID             = 17 platform;
  {$EXTERNALSYM IPCTL_MAXID}

{ Structure used to describe IP options for IP_OPTIONS. The `ip_dst'
   field is used for the first-hop gateway when using a source route
   (this gets put into the header proper).  }
type
  ip_opts = record
    ip_dst: in_addr;
    ip_opts: packed array[0..40-1] of Byte;
  end platform;
  {$EXTERNALSYM ip_opts}
  Pip_opts = ^ip_opts;

{ Structure used for IP_ADD_MEMBERSHIP and IP_DROP_MEMBERSHIP. }
  ip_mreq = record
    imr_multiaddr: in_addr;     { IP multicast address of group }
    imr_interface: in_addr;     { local IP address of interface }
  end;
  {$EXTERNALSYM ip_mreq}
  Pip_mreq = ^ip_mreq;

{ IPV6 }
const
  IPV6PORT_RESERVED = 1024 platform;
  {$EXTERNALSYM IPV6PORT_RESERVED}
  IPV6PORT_ANONMIN = 49152 platform;
  {$EXTERNALSYM IPV6PORT_ANONMIN}
  IPV6PORT_ANONMAX = 65535 platform;
  {$EXTERNALSYM IPV6PORT_ANONMAX}
  IPV6PORT_RESERVEDMIN = 600 platform;
  {$EXTERNALSYM IPV6PORT_RESERVEDMIN}
  IPV6PORT_RESERVEDMAX = (IPV6PORT_RESERVED-1) platform;
  {$EXTERNALSYM IPV6PORT_RESERVEDMAX}

type
  in6_addr = record
    case Integer of 
    0: (s6_addr: packed array [0..16-1] of UInt8);
    1: (__s6_addr8: packed array [0..16-1] of UInt8);
    2: (__s6_addr16: packed array [0..8-1] of UInt16);
    3: (__s6_addr32: packed array [0..4-1] of UInt32);
    4: (s6_addr32: packed array [0..4-1] of UInt32); // Included for compatability with Linux macros
  end;
  {$EXTERNALSYM in6_addr}
  Pin6_addr = ^in6_addr;

const 
  INET6_ADDRSTRLEN    = 46;
  {$EXTERNALSYM INET6_ADDRSTRLEN}

type
  sockaddr_in6 = record
    sin6_len: UInt8;
    sin6_family: sa_family_t;
    sin6_port: in_port_t;
    sin6_flowinfo: UInt32;
    sin6_addr: in6_addr;
    sin6_scope_id: UInt32;
  end;
  {$EXTERNALSYM sockaddr_in6}
  Psockaddr_in6 = ^sockaddr_in6;

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

const

(* the followings are relic in IPv4 and hence are disabled 
  IPV6_OPTIONS = 1  platform; { buf/ip6_opts; set/get IP6 options }
  {$EXTERNALSYM IPV6_OPTIONS}
  IPV6_RECVOPTS = 5  platform; { bool; receive all IP6 opts w/dgram }
  {$EXTERNALSYM IPV6_RECVOPTS}
  IPV6_RECVRETOPTS = 6  platform; { bool; receive IP6 opts for response }
  {$EXTERNALSYM IPV6_RECVRETOPTS}
  IPV6_RECVDSTADDR = 7  platform; { bool; receive IP6 dst addr w/dgram }
  {$EXTERNALSYM IPV6_RECVDSTADDR}
  IPV6_RETOPTS = 8  platform; { ip6_opts; set/get IP6 options }
  {$EXTERNALSYM IPV6_RETOPTS}
*)
  IPV6_SOCKOPT_RESERVED1 = 3  platform; { reserved for future use }
  {$EXTERNALSYM IPV6_SOCKOPT_RESERVED1}

  IPV6_UNICAST_HOPS = 4; { int; IP6 hops }
  {$EXTERNALSYM IPV6_UNICAST_HOPS}
  IPV6_MULTICAST_IF = 9; { __uint8_t; set/get IP6 multicast i/f  }
  {$EXTERNALSYM IPV6_MULTICAST_IF}
  IPV6_MULTICAST_HOPS = 10; { __uint8_t; set/get IP6 multicast hops }
  {$EXTERNALSYM IPV6_MULTICAST_HOPS}
  IPV6_MULTICAST_LOOP = 11; { __uint8_t; set/get IP6 mcast loopback }
  {$EXTERNALSYM IPV6_MULTICAST_LOOP}
  IPV6_JOIN_GROUP = 12; { ip6_mreq; join a group membership }
  {$EXTERNALSYM IPV6_JOIN_GROUP}
  IPV6_LEAVE_GROUP = 13; { ip6_mreq; leave a group membership }
  {$EXTERNALSYM IPV6_LEAVE_GROUP}


  IPV6_PORTRANGE = 14 platform; { int; range to choose for unspec port }
  {$EXTERNALSYM IPV6_PORTRANGE}
  _ICMP6_FILTER = 18 platform; { icmp6_filter; icmp6 filter. Renamed from ICMP6_FILTER }
  {$EXTERNALSYM _ICMP6_FILTER}
{ RFC2292 options }
  IPV6_PKTINFO = 19 platform; { bool; send/recv if, src/dst addr }
  {$EXTERNALSYM IPV6_PKTINFO}
  IPV6_HOPLIMIT = 20 platform; { bool; hop limit }
  {$EXTERNALSYM IPV6_HOPLIMIT}
  IPV6_NEXTHOP = 21 platform; { bool; next hop addr }
  {$EXTERNALSYM IPV6_NEXTHOP}
  IPV6_HOPOPTS = 22 platform; { bool; hop-by-hop option }
  {$EXTERNALSYM IPV6_HOPOPTS}
  IPV6_DSTOPTS = 23 platform; { bool; destination option }
  {$EXTERNALSYM IPV6_DSTOPTS}
  IPV6_RTHDR = 24 platform; { bool; routing header }
  {$EXTERNALSYM IPV6_RTHDR}
  IPV6_PKTOPTIONS = 25 platform; { buf/cmsghdr; set/get IPv6 options }
  {$EXTERNALSYM IPV6_PKTOPTIONS}

  IPV6_CHECKSUM = 26 platform; { int; checksum offset for raw socket }
  {$EXTERNALSYM IPV6_CHECKSUM}

  IPV6_V6ONLY = 27; { bool; only bind INET6 at wildcard bind }
  {$EXTERNALSYM IPV6_V6ONLY}

  IPV6_BINDV6ONLY = IPV6_V6ONLY platform;
  {$EXTERNALSYM IPV6_BINDV6ONLY}

{ IPSEC }
  IPV6_IPSEC_POLICY = 28 platform; { struct; get/set security policy }
  {$EXTERNALSYM IPV6_IPSEC_POLICY}

  IPV6_FAITH = 29 platform; { bool; accept FAITH'ed connections }
  {$EXTERNALSYM IPV6_FAITH}
{ IPV6FIREWALL }
  IPV6_FW_ADD = 30 platform; { add a firewall rule to chain }
  {$EXTERNALSYM IPV6_FW_ADD}
  IPV6_FW_DEL = 31 platform; { delete a firewall rule from chain }
  {$EXTERNALSYM IPV6_FW_DEL}
  IPV6_FW_FLUSH = 32 platform; { flush firewall rule chain }
  {$EXTERNALSYM IPV6_FW_FLUSH}
  IPV6_FW_ZERO = 33 platform; { clear single/all firewall counter(s) }
  {$EXTERNALSYM IPV6_FW_ZERO}
  IPV6_FW_GET = 34 platform; { get entire firewall rule chain }
  {$EXTERNALSYM IPV6_FW_GET}

  IPV6_RECVTCLASS = 35 platform; { bool; recv traffic class values }
  {$EXTERNALSYM IPV6_RECVTCLASS}
  IPV6_TCLASS = 36 platform; { int; send traffic class value }
  {$EXTERNALSYM IPV6_TCLASS}

{ to define items, should talk with KAME guys first, for *BSD compatibility }
  IPV6_RTHDR_LOOSE = 0 platform; { this hop need not be a neighbor. XXX old spec }
  {$EXTERNALSYM IPV6_RTHDR_LOOSE}
  IPV6_RTHDR_STRICT = 1 platform; { this hop must be a neighbor. XXX old spec }
  {$EXTERNALSYM IPV6_RTHDR_STRICT}
  IPV6_RTHDR_TYPE_0 = 0 platform; { IPv6 routing header type 0 }
  {$EXTERNALSYM IPV6_RTHDR_TYPE_0}

{ Defaults and limits for options }
  IPV6_DEFAULT_MULTICAST_HOPS = 1  platform; { normally limit m'casts to 1 hop  }
  {$EXTERNALSYM IPV6_DEFAULT_MULTICAST_HOPS}
  IPV6_DEFAULT_MULTICAST_LOOP = 1  platform; { normally hear sends if a member  }
  {$EXTERNALSYM IPV6_DEFAULT_MULTICAST_LOOP}

type
  ipv6_mreq = record
    ipv6mr_multiaddr: in6_addr;
    ipv6mr_interface: Cardinal;
  end;
  {$EXTERNALSYM ipv6_mreq}
  Pipv6_mreq = ^ipv6_mreq;

{ IPv6 packet information.  }
  in6_pktinfo = record
    ipi6_addr: in6_addr;         { src/dst IPv6 address }
    ipi6_ifindex: Cardinal;      { send/recv interface index }
  end;
  {$EXTERNALSYM in6_pktinfo}
  Pin6_pktinfo = ^in6_pktinfo;

const

{ Argument for IPV6_PORTRANGE:
 - which range to search when port is unspecified at bind() or connect() }

  IPV6_PORTRANGE_DEFAULT = 0 platform; { default range }
  {$EXTERNALSYM IPV6_PORTRANGE_DEFAULT}
  IPV6_PORTRANGE_HIGH = 1 platform; { "high" - request firewall bypass }
  {$EXTERNALSYM IPV6_PORTRANGE_HIGH}
  IPV6_PORTRANGE_LOW = 2 platform; { "low" - vouchsafe security }
  {$EXTERNALSYM IPV6_PORTRANGE_LOW}


{ Definitions for inet6 sysctl operations.

  Third level is protocol number.
  Fourth level is desired variable within that protocol.}

  IPV6PROTO_MAXID = (IPPROTO_PIM + 1) platform; { don't list to IPV6PROTO_MAX }
  {$EXTERNALSYM IPV6PROTO_MAXID}

{ Names for IP sysctl objects }

  IPV6CTL_FORWARDING = 1 platform; { act as router }
  {$EXTERNALSYM IPV6CTL_FORWARDING}
  IPV6CTL_SENDREDIRECTS = 2 platform; { may send redirects when forwarding}
  {$EXTERNALSYM IPV6CTL_SENDREDIRECTS}
  IPV6CTL_DEFHLIM = 3 platform; { default Hop-Limit }
  {$EXTERNALSYM IPV6CTL_DEFHLIM}
  { #ifdef notyet }
  IPV6CTL_DEFMTU = 4 platform; { default MTU }
  {$EXTERNALSYM IPV6CTL_DEFMTU}
  { #endif }
  IPV6CTL_FORWSRCRT = 5 platform; { forward source-routed dgrams }
  {$EXTERNALSYM IPV6CTL_FORWSRCRT}
  IPV6CTL_STATS = 6 platform; { stats }
  {$EXTERNALSYM IPV6CTL_STATS}
  IPV6CTL_MRTSTATS = 7 platform; { multicast forwarding stats }
  {$EXTERNALSYM IPV6CTL_MRTSTATS}
  IPV6CTL_MRTPROTO = 8 platform; { multicast routing protocol }
  {$EXTERNALSYM IPV6CTL_MRTPROTO}
  IPV6CTL_MAXFRAGPACKETS = 9 platform; { max packets reassembly queue }
  {$EXTERNALSYM IPV6CTL_MAXFRAGPACKETS}
  IPV6CTL_SOURCECHECK = 10 platform; { verify source route and intf }
  {$EXTERNALSYM IPV6CTL_SOURCECHECK}
  IPV6CTL_SOURCECHECK_LOGINT = 11 platform; { minimume logging interval }
  {$EXTERNALSYM IPV6CTL_SOURCECHECK_LOGINT}
  IPV6CTL_ACCEPT_RTADV = 12 platform;
  {$EXTERNALSYM IPV6CTL_ACCEPT_RTADV}
  IPV6CTL_KEEPFAITH = 13 platform;
  {$EXTERNALSYM IPV6CTL_KEEPFAITH}
  IPV6CTL_LOG_INTERVAL = 14 platform;
  {$EXTERNALSYM IPV6CTL_LOG_INTERVAL}
  IPV6CTL_HDRNESTLIMIT = 15 platform;
  {$EXTERNALSYM IPV6CTL_HDRNESTLIMIT}
  IPV6CTL_DAD_COUNT = 16 platform;
  {$EXTERNALSYM IPV6CTL_DAD_COUNT}
  IPV6CTL_AUTO_FLOWLABEL = 17 platform;
  {$EXTERNALSYM IPV6CTL_AUTO_FLOWLABEL}
  IPV6CTL_DEFMCASTHLIM = 18 platform;
  {$EXTERNALSYM IPV6CTL_DEFMCASTHLIM}
  IPV6CTL_GIF_HLIM = 19 platform; { default HLIM for gif encap packet }
  {$EXTERNALSYM IPV6CTL_GIF_HLIM}
  IPV6CTL_KAME_VERSION = 20 platform;
  {$EXTERNALSYM IPV6CTL_KAME_VERSION}
  IPV6CTL_USE_DEPRECATED = 21 platform; { use deprecated addr (RFC2462 5.5.4) }
  {$EXTERNALSYM IPV6CTL_USE_DEPRECATED}
  IPV6CTL_RR_PRUNE = 22 platform; { walk timer for router renumbering }
  {$EXTERNALSYM IPV6CTL_RR_PRUNE}
(* #if 0	/*obsolete*/
  IPV6CTL_MAPPED_ADDR = 23 platform;
  {$EXTERNALSYM IPV6CTL_MAPPED_ADDR}
#endif *)
  IPV6CTL_V6ONLY = 24 platform;
  {$EXTERNALSYM IPV6CTL_V6ONLY}
  IPV6CTL_RTEXPIRE = 25 platform; { cloned route expiration time }
  {$EXTERNALSYM IPV6CTL_RTEXPIRE}
  IPV6CTL_RTMINEXPIRE = 26 platform; { min value for expiration time }
  {$EXTERNALSYM IPV6CTL_RTMINEXPIRE}
  IPV6CTL_RTMAXCACHE = 27 platform; { trigger level for dynamic expire }
  {$EXTERNALSYM IPV6CTL_RTMAXCACHE}

  IPV6CTL_USETEMPADDR = 32 platform; { use temporary addresses (RFC3041) }
  {$EXTERNALSYM IPV6CTL_USETEMPADDR}
  IPV6CTL_TEMPPLTIME = 33 platform; { preferred lifetime for tmpaddrs }
  {$EXTERNALSYM IPV6CTL_TEMPPLTIME}
  IPV6CTL_TEMPVLTIME = 34 platform; { valid lifetime for tmpaddrs }
  {$EXTERNALSYM IPV6CTL_TEMPVLTIME}
  IPV6CTL_AUTO_LINKLOCAL = 35 platform; { automatic link-local addr assign }
  {$EXTERNALSYM IPV6CTL_AUTO_LINKLOCAL}
  IPV6CTL_RIP6STATS = 36 platform; { raw_ip6 stats }
  {$EXTERNALSYM IPV6CTL_RIP6STATS}

  IPV6CTL_MAXFRAGS = 41      platform; { max fragments }
  {$EXTERNALSYM IPV6CTL_MAXFRAGS}

  IPV6CTL_NEIGHBORGCTHRESH = 46 platform;
  {$EXTERNALSYM IPV6CTL_NEIGHBORGCTHRESH}
  IPV6CTL_MAXIFPREFIXES = 47 platform;
  {$EXTERNALSYM IPV6CTL_MAXIFPREFIXES}
  IPV6CTL_MAXIFDEFROUTERS = 48 platform;
  {$EXTERNALSYM IPV6CTL_MAXIFDEFROUTERS}
  IPV6CTL_MAXDYNROUTES = 49 platform;
  {$EXTERNALSYM IPV6CTL_MAXDYNROUTES}

{ New entries should be added here from current IPV6CTL_MAXID value. 
  to define items, should talk with KAME guys first, for *BSD compatibility }
  IPV6CTL_MAXID = 50 platform;
  {$EXTERNALSYM IPV6CTL_MAXID}
