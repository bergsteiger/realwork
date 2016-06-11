{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{   Copyright and license exceptions noted in source    }
{                                                       }
{*******************************************************}

unit Posix.NetinetTCP;

{$WEAKPACKAGEUNIT}
{$HPPEMIT NOUSINGNAMESPACE}

interface

uses Posix.Base;

{$IFDEF MACOS}
{$I osx/NetinetTCPTypes.inc}
{$ELSEIF defined(LINUX)}
{$I linux/NetinetTCPTypes.inc}
{$ELSEIF defined(ANDROID)}
{$I android/NetinetTCPTypes.inc}
{$ENDIF}


{$IFDEF MACOS}
 function TCPOPT_CC_HDR(const ccopt : Integer): Integer; inline;
 {$EXTERNALSYM TCPOPT_CC_HDR}
{$ENDIF}
{$IFDEF ANDROID}
  function tcp_flag_word(tp: Ptcp_word_hdr): UInt32; inline;
 {$EXTERNALSYM tcp_flag_word}
{$ENDIF}

implementation

{$IFDEF MACOS}
function TCPOPT_CC_HDR(const ccopt : Integer) : Integer; inline;
begin
    Result := (TCPOPT_NOP shl 24) or
      (TCPOPT_NOP shl 16) or
      (ccopt shl 8) or
      TCPOLEN_CC;
end;
{$ENDIF}

{$IFDEF ANDROID}
  function tcp_flag_word(tp: Ptcp_word_hdr): UInt32; inline;
  begin
    Result := tp^.words[2];
  end;
{$ENDIF}
end.
