unit vtCombo;

{ $Id: vtCombo.pas,v 1.54 2015/02/25 13:18:08 lulin Exp $ }

// $Log: vtCombo.pas,v $
// Revision 1.54  2015/02/25 13:18:08  lulin
// - перегенерация.
//
// Revision 1.53  2015/01/15 13:50:22  lulin
// {RequestLink:585926571}. Используем Interlocked.
//
// Revision 1.52  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.51  2012/11/01 09:42:28  lulin
// - забыл точку с запятой.
//
// Revision 1.50  2012/11/01 07:44:16  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.49  2012/04/02 12:17:57  kostitsin
// vtCombo
//
// Revision 1.48  2009/09/07 06:54:28  lulin
// - чистка кода.
//
// Revision 1.47  2009/09/02 11:48:58  lulin
// {RequestLink:159360578}. №20.
//
// Revision 1.46  2009/01/30 13:51:40  lulin
// - чистка кода.
//
// Revision 1.45  2009/01/21 14:43:57  lulin
// - боремся с родительским шрифтом (подробности у Вована).
//
// Revision 1.44  2008/04/03 07:48:49  voba
// - bug fix не вызывалось OnDropDown если не присвоен DropDownContainer
//
// Revision 1.43  2008/02/14 19:32:34  lulin
// - изменены имена файлов с примесями.
//
// Revision 1.42  2008/02/14 14:12:19  lulin
// - <K>: 83920106.
//
// Revision 1.41  2008/02/07 08:37:48  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.40  2008/01/25 12:06:55  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.39  2008/01/25 11:32:10  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.38  2007/12/12 12:17:18  voba
// - cc
//
// Revision 1.37  2007/03/14 12:27:26  lulin
// - не записываем мусор.
//
// Revision 1.36  2007/01/18 10:49:37  lulin
// - заменяем объект менеджера памяти на интерфейс.
//
// Revision 1.35  2006/12/28 13:35:59  lulin
// - bug fix: AV при выходе из приложения (CQ OIT5-24042).
//
// Revision 1.34  2006/12/08 15:03:54  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.33  2006/12/08 14:21:06  lulin
// - очищаем кешированные компоненты так, как будто они заново родились.
//
// Revision 1.32  2006/06/08 13:38:06  lulin
// - подготавливаем контролы к обработке числа повторений нажатия клавиши.
//
// Revision 1.31  2006/04/14 13:40:27  lulin
// - запрещаем перекрывать деструктор.
//
// Revision 1.30  2005/11/03 10:26:13  mmorozov
// change: после обработки сообщения возвращаем правильный результат;
//
// Revision 1.29  2005/05/12 14:33:51  lulin
// - new method: _Tafw.IsObjectLocked.
//
// Revision 1.28  2005/01/14 17:24:24  lulin
// - в ProcessCommand добавлен параметр aForce - сигнализирующий, что такого ShortCut'а нету в VCM и что не надо умничать с обработкой комманды.
//
// Revision 1.27  2004/12/29 14:58:43  voba
// - add TvtSimpleComboEdit - для вызова внешней формы редактирования
//
// Revision 1.26  2004/12/21 13:34:55  am
// change: прикрутил к vtCombo Il3CommandTarget
//
// Revision 1.25  2004/11/19 16:33:07  lulin
// - bug fix: съедались двухбуквенные ShortCut'ы.
//
// Revision 1.24  2004/08/18 08:46:19  voba
// - disable uses Themes for D6
//
// Revision 1.23  2004/08/17 14:13:49  fireton
// - календарик теперь поддерживает темы Windows XP
// - bug fix: правильный ресайз кнопки у TvtCustomCombo
//
// Revision 1.22  2004/08/13 17:53:40  mmorozov
// new: property TvtCustomCombo.TextBottom;
//
// Revision 1.21  2004/08/12 12:18:39  am
// change: BeginPaint\EndPaint в WMPaint
//
// Revision 1.20  2004/07/30 13:08:12  am
// change: прикрутил лок к кнопке и комбо
//
// Revision 1.19  2004/07/30 11:46:44  mmorozov
// new: method TBtnWinControl.IsLockPaint (замораживание отрисовки);
//
// Revision 1.18  2004/07/29 11:41:49  mmorozov
// change: обработка shortcut-ов перенесена из WMKeyDown в CNKeyDown (т.е. WMChar уже не придет и выделенный в поле даты текст не будет удален);
//
// Revision 1.17  2004/07/09 13:37:31  fireton
// - bug fix: открытие/закрытие drop'а при нажатии мышкой на кнопку
//
// Revision 1.16  2004/07/06 15:07:19  fireton
// - bug fix: Range Check Error при отпускании мышки вне drop-down кнопки
// - bug fix: закрыте календарика при отпускании мышки на нем
//
// Revision 1.15  2004/03/10 14:12:05  nikitin75
// + shortcuts support (WM_SYSKEYDOWN handler, enter|escape check);
//
// Revision 1.14  2004/03/03 14:07:21  nikitin75
// + поддержка OvcController;
//
// Revision 1.13  2004/02/26 12:00:08  am
// change: CMControlListChange
//
// Revision 1.12  2004/02/26 11:55:25  am
// change: сообщение CM_LISTCHANGED для TvtCombo не прокидывается выше(дефолтное поведение).
// иначе имеем такую ситуацию. При выставлении TPopupCalendar.Parent = TvtEdit - сообщение
// поднимается по цепочке Parent'ов. Если в цепочке есть тулбар - он поймает сообщение и
// посчитает, что в него вставили этот контрол (TPopupCalendar).
//
// Revision 1.11  2004/01/21 13:11:59  mmorozov
// new: метод DoCloseUp вызывается в CloseUp;
//
// Revision 1.10  2003/12/10 12:20:58  fireton
// update: popup корректно масштабируется при больших шрифтах в системе
//
// Revision 1.9  2003/12/04 14:56:55  fireton
// - update: в хуке PostMessage заменен на SendMessage (для избещания посылки избыточных сообщений)
//
// Revision 1.8  2003/04/19 11:24:49  law
// - new file: vtDefine.inc.
//
// Revision 1.7  2002/07/11 08:49:16  voba
// no message
//
// Revision 1.6  2002/06/20 06:27:13  voba
// no message
//
// Revision 1.5  2001/02/02 07:36:43  voba
// no message
//
// Revision 1.4  2000/12/15 15:36:29  law
// - вставлены директивы Log.
//

{$Include vtDefine.inc }

interface

uses
  Forms, Menus, SysUtils, Windows, Graphics, Messages, Classes,
  Controls, Buttons, Mask, StdCtrls, TypInfo, Dialogs,
  ImgList, vtStdRes,

  l3MinMax,
  l3InternalInterfaces,
  l3Types,
  l3Interfaces;

type
  TvtComboButtonStyle = (cbsEllipsis, cbsDownArrow, cbsDefault);
  TvtComboStyle = (csDropDown, csDropDownList);
  TvtAlignVertical = (avTop, avCenter);
  TvtComboCloseUpEvent = procedure(Sender: TObject; Select: boolean) of object;

  TvtOnGetDropDownControl = procedure(Sender: TObject; var aDropDownControl : TWinControl) of object;

  TvtDropDownButton = class(TSpeedButton)
  private
    //procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
  protected
    //procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    //procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
  end;

  _l3Unknown_Parent_ = TCustomMaskEdit;
  {$Define _UnknownIsComponent}
  {$Include l3Unknown.imp.pas}
  TvtSimpleCustomCombo = class(_l3Unknown_,
                               Il3CommandTarget)
  private
    fAlignmentVertical   : TvtAlignVertical;
    fBtnParent           : TWinControl;
    fButton              : TvtDropDownButton;
    ///fDropDownCount       : Integer;
    fOnCustomDlg         : TNotifyEvent;
    fOnCloseUp           : TvtComboCloseUpEvent;
    fOnDropDown          : TNotifyEvent;
    fButtonStyle         : TvtComboButtonStyle;
    fCanvas,
    fPaintCanvas         : TControlCanvas;
    fStyle               : TvtComboStyle;
    fReadOnly            : boolean;
    fAllowClearKey       : boolean;

    fOnMouseEnterControl : TMouseEvent;
    fOnMouseLeaveControl : TMouseEvent;

    fSavedCursor         : TCursor;
    fIgnoreCursorChange  : Boolean;
    fDroppedDown         : boolean;

    fDirectInput         : Boolean;

    fImageIndex          : TImageIndex;
    fImages              : TCustomImageList;
    fImageChangeLink     : TChangeLink;

    procedure CMCursorChanged(var Message: TMessage); message CM_CURSORCHANGED;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var Message: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSysKeyDown(var Msg : TWMSysKeyDown); message WM_SYSKEYDOWN;

    function  IsHandledShortcut(var Msg: TWMKeyDown): Boolean;

    // Property Access Methods
    ///function GetDataField: string;
    ///function GetDataSource: TDataSource;
    function  GetReadOnly: Boolean;
    procedure SetButtonStyle(Value: TvtComboButtonStyle);
    ///procedure SetDataField(Value: string);
    ///procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetStyle(Value: TvtComboStyle);
    procedure SetAlignmentVertical(Value: TvtAlignVertical);
    function  GetDirectInput: Boolean;
    procedure SetDirectInput(Value: Boolean);
    procedure SetImages(Value: TCustomImageList);
    function  GetImages : TCustomImageList;
    procedure SetImageIndex(Value: TImageIndex);
    function  IsImageListStored : boolean;
    procedure ImageListChange(Sender: TObject);
  protected
      {$IfDef DesignTimeLibrary}
      function CheckStamp(const aGUID: TGUID): Boolean;
        {-}
      {$EndIf DesignTimeLibrary}
    function  ProcessCommand(Cmd    : Tl3OperationCode;
                             aForce : Boolean;
                             aCount : Integer): Boolean;
      virtual;
      {-}
    function InUpdating: boolean; virtual;
    ///function  GetItemCount: Integer; virtual; abstract;
    ///function  GetItemSize: TSize; virtual; abstract;
    function  GetLeftIndent: Integer; virtual;
    procedure BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DrawButton(Canvas: TCanvas; R: TRect; State: TButtonState; ControlState: TControlState; var DefaultPaint:boolean); virtual;
    procedure HideCaret; virtual;
    procedure Paint; virtual;
    procedure ShowCaret; virtual;

    // Virtual Property Access Methods
    function  GetShowButton: Boolean; virtual;
    procedure SetModified(Value: Boolean); virtual;
    procedure SetShowButton(Value: Boolean);

    // Virtual Methods
    function  Editable: Boolean; virtual;
    function  EditCanModify: Boolean; override; //virtual;
    function  GetClientEditRect: TRect; virtual;
    function  GetEditRect: TRect; virtual;
    function  GetIconIndent: Integer; virtual;
    function  GetIconLeft: Integer; virtual;
    procedure DoDropDown; virtual;
    procedure DoCloseUp(Accept: boolean); virtual;
    procedure DataChange(Sender: TObject); virtual;
    procedure EditingChange(Sender: TObject); virtual;
    procedure HandleDropDownKeys(var Key: Word; Shift: TShiftState); virtual;
    ///procedure HandleGridKeys(var Key: Word; Shift: TShiftState); virtual;
    procedure Reset; override; //virtual;
    procedure SetEditRect; virtual;
    procedure UpdateButtonPosition; virtual;
    procedure UpdateData(Sender: TObject); virtual;
    function EffectiveReadOnly: Boolean; virtual;
    function GetRightIndent(Rect:TRect): Integer; virtual;
    function GetTopIndent: Integer; virtual;

    // Overridden Methods
    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure WndProc(var Message: TMessage); override;
    procedure PaintToCanvas(Canvas: TCanvas; Rect: TRect; Highlight, GridPaint: Boolean; Text: string); virtual; abstract;

    property Canvas: TControlCanvas read FCanvas;
    property BtnParent: TWinControl read FBtnParent;
    {$I l3DefineCleanup.inc}
  public
    constructor Create(AOwner:tcomponent);
      override;

    procedure SelectAll; virtual;
    function  IsDroppedDown: Boolean; virtual;
    procedure DropDown; virtual;
    procedure CloseUp(Accept: Boolean); virtual;

    property AlignmentVertical: TvtAlignVertical read FAlignmentVertical write SetAlignmentVertical default avTop;
    property AllowClearKey: boolean read FAllowClearKey write FAllowClearKey default False;
    property Button: TvtDropDownButton read FButton;
    property ButtonStyle: TvtComboButtonStyle 
      read FButtonStyle 
      write SetButtonStyle
      default cbsDownArrow;
      {-}
    //property DropDownCount: Integer read FDropDownCount write SetDropDownCount;
    property ReadOnly: Boolean 
      read GetReadOnly 
      write SetReadOnly
      default false;
      {-}
    property ShowButton: boolean read GetShowButton write SetShowButton default True;
    property Style: TvtComboStyle read FStyle write SetStyle;
    property OnCustomDlg: TNotifyevent read FOnCustomDlg write FOnCustomDlg;
    property OnCloseUp: TvtComboCloseUpEvent read FOnCloseUp write FOnCloseUp;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property DirectInput: Boolean read GetDirectInput write SetDirectInput default True;
    property OnMouseEnterControl: TMouseEvent read FOnMouseEnterControl write FOnMouseEnterControl;
    property OnMouseLeaveControl: TMouseEvent read FOnMouseLeaveControl write FOnMouseLeaveControl;
    property Images: TCustomImageList read GetImages write SetImages stored IsImageListStored;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property DroppedDown: Boolean read FDroppedDown;
    protected
      property ParentFont
        default false;
        {-}
  end;

  TvtCustomCombo = class(TvtSimpleCustomCombo,
                         Il3MouseListener)
   private
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    // Il3MouseListener
    procedure MouseListenerNotify(aMouseMessage: WPARAM;
                                  aHookStruct: PMouseHookStruct;
                                  var theResult: Tl3HookProcResult);
   protected
    function  GetDropDownContainer: TWinControl; virtual; abstract;
    function  GetDropDownControl: TWinControl; virtual;
    procedure SetDropDownControl(Value: TWinControl); virtual;

    property DropDownContainer: TWinControl read GetDropDownContainer;
    procedure Cleanup; override;
   public
    procedure CheckCancelMode; virtual;
    procedure CloseUp(Accept: Boolean); override;
    procedure DropDown; override;
    property DropDownControl: TWinControl read GetDropDownControl write SetDropDownControl;
   end;

  TvtCustomListCombo = class(TvtCustomCombo)
   protected
    fDropDownCount       : Integer;
    procedure SetDropDownCount(Value: Integer); virtual;
    function  GetItemCount: Integer; virtual; abstract;
    function  GetItemSize: TSize; virtual; abstract;
   public
    constructor Create(AOwner:tcomponent); override;
    procedure DropDown; override;
    property ItemCount: Integer read GetItemCount;
    property ItemSize: TSize read GetItemSize;
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount;
  end;


  TvtComboEdit = class(TvtCustomCombo)
   protected
    fOnGetDropDownControl : TvtOnGetDropDownControl;

    procedure SetDropDownControl(Value: TWinControl); override;
    function  GetDropDownControl: TWinControl;        override;
    function  GetDropDownContainer: TWinControl;      override;
    ///function  GetItemCount: Integer;                  override;
    ///function  GetItemSize: TSize;                     override;

  published
    property OnGetDropDownControl : TvtOnGetDropDownControl read fOnGetDropDownControl write fOnGetDropDownControl;

    {$ifdef Delphi4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;
    {$endif}

    ///property UnboundAlignment;
    property AlignmentVertical;
    property AllowClearKey;
    ///property AutoDropDown;
    property AutoSelect;
    property AutoSize;
    property ShowButton;
    property BorderStyle;
    property ButtonStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    ///property DropDownCount;
    ///property DropDownWidth;
    property Enabled;
    property Font;
    {$ifdef Delphi3}
    property ImeMode;
    property ImeName;
    {$endif}

    property Images;
    property ImageIndex;

    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property Style default csDropDownList;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnCloseUp;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
end;

TvtSimpleComboEdit = class(TvtSimpleCustomCombo)
  published

    {$ifdef Delphi4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;
    {$endif}

    ///property UnboundAlignment;
    property AlignmentVertical;
    property AllowClearKey;
    ///property AutoDropDown;
    property AutoSelect;
    property AutoSize;
    property ShowButton;
    property BorderStyle;
    property ButtonStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    ///property DropDownCount;
    ///property DropDownWidth;
    property Enabled;
    property Font;
    {$ifdef Delphi3}
    property ImeMode;
    property ImeName;
    {$endif}

    property Images;
    property ImageIndex;

    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property Style default csDropDownList;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnCloseUp;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
end;

var
 WM_vt_CALLDROPDOWN: UINT = 0;
 WM_vt_CALLCLOSEUP: UINT = 0;


function vtCenterRect(aMainRect, aSubRect : TRect) : TRect;

implementation

uses
  l3Base,
  l3ListenersManager,
  l3Interlocked,

  {$IfDef evNeedOvc}
  OvcBase, OvcCmd, OvcConst, Types,
  {$IfDef Delphi7}
  Themes,
  {$EndIf Delphi7}
  {$EndIf evNeedOvc}

  afwFacade,
  afwVCL
  ;

{$Include l3Unknown.imp.pas}
 
procedure vtDrawEllipsis(Canvas: TCanvas; R: TRect; State: TButtonState;
    Enabled: Boolean; ControlState: TControlState);
 var Flags: Integer;
    DC: HDC;
    w: integer;
    LeftIndent, TopIndent: integer;
 begin
  Flags:= 0;
  if (State = bsDown) and not (csPaintCopy in ControlState) then
    Flags := BF_FLAT;
  DC:= Canvas.Handle;
  DrawEdge(DC, R, EDGE_RAISED, BF_RECT or BF_MIDDLE or Flags);
  LeftIndent:= ((R.Right - R.Left) shr 1) - 1 + Ord(State=bsDown);
  TopIndent:= ((R.Bottom+1-R.Top) shr 1) - 1 + Ord(State=bsDown);
  W := (R.Right+1 - R.Left) shr 3;
  if W = 0 then W := 1;
  PatBlt(DC, R.Left + LeftIndent, R.Top + TopIndent, W, W, BLACKNESS);
  PatBlt(DC, R.Left + LeftIndent - (W * 2), R.Top + TopIndent, W, W, BLACKNESS);
  PatBlt(DC, R.Left + LeftIndent + (W * 2), R.Top + TopIndent, W, W, BLACKNESS);
end;

procedure vtDrawDropDownArrow(Canvas: TCanvas; R: TRect;
    State: TButtonState; Enabled: Boolean; ControlState: TControlState);
 var Flags: Integer;
 begin
  if not Enabled then Flags := DFCS_SCROLLCOMBOBOX or DFCS_INACTIVE
  else if (State=bsUp) or (csPaintCopy in ControlState) then
    Flags := DFCS_SCROLLCOMBOBOX
  else Flags := DFCS_SCROLLCOMBOBOX or DFCS_FLAT or DFCS_PUSHED;
  DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, Flags);
 end;


type
 TBtnWinControl = class(TWinControl)
  private
  // internal methods
    function InUpdating : Boolean;
  private
  // messages
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
  end;

procedure TvtDropDownButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if not PtInRect(Clientrect, Point(x, y)) then
  begin
    Perform(WM_LBUTTONUP, 0, 0{MAKELPARAM(x, y)});
    ReleaseCapture;
  end;
end;

procedure TvtDropDownButton.Paint;
var R : TRect;
    DefaultPaint:boolean;
begin
  SetRect(R, 0, 0, ClientWidth, ClientHeight);
  with TvtSimpleCustomCombo(Parent.Parent) do
  begin
    DefaultPaint:= True;
    DrawButton(self.Canvas, R, FState, ControlState, DefaultPaint);
    if DefaultPaint then inherited Paint;
  end;
end;

constructor TvtSimpleCustomCombo.Create;
 begin
  inherited Create(AOwner);
  afwHackControlFont(Self);

  ControlStyle := ControlStyle + [csReplicatable];

  fCanvas := TControlCanvas.Create;
  fCanvas.Control := self;

  fAlignmentVertical := avTop;
  fButtonStyle := cbsDownArrow;
  ///fDropDownCount := 8;

  fBtnParent := TBtnWinControl.Create(Self);
  with fBtnParent do
   begin
    ControlStyle := ControlStyle + [csReplicatable];
    Width := Max(GetSystemMetrics(SM_CXVSCROLL) + 4, 17);
    Height := 17;
    Visible := True;
    Parent := Self;
   end;

  fButton := TvtDropDownButton.Create(self);
  with fButton do
   begin
    ControlStyle := ControlStyle + [csReplicatable];
    SetBounds (0, 0, FBtnParent.Width, FBtnParent.Height);
    Width := Max(GetSystemMetrics(SM_CXVSCROLL), 17);
    Parent := FBtnParent;
    OnMouseDown := BtnMouseDown;
   end;

  {FDataLink := TFieldDataLink.Create;
  FDataLink.Control := self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;}

  fDirectInput := True;
  fSavedCursor := crIBeam;

  fImageChangeLink := TChangeLink.Create;
  fImageChangeLink.OnChange := ImageListChange;
  fImageIndex := -1;
 end;

type
 _Unknown_Child_ = TvtSimpleCustomCombo;
{$I l3ImplCleanup.inc}
begin
 fImages := nil;
 FreeAndNil(fImageChangeLink);
 FreeAndNil(fCanvas);
 FreeAndNil(fPaintCanvas);
 inherited;
end;

function TvtSimpleCustomCombo.GetIconIndent: Integer;
 begin
  Result:= fBtnParent.Width;
 end;

function TvtSimpleCustomCombo.GetIconLeft: Integer;
 begin
  Result:= fBtnParent.Left - 1;
 end;

function TvtSimpleCustomCombo.GetShowButton: Boolean;
 begin
  Result:= fBtnParent.Visible;
 end;

procedure TvtSimpleCustomCombo.SetShowButton(Value: Boolean);
begin
  if (fBtnParent.Visible <> Value) then
  begin
    fBtnParent.Visible := Value;
    UpdateButtonPosition;
    if not (csLoading in Owner.ComponentState) then SetEditRect;
    Invalidate;
  end
end;

function vtCenterRect(aMainRect, aSubRect : TRect) : TRect;
 var
  lWidth,
  lHeight : Integer;
 begin
  With aSubRect do
   begin
    lWidth  := Right - Left;
    lHeight := Bottom - Top;
   end;
  With Result do
   begin
    Left   := (aMainRect.Right - aMainRect.Left - lWidth) div 2;
    Top    := (aMainRect.Bottom - aMainRect.Top - lHeight) div 2;
    Right  := Left + lWidth;
    Bottom := Top  + lHeight;
   end;
 end;

procedure TvtSimpleCustomCombo.DrawButton(Canvas: TCanvas; R: TRect; State: TButtonState;
    ControlState: TControlState; var DefaultPaint: Boolean);
 var
  Flags: Integer;
 {$IfDef Delphi7}
  lButton: TThemedButton;
  lDetails: TThemedElementDetails;
{$EndIf Delphi7}
 begin
  DefaultPaint := False;
  case ButtonStyle of
   cbsDownArrow : vtDrawDropDownArrow(Canvas, R, State, Enabled, ControlState);
   cbsEllipsis  : vtDrawEllipsis(Canvas, R, State, Enabled, ControlState);
   cbsDefault   :
    begin
   {$IfDef Delphi7}
     if ThemeServices.ThemesEnabled then
     begin
      if State = bsDisabled then
       lButton := tbPushButtonDisabled
      else
       if State = bsDown then
        lButton := tbPushButtonPressed
       else
        lButton := tbPushButtonNormal;
      lDetails := ThemeServices.GetElementDetails(lButton);
      ThemeServices.DrawElement(Canvas.Handle, lDetails, R);
      //R := ThemeServices.ContentRect(Canvas.Handle, lDetails, R);
     end
     else
   {$EndIf Delphi7}
     begin
      Flags := BF_RECT or BF_MIDDLE;
      If (State = bsDown) and not (csPaintCopy in ControlState) then
       Flags := Flags or BF_FLAT;
      DrawEdge(Canvas.Handle, R, EDGE_RAISED, Flags);
     end;
     R := vtCenterRect(R, Rect(0, 0, Images.Width, Images.Height));
     If (State = bsDown) {$IfDef Delphi7} and not ThemeServices.ThemesEnabled {$EndIf Delphi7} then
     begin
      Inc(R.Left);
      Inc(R.Top);
     end;
     If (FImageIndex <> -1)
      then Images.Draw(Canvas, R.Left, R.Top, FImageIndex, True {Enabled});
    end
  end;
 end;

procedure TvtSimpleCustomCombo.CreateParams(var Params: TCreateParams);
 begin
  inherited CreateParams(Params);
  with Params do
    Style := Style and not (ES_AUTOVSCROLL or ES_WANTRETURN) or
      WS_CLIPCHILDREN or ES_MULTILINE;
 end;

procedure TvtSimpleCustomCombo.CreateWnd;
begin
  inherited;
  SetEditRect;
end;

function TvtSimpleCustomCombo.GetEditRect: TRect;
begin
  result.Bottom := ClientHeight + 1;
  if ShowButton then result.Right := FBtnParent.Left - 1
  else result.Right := ClientWidth - 2;

  { RSW - 3/27/99 }
  Result.Top := GetTopIndent;
  if (BorderStyle = bsNone) then
   Result.Left := 1
  else
   Result.Left := 0;

  inc(result.Left, GetLeftIndent);
end;

procedure TvtSimpleCustomCombo.SetEditRect;
var r: TRect;
begin
  Canvas.font:= Font; { 4/14/99 }
  r := GetEditRect;
  SendMessage(Handle, EM_SETRECTNP, 0, LPARAM(@r));
end;

procedure TvtSimpleCustomCombo.UpdateButtonPosition;
begin
 FButton.Width := Height-4;
 if (not NewStyleControls) or (BorderStyle = bsNone) or (not Ctl3d) then
   FBtnParent.SetBounds(Width - FButton.Width, 0, FButton.Width, ClientHeight)
 else
   FBtnParent.SetBounds(Width - FButton.Width - 4, 0, FButton.Width, ClientHeight);

 if not FBtnParent.Visible and (csDesigning in ComponentState) then
   FBtnParent.Left := BoundsRect.Right;

 if BorderStyle = bsNone then
 begin
   FButton.Top := -1;
   FButton.Height := FBtnParent.Height+1;
 end else begin
   FButton.Top:= 0;
   FButton.Height := FBtnParent.Height;
 end;

 SetEditRect;
end;

procedure TvtSimpleCustomCombo.DoCloseUp(Accept: boolean);
begin
   if Assigned(FOnCloseUp) then FOnCloseUp(self, Accept);
end;

procedure TvtSimpleCustomCombo.CloseUp(Accept: boolean);
begin
end;

procedure TvtSimpleCustomCombo.DataChange(Sender: TObject);
begin
  {if FDataLink.Field <> nil then
  begin
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType = ftString) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;
    if Focused and FDataLink.CanModify then
      Text := FDataLink.Field.Text
    else begin
      Text := FDataLink.Field.DisplayText;
      if FDataLink.Editing then
        Modified := True;
    end;
  end else }
  begin
    if csDesigning in ComponentState then
      Text := Name else
      Text := '';
  end;
end;

procedure TvtSimpleCustomCombo.EditingChange(Sender: TObject);
begin
  ///inherited ReadOnly := not FDataLink.Editing;  // RSW use inherited ReadOnly
end;

procedure TvtSimpleCustomCombo.UpdateData(Sender: TObject);
begin
  {if FDataLink.Field.Text <> Text then
    FDataLink.Field.Text := Text;}
end;

{procedure TvtCustomCombo.DrawInGridCell(ACanvas: TCanvas; Rect: TRect;
  State: TGridDrawState);
begin
end;}

procedure TvtSimpleCustomCombo.DoDropDown;
begin
  if Assigned(FOnDropDown) then FOnDropDown(self);
end;

procedure TvtSimpleCustomCombo.DropDown;
begin
 if not EditCanModify then Exit;
 if IsDroppedDown then Exit;
 DoDropDown;
end;

{ return true if allowed to type text into control }

function TvtSimpleCustomCombo.Editable: boolean;
begin
  Result := True;
//  Result := IsDroppedDown;
end;

procedure TvtSimpleCustomCombo.HandleDropDownKeys(var Key: Word; Shift: TShiftState);
 begin
  case Key of
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
       begin
        if IsDroppedDown then CloseUp(False)
        else DropDown;
        Key := 0;
       end;
    VK_RETURN, VK_ESCAPE:
      if IsDroppedDown and not (ssAlt in Shift) then
       begin
        CloseUp(Key = VK_RETURN);
        Key := 0;
       end
  end;
 end;

procedure TvtSimpleCustomCombo.Change;
 begin
  //if ((DataLink<>Nil) and (FDataLink.Field=Nil)) then
  Modified := True;
{  if (DataLink<>Nil) and
     ((FDataLink.Field=Nil) or
      (_DataSource.dataset.state in [dsEdit, dsInsert])) then
  begin
     FDataLink.Modified;
     Modified:= True;
  end;}

  inherited;
 end;

function TvtSimpleCustomCombo.EditCanModify: Boolean;
begin
  Result := False;
  If EffectiveReadOnly then exit; { RSW - otherwise CloseUP still goes into edit mode}
  {if FDatalink.Field <> nil then result := FDataLink.Edit
  else}
  Result := True;
end;

procedure TvtSimpleCustomCombo.KeyDown(var Key: Word; Shift: TShiftState);
 begin
  if GetKeyState(VK_MENU) < 0 then Include(Shift, ssAlt);

  if Modified and (not isDroppedDown) and (Key = VK_ESCAPE) then
   begin
    Reset;
    Key := 0;
   end;

  HandleDropDownKeys(Key, Shift);
  //HandleGridKeys(Key, Shift);

  inherited KeyDown(Key, Shift);

  {if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
    FDataLink.Edit;
   }
 end;


procedure TvtSimpleCustomCombo.KeyPress(var Key: Char);
begin
  inherited;
  if EffectiveReadOnly then
  begin
     Key:= #0;
     exit;
  end;
end;

function TvtSimpleCustomCombo.GetClientEditRect: TRect;
begin
  result := ClientRect;
  if ShowButton then
   Result.Right := FBtnParent.Left;
end;

function TvtSimpleCustomCombo.EffectiveReadOnly: Boolean;
begin
  result:= FReadOnly;
  // or FDataLink.ReadOnly or {(inherited ReadOnly) or}
  //         ((FDataLink.Field<>nil) and (not FDataLink.Field.CanModify));
end;

function TvtSimpleCustomCombo.GetReadOnly: Boolean;
begin
  result:= FReadOnly;
//  if IsDataBound then result := FDataLink.ReadOnly else result := inherited ReadOnly;
end;

procedure TvtSimpleCustomCombo.SetButtonStyle(Value: TvtComboButtonStyle);
begin
  if Value <> FButtonStyle then
  begin
    FButtonStyle := Value;
    if HandleAllocated then RecreateWnd;
    FButton.Invalidate;
  end
end;

{procedure TvtCustomCombo.SetDataField(Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TvtCustomCombo.SetDataSource(Value: TDataSource);
begin
  FDataLink._DataSource := Value;
  if Value <> nil then Value.FreeNotification(self);
end;
}
procedure TvtSimpleCustomCombo.SetReadOnly(Value: Boolean);
begin
//  FDataLink.ReadOnly:= Value;
  fReadOnly:= Value;
  fButton.Enabled := not Value;
{  if Style <> csDropDownList then }inherited ReadOnly := Value;
//  if IsDataBound then FDataLink.ReadOnly := Value;
//{  if Style <> csDropDownList then }inherited ReadOnly := Value;
end;

procedure TvtSimpleCustomCombo.SetStyle(Value: TvtComboStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    if HandleAllocated and not (csLoading in ComponentState) then
    begin
      if FStyle = csDropDownList then
      begin
        inherited ReadOnly := True;  { Should be inherited Readonly, but Hidecaret already does this }
        HideCaret;
      end else begin
        ShowCaret;
      end;
    end;
  end;
end;

function TvtSimpleCustomCombo.IsDroppedDown: boolean;
begin
  result := fDroppedDown;
end;

procedure TvtSimpleCustomCombo.Loaded;
begin
  FButton.Width := Max(GetSystemMetrics(SM_CXVSCROLL), 17);
  if (Parent <> nil) or (Owner <> nil) then
    UpdateButtonPosition;
  inherited Loaded;
end;

procedure TvtSimpleCustomCombo.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Style = csDropDownList then
  begin
    if not IsDroppedDown and (Button = mbLeft) then
     begin
      PostMessage(Handle, WM_vt_CALLDROPDOWN, 0, 0);
      ReleaseCapture; { RSW - Capture causes cursor problems }
     end
    else CloseUp(False);
  end;
end;

procedure TvtSimpleCustomCombo.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FIgnoreCursorChange := True;
  if Style = csDropDownList then {Screen.}Cursor := crArrow else Cursor := FSavedCursor;   // Change component cursor, not screen cursor. -ksw (2/12/99)
  FIgnoreCursorChange := False;
end;

procedure TvtSimpleCustomCombo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  //if (Operation = opRemove) and (AComponent = _DataSource) then _DataSource := nil;
end;

procedure TvtSimpleCustomCombo.WndProc(var Message: TMessage);
begin
 if Message.Msg = WM_vt_CALLDROPDOWN then
  DropDown
 else
  if Message.Msg = WM_vt_CALLCLOSEUP then
   CloseUp(Message.WPARAM = 1)
  else
   if Message.Msg = WM_NCLBUTTONDOWN then
    CloseUp(False);

 inherited;
end;

procedure TvtSimpleCustomCombo.CMCursorChanged(var Message: TMessage);
begin
  inherited;
  if not FIgnoreCursorChange then FSavedCursor := Cursor;
end;

procedure TvtSimpleCustomCombo.CMEnter(var Message: TCMEnter);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  inherited;
end;

procedure TvtSimpleCustomCombo.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  FButton.Enabled := Enabled;
end;

procedure TvtSimpleCustomCombo.CMExit(var Message: TCMExit);
begin
 DoExit;
end;

procedure TvtSimpleCustomCombo.CMFontChanged(var Message: TMessage);
begin
  inherited;
  // This is needed only when changing font in the middle of editing
  if not (csLoading in Owner.ComponentState) then SetEditRect;
end;

procedure TvtSimpleCustomCombo.CNKeyDown(var Message: TWMKeyDown);
var
 l_IsShortCut : Boolean;
begin
  l_IsShortCut := true;
  with Message do
   if IsDroppedDown and (KeyDataToShiftState(KeyData) = []) then
    if (CharCode = VK_RETURN) or (CharCode = VK_ESCAPE) then
     l_IsShortCut := false;
  if l_IsShortCut then
   if IsHandledShortcut(Message) then
    Exit;
  if not (csDesigning in ComponentState) then
    with Message do
    begin
     if (CharCode = VK_TAB) and IsDroppedDown then Closeup(False)
     else if((CharCode = VK_Return) or (charcode=VK_Escape)) then
     begin
      if IsDroppedDown then
       exit
      else
      if (not modified) or (CharCode = VK_Return) then
       SendMessage(GetParent(Handle), TMessage(Message).Msg,TMessage(Message).wParam, TMessage(Message).lParam);
     end;
    end;
  inherited;
end;

procedure TvtSimpleCustomCombo.WMPaint(var Message: TWMPaint);
var r: TRect;
    DC: HDC;
    PS: TPaintStruct;
    lpPaint: tagPaintStruct;
begin
  if InUpdating and not (csDesigning in ComponentState) then
  begin
    DC := BeginPaint(Handle, lpPaint);
    EndPaint(Handle, lpPaint);
    exit;
  end;
  if (csPaintCopy in ControlState) then
  begin
     // 6/28/99 - Support unbound csPaintCopy }
      { if not editable with focus, need to do drawing to show proper focus }
      try
         if FPaintCanvas = nil then
         begin
            FPaintCanvas := TControlCanvas.Create;
            FPaintCanvas.Control := Self;
         end;

         if Message.DC = 0 then DC := BeginPaint(Handle, PS)
         else DC:= Message.DC;
         FPaintCanvas.Handle := DC;

         PaintToCanvas(FPaintCanvas, GetClientEditRect, True, False, Text);

      finally
         FPaintCanvas.Handle := 0;
         if Message.DC = 0 then EndPaint(Handle, PS);
      end;
  end
  else begin
     inherited;
     Paint;
  end;
  r := FBtnParent.ClientRect;
  InvalidateRect(FBtnParent.Handle, @r, False);
end;

procedure TvtSimpleCustomCombo.WMSize(var Message: TWMSize);
begin
  inherited;
  UpdateButtonPosition;
  SetEditRect;
end;

procedure TvtSimpleCustomCombo.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if Style = csDropDownList then
  begin
    Invalidate;
    ShowCaret;
    HideCaret;
  end;
end;

procedure TvtSimpleCustomCombo.SetModified(Value: Boolean);
begin
  //if Value then FDatalink.modified;
  inherited Modified := Value;
end;

procedure TvtSimpleCustomCombo.BtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if Button <> mbLeft then Exit;
  if IsDroppedDown then
   CloseUp(False)
  else
  begin
   if CanFocus then SetFocus;
   if Focused then PostMessage(Handle, WM_vt_CALLDROPDOWN, 0, 0);
  end;
end;

procedure TvtSimpleCustomCombo.HideCaret;
begin
 Windows.HideCaret(Handle);
 inherited ReadOnly := True;
end;

procedure TvtSimpleCustomCombo.Paint;
begin
end;

procedure TvtSimpleCustomCombo.Reset;
begin
  //if DataLink.Field <> nil then DataLink.Reset;
  SelectAll;
  SetModified(False);
  Paint;
end;

procedure TvtSimpleCustomCombo.SelectAll;
begin
 inherited SelectAll;
end;

procedure TvtSimpleCustomCombo.ShowCaret;
begin
 if not HandleAllocated then exit;
 Windows.ShowCaret(Handle);
 inherited ReadOnly := False;
end;

function TvtSimpleCustomCombo.GetLeftIndent: Integer;
begin
  Result := 0;
end;

procedure TvtSimpleCustomCombo.WMPaste(var Message: TMessage);
begin
 if (Style=csDropDown) and EditCanModify then
 begin
  inherited;
  SetModified(True);
 end
 else
  inherited;
end;

function TvtSimpleCustomCombo.GetRightIndent(Rect:TRect): Integer;
begin
 Result := 0;
end;

function TvtSimpleCustomCombo.GetTopIndent: Integer;
begin
  Result := 0;
  if (BorderStyle = bsNone) then
  begin
     Result := 1;
  end;
  if AlignmentVertical = avCenter then
  begin
     if BorderStyle=bsNone then
        Inc(result,(Height - Canvas.Textheight('A')-2) div 2)
     else
        Result := (Height - Canvas.Textheight('A')-5) div 2;
  end;
end;

procedure TvtSimpleCustomCombo.SetAlignmentVertical(Value: TvtAlignVertical);
begin
  if FAlignmentVertical <> Value then begin
     FAlignmentVertical := Value;
     Invalidate;
  end;
end;

function TvtSimpleCustomCombo.GetDirectInput: Boolean;
 begin
  Result := fDirectInput;
 end;

procedure TvtSimpleCustomCombo.SetDirectInput(Value: Boolean);
 begin
  inherited ReadOnly := not Value or FReadOnly;
  fDirectInput := Value;
 end;

function TvtSimpleCustomCombo.GetImages : TCustomImageList;
 begin
  If fImages = nil then Images := vtResources.Images;
  Result := fImages;
 end;

procedure TvtSimpleCustomCombo.SetImages(Value: TCustomImageList);
begin
 if (fImages <> Value) then
 begin
  if (FImageChangeLink <> nil) AND (FImageChangeLink.Sender = nil) then
   // - список картинок уже убит - надо его зачистить
   fImages := nil;
  if (fImages <> nil) then
   fImages.UnRegisterChanges(FImageChangeLink);
  fImages := Value;
  Invalidate;
  if (fImages <> nil) then
  begin
   fImages.RegisterChanges(fImageChangeLink);
   fImages.FreeNotification(Self);
  end;//fImages <> nil
 end;//fImages <> Value
end;

procedure TvtSimpleCustomCombo.SetImageIndex(Value: TImageIndex);
 begin
  if fImageIndex <> Value then
   begin
    fImageIndex := Value;
    Invalidate;
    //if FTabShowing then FPageControl.UpdateTab(Self);
   end;
 end;

function TvtSimpleCustomCombo.IsImageListStored : boolean;
 begin
  Result := (fImages <> nil) and (fImages <> vtResources.Images);
 end;

procedure TvtSimpleCustomCombo.ImageListChange(Sender: TObject);
begin
  if Sender = fImages then Invalidate; //Change;
end;

function TBtnWinControl.InUpdating : Boolean;
begin
 Result := afw.IsObjectLocked(Self);
end;

procedure TBtnWinControl.WMEraseBkgnd(var Message: TWmEraseBkgnd);
 begin
  if InUpdating then
   begin
    Message.Result := 1;
    exit;
   end
  else inherited;
 end;

procedure TvtSimpleCustomCombo.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
 if InUpdating then
 begin
  Message.Result := 1;
  exit;
 end
 else
  inherited;
end;

procedure TvtSimpleCustomCombo.WMSysKeyDown(var Msg : TWMSysKeyDown);
begin
 if IsHandledShortcut(Msg) then
  Exit;
 inherited;
end;

function TvtSimpleCustomCombo.IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
{$IfDef evNeedOvc}
var
 l_Controller : TOvcController;
{$EndIf evNeedOvc}
begin
 Result := false;
 {$IfDef evNeedOvc}
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([OvcCmd.scDefaultTableName], TMessage(Msg),
                     GetTickCount, Il3CommandTarget(Self)) = ccShortCut then
   begin
    Msg.Result := -1;  {indicate that this message was processed}
    Result := true;
   end;
 {$EndIf evNeedOvc}
end;

function TvtSimpleCustomCombo.InUpdating: boolean;
begin
 Result := afw.IsObjectLocked(Self);
end;

procedure TvtSimpleCustomCombo.WMNCPaint(var Message: TWMNCPaint);
begin
 if not InUpdating then
  inherited;
end;

{$IfDef DesignTimeLibrary}
function TvtSimpleCustomCombo.CheckStamp(const aGUID: TGUID): Boolean;
  {-}
begin
 Result := false;
end;
{$EndIf DesignTimeLibrary}

function TvtSimpleCustomCombo.ProcessCommand(Cmd    : Tl3OperationCode;
                                             aForce : Boolean;
                                             aCount : Integer): Boolean;
var
 l_Key : Word;
begin
 Result := False;
 case Cmd of
  ccDel: begin
   l_Key := VK_DELETE;
   KeyDown(l_Key, []);
   Result := True;
  end;
 end;
end;

{TvtCustomListCombo}

constructor TvtCustomListCombo.Create(AOwner : TComponent);
 begin
  inherited Create(AOwner);
  fDropDownCount := 8;
 end;

procedure TvtCustomListCombo.SetDropDownCount(Value: Integer);
begin
  fDropDownCount := Value;
end;

procedure TvtCustomListCombo.DropDown;
 var
  p: TPoint;
  NewControlSize: TSize;
  Border: Integer;
 begin
  If IsDroppedDown then Exit;
  TL3ListenersManager.AddMouseListener(Self);
  DoDropDown;

  p := Parent.ClientToScreen(Point(Left, Top));

  // Initialize size of DropDownControl
  Border := 2 * GetSystemMetrics(SM_CYBORDER);
  NewControlSize := ItemSize;
  if ItemCount > 0 then NewControlSize.cy :=
    Min(DropDownCount, ItemCount) * NewControlSize.cy
  else NewControlSize.cy := Height;
  inc(NewControlSize.cy, Border);
  DropDownContainer.Height := NewControlSize.cy;
  NewControlSize.cx := Max(Width, NewControlSize.cx + Border + 2 * GetSystemMetrics(SM_CXVSCROLL));

  // Adjust if near right edge of screen
  if p.x > Screen.Width - NewControlSize.cx then p.x := (p.x + Width) - NewControlSize.cx;
  // Adjust if near bottom of screen
  if p.y + Height + NewControlSize.cy > Screen.Height{GetSystemMetrics(SM_CYFULLSCREEN)} then p.y := (p.y - Height) - NewControlSize.cy;

  TEdit(DropDownContainer).Color := TEdit(DropDownControl).Color;

  { 6/22/99 - Use HWND_TOPMOST only for formstyle=fsStayOnTop }
  if TForm(GetParentForm(self)).formstyle = fsStayOnTop
   then
    SetWindowPos(DropDownContainer.Handle, HWND_TOPMOST, p.x, p.y + Height, NewControlSize.cx, NewControlSize.cy,
      SWP_NOACTIVATE or SWP_SHOWWINDOW)
   else
    SetWindowPos(DropDownContainer.Handle, HWND_TOP, p.x, p.y + Height, NewControlSize.cx, NewControlSize.cy,
      SWP_NOACTIVATE or SWP_SHOWWINDOW);
  DropDownContainer.Visible := True;
  fDroppedDown := True;
  SendMessage(DropDownContainer.Handle, wm_SetFocus, 0, 0);
  DropDownControl.Update;
  //2/25/99 - Let inherited classes do the selectall.
  //  SelectAll;
  ShowCaret;
 end;

{TvtComboEdit}

procedure TvtComboEdit.SetDropDownControl(Value: TWinControl);
 begin
  ///fDropDownCtrl := Value;
 end;

function TvtComboEdit.GetDropDownControl: TWinControl;
 begin
  If Assigned(fOnGetDropDownControl)
   then fOnGetDropDownControl(Self, Result)
   else Result := nil;
  ///fDropDownCtrl;
 end;

function TvtComboEdit.GetDropDownContainer: TWinControl;
 begin
  Result := GetDropDownControl;
 end;

{function TvtCustomCombo.IsDataBound: Boolean;
begin
  result := (_DataSource <> nil) and (_DataSource.DataSet <> nil) and (DataField <> '');
end; }

procedure TvtCustomCombo.CheckCancelMode;
var p, p2: TPoint;
    wndRect: TRect;
begin
  GetCursorPos(p);
  p2 := DropDownControl.ClientToScreen(Point(0, 0));
  GetWindowRect(Handle, wndRect);
  with p2 do
  begin
    if (not PtInRect(Rect(x, y, x + DropDownControl.Width, y + DropDownControl.Height), p)) and
       (not PtInRect(wndRect, p)) then CloseUp(False);
  end;
end;

procedure TvtCustomCombo.CloseUp(Accept: boolean);
//var i: Integer;
 begin
//  i := GetCapture; { RSW }
//  if Accept then Modified := True; { RSW - Rely on parent class to set modified as we don't really know }
//  if i <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
  { RSW - comment out as this causes problem with button not getting mouse up }
  try
    SelectAll;

    if IsDroppedDown then
    begin
      SetWindowPos(DropDownContainer.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
        SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
      DropDownContainer.Visible := False;
      Invalidate;
      if DropDownControl.Focused then SetFocus;
     { RSW - Let parent class call CloseUP so that its fired after things are updated (i.e. modified flag )}
//    if Assigned(FOnCloseUp) then FOnCloseUp(self, Accept);
    end;
    if Style = csDropDownList then HideCaret;
  finally
   Tl3ListenersManager.RemoveMouseListener(Self);
   fDroppedDown := False;
  end;
  DoCloseUp(Accept); //Morozov
 end;

procedure TvtCustomCombo.DropDown;
 var
  P : TPoint;
  lDDContainer : TWinControl;
 begin
  If Not EditCanModify then Exit;
  If IsDroppedDown then Exit;
  DoDropDown;
  lDDContainer := DropDownContainer;
  If lDDContainer = nil then Exit;

  Tl3ListenersManager.AddMouseListener(Self);

  p := Parent.ClientToScreen(Point(Left, Top));

  if p.x > Screen.Width - lDDContainer.Width
   then p.x := p.x + Width - lDDContainer.Width;

  if p.y + Height + lDDContainer.Height > Screen.Height
   then p.y := p.y - Height - lDDContainer.Height;

  ///TEdit(DropDownContainer).Color := TEdit(DropDownControl).Color;

  with lDDContainer do
   begin
    Visible := False;
    Parent := Self;
    //If Parent = nil then Parent := Self;
    Windows.SetParent(Handle, 0);
   end;

  if TForm(GetParentForm(self)).formstyle = fsStayOnTop
   then
    SetWindowPos(lDDContainer.Handle, HWND_TOPMOST, p.x, p.y + Height, 0, 0,
      {SWP_NOACTIVATE or} SWP_SHOWWINDOW or SWP_NOSIZE)
   else
    SetWindowPos(lDDContainer.Handle, HWND_TOP,     p.x, p.y + Height, 0, 0,
      {SWP_NOACTIVATE or} SWP_SHOWWINDOW or SWP_NOSIZE);

  lDDContainer.top := p.y + Height;
  lDDContainer.Left := p.x;
  lDDContainer.Visible := True;

  fDroppedDown := True;
  lDDContainer.Update;

  ShowCaret;
 end;

{TvtSimpleComboEdit}


{TvtCustomCombo}
function TvtCustomCombo.GetDropDownControl: TWinControl;
 begin
  Result := GetDropDownContainer;
 end;

procedure TvtCustomCombo.SetDropDownControl(Value: TWinControl);
 begin
 end;

procedure TvtCustomCombo.Cleanup;
begin
 Tl3ListenersManager.RemoveMouseListener(Self);
 inherited;
end;

procedure TvtCustomCombo.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if fDroppedDown
   then
    begin
     if DropDownContainer.HandleAllocated and
        (Message.FocusedWnd <> DropDownContainer.Handle) then
     CloseUp(False);
     if Style = csDropDownList then Invalidate;
    end;
end;

procedure TvtCustomCombo.MouseListenerNotify(aMouseMessage: WPARAM;
                                             aHookStruct: PMouseHookStruct;
                                             var theResult: Tl3HookProcResult);
var
 lDDRect: TRect;
begin
 if (Screen.ActiveControl <> Self) or not IsDroppedDown then
  Exit;

 if (aMouseMessage = WM_LBUTTONDOWN) or (aMouseMessage = WM_NCLBUTTONDOWN) then
 begin
  GetWindowRect(DropDownContainer.Handle, lDDRect);
  if not PtInRect(lDDRect, aHookStruct.pt) then
  begin
   with lDDRect do
   begin
    Left := 0;
    Top  := 0;
    Right := Button.Width;
    Bottom := Button.Height;
   end;
   lDDRect.TopLeft := Button.ClientToScreen(lDDRect.TopLeft);
   lDDRect.BottomRight := Button.ClientToScreen(lDDRect.BottomRight);
   if not PtInRect(lDDRect, aHookStruct.pt) then
    SendMessage(Handle, WM_vt_CALLCLOSEUP, 0, 0);
  end;
 end;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtCombo.pas initialization enter'); {$EndIf}
  WM_vt_CALLDROPDOWN := RegisterWindowMessage('VTCOMBODROPDOWNMESSAGE');
  WM_vt_CALLCLOSEUP := RegisterWindowMessage('VTCOMBOCLOSEUPMESSAGE');
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtCombo.pas initialization leave'); {$EndIf}
end.
