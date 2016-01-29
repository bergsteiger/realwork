{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

// This version of ComApp.pas is used with Delphi6 built WebAppDebugger executables.  It
// allows them to work with a new version of the WebAppDebugger without changing any
// source code.  The new version of the WebAppDebugger uses sockets rather
// than COM for interprocess communication between the WebAppDebugger and WebAppDebugger
// executables.

unit ComApp;

interface

uses
  SockApp;

type

  TWebAppAutoObjectFactory = class(TWebAppSockObjectFactory)
  public
    constructor Create(AClassID: TGuid; const AClassName, ADescription: string);
  end;

implementation

{ TWebAppAutoObjectFactory }

constructor TWebAppAutoObjectFactory.Create(AClassID: TGuid;
  const AClassName, ADescription: string);
begin
  inherited Create(AClassName);
end;

end.
