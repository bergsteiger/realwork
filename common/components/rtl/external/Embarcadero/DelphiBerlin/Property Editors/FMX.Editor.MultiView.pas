{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Editor.MultiView;

interface

uses
  DesignEditors, DesignMenus, FMX.MultiView, System.Classes, DesignIntf;

type

{ TMultiViewEditor }

  TMultiViewEditor = class(TComponentEditor)
  private const
    EditorShowHide = 0;
    EditorMode = 1;
  private
    FMultiView: TMultiView;
    function ModeToString(const AMode: TMultiViewMode): string;
    function DefineCurrentMode: string;
    procedure DoSetMode(Sender: TObject);
  public
    constructor Create(AComponent: TComponent; ADesigner: IDesigner); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
    procedure ExecuteVerb(Index: Integer); override;
    property MultiView: TMultiView read FMultiView;
  end;

implementation

uses
  FmxDsnConst, System.SysUtils, Vcl.Menus;

{ TMultiViewEditor }

constructor TMultiViewEditor.Create(AComponent: TComponent; ADesigner: IDesigner);
begin
  inherited;
  FMultiView := AComponent as TMultiView;
end;

function TMultiViewEditor.DefineCurrentMode: string;
begin
  if MultiView.HasPresenter then
    Result := MultiView.Presenter.DisplayName
  else
    Result := ModeToString(MultiView.Mode);
end;

procedure TMultiViewEditor.DoSetMode(Sender: TObject);
var
  MenuItem: TMenuItem;
  Mode: TMultiViewMode;
begin
  if Sender is Vcl.Menus.TMenuItem then
  begin
    MenuItem := Sender as Vcl.Menus.TMenuItem;
    if MenuItem.Tag >= 0 then
    begin
      Mode := TMultiViewMode(MenuItem.Tag);
      MultiView.Mode := Mode;
      Designer.Modified;
    end;
  end;
end;

procedure TMultiViewEditor.ExecuteVerb(Index: Integer);
begin
  inherited;
  if Index = EditorShowHide then
    if MultiView.IsShowed then
      MultiView.HideMaster
    else
      MultiView.ShowMaster;
end;

function TMultiViewEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    EditorMode:
      Result := Format(SMultiViewMode, [DefineCurrentMode]);
    EditorShowHide:
      if MultiView.IsShowed then
        Result := SMultiViewHide
      else
        Result := SMultiViewShow;
  else
    Result := string.Empty;
  end;
end;

function TMultiViewEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

function TMultiViewEditor.ModeToString(const AMode: TMultiViewMode): string;
begin
  case AMode of
    TMultiViewMode.PlatformBehaviour:
      Result := SMultiViewPlatformBehavior;
    TMultiViewMode.Panel:
      Result := SMultiViewPanel;
    TMultiViewMode.Popover:
      Result := SMultiViewlDropDown;
    TMultiViewMode.Drawer:
      Result := SMultiViewDrawer;
    TMultiViewMode.Custom:
      Result := SMultiViewCustom;
    TMultiViewMode.NavigationPane:
      Result := SMultiViewNavigationPane;
  end;
end;

procedure TMultiViewEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  Mode: TMultiViewMode;
  MenuItem: IMenuItem;
  Checked: Boolean;
begin
  inherited PrepareItem(Index, AItem);

  case Index of
    EditorShowHide:
      AItem.Enabled := MultiView.HasPresenter and MultiView.Presenter.CanShowHideInDesignTime;
    EditorMode:
      for Mode := Low(TMultiViewMode) to High(TMultiViewMode) do
      begin
        Checked := MultiView.Mode = Mode;
        MenuItem := AItem.AddItem(ModeToString(Mode), 0, Checked, True, DoSetMode);
        MenuItem.GroupIndex := 1;
        MenuItem.RadioItem := True;
        MenuItem.Checked := Checked;
                                                                                                        
        MenuItem.Tag := NativeInt(Mode);
        MenuItem := nil;
      end;
  end;
end;

end.
