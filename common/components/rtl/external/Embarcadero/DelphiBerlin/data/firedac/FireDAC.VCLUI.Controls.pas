{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC GUIx Forms custom controls           }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.VCLUI.Controls;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows, Winapi.Messages,
{$ENDIF}
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls,
    System.SysUtils, Vcl.StdCtrls, Vcl.Buttons, System.IniFiles, Vcl.Dialogs,
  FireDAC.Stan.Intf;

type
  TFDGUIxFormsPanelTree = class;
  TFDGUIxFormsDblListBox = class;

  {----------------------------------------------------------------------------}
  { TFDGUIxFormsPanelTree                                                      }
  {----------------------------------------------------------------------------}
  TFDGUIxFormsPanelTree = class(TScrollBox)
  private
    FPanels: TList;
    FLock: Boolean;
    procedure CMControlChange(var Message: TMessage); message CM_CONTROLCHANGE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure ChangeAllState(AExpand: Boolean);
  protected
    procedure Loaded; override;
{$IFDEF MSWINDOWS}
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint): Boolean; override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadState(const ASection: String; AIni: TCustomIniFile);
    procedure SaveState(const ASection: String; AIni: TCustomIniFile);
  published
    property BevelOuter;
  end;

  {----------------------------------------------------------------------------}
  { TFDGUIxFormsDblListBox                                                     }
  {----------------------------------------------------------------------------}
  TFDGUIxFormsDblListBox = class(TCustomPanel)
  private
    procedure IncludeBtnClick(Sender: TObject);
    procedure ExcludeBtnClick(Sender: TObject);
    procedure IncAllBtnClick(Sender: TObject);
    procedure ExcAllBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure UpBtnClick(Sender: TObject);
    procedure MoveSelected(List: TCustomListBox; Items: TStrings);
    procedure SetItem(List: TListBox; Index: Integer);
    function GetFirstSelection(List: TCustomListBox): Integer;
    procedure ListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure SetS(AIndex: Integer; const AValue: String);
    function GetS(AIndex: Integer): String;
    procedure SetItems(AIndex: Integer; AValues: TStrings);
    function GetItems(AIndex: Integer): TStrings;
    function GetEvent(AIndex: Integer): TNotifyEvent;
    procedure SetEvent(AIndex: Integer; AValue: TNotifyEvent);
    procedure SetI(AIndex: Integer; AValue: Integer);
    function GetI(AIndex: Integer): Integer;
    procedure SetB(AIndex: Integer; AValue: Boolean);
    function GetB(AIndex: Integer): Boolean;
    procedure ListKeys(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListClick(Sender: TObject);
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
  public
    DstLabel: TLabel;
    SrcLabel: TLabel;
    SrcList: TListBox;
    IncludeBtn: TSpeedButton;
    IncAllBtn: TSpeedButton;
    ExcludeBtn: TSpeedButton;
    ExAllBtn: TSpeedButton;
    UpBtn: TSpeedButton;
    DownBtn: TSpeedButton;
    DstList: TListBox;
    constructor Create(AOwner: TComponent); override;
    procedure SetButtons;
    property SrcItemIndex: Integer index 0 read GetI write SetI;
    property DstItemIndex: Integer index 1 read GetI write SetI;
  published
    property DestCaption: String index 0 read GetS write SetS;
    property SrcCaption: String index 1 read GetS write SetS;
    property DestListHint: String index 2 read GetS write SetS;
    property SrcListHint: String index 3 read GetS write SetS;
    property IncHint: String index 4 read GetS write SetS;
    property IncAllHint: String index 5 read GetS write SetS;
    property ExHint: String index 6 read GetS write SetS;
    property ExAllHint: String index 7 read GetS write SetS;
    property UpHint: String index 8 read GetS write SetS;
    property DownHint: String index 9 read GetS write SetS;
    property SrcItems: TStrings index 0 read GetItems write SetItems;
    property DstItems: TStrings index 1 read GetItems write SetItems;
    property SrcItemsSorted: Boolean index 0 read GetB write SetB default True;
    property OnSrcClick: TNotifyEvent index 0 read GetEvent write SetEvent;
    property OnDstClick: TNotifyEvent index 1 read GetEvent write SetEvent;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelKind;
    property BevelOuter;
    property BevelInner;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property DragCursor;
    property Enabled;
    property Color;
    property Font;
    property Ctl3D;
    property ParentCtl3D;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnResize;
  end;

function FDGUIxSetupEditor(ACombo: TComboBox; AEdit: TEdit;
  AFileEdt: TCustomEdit; AOpenDlg: TOpenDialog; const AType: String): Integer;
procedure FDGUIxCancel;
function FDGUIxBeginModal(AForm: TCustomForm; ASaveActive: Boolean = True): Pointer;
procedure FDGUIxEndModal(var AData: Pointer);

implementation

uses
  System.Types, System.UITypes,
  FireDAC.Stan.Consts, FireDAC.Stan.Util;

{$R FireDAC.VCLUI.PanelTreeButton.res}

const
  CPlusBitmap = 'FDPLUS';
  CMinusBitmap = 'FDMINUS';
  CHorizSpace0 = 7;
  CHorizSpace1 = 5;
  CButtonWidth = 11;
  CHorizSpace2 = 10;
  CVertSpace0 = 3;
  CButtonHeight = CButtonWidth;
  CMountMinHeight = 20;

{ --------------------------------------------------------------------------- }
{ TFDGUIxFormsPanelTreeItem                                                   }
{ --------------------------------------------------------------------------- }
type
  TFDGUIxFormsPanelTreeItem = class(TObject)
  private
    FTree: TFDGUIxFormsPanelTree;
    FPanel: TPanel;
    FParent: TFrame;
    FMount: TPanel;
    FLbl: TLabel;
    FImg: TImage;
    FShp: TShape;
    FExpanded: Boolean;
    procedure BuildGroup;
    procedure BuildPanelMount;
    procedure DoExpandClicked(ASender: TObject);
    procedure DoPanelEnter(ASender: TObject);
    procedure DoPanelExit(ASender: TObject);
    procedure DoBtnEnter(ASender: TObject);
    procedure DoBtnExit(ASender: TObject);
    procedure DoBtnKeyPressed(ASender: TObject; var AKey: Char);
    procedure ChangeState(AExpand: Boolean);
  protected
    procedure Build;
  public
    constructor Create(APanel: TCustomPanel; AFrame: TCustomFrame;
      ATree: TFDGUIxFormsPanelTree);
    destructor Destroy; override;
  end;

{ --------------------------------------------------------------------------- }
constructor TFDGUIxFormsPanelTreeItem.Create(APanel: TCustomPanel;
  AFrame: TCustomFrame; ATree: TFDGUIxFormsPanelTree);
begin
  inherited Create;
  FTree := ATree;
  FParent := TFrame(AFrame);
  FPanel := TPanel(APanel);
  if not (csLoading in ATree.ComponentState) then
    Build;
end;

{ --------------------------------------------------------------------------- }
destructor TFDGUIxFormsPanelTreeItem.Destroy;
begin
  if (FPanel <> nil) and not (csDestroying in FPanel.ComponentState) then begin
    FPanel.Enabled := True;
    FPanel.Visible := False;
  end;
  if FParent <> nil then begin
    FParent.Hint := FLbl.Caption;
    if FPanel <> nil then
      FPanel.Parent := FParent;
  end
  else if (FTree <> nil) and (FPanel <> nil) then begin
    FPanel.Caption := FLbl.Caption;
    FPanel.Parent := FTree;
  end;
  FDFreeAndNil(FMount);
  FTree := nil;
  FPanel := nil;
  FParent := nil;
  FLbl := nil;
  FImg := nil;
  FShp := nil;
  inherited Destroy;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.Build;
begin
  FTree.FLock := True;
  try
    if FPanel <> nil then
      BuildPanelMount
    else if FParent <> nil then
      BuildGroup;
  finally
    FTree.FLock := False;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.BuildGroup;
begin
  FMount := TPanel.Create(FTree);
  FMount.Visible := False;
  FMount.Parent := FTree;
  FMount.Height := CMountMinHeight;
  FMount.Align := alTop;
  FMount.ParentColor := True;
  FMount.BevelInner := bvNone;
  FMount.BevelOuter := bvNone;

  FLbl := TLabel.Create(FMount);
  FLbl.Parent := FMount;
  FLbl.AutoSize := False;
  FLbl.SetBounds(CHorizSpace0 + CHorizSpace1, CVertSpace0,
    FMount.ClientWidth - (CHorizSpace0 + CHorizSpace1), CMountMinHeight);
  FLbl.Caption := FParent.Hint;
  FParent.Hint := '';
  FLbl.Font.Style := FLbl.Font.Style + [fsBold];
  FLbl.Anchors := [akTop, akLeft, akRight];
  FParent.Visible := False;

  FMount.Visible := True;
end;

type
  __TWinControl = class(TWinControl);

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.BuildPanelMount;
var
  oPnl: TPanel;
begin
  FMount := TPanel.Create(FTree);
  FMount.Visible := False;
  FMount.Parent := FTree;
  FMount.BevelInner := bvNone;
  FMount.BevelOuter := bvNone;
  FMount.Height := CMountMinHeight;
  FMount.Align := alTop;
  FMount.ParentColor := True;
  FMount.OnEnter := DoPanelEnter;
  FMount.OnExit := DoPanelExit;

  oPnl := TPanel.Create(FMount);
  oPnl.Parent := FMount;
  oPnl.BevelInner := bvNone;
  oPnl.BevelOuter := bvNone;
  oPnl.SetBounds(CHorizSpace0, 2, CHorizSpace1 + CButtonWidth + CHorizSpace1,
    CVertSpace0 + CButtonHeight + CVertSpace0);
  oPnl.Anchors := [akTop, akLeft];
  oPnl.TabStop := True;
  oPnl.ParentColor := True;
  oPnl.OnEnter := DoBtnEnter;
  oPnl.OnExit := DoBtnExit;
  __TWinControl(oPnl).OnKeyPress := DoBtnKeyPressed;

  FShp := TShape.Create(oPnl);
  FShp.Parent := oPnl;
  FShp.Align := alClient;
  FShp.Shape := stRoundRect;
  FShp.Brush.Style := bsClear;
  FShp.Pen.Style := psDot;
  FShp.Visible := False;

  FImg := TImage.Create(oPnl);
  FImg.Parent := oPnl;
  FImg.SetBounds(CHorizSpace1, CVertSpace0, CButtonWidth, CButtonHeight);
  FImg.OnClick := DoExpandClicked;
  FImg.Picture.Bitmap.LoadFromResourceName(HInstance, CPlusBitmap);

  FLbl := TLabel.Create(FMount);
  FLbl.Parent := FMount;
  FLbl.AutoSize := False;
  FLbl.SetBounds(CHorizSpace0 + CHorizSpace1 + CButtonWidth + CHorizSpace0 + CHorizSpace1,
    CVertSpace0, FMount.ClientWidth - (CHorizSpace0 + CHorizSpace1 + CButtonWidth +
    CHorizSpace0 + CHorizSpace1), CMountMinHeight);
  FLbl.Caption := FPanel.Caption;
  FPanel.Caption := '';
  FLbl.Font.Style := FLbl.Font.Style + [fsBold];
  FLbl.Anchors := [akTop, akLeft, akRight];

  FPanel.Parent := FMount;
  FPanel.BevelInner := bvNone;
  FPanel.BevelOuter := bvNone;
  FPanel.Anchors := [akTop, akLeft, akRight];
  FPanel.SetBounds(
    FLbl.Left, FLbl.Top + FLbl.Height,
    FPanel.Width, FPanel.Height);
  FPanel.Enabled := False;
  FPanel.Visible := False;

  FMount.Visible := True;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.ChangeState(AExpand: Boolean);
begin
  if (FExpanded = AExpand) or (FPanel = nil) then
    Exit;
  FExpanded := AExpand;
  if FExpanded then begin
    FPanel.Visible := True;
    FPanel.Enabled := True;
    FMount.Height := FMount.Height + FPanel.Height + 3;
    FImg.Picture.Bitmap.LoadFromResourceName(HInstance, CMinusBitmap);
  end
  else begin
    FPanel.Visible := False;
    FPanel.Enabled := False;
    FMount.Height := FMount.Height - FPanel.Height - 3;
    FImg.Picture.Bitmap.LoadFromResourceName(HInstance, CPlusBitmap);
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.DoExpandClicked(ASender: TObject);
begin
  ChangeState(not FExpanded);
  FImg.Parent.SetFocus;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.DoPanelEnter(ASender: TObject);
begin
  FLbl.Font.Color := clHotLight;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.DoPanelExit(ASender: TObject);
begin
  FLbl.Font.Color := clWindowText;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.DoBtnEnter(ASender: TObject);
begin
  FShp.Visible := True;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.DoBtnExit(ASender: TObject);
begin
  FShp.Visible := False;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTreeItem.DoBtnKeyPressed(ASender: TObject; var AKey: Char);
begin
  if (AKey = ' ') or
     (AKey = '+') and not FExpanded or
     (AKey = '-') and FExpanded then begin
    DoExpandClicked(nil);
    AKey := #0;
  end
  else if AKey = '*' then begin
    FTree.ChangeAllState(True);
    AKey := #0;
  end
  else if AKey = '/' then begin
    FTree.ChangeAllState(False);
    AKey := #0;
  end;
end;

{ --------------------------------------------------------------------------- }
{ TFDGUIxFormsPanelTree                                                       }
{ --------------------------------------------------------------------------- }
constructor TFDGUIxFormsPanelTree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPanels := TList.Create;
  Caption := '';
  VertScrollBar.Style := ssFlat;
  HorzScrollBar.Style := ssFlat;
  VertScrollBar.Tracking := True;
  VertScrollBar.Smooth := False;
  HorzScrollBar.Tracking := True;
  HorzScrollBar.Smooth := False;
end;

{ --------------------------------------------------------------------------- }
destructor TFDGUIxFormsPanelTree.Destroy;
var
  i: Integer;
  oItem: TFDGUIxFormsPanelTreeItem;
begin
  for i := 0 to FPanels.Count - 1 do begin
    oItem := TFDGUIxFormsPanelTreeItem(FPanels[i]);
    oItem.FParent := nil;
    oItem.FTree := nil;
    FDFree(oItem);
  end;
  FDFreeAndNil(FPanels);
  inherited Destroy;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTree.Loaded;
var
  i: Integer;
begin
  inherited Loaded;
  DisableAlign;
  try
    for i := 0 to FPanels.Count - 1 do
      TFDGUIxFormsPanelTreeItem(FPanels[i]).Build;
  finally
    EnableAlign;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTree.CMControlChange(var Message: TMessage);
var
  i: Integer;
  oCtrl, oCtrl2: TControl;
  lInserted: Boolean;
begin
  inherited;
  oCtrl := TControl(Message.WParam);
  lInserted := Boolean(Message.LParam);

  if (csDesigning in ComponentState) or FLock or
     (oCtrl.Parent <> Self) then
    Exit;

  if oCtrl is TCustomPanel then begin
    if lInserted then
      FPanels.Add(TFDGUIxFormsPanelTreeItem.Create(TCustomPanel(oCtrl), nil, Self))
    else
      for i := 0 to FPanels.Count - 1 do
        if TFDGUIxFormsPanelTreeItem(FPanels[i]).FPanel = oCtrl then begin
          FDFree(TFDGUIxFormsPanelTreeItem(FPanels[i]));
          FPanels.Delete(i);
          Break;
        end;
  end
  else if oCtrl is TCustomFrame then begin
    if lInserted then begin
      FPanels.Add(TFDGUIxFormsPanelTreeItem.Create(nil, TCustomFrame(oCtrl), Self));
      for i := 0 to TCustomFrame(oCtrl).ControlCount - 1 do begin
        oCtrl2 := TCustomFrame(oCtrl).Controls[i];
        if oCtrl2 is TCustomPanel then
          FPanels.Add(TFDGUIxFormsPanelTreeItem.Create(TCustomPanel(oCtrl2), TCustomFrame(oCtrl), Self));
      end;
    end
    else begin
      i := 0;
      while i <= FPanels.Count - 1 do
        if TFDGUIxFormsPanelTreeItem(FPanels[i]).FParent = oCtrl then begin
          FDFree(TFDGUIxFormsPanelTreeItem(FPanels[i]));
          FPanels.Delete(i);
        end
        else
          Inc(i);
    end;
  end;
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTree.CMEnabledChanged(var Message: TMessage);
var
  i: Integer;
  oLbl: TLabel;
begin
  inherited;
  for i := 0 to FPanels.Count - 1 do begin
    oLbl := TFDGUIxFormsPanelTreeItem(FPanels[i]).FLbl;
    if not Enabled then
      oLbl.Font.Color := clGray
    else
      oLbl.Font.Color := clWindowText;
  end;
end;

{ --------------------------------------------------------------------------- }
{$IFDEF MSWINDOWS}
function TFDGUIxFormsPanelTree.DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
  MousePos: TPoint): Boolean;
var
  iMsg, iCode: Cardinal;
begin
  Result := inherited DoMouseWheel(Shift, WheelDelta, MousePos);
  if FLock then
    Exit;
  if ssShift in Shift then
    iMsg := WM_HSCROLL
  else
    iMsg := WM_VSCROLL;
  if WheelDelta < 0 Then
    iCode := SB_LINEDOWN
  else
    iCode := SB_LINEUP;
  Perform(iMsg, iCode, 0);
  Perform(iMsg, SB_ENDSCROLL, 0);
end;
{$ENDIF}

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTree.ChangeAllState(AExpand: Boolean);
var
  i: Integer;
begin
  for i := 0 to FPanels.Count - 1 do
    TFDGUIxFormsPanelTreeItem(FPanels[i]).ChangeState(AExpand);
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTree.LoadState(const ASection: String; AIni: TCustomIniFile);
var
  i: Integer;
  s: String;
begin
  s := AIni.ReadString(ASection, Name, '');
  for i := 1 to Length(s) do
    TFDGUIxFormsPanelTreeItem(FPanels[i - 1]).ChangeState(s[i] = 'X');
end;

{ --------------------------------------------------------------------------- }
procedure TFDGUIxFormsPanelTree.SaveState(const ASection: String; AIni: TCustomIniFile);
var
  i: Integer;
  s: String;
begin
  SetLength(s, FPanels.Count);
  for i := 1 to FPanels.Count do
    if TFDGUIxFormsPanelTreeItem(FPanels[i - 1]).FExpanded then
      s[i] := 'X'
    else
      s[i] := ' ';
  AIni.WriteString(ASection, Name, s);
end;

{ --------------------------------------------------------------------------- }
{ --------------------------------------------------------------------------- }
type
  TFDGUIxFormsListViewItemType = (itString, itInteger, itFloat, itSet);
  TFDGUIxFormsListViewItemInfo = class(TObject)
  private
    FType: TFDGUIxFormsListViewItemType;
    FList: TStrings;
    FValue: string;
    FIndex: Integer;
    procedure SetValue(const AValue: string);
  public
    constructor Create(const AValue: string); overload;
    constructor Create(const AValue: Boolean); overload;
    constructor Create(const AValue: Integer); overload;
    constructor Create(const AValue: Double); overload;
    constructor Create(const AValues: TStrings; AIndex: Integer); overload;
    destructor Destroy; override;
    property Value: string read FValue write SetValue;
    property Values: TStrings read FList;
    property Index: Integer read FIndex;
  end;

{------------------------------------------------------------------------------}
{ TFDGUIxFormsListViewItemInfo                                                 }
{------------------------------------------------------------------------------}
constructor TFDGUIxFormsListViewItemInfo.Create(const AValue: string);
begin
  inherited Create;
  FType := itString;
  FValue := AValue;
  FIndex := -1;
end;

{------------------------------------------------------------------------------}
constructor TFDGUIxFormsListViewItemInfo.Create(const AValue: Boolean);
begin
  inherited Create;
  FType := itSet;
  FList := TFDStringList.Create;
  FList.Add(S_FD_True);
  FList.Add(S_FD_False);
  FValue := S_FD_Bools[AValue];
  if AValue then
    FIndex := 0
  else
    FIndex := 1;
end;

{------------------------------------------------------------------------------}
constructor TFDGUIxFormsListViewItemInfo.Create(const AValue: Integer);
begin
  inherited Create;
  FType := itInteger;
  FValue := IntToStr(AValue);
  FIndex := -1;
end;

{------------------------------------------------------------------------------}
constructor TFDGUIxFormsListViewItemInfo.Create(const AValue: Double);
begin
  inherited Create;
  FType := itFloat;
  FValue := FDFloat2Str(AValue, FormatSettings.DecimalSeparator);
  FIndex := -1;
end;

{------------------------------------------------------------------------------}
constructor TFDGUIxFormsListViewItemInfo.Create(const AValues: TStrings; AIndex: Integer);
begin
  inherited Create;
  FType := itSet;
  FList := TFDStringList.Create;
  FList.AddStrings(AValues);
  FIndex := AIndex;
  if FIndex <> -1 then
    FValue := FList[FIndex];
end;

{------------------------------------------------------------------------------}
destructor TFDGUIxFormsListViewItemInfo.Destroy;
begin
  FDFreeAndNil(FList);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsListViewItemInfo.SetValue(const AValue: string);
var
  i: Integer;
begin
  if FValue <> AValue then
    case FType of
    itInteger:
      begin
        StrToInt(AValue);
        FValue := AValue;
      end;
    itFloat:
      begin
        FDStr2Float(AValue, FormatSettings.DecimalSeparator);
        FValue := AValue;
      end;
    itSet:
      begin
        i := FList.IndexOf(AValue);
        if i <> -1 then begin
          FIndex := i;
          FValue := AValue;
        end;
      end;
    else
      FValue := AValue;
    end;
end;

{------------------------------------------------------------------------------}
{ TFDGUIxFormsDblListBox                                                       }
{------------------------------------------------------------------------------}
constructor TFDGUIxFormsDblListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Top := 0;
  Left := 0;
  Width := 422;
  Height := 270;
  BevelOuter := bvNone;
  ControlStyle := ControlStyle - [csSetCaption];
  Caption := '';
  DstLabel := TLabel.Create(Self);
  DstLabel.Width := 145;
  DstLabel.Height := 16;
  DstLabel.AutoSize := False;
  DstLabel.Caption := '&Included fields:';
  DstLabel.Parent := Self;

  SrcLabel := TLabel.Create(Self);
  SrcLabel.Width := 145;
  SrcLabel.Height := 16;
  SrcLabel.AutoSize := False;
  SrcLabel.Caption := '&Source fields:';
  SrcLabel.Parent := Self;

  SrcList := TListBox.Create(Self);
  SrcList.Hint := 'A list of accessible source fields';
  SrcList.DragMode := dmAutomatic;
  SrcList.MultiSelect := True;
  SrcList.Sorted := True;
  SrcList.TabOrder := 0;
  SrcList.OnDragDrop := ListDragDrop;
  SrcList.OnDragOver := ListDragOver;
  SrcList.OnKeyDown := ListKeys;
  SrcList.OnClick := ListClick;
  SrcList.Parent := Self;

  IncludeBtn := TSpeedButton.Create(Self);
  IncludeBtn.Width := 24;
  IncludeBtn.Height := 24;
  IncludeBtn.Hint := 'Include field';
  IncludeBtn.Caption := '&>';
  IncludeBtn.OnClick := IncludeBtnClick;
  IncludeBtn.Parent := Self;

  IncAllBtn := TSpeedButton.Create(Self);
  IncAllBtn.Width := 24;
  IncAllBtn.Height := 24;
  IncAllBtn.Hint := 'Include all fields';
  IncAllBtn.Caption := '>>';
  IncAllBtn.OnClick := IncAllBtnClick;
  IncAllBtn.Parent := Self;

  ExcludeBtn := TSpeedButton.Create(Self);
  ExcludeBtn.Width := 24;
  ExcludeBtn.Height := 24;
  ExcludeBtn.Hint := 'Exclude field';
  ExcludeBtn.Caption := '&<';
  ExcludeBtn.Enabled := False;
  ExcludeBtn.OnClick := ExcludeBtnClick;
  ExcludeBtn.Parent := Self;

  ExAllBtn := TSpeedButton.Create(Self);
  ExAllBtn.Width := 24;
  ExAllBtn.Height := 24;
  ExAllBtn.Hint := 'Exclude all fields';
  ExAllBtn.Caption := '<<';
  ExAllBtn.Enabled := False;
  ExAllBtn.OnClick := ExcAllBtnClick;
  ExAllBtn.Parent := Self;

  UpBtn := TSpeedButton.Create(Self);
  UpBtn.Width := 24;
  UpBtn.Height := 24;
  UpBtn.Hint := 'Move field up';
  UpBtn.Caption := '&^';
  UpBtn.Enabled := False;
  UpBtn.OnClick := UpBtnClick;
  UpBtn.Parent := Self;

  DownBtn := TSpeedButton.Create(Self);
  DownBtn.Width := 24;
  DownBtn.Height := 24;
  DownBtn.Hint := 'Move field down';
  DownBtn.Caption := '&v';
  DownBtn.Enabled := False;
  DownBtn.OnClick := DownBtnClick;
  DownBtn.Parent := Self;

  DstList := TListBox.Create(Self);
  DstList.Hint := 'A list of included fields';
  DstList.DragMode := dmAutomatic;
  DstList.MultiSelect := True;
  DstList.TabOrder := 1;
  DstList.OnDragDrop := ListDragDrop;
  DstList.OnDragOver := ListDragOver;
  DstList.OnKeyDown := ListKeys;
  DstList.OnClick := ListClick;
  DstList.Parent := Self;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.AlignControls(AControl: TControl; var Rect: TRect);
var
  BevelSize: Integer;
begin
  BevelSize := BorderWidth;
  if BevelOuter <> bvNone then
    Inc(BevelSize, BevelWidth);
  if BevelInner <> bvNone then
    Inc(BevelSize, BevelWidth);
  InflateRect(Rect, -BevelSize, -BevelSize);

  SrcLabel.Left := Rect.Left;
  SrcLabel.Top := Rect.Top;
  SrcLabel.Width := ((Rect.Right - Rect.Left + 1) - 24 - 10 * 2) div 2;

  SrcList.Left := SrcLabel.Left;
  SrcList.Top := (SrcLabel.Top + SrcLabel.Height - 1) + 5;
  SrcList.Height := Rect.Bottom - Top;
  SrcList.Width := SrcLabel.Width;

  IncludeBtn.Left := (SrcList.Left + SrcList.Width - 1) + 10;
  IncludeBtn.Top := SrcList.Top;

  IncAllBtn.Left := IncludeBtn.Left;
  IncAllBtn.Top := (IncludeBtn.Top + IncludeBtn.Height - 1) + 11;

  ExcludeBtn.Left := IncludeBtn.Left;
  ExcludeBtn.Top := (IncAllBtn.Top + IncAllBtn.Height - 1) + 11;

  ExAllBtn.Left := IncludeBtn.Left;
  ExAllBtn.Top := (ExcludeBtn.Top + ExcludeBtn.Height - 1) + 11;

  UpBtn.Left := IncludeBtn.Left;
  UpBtn.Top := (ExAllBtn.Top + ExAllBtn.Height - 1) + 11;

  DownBtn.Left := IncludeBtn.Left;
  DownBtn.Top := (UpBtn.Top + UpBtn.Height - 1) + 11;

  DstLabel.Left := (IncludeBtn.Left + IncludeBtn.Width - 1) + 10;
  DstLabel.Top := SrcLabel.Top;
  DstLabel.Width := SrcList.Width;

  DstList.Left := DstLabel.Left;
  DstList.Top := SrcList.Top;
  DstList.Height := SrcList.Height;
  DstList.Width := SrcList.Width;

  SetButtons;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.IncludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(SrcList);
  MoveSelected(SrcList, DstList.Items);
  SetItem(SrcList, Index);
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.ExcludeBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  MoveSelected(DstList, SrcList.Items);
  SetItem(DstList, Index);
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.IncAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to SrcList.Items.Count - 1 do
    DstList.Items.AddObject(SrcList.Items[I], SrcList.Items.Objects[I]);
  SrcList.Items.Clear;
  SetItem(SrcList, 0);
  DstList.SetFocus;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.ExcAllBtnClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to DstList.Items.Count - 1 do
    SrcList.Items.AddObject(DstList.Items[I], DstList.Items.Objects[I]);
  DstList.Items.Clear;
  SetItem(DstList, 0);
  SrcList.SetFocus;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.UpBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  if Index > 0 then begin
    DstList.Items.Exchange(Index, Index - 1);
    SetItem(DstList, Index - 1);
  end;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.DownBtnClick(Sender: TObject);
var
  Index: Integer;
begin
  Index := GetFirstSelection(DstList);
  if Index < DstList.Items.Count - 1 then begin
    DstList.Items.Exchange(Index, Index + 1);
    SetItem(DstList, Index + 1);
  end;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.MoveSelected(List: TCustomListBox; Items: TStrings);
var
  I: Integer;
begin
  for I := List.Items.Count - 1 downto 0 do
    if List.Selected[I] then begin
      Items.AddObject(List.Items[I], List.Items.Objects[I]);
      List.Items.Delete(I);
    end;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.ListKeys(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_INSERT then begin
    IncludeBtnClick(Sender);
    Key := 0;
  end
  else if Key = VK_DELETE then begin
    ExcludeBtnClick(Sender);
    Key := 0;
  end
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.ListClick(Sender: TObject);
begin
  SetButtons;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.SetButtons;
var
  SrcEmpty, DstEmpty: Boolean;
begin
  SrcEmpty := SrcList.Items.Count = 0;
  DstEmpty := DstList.Items.Count = 0;
  IncludeBtn.Enabled := not SrcEmpty;
  IncAllBtn.Enabled := not SrcEmpty;
  ExcludeBtn.Enabled := not DstEmpty;
  ExAllBtn.Enabled := not DstEmpty;
  UpBtn.Enabled := not DstEmpty;
  DownBtn.Enabled := not DstEmpty;
end;

{------------------------------------------------------------------------------}
function TFDGUIxFormsDblListBox.GetFirstSelection(List: TCustomListBox): Integer;
begin
  for Result := 0 to List.Items.Count - 1 do
    if List.Selected[Result] then
      Exit;
  Result := -1;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.SetItem(List: TListBox; Index: Integer);
var
  MaxIndex: Integer;
begin
  List.SetFocus;
  MaxIndex := List.Items.Count - 1;
  if Index = -1 then
    Index := 0
  else if Index > MaxIndex then
    Index := MaxIndex;
  List.Selected[Index] := True;
  SetButtons;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.ListDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Source is TListBox) and ((Sender <> Source) or
    (TListBox(Sender) = DstList));
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.ListDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  j, i: Integer;

  procedure ExchangeItem(i, j: Integer);
  var
    s: String;
    o: TObject;
    oSrc, oSndr: TListBox;
  begin
    oSrc := TListBox(Source);
    s := oSrc.Items[i];
    o := oSrc.Items.Objects[i];
    oSrc.Items.Delete(i);

    oSndr := TListBox(Sender);
    if j > oSndr.Items.Count then
      j := oSndr.Items.Count;
    oSndr.Items.InsertObject(j, s, o);
  end;

begin
  j := TListBox(Sender).ItemAtPos(Point(x, y), False);
  for i := TListBox(Source).Items.Count - 1 downto 0 do
    if TListBox(Source).Selected[i] then
      ExchangeItem(i, j);
  if SrcList.Sorted then
    try
      SrcList.Sorted := False;
    finally
      SrcList.Sorted := True;
    end;
  SetButtons;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.SetS(AIndex: Integer; const AValue: String);
begin
  if GetS(AIndex) <> AValue then
    case AIndex of
    0: DstLabel.Caption := AValue;
    1: SrcLabel.Caption := AValue;
    2: DstList.Hint := AValue;
    3: SrcList.Hint := AValue;
    4: IncludeBtn.Hint := AValue;
    5: IncAllBtn.Hint := AValue;
    6: ExcludeBtn.Hint := AValue;
    7: ExAllBtn.Hint := AValue;
    8: UpBtn.Hint := AValue;
    9: DownBtn.Hint := AValue;
    end;
end;

{------------------------------------------------------------------------------}
function TFDGUIxFormsDblListBox.GetS(AIndex: Integer): String;
begin
  case AIndex of
  0: Result := DstLabel.Caption;
  1: Result := SrcLabel.Caption;
  2: Result := DstList.Hint;
  3: Result := SrcList.Hint;
  4: Result := IncludeBtn.Hint;
  5: Result := IncAllBtn.Hint;
  6: Result := ExcludeBtn.Hint;
  7: Result := ExAllBtn.Hint;
  8: Result := UpBtn.Hint;
  9: Result := DownBtn.Hint;
  end;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.SetItems(AIndex: Integer; AValues: TStrings);
begin
  case AIndex of
  0: SrcList.Items.SetStrings(AValues);
  1: DstList.Items.SetStrings(AValues);
  end;
end;

{------------------------------------------------------------------------------}
{$WARNINGS OFF}
function TFDGUIxFormsDblListBox.GetItems(AIndex: Integer): TStrings;
begin
  case AIndex of
  0: Result := SrcList.Items;
  1: Result := DstList.Items;
  end;
end;

{------------------------------------------------------------------------------}
function TFDGUIxFormsDblListBox.GetEvent(AIndex: Integer): TNotifyEvent;
begin
  case AIndex of
  0: Result := SrcList.OnClick;
  1: Result := DstList.OnClick;
  end;
end;
{$WARNINGS ON}

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.SetEvent(AIndex: Integer; AValue: TNotifyEvent);
begin
  case AIndex of
  0: SrcList.OnClick := AValue;
  1: DstList.OnClick := AValue;
  end;
end;

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.SetI(AIndex: Integer; AValue: Integer);
begin
  case AIndex of
  0: SrcList.ItemIndex := AValue;
  1: DstList.ItemIndex := AValue;
  end;
end;

{------------------------------------------------------------------------------}
{$WARNINGS OFF}
function TFDGUIxFormsDblListBox.GetI(AIndex: Integer): Integer;
begin
  case AIndex of
  0: Result := SrcList.ItemIndex;
  1: Result := DstList.ItemIndex;
  end;
end;
{$WARNINGS ON}

{------------------------------------------------------------------------------}
procedure TFDGUIxFormsDblListBox.SetB(AIndex: Integer; AValue: Boolean);
begin
  case AIndex of
  0: SrcList.Sorted := AValue;
  end;
end;

{------------------------------------------------------------------------------}
{$WARNINGS OFF}
function TFDGUIxFormsDblListBox.GetB(AIndex: Integer): Boolean;
begin
  case AIndex of
  0: Result := SrcList.Sorted;
  end;
end;
{$WARNINGS ON}

{-------------------------------------------------------------------------------}
{ Utilities                                                                     }
{-------------------------------------------------------------------------------}
function FDGUIxSetupEditor(ACombo: TComboBox; AEdit: TEdit;
  AFileEdt: TCustomEdit; AOpenDlg: TOpenDialog; const AType: String): Integer;
var
  i: Integer;
begin
  Result := 1;
  if AType = '@L' then begin
    ACombo.Style := csDropDown;
    ACombo.Items.BeginUpdate;
    try
      ACombo.Items.Clear;
      ACombo.Items.Add(S_FD_True);
      ACombo.Items.Add(S_FD_False);
    finally
      ACombo.Items.EndUpdate;
    end;
    ACombo.Text := S_FD_False;
  end
  else if AType = '@Y' then begin
    ACombo.Style := csDropDown;
    ACombo.Items.BeginUpdate;
    try
      ACombo.Items.Clear;
      ACombo.Items.Add(S_FD_Yes);
      ACombo.Items.Add(S_FD_No);
    finally
      ACombo.Items.EndUpdate;
    end;
    ACombo.Text := S_FD_No;
  end
  else if AType = '@I' then begin
    //ACombo.Style := csSimple;
    //ACombo.Items.Clear;
    //ACombo.Text := '0';
    AEdit.Text := '0';
    Result := 0;
  end
  else if (AType = '') or (AType = '@S') or (AType = '@P') then begin
    //ACombo.Style := csSimple;
    //ACombo.Items.Clear;
    //ACombo.Text := '';
    AEdit.Text := '';
    Result := 0;
  end
  else if Copy(AType, 1, 2) = '@F' then begin
    AFileEdt.Text := '';
    AOpenDlg.Filter := Copy(AType, 4, MAXINT) + '|All Files|*.*';
    AOpenDlg.FilterIndex := 0;
    Result := 2;
  end
  else begin
    ACombo.Style := csDropDown;
    i := 1;
    ACombo.Items.BeginUpdate;
    try
      ACombo.Items.Clear;
      while i <= Length(AType) do
        ACombo.Items.Add(FDExtractFieldName(AType, i));
    finally
      ACombo.Items.EndUpdate;
    end;
    ACombo.Text := '';
  end;
end;

{-------------------------------------------------------------------------------}
procedure FDGUIxCancel;
begin
{$IFDEF MSWINDOWS}
  CancelDrag;
  if GetCapture <> 0 then
    SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
  ReleaseCapture;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
type
  TFDGUIxModalData = class(TObject)
  private
    FWindowList: Pointer;
    FActiveWindow: HWnd;
  end;

function FDGUIxBeginModal(AForm: TCustomForm; ASaveActive: Boolean = True): Pointer;
var
  oData: TFDGUIxModalData;
begin
  Result := TFDGUIxModalData.Create;
  oData := TFDGUIxModalData(Result);
  Application.ModalStarted;
  oData.FWindowList := DisableTaskWindows(0);
  if ASaveActive then
    oData.FActiveWindow := GetActiveWindow
  else
    oData.FActiveWindow := 0;
end;

{-------------------------------------------------------------------------------}
procedure FDGUIxEndModal(var AData: Pointer);
var
  oData: TFDGUIxModalData;
begin
  oData := TFDGUIxModalData(AData);
  EnableTaskWindows(oData.FWindowList);
  if oData.FActiveWindow <> 0 then
    SetActiveWindow(oData.FActiveWindow);
  Application.ModalFinished;
  FDFree(oData);
  AData := nil;
end;

end.
