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

  ip6_ext = record
    ip6e_nxt: UInt8;
    ip6e_len: UInt8;
  end;
  {$EXTERNALSYM ip6_ext}
  Pip6_ext = ^ip6_ext;

{ Hop-by-Hop options header.  }
  ip6_hbh = record
    ip6h_nxt: UInt8;        { next header.  }
    ip6h_len: UInt8;        { length in units of 8 octets.  }
    { followed by options }
  end;
  {$EXTERNALSYM ip6_hbh}
  Pip6_hbh = ^ip6_hbh;

{ Destination options header }
  ip6_dest = record
    ip6d_nxt: UInt8;        { next header }
    ip6d_len: UInt8;        { length in units of 8 octets }
    { followed by options }
  end;
  {$EXTERNALSYM ip6_dest}
  Pip6_dest = ^ip6_dest;

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

{ Fragment header }
  ip6_frag = record
    ip6f_nxt: UInt8;        { next header }
    ip6f_reserved: UInt8;   { reserved field }
    ip6f_offlg: UInt16;     { offset, reserved, and flag }
    ip6f_ident: UInt32;     { identification }
  end;
  {$EXTERNALSYM ip6_frag}
  Pip6_frag = ^ip6_frag;

const
  IP6F_OFF_MASK       = $f8ff;  { mask out offset from _offlg }
  {$EXTERNALSYM IP6F_OFF_MASK}
  IP6F_RESERVED_MASK  = $0600;  { reserved bits in ip6f_offlg }
  {$EXTERNALSYM IP6F_RESERVED_MASK}
  IP6F_MORE_FRAG      = $0100;  { more-fragments flag }
  {$EXTERNALSYM IP6F_MORE_FRAG}

type
  ip6_opt = record
    ip6o_type: UInt8;
    ip6o_len: UInt8;
  end;
  {$EXTERNALSYM ip6_opt}
  Pip6_opt = ^ip6_opt;

const
{ The high-order 3 bits of the option type define the behavior
  when processing an unknown option and whether or not the option
  content changes in flight. }
//TODO: #define IP6OPT_TYPE(o)		((o) & 0xc0)
  IP6OPT_TYPE_SKIP = $00;
  {$EXTERNALSYM IP6OPT_TYPE_SKIP}
  IP6OPT_TYPE_DISCARD = $40;
  {$EXTERNALSYM IP6OPT_TYPE_DISCARD}
  IP6OPT_TYPE_FORCEICMP = $80;
  {$EXTERNALSYM IP6OPT_TYPE_FORCEICMP}
  IP6OPT_TYPE_ICMP = $c0;
  {$EXTERNALSYM IP6OPT_TYPE_ICMP}
  IP6OPT_TYPE_MUTABLE = $20;
  {$EXTERNALSYM IP6OPT_TYPE_MUTABLE}

{ Special option types for padding. }
  IP6OPT_PAD1 = 0;
  {$EXTERNALSYM IP6OPT_PAD1}
  IP6OPT_PADN = 1;
  {$EXTERNALSYM IP6OPT_PADN}

  IP6OPT_JUMBO	 = $c2;
  {$EXTERNALSYM IP6OPT_JUMBO	}
  IP6OPT_NSAP_ADDR = $c3;
  {$EXTERNALSYM IP6OPT_NSAP_ADDR}
  IP6OPT_TUNNEL_LIMIT = $04;
  {$EXTERNALSYM IP6OPT_TUNNEL_LIMIT}
  IP6OPT_ROUTER_ALERT = $05;
  {$EXTERNALSYM IP6OPT_ROUTER_ALERT}

  IP6OPT_JUMBO_LEN = 6;
  {$EXTERNALSYM IP6OPT_JUMBO_LEN}

type
  ip6_opt_jumbo = record
    ip6oj_type: UInt8;
    ip6oj_len: UInt8;
    ip6oj_jumbo_len: array[0..3] of UInt8;
  end;
  {$EXTERNALSYM ip6_opt_jumbo}
  Pip6_opt_jumbo = ^ip6_opt_jumbo;

  ip6_opt_nsap = record
    ip6on_type: UInt8;
    ip6on_len: UInt8;
    ip6on_src_nsap_len: UInt8;
    ip6on_dst_nsap_len: UInt8;
    { followed by source NSAP } 
    { followed by destination NSAP }
  end;
  {$EXTERNALSYM ip6_opt_nsap}
  Pip6_opt_nsap = ^ip6_opt_nsap;

  ip6_opt_tunnel = record
    ip6ot_type: UInt8;
    ip6ot_len: UInt8;
    ip6ot_encap_limit: UInt8;
  end;
  {$EXTERNALSYM ip6_opt_tunnel}
  Pip6_opt_tunnel = ^ip6_opt_tunnel;

  ip6_opt_router = record
    ip6or_type: UInt8;
    ip6or_len: UInt8;
    ip6or_value: array [0..1] of UInt8;
  end;
  {$EXTERNALSYM ip6_opt_router}
  Pip6_opt_router = ^ip6_opt_router;

const
  IP6_ALERT_MLD = $0000;
  {$EXTERNALSYM IP6_ALERT_MLD}
  IP6_ALERT_RSVP = $0100;
  {$EXTERNALSYM IP6_ALERT_RSVP}
  IP6_ALERT_AN = $0200;
  {$EXTERNALSYM IP6_ALERT_AN}
