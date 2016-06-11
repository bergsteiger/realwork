{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit IPRegister;

interface

uses
  Classes;

procedure Register;

implementation

uses
  DesignIntf,
  IPPeerServer,
  IPPeerClient;

procedure Register;
begin
  //This forces the package to load at startup to allow IndyPeerImpl to be injected for designer support
  ForceDemandLoadState(dlDisable);
end;
  
end.
