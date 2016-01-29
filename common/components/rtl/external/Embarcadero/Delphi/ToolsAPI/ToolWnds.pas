{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit ToolWnds;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  DesignWindows, Vcl.ExtCtrls, Vcl.ToolWin, Vcl.ComCtrls, System.IniFiles, Vcl.ActnList, Vcl.Menus,
  Vcl.ActnPopup, System.Actions, Vcl.PlatformDefaultStyleActnCtrls;

type
  TToolbarDesignWindow = class(TDesignWindow)
    ToolBar1: TToolBar;
    Splitter1: TSplitter;
    PopupMenu1: TPopupActionBar;
    ActionList1: TActionList;
    ToolbarCmd: TAction;
    TextLabelsCmd: TAction;
    Toolbar2: TMenuItem;
    PopupMenu2: TPopupActionBar;
    TextLabels1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure ToolbarCmdExecute(Sender: TObject);
    procedure TextLabelsCmdExecute(Sender: TObject);
    procedure ToolbarCmdUpdate(Sender: TObject);
    procedure TextLabelsCmdUpdate(Sender: TObject);
  private
    FLargeButtons: Boolean;
    procedure SetLargeButtons(Value: Boolean);
    function GetToolbarVisible: boolean;
    procedure SetToolbarVisible(const Value: boolean);
    procedure UpdateToolbarVisible(Visible: boolean);
  protected
    procedure ResizeButtons(Large: Boolean); virtual;
  public
    property ToolbarVisible: boolean read GetToolbarVisible write SetToolbarVisible;
    property LargeButtons: Boolean read FLargeButtons write SetLargeButtons;
  end;

implementation

{$R *.dfm}

{
  Simple Intl fix to display longer captions on localized versions of the
  product.        
  InitFromResources is called in initialization section.
  See bug #105175
}

resourcestring
  sSmallToolbarSize = '30';
  sSmallButtonHeight = '22';
  sSmallButtonWidth = '23';
  sLargeToolbarSize = '44';
  sLargeButtonHeight = '36';
  sLargeButtonWidth = '56';

var
  SmallToolbarSize: Integer;
  SmallButtonHeight: Integer;
  SmallButtonWidth: Integer;
  LargeToolbarSize: Integer;
  LargeButtonHeight: Integer;
  LargeButtonWidth: Integer;

procedure InitFromResources;
begin
  SmallToolbarSize := StrToIntDef(sSmallToolbarSize, 30);
  SmallButtonHeight := StrToIntDef(sSmallButtonHeight, 22);
  SmallButtonWidth := StrToIntDef(sSmallButtonWidth, 23);
  LargeToolbarSize := StrToIntDef(sLargeToolbarSize, 44);
  LargeButtonHeight := StrToIntDef(sLargeButtonHeight, 36);
  LargeButtonWidth := StrToIntDef(sLargeButtonWidth, 56);
end;

procedure TToolbarDesignWindow.FormCreate(Sender: TObject);
begin
  { Toggle to force update }
  ResizeButtons(False);
  SmallToolbarSize := ToolBar1.Height;
  ResizeButtons(True);
  LargeToolbarSize := ToolBar1.Height;
  ResizeButtons(FLargeButtons);
  UpdateToolbarVisible(True);
end;

procedure TToolbarDesignWindow.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  with Toolbar1 do
    if (Height >= LargeToolbarSize) then
      if (NewSize <= SmallToolbarSize) then
        NewSize := SmallToolbarSize
      else
        NewSize := LargeToolbarSize
    else
      if(NewSize >= LargeToolbarSize) then
        NewSize := LargeToolbarSize
      else
        NewSize := SmallToolbarSize;
end;

procedure TToolbarDesignWindow.Splitter1Moved(Sender: TObject);
begin
  LargeButtons := (ToolBar1.Height >= LargeToolbarSize);
end;

function TToolbarDesignWindow.GetToolbarVisible: boolean;
begin
  Result := ToolBar1.Visible;
end;

procedure TToolbarDesignWindow.SetToolbarVisible(const Value: boolean);
begin
  if Value <> ToolbarVisible  then
    UpdateToolbarVisible(Value);
end;

procedure TToolbarDesignWindow.UpdateToolbarVisible(Visible: boolean);
begin
  DisableAlign;
  try
    ToolBar1.Visible := Visible;
    Splitter1.Top := Toolbar1.Top + Toolbar1.Height;
    Splitter1.Visible := Visible;
  finally
    EnableAlign;
  end;
end;

procedure TToolbarDesignWindow.ToolbarCmdExecute(Sender: TObject);
begin
  ToolbarVisible := not ToolbarVisible;
end;

procedure TToolbarDesignWindow.ToolbarCmdUpdate(Sender: TObject);
begin
  if Sender is TAction then
    TAction(Sender).Checked := ToolbarVisible;
end;


procedure TToolbarDesignWindow.SetLargeButtons(Value: Boolean);
begin
  if Value <> FLargeButtons then
  begin
    ResizeButtons(Value);
    FLargeButtons := Value;
  end;
end;

procedure TToolbarDesignWindow.ResizeButtons(Large: Boolean);
var
//  I: Integer;
  NewLargeWidth, NewLargeHeight: Integer;
begin
    with ToolBar1 do
    begin
      Perform(WM_SETREDRAW, 0, 0);
      try
        if Large then
        begin
          NewLargeWidth := MulDiv(LargeButtonWidth, PixelsPerInch, 96);
          NewLargeHeight := LargeButtonHeight + MulDiv(13{Height of text}, PixelsPerInch, 96) - 13;
              { Large buttons }
{
          for I := 0 to ButtonCount - 1 do
            if not (Buttons[I].Style in [tbsSeparator, tbsDivider]) then
              Buttons[I].AutoSize := True;
}
          ShowCaptions := True;
          ButtonWidth := NewLargeWidth;
          ButtonHeight := NewLargeHeight;
          //! Take into account large font systems
          Height := ButtonHeight + 8;//!LargeToolbarSize;
          ShowHint := False;
        end
        else
        begin
          { Small buttons }
{
          for I := 0 to ButtonCount - 1 do
            if not (Buttons[I].Style in [tbsSeparator, tbsDivider]) then
              Buttons[I].AutoSize := False;
}
          ShowCaptions := False;
          ButtonWidth := SmallButtonWidth;
          ButtonHeight := SmallButtonHeight;
          Height := SmallToolbarSize;
          ShowHint := True;
        end;
      finally
        Perform(WM_SETREDRAW, 1, 0);
        Invalidate;
      end;
    end;
end;

procedure TToolbarDesignWindow.TextLabelsCmdExecute(Sender: TObject);
begin
  LargeButtons := not LargeButtons;
end;

procedure TToolbarDesignWindow.TextLabelsCmdUpdate(Sender: TObject);
begin
  if Sender is TAction then
    TAction(Sender).Checked := LargeButtons;
end;

initialization
  InitFromResources;

end.
