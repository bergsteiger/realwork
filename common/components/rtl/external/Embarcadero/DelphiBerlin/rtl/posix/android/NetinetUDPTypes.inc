{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

type
  u_int16_t = UInt16;
{$IFDEF __FAVOR_BSD}
  udphdr = record
    uh_sport: u_int16_t;	// source port
    uh_dport: u_int16_t;	// destination port
    uh_ulen : u_int16_t;	// udp length
    uh_sum  : u_int16_t;	// udp checksum
  end;
{$ELSE}
  udphdr = record
    source: UInt16;
    dest  : UInt16;
    len   : UInt16;
    check : UInt16;
  end;
{$ENDIF}
{$EXTERNALSYM udphdr}

