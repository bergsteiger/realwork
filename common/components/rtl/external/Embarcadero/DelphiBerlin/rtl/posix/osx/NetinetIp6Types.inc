{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type
  ip6_hdrctl = record
    ip6_un1_flow: UInt32;
    ip6_un1_plen: UInt16;
    ip6_un1_nxt: UInt8;
    ip6_un1_hlim: UInt8;
  end;
  {$EXTERNALSYM ip6_hdrctl}
  Pip6_hdrctl = ^ip6_hdrctl;
  {$EXTERNALSYM Pip6_hdrctl}

  TIP6CtlUnion = record
    case Integer of
    0: ( ip6_un1: ip6_hdrctl);
    1: ( ip6_un2_vfc: UInt8);
  end;
  {$EXTERNALSYM TIP6CtlUnion}

  ip6_hdr = record
    ip6_ctlun: TIP6CtlUnion;
    ip6_src: in6_addr;
    ip6_dst: in6_addr;
  end;
  {$EXTERNALSYM ip6_hdr}
  Pip6_hdr = ^ip6_hdr;
  {$EXTERNALSYM Pip6_hdr}

  ip6_ext = record
    ip6e_nxt: UInt8;
    ip6e_len: UInt8;
  end;
  {$EXTERNALSYM ip6_ext}
  Pip6_ext = ^ip6_ext;
  {$EXTERNALSYM Pip6_ext}

{ Hop-by-Hop options header.  }
  ip6_hbh = record
    ip6h_nxt: UInt8;        { next header.  }
    ip6h_len: UInt8;        { length in units of 8 octets.  }
    { followed by options }
  end;
  {$EXTERNALSYM ip6_hbh}
  Pip6_hbh = ^ip6_hbh;
  {$EXTERNALSYM Pip6_hbh}

{ Destination options header }
  ip6_dest = record
    ip6d_nxt: UInt8;        { next header }
    ip6d_len: UInt8;        { length in units of 8 octets }
    { followed by options }
  end;
  {$EXTERNALSYM ip6_dest}
  Pip6_dest = ^ip6_dest;
  {$EXTERNALSYM Pip6_dest}

const
{ Option types and related macros }
  IP6OPT_PAD1 = $00; { 00 0 00000 }
  {$EXTERNALSYM IP6OPT_PAD1}
  IP6OPT_PADN = $01; { 00 0 00001 }
  {$EXTERNALSYM IP6OPT_PADN}
  IP6OPT_JUMBO = $C2; { 11 0 00010 = 194 }
  {$EXTERNALSYM IP6OPT_JUMBO}
  IP6OPT_NSAP_ADDR = $C3; { 11 0 00011 }
  {$EXTERNALSYM IP6OPT_NSAP_ADDR}
  IP6OPT_TUNNEL_LIMIT = $04; { 00 0 00100 }
  {$EXTERNALSYM IP6OPT_TUNNEL_LIMIT}
  IP6OPT_RTALERT = $05; { 00 0 00101 (KAME definition) }  //TODO: ROUTER_ALERT
  {$EXTERNALSYM IP6OPT_RTALERT}

  IP6OPT_RTALERT_LEN = 4;
  {$EXTERNALSYM IP6OPT_RTALERT_LEN}
  IP6OPT_RTALERT_MLD = 0; { Datagram contains an MLD message }
  {$EXTERNALSYM IP6OPT_RTALERT_MLD}
  IP6OPT_RTALERT_RSVP = 1; { Datagram contains an RSVP message }
  {$EXTERNALSYM IP6OPT_RTALERT_RSVP}
  IP6OPT_RTALERT_ACTNET = 2 ; { contains an Active Networks msg }
  {$EXTERNALSYM IP6OPT_RTALERT_ACTNET}
  IP6OPT_MINLEN = 2;
  {$EXTERNALSYM IP6OPT_MINLEN}

  IP6OPT_BINDING_UPDATE = $c6; { 11 0 00110 }
  {$EXTERNALSYM IP6OPT_BINDING_UPDATE}
  IP6OPT_BINDING_ACK = $07; { 00 0 00111 }
  {$EXTERNALSYM IP6OPT_BINDING_ACK}
  IP6OPT_BINDING_REQ = $08; { 00 0 01000 }
  {$EXTERNALSYM IP6OPT_BINDING_REQ}
  IP6OPT_HOME_ADDRESS = $c9; { 11 0 01001 }
  {$EXTERNALSYM IP6OPT_HOME_ADDRESS}
  IP6OPT_EID = $8a; { 10 0 01010 }
  {$EXTERNALSYM IP6OPT_EID}

  //TODO: #define IP6OPT_TYPE(o) ((o) & $C0)
  IP6OPT_TYPE_SKIP = $00;
  {$EXTERNALSYM IP6OPT_TYPE_SKIP}
  IP6OPT_TYPE_DISCARD = $40;
  {$EXTERNALSYM IP6OPT_TYPE_DISCARD}
  IP6OPT_TYPE_FORCEICMP = $80;
  {$EXTERNALSYM IP6OPT_TYPE_FORCEICMP}
  IP6OPT_TYPE_ICMP = $C0;
  {$EXTERNALSYM IP6OPT_TYPE_ICMP}

  IP6OPT_MUTABLE = $20;
  {$EXTERNALSYM IP6OPT_MUTABLE}

  IP6OPT_JUMBO_LEN = 6;
  {$EXTERNALSYM IP6OPT_JUMBO_LEN}

type
{ Routing header }
  ip6_rthdr = record
    ip6r_nxt: UInt8;        { next header }
    ip6r_len: UInt8;        { length in units of 8 octets }
    ip6r_type: UInt8;       { routing type }
    ip6r_segleft: UInt8;    { segments left }
    { followed by routing type specific data }
  end;
  {$EXTERNALSYM ip6_rthdr}
  Pip6_rthdr = ^ip6_rthdr;
  {$EXTERNALSYM Pip6_rthdr}

{ Type 0 Routing header }
  ip6_rthdr0 = record
    ip6r0_nxt: UInt8;       { next header }
    ip6r0_len: UInt8;       { length in units of 8 octets }
    ip6r0_type: UInt8;      { always zero }
    ip6r0_segleft: UInt8;   { segments left }
    ip6r0_reserved: UInt8;  { reserved field }
  end;
  {$EXTERNALSYM ip6_rthdr0}
  Pip6_rthdr0 = ^ip6_rthdr0;
  {$EXTERNALSYM Pip6_rthdr0}

{ Fragment header }
  ip6_frag = record
    ip6f_nxt: UInt8;        { next header }
    ip6f_reserved: UInt8;   { reserved field }
    ip6f_offlg: UInt16;     { offset, reserved, and flag }
    ip6f_ident: UInt32;     { identification }
  end;
  {$EXTERNALSYM ip6_frag}
  Pip6_frag = ^ip6_frag;
  {$EXTERNALSYM Pip6_frag}

const
  IP6F_OFF_MASK       = $f8ff;  { mask out offset from _offlg }
  {$EXTERNALSYM IP6F_OFF_MASK}
  IP6F_RESERVED_MASK  = $0600;  { reserved bits in ip6f_offlg }
  {$EXTERNALSYM IP6F_RESERVED_MASK}
  IP6F_MORE_FRAG      = $0100;  { more-fragments flag }
  {$EXTERNALSYM IP6F_MORE_FRAG}

{ Internet implementation parameters.}
  IPV6_MAXHLIM = 255; { maximun hoplimit }
  {$EXTERNALSYM IPV6_MAXHLIM}
  IPV6_DEFHLIM = 64; { default hlim }
  {$EXTERNALSYM IPV6_DEFHLIM}
  IPV6_FRAGTTL = 120; { ttl for fragment packets, in slowtimo tick }
  {$EXTERNALSYM IPV6_FRAGTTL}
  IPV6_HLIMDEC = 1; { subtracted when forwaeding }
  {$EXTERNALSYM IPV6_HLIMDEC}

  IPV6_MMTU = 1280; { minimal MTU and reassembly. 1024 + 256 }
  {$EXTERNALSYM IPV6_MMTU}
  IPV6_MAXPACKET = 65535; { ip6 max packet size without Jumbo payload}
  {$EXTERNALSYM IPV6_MAXPACKET}
