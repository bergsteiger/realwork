{************************************************}
{                                                }
{   Turbo Vision Editor Demo                     }
{   Copyright (c) 1992 by Borland International  }
{                                                }
{   For Virtual Pascal v2.1 (c) 2000 vpascal.com }
{                                                }
{************************************************}
{$APPTYPE CONSOLE}
program TvApp;

{$X+,S-,H-}
{&Use32+}

uses Use32, W32SysLow, Objects, Drivers, Memory, Views, Menus, Dialogs,
  StdDlg, MsgBox, App;

type
  PEditorApp = ^TEditorApp;
  TEditorApp = object(TApplication)
  end;

var
  EditorApp: TEditorApp;

begin
  EditorApp.Init;
  EditorApp.Run;
  EditorApp.Done;
end.
