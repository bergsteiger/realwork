unit vtCtrls;
{* Дополнительные управляющие элементы библиотеки VT. }

{ $Id: vtCtrls.pas,v 1.29 2015/04/28 14:33:42 lulin Exp $ }

// $Log: vtCtrls.pas,v $
// Revision 1.29  2015/04/28 14:33:42  lulin
// - рефакторим.
//
// Revision 1.28  2015/04/28 13:25:00  lulin
// - рефакторим.
//
// Revision 1.27  2015/04/28 10:45:18  lulin
// - рефакторим.
//
// Revision 1.26  2015/03/17 09:59:30  lulin
// - перетряхиваем зависимости.
//
// Revision 1.25  2015/03/17 09:14:02  lulin
// - перетряхиваем зависимости.
//
// Revision 1.24  2014/03/27 13:46:24  dinishev
// {Requestlink:522796828}. Тест.
//
// Revision 1.23  2013/11/12 11:53:27  morozov
// {RequestLink: 499495428}
//
// Revision 1.22  2013/06/14 05:44:49  dinishev
// Bug fix: нашлось AV по логу.
//
// Revision 1.21  2013/04/04 11:19:54  lulin
// - портируем.
//
// Revision 1.20  2012/04/02 13:00:46  kostitsin
// vtCtrls
//
// Revision 1.19  2011/06/16 13:45:18  lulin
// {RequestLink:269073582}.
//
// Revision 1.18  2010/11/02 08:13:40  voba
// - bug fix
//
// Revision 1.17  2009/03/24 09:31:08  lulin
// - bug fix: не собирался Архивариус в ветке.
//
// Revision 1.16  2009/03/23 14:40:22  lulin
// [$139442655]. Убиваем старый контрол.
//
// Revision 1.15  2008/07/08 09:48:46  lulin
// - не перекладываем строки в ноды, а просто реализуем интерфейс ноды.
//
// Revision 1.14  2007/12/10 13:33:23  voba
// - add _TvtColorBox
//
// Revision 1.13  2007/04/16 08:42:36  lulin
// - используем отложенную отрисовку.
//
// Revision 1.12  2007/01/05 14:37:31  lulin
// - cleanup.
//
// Revision 1.11  2006/12/13 15:13:12  lulin
// - cleanup.
//
// Revision 1.10  2006/03/29 09:00:14  voba
// - merge
//
// Revision 1.9.20.3  2006/03/29 08:25:42  voba
// - enh. в TvtPopupList тип Lister'а настраиваемый
//
// Revision 1.9.20.2  2006/03/27 09:28:35  voba
// no message
//
// Revision 1.9.20.1  2006/03/24 09:29:18  voba
// no message
//
// Revision 1.9  2005/05/30 10:47:53  lulin
// - new unit: vtGroupBoxEx.
//
// Revision 1.8  2005/05/30 10:25:37  lulin
// - компонент "Заголовок" переехал в модуль с "правильным" названием.
//
// Revision 1.7  2005/04/19 15:41:39  lulin
// - переходим на "правильный" ProcessMessages.
//
// Revision 1.6  2004/10/29 08:12:58  voba
// - bug fix: энтер отвалился
//
// Revision 1.5  2004/09/16 11:31:05  lulin
// - навел подобие порядка с регистрацией компонент библиотеки.
//
// Revision 1.4  2004/09/02 13:05:55  law
// - все dynamic методы заменил на virtual.
//
// Revision 1.3  2004/07/28 07:45:31  voba
// - заточки обработки клавиатуры
//
// Revision 1.2  2004/05/27 07:42:41  fireton
// - bug fix: TvtCustomPopupWindow теперь всегда открывается поверх всех окон
//
// Revision 1.1  2004/05/05 14:32:48  voba
// -rename vCtrls to vtCtrls
//
// Revision 1.44  2004/04/29 08:12:45  fireton
// - bug fix: теперь компилится для дизайн-тайма
//
// Revision 1.43  2004/04/28 11:31:46  fireton
// - bug fix: TvtComboBox теперь сохраняет SelStart и SelLength при потере фокуса
//
// Revision 1.42  2004/03/05 10:20:03  voba
// TCustomVLister -> TvtCustomLister
//
// Revision 1.41  2004/03/04 16:35:36  law
// - rename unit: VLister -> vtLister.
//
// Revision 1.40  2004/02/12 13:29:20  fireton
// no message
//
// Revision 1.39  2003/12/24 16:09:10  voba
// -new behavior: событие OnCurrentChange теперь вызывается после присвоения Current. В событие теперь дополнительно передается старый (предыдущий) индекс текущего.
//
// Revision 1.38  2003/04/19 11:24:48  law
// - new file: vtDefine.inc.
//
// Revision 1.37  2003/02/25 14:08:36  voba
// no message
//
// Revision 1.36  2002/12/23 16:46:58  voba
// no message
//
// Revision 1.35  2002/11/19 17:01:36  voba
// no message
//
// Revision 1.34  2002/07/11 08:49:09  voba
// -new behavior Splitter умеет "восстанавливать" размер ранее закрытого подопечного компонента
//
// Revision 1.33  2002/07/08 09:45:42  law
// no message
//
// Revision 1.32  2002/06/20 06:27:56  voba
// no message
//
// Revision 1.31  2002/04/01 15:19:49  voba
// no message
//
// Revision 1.30  2001/11/05 16:19:39  voba
// no message
//
// Revision 1.29  2001/08/31 11:02:36  law
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.28  2001/08/29 15:36:27  law
// - cleanup: удалены ненужные зависимости от Orpheus и SysTools.
//
// Revision 1.27  2001/08/23 08:06:32  voba
// no message
//
// Revision 1.26  2001/06/28 15:02:42  law
// - cleanup: убраны связи с RX.
//
// Revision 1.25  2001/06/18 15:59:44  voba
// no message
//
// Revision 1.24  2001/05/24 14:12:18  voba
// no message
//
// Revision 1.23  2001/05/24 12:24:09  voba
// no message
//
// Revision 1.22  2001/05/24 12:06:08  voba
// no message
//
// Revision 1.21  2001/05/24 11:37:46  voba
// no message
//
// Revision 1.20  2001/05/23 14:01:09  voba
// no message
//
// Revision 1.19  2001/05/23 13:55:06  voba
// no message
//
// Revision 1.18  2001/05/23 13:47:29  voba
// no message
//
// Revision 1.17  2001/05/23 13:46:04  voba
// no message
//
// Revision 1.16  2001/05/23 13:25:29  voba
// - new behavior : class TvtPopupWindow
//
// Revision 1.15  2001/05/22 09:18:33  voba
// no message
//
// Revision 1.14  2001/05/21 12:34:17  voba
// - bug fix
//
// Revision 1.13  2001/05/21 09:04:26  voba
// -bug fix
//
// Revision 1.12  2001/05/18 06:08:08  voba
// - new behavior
//
// Revision 1.11  2001/04/05 08:52:17  law
// - cleanup: использование модулей WinTypes и WinProcs заменен на Windows.
//
// Revision 1.10  2000/12/19 15:14:19  voba
// no message
//
// Revision 1.9  2000/12/15 15:36:28  law
// - вставлены директивы Log.
//

{$Include vtDefine.inc }

{.$WriteableConst On}

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, ClipBrd,
  Forms, StdCtrls, ExtCtrls, Menus,

  l3VCLStrings,

  vtLister,
  vtHeader,

  l3Interfaces,
  l3Base
  ;

type
  TAdjustCorner = (acBottomLeft, acBottomRight);
  //TNaturalNumber = 1..High(Integer);

  TVEdit = class(TEdit)
  end;

TvtSplitter = class({TWinControl} TGraphicControl)
  private
    FActiveControl: TWinControl;
    FAutoSnap: Boolean;
    FBeveled: Boolean;
    FBrush: TBrush;
    FControl: TControl;
    FDownPos: TPoint;
    FLineDC: HDC;
    FLineVisible: Boolean;
    FMinSize: NaturalNumber;
    FMaxSize: Integer;
    FNewSize: Integer;
    FOldKeyDown: TKeyEvent;
    FOldSize: Integer;
    FSaveSize: Integer;
    fInDblClick : Boolean;
    FPrevBrush: HBrush;
    FResizeStyle: TResizeStyle;
    FSplit: Integer;
    FSplitControl : TControl;
    FOnCanResize: TCanResizeEvent;
    FOnMoved: TNotifyEvent;
    FOnPaint: TNotifyEvent;
    procedure AllocateLineDC;
    procedure CalcSplitSize(X, Y: Integer; var NewSize, Split: Integer);
    procedure DrawLine;
    function FindControl: TControl;
    procedure FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ReleaseLineDC;
    procedure SetBeveled(Value: Boolean);
    procedure UpdateControlSize;
    function  GetControlSize : Integer;
  protected
    function CanResize(var NewSize: Integer): Boolean; reintroduce; virtual;
    function DoCanResize(var NewSize: Integer): Boolean; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure DblClick; override;
    procedure Paint; override;
    procedure RequestAlign; override;
    procedure StopSizing; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas;

    property SaveSize: Integer
     read  fSaveSize
     write fSaveSize;

  published
    property SplitControl : TControl read FSplitControl write FSplitControl;
    property Align default alLeft;
    property AutoSnap: Boolean read FAutoSnap write FAutoSnap default True;
    property Beveled: Boolean read FBeveled write SetBeveled default False;
    property Color;
    property Constraints;
    property MinSize: NaturalNumber read FMinSize write FMinSize default 30;
    property ParentColor;
    property ResizeStyle: TResizeStyle read FResizeStyle write FResizeStyle
      default rsPattern;
    property Visible;
    property OnCanResize: TCanResizeEvent read FOnCanResize write FOnCanResize;
    property OnMoved: TNotifyEvent read FOnMoved write FOnMoved;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

  TvtComboBox = class(TComboBox)
   {* Выпадающий список. }
   private
    FSavedSelStart: Integer;
    FSavedSelLength: Integer;
   protected
    fHistorySize : integer;
    function GetSelLength: Integer; {$IFNDEF DesignTimeLibrary} {$IfDef l3HackedVCL}override;{$EndIf} {$ENDIF}
    function GetSelStart: Integer; {$IFNDEF DesignTimeLibrary} {$IfDef l3HackedVCL}override;{$EndIf} {$ENDIF}
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
   public
    procedure AddToHistory;
     {* - добавляет поле Text в Items первой строчкой. }
   published
    constructor Create(AOwner: TComponent); override;
    property HistorySize : integer read fHistorySize write fHistorySize default 20;
   end;

  TSpeedBarComboBox = class(TCustomComboBox)
   Private
    FEditChange : Boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
   Protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
   published
    property Style; {Must be published before Items}
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property Items;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    {property Sorted;}
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
  end;

  TFontSizeComboBox = class(TSpeedBarComboBox)
   {* Выпадающий список размеров шрифта. }
  private
    FFontName : String;
  protected
    Function  GetFontSize : Integer;
    Procedure SetFontSize (Value : Integer);
    Procedure SetFontName (Value : String);
    procedure CreateWnd; override;
  public
    procedure BuildList;
    {constructor Create(AOwner: TComponent); override;}
  published
    property FontName : String Read FFontName Write SetFontName;
     {* - Гарнитур шрифта. }
    property FontSize : Integer Read GetFontSize Write SetFontSize;
     {* - Размер шрифта. }
    property Items Stored False;
  end;

 TOnAdjustCtrl = procedure(Sender: TObject) of object;

 TvtCustomPopupWindow = class(TCustomControl,
                              Il3MouseListener)
  {* Базовое popup окно. }
  private
    fDependControl  : TControl;
    fExecResult     : Longint;
    fOrigin         : TPoint;
    MouseHook       : HHook;
    FAdjustCorner   : TAdjustCorner;
    fOnAdjustCtrl   : TOnAdjustCtrl;

    procedure WMChar(var Msg : TWMChar); message WM_CHAR;
    procedure ListKeyPress(Sender: TObject; var Key: Char);
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
    procedure WMActivate(var Message: TWMActivate); message WM_ACTIVATE;
    procedure WMKillFocus(var Msg : TWMKillFocus);   message WM_KILLFOCUS;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    Function  CheckMouseClick : Boolean;
    {procedure HookActiveComponent(Sender: TObject; var Msg: TMessage; var Handled: Boolean);}
    {Procedure NActiveChanged(Sender: TObject);}
    // Il3MouseListener
    procedure MouseListenerNotify(aMouseMessage: WPARAM;
                                  aHookStruct: PMouseHookStruct;
                                  var theResult: Tl3HookProcResult);
    function CheckStamp(const aGUID: TGUID): Boolean;
  protected
    procedure KeyPressHandler(Const Key: Word); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MakeChildComponents; virtual;
    procedure DoOnExecute; virtual;
    procedure DoAfterExecute; virtual;
  public
    constructor Create(AOwner: TComponent); reintroduce; overload;
    constructor Create(AOwner: TComponent; aOrigin : TPoint); reintroduce; overload;
    //destructor  Destroy; override;
    procedure Close;
    function  Execute : Longint;

    property AdjustCorner  : TAdjustCorner read fAdjustCorner  write fAdjustCorner;
    property DependControl : TControl      read fDependControl write fDependControl;
    property OnAdjustCtrl  : TOnAdjustCtrl read fOnAdjustCtrl  write fOnAdjustCtrl;
    property ExecResult    : Longint       read fExecResult    write fExecResult;
    property Origin        : TPoint        read fOrigin        write fOrigin;
  end;

 TWinControlClass = class of TWinControl;

 TvtPopupWindow = class(TvtCustomPopupWindow)
  {* Popup окно. }
  protected
   fChildControl : TWinControl;
   procedure DoOnExecute; override;
   procedure DoAfterExecute; override;
  public
   //property ChildComponentClass
   constructor Create(aOwner: TComponent; aChildControl : TWinControl); reintroduce; overload;
   constructor Create(aOwner: TComponent; aChildControlClass : TWinControlClass); reintroduce; overload;
   //constructor Create(AOwner: TComponent; aOrigin : TPoint); reintroduce; overload;

 end;

 Tvt_plShowOption = (vt_plShowFooter);

 Tvt_plShowOptionSet = Set of Tvt_plShowOption;

 TclassofTvtCustomLister = class of TvtCustomLister;

 TvtPopupList = class(TvtCustomPopupWindow)
  {* Popup список. }
  protected
   {fPressItemLog : Boolean;}
   BackPanel: TWinControl;
   fListerClass : TclassofTvtCustomLister;
   fLister  : TvtCustomLister; //TvtDStringLister;
   fFooter  : TvtHeader;
   fShowOption : Tvt_plShowOptionSet;

   procedure ListActionElementHandler(Sender:TObject; Index : Longint);
   procedure KeyPressHandler(Const Key: Word); override;
   procedure ListMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
   procedure evntListCurrentChanged(Sender: TObject; aNewCurrent: Longint;
       aOldCurrent: Longint);
   procedure MakeChildComponents; override;
   procedure DoOnExecute; override;

  public
   constructor Create(aOwner: TComponent; aListerClass : TclassofTvtCustomLister; aShowOption : Tvt_plShowOptionSet = []); reintroduce; overload;
   constructor Create(aOwner: TComponent; aListerClass : TclassofTvtCustomLister; aOrigin : TPoint; aShowOption : Tvt_plShowOptionSet = []); reintroduce; overload;
   property Lister  : TvtCustomLister Read fLister Write fLister;
   property Footer  : TvtHeader Read fFooter Write fFooter;
   //function Execute : Longint;
  end;

 TvPopupWindow = TvtPopupWindow;
 TvPopupList = TvtPopupList;

 TvtImage = class(TImage)
  {* Рисунок. }
  public
   procedure WMCut(var Msg: TMessage);   message WM_Cut;
   procedure WMCopy(var Msg: TMessage);  message WM_Copy;
   procedure WMPaste(var Msg: TMessage); message WM_Paste;
   procedure WMClear(var Msg: TMessage); message WM_Clear;
  end;

 procedure GetFontList(List : TStrings);
   overload;
 procedure GetFontSizeList(const FFontName : String; List : TStrings);
   overload;
 procedure GetFontList(List : Tl3CustomStrings);
   overload;
 procedure GetFontSizeList(const FFontName : String; List : Tl3CustomStrings);
   overload;

 procedure GetFontListEx(aList: Tl3CustomStrings; aCharSet: Byte);
 procedure GetfontSizeListEx(const aFontName: String; aList: Tl3CustomStrings; aCharSet: Byte);

 procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorRect  : TRect;   aAdjustCorner : TAdjustCorner = acBottomLeft); overload;
 procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorPoint : TPoint;  aAdjustCorner : TAdjustCorner = acBottomLeft); overload;
 procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorCtrl : TControl; aAdjustCorner : TAdjustCorner = acBottomLeft); overload;

implementation

uses
  l3String,
  l3ControlsTypes,
  l3ListenersManager,
  l3BatchService,
  l3AFWExceptions,
  afwFacade
  ;

Var
 g_CurrentPopup : TvtCustomPopupWindow;

var
 lFakeParent : TWinControl = nil; // специальный контрол для правильной отрисовки PopUpWindow

Type
 TSpecWinControl = class(TWinControl)
  public
   destructor  Destroy; override;
 end;

 destructor TSpecWinControl.Destroy;
  begin
   If (Pointer(lFakeParent) = Self) then lFakeParent := nil;
   inherited;
  end;

 function GetFakeParent : TWinControl;
  begin
   If lFakeParent = nil
    then lFakeParent := TSpecWinControl.Create(Application.MainForm);
   If lFakeParent.Parent = nil
    then lFakeParent.Parent := Application.MainForm;
   Result := lFakeParent;
  end;

 procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorRect : TRect; aAdjustCorner : TAdjustCorner = acBottomLeft);
  var
   ptUpper, ptLower: TPoint;
   ptLeftTop: TPoint;
   lDeskRect : TRect;                      //Left, Top, Right, Bottom:
  begin
   ptUpper.X := aAnchorRect.Left;
   ptUpper.Y := aAnchorRect.Top;
   ptLower.X := aAnchorRect.Right;
   ptLower.Y := aAnchorRect.Bottom;

   lDeskRect := Screen.DeskTopRect;

   Case aAdjustCorner of
    acBottomLeft  :
     begin
      if ptUpper.X + 1 + aAdjustCtrl.Width > lDeskRect.Right
       then ptLeftTop.X := lDeskRect.Right - aAdjustCtrl.Width - 1
       else ptLeftTop.X := ptUpper.X + 1;

      if ptLower.Y + 1 + aAdjustCtrl.Height > lDeskRect.Bottom
       then ptLeftTop.Y := ptUpper.Y - aAdjustCtrl.Height
       else ptLeftTop.Y := ptLower.Y + 1;
     end;

    acBottomRight :
     begin
      if ptLower.X - 1 - aAdjustCtrl.Width < lDeskRect.Left
       then ptLeftTop.X := lDeskRect.Left
       else ptLeftTop.X := ptLower.X - 1 - aAdjustCtrl.Width;

      if ptLower.Y + 1 + aAdjustCtrl.Height > lDeskRect.Bottom
       then ptLeftTop.Y := ptUpper.Y - aAdjustCtrl.Height
       else ptLeftTop.Y := ptLower.Y + 1;
     end;
   end;

   //If aAdjustCtrl.Parent <> Nil
   // then ptLeftTop := aAdjustCtrl.Parent.ScreenToClient(ptLeftTop);

   With aAdjustCtrl do
    begin
     aAdjustCtrl.Left := ptLeftTop.X;
     aAdjustCtrl.Top  := ptLeftTop.Y;

     {дальше правильнее использовать Rect от текущего монитора}
     If Left < lDeskRect.Left then Left := lDeskRect.Left;
     If Top < 0 then Top := 0;
     If Width > lDeskRect.Right - lDeskRect.Left - Left then
      Width := lDeskRect.Right - lDeskRect.Left - Left;
     If Height > lDeskRect.Bottom - Top then
      Height := lDeskRect.Right - Top;

     {If Left < 0 then Left:=0;
     If Width > Parent.ClientWidth - Left then Width := Parent.ClientWidth - Left;
     If Top < 0 then Top:=0;
     If Height > Parent.ClientHeight - Top then Height := Parent.ClientHeight - Top;
     }
    end;
  end;

procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorPoint : TPoint;
                                 aAdjustCorner : TAdjustCorner = acBottomLeft);
 var
  lRect : TRect;
 begin
  lRect.TopLeft := aAnchorPoint;
  lRect.BottomRight := aAnchorPoint;
  AdjustCtrl(aAdjustCtrl, lRect, aAdjustCorner);
 end;

procedure AdjustCtrl(aAdjustCtrl : TControl; aAnchorCtrl : TControl;
                                 aAdjustCorner : TAdjustCorner = acBottomLeft);
 var
  lRect : TRect;
 begin
  lRect.TopLeft := aAnchorCtrl.ClientToScreen(Point(0,0));
  lRect.BottomRight := aAnchorCtrl.ClientToScreen(
                                 Point(aAnchorCtrl.Width, aAnchorCtrl.Height));
  AdjustCtrl(aAdjustCtrl, lRect, aAdjustCorner);
 end;

{Procedure AdjustWin1(AdjustCtrl : TControl; AnchorCtrl : TControl;
                    AnchorCtrlReg : TRect; AdjustCorner : TAdjustCorner;
                    aParent : TWinControl = nil);
  Var
   ptUpper, ptLower: TPoint;
   ptLeftTop: TPoint;
  begin
   With AdjustCtrl do
    Begin
     if (aParent = nil) then aParent := Parent;
     ptUpper.X := AnchorCtrlReg.Left;
     ptUpper.Y := AnchorCtrlReg.Top;
     ptUpper   := AnchorCtrl.ClientToScreen( ptUpper );
     ptLower.X := AnchorCtrlReg.Right;
     ptLower.Y := AnchorCtrlReg.Bottom;
     ptLower   := AnchorCtrl.ClientToScreen( ptLower );
     Case AdjustCorner of
      acBottomLeft  : Begin
                       if ptUpper.X + 1 + Width > Screen.Width
                        then ptLeftTop.X := Screen.Width - Width - 1
                        else ptLeftTop.X := ptUpper.X + 1;

                       if ptLower.Y + 1 + Height > Screen.Height
                        then ptLeftTop.Y := ptUpper.Y - Height
                        else ptLeftTop.Y := ptLower.Y + 1;
                      end;

      acBottomRight : Begin
                       if ptLower.X - 1 - Width < 0
                        then ptLeftTop.X := 0
                        else ptLeftTop.X := ptLower.X - 1 - Width;

                       if ptLower.Y + 1 + Height > Screen.Height
                        then ptLeftTop.Y := ptUpper.Y - Height
                        else ptLeftTop.Y := ptLower.Y + 1;
                      end;
     end;
     if aParent <> Nil then ptLeftTop := aParent.ScreenToClient(ptLeftTop);
     Left := ptLeftTop.X;
     Top  := ptLeftTop.Y;
    end;
  end;
}

constructor TvtCustomPopupWindow.Create(AOwner: TComponent);
begin
 Create(AOwner, Point(-1,-1));
end;

constructor TvtCustomPopupWindow.Create(AOwner: TComponent; aOrigin : TPoint);
begin
  fDependControl:=TControl(AOwner);
  //If Not (AOwner is TForm) then AOwner := GetParentForm(TWinControl(aOwner));

  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible, csReplicatable,
    csAcceptsControls];
  Ctl3D := True;
  ParentCtl3D := False;
  Visible := False;

  Height := 124;
  Width  := 185;

  FOrigin := aOrigin;
  MakeChildComponents;
end;

procedure TvtCustomPopupWindow.MakeChildComponents;
 begin
  //
 end;

procedure TvtCustomPopupWindow.DoOnExecute;
 begin
  If Assigned(fOnAdjustCtrl) then
   OnAdjustCtrl(Self)
  else
   If (Origin.X < 0) and (Origin.Y < 0) then
    AdjustCtrl(Self, DependControl, AdjustCorner)
   else
    AdjustCtrl(Self, Origin, AdjustCorner);
 end;

procedure TvtCustomPopupWindow.DoAfterExecute;
 begin
  //
 end;

{destructor TvtCustomPopupWindow.Destroy;
 begin
  UnHookWindowsHookEx(MouseHook);
  If g_CurrentPopup = Self then g_CurrentPopup:=Nil;
  Inherited Destroy;
 end; }

procedure TvtCustomPopupWindow.MouseListenerNotify(aMouseMessage: WPARAM;
                                                   aHookStruct: PMouseHookStruct;
                                                   var theResult: Tl3HookProcResult);
begin
 if (aMouseMessage = WM_LBUTTONDOWN) or
    (aMouseMessage = WM_RBUTTONDOWN) or
    (aMouseMessage = WM_MBUTTONDOWN) or
    (aMouseMessage = WM_NCLBUTTONDOWN) or
    (aMouseMessage = WM_NCRBUTTONDOWN) or
    (aMouseMessage = WM_NCMBUTTONDOWN) then
  if (g_CurrentPopup = Self) and CheckMouseClick then
  begin
   theResult.Result := 1;
   theResult.Handled := True;
  end;
end;

function TvtCustomPopupWindow.CheckStamp(const aGUID: TGUID): Boolean;
begin
 Result := False;
end;

type
 THackApplication = class(TApplication)
 end;

function TvtCustomPopupWindow.Execute : Longint;
 var
  lParWin  : TCustomForm;
  lSaveActiveControl : TWinControl;
  lMsg: TMsg;
 begin
 {$IfDef InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
  if (Application.MainForm <> nil) then
   if not Tl3BatchService.Instance.HasModalWorker then
    raise El3TryEnterModalState.Create('Здесь надо обрабатывать модальность формы' + ClassName);
 {$EndIf InsiderTest}
  Tl3ListenersManager.AddMouseListener(Self);

  g_CurrentPopup := Self;
  try
   //lParWin := GetParentForm(fDependControl); //Application.MainForm; //Screen.ActiveForm;
   lParWin := Screen.ActiveForm;

   If lParWin = nil then
    lParWin := Application.MainForm;

   If (lParWin as TForm).FormStyle = fsMDIChild then
    lParWin := Application.MainForm;

   lSaveActiveControl := lParWin.ActiveControl;

   GetFakeParent.Parent := lParWin;
   Parent := GetFakeParent;
   Windows.SetParent(Handle, 0);

   try
    DoOnExecute;
    try
     Visible:=True;
     afw.ProcessMessages;
     ExecResult := - 2;

     While (ExecResult < -1) do
      begin
       (* Это собственный обработчик Message, можно что-то сфильтровать
          Идея: можно попытаться подавить KillFocus при передаче фокуса на popup окошко,
          но придется видимо Хук вешать*)
       if Tl3BatchService.Instance.IsBatchMode then
        Tl3BatchService.Instance.ExecuteCurrentModalWorker;
       If Application.Terminated then Close;
       case Integer(Windows.GetMessage(lMsg, 0, 0, 0)) of
        -1 : Close;
         0 : begin
              PostQuitMessage(lMsg.wParam);
              Close;
             end;
       end;
       if {not IsHintMsg(Msg) and not Handled and not IsMDIMsg(Msg) and}
          not THackApplication(Application).IsKeyMsg(lMsg) {and not IsDlgMsg(Msg)} then
       begin
        TranslateMessage(lMsg);
        DispatchMessage(lMsg);
       end;

       //afw.ProcessMessages;
       If Application.Terminated then Close;
      end;
     //ReleaseCapture;
     Result := ExecResult;
    finally
     DoAfterExecute;
     afw.ProcessMessages;
    end;//try...finally
   finally
    Visible:=False;
    If lSaveActiveControl <> nil then lSaveActiveControl.SetFocus;
    //SendMessage(lSaveActiveControl.Handle, WM_SETFOCUS, 0, 0); //lSaveActiveControl.SetFocus;
    afw.ProcessMessages;
    //lFakeParent.Parent := nil;
   end;
  finally
   if g_CurrentPopup = Self then
    g_CurrentPopup := nil;
   Tl3ListenersManager.RemoveMouseListener(Self);
  end;
 end;

procedure TvtCustomPopupWindow.Close;
 begin
  ExecResult := -1;
 end;

procedure TvtCustomPopupWindow.CreateParams(var Params: TCreateParams);
 begin
  inherited CreateParams(Params);
  with Params do begin
    Style := {WS_CHILD or} WS_POPUP; // or {WS_BORDER or} WS_CLIPCHILDREN and not WS_CAPTION;

    ExStyle := WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
 end;

procedure TvtCustomPopupWindow.KeyPressHandler(Const Key: Word);
begin
  Case Key of
   vk_Escape : Close;
  end;
end;

procedure TvtCustomPopupWindow.WMChar(var Msg : TWMChar);
begin
  inherited;
  KeyPressHandler(Msg.CharCode);
end;

procedure TvtCustomPopupWindow.ListKeyPress(Sender: TObject; var Key: Char);
begin
 KeyPressHandler(Ord(Key));
end;

{Procedure TvtCustomPopupWindow.NActiveChanged(Sender: TObject);
 Begin
  ExecResult := -1;
 end;}

Function TvtCustomPopupWindow.CheckMouseClick : Boolean;
 var
  Pt : TPoint;
 Begin
  GetCursorPos(Pt);
  Pt := ScreenToClient(Pt);
  Result := (Pt.X < 0) or (Pt.Y < 0) or (Pt.X > Width) or (Pt.Y > Height);
  If Result then Close;
 end;

(*procedure TvtCustomPopupWindow.HookActiveComponent(Sender: TObject; var Msg: TMessage; var Handled: Boolean);
{var
  Pt : TPoint;}
Begin
 {If Msg.Msg = WM_KillFocus then Close;}
 {If Msg.Msg = WM_LBUTTONDOWN then
  Begin
   GetCursorPos(Pt);
   Pt := ScreenToClient(Pt);
   If (Pt.X < 0) or (Pt.Y < 0) or (Pt.X > Width) or (Pt.Y > Height)
   then
    Begin
     Close;
     Handled:=True;
    end;
  end;  }
end;
 *)

procedure TvtCustomPopupWindow.WMMouseActivate(var Message: TMessage);
begin
 Message.Result := MA_NOACTIVATE;
end;

procedure TvtCustomPopupWindow.WMActivate(var Message: TWMActivate);
begin
 inherited;
 if Message.Active = WA_INACTIVE then
  Close;
end;

procedure TvtCustomPopupWindow.WMKillFocus(var Msg : TWMKillFocus);
begin
 inherited;
 Close;
end;

procedure TvtCustomPopupWindow.CMExit(var Message: TCMExit);
begin
 Inherited;
 Close;
end;

constructor TvtPopupWindow.Create(aOwner: TComponent; aChildControl : TWinControl);
begin
 inherited Create(aOwner);
 fChildControl := aChildControl;
 fChildControl.Parent := Self;
 fChildControl.Align := alClient;
 fChildControl.Visible := True;
end;

constructor TvtPopupWindow.Create(aOwner: TComponent; aChildControlClass : TWinControlClass);
begin
 Create(aOwner, aChildControlClass.Create(Self));
end;

{constructor TvtPopupWindow.Create(AOwner: TComponent; aOrigin : TPoint);
 begin
  inherited Create(aOwner, aOrigin);
 end;}

procedure TvtPopupWindow.DoOnExecute;
begin
 inherited;
 Visible:=True;
 fChildControl.SetFocus;
end;

procedure TvtPopupWindow.DoAfterExecute;
begin
 inherited;
 //If fChildControl.Owner <> self then
 fChildControl.Visible := false;
 fChildControl.Parent := nil;
end;

{TvtPopupList}
constructor TvtPopupList.Create(AOwner: TComponent; aListerClass : TclassofTvtCustomLister; aShowOption : Tvt_plShowOptionSet = []);
begin
 fShowOption := aShowOption;
 fListerClass := aListerClass;
 inherited Create(AOwner); //, (-1,-1){aOrigin});
end;

constructor TvtPopupList.Create(AOwner: TComponent; aListerClass : TclassofTvtCustomLister; aOrigin : TPoint; aShowOption : Tvt_plShowOptionSet = []);
begin
 fShowOption := aShowOption;
 fListerClass := aListerClass;
 inherited Create(AOwner,aOrigin);
end;

procedure TvtPopupList.MakeChildComponents;
begin
 BackPanel := TPanel.Create(Self);
 with BackPanel as TPanel do
 begin
  Parent := Self;
  Align := alClient;
  ParentColor := True;
  ParentFont  := True;
  BevelWidth  := 2;
  BorderWidth := 3;
 end;

 {vtLister}
 FLister := fListerClass.Create(Self);
 with FLister do
 begin
  Parent := BackPanel;
  Align := alClient;
  ParentColor := True;

  BorderStyle:=bsNone;
  ParentCtl3D := False;
  Ctl3D := False;
  OnMouseUp   := ListMouseUp;
  Options := Options + [vlMouseTrack];
  //Font.Name:='MS Sans Serif';
  //Font.Style := [];
  OnKeyPress := ListKeyPress;
  OnActionElement := ListActionElementHandler;
 end;

 if vt_plShowFooter in fShowOption then
 begin
  fFooter  := TvtHeader.Create(Self);
  with fFooter do
  begin
   Parent := BackPanel;
   Align  := alBottom;
   ParentColor := True;
   Height := 20;
   BorderStyle := bsNone;
   Sections.Add;
   Sections.Add;
   SectionWidth[0] := 55;
   SectionJustification[0] := taCenter;
   ParentFont := False;
   Font.Name:='MS Sans Serif';
   Font.Size := 8;
   Font.Style := [];
  end;
  FLister.OnCurrentChanged := evntListCurrentChanged;
 end;

end;

procedure TvtPopupList.DoOnExecute;
 var
  MaxLen   : Integer;
  lHeight  : Integer;
  lDim     : TPoint;
 begin
   Width := Screen.Width; //чтобы высоту и ширину правильно считать
   Height := Screen.Height; //чтобы высоту и ширину правильно считать

   lHeight := 4 + TPanel(BackPanel).BorderWidth*(2+1); {BevelWidth * 2};
   If vt_plShowFooter in fShowOption then lHeight := lHeight + fFooter.Height;
   lDim := fLister.GetItemsRangeDim(0, 0, Height - lHeight);
   lHeight := lDim.Y + lHeight;

   {For I := 0 to pred(fLister.Total) do
    begin
     Inc(lHeight, fLister.GetItemHeight(I));
     If lHeight >= Screen.Height then break;
    end;}

   //Height := (FLister.Total) * FLister.RowHeight + 4 + TPanel(BackPanel).BorderWidth*2; {BevelWidth * 2};
   //If vt_plShowFooter in fShowOption then Height := Height + fFooter.Height;

   //If Height > Screen.Height then Height := Screen.Height;

   //MaxLen := lWidth - 4; {BevelWidth * 2}
   MaxLen := lDim.X;
   //For I := 0 to FLister.Items.Count - 1 do
   // MaxLen := Max(MaxLen, FLister.GetItemTextIndent(I) + FLister.Canvas.Canvas.TextWidth(FLister.Items.PasStr[I]));

   If lHeight > Screen.Height
    then Height := Screen.Height
    else Height := lHeight;

   //Width := lWidth;
   Width := MaxLen + Width - FLister.ClientWidth + 6 + TPanel(BackPanel).BorderWidth*2;
   Width := MaxLen + Width - FLister.ClientWidth + 6 + TPanel(BackPanel).BorderWidth*2;
   // ^^^ Так надо

   Inherited;
   {If Assigned(fOnAdjustCtrl)
    then OnAdjustCtrl(Self)
    else AdjustCtrl(Self, DependControl, AdjustCorner);}

   Visible:=True;
   Windows.SetFocus(FLister.Handle);
 end;

procedure TvtPopupList.evntListCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
 begin
  If fFooter = nil then Exit;
  If fLister.Total > 0
   then fFooter.Sections[0].Caption := Format('%d из %d', [Succ(aNewCurrent),fLister.Total])
   else fFooter.Sections[0].Caption := '';
 end;

procedure TvtPopupList.ListMouseUp(Sender: TObject; Button: TMouseButton;
                                  Shift: TShiftState; X, Y: Integer);
 begin
  If (Button = mbLeft) then ExecResult := FLister.Current;
 end;

procedure TvtPopupList.KeyPressHandler(Const Key: Word);
begin
  Case Key of
   vk_Escape : Close;
   vk_Return : ExecResult := FLister.Current;
  end;
end;

procedure TvtPopupList.ListActionElementHandler(Sender:TObject; Index : Longint);
begin
 ExecResult := FLister.Current;
end;

{TSpeedBarComboBox}

procedure TSpeedBarComboBox.KeyDown(var Key: Word; Shift: TShiftState);
 begin
  Case Key of
     vk_Return : Change;
     vk_Escape : Begin
                  Try
                   Text := Items[ItemIndex];
                  except
                   Text := '';
                  end;
                  FEditChange:=False;
                  Change;
                 end;
    end;
 end;

procedure TSpeedBarComboBox.CNCommand(var Message: TWMCommand);
  Begin
   Case Message.NotifyCode of
    CBN_EDITCHANGE : FEditChange:=True;
    CBN_SELCHANGE  : Begin
                      FEditChange:=False;
                      Inherited;
                     end;
    CBN_KILLFOCUS  : Begin
                      Inherited;
                      If FEditChange then
                       Begin
                        FEditChange:=False;
                        Change;
                       end;
                     end;
    else Inherited;
   end;
  end;


{TFontSizeComboBox}

function FEnumFontsProc(var EnumLogFont: TEnumLogFont;
  var TextMetric: TNewTextMetric; FontType: Integer; Data: LPARAM): Integer;
  export; stdcall;
begin
  TStrings(Data).AddObject(l3GetStrPas(EnumLogFont.elfLogFont.lfFaceName), TObject(FontType));
  Result := 1;
end;

Procedure GetFontList(List : TStrings);
var
 DC: HDC;
Begin
 DC := GetDC(0);
 try
  EnumFonts(DC, Nil, @FEnumFontsProc, Pointer(List));
 finally
  ReleaseDC(0, DC);
 end;//try..finally
end;

Var
 EnumFontName : String;

function FSEnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; export; stdcall;
var
 Box      : TStrings;
 FSizeStr : String;
 FntSize  : Integer;
 tmpSize  : Integer;
 I        : Integer;
 Added    : Boolean;
begin
 Box := TStrings(Data);
 if (FontType and RASTER_FONTTYPE = 0) then
  Result := 0
 else
 begin
  if (StrPas(LogFont.lfFaceName) = EnumFontName) then
  begin
   FntSize := MulDiv(LogFont.lfHeight, 72, Screen.PixelsPerInch);
   FSizeStr := IntToStr(FntSize);
   Added := False;
   for I:=0 to Box.Count-1 do
   begin
    tmpSize := StrToInt(Box.Strings[I]);
    if (tmpSize > FntSize)then
     Box.Insert(I, FSizeStr);
    if (tmpSize >= FntSize) then
    begin
     Added := True;
     Break;
    end;//tmpSize >= FntSize
   end;//for I:=0
   if Not Added then
    Box.Add(FSizeStr);
  end;//StrPas(LogFont.lfFaceName) = EnumFontName
  Result := 1;
 end;//FontType and RASTER_FONTTYPE = 0
end;

procedure GetFontSizeList(const FFontName : String; List : TStrings);
var
 DC : HDC;
 I  : Integer;
begin
 List.Clear;
 if (FFontName <> '') then
 begin
  DC := GetDC(0);
  try
   EnumFontName := FFontName;
   EnumFonts(DC, PChar(FFontName), @FSEnumFontsProc, Pointer(List));
  finally
   ReleaseDC(0, DC);
  end;//try..finally
 end;//FFontName <> ''
 if (List.Count <= 0) then
 Begin
  For I := 8 to 12 do List.Add(IntToStr(I));
  For I := 7 to 14 do List.Add(IntToStr(I*2));
  For I := 3 to 6  do List.Add(IntToStr(I*12));
 end;//List.Count <= 0
end;

function FEnumFontsProc1(var EnumLogFont: TEnumLogFont;
  var TextMetric: TNewTextMetric; FontType: Integer; Data: LPARAM): Integer;
  export; stdcall;
begin
  Tl3CustomStrings(Data).AddObject(l3GetStrPas(EnumLogFont.elfLogFont.lfFaceName), TObject(FontType));
  Result := 1;
end;

Procedure GetFontList(List : Tl3CustomStrings);
var
 DC: HDC;
Begin
 DC := GetDC(0);
 try
  EnumFonts(DC, Nil, @FEnumFontsProc1, Pointer(List));
 finally
  ReleaseDC(0, DC);
 end;//try..finally
end;

function FSEnumFontsProc1(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; export; stdcall;
var
 Box      : Tl3CustomStrings;
 FSizeStr : String;
 FntSize  : Integer;
 tmpSize  : Integer;
 I        : Integer;
 Added    : Boolean;
begin
 Box := Tl3CustomStrings(Data);
 if (FontType and RASTER_FONTTYPE = 0) then
  Result := 0
 else
 begin
  if (StrPas(LogFont.lfFaceName) = EnumFontName) then
  begin
   FntSize := MulDiv(LogFont.lfHeight, 72, Screen.PixelsPerInch);
   FSizeStr := IntToStr(FntSize);
   Added := False;
   for I:=0 to Box.Count-1 do
   begin
    tmpSize := StrToInt(Box[I].AsString);
    if (tmpSize > FntSize)then
     Box.Insert(I, FSizeStr);
    if (tmpSize >= FntSize) then
    begin
     Added := True;
     Break;
    end;//tmpSize >= FntSize
   end;//for I:=0
   if Not Added then
    Box.Add(FSizeStr);
  end;//StrPas(LogFont.lfFaceName) = EnumFontName
  Result := 1;
 end;//FontType and RASTER_FONTTYPE = 0
end;

procedure GetFontSizeList(const FFontName : String; List : Tl3CustomStrings);
var
 DC : HDC;
 I  : Integer;
begin
 List.Clear;
 if (FFontName <> '') then
 begin
  DC := GetDC(0);
  try
   EnumFontName := FFontName;
   EnumFonts(DC, PChar(FFontName), @FSEnumFontsProc1, Pointer(List));
  finally
   ReleaseDC(0, DC);
  end;//try..finally
 end;//FFontName <> ''
 if (List.Count <= 0) then
 Begin
  For I := 8 to 12 do List.Add(IntToStr(I));
  For I := 7 to 14 do List.Add(IntToStr(I*2));
  For I := 3 to 6  do List.Add(IntToStr(I*12));
 end;//List.Count <= 0
end;

procedure GetFontListEx(aList: Tl3CustomStrings; aCharSet: Byte);
// http://mdp.garant.ru/pages/viewpage.action?pageId=499495428
var
 l_DC: HDC;
 l_LogFont: TLogFont;
begin
 l3FillChar(l_LogFont, SizeOf(l_LogFont), 0);
 l_LogFont.lfCharSet := aCharSet;
 l_DC := GetDC(0);
 try
  // The EnumFontFamiliesEx function enumerates all uniquely-named fonts in
  // the system that match the font characteristics specified by the LOGFONT structure
  EnumFontFamiliesEx(l_DC, l_LogFont, @FEnumFontsProc1, LPARAM(aList), DWORD(0));
 finally
  ReleaseDC(0, l_DC);
 end;//try..finally
end;

procedure GetfontSizeListEx(const aFontName: String; aList: Tl3CustomStrings; aCharSet: Byte);
// http://mdp.garant.ru/pages/viewpage.action?pageId=499495428
var
 l_DC: HDC;
 l_Index: Integer;
 l_LogFont: TLogFont;
begin
 aList.Clear;
 if (aFontName <> '') then
 begin
  l_DC := GetDC(0);
  l3FillChar(l_LogFont, SizeOf(l_LogFont), 0);
  try
   l_LogFont.lfCharSet := aCharSet;
   StrPCopy(l_LogFont.lfFaceName, aFontName);
   EnumFontFamiliesEx(l_DC, l_LogFont, @FSEnumFontsProc1, LPARAM(aList), DWORD(0));
  finally
   ReleaseDC(0, l_DC);
  end;//try..finally
 end;//aFontName <> ''
 if (aList.Count <= 0) then
 begin
  for l_Index := 8 to 12 do
   aList.Add(IntToStr(l_Index));
  for l_Index := 7 to 14 do
   aList.Add(IntToStr(l_Index * 2));
  for l_Index := 3 to 6  do
   aList.Add(IntToStr(l_Index * 12));
 end;//List.Count <= 0
end;

procedure TFontSizeComboBox.CreateWnd;
 Begin
  Inherited CreateWnd;
  BuildList;
 end;

Procedure TFontSizeComboBox.SetFontName(Value : String);
 Begin
  If FFontName = Value then Exit;
  FFontName := Value;
  BuildList;
 end;

procedure TFontSizeComboBox.BuildList;
 Begin
  if not HandleAllocated then Exit;
  GetFontSizeList(FFontName, Items);
 end;

Function  TFontSizeComboBox.GetFontSize : Integer;
Begin
{IfDef Debug}
 If Text=''
  then Result:=0
  else
{EndIf}
 Try
  Result:=StrToInt(Text);
 except
  Result:=0;
 end;
end;

Procedure TFontSizeComboBox.SetFontSize (Value : Integer);
Begin
 If Value <= 0
  then Text:=''
  else
   If FontSize <> Value
    then Text:=IntToStr(Value);
end;

{TvtComboBox}

constructor TvtComboBox.Create(AOwner: TComponent);
 begin
  Inherited Create(AOwner);
  fHistorySize := 20;
 end;

procedure TvtComboBox.AddToHistory;
 var
  lInd : Integer;

 function lFindStr(const S: string): Integer;
  begin
   with Items do
   begin
    for Result := 0 to Count - 1 do
     if AnsiCompareStr(Strings[Result], S) = 0 then Exit;
    Result := -1;
   end;
 end;

 begin
  If Text = '' then Exit;
  with Items do
   begin
    lInd :=lFindStr(Self.Text);   // IndexOf(Self.Text); - регистронезвасимый поиск
    If (lInd = -1) then
    begin
     Insert(0, Self.Text);
     While Count > fHistorySize do
      Delete(Pred(Count));
    end
    else
     Move(lInd,0);
    ItemIndex := 0;
   end;
 end;

procedure TvtComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer);
begin
 if Message.Msg = WM_KILLFOCUS then
 begin
  FSavedSelStart := inherited GetSelStart;
  FSavedSelLength := inherited GetSelLength;
 end;
 inherited;
end;

function TvtComboBox.GetSelLength: Integer;
begin
 if Focused then
  Result := inherited GetSelLength
 else
  Result := FSavedSelLength;
end;

function TvtComboBox.GetSelStart: Integer;
begin
 if Focused then
  Result := inherited GetSelStart
 else
  Result := FSavedSelStart;
end;

procedure TvtImage.WMCut(var Msg: TMessage);
 begin
  Clipboard.Assign(Picture);
  Picture.Graphic := nil;
 end;

procedure TvtImage.WMCopy(var Msg: TMessage);
 begin
  Clipboard.Assign(Picture);
 end;

procedure TvtImage.WMPaste(var Msg: TMessage);
 begin
  Picture.Assign(Clipboard);
 end;

procedure TvtImage.WMClear(var Msg: TMessage);
 begin
  Picture.Graphic := nil;
 end;


{ TvtSplitter }

type
 TWinControlAccess = class(TWinControl);

constructor TvtSplitter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoSnap := True;
  Align := alLeft;
  Width := 3;
  Cursor := crHSplit;
  FMinSize := 30;
  FResizeStyle := rsPattern;
  FOldSize := -1;
  fInDblClick := False;
end;

destructor TvtSplitter.Destroy;
begin
  FBrush.Free;
  inherited Destroy;
end;

procedure TvtSplitter.AllocateLineDC;
begin
  FLineDC := GetDCEx(Parent.Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS
    or DCX_LOCKWINDOWUPDATE);
  if ResizeStyle = rsPattern then
  begin
    if FBrush = nil then
    begin
      FBrush := TBrush.Create;
      FBrush.Bitmap := AllocPatternBitmap(clBlack, clWhite);
    end;
    FPrevBrush := SelectObject(FLineDC, FBrush.Handle);
  end;
end;

procedure TvtSplitter.DrawLine;
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

procedure TvtSplitter.ReleaseLineDC;
begin
  if FPrevBrush <> 0 then
    SelectObject(FLineDC, FPrevBrush);
  ReleaseDC(Parent.Handle, FLineDC);
  if FBrush <> nil then
  begin
    FBrush.Free;
    FBrush := nil;
  end;
end;

procedure TvtSplitter.RequestAlign;
begin
  inherited RequestAlign;
  if (Cursor <> crVSplit) and (Cursor <> crHSplit) then Exit;
  if Align in [alBottom, alTop] then
    Cursor := crVSplit
  else
    Cursor := crHSplit;
end;

procedure TvtSplitter.Paint;
const
  XorColor = $00FFD8CE;
var
  //FrameBrush: HBRUSH;
  R: TRect;
begin
  R := ClientRect;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);
  if Beveled then
  {V}
  begin
    Frame3D(Canvas, R, clBtnHighlight, clBtnShadow, 1 +
            ord(((Align in [alLeft, alRight]) and (Width > 5)) or
               (not (Align in [alLeft, alRight]) and (height > 5))));
  end;
  {
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
  }
  {^V}

  if csDesigning in ComponentState then
    { Draw outline }
    with Canvas do
    begin
      Pen.Style := psDot;
      Pen.Mode := pmXor;
      Pen.Color := XorColor;
      Brush.Style := bsClear;
      Rectangle(0, 0, ClientWidth, ClientHeight);
    end;
  if Assigned(FOnPaint) then FOnPaint(Self);
end;

function TvtSplitter.GetControlSize : Integer;
 var
  lControl : TControl;
 begin
  lControl := FindControl;
  if not Assigned(lControl) then
  begin
   Result := 0;
   Exit;
  end;

  if Align in [alLeft, alRight] then
   Result := lControl.Width
  else
   Result := lControl.Height;
 end;

function TvtSplitter.FindControl: TControl;
var
  P: TPoint;
  I: Integer;
  R: TRect;
begin
  If FSplitControl <> nil then
  begin
   Result := FSplitControl;
   Exit;
  end;

  If Align in [alLeft, alTop] then
   for I := 0 to Parent.ControlCount - 1 do
    begin
     Result := Parent.Controls[I];
     If (Result <> Self) and (Result.Align = Align) and Result.Visible
      then
       If (Align = alLeft) and (Result.Width = 0) and (Result.Left = Left + Width)
        then Exit
        else
         If (Align = alTop) and (Result.Height = 0) and (Result.Top = Top + Height)
          then Exit;
    end;


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
    if Result.Visible and Result.Enabled then
    begin
      R := Result.BoundsRect;
      if (R.Right - R.Left) = 0 then
        if Align in [alTop, alLeft] then
          Dec(R.Left)
        else
          Inc(R.Right);
      if (R.Bottom - R.Top) = 0 then
        if Align in [alTop, alLeft] then
          Dec(R.Top)
        else
          Inc(R.Bottom);
      if PtInRect(R, P) then Exit;
    end;
  end;
  Result := nil;
end;

function TvtSplitter.DoCanResize(var NewSize: Integer): Boolean;
begin
  Result := CanResize(NewSize);
  if Result and (NewSize <= MinSize) and FAutoSnap then
    NewSize := 0;

end;

function TvtSplitter.CanResize(var NewSize: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnCanResize) then FOnCanResize(Self, NewSize, Result);
end;


procedure TvtSplitter.UpdateControlSize;

function Min(X, Y: Integer): Integer;
  begin
    if X > Y
     then Result := Y
     else Result := X;
  end;

begin
  if FNewSize <> FOldSize then
  begin
    case Align of
      alLeft:
        begin
          Parent.DisableAlign;
          try
           FControl.Width := FNewSize;
           //Left := Min(FControl.Left, Left) + FNewSize;
           //Left := FControl.Left{ FNewSize};
          finally
           Parent.EnableAlign;
          end;
          Left := Min(FControl.Left, Left) + FNewSize;
        end;
      alTop:
        begin
          Parent.DisableAlign;
          try
           FControl.Height := FNewSize;
          finally
           Parent.EnableAlign;
          end;
          Top := FControl.Top + FNewSize;
         end;
      alRight:
        begin
          Parent.DisableAlign;
          try
           FControl.Left := FControl.Left + (FControl.Width - FNewSize);
          finally
           Parent.EnableAlign;
          end;
          FControl.Width := FNewSize;
        end;
      alBottom:
        begin
          Parent.DisableAlign;
          try
           FControl.Top := FControl.Top + (FControl.Height - FNewSize);
          finally
           Parent.EnableAlign;
          end;
          FControl.Height := FNewSize;
        end;
    end;
    Update;
    if Assigned(FOnMoved) then FOnMoved(Self);
    FOldSize := FNewSize;
    If FNewSize > 0 then FSaveSize := FNewSize;
  end;
end;

procedure TvtSplitter.CalcSplitSize(X, Y: Integer; var NewSize, Split: Integer);
var
  S: Integer;
begin
  if Align in [alLeft, alRight] then
    Split := X - FDownPos.X
  else
    Split := Y - FDownPos.Y;

  S := 0;
  case Align of
   alLeft   : S := FControl.Width + Split;
   alRight  : S := FControl.Width - Split;
   alTop    : S := FControl.Height + Split;
   alBottom : S := FControl.Height - Split;
  end;
  NewSize := S;

  if S < 5 then
   S := 0
  else
   if S < FMinSize then
    NewSize := FMinSize
   else
    if S > FMaxSize then
     NewSize := FMaxSize;

  if S <> NewSize then
  begin
   if Align in [alRight, alBottom] then
    S := S - NewSize
   else
    S := NewSize - S;
   Inc(Split, S);
  end;
end;

procedure TvtSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
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
            if Visible and (Align in [alLeft, alRight]) then Dec(FMaxSize, Width);
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

      CalcSplitSize(X, Y, FNewSize, FSplit);
      AllocateLineDC;
      with ValidParentForm(Self) do
        if ActiveControl <> nil then
        begin
          FActiveControl := ActiveControl;     
         // If Pointer(TWinControlAccess(FActiveControl).OnKeyDown) <> @FocusKeyDown then
          begin
           FOldKeyDown := TWinControlAccess(FActiveControl).OnKeyDown;
           TWinControlAccess(FActiveControl).OnKeyDown := FocusKeyDown;
          end;
        end;
      if ResizeStyle in [rsLine, rsPattern] then DrawLine;
    end;
  end;
end;

procedure TvtSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewSize, Split: Integer;
begin
  inherited;
  if (ssLeft in Shift) and Assigned(FControl) then
  begin
   CalcSplitSize(X, Y, NewSize, Split);
   if DoCanResize(NewSize) {and (NewSize <> GetControlSize)} then
   begin
    fInDblClick := False;
    if ResizeStyle in [rsLine, rsPattern] then DrawLine;
    FNewSize := NewSize;
    FSplit := Split;
    if ResizeStyle = rsUpdate then UpdateControlSize;
    if ResizeStyle in [rsLine, rsPattern] then DrawLine;
   end;
  end;
end;

procedure TvtSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  If fInDblClick then
  begin
   StopSizing;
   If GetControlSize = 0 then
    FNewSize := FSaveSize
   else
    FNewSize := 0;

   FControl := FindControl;
   UpdateControlSize;
   FControl := nil;

   fInDblClick := False;
  end
  else
   if Assigned(FControl) then
   begin
    if ResizeStyle in [rsLine, rsPattern] then DrawLine;
    UpdateControlSize;
    StopSizing;
   end;
end;

procedure TvtSplitter.DblClick;
begin
 Inherited;
 fInDblClick := True;
end;

procedure TvtSplitter.FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    StopSizing
  else
   if Assigned(FOldKeyDown) then
    FOldKeyDown(Sender, Key, Shift);
end;

procedure TvtSplitter.SetBeveled(Value: Boolean);
begin
  FBeveled := Value;
  Invalidate;
end;

procedure TvtSplitter.StopSizing;
begin
  if Assigned(FControl) then
  begin
    if FLineVisible then DrawLine;
    FControl := nil;
    ReleaseLineDC;
    if Assigned(FActiveControl) then
    begin
      TWinControlAccess(FActiveControl).OnKeyDown := FOldKeyDown;
      FActiveControl := nil;
    end;
  end;
  if Assigned(FOnMoved) then
    FOnMoved(Self);
end;

end.
