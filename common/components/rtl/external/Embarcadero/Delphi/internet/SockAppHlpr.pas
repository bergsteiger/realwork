{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SockAppHlpr;

interface

procedure InitSockAppFactory(const ClassName: String);

implementation

uses SockApp;

procedure InitSockAppFactory(const ClassName: String);
begin
  TWebAppSockObjectFactory.Create(ClassName);
end;

end.




