{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

unit ColnProp;

interface

uses Windows,
  Classes, Forms, Controls, SysUtils,
{$ifdef VCL_6_USED}
  DesignIntf, DesignEditors, DesignWindows, DsnConst,
{$else}
  DsgnIntf,
{$endif}
  ColnEdit, ElStatBar, ElSideBar;

type
  TElStatusBarEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount: integer; override;
  end;

  TElSideBarEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: integer); override;
    function GetVerb(Index: integer): string; override;
    function GetVerbCount: integer; override;
  end;

implementation

procedure TElStatusBarEditor.ExecuteVerb(Index: integer);
begin
  if Index = 0 then
  begin
    ShowCollectionEditor(Self.Designer, Component, (Component as TElStatusBar).Panels, 'Panels');
  end;
end;

function TElStatusBarEditor.GetVerb(Index: integer): string;
begin
  if Index = 0 then result := 'Status Panels ...';
end;

function TElStatusBarEditor.GetVerbCount: integer;
begin
  result := 1;
end;

procedure TElSideBarEditor.ExecuteVerb(Index: integer);
begin
  if Index = 0 then
  begin
    ShowCollectionEditor(Self.Designer, Component, (Component as TElSideBar).Sections, 'Sections');
  end;
end;

function TElSideBarEditor.GetVerb(Index: integer): string;
begin
  if Index = 0 then
     result := 'Sidebar Sections ...'
end;

function TElSideBarEditor.GetVerbCount: integer;
begin
  result := 1;
end;

end.
