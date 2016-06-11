{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type
  _if_nameindex = record //renamed due to name conflict with function name.
    if_index: Cardinal;
    if_name: MarshaledAString;
  end;
  PIfNameIndex = ^_if_nameindex;

{ Standard interface flags. }
const
  IFF_UP = $1 platform;             { Interface is up.  }
  {$EXTERNALSYM IFF_UP}
  IFF_BROADCAST = $2 platform;      { Broadcast address valid.  }
  {$EXTERNALSYM IFF_BROADCAST}
  IFF_DEBUG = $4 platform;          { Turn on debugging.  }
  {$EXTERNALSYM IFF_DEBUG}
  IFF_LOOPBACK = $8 platform;       { Is a loopback net.  }
  {$EXTERNALSYM IFF_LOOPBACK}
  IFF_POINTOPOINT = $10 platform;   { Interface is point-to-point link.  }
  {$EXTERNALSYM IFF_POINTOPOINT}
  IFF_NOTRAILERS = $20 platform;    { Avoid use of trailers.  }
  {$EXTERNALSYM IFF_NOTRAILERS}
  IFF_RUNNING = $40 platform;       { Resources allocated.  }
  {$EXTERNALSYM IFF_RUNNING}
  IFF_NOARP = $80 platform;         { No address resolution protocol.  }
  {$EXTERNALSYM IFF_NOARP}
  IFF_PROMISC = $100 platform;      { Receive all packets.  }
  {$EXTERNALSYM IFF_PROMISC}

  { Not supported }
  IFF_ALLMULTI = $200 platform;     { Receive all multicast packets.  }
  {$EXTERNALSYM IFF_ALLMULTI}

  IFF_MASTER = $400 platform;       { Master of a load balancer.  }
  {$EXTERNALSYM IFF_MASTER}
  IFF_SLAVE = $800 platform;        { Slave of a load balancer.  }
  {$EXTERNALSYM IFF_SLAVE}

  IFF_MULTICAST = $1000 platform;   { Supports multicast.  }
  {$EXTERNALSYM IFF_MULTICAST}

  IFF_PORTSEL = $2000 platform;     { Can set media type.  }
  {$EXTERNALSYM IFF_PORTSEL}
  IFF_AUTOMEDIA = $4000 platform;   { Auto media select active.  }
  {$EXTERNALSYM IFF_AUTOMEDIA}
  IFF_DYNAMIC   = $8000 platform;   { Dialup device with changing addresses. }
  {$EXTERNALSYM IFF_DYNAMIC}

  IFF_LOWER_UP = $10000;
  {$EXTERNALSYM IFF_LOWER_UP}
  IFF_DORMANT = $20000;
  {$EXTERNALSYM IFF_DORMANT}

  IFF_VOLATILE = (IFF_LOOPBACK or IFF_POINTOPOINT or IFF_BROADCAST or IFF_MASTER or IFF_SLAVE or IFF_RUNNING or IFF_LOWER_UP or IFF_DORMANT);
  {$EXTERNALSYM IFF_VOLATILE}

  IFF_802_1Q_VLAN = $1;
  {$EXTERNALSYM IFF_802_1Q_VLAN}
  IFF_EBRIDGE = $2;
  {$EXTERNALSYM IFF_EBRIDGE}
  IFF_SLAVE_INACTIVE = $4;
  {$EXTERNALSYM IFF_SLAVE_INACTIVE}
  IFF_MASTER_8023AD = $8;
  {$EXTERNALSYM IFF_MASTER_8023AD}
  IFF_MASTER_ALB = $10;
  {$EXTERNALSYM IFF_MASTER_ALB}

  IF_GET_IFACE = $1;
  {$EXTERNALSYM IF_GET_IFACE}
  IF_GET_PROTO = $2;
  {$EXTERNALSYM IF_GET_PROTO}

  IF_IFACE_V35 = $1000;
  {$EXTERNALSYM IF_IFACE_V35}
  IF_IFACE_V24 = $1001;
  {$EXTERNALSYM IF_IFACE_V24}
  IF_IFACE_X21 = $1002;
  {$EXTERNALSYM IF_IFACE_X21}
  IF_IFACE_T1 = $1003;
  {$EXTERNALSYM IF_IFACE_T1}
  IF_IFACE_E1 = $1004;
  {$EXTERNALSYM IF_IFACE_E1}
  IF_IFACE_SYNC_SERIAL = $1005;
  {$EXTERNALSYM IF_IFACE_SYNC_SERIAL}
  IF_IFACE_X21D = $1006;
  {$EXTERNALSYM IF_IFACE_X21D}

  IF_PROTO_HDLC = $2000;
  {$EXTERNALSYM IF_PROTO_HDLC}
  IF_PROTO_PPP = $2001;
  {$EXTERNALSYM IF_PROTO_PPP}
  IF_PROTO_CISCO = $2002;
  {$EXTERNALSYM IF_PROTO_CISCO}
  IF_PROTO_FR = $2003;
  {$EXTERNALSYM IF_PROTO_FR}
  IF_PROTO_FR_ADD_PVC = $2004;
  {$EXTERNALSYM IF_PROTO_FR_ADD_PVC}
  IF_PROTO_FR_DEL_PVC = $2005;
  {$EXTERNALSYM IF_PROTO_FR_DEL_PVC}
  IF_PROTO_X25 = $2006;
  {$EXTERNALSYM IF_PROTO_X25}
  IF_PROTO_HDLC_ETH = $2007;
  {$EXTERNALSYM IF_PROTO_HDLC_ETH}
  IF_PROTO_FR_ADD_ETH_PVC = $2008;
  {$EXTERNALSYM IF_PROTO_FR_ADD_ETH_PVC}
  IF_PROTO_FR_DEL_ETH_PVC = $2009;
  {$EXTERNALSYM IF_PROTO_FR_DEL_ETH_PVC}
  IF_PROTO_FR_PVC = $200A;
  {$EXTERNALSYM IF_PROTO_FR_PVC}
  IF_PROTO_FR_ETH_PVC = $200B;
  {$EXTERNALSYM IF_PROTO_FR_ETH_PVC}
  IF_PROTO_RAW = $200C;
  {$EXTERNALSYM IF_PROTO_RAW}

  IF_OPER_UNKNOWN = 0;
  {$EXTERNALSYM IF_OPER_UNKNOWN}
  IF_OPER_NOTPRESENT = 1;
  {$EXTERNALSYM IF_OPER_NOTPRESENT}
  IF_OPER_DOWN = 2;
  {$EXTERNALSYM IF_OPER_DOWN}
  IF_OPER_LOWERLAYERDOWN = 3;
  {$EXTERNALSYM IF_OPER_LOWERLAYERDOWN}
  IF_OPER_TESTING = 4;
  {$EXTERNALSYM IF_OPER_TESTING}
  IF_OPER_DORMANT = 5;
  {$EXTERNALSYM IF_OPER_DORMANT}
  IF_OPER_UP = 6;
  {$EXTERNALSYM IF_OPER_UP}
  IF_LINK_MODE_DEFAULT = 0;
  {$EXTERNALSYM IF_LINK_MODE_DEFAULT}
  IF_LINK_MODE_DORMANT = 1;
  {$EXTERNALSYM IF_LINK_MODE_DORMANT}




{ Interface request structure used for socket ioctl's.  All interface
   ioctl's must have parameter definitions which begin with ifr_name.
   The remainder may be interface specific.  }
const
  IFHWADDRLEN = 6;
  {$EXTERNALSYM IFHWADDRLEN}
  IFNAMSIZ    = 16;
  {$EXTERNALSYM IFNAMSIZ}
  IF_NAMESIZE = IFNAMSIZ;
  {$EXTERNALSYM IF_NAMESIZE}

type
  sync_serial_settings = record
     clock_rate: UInt32;
     clock_type: UInt32;
     loopback: Word;
  end;
  {$EXTERNALSYM sync_serial_settings}
  Psync_serial_settings = ^sync_serial_settings;

  te1_settings = record
     clock_rate: UInt32;
     clock_type: UInt32;
     loopback: Word;
     slot_map: UInt32;
  end;
  {$EXTERNALSYM te1_settings}
  Pte1_settings = ^te1_settings;

  raw_hdlc_proto = record
    encoding: Word;
    parity: Word;
  end;
  {$EXTERNALSYM raw_hdlc_proto}
  Praw_hdlc_proto = ^raw_hdlc_proto;

  fr_proto = record
    t391: UInt32;
    t392: UInt32;
    n391: UInt32;
    n392: UInt32;
    n393: UInt32;
    lmi: Word;
    dce: Word;
  end;
  {$EXTERNALSYM fr_proto}
  Pfr_proto = ^fr_proto;

  fr_proto_pvc = record
    dlci: UInt32;
  end;
  {$EXTERNALSYM fr_proto_pvc}
  Pfr_proto_pvc = ^fr_proto_pvc;

  fr_proto_pvc_info = record
    dlci: UInt32;
    master: packed array[0..IFNAMSIZ-1] of Byte;
  end;
  {$EXTERNALSYM fr_proto_pvc_info}
  Pfr_proto_pvc_info = ^fr_proto_pvc_info;

  cisco_proto = record
    interval: UInt32;
    timeout: UInt32;
  end;
  {$EXTERNALSYM cisco_proto}
  Pcisco_proto = ^cisco_proto;

type

{ Device mapping structure. I'd just gone off and designed a
   beautiful scheme using only loadable modules with arguments for
   driver options and along come the PCMCIA people 8)

   Ah well. The get() side of this is good for WDSETUP, and it'll be
   handy for debugging things. The set side is fine for now and being
   very small might be worth keeping for clean configuration.  }

  ifmap = record
    mem_start: UInt32;
    mem_end: UInt32;
    base_addr: Word;
    irq: Byte;
    dma: Byte;
    port: Byte;
    { 3 bytes spare }
  end platform;
  {$EXTERNALSYM ifmap}
  Pifmap = ^ifmap;

  if_settings = record
    _type: UInt32;
    size: UInt32;
    ifs_ifsu: record
                case Integer of
                  0:( raw_hdlc: Praw_hdlc_proto;);
                  1:( cisco: Pcisco_proto;);
                  2:( fr: Pfr_proto;);
                  3:( fr_pvc: Pfr_proto_pvc;);
                  4:( fr_pvc_info: Pfr_proto_pvc_info;);
                  5:( sync: Psync_serial_settings);
                  6:( te1: Pte1_settings;);
                end;
    end;

  ifreq = {packed} record
    ifrn_name: packed array[0..IFNAMSIZ-1] of Byte; { Interface name, e.g. "en0".  }
    ifr_ifru: record
                case Integer of
                   0:( ifru_addr: sockaddr; );
                   1:( ifru_dstaddr: sockaddr; );
                   2:( ifru_broadaddr: sockaddr; );
                   3:( ifru_netmask: sockaddr; );
                   4:( ifru_hwaddr: sockaddr; );
                   5:( ifru_flags: Smallint; );
                   6:( ifru_ivalue: Integer; );
                   7:( ifru_mtu: Integer;);
                   8:( ifru_map: ifmap;);
                   9:( ifru_slave: packed array[0..IFNAMSIZ-1] of Byte; ); { Just fits the size }
                  10:( ifru_newname: packed array[0..IFNAMSIZ-1] of Byte; );
                  11:( ifru_data: caddr_t; );
                  12:( ifru_settings: if_settings;);
                end;
    end;
  {$EXTERNALSYM ifreq}
  Pifreq = ^ifreq;


{* Cannot be translated
  #define ifr_name ifr_ifrn.ifrn_name
  #define ifr_hwaddr ifr_ifru.ifru_hwaddr
  #define ifr_addr ifr_ifru.ifru_addr
  #define ifr_dstaddr ifr_ifru.ifru_dstaddr
  #define ifr_broadaddr ifr_ifru.ifru_broadaddr
  #define ifr_netmask ifr_ifru.ifru_netmask
  #define ifr_flags ifr_ifru.ifru_flags
  #define ifr_metric ifr_ifru.ifru_ivalue
  #define ifr_mtu ifr_ifru.ifru_mtu
  #define ifr_map ifr_ifru.ifru_map
  #define ifr_slave ifr_ifru.ifru_slave
  #define ifr_data ifr_ifru.ifru_data
  #define ifr_ifindex ifr_ifru.ifru_ivalue
  #define ifr_bandwidth ifr_ifru.ifru_ivalue
  #define ifr_qlen ifr_ifru.ifru_ivalue
  #define ifr_newname ifr_ifru.ifru_newname
  #define ifr_settings ifr_ifru.ifru_settings

*}


{ Structure used in SIOCGIFCONF request.  Used to retrieve interface
   configuration for machine (useful for programs which must know all
   networks accessible).  }
type
  ifconf = record
    ifc_len: Integer;                 { Size of buffer.  }
    ifc_ifcu: record
                case Integer of
                  0: (ifcu_buf: caddr_t);
                  1: (ifcu_req: PIFreq);
                end;
  end;
  {$EXTERNALSYM ifconf}
  Pifconf = ^ifconf;

(* Cannot be translated
#define	ifc_buf	ifc_ifcu.ifcu_buf	{ Buffer address.  }
#define	ifc_req	ifc_ifcu.ifcu_req	{ Array of structures.  }
*)
