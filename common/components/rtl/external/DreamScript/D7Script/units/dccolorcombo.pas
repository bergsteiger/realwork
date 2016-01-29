{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCColorCombo;

interface
{$I dc.inc}
uses
  Windows, Messages, Classes, Controls, StdCtrls, Graphics;

type
  TDCColorCombo = class(TCustomComboBox)
  private
    FSelectedColor, FCustomColor: TColor;
    FUseCustomColor: Boolean;
    procedure SetSelectedColor(Value: TColor);
    procedure SetCustomColor(Value: TColor);
    procedure SetUseCustomColor(Value: Boolean);
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure AddColor2Combo(const S: string);
    procedure AddCustomItem;
  protected
    procedure CreateHandle; override;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    procedure Change; override;
    property Items stored False;
    property Style default csOwnerDrawFixed;
  public
    constructor Create(AOwner: TComponent); override;
  published
    {$IFDEF D4}
    property Anchors;
    property BiDiMode;
    {$ENDIF}
    property Color;
    {$IFDEF D4}
    property Constraints;
    {$ENDIF}
    property Ctl3D;

    property CustomColor: TColor read FCustomColor write SetCustomColor
      default clBlack;

    property DragCursor;
    {$IFDEF D4}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    //property MaxLength;
    {$IFDEF D4}
    property ParentBiDiMode;
    {$ENDIF}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;

    property SelectedColor: TColor read FSelectedColor write SetSelectedColor
      default clBlack;
    property UseCustomColor: Boolean read FUseCustomColor write SetUseCustomColor;

    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    {$IFDEF D5}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    //property OnDrawItem;
    property OnDropDown;
    {$IFDEF D4}
    property OnEndDock;
    {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    //property OnMeasureItem;
    {$IFDEF D4}
    property OnStartDock;
    {$ENDIF}
    property OnStartDrag;
  end;

procedure Register;

implementation

uses dcConsts;

procedure Register;
begin
  RegisterComponents(SPalDreamEdit, [TDCColorCombo]);
end;

{********************************************************************}

constructor TDCColorCombo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := csOwnerDrawFixed;
  FSelectedColor := clBlack;
  FCustomColor := clBlack;
  FUseCustomColor := True;
end;

procedure TDCColorCombo.AddColor2Combo(const S: string);
var
  s2: string;
begin
  s2 := S;
  if Copy(s2, 1, 2) = 'cl' then
    Delete(s2, 1, 2);
  Items.AddObject(s2, TObject(StringToColor(S)));
end;

procedure TDCColorCombo.AddCustomItem;
begin
  Items.AddObject('Custom', TObject(FCustomColor));
end;

procedure TDCColorCombo.CreateHandle;
begin
  inherited;
  with Items do
  begin
    BeginUpdate;
    Clear;
    GetColorValues(AddColor2Combo);
    if FUseCustomColor then
      AddCustomItem;
    EndUpdate;
  end;
  ItemIndex := Items.IndexOfObject(TObject(FSelectedColor));
end;

procedure TDCColorCombo.SetSelectedColor(Value: TColor);
var
  Ident: string;
begin
  if Value <> FSelectedColor then
    if ColorToIdent(Value, Ident) then
    begin
      FSelectedColor := Value;
      ItemIndex := Items.IndexOfObject(TObject(FSelectedColor));
    end
    else if FUseCustomColor then
      SetCustomColor(Value)
    else
    begin
      FSelectedColor := TColor(-1);
      ItemIndex := -1;
    end;
end;

procedure TDCColorCombo.SetCustomColor(Value: TColor);
begin
  FCustomColor := Value;
  if FUseCustomColor then
  begin
    FSelectedColor := FCustomColor;
    with Items do
    begin
      Objects[Count - 1] := TObject(FCustomColor);
      ItemIndex := -1;
      ItemIndex := Count - 1;
    end;
    Change;
  end;
end;

procedure TDCColorCombo.SetUseCustomColor(Value: Boolean);
begin
  if FUseCustomColor <> Value then
  begin
    FUseCustomColor := Value;
    if FUseCustomColor then
      AddCustomItem
    else
    begin
      with Items do
        Delete(Count - 1);
      if ItemIndex < 0 then
        ItemIndex := 0;
    end;
  end;
end;

procedure TDCColorCombo.Change;
begin
  Perform(CM_CHANGED, 0, Longint(Self));
  FSelectedColor := TColor(SendMessage(Handle, CB_GETITEMDATA, ItemIndex, 0));
  if Assigned(OnChange) then OnChange(Self);
end;

const
  ColorRectWidth = 30;

procedure TDCColorCombo.CNDrawItem(var Message: TWMDrawItem);
begin
  with Message.DrawItemStruct^ do
    rcItem.Left := rcItem.Left + ColorRectWidth + 2;
  inherited;
end;

procedure TDCColorCombo.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  BColor: TColor;
  r: TRect;
begin
  if Index < Items.Count then
  begin
    BColor := Canvas.Brush.Color;
    Canvas.Brush.Color := TColor(SendMessage(Handle, CB_GETITEMDATA, Index, 0));
    with Rect do
      r := Classes.Rect(Left - ColorRectWidth, Top + 1, Left - 2, Bottom - 1);
    with r do
      Canvas.Rectangle(Left, Top, Right, Bottom);
    InflateRect(r, -1, -1);
    Canvas.FillRect(r);
    Canvas.Brush.Color := BColor;
  end;
  inherited;
end;

end.

