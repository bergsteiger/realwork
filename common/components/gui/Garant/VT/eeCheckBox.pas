unit eeCheckBox;

{$Include vtDefine.inc}

interface

uses
  Windows,
  Messages,
  Graphics,
  SysUtils,
  Classes,
  Controls,
  StdCtrls;

type

  TeeCustomCheckBox = class(TCustomCheckBox)
  private
    f_PrevCharCode : Word;
  protected
    function  IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
    procedure WMChar(Var Msg: TWMChar); message WM_CHAR;
    procedure WMKeyDown(Var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Msg: TWMSysKeyDown); message WM_SYSKEYDOWN;
  public
  // public methods
   constructor Create(AOwner:TComponent);
     override;
     {-}
    protected
      property ParentFont
        default false;
        {-}    
  end;//TeeCustomCheckBox

  TeeCheckBox = class(TeeCustomCheckBox)
  published
    property Action;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    property Color nodefault;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State;
    property TabOrder;
    property TabStop;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;//TeeCheckBox

  TeeCheckBox1 = class(TeeCheckBox)
  private
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
      procedure WMLButtonDown(var Msg : TMessage{TWMLButtonDown});
        message WM_LBUTTONDOWN;
        {-}
  protected
    function CanFocus: Boolean; override;
    procedure WndProc(var Message: TMessage); override;
  end;//TeeCheckBox1

implementation

uses
  {$IfDef eeNeedOvc}
  OvcBase,
  OvcCmd,
  OvcConst,
  {$EndIf eeNeedOvc}

  afwFont,
  afwVCL
  ;

constructor TeeCustomCheckBox.Create(AOwner:TComponent);
  //override;
  {-}
begin
 inherited Create(AOwner);
 afwHackControlFont(Self);
end;

function TeeCustomCheckBox.IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
{$IfDef eeNeedOvc}
var
 l_Controller : TOvcController;
{$EndIf eeNeedOvc}
begin
 f_PrevCharCode := 0;
 Result := false;
 {$IfDef eeNeedOvc}
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([], TMessage(Msg), GetTickCount) = ccShortCut then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    f_PrevCharCode := Msg.CharCode;
    Result := true;
   end;
 {$EndIf eeNeedOvc}
end;

procedure TeeCustomCheckBox.WMChar(Var Msg: TWMChar);
begin
 if (f_PrevCharCode <> 0) and (Msg.CharCode = f_PrevCharCode) then
   Exit;
 inherited;
end;

procedure TeeCustomCheckBox.WMKeyDown(Var Msg: TWMKeyDown);
begin
 if IsHandledShortcut(Msg) then
   Exit;
 inherited;
end;

procedure TeeCustomCheckBox.WMSysKeyDown(var Msg: TWMSysKeyDown);
begin
 if IsHandledShortcut(Msg) then
   Exit;
 inherited;
end;

// start class TeeCheckBox1

procedure TeeCheckBox1.WMMouseActivate(var Message: TMessage);
begin
 if not (csDesigning in ComponentState) then
  Message.Result := MA_NOACTIVATE
 else
  inherited;
end;

procedure TeeCheckBox1.WMLButtonDown(var Msg : TMessage{TWMLButtonDown});
  //message WM_LBUTTONDOWN;
  {-}
begin
 if not (csDesigning in ComponentState) then
  Checked := not Checked
 else
  inherited;
end;

function TeeCheckBox1.CanFocus: Boolean;
begin
 if not (csDesigning in ComponentState) then
  Result := false
 else
  Result := inherited CanFocus;
end;

procedure TeeCheckBox1.WndProc(var Message: TMessage);
begin
 case Message.Msg of
   WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
     if not (csDesigning in ComponentState) then
     begin
      Checked := not Checked;
      Exit;
     end;//not (csDesigning in ComponentState)
 end;//case Message.Msg
 inherited;
end;

end.
