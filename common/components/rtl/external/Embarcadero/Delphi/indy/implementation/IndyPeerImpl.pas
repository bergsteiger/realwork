{*******************************************************}
{                                                       }
{              Delphi Indy Implementation               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "IndyPeerImpl"'}    {Do not Localize}
{$IFDEF MACOS}
  (*$HPPEMIT '#if defined(__APPLE__) && !defined(_NO_PRAGMA_LINK_INDY)' *)
  (*$HPPEMIT ' #ifndef USEPACKAGES' *)
  (*$HPPEMIT '  #pragma link "IndyCore.a"' *)
  (*$HPPEMIT '  #pragma link "IndyProtocols.a"' *)
  (*$HPPEMIT '  #pragma link "IndySystem.a"' *)
  (*$HPPEMIT ' #else' *)
  (*$HPPEMIT '  #pragma link "IndyCore.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndyProtocols.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndySystem.bpi"' *)
  (*$HPPEMIT ' #endif' *)
  (*$HPPEMIT '#endif' *)
{$ELSE} //Win32, Win64
  (*$HPPEMIT '#if !defined(_NO_PRAGMA_LINK_INDY)' *)
  (*$HPPEMIT ' #ifndef USEPACKAGES' *) //static
  {$IFDEF WIN64}
    (*$HPPEMIT '  #pragma link "IndyCore.a"' *)
    (*$HPPEMIT '  #pragma link "IndyProtocols.a"' *)
    (*$HPPEMIT '  #pragma link "IndySystem.a"' *)
  {$ELSE}
    (*$HPPEMIT '  #pragma link "IndyCore.lib"' *)
    (*$HPPEMIT '  #pragma link "IndyProtocols.lib"' *)
    (*$HPPEMIT '  #pragma link "IndySystem.lib"' *)
  {$ENDIF}
  (*$HPPEMIT ' #else' *)
  (*$HPPEMIT '  #pragma link "IndyCore.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndyProtocols.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndySystem.bpi"' *)
  (*$HPPEMIT ' #endif' *)
  (*$HPPEMIT '#endif' *) 
{$ENDIF}

unit IndyPeerImpl;

interface

uses
  IPPeerClient;

function IPImpId: string;

implementation

function IPImpId: string;
begin
  Result := IPPeerClient.IPImpId;
end;

end.
