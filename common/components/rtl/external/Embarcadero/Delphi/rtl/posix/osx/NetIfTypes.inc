{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  _if_nameindex = record
    if_index: Cardinal;
    if_name: MarshaledAString;
  end;
  {$EXTERNALSYM _if_nameindex}
  PIfNameIndex = ^_if_nameindex;
  {$EXTERNALSYM PIfNameIndex}

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
  IFF_ALLMULTI = $200 platform;     { Receive all multicast packets.  }
  {$EXTERNALSYM IFF_ALLMULTI}
  IFF_OACTIVE = $400 platform;     { transmission in progress }
  {$EXTERNALSYM IFF_OACTIVE}
  IFF_SIMPLEX = $800 platform;     { can't hear own transmissions }
  {$EXTERNALSYM IFF_SIMPLEX}
  IFF_LINK0 = $1000 platform;      { per link layer defined bit }
  {$EXTERNALSYM IFF_LINK0}
  IFF_LINK1 = $2000 platform;      { per link layer defined bit }
  {$EXTERNALSYM IFF_LINK1}
  IFF_LINK2 = $4000 platform;      { per link layer defined bit }
  {$EXTERNALSYM IFF_LINK2}
  IFF_ALTPHYS = IFF_LINK2 platform; { use alternate physical connection }
  {$EXTERNALSYM IFF_ALTPHYS}
  IFF_MULTICAST = $8000 platform;  { supports multicast }
  {$EXTERNALSYM IFF_MULTICAST}

{ Interface request structure used for socket ioctl's.  All interface
   ioctl's must have parameter definitions which begin with ifr_name.
   The remainder may be interface specific.  }
const
  IFNAMSIZ    = 16;
  {$EXTERNALSYM IFNAMSIZ}
type
  ifdevmtu = record
    ifdm_current: Integer;
    ifdm_min: Integer;
    ifdm_max: Integer;
  end;
  {$EXTERNALSYM ifdevmtu}

  ifkpi = record
    ifk_module_id: UInt32;
    ifk_type: UInt32;
    case Integer of
      0:( ifk_ptr: Pointer; );
      1:( ifk_value: Integer; );
  end;
  {$EXTERNALSYM ifkpi}

  ifreq = {packed} record
    ifrn_name: packed array[0..IFNAMSIZ-1] of Byte; { Interface name, e.g. "en0".  }
    case Integer of
       0: ( ifru_addr: sockaddr; );
       1: ( ifru_dstaddr: sockaddr; );
       2: ( ifru_broadaddr: sockaddr; );
       5: ( ifru_flags: Smallint; );
       6: ( ifru_metric: Integer; );
       7: ( ifru_mtu: Integer; );
       8: ( ifru_phys: Integer; );
       9: ( ifru_media: Integer; );
       10:( ifru_intval: Integer; );
       11:( ifru_data: caddr_t; );
       12:( ifru_devmtu: ifdevmtu; );
       13:( ifru_kpi: ifkpi; );
       14:( ifru_wake_flags: UInt32; );
       //DONE: other versions
    end;
  {$EXTERNALSYM ifreq}
  Pifreq = ^ifreq;

type
  Pifaddrs = ^ifaddrs;
  ifaddrs = record
    ifa_next: Pifaddrs;        { Next address for interface.  }
    ifa_name: MarshaledAString;
    ifa_flags: Cardinal;
    ifa_addr: Psockaddr;       { Address of interface.  }
    ifa_netmask: Psockaddr;
    ifa_dstaddr: Psockaddr;
    ifa_data: Pointer;
  end platform;
  {$EXTERNALSYM ifaddrs}

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

(* Cannot be translated
#define	ifc_buf	ifc_ifcu.ifcu_buf	{ Buffer address.  }
#define	ifc_req	ifc_ifcu.ifcu_req	{ Array of structures.  }
*)
