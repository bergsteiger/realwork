{***************************************************************}
{                                                               }
{   Borland Delphi Visual Component Library                     }
{                                                               }
{   Copyright (c) 2000-2001 Borland Software Corporation        }
{                                                               }
{***************************************************************}
unit SvrInfoConsole;

interface

uses
  SysUtils, Classes, QForms;

type
  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses SockApp;

{$R *.xfm}

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\SvrInfoConsole.pas initialization enter'); {$EndIf}
  TWebAppSockObjectFactory.Create('ServerInfo');

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\SvrInfoConsole.pas initialization leave'); {$EndIf}
end.
