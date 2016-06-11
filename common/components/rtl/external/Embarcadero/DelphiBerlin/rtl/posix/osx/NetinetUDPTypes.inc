{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{udp.h}

type
// Udp protocol header.
// Per RFC 768, September, 1981.
  udphdr = record
    uh_sport: UInt16; //source port
    uh_dport: UInt16; //destination port
    uh_ulen : UInt16; //udp length
    uh_sum  : UInt16; //udp checksum
  end;
  {$EXTERNALSYM udphdr}

const
  {$EXTERNALSYM UDP_NOCKSUM}
  UDP_NOCKSUM = $01;   // don't checksum outbound payloads
{udp.h end}
