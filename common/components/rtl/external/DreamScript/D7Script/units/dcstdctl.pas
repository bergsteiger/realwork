{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcstdctl;

interface
{$I dc.inc}

uses
  consts,
  dcsystem, Messages, Windows, SysUtils, dcdreamlib,Classes, Controls, forms,
  stdctrls, extctrls, comctrls, Graphics, dccommon, dccontrols, dcconsts
  {$IFDEF D3},checklst{$ENDIF}
  {$IFDEF D4},imglist{$ENDIF}
  ;

type
  {$IFDEF D3}
  TDCSplitter = class(TSplitter)
  private
    FVersion : TDCVersion;
  published
    property Visible;
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;
  {$ELSE}
  TDCSplitter = class(TGraphicControl)
  private
    FLineDC: HDC;
    FDownPos: TPoint;
    FSplit: Integer;
    FMinSize: integer;
    FMaxSize: integer;
    FControl: TControl;
    FNewSize: integer;
    FActiveControl: TWinControl;
    FOldKeyDown: TKeyEvent;
    FBeveled: Boolean;
    FLineVisible: Boolean;
    FOnMoved: TNotifyEvent;
    FVersion : TDCVersion;
    procedure AllocateLineDC;
    procedure DrawLine;
    procedure ReleaseLineDC;
    procedure UpdateSize(X, Y: Integer);
    procedure FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetBeveled(Value: Boolean);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure StopSizing;
    function FindControl: TControl;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align default alLeft;
    property Visible;
    property Beveled: Boolean read FBeveled write SetBeveled default True;
    property Color;
    property MinSize: integer read FMinSize write FMinSize default 30;
    property ParentColor;
    property OnMoved: TNotifyEvent read FOnMoved write FOnMoved;
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;
  {$ENDIF}
{------------------------------------------------------------------}

  TPanelClass = class of TPanel;

  TSpAlign = (spTop, spBottom, spLeft, spRight);

  TSavePos = record
    Height : integer;
    Width  : integer;
    Align  : TAlign;
  end;

  TCustomSplitterPanel = class(TCustomPanel)
  private
    FLefTPanel          : TPanel;
    FRightPanel         : TPanel;
    fPanels             : TList;
    FVertSplitter       : TDCSplitter;
    FRightAlign         : TSpAlign;
    FLeftVisible        : boolean;
    FRightVisible       : boolean;
    fHitPos             : TPoint;
    RightPos            : TSavePos;
    FVersion            : TDCVersion;
    function GetSplitterBeveled:boolean;
    procedure SetRightAlign(Value:TSpAlign);
    procedure SetLeftVisible(Value :boolean);
    procedure SetRightVisible(Value :boolean);
    procedure SetSplitterBeveled(Value:boolean);
    procedure AlignSplitter(Splitter:TDCSplitter;Panel:TPanel);
    procedure SeTPanel(Panel : TPanel; AAlign:TSpAlign);
    procedure ChangeVisible(Panel : TPanel ; var SavePos : TSavePos; Value : boolean);
    procedure CheckVertSplitter;
    function  CreatePanel(AParent : TWinControl; AAlign : TAlign) : TPanel;
    function  InLoading : boolean;
  protected
    procedure Loaded; override;
    {$IFNDEF D3}
    procedure GetChildren(Proc: TGetChildProc); override;
    {$ELSE}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    {$ENDIF}
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHitTest;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    function  GetChildOwner : TComponent; override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy; override;

    property Panel1 : TPanel read fLeftPanel;
    property Panel2 : TPanel read fRightPanel;
  published
    property RightAlign : TSpAlign read FRightAlign write SetRightAlign;
    property LeftVisible : boolean read FLeftVisible write SetLeftVisible;
    property RightVisible : boolean read FRightVisible write SetRightVisible;
    property SplitterBeveled : boolean read GetSplitterBeveled write SetSplitterBeveled;
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

  TDCSplitPanel = class(TCustomSplitterPanel)
  published
    property BevelInner;
    property BevelOuter;
    property Align;
    property Caption;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Color;
    property Ctl3D;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    {$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Constraints;
    property UseDockManager default True;
    property DockSite;
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {$IFDEF D4}
    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
 end;

  TDCCheckData = class
    FData : LongInt;
    FState :TCheckBoxState;
  end;

  {$IFDEF D3}
  TDCCheckListBox = class(TCheckListBox)
  private
    FVersion : TDCVersion;
  published
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;
  {$ELSE}
  TDCCheckListBox = class(TCustomListBox)
  private
    {$IFNDEF D3}
    FInternalFlag: Boolean;
    {$ENDIF}
    FDataList : TList;
    FAllowGrayed: Boolean;
    FStandardItemHeight: Integer;
    FOnClickCheck: TNotifyEvent;
    FVersion : TDCVersion;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure ResetItemHeight;
    procedure DrawCheck( R: TRect; AState: TCheckBoxState );
    procedure SetChecked( Index: Integer; Checked: Boolean );
    function  GetChecked( Index: Integer ): Boolean;
    procedure SetState( Index: Integer; AState: TCheckBoxState );
    function  GetState( Index: Integer ): TCheckBoxState;
    procedure ToggleClickCheck( Index: Integer );
    procedure InvalidateCheck( Index: Integer );
    function  GetStringData ( Index: Integer ): TDCCheckData;
  protected
    procedure DeleteString(Index: Integer);  {$IFDEF D3} override; {$ENDIF}
    procedure SetItemData( Index: Integer; AData: LongInt );  {$IFDEF D3} override; {$ENDIF}
    function  GetItemData( Index: Integer ): LongInt;  {$IFDEF D3} override; {$ENDIF}
    {$IFNDEF D3}
    procedure  LBGETITEMDATA(var Message:TMessage); message LB_GETITEMDATA;
    procedure  LBSETITEMDATA(var Message:TMessage); message LB_SETITEMDATA;
    procedure  LBDELETESTRING(var Message:TMessage); message LB_DELETESTRING;
    {$ENDIF}
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure ClickCheck; dynamic;
    procedure CreateParams(var Params: TCreateParams); override;
    function  GetCheckWidth: Integer;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy ; override;
    property Checked[Index: Integer]: Boolean read GetChecked write SetChecked;
    property State[Index: Integer]: TCheckBoxState read GetState write SetState;
  published
    property Align;
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed default False;
    property BorderStyle;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    {$IFDEF D3}
    property ImeMode;
    property ImeName;
    {$ENDIF}
    property IntegralHeight;
    property ItemHeight;
    property Items;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property Style;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Visible;
    property Version : TDCVersion read FVersion write FVersion stored false;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnClickCheck: TNotifyEvent read FOnClickCheck write FOnClickCheck;
  end;
  {$ENDIF}

  TDCFormParent = class(TComponent)
  Private
    FCreatedForm:TCustomForm;
    FForm:TCustomForm;
    FFormClass:TCustomFormClass;
    FFormClassName:String;
    FFormComponent:TComponent;
    FFormSaveParent:THandle;
    FFormSavePosition:TPosition;
    FFormSaveStyle:Integer;
    FFormSaveStyleEx:Integer;
    FFormSaveWindowPlacement: TWindowPlacement;
    FFormSaveVisible:Boolean;
    FParentControl:TWinControl;
    FVersion : TDCVersion;
    Procedure SetForm(Value:TCustomForm);
    Procedure SetFormClass(Value:TCustomFormClass);
    Procedure SetFormClassName(const Value:String);
    Procedure SetFormComponent(Value:TComponent);
    Procedure SetParentControl(Value:TWinControl);
    Procedure SizeChanged; 
  Protected
    Procedure Notification(Component:TComponent;Operation:TOperation);override;
    Procedure Loaded;override;
  Public
    Destructor Destroy;override;

    Property Form:TCustomForm read FForm write SetForm;
    Property FormClass:TCustomFormClass read FFormClass write SetFormClass;
  Published
    Property FormClassName:String read FFormClassName write SetFormClassName;
    Property FormComponent:TComponent read FFormComponent write SetFormComponent;
    Property ParentControl:TWinControl read FParentControl write SetParentControl;
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

  TCustomDCFormPanel = class(TCustomPanel)
  Private
    FFormParent:TDCFormParent;
    FVersion : TDCVersion;
    Function GetForm:TCustomForm;
    Function GetFormClass:TCustomFormClass;
    Function GetFormClassName:String;
    Function GetFormComponent:TComponent;
    Procedure SetForm(Value:TCustomForm);
    Procedure SetFormClass(Value:TCustomFormClass);
    Procedure SetFormClassName(const Value:String);
    Procedure SetFormComponent(Value:TComponent); 
  Protected
    Procedure WMSize(Var Message:TMessage);message WM_SIZE;

    Property Form:TCustomForm read GetForm write SetForm;
    Property FormClass:TCustomFormClass read GetFormClass write SetFormClass;
    Property FormClassName:String read GetFormClassName write SetFormClassName;
    Property FormComponent:TComponent read GetFormComponent write SetFormComponent;
    property Version : TDCVersion read FVersion write FVersion stored false;
  Public
    Constructor Create(AOwner:TComponent);override;
    Destructor Destroy;override;
  End;

  TDCFormTabSheet = class(TTabSheet)
  Private
    FFormParent:TDCFormParent;
    FVersion : TDCVersion;
    fHookControl : TControl;
    Function GetForm:TCustomForm;
    Function GetFormClass:TCustomFormClass;
    Function GetFormClassName:String;
    Function GetFormComponent:TComponent;

    procedure SetForm(Value:TCustomForm);

    Procedure SetFormClass(Value:TCustomFormClass);
    Procedure SetFormClassName(const Value:String);
    Procedure SetFormComponent(Value:TComponent);
  Protected
    Procedure WMSize(Var Message:TMessage);message WM_SIZE;  
  Public
    Constructor Create(AOwner:TComponent);override;
    Destructor Destroy;override;

    Property Form:TCustomForm read GetForm write SetForm;
    Property FormClass:TCustomFormClass read GetFormClass write SetFormClass;
  Published
    Property FormClassName:String read GetFormClassName write SetFormClassName;
    Property FormComponent:TComponent read GetFormComponent write SetFormComponent;
    property Version : TDCVersion read FVersion write FVersion stored false;
  End;

  TDCFormPanel=Class(TCustomDCFormPanel)
  Public
    Property Form;
    property FormClass;
  Published
    Property FormClassName;
    Property FormComponent;

    property Align;
    property Alignment;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    Property Caption;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Version;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;

    {$IFDEF D4}
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Constraints;
    property DockSite;
    property DragKind;
    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    property ParentBiDiMode;
    property UseDockManager default True;
    {$ENDIF}
  End;

Procedure Register;

implementation

type
  THack = class(TWinControl);

{------------------------------------------------------------------}

{$IFNDEF D3}

constructor TDCSplitter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 3;
  Cursor := crHSplit;
  FMinSize := 30;
  FBeveled := True;
  Align := alLeft;
end;

{------------------------------------------------------------------}

procedure TDCSplitter.AllocateLineDC;
begin
  FLineDC := GetDCEx(Parent.Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS
    or DCX_LOCKWINDOWUPDATE);
end;

{------------------------------------------------------------------}

procedure TDCSplitter.DrawLine;
var
  P: TPoint;
begin
  FLineVisible := not FLineVisible;
  P := Point(Left, Top);
  if Align in [alLeft, alRight] then
    P.X := Left + FSplit else
    P.Y := Top + FSplit;
  with P do PatBlt(FLineDC, X, Y, Width, Height, PATINVERT);
end;

{------------------------------------------------------------------}

procedure TDCSplitter.ReleaseLineDC;
begin
  ReleaseDC(Parent.Handle, FLineDC);
end;

{------------------------------------------------------------------}

procedure TDCSplitter.Paint;
var
  FrameBrush: HBRUSH;
  R: TRect;
begin
  R := ClientRect;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);
  if Beveled then
  begin
    if Align in [alLeft, alRight] then
      InflateRect(R, -1, 2) else
      InflateRect(R, 2, -1);
    OffsetRect(R, 1, 1);
    FrameBrush := CreateSolidBrush(ColorToRGB(clBtnHighlight));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
    OffsetRect(R, -2, -2);
    FrameBrush := CreateSolidBrush(ColorToRGB(clBtnShadow));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
  end;
end;

{------------------------------------------------------------------}

function TDCSplitter.FindControl: TControl;
  var
    P: TPoint;
    I: Integer;
  begin
    Result := nil;
    P := Point(Left, Top);
    case Align of
      alLeft: Dec(P.X);
      alRight: Inc(P.X, Width);
      alTop: Dec(P.Y);
      alBottom: Inc(P.Y, Height);
    else
      Exit;
    end;
    for I := 0 to Parent.ControlCount - 1 do
    begin
      Result := Parent.Controls[I];
      if PtInRect(Result.BoundsRect, P) then Exit;
    end;
    Result := nil;
  end;

{------------------------------------------------------------------}

procedure TDCSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);

var
  I: Integer;
begin
  inherited;
  if Button = mbLeft then
  begin
    FControl := FindControl;
    FDownPos := Point(X, Y);
    if Assigned(FControl) then
    begin
      if Align in [alLeft, alRight] then
      begin
        FMaxSize := Parent.ClientWidth - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Align in [alLeft, alRight] then Dec(FMaxSize, Width);
        Inc(FMaxSize, FControl.Width);
      end
      else
      begin
        FMaxSize := Parent.ClientHeight - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Align in [alTop, alBottom] then Dec(FMaxSize, Height);
        Inc(FMaxSize, FControl.Height);
      end;
      UpdateSize(X, Y);
      AllocateLineDC;
      with ValidParentForm(Self) do
        if ActiveControl <> nil then
        begin
          FActiveControl := ActiveControl;
          FOldKeyDown := THack(FActiveControl).OnKeyDown;
          THack(FActiveControl).OnKeyDown := FocusKeyDown;
        end;
      DrawLine;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TDCSplitter.UpdateSize(X, Y: Integer);
var
  S: Integer;
begin
  if Align in [alLeft, alRight] then
    FSplit := X - FDownPos.X
  else
    FSplit := Y - FDownPos.Y;
  S := 0;
  case Align of
    alLeft: S := FControl.Width + FSplit;
    alRight: S := FControl.Width - FSplit;
    alTop: S := FControl.Height + FSplit;
    alBottom: S := FControl.Height - FSplit;
  end;
  FNewSize := S;
  if S < FMinSize then
    FNewSize := FMinSize
  else if S > FMaxSize then
    FNewSize := FMaxSize;
  if S <> FNewSize then
  begin
    if Align in [alRight, alBottom] then
      S := S - FNewSize else
      S := FNewSize - S;
    Inc(FSplit, S);
  end;
end;

{------------------------------------------------------------------}

procedure TDCSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Assigned(FControl) then
  begin
    DrawLine;
    UpdateSize(X, Y);
    DrawLine;
  end;
end;

{------------------------------------------------------------------}

procedure TDCSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  if Assigned(FControl) then
  begin
    DrawLine;
    case Align of
      alLeft: FControl.Width := FNewSize;
      alTop: FControl.Height := FNewSize;
      alRight:
        begin
          Parent.DisableAlign;
          try
            FControl.Left := FControl.Left + (FControl.Width - FNewSize);
            FControl.Width := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
      alBottom:
        begin
          Parent.DisableAlign;
          try
            FControl.Top := FControl.Top + (FControl.Height - FNewSize);
            FControl.Height := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
    end;
    StopSizing;
  end;
end;

{------------------------------------------------------------------}

procedure TDCSplitter.FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    StopSizing
  else if Assigned(FOldKeyDown) then
    FOldKeyDown(Sender, Key, Shift);
end;

{------------------------------------------------------------------}

procedure TDCSplitter.SetBeveled(Value: Boolean);
begin
  If FBeveled<>Value then
  begin
    FBeveled := Value;
    Repaint;
  end;
end;

{------------------------------------------------------------------}

procedure TDCSplitter.StopSizing;
begin
  if Assigned(FControl) then
  begin
    if FLineVisible then DrawLine;
    FControl := nil;
    ReleaseLineDC;
    if Assigned(FActiveControl) then
    begin
      THack(FActiveControl).OnKeyDown := FOldKeyDown;
      FActiveControl := nil;
    end;
  end;
  if Assigned(FOnMoved) then
    FOnMoved(Self);
end;

{$ENDIF}

{------------------------------------------------------------------}

type
  TMPanel = class(TPanel)
    {$IFNDEF D3}
    procedure GetChildren(Proc: TGetChildProc); override;
    {$ELSE}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    {$ENDIF}
  end;

  TMDCSplitter = class(TDCSplitter)
    procedure SelectOwner;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  end;

procedure TMDCSplitter.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  Msg.result := 1;
end;

{------------------------------------------------------------------}

procedure TMDCSplitter.SelectOwner;
begin
  if csDesigning in ComponentState then
    DesignerSelectComponent(Owner);
end;

{------------------------------------------------------------------}

procedure TMDCSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SelectOwner;
end;

{------------------------------------------------------------------}

procedure TMDCSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SelectOwner;
end;

{------------------------------------------------------------------}

{$IFNDEF D3}
procedure  TMPanel.GetChildren(Proc: TGetChildProc);
{$ELSE}
procedure TMPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
{$ENDIF}
var
  i : integer;
begin
  for i := 0 to ControlCount - 1 do
    Proc(Controls[i]);
end;

const
  DefaultPos = 3;
var
  SpAlignToAlign : Array[0..3] of TAlign  = (alTop, alBottom, alLeft, alRight);

{------------------------------------------------------------------}

function TCustomSplitterPanel.CreatePanel(AParent : TWinControl; AAlign : TAlign) : TPanel;
begin
  result := TMPanel.Create(self);
  with result do
    begin
      Parent := AParent;
      Align := AAlign;
      fPanels.Add(result);
      Caption := '';
      BevelInner:=bvNone;
      BevelOuter:=bvNone;
    end;
end;

{------------------------------------------------------------------}

constructor TCustomSplitterPanel.Create(AOwner:TComponent);
begin
  inherited;
  SafeRegisterClass(TMPanel);
  SafeRegisterClass(TMDCSplitter);
  fPanels := TList.Create;
  width := 300;
  height := 150;
  FRightPanel := CreatePanel(self, alRight);
  FLeftPanel  := CreatePanel(self, alClient);
  FVertSplitter  := TMDCSplitter.Create(Self);
  FVertSplitter.Parent := Self;
  FRightAlign := spRight;
  FLeftVisible:=true;
  FRightVisible := true;
  AlignSplitter(FVertSplitter,FRightPanel);
  FVertSplitter.Beveled := True;
end;

{------------------------------------------------------------------}

destructor TCustomSplitterPanel.Destroy;
begin
  fPanels.Free;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.AlignSplitter(Splitter:TDCSplitter;Panel:TPanel);
begin
  with Splitter do
  begin
    Align := Panel.Align;
    case Align of
      alTop : Top := Panel.Height+1;
      alBottom : Top := Panel.Top-Height-1;
      alLeft : Left := Panel.Width+1;
      alRight: Left :=Panel.Left - Width -1;
    end;
    if Align in [alTop, alBottom] then
      Height := DefaultPos
    else if Align in [alLeft, alRight] then
      Width:=DefaultPos;
    Visible := not ((Align in [alNone,alClient]) or not Visible);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.SetPanel(Panel : TPanel; AAlign:TSpAlign);
var
  W : integer;
  H : integer;
begin
  if InLoading then
    exit;

  H:= 0;
  W:= 0;
  if ((Panel.Align in [alTop,alBottom]) and (AAlign in [spTop,spBottom]) ) or
      ( AAlign in [spLeft,spRight] ) then
    H := Panel.Height
  else
    with Panel.Parent do
      if Width <> 0 then
        H := round (Panel.Width * Height / Width);
  if ((Panel.Align in [alLeft,alRight]) and (AAlign in [spLeft,spRight])) or
      (AAlign in [spTop,spBottom] ) then
    W := Panel.Width
  else
    with Panel.Parent do
      if Height <> 0 then
        W := round ((Panel.Height * Width / Height));
  with Panel do
    begin
      Align := SpAlignToAlign[byte(AAlign)];
      Width:=W;
      Height:=H;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.SetRightAlign(Value:TSpAlign);
begin
//  if (FRightAlign <> Value) then
  begin
    FRightAlign := Value;
    if InLoading then
      exit;
    SetPanel(FRightPanel,Value);
    AlignSplitter(FVertSplitter,FRightPanel);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.ChangeVisible(Panel : TPanel ; var SavePos : TSavePos; Value : boolean);
begin
  with Panel do
    if Value then
    begin
      Align  := SavePos.Align;
      Width  := SavePos.Width;
      Height := SavePos.Height;
    end
    else
    begin
      SavePos.Width  := Width;
      SavePos.Height := Height;
      SavePos.Align  := Align;
      Align := alClient;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.CheckVertSplitter;
begin
  FVertSplitter.Visible := FLeftVisible and FRightVisible;
  if FVertSplitter.Visible then
    AlignSplitter(FVertSplitter,FRightPanel);
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.SetLeftVisible(Value : boolean);
begin
//  if FLeftVisible <> Value then
  begin
    FLeftVisible := Value;
    if InLoading or (csDesigning in ComponentState) then
      exit;
    ChangeVisible(fRightPanel, RightPos, Value);
    FLeftPanel.Visible := Value;
    CheckVertSplitter;
  end;
end;

{------------------------------------------------------------------}
type
  TMWinControl = class(TWinControl)
  end;

procedure TCustomSplitterPanel.SetRightVisible(Value :boolean);
begin
//  if FRightBottomVisible <> Value then
  begin
    FRightVisible := Value;
    if InLoading or (csDesigning in ComponentState) then
      exit;
    FRightPanel.Visible := Value;
    CheckVertSplitter;
//    with TMWinControl(fLeftPanel.Controls[0]) do
      begin
        visible := false;
        visible := true;
      end;
  end;
end;

{------------------------------------------------------------------}

function TCustomSplitterPanel.GetSplitterBeveled:boolean;
begin
  Result:=FVertSplitter.Beveled;
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.SetSplitterBeveled(Value:boolean);
begin
  FVertSplitter.Beveled := Value;
end;

{------------------------------------------------------------------}

function TCustomSplitterPanel.InLoading : boolean;
begin
  result := (csLoading in ComponentState) or (csLoading in Owner.ComponentState);
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.Loaded;
var
  fRVisible : boolean;
  fLVisible : boolean;
begin
  inherited;
  if ControlCount > 3 then
    begin
      FVertSplitter.Free;
      fLeftPanel.Free;
      fRightPanel.Free;
    end;

  FVertSplitter := TDCSplitter(Controls[0]);
  fLeftPanel := TPanel(Controls[1]);
  fRightPanel := TPanel(Controls[2]);

  AlignSplitter(FVertSplitter,FRightPanel);
  fLVisible := LeftVisible;
  fRVisible := RightVisible;

  SetLeftVisible(false);
  SetRightVisible(false);

  LeftVisible := fLVisible;
  RightVisible := fRVisible;
{  if FRightPanel.Width >= Width then
    FRightPanel.Width := Width div 2;}
end;

{------------------------------------------------------------------}

{$IFNDEF D3}
procedure TCustomSplitterPanel.GetChildren(Proc: TGetChildProc);
{$ELSE}
procedure TCustomSplitterPanel.GetChildren(Proc: TGetChildProc; Root: TComponent);
{$ENDIF}
begin
  Proc(FLefTPanel);
  Proc(FRightPanel);
  Proc(fVertSplitter);
end;

{------------------------------------------------------------------}

function isnear(x, y : integer) : boolean;
begin
  result := abs(x - y) < 3;
end;

{------------------------------------------------------------------}

function  SplitterAtPos(Splitter:TDCSplitter;x,y:integer):boolean;
begin
  with Splitter do
    result := ( (Align in [alTop,alBottom]) and isnear(y,Top)  ) or
              ( (Align in [alLeft,alRight]) and isnear(x,Left) )
end;

{------------------------------------------------------------------}

function SetSplitterCusrsor(Splitter:TDCSplitter;Pos:TPoint) : boolean;
const
  curs : array[boolean] of TCursor = (crHSplit, crVSplit);
begin
  result := SplitterAtPos(Splitter, Pos.X, Pos.Y);
  if result then
    SetCursor(Screen.Cursors[curs[Splitter.Align in [alTop,alBottom]]]);
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
  if SplitterAtPos(FVertSplitter,Msg.XPos,Msg.YPos) then
    Msg.result := 1;
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  DefaultHandler(Msg);
  fHitPos := ScreenToClient(SmallPointToPoint(Msg.Pos));
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.WMWindowPosChanged(var Message: TWMWindowPosChanged);
{var
  W,H:integer;}
begin
{  W:= Width;
  H:= Height;}
  inherited;
  if  (csDesigning in ComponentState) then
  begin
{    with (Message.WindowPos^) do
      case FRightPanel.Align of
        alTop,alBottom : if H <> 0 then
          FRightPanel.Height  := (FRightPanel.Height * cy) div H;
        alLeft,alRight :  if Width <> 0 then
          FRightPanel.Width := (FRightPanel.Width * cx) div W;
      end;}
    if FRightPanel.Width > Width then
      FRightPanel.Width := Width div 2;
    if FRightPanel.Height > Height then
      FRightPanel.Width := Height div 2;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomSplitterPanel.WMSetCursor(var Msg: TWMSetCursor);
begin
  with Msg do
    if (csDesigning in ComponentState) and (HitTest = HTCLIENT) then
      if SetSplitterCusrsor(FVertSplitter,fHitPos) then
        exit;

  inherited;
end;

{------------------------------------------------------------------}

function TCustomSplitterPanel.GetChildOwner : TComponent;
begin
  result := self;
end;



{---------------TDCCheckListBox-----------------------------------}
type
  TMStrings = class(TStrings);

{---------------------------------------------------------------}

{$IFNDEF D3}
constructor TDCCheckListBox.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FDatalist := TList.Create;
end;

{---------------------------------------------------------------}

destructor TDCCheckListBox.Destroy ;
begin
  FreeList(FDataList);
  inherited Destroy;
end;

{---------------------------------------------------------------}

procedure TDCCheckListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    if Style and (LBS_OWNERDRAWFIXED or LBS_OWNERDRAWVARIABLE ) = 0 then
      Style := Style or LBS_OWNERDRAWFIXED;
end;

{-------------------------------------------------------------------------}

function TDCCheckListBox.GetStringData ( Index: Integer ): TDCCheckData;
var
  Res : TObject;
begin
  {$IFDEF D3}
  Res :=  TObject(inherited GetItemData( Index ));
  {$ELSE}
  FInternalFlag := true;
  try
    Res :=  TObject(TMStrings(Items).GetObject( Index ));
  finally
    FInternalFlag := false;
  end;
  {$ENDIF}
  if LB_ERR = Integer(Res) then
    raise EListError.CreateFmt(ResStr(SListIndexError) , [Index]);
  if (Res = nil) or (not (Res is TDCCheckData)) then
  begin
    Res := TDCCheckData.Create;
    FDatalist.Add(Res);
    {$IFDEF D3}
    inherited SetItemData(Index, LongInt(Res));
    {$ELSE}
    FInternalFlag := true;
    try
      TMStrings(Items).PutObject( Index, Res)
    finally
      FInternalFlag := false;
    end;
   {$ENDIF}
  end;
  Result := TDCCheckData(Res);
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.SetItemData( Index: Integer; AData: LongInt );
begin
  GetStringData(Index).FData:=AData;
end;

{-------------------------------------------------------------------------}

function TDCCheckListBox.GetItemData( Index: Integer ): LongInt;
begin
  result := GetStringData(Index).FData;
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.DeleteString(Index: Integer);
var
  Data : TDCCheckData;
begin
  Data := GetStringData(Index);
  FDataList.Remove(Data);
  Data.Free;
  {$IFDEF D3}
  inherited;
  {$ENDIF}
end;

{$IFNDEF D3}
{-------------------------------------------------------------------------}

procedure  TDCCheckListBox.LBGETITEMDATA(var Message:TMessage);
begin
  inherited;
  if not FInternalFlag then
    Message.Result := GetItemData(Message.Wparam);
end;

{-------------------------------------------------------------------------}

procedure  TDCCheckListBox.LBSETITEMDATA(var Message:TMessage);
begin
  if not FInternalFlag then
  begin
    SetItemData(Message.Wparam,Message.Lparam);
    Message.Lparam := Integer(GetStringData(Message.Wparam));
  end;
  inherited;
end;

{-------------------------------------------------------------------------}

procedure  TDCCheckListBox.LBDELETESTRING(var Message:TMessage);
begin
  DeleteString(Message.Wparam);
  inherited;
end;
{$ENDIF}
{-------------------------------------------------------------------------}

function TDCCheckListBox.GetCheckWidth: Integer;
begin
  result := DefaultCheckWidth + 2 ;
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.ResetItemHeight;
begin
  if HandleAllocated and (Style = lbStandard) then
  begin
    Canvas.Font := Font;
    FStandardItemHeight := Canvas.TextHeight('Wg'); //don't resource
    Perform(LB_SETITEMHEIGHT, 0, FStandardItemHeight);
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  R: TRect;
  SaveEvent: TDrawItemEvent;
begin

  if Index < Items.Count then
  begin
    R := Rect;
    R.Right := Rect.Left;
    R.Left := R.Right - GetCheckWidth;
    DrawCheck( R, GetState( Index ) );
  end;
  if (Style = lbStandard) and Assigned(OnDrawItem) then
  begin
    SaveEvent := OnDrawItem;
    OnDrawItem := nil;
    try
      inherited;
    finally
      OnDrawItem := SaveEvent;
    end;
  end
  else
    inherited;
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.CNDrawItem(var Message: TWMDrawItem);
begin
    with Message.DrawItemStruct^ do
        rcItem.Left := rcItem.Left + GetCheckWidth;
    inherited;
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.DrawCheck( R: TRect; AState: TCheckBoxState );
var
  DrawState: Integer;
  DrawRect: TRect;
begin
  case AState of
    cbChecked:
      DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
    cbUnchecked:
      DrawState := DFCS_BUTTONCHECK;
    else // cbGrayed
      DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
  end;
  DrawRect.Left := R.Left + (R.Right - R.Left - DefaultCheckWidth) div 2;
  DrawRect.Top := R.Top + (R.Bottom - R.Top - DefaultCheckWidth) div 2;
  DrawRect.Right := DrawRect.Left + DefaultCheckWidth;
  DrawRect.Bottom := DrawRect.Top + DefaultCheckHeight;
  DrawFrameControl( Canvas.Handle,  DrawRect,  DFC_BUTTON,  DrawState);
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.SetChecked( Index: Integer; Checked: Boolean );
begin
  if Checked then
    SetState(Index,cbChecked)
  else
    SetState(Index,cbUnChecked)
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.SetState( Index: Integer; AState: TCheckBoxState );
begin
  if AState <> GetState(Index) then
  begin
    GetStringData(Index).FState := AState;
    InvalidateCheck( Index );
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.InvalidateCheck( Index: Integer );
var
  R: TRect;
begin
  R := ItemRect( Index );
  R.Right := R.Left + GetCheckWidth;
  InvalidateRect(Handle, @R, not (csOpaque in ControlStyle));
  UpdateWindow(Handle);
end;

{-------------------------------------------------------------------------}

function TDCCheckListBox.GetChecked( Index: Integer ): Boolean;
begin
  Result := GetState(Index) = cbChecked;
end;

{-------------------------------------------------------------------------}

function TDCCheckListBox.GetState( Index: Integer ): TCheckBoxState;
begin
  result := GetStringData(Index).FState;
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.KeyPress(var Key: Char);
begin
  inherited;
  if (Key = ' ') then ToggleClickCheck( ItemIndex );
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
begin
  inherited;
  If Button<>mbLeft then
    exit;
  Index := ItemAtPos(Point(X,Y),True);
  if Index <> -1 then
    if X - ItemRect(Index).Left < GetCheckWidth then
      ToggleClickCheck(Index);
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.ToggleClickCheck( Index: Integer );
var
  AState: TCheckBoxState;
begin
  if (Index >= 0) and (Index < Items.Count) then
  begin
    AState := State[Index];
    case AState of
      cbUnchecked:
        if FAllowGrayed then AState := cbGrayed else
          AState := cbChecked;
      cbChecked: AState := cbUnchecked;
      cbGrayed: AState := cbChecked;
    end;
    State[Index] := AState;
    ClickCheck;
  end;
end;

{-------------------------------------------------------------------------}

procedure TDCCheckListBox.ClickCheck;
begin
  if Assigned(FOnClickCheck) then FOnClickCheck(Self);
end;
{$ENDIF}


{ TCustomFormPanel }

Destructor  TDCFormParent.Destroy;
{Var
  Frm:TCustomForm;}
Begin
  FreeObject(FCreatedForm,FCreatedForm);
//  Frm:=Form;
  Form:=Nil;
{  If (Frm<>FCreatedForm) And (FParentControl<>Nil) Then
    FParentControl.RemoveControl(Frm);}
  Inherited;
End;

{----------------------------------------------------------}

Procedure TDCFormParent.Notification(Component:TComponent;Operation:TOperation);
Begin
 Inherited;
  If (Component=FForm) And (Operation=opRemove) Then
    FForm:=Nil;
  If (Component=FFormComponent) And (Operation=opRemove) Then
    FFormComponent:=Nil;
  If (Component=FParentControl) And (Operation=opRemove) Then
    FParentControl:=Nil
End;

{----------------------------------------------------------}

Procedure TDCFormParent.Loaded;
Begin
  Inherited;
  If FFormClass<>Nil Then
  Begin
    FCreatedForm:=TForm(FFormClass.Create(Self));
    FCreatedForm.Visible:=False;
    Form:=FCreatedForm;
  End;
End;

{----------------------------------------------------------}
type
  TMForm = class(TCustomForm)
  end;

Procedure TDCFormParent.SetForm(Value:TCustomForm);
Var
  ParentForm:TCustomForm;
Begin
  Try
    If FForm=Value Then
      Exit;
    If FParentControl=Nil Then
      ParentForm:=Nil
    Else
      ParentForm:=GetParentForm(FParentControl);
    If (ParentForm=Value) And (Value<>Nil) Then
    Begin
      FreeObject(FCreatedForm,FCreatedForm);
      Error(SErrCircularReference);
    End;
    If csDesigning In ComponentState Then
      Exit;
    If FForm<>Nil Then Begin
      If FForm=FCreatedForm Then
      Begin
        FreeObject(FCreatedForm,FCreatedForm);
        FForm:=Nil;
      End
      Else
      Begin
        If FForm.HandleAllocated Then
        Begin
          If TMForm(FForm).FormStyle<>fsMDIChild Then
            FForm.Visible:=False;
//          ShowWindow(FForm.Handle,SW_HIDE);
          If Not FFormSaveVisible Then
            FFormSaveWindowPlacement.showCmd:=SW_HIDE;
          SetParent(FForm.Handle,FFormSaveParent);

          SetWindowPlacement(FForm.Handle,@FFormSaveWindowPlacement);
          SetWindowLong(FForm.Handle,GWL_STYLE,FFormSaveStyle);
          SetWindowLong(FForm.Handle,GWL_EXSTYLE,FFormSaveStyleEx);
          SetWindowPos(FForm.Handle,HWND_BOTTOM,0,0,0,0,SWP_NOMOVE Or SWP_NOSIZE Or
                       SWP_NOZORDER Or SWP_FRAMECHANGED Or SWP_NOACTIVATE);
          If TMForm(FForm).FormStyle<>fsMDIChild Then
            FForm.Visible:=FFormSaveVisible;
          TForm(FForm).Position:=FFormSavePosition;
        End;
      End;
    End;
    FForm:=Value;
    If FParentControl=Nil Then
      Exit;
    If FForm<>Nil Then
    Begin
      FParentControl.HandleNeeded;
      FFormSaveStyle:=GetWindowLong(FForm.Handle,GWL_STYLE);
      FFormSaveStyleEx:=GetWindowLong(FForm.Handle,GWL_EXSTYLE);
      FFormSaveVisible:=FForm.Visible;
      FFormSaveParent:=GetParent(FForm.Handle);
      FFormSavePosition:=TForm(FForm).Position;
      TForm(FForm).Position:=poDesigned;
      GetWindowPlacement(FForm.Handle,@FFormSaveWindowPlacement);

      SetWindowLong(FForm.Handle,GWL_STYLE,(FFormSaveStyle Or WS_CHILD) And Not WS_OVERLAPPED And Not WS_OVERLAPPEDWINDOW And Not WS_CAPTION);
      SetWindowLong(FForm.Handle,GWL_EXSTYLE,FFormSaveStyleEx And Not WS_EX_MDICHILD);
      SetParent(FForm.Handle,FParentControl.Handle);
      SetWindowPos(FForm.Handle,HWND_BOTTOM,0,0,0,0,SWP_NOMOVE Or SWP_NOSIZE Or
                   SWP_NOZORDER Or SWP_FRAMECHANGED Or SWP_NOACTIVATE);
      FForm.Left:=0;
      FForm.Top:=0;
      SizeChanged;
      FForm.Visible:=True;
      FForm.FreeNotification(Self);
    End;
  Except
    FForm:=Nil;
    If csLoading in ComponentState Then
      Application.HandleException(Self)
    Else
      Raise;
  End;
End;

{----------------------------------------------------------}

Procedure TDCFormParent.SetFormClass(Value:TCustomFormClass);
Begin
  FFormClass:=Value;
  If FFormClass<>Nil Then
  Begin
    Try
      If Not (csLoading in ComponentState) Then
      Begin
        FCreatedForm:=CreateFormWithClass(FFormClass);
        Form:=FCreatedForm;
      End;
    Except
      If csLoading in ComponentState Then
        Application.HandleException(Self)
      Else
        Raise;
    End;
  End
  Else
    Form:=Nil;
End;

{----------------------------------------------------------}

Procedure TDCFormParent.SetFormClassName(const Value:String);
Begin
  Try
    FFormClassName:=Value;
    If csDesigning In ComponentState Then
      Exit;
    If FCreatedForm<>Nil Then
    Begin
      Form:=Nil;
      FreeObject(FCreatedForm,FCreatedForm);
    End;
    If Value='' Then
      Form:=Nil
    Else
    Begin
      If FForm<>Nil Then
        Exit;
      FormClass:=TFormClass(FindClass(FFormClassName));
    End;
  Except
    If csLoading in ComponentState Then
      Application.HandleException(Self)
    Else
      Raise;
  End;
End;

{----------------------------------------------------------}

Procedure TDCFormParent.SetFormComponent(Value:TComponent);
Begin
  If FFormComponent=Value Then
    Exit;
  If Value=Nil Then
    Form:=Nil
  Else
  Begin
    Form:=GetPForm(Value) As TForm;
    Value.FreeNotification(Self);
  End;
  FFormComponent:=Value;
End;

{----------------------------------------------------------}

Procedure TDCFormParent.SetParentControl(Value:TWinControl);
Begin
  If FParentControl=Value Then
    Exit;
  FParentControl:=Value;
  If FParentControl=Nil Then
    Form:=Nil
  Else
  Begin
    FParentControl.FreeNotification(Self);
    Form:=FForm;
  End;  
End;

{----------------------------------------------------------}

Procedure TDCFormParent.SizeChanged;
Begin
  If (FForm=Nil) Or (FParentControl=Nil)Then
    Exit;
  FForm.Width:=FParentControl.ClientWidth;
  FForm.Height:=FParentControl.ClientHeight;
End;

{ TDCCustomFormPanel }

Constructor TCustomDCFormPanel.Create(AOwner:TComponent);
Begin
  Inherited;
  FFormParent:=TDCFormParent.Create(Self);
  FFormParent.ParentControl:=Self;
End;

{----------------------------------------------------------}

Destructor TCustomDCFormPanel.Destroy;
Begin
  FFormParent.Free;
  Inherited;
End;

{----------------------------------------------------------}

Function TCustomDCFormPanel.GetForm:TCustomForm;
Begin
  Result:=FFormParent.Form;
End;

{----------------------------------------------------------}

Function TCustomDCFormPanel.GetFormClass:TCustomFormClass;
Begin
  Result:=FFormParent.FormClass;
End;

{----------------------------------------------------------}

Function TCustomDCFormPanel.GetFormClassName:String;
Begin
  Result:=FFormParent.FormClassName;
End;

{----------------------------------------------------------}

Function TCustomDCFormPanel.GetFormComponent:TComponent;
Begin
  Result:=FFormParent.FormComponent;
End;

{----------------------------------------------------------}

Procedure TCustomDCFormPanel.SetForm(Value:TCustomForm);
Begin
  FFormParent.Form:=Value;
End;

{----------------------------------------------------------}

Procedure TCustomDCFormPanel.SetFormClass(Value:TCustomFormClass);
Begin
  FFormParent.FormClass:=Value;
End;

{----------------------------------------------------------}

Procedure TCustomDCFormPanel.SetFormClassName(const Value:String);
Begin
  FFormParent.FormClassName:=Value;
End;

{----------------------------------------------------------}

Procedure TCustomDCFormPanel.SetFormComponent(Value:TComponent);
Begin
  FFormParent.FormComponent:=Value;
End;

{----------------------------------------------------------}

Procedure TCustomDCFormPanel.WMSize(Var Message:TMessage);
Begin
  Inherited;
  FFormParent.SizeChanged;
End;

{ TDCFormTabSheet }

type
  _THookControl = class(TControl)
    procedure CMDialogKey(var Msg : TMessage); message CM_DIALOGKEY;
  end;

procedure _THookControl.CMDialogKey(var Msg : TMessage);
begin
  if Owner is TControl then
    GetParentForm(TControl(Owner)).Dispatch(Msg);
end;

{----------------------------------------------------------}

Constructor TDCFormTabSheet.Create(AOwner:TComponent);
Begin
  Inherited;
  FFormParent:=TDCFormParent.Create(Self);
  FFormParent.ParentControl:=Self;
End;

{----------------------------------------------------------}

Destructor TDCFormTabSheet.Destroy;
Begin
  Form := nil;
  FFormParent.Free;
  Inherited;
End;

{----------------------------------------------------------}

Function TDCFormTabSheet.GetForm:TCustomForm;
Begin
  Result:=FFormParent.Form;
End;

{----------------------------------------------------------}

Function TDCFormTabSheet.GetFormClass:TCustomFormClass;
Begin
  Result:=FFormParent.FormClass;
End;

{----------------------------------------------------------}

Function TDCFormTabSheet.GetFormClassName:String;
Begin
  Result:=FFormParent.FormClassName;
End;

{----------------------------------------------------------}

Function TDCFormTabSheet.GetFormComponent:TComponent;
Begin
  Result:=FFormParent.FormComponent;
End;

{----------------------------------------------------------}

Procedure TDCFormTabSheet.SetForm(Value:TCustomForm);
var
  f : TCustomForm;
Begin
  f := FFormParent.Form;
  if f <> nil then
    begin
      f.RemoveControl(fHookControl);
      fHookControl.Free;
      fHookControl := nil;
    end;
  FFormParent.Form:=Value;
  if Value <> nil then
    begin
      fHookControl := _THookControl.Create(self);
      Value.InsertControl(fHookControl);
    end;
End;

{----------------------------------------------------------}

Procedure TDCFormTabSheet.SetFormClass(Value:TCustomFormClass);
Begin
  FFormParent.FormClass:=Value;
End;

{----------------------------------------------------------}

Procedure TDCFormTabSheet.SetFormClassName(const Value:String);
Begin
  FFormParent.FormClassName:=Value;
End;

{----------------------------------------------------------}

Procedure TDCFormTabSheet.SetFormComponent(Value:TComponent);
Begin
  FFormParent.FormComponent:=Value;
End;

{----------------------------------------------------------}

Procedure TDCFormTabSheet.WMSize(Var Message:TMessage);
Begin
  Inherited;
  FFormParent.SizeChanged;
End;


Procedure Register;
Begin
  RegisterComponents(SPalDream,[TDCSplitter,TDCCheckListBox,TDCSplitPanel,
    TDCFormParent,TDCFormPanel,TDCHint]);
End;
end.
