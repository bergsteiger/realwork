{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

// NOTE: Starting with XE8, this unit is no longer required to support HTTPS connections.
unit REST.OpenSSL;

interface

{$IF defined(IOS) and not defined(CPUARM)}
{$DEFINE MAC_OR_SIMULATOR}
{$IFEND}

{$IFDEF MAC_OR_SIMULATOR}
uses
  IdSSLOpenSSLHeaders;       // IdOpenSSLSetLibPath
{$ELSE}
{$IFDEF IOS}
uses
  IdSSLOpenSSLHeaders_Static; // Static link openssl
{$ENDIF}
{$ENDIF}

{$IFDEF MAC_OR_SIMULATOR}
procedure SetMacSSLPath(AValue: string);
{$ENDIF}

implementation

{$IFDEF MAC_OR_SIMULATOR}
procedure SetMacSSLPath(AValue: string);
begin
  IdOpenSSLSetLibPath(AValue); // do not localize
end;
{$ENDIF}

initialization

{$IFDEF MAC_OR_SIMULATOR}
// default library path on Mac OSX
IdOpenSSLSetLibPath('/usr/lib'); // do not localize
{$ENDIF}

end.
