{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

program serverinfo;

{$APPTYPE GUI}

uses
  Vcl.Forms,
  SockApp,
  SvrInfoConsole in 'SvrInfoConsole.pas' {Form1},
  SvrInfoModule in 'SvrInfoModule.pas' {WebModule2: TWebModule},
  SvrInfoConst in 'SvrInfoConst.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
