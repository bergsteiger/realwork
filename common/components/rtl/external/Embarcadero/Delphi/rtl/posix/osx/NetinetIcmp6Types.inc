{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


type
  icmp6_filter = record
    data: packed array[0..8-1] of UInt32;
  end;
  {$EXTERNALSYM icmp6_filter}
  Picmp6_filter = ^icmp6_filter;

  icmp6_hdr = {packed} record
    icmp6_type: UInt8;    { type field }
    icmp6_code: UInt8;    { code field }
    icmp6_cksum: UInt16;  { checksum field }
    icmp6_dataun: record
      case Integer of
      0: (icmp6_un_data32: packed array[0..1-1] of UInt32); { type-specific field }
      1: (icmp6_un_data16: packed array[0..2-1] of UInt16); { type-specific field }
      2: (icmp6_un_data8: packed array[0..4-1] of UInt8);   { type-specific field }
    end;
  end;
  {$EXTERNALSYM icmp6_hdr}
  Picmp6_hdr = ^icmp6_hdr;

const
  ICMP6_DST_UNREACH             = 1;
  {$EXTERNALSYM ICMP6_DST_UNREACH}
  ICMP6_PACKET_TOO_BIG          = 2;
  {$EXTERNALSYM ICMP6_PACKET_TOO_BIG}
  ICMP6_TIME_EXCEEDED           = 3;
  {$EXTERNALSYM ICMP6_TIME_EXCEEDED}
  ICMP6_PARAM_PROB              = 4;
  {$EXTERNALSYM ICMP6_PARAM_PROB}

  ICMP6_INFOMSG_MASK = $80;    { all informational messages }
  {$EXTERNALSYM ICMP6_INFOMSG_MASK}

  ICMP6_ECHO_REQUEST          = 128;
  {$EXTERNALSYM ICMP6_ECHO_REQUEST}
  ICMP6_ECHO_REPLY            = 129;
  {$EXTERNALSYM ICMP6_ECHO_REPLY}
  ICMP6_MEMBERSHIP_QUERY      = 130;
  {$EXTERNALSYM ICMP6_MEMBERSHIP_QUERY}
  ICMP6_MEMBERSHIP_REPORT     = 131;
  {$EXTERNALSYM ICMP6_MEMBERSHIP_REPORT}
  ICMP6_MEMBERSHIP_REDUCTION  = 132;
  {$EXTERNALSYM ICMP6_MEMBERSHIP_REDUCTION}

  ICMP6_DST_UNREACH_NOROUTE     = 0; { no route to destination }
  {$EXTERNALSYM ICMP6_DST_UNREACH_NOROUTE}
  ICMP6_DST_UNREACH_ADMIN       = 1; { communication with destination administratively prohibited }
  {$EXTERNALSYM ICMP6_DST_UNREACH_ADMIN}
  ICMP6_DST_UNREACH_NOTNEIGHBOR = 2; { beyond scope of source address }
  {$EXTERNALSYM ICMP6_DST_UNREACH_NOTNEIGHBOR}
  ICMP6_DST_UNREACH_ADDR        = 3; { address unreachable }
  {$EXTERNALSYM ICMP6_DST_UNREACH_ADDR}
  ICMP6_DST_UNREACH_NOPORT      = 4; { bad port }
  {$EXTERNALSYM ICMP6_DST_UNREACH_NOPORT}

  ICMP6_TIME_EXCEED_TRANSIT     = 0; { Hop Limit == 0 in transit }
  {$EXTERNALSYM ICMP6_TIME_EXCEED_TRANSIT}
  ICMP6_TIME_EXCEED_REASSEMBLY  = 1; { Reassembly time out }
  {$EXTERNALSYM ICMP6_TIME_EXCEED_REASSEMBLY}

  ICMP6_PARAMPROB_HEADER        = 0; { erroneous header field }
  {$EXTERNALSYM ICMP6_PARAMPROB_HEADER}
  ICMP6_PARAMPROB_NEXTHEADER    = 1; { unrecognized Next Header }
  {$EXTERNALSYM ICMP6_PARAMPROB_NEXTHEADER}
  ICMP6_PARAMPROB_OPTION        = 2; { unrecognized IPv6 option }
  {$EXTERNALSYM ICMP6_PARAMPROB_OPTION}

  _ND_ROUTER_SOLICIT           = 133; //renamed from ND_ROUTER_SOLICIT
  {$EXTERNALSYM ND_ROUTER_SOLICIT}
  _ND_ROUTER_ADVERT            = 134; //renamed from ND_ROUTER_ADVERT
  {$EXTERNALSYM ND_ROUTER_ADVERT}
  _ND_NEIGHBOR_SOLICIT         = 135; //renamed from ND_NEIGHBOR_SOLICIT
  {$EXTERNALSYM ND_NEIGHBOR_SOLICIT}
  _ND_NEIGHBOR_ADVERT          = 136; //renamed from ND_NEIGHBOR_ADVERT
  {$EXTERNALSYM ND_NEIGHBOR_ADVERT}
  _ND_REDIRECT                 = 137; //renamed from ND_REDIRECT
  {$EXTERNALSYM ND_REDIRECT}

type
  nd_router_solicit = record      { router solicitation }
    nd_rs_hdr: icmp6_hdr;
    { could be followed by options }
  end;
  {$EXTERNALSYM nd_router_solicit}
  Pnd_router_solicit = ^nd_router_solicit;

  nd_router_advert = record       { router advertisement }
    nd_ra_hdr: icmp6_hdr;
    nd_ra_reachable: UInt32;   { reachable time }
    nd_ra_retransmit: UInt32;  { retransmit timer }
    { could be followed by options }
  end;
  {$EXTERNALSYM nd_router_advert}
  Pnd_router_advert = ^nd_router_advert;

const
  ND_RA_FLAG_MANAGED       = $80;
  {$EXTERNALSYM ND_RA_FLAG_MANAGED}
  ND_RA_FLAG_OTHER         = $40;
  {$EXTERNALSYM ND_RA_FLAG_OTHER}
  ND_RA_FLAG_HOME_AGENT    = $20;
  {$EXTERNALSYM ND_RA_FLAG_HOME_AGENT}

type
  nd_neighbor_solicit = record    { neighbor solicitation }
    nd_ns_hdr: icmp6_hdr;
    nd_ns_target: in6_addr; { target address }
    { could be followed by options }
  end;
  {$EXTERNALSYM nd_neighbor_solicit}
  Pnd_neighbor_solicit = ^nd_neighbor_solicit;

  nd_neighbor_advert = record     { neighbor advertisement }
    nd_na_hdr: icmp6_hdr;
    nd_na_target: in6_addr; { target address }
    { could be followed by options }
  end;
  {$EXTERNALSYM nd_neighbor_advert}
  Pnd_neighbor_advert = ^nd_neighbor_advert;

const
  ND_NA_FLAG_ROUTER        = $00000080;
  {$EXTERNALSYM ND_NA_FLAG_ROUTER}
  ND_NA_FLAG_SOLICITED     = $00000040;
  {$EXTERNALSYM ND_NA_FLAG_SOLICITED}
  ND_NA_FLAG_OVERRIDE      = $00000020;
  {$EXTERNALSYM ND_NA_FLAG_OVERRIDE}

type
  nd_redirect = record            { redirect }
    nd_rd_hdr: icmp6_hdr;
    nd_rd_target: in6_addr; { target address }
    nd_rd_dst: in6_addr;    { destination address }
    { could be followed by options }
  end;
  {$EXTERNALSYM nd_redirect}
  Pnd_redirect = ^nd_redirect;

  nd_opt_hdr = record             { Neighbor discovery option header }
    nd_opt_type: UInt8;
    nd_opt_len: UInt8;        { in units of 8 octets }
    { followed by option specific data }
  end;
  {$EXTERNALSYM nd_opt_hdr}
  Pnd_opt_hdr = ^nd_opt_hdr;

const
  ND_OPT_SOURCE_LINKADDR       = 1;
  {$EXTERNALSYM ND_OPT_SOURCE_LINKADDR}
  ND_OPT_TARGET_LINKADDR       = 2;
  {$EXTERNALSYM ND_OPT_TARGET_LINKADDR}
  ND_OPT_PREFIX_INFORMATION    = 3;
  {$EXTERNALSYM ND_OPT_PREFIX_INFORMATION}
  ND_OPT_REDIRECTED_HEADER     = 4;
  {$EXTERNALSYM ND_OPT_REDIRECTED_HEADER}
  _ND_OPT_MTU                   = 5;  //renamed from ND_OPT_MTU
  {$EXTERNALSYM _ND_OPT_MTU}

type
  nd_opt_prefix_info = record     { prefix information }
    nd_opt_pi_type: UInt8;
    nd_opt_pi_len: UInt8;
    nd_opt_pi_prefix_len: UInt8;
    nd_opt_pi_flags_reserved: UInt8;
    nd_opt_pi_valid_time: UInt32;
    nd_opt_pi_preferred_time: UInt32;
    nd_opt_pi_reserved2: UInt32;
    nd_opt_pi_prefix: in6_addr;
  end;
  {$EXTERNALSYM nd_opt_prefix_info}
  Pnd_opt_prefix_info = ^nd_opt_prefix_info;

const
  ND_OPT_PI_FLAG_ONLINK        = $80;
  {$EXTERNALSYM ND_OPT_PI_FLAG_ONLINK}
  ND_OPT_PI_FLAG_AUTO          = $40;
  {$EXTERNALSYM ND_OPT_PI_FLAG_AUTO}

type
  nd_opt_rd_hdr = record          { redirected header }
    nd_opt_rh_type: UInt8;
    nd_opt_rh_len: UInt8;
    nd_opt_rh_reserved1: UInt16;
    nd_opt_rh_reserved2: UInt32;
    { followed by IP header and data }
  end;
  {$EXTERNALSYM nd_opt_rd_hdr}
  Pnd_opt_rd_hdr = ^nd_opt_rd_hdr;

  nd_opt_mtu = record             { MTU option }
    nd_opt_mtu_type: UInt8;
    nd_opt_mtu_len: UInt8;
    nd_opt_mtu_reserved: UInt16;
    nd_opt_mtu_mtu: UInt32;
  end;
  {$EXTERNALSYM nd_opt_mtu}
  Pnd_opt_mtu = ^nd_opt_mtu;

//TODO: Why isn't this mld_hdr?
  mld6_hdr = record
    mld6_icmp6_hdr: icmp6_hdr;
    mld6_addr: in6_addr;
  end;
  {$EXTERNALSYM mld6_hdr}
  Pmld6_hdr = ^mld6_hdr;

const
  ICMP6_ROUTER_RENUMBERING = 138;
  {$EXTERNALSYM ICMP6_ROUTER_RENUMBERING}

type
  icmp6_router_renum = record
    rr_hdr: icmp6_hdr;
    rr_segnum: UInt8;
    rr_flags: UInt8;
    rr_maxdelay: UInt16;
    rr_reserved: UInt32;
  end;
  {$EXTERNALSYM icmp6_router_renum}
  Picmp6_router_renum = ^icmp6_router_renum;

const
{ Router renumbering flags }
  ICMP6_RR_FLAGS_TEST             = $80;
  {$EXTERNALSYM ICMP6_RR_FLAGS_TEST}
  ICMP6_RR_FLAGS_REQRESULT        = $40;
  {$EXTERNALSYM ICMP6_RR_FLAGS_REQRESULT}
  ICMP6_RR_FLAGS_FORCEAPPLY       = $20;
  {$EXTERNALSYM ICMP6_RR_FLAGS_FORCEAPPLY}
  ICMP6_RR_FLAGS_SPECSITE         = $10;
  {$EXTERNALSYM ICMP6_RR_FLAGS_SPECSITE}
  ICMP6_RR_FLAGS_PREVDONE         = $08;
  {$EXTERNALSYM ICMP6_RR_FLAGS_PREVDONE}

type
  rr_pco_match = record   { match prefix part }
    rpm_code: UInt8;
    rpm_len: UInt8;
    rpm_ordinal: UInt8;
    rpm_matchlen: UInt8;
    rpm_minlen: UInt8;
    rpm_maxlen: UInt8;
    rpm_reserved: UInt16;
    rpm_prefix: in6_addr;
  end;
  {$EXTERNALSYM rr_pco_match}
  Prr_pco_match = ^rr_pco_match;

const
{ PCO code values }
  RPM_PCO_ADD             = 1;
  {$EXTERNALSYM RPM_PCO_ADD}
  RPM_PCO_CHANGE          = 2;
  {$EXTERNALSYM RPM_PCO_CHANGE}
  RPM_PCO_SETGLOBAL       = 3;
  {$EXTERNALSYM RPM_PCO_SETGLOBAL}

type
  rr_pco_use = record { use prefix part }
    rpu_uselen: UInt8;
    rpu_keeplen: UInt8;
    rpu_ramask: UInt8;
    rpu_raflags: UInt8;
    rpu_vltime: UInt32;
    rpu_pltime: UInt32;
    rpu_flags: UInt32;
    rpu_prefix: in6_addr;
  end;
  {$EXTERNALSYM rr_pco_use}
  Prr_pco_use = ^rr_pco_use;

const
  ICMP6_RR_PCOUSE_RAFLAGS_ONLINK  = $80;
  {$EXTERNALSYM ICMP6_RR_PCOUSE_RAFLAGS_ONLINK }
  ICMP6_RR_PCOUSE_RAFLAGS_AUTO    = $40;
  {$EXTERNALSYM ICMP6_RR_PCOUSE_RAFLAGS_AUTO   }
  ICMP6_RR_PCOUSE_FLAGS_DECRVLTIME = $80;
  {$EXTERNALSYM ICMP6_RR_PCOUSE_FLAGS_DECRVLTIME}
  ICMP6_RR_PCOUSE_FLAGS_DECRPLTIME = $40;
  {$EXTERNALSYM ICMP6_RR_PCOUSE_FLAGS_DECRPLTIME}

type
  rr_result = record
    rrr_flags: UInt16;
    rrr_ordinal: UInt8;
    rrr_matchedlen: UInt8;
    rrr_ifid: UInt32;
    rrr_prefix: in6_addr;
  end;
  {$EXTERNALSYM rr_result}
  Prr_result = ^rr_result;

const
  ICMP6_RR_RESULT_FLAGS_OOB       = $0200;
  {$EXTERNALSYM ICMP6_RR_RESULT_FLAGS_OOB      }
  ICMP6_RR_RESULT_FLAGS_FORBIDDEN = $0100;
  {$EXTERNALSYM ICMP6_RR_RESULT_FLAGS_FORBIDDEN}

type
{ Mobile IPv6 extension: Advertisement Interval.  }
  nd_opt_adv_interval = record
    nd_opt_adv_interval_type: UInt8;
    nd_opt_adv_interval_len: UInt8;
    nd_opt_adv_interval_reserved: UInt16;
    nd_opt_adv_interval_ival: UInt32;
  end;
  {$EXTERNALSYM nd_opt_adv_interval}
  Pnd_opt_adv_interval = ^nd_opt_adv_interval;
  {$EXTERNALSYM Pnd_opt_adv_interval}

{ Mobile IPv6 extension: Home Agent Info.  }
  nd_opt_home_agent_info = record
    nd_opt_home_agent_info_type: UInt8;
    nd_opt_home_agent_info_len: UInt8;
    nd_opt_home_agent_info_reserved: UInt16;
    nd_opt_home_agent_info_preference: Int16;
    nd_opt_home_agent_info_lifetime: UInt16;
  end;
  {$EXTERNALSYM nd_opt_home_agent_info}
  Pnd_opt_home_agent_info = ^nd_opt_home_agent_info;
  {$EXTERNALSYM Pnd_opt_home_agent_info}
