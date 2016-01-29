
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       Web server application components               }
{                                                       }
{       Copyright (c) 2001 Borland Software Corp.       }
{                                                       }
{*******************************************************}

unit DesignerDbgSite;

interface

uses SysUtils, Classes, HTTPApp, HTTPProd, DbgSiteAS, AscrLib, ActiveX, ActivDbgLib;

type

  TDesignerDebugScriptSite = class(TBaseDebugScriptSite)
  protected
    procedure HandleScriptError(const AErrorDebug: IActiveScriptErrorDebug;
      var AEnterDebugger: Boolean); override;
    function BreakOnFirstStatement: Boolean; override;
  end;

implementation

uses
  WebScript, Forms, Windows, SiteComp, WebScriptAS, Dialogs, Controls;

var
  SetBreak: Boolean = False;
  
{ TDesignerDebugScriptSite }

resourcestring
  sScriptErrorPrompt = 'A script error occured.  Do you want to debug?';
  sScriptError = 'Script Error';
  
function TDesignerDebugScriptSite.BreakOnFirstStatement: Boolean;
begin
  Result := SetBreak;
end;

procedure TDesignerDebugScriptSite.HandleScriptError(
  const AErrorDebug: IActiveScriptErrorDebug; var AEnterDebugger: Boolean);
begin
  inherited HandleScriptError(AErrorDebug, AEnterDebugger);
  AEnterDebugger := True;
  if SiteComp.InternetEnvOptions <> nil then
    if SiteComp.InternetEnvOptions.DisableDebugger then
      AEnterDebugger := False;
  if AEnterDebugger then
    AEnterDebugger := MessageDlg(sScriptErrorPrompt, mtError, [mbYes, mbNo], 0) = mrYes;
end;

type
  TScriptDebugger = class(TInterfacedObject, IInternetScriptDebugger)
  protected
    procedure DebugScript(AContext: IUnknown);
    function CanDebugScript(AContext: IUnknown): Boolean;
  end;

procedure TScriptDebugger.DebugScript(AContext: IUnknown);
begin
  SetBreak := True;
  try
    if SiteComp.ExecuteScript <> nil then
      SiteComp.ExecuteScript.ExecuteScript(AContext);
  finally
    SetBreak := False;
  end;
end;

function TScriptDebugger.CanDebugScript(AContext: IUnknown): Boolean;
begin
  Result := (SiteComp.ExecuteScript <> nil) and SiteComp.ExecuteScript.CanExecuteScript(AContext);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\DesignerDbgSite.pas initialization enter'); {$EndIf}
  ActiveScriptEngine.ScriptSiteClass := TDesignerDebugScriptSite;
  SiteComp.ScriptDebugger := TScriptDebugger.Create;
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\WebSnap\DesignerDbgSite.pas initialization leave'); {$EndIf}
finalization
  if (ActiveScriptEngine <> nil) and (ActiveScriptEngine.ScriptSiteClass = TDesignerDebugScriptSite) then
    ActiveScriptEngine.ScriptSiteClass := nil;
  Sitecomp.ScriptDebugger := nil;
end.
