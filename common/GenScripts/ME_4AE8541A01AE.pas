unit vtLabel;

// Модуль: "w:\common\components\gui\Garant\VT\vtLabel.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtLabel" MUID: (4AE8541A01AE)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3PureMixIns
 , afwInterfaces
 , l3Interfaces
 , evdTypes
 , l3GraphicControlCanvas
 , Messages
 , Classes
 , Types
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4AE8541A01AEintf_uses*
 //#UC END# *4AE8541A01AEintf_uses*
;

type
 TvtDrawDirection = (
  ddHorizontal
  , ddVertical
 );//TvtDrawDirection

 {$Define _UnknownIsComponent}

 //#UC START# *50253C0401F1ci*
 //#UC END# *50253C0401F1ci*
 _l3Unknown_Parent_ = TCustomLabel;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *50253C0401F1cit*
 //#UC END# *50253C0401F1cit*
 TvtCustomLabelPrim = class(_l3Unknown_)
 //#UC START# *50253C0401F1publ*
 protected
   {$I l3DefineCleanup.inc}
 //#UC END# *50253C0401F1publ*
 end;//TvtCustomLabelPrim

 //#UC START# *4F29240F0204ci*
 //#UC END# *4F29240F0204ci*
 //#UC START# *4F29240F0204cit*
 //#UC END# *4F29240F0204cit*
 TvtCustomLabel = class(TvtCustomLabelPrim, IafwTextControl)
  private
   f_Canvas: Tl3GraphicControlCanvas;
   f_InAdjustBounds: Boolean;
   f_EndEllipsis: Boolean;
   f_CCaption: Il3CString;
   f_VerticalAligment: TevVerticalAligment;
   f_DrawDirection: TvtDrawDirection;
   f_Caption: Tl3DString;
  private
   procedure WMGetText(var Msg: TMessage); message WM_GetText;
   procedure WMGetTextLength(var Msg: TMessage); message WM_GetTextLength;
   procedure WMSetText(var Msg: TMessage); message WM_SetText;
  protected
   procedure pm_SetEndEllipsis(aValue: Boolean);
   procedure pm_SetDrawDirection(aValue: TvtDrawDirection);
   function pm_GetCaption: Tl3DString; virtual;
   procedure pm_SetCaption(aValue: Tl3DString); virtual;
   {$If Defined(DesignTimeLibrary)}
   function CheckStamp(const aGUID: TGUID): Boolean;
   {$IfEnd} // Defined(DesignTimeLibrary)
   function CaptionStored: Boolean;
    {* Функция определяющая, что свойство Caption сохраняется }
   function pm_GetCCaption: IafwCString;
   procedure pm_SetCCaption(const aValue: IafwCString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure AdjustBounds; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If Defined(l3HackedVCL) AND NOT Defined(NoVCL)}
   function GetLabelText: AnsiString; override;
   {$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure DoDrawText(var Rect: TRect;
    Flags: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure ClearFields; override;
  public
   constructor Create(AOwner: TComponent); override;
  public
   property EndEllipsis: Boolean
    read f_EndEllipsis
    write pm_SetEndEllipsis
    default False;
   property CCaption: Il3CString
    read f_CCaption
    write pm_SetCCaption;
   property VerticalAligment: TevVerticalAligment
    read f_VerticalAligment
    write f_VerticalAligment;
   property DrawDirection: TvtDrawDirection
    read f_DrawDirection
    write pm_SetDrawDirection;
   property Caption: Tl3DString
    read pm_GetCaption
    write pm_SetCaption
    stored CaptionStored;
 //#UC START# *4F29240F0204publ*
 protected
   property ParentFont default False;
 //#UC END# *4F29240F0204publ*
 end;//TvtCustomLabel

 //#UC START# *5703BF610068ci*
 //#UC END# *5703BF610068ci*
 //#UC START# *5703BF610068cit*
 //#UC END# *5703BF610068cit*
 TvtStyledLabel = class(TvtCustomLabel{$If NOT Defined(DesignTimeLibrary)}
 , IafwStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 )
  {* Метка, которая следит за таблицей стилей }
  private
   f_StyleId: Tl3StyleId;
  protected
   procedure pm_SetStyleId(aValue: Tl3StyleId);
   {$If NOT Defined(DesignTimeLibrary)}
   procedure StyleTableChanged;
    {* таблица стилей изменилась. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(AOwner: TComponent); override;
  public
   property StyleId: Tl3StyleId
    read f_StyleId
    write pm_SetStyleId;
 //#UC START# *5703BF610068publ*
   published
     property Align;
     property Alignment;
     property Anchors;
     property AutoSize;
     property BiDiMode;
     property Caption;
     property Color nodefault;
     property Constraints;
     property DragCursor;
     property DragKind;
     property DragMode;
     property Enabled;
     property FocusControl;
     property Font;
     property ParentBiDiMode;
     property ParentColor;
     property ParentFont;
     property ParentShowHint;
     property PopupMenu;
     property ShowAccelChar;
     property ShowHint;
     property Transparent;
     property Layout;
     property Visible;
     property WordWrap;
     property EndEllipsis;
     property OnClick;
     property OnContextPopup;
     property OnDblClick;
     property OnDragDrop;
     property OnDragOver;
     property OnEndDock;
     property OnEndDrag;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;
     property OnMouseEnter;
     property OnMouseLeave;
     property OnStartDock;
     property OnStartDrag;
     property DrawDirection
      default ddHorizontal;
 //#UC END# *5703BF610068publ*
 end;//TvtStyledLabel

 TvtImagePosition = (
  ipLeft
  , ipRight
 );//TvtImagePosition

 //#UC START# *57039747002Eci*
 //#UC END# *57039747002Eci*
 //#UC START# *57039747002Ecit*
 //#UC END# *57039747002Ecit*
 TvtImageLabel = class(TvtStyledLabel)
  {* Метка с иконкой }
  private
   f_ImageChangeLink: TChangeLink;
   f_ImagePosition: TvtImagePosition;
   f_ImageIndex: Integer;
   f_ImageList: TCustomImageList;
   f_ImageIndent: Integer;
  private
   procedure OnImageListChange(Sender: TObject);
  protected
   procedure pm_SetImagePosition(aValue: TvtImagePosition);
   procedure pm_SetImageIndex(aValue: Integer);
   procedure pm_SetImageList(aValue: TCustomImageList);
   procedure pm_SetImageIndent(aValue: Integer);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure AdjustBounds; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure DoDrawText(var Rect: TRect;
    Flags: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
  public
   property ImagePosition: TvtImagePosition
    read f_ImagePosition
    write pm_SetImagePosition;
   property ImageIndex: Integer
    read f_ImageIndex
    write pm_SetImageIndex;
   property ImageList: TCustomImageList
    read f_ImageList
    write pm_SetImageList;
   property ImageIndent: Integer
    read f_ImageIndent
    write pm_SetImageIndent;
 //#UC START# *57039747002Epubl*
   published
     property Align;
     property Alignment;
     property Anchors;
     property AutoSize;
     property BiDiMode;
     property Caption;
     property Color nodefault;
     property Constraints;
     property DragCursor;
     property DragKind;
     property DragMode;
     property Enabled;
     property FocusControl;
     property Font;
     property ParentBiDiMode;
     property ParentColor;
     property ParentFont;
     property ParentShowHint;
     property PopupMenu;
     property ShowAccelChar;
     property ShowHint;
     property Transparent;
     property Layout;
     property Visible;
     property WordWrap;
     property EndEllipsis;
     property OnClick;
     property OnContextPopup;
     property OnDblClick;
     property OnDragDrop;
     property OnDragOver;
     property OnEndDock;
     property OnEndDrag;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;
     property OnMouseEnter;
     property OnMouseLeave;
     property OnStartDock;
     property OnStartDrag;
     property DrawDirection
      default ddHorizontal;
 //#UC END# *57039747002Epubl*
 end;//TvtImageLabel

 //#UC START# *4AE8541A01AEci*
 //#UC END# *4AE8541A01AEci*
 //#UC START# *4AE8541A01AEcit*
 //#UC END# *4AE8541A01AEcit*
 TvtLabel = class(TvtCustomLabel)
 //#UC START# *4AE8541A01AEpubl*
   published
     property Align;
     property Alignment;
     property Anchors;
     property AutoSize;
     property BiDiMode;
     property Caption;
     property Color nodefault;
     property Constraints;
     property DragCursor;
     property DragKind;
     property DragMode;
     property Enabled;
     property FocusControl;
     property Font;
     property ParentBiDiMode;
     property ParentColor;
     property ParentFont;
     property ParentShowHint;
     property PopupMenu;
     property ShowAccelChar;
     property ShowHint;
     property Transparent;
     property Layout;
     property Visible;
     property WordWrap;
     property EndEllipsis;
     property OnClick;
     property OnContextPopup;
     property OnDblClick;
     property OnDragDrop;
     property OnDragOver;
     property OnEndDock;
     property OnEndDrag;
     property OnMouseDown;
     property OnMouseMove;
     property OnMouseUp;
     property OnMouseEnter;
     property OnMouseLeave;
     property OnStartDock;
     property OnStartDrag;
     property DrawDirection
      default ddHorizontal;
 //#UC END# *4AE8541A01AEpubl*
 end;//TvtLabel

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , l3MemUtils
 , l3Interlocked
 , l3String
 , afwVCL
 , Graphics
 , l3Types
 , l3MinMax
 , evStyleInterface
 , TextPara_Const
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , evdTextStyle_Const
 //#UC START# *4AE8541A01AEimpl_uses*
 //#UC END# *4AE8541A01AEimpl_uses*
;

type
 THackLink = class({$If NOT Defined(NoVCL)}
 TControlActionLink
 {$IfEnd} // NOT Defined(NoVCL)
 )
 end;//THackLink

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

//#UC START# *50253C0401F1impl*
type
 _Unknown_Child_ = TvtCustomLabelPrim;
{$I l3ImplCleanup.inc}
begin
 inherited;
end;
//#UC END# *50253C0401F1impl*

procedure TvtCustomLabel.pm_SetEndEllipsis(aValue: Boolean);
//#UC START# *4F2A579F0395_4F29240F0204set_var*
//#UC END# *4F2A579F0395_4F29240F0204set_var*
begin
//#UC START# *4F2A579F0395_4F29240F0204set_impl*
 if (f_EndEllipsis <> aValue) then
 begin
  f_EndEllipsis := aValue;
  AdjustBounds;
  Invalidate;
 end;//f_EndEllipsis <> Value
//#UC END# *4F2A579F0395_4F29240F0204set_impl*
end;//TvtCustomLabel.pm_SetEndEllipsis

procedure TvtCustomLabel.pm_SetDrawDirection(aValue: TvtDrawDirection);
//#UC START# *4F29387A0298_4F29240F0204set_var*
//#UC END# *4F29387A0298_4F29240F0204set_var*
begin
//#UC START# *4F29387A0298_4F29240F0204set_impl*
 if (f_DrawDirection <> aValue) then
 begin
  f_DrawDirection := aValue;
  AdjustBounds;
 end;//f_DrawDirection <> aValue
//#UC END# *4F29387A0298_4F29240F0204set_impl*
end;//TvtCustomLabel.pm_SetDrawDirection

function TvtCustomLabel.pm_GetCaption: Tl3DString;
//#UC START# *4F2A554F01F4_4F29240F0204get_var*
//#UC END# *4F2A554F01F4_4F29240F0204get_var*
begin
//#UC START# *4F2A554F01F4_4F29240F0204get_impl*
 Result := l3DStr(CCaption);
//#UC END# *4F2A554F01F4_4F29240F0204get_impl*
end;//TvtCustomLabel.pm_GetCaption

procedure TvtCustomLabel.pm_SetCaption(aValue: Tl3DString);
//#UC START# *4F2A554F01F4_4F29240F0204set_var*
//#UC END# *4F2A554F01F4_4F29240F0204set_var*
begin
//#UC START# *4F2A554F01F4_4F29240F0204set_impl*
 CCaption := l3CStr(aValue);
//#UC END# *4F2A554F01F4_4F29240F0204set_impl*
end;//TvtCustomLabel.pm_SetCaption

procedure TvtCustomLabel.WMGetText(var Msg: TMessage);
//#UC START# *4F2932F103B5_4F29240F0204_var*
//#UC END# *4F2932F103B5_4F29240F0204_var*
begin
//#UC START# *4F2932F103B5_4F29240F0204_impl*
 with Msg do
  Result := StrLen(StrLCopy(PChar(LParam), PChar(l3Str(CCaption)), WParam - 1));
//#UC END# *4F2932F103B5_4F29240F0204_impl*
end;//TvtCustomLabel.WMGetText

procedure TvtCustomLabel.WMGetTextLength(var Msg: TMessage);
//#UC START# *4F2933200190_4F29240F0204_var*
//#UC END# *4F2933200190_4F29240F0204_var*
begin
//#UC START# *4F2933200190_4F29240F0204_impl*
 Msg.Result := l3Len(CCaption);
//#UC END# *4F2933200190_4F29240F0204_impl*
end;//TvtCustomLabel.WMGetTextLength

procedure TvtCustomLabel.WMSetText(var Msg: TMessage);
//#UC START# *4F293E2A012A_4F29240F0204_var*
//#UC END# *4F293E2A012A_4F29240F0204_var*
begin
//#UC START# *4F293E2A012A_4F29240F0204_impl*
 if (Msg.lParam <> 0) then
 begin
  Msg.Result := Ord(true);
  CCaption := l3CStr(l3PCharLen(PChar(Msg.lParam)));
 end//Msg.lParam <> 0
 else
  Msg.Result := Ord(false);
//#UC END# *4F293E2A012A_4F29240F0204_impl*
end;//TvtCustomLabel.WMSetText

{$If Defined(DesignTimeLibrary)}
function TvtCustomLabel.CheckStamp(const aGUID: TGUID): Boolean;
//#UC START# *4F293EBE00D9_4F29240F0204_var*
//#UC END# *4F293EBE00D9_4F29240F0204_var*
begin
//#UC START# *4F293EBE00D9_4F29240F0204_impl*
 Result := false;
//#UC END# *4F293EBE00D9_4F29240F0204_impl*
end;//TvtCustomLabel.CheckStamp
{$IfEnd} // Defined(DesignTimeLibrary)

function TvtCustomLabel.CaptionStored: Boolean;
 {* Функция определяющая, что свойство Caption сохраняется }
//#UC START# *4F2A554F01F4Stored_4F29240F0204_var*
//#UC END# *4F2A554F01F4Stored_4F29240F0204_var*
begin
//#UC START# *4F2A554F01F4Stored_4F29240F0204_impl*
 Result := not l3IsNil(CCaption) AND
           ((ActionLink = nil) or not THackLink(ActionLink).IsCaptionLinked);
//#UC END# *4F2A554F01F4Stored_4F29240F0204_impl*
end;//TvtCustomLabel.CaptionStored

function TvtCustomLabel.pm_GetCCaption: IafwCString;
//#UC START# *473DAC05025F_4F29240F0204get_var*
//#UC END# *473DAC05025F_4F29240F0204get_var*
begin
//#UC START# *473DAC05025F_4F29240F0204get_impl*
 Result := f_CCaption;
//#UC END# *473DAC05025F_4F29240F0204get_impl*
end;//TvtCustomLabel.pm_GetCCaption

procedure TvtCustomLabel.pm_SetCCaption(const aValue: IafwCString);
//#UC START# *473DAC05025F_4F29240F0204set_var*
//#UC END# *473DAC05025F_4F29240F0204set_var*
begin
//#UC START# *473DAC05025F_4F29240F0204set_impl*
 if not l3Same(f_CCaption, aValue) then
 begin
  f_CCaption := aValue;
  Perform(CM_TEXTCHANGED, 0, 0);
  SendDockNotification(afw_CM_TEXTCHANGED, 0, Integer(aValue));
 end;//not l3Same(f_Text, aValue)
//#UC END# *473DAC05025F_4F29240F0204set_impl*
end;//TvtCustomLabel.pm_SetCCaption

procedure TvtCustomLabel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F29240F0204_var*
//#UC END# *479731C50290_4F29240F0204_var*
begin
//#UC START# *479731C50290_4F29240F0204_impl*
 f_CCaption := nil;
 l3Free(f_Canvas);
 inherited;
//#UC END# *479731C50290_4F29240F0204_impl*
end;//TvtCustomLabel.Cleanup

constructor TvtCustomLabel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4F29240F0204_var*
//#UC END# *47D1602000C6_4F29240F0204_var*
begin
//#UC START# *47D1602000C6_4F29240F0204_impl*
 inherited Create(AOwner);
 afwHackControlFont(Self);
 f_Canvas := Tl3GraphicControlCanvas.Create(Self);
 f_EndEllipsis := False;
//#UC END# *47D1602000C6_4F29240F0204_impl*
end;//TvtCustomLabel.Create

{$If NOT Defined(NoVCL)}
procedure TvtCustomLabel.AdjustBounds;
//#UC START# *4F2A44BC0297_4F29240F0204_var*
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
  AAlignment: TAlignment;
//#UC END# *4F2A44BC0297_4F29240F0204_var*
begin
//#UC START# *4F2A44BC0297_4F29240F0204_impl*
 if not (csReading in ComponentState) and AutoSize then
 begin
  if not f_InAdjustBounds then
   try
    f_InAdjustBounds := true;
    Rect := ClientRect;
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[WordWrap]);
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    X := Left;
    AAlignment := Alignment;
    if UseRightToLeftAlignment then
     ChangeBiDiModeAlignment(AAlignment);
    if (AAlignment = taRightJustify) then
     Inc(X, Width - Rect.Right);
    if DrawDirection = ddHorizontal then
    begin
     //http://mdp.garant.ru/pages/viewpage.action?pageId=494529735
     if Align = alClient then
      SetBounds(Left, Top, Width, Height)
     else
      SetBounds(X, Top, Rect.Right, Rect.Bottom);
    end
    else
     SetBounds(X, Top, Rect.Bottom, Rect.Right);
   finally
    f_InAdjustBounds := false;
   end;//try..finally
 end;//not (csReading in ComponentState) and AutoSize
//#UC END# *4F2A44BC0297_4F29240F0204_impl*
end;//TvtCustomLabel.AdjustBounds
{$IfEnd} // NOT Defined(NoVCL)

{$If Defined(l3HackedVCL) AND NOT Defined(NoVCL)}
function TvtCustomLabel.GetLabelText: AnsiString;
//#UC START# *4F2A45C40091_4F29240F0204_var*
//#UC END# *4F2A45C40091_4F29240F0204_var*
begin
//#UC START# *4F2A45C40091_4F29240F0204_impl*
 Result := l3Str(CCaption);
//#UC END# *4F2A45C40091_4F29240F0204_impl*
end;//TvtCustomLabel.GetLabelText
{$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomLabel.DoDrawText(var Rect: TRect;
 Flags: Integer);
//#UC START# *4F2A461702D8_4F29240F0204_var*
 function GetLogFont(aFont : TFont): TLogFont;
 const
  cPrecision : array[Boolean] of Integer = (OUT_TT_PRECIS, OUT_TT_ONLY_PRECIS);
  cBoolToByte : array[Boolean] of Byte = (0, 1);
  cRotation = 90;
 begin//GetLogFont
  with Result do
  begin
   lfHeight := aFont.Height;
   //if ScaledFont then lfHeight := Trunc(lfHeight * (Screen.PixelsPerInch / 96));
   lfWidth := 0;
   lfEscapement := cRotation * 10;
   lfOrientation := cRotation * 10;

   if fsBold in aFont.Style
    then lfWeight := FW_BOLD
    else lfWeight := FW_NORMAL;
   lfItalic    := cBoolToByte[fsItalic in aFont.Style];
   lfUnderline := cBoolToByte[fsUnderline in aFont.Style];
   lfStrikeout := cBoolToByte[fsStrikeOut in aFont.Style];

   if aFont.CharSet = DEFAULT_CHARSET then
    lfCharSet := ANSI_CHARSET
   else
    lfCharSet := aFont.CharSet;

   lfOutPrecision := cPrecision[cRotation <> 0];
   lfClipPrecision := CLIP_DEFAULT_PRECIS; {Default}
   lfQuality := PROOF_QUALITY;             {Windows gets a better one if available}
   lfPitchAndFamily := VARIABLE_PITCH;     {Default}
   StrPCopy(lfFaceName, aFont.Name);       {Canvas's font name}
  end;//with Result
 end;//GetLogFont

 procedure PrepareCanvas;
 begin//PrepareCanvas
  if (Flags and DT_CALCRECT <> DT_CALCRECT) and
     (DrawDirection <> ddHorizontal) then
   F_Canvas.Canvas.Font.Handle := CreateFontIndirect(GetLogFont(Font));
 end;//PrepareCanvas

 procedure FreeCanvas;
 begin//FreeCanvas
  if (Flags and DT_CALCRECT <> DT_CALCRECT) and
     (DrawDirection <> ddHorizontal) then
   DeleteObject(F_Canvas.Canvas.Font.Handle);
 end;//FreeCanvas

var
 ll3Text : Tl3PCharLen;
 lText   : Il3CString;
 l_DC    : HDC;
 lRect   : TRect;
//#UC END# *4F2A461702D8_4F29240F0204_var*
begin
//#UC START# *4F2A461702D8_4F29240F0204_impl*
 if Transparent then
  f_Canvas.etoFlags := 0
 else
  f_Canvas.etoFlags := eto_Opaque;
 lText := CCaption;
 if (Flags and DT_CALCRECT <> 0) and (l3IsNil(lText) or ShowAccelChar and
   (l3IsChar(lText, 0, '&')) and (l3Len(lText) = 1)) then
  lText := l3Cat(lText, ' ');
 if not ShowAccelChar then
  Flags := Flags or DT_NOPREFIX;
 if f_EndEllipsis then
  Flags := Flags or DT_END_ELLIPSIS;
 Flags := DrawTextBiDiModeFlags(Flags);
 f_Canvas.Font.AssignFont(Font);
 ll3Text := l3PCharLen(lText);
 f_Canvas.BeginPaint;
 try
  f_Canvas.BackColor := Color;
  f_Canvas.DrawEnabled := True;
  if Transparent then
   SetBkMode(f_Canvas.DC, Windows.TRANSPARENT)
  else
  begin
   SetBkColor(f_Canvas.DC, ColorToRGB(f_Canvas.BackColor));
   SetBkMode(f_Canvas.DC, Windows.OPAQUE);
  end;//Transparent

  if not Enabled then
  begin
   OffsetRect(Rect, 1, 1);
   Canvas.Font.Color := clBtnHighlight;
   f_Canvas.DrawText(ll3Text, Rect, Flags);
   OffsetRect(Rect, -1, -1);
   Canvas.Font.Color := clBtnShadow;
   f_Canvas.DrawText(ll3Text, Rect, Flags);
  end//not Enabled
  else
  begin
   l_DC := f_Canvas.DC;
   PrepareCanvas;
   try
    if (DrawDirection <> ddHorizontal) and
       (Flags and DT_CALCRECT <> DT_CALCRECT) then
    begin
     lRect := Rect;
     lRect.Top := lRect.Bottom;
     f_Canvas.DrawText(ll3Text, lRect, Flags or dt_noclip);
    end//DrawDirection <> ddHorizontal
    else
    begin
     if (Flags and DT_CALCRECT <> DT_CALCRECT) then
     begin
      Case f_VerticalAligment of
       ev_valCenter:
       begin
        Assert(not WordWrap);
        Rect.Top := Rect.Top + (Self.Height - f_Canvas.Canvas.TextHeight('W')) div 2;
       end;//ev_valCenter
       ev_valBottom:
       begin
        Assert(not WordWrap);
        Rect.Top := Rect.Top + (Self.Height - f_Canvas.Canvas.TextHeight('W'));
       end;//ev_valBottom
      end;//Case f_VerticalAligment
     end;//Flags and DT_CALCRECT <> DT_CALCRECT
     f_Canvas.DrawText(ll3Text, Rect, Flags);
     if (Flags and DT_CALCRECT = DT_CALCRECT) then
     begin
      if EndEllipsis AND not WordWrap then
       if (Parent <> nil) then
        Rect.Right := Min(Rect.Right, Parent.Width - Self.Left);
     end;//Flags and DT_CALCRECT = DT_CALCRECT
    end;//DrawDirection <> ddHorizontal..
   finally
    FreeCanvas;
   end;//try..finally
  end;//not Enabled
 finally
  f_Canvas.EndPaint;
 end;//try..finally
//#UC END# *4F2A461702D8_4F29240F0204_impl*
end;//TvtCustomLabel.DoDrawText
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomLabel.SetBounds(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer);
//#UC START# *4F2A599E0283_4F29240F0204_var*
//#UC END# *4F2A599E0283_4F29240F0204_var*
begin
//#UC START# *4F2A599E0283_4F29240F0204_impl*
 inherited;
 if not f_InAdjustBounds then
  AdjustBounds;
//#UC END# *4F2A599E0283_4F29240F0204_impl*
end;//TvtCustomLabel.SetBounds
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtCustomLabel.ClearFields;
begin
 CCaption := nil;
 inherited;
end;//TvtCustomLabel.ClearFields

//#UC START# *4F29240F0204impl*
//#UC END# *4F29240F0204impl*

procedure TvtStyledLabel.pm_SetStyleId(aValue: Tl3StyleId);
//#UC START# *5703BFB901D4_5703BF610068set_var*
//#UC END# *5703BFB901D4_5703BF610068set_var*
begin
//#UC START# *5703BFB901D4_5703BF610068set_impl*
 if aValue <> f_StyleId then
 begin
  f_StyleId := aValue;
  {$IfNDef DesignTimeLibrary}
  StyleTableChanged;
  {$EndIf DesignTimeLibrary}
 end;//if aValue <> f_StyleId then
//#UC END# *5703BFB901D4_5703BF610068set_impl*
end;//TvtStyledLabel.pm_SetStyleId

{$If NOT Defined(DesignTimeLibrary)}
procedure TvtStyledLabel.StyleTableChanged;
 {* таблица стилей изменилась. }
//#UC START# *467D2CB10135_5703BF610068_var*
//#UC END# *467D2CB10135_5703BF610068_var*
begin
//#UC START# *467D2CB10135_5703BF610068_impl*
 with TevStyleInterface.Make(k2_typTextPara, f_StyleId) do
 try
  Font.Assign2Font(Self.Font);
  Color := Font.BackColor;
 finally
  Free;
 end;//try..finally
//#UC END# *467D2CB10135_5703BF610068_impl*
end;//TvtStyledLabel.StyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvtStyledLabel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5703BF610068_var*
//#UC END# *479731C50290_5703BF610068_var*
begin
//#UC START# *479731C50290_5703BF610068_impl*
 {$IfNDef DesignTimeLibrary}
 evDelStyleTableSpy(Self);
 {$EndIf DesignTimeLibrary}
 inherited;
//#UC END# *479731C50290_5703BF610068_impl*
end;//TvtStyledLabel.Cleanup

constructor TvtStyledLabel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_5703BF610068_var*
//#UC END# *47D1602000C6_5703BF610068_var*
begin
//#UC START# *47D1602000C6_5703BF610068_impl*
 inherited;
 f_StyleId := evd_saGUI;
 {$IfNDef DesignTimeLibrary}
 evAddStyleTableSpy(Self, True);
 {$EndIf DesignTimeLibrary}
//#UC END# *47D1602000C6_5703BF610068_impl*
end;//TvtStyledLabel.Create

//#UC START# *5703BF610068impl*
//#UC END# *5703BF610068impl*

procedure TvtImageLabel.pm_SetImagePosition(aValue: TvtImagePosition);
//#UC START# *570397B90044_57039747002Eset_var*
//#UC END# *570397B90044_57039747002Eset_var*
begin
//#UC START# *570397B90044_57039747002Eset_impl*
 if (f_ImagePosition <> aValue) then
 begin
  f_ImagePosition := aValue;
  Invalidate;
 end;
//#UC END# *570397B90044_57039747002Eset_impl*
end;//TvtImageLabel.pm_SetImagePosition

procedure TvtImageLabel.pm_SetImageIndex(aValue: Integer);
//#UC START# *570397F60218_57039747002Eset_var*
//#UC END# *570397F60218_57039747002Eset_var*
begin
//#UC START# *570397F60218_57039747002Eset_impl*
 if (f_ImageIndex <> aValue) then
 begin
  f_ImageIndex := aValue;
  Invalidate;
 end;
//#UC END# *570397F60218_57039747002Eset_impl*
end;//TvtImageLabel.pm_SetImageIndex

procedure TvtImageLabel.pm_SetImageList(aValue: TCustomImageList);
//#UC START# *5703987900FF_57039747002Eset_var*
//#UC END# *5703987900FF_57039747002Eset_var*
begin
//#UC START# *5703987900FF_57039747002Eset_impl*
 if (aValue <> f_ImageList) then
 begin
  if (f_ImageChangeLink <> nil) and (f_ImageChangeLink.Sender = nil) then
   // - список картинок уже убит - надо его зачистить
   f_ImageList := nil;
  // отрегистрируем
  if Assigned(f_ImageList) then
   f_ImageList.UnRegisterChanges(f_ImageChangeLink);
  // зарегистрируем
  f_ImageList := aValue;
  if Assigned(f_ImageList) then
   f_ImageList.RegisterChanges(f_ImageChangeLink);
  AdjustBounds;
 end;
//#UC END# *5703987900FF_57039747002Eset_impl*
end;//TvtImageLabel.pm_SetImageList

procedure TvtImageLabel.pm_SetImageIndent(aValue: Integer);
//#UC START# *5703994301BB_57039747002Eset_var*
//#UC END# *5703994301BB_57039747002Eset_var*
begin
//#UC START# *5703994301BB_57039747002Eset_impl*
 if (f_ImageIndent <> aValue) then
 begin
  f_ImageIndent := aValue;
  AdjustBounds;
 end;
//#UC END# *5703994301BB_57039747002Eset_impl*
end;//TvtImageLabel.pm_SetImageIndent

procedure TvtImageLabel.OnImageListChange(Sender: TObject);
//#UC START# *570398B70100_57039747002E_var*
//#UC END# *570398B70100_57039747002E_var*
begin
//#UC START# *570398B70100_57039747002E_impl*
 AdjustBounds;
//#UC END# *570398B70100_57039747002E_impl*
end;//TvtImageLabel.OnImageListChange

procedure TvtImageLabel.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57039747002E_var*
//#UC END# *479731C50290_57039747002E_var*
begin
//#UC START# *479731C50290_57039747002E_impl*
 FreeAndNil(f_ImageChangeLink);
 inherited;
//#UC END# *479731C50290_57039747002E_impl*
end;//TvtImageLabel.Cleanup

constructor TvtImageLabel.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_57039747002E_var*
//#UC END# *47D1602000C6_57039747002E_var*
begin
//#UC START# *47D1602000C6_57039747002E_impl*
 inherited;
 f_ImageChangeLink := TChangeLink.Create;
 f_ImageChangeLink.OnChange := OnImageListChange;
 f_ImagePosition := ipRight;
 f_ImageIndex := -1;
 f_ImageIndent := 5;
//#UC END# *47D1602000C6_57039747002E_impl*
end;//TvtImageLabel.Create

{$If NOT Defined(NoVCL)}
procedure TvtImageLabel.AdjustBounds;
//#UC START# *4F2A44BC0297_57039747002E_var*
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
  AAlignment: TAlignment;
//#UC END# *4F2A44BC0297_57039747002E_var*
begin
//#UC START# *4F2A44BC0297_57039747002E_impl*
 if not (csReading in ComponentState) and AutoSize then
  if not f_InAdjustBounds then
  try
   f_InAdjustBounds := true;
   Rect := ClientRect;
   DC := GetDC(0);
   Canvas.Handle := DC;
   if Assigned(f_ImageList) and (f_ImageIndex >= 0) then
    Dec(Rect.Right, f_ImageIndent + f_ImageList.Width);
   DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[WordWrap]);
   if Assigned(f_ImageList) and (f_ImageIndex >= 0) then
    Inc(Rect.Right, f_ImageIndent + f_ImageList.Width);
   Canvas.Handle := 0;
   ReleaseDC(0, DC);
   X := Left;
   AAlignment := Alignment;
   if UseRightToLeftAlignment then
    ChangeBiDiModeAlignment(AAlignment);
   if (AAlignment = taRightJustify) then
    Inc(X, Width - Rect.Right);
   if DrawDirection = ddHorizontal then
   begin
    //http://mdp.garant.ru/pages/viewpage.action?pageId=494529735
    if Align = alClient then
     SetBounds(Left, Top, Width, Height)
    else
     SetBounds(X, Top, Rect.Right, Rect.Bottom);
   end
   else
    SetBounds(X, Top, Rect.Bottom, Rect.Right);
  finally
   f_InAdjustBounds := false;
  end;//try..finally
//#UC END# *4F2A44BC0297_57039747002E_impl*
end;//TvtImageLabel.AdjustBounds
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtImageLabel.DoDrawText(var Rect: TRect;
 Flags: Integer);
//#UC START# *4F2A461702D8_57039747002E_var*
 function GetLogFont(aFont : TFont): TLogFont;
 const
  cPrecision : array[Boolean] of Integer = (OUT_TT_PRECIS, OUT_TT_ONLY_PRECIS);
  cBoolToByte : array[Boolean] of Byte = (0, 1);
  cRotation = 90;
 begin//GetLogFont
  with Result do
  begin
   lfHeight := aFont.Height;
   //if ScaledFont then lfHeight := Trunc(lfHeight * (Screen.PixelsPerInch / 96));
   lfWidth := 0;
   lfEscapement := cRotation * 10;
   lfOrientation := cRotation * 10;

   if fsBold in aFont.Style
    then lfWeight := FW_BOLD
    else lfWeight := FW_NORMAL;
   lfItalic    := cBoolToByte[fsItalic in aFont.Style];
   lfUnderline := cBoolToByte[fsUnderline in aFont.Style];
   lfStrikeout := cBoolToByte[fsStrikeOut in aFont.Style];

   if aFont.CharSet = DEFAULT_CHARSET then
    lfCharSet := ANSI_CHARSET
   else
    lfCharSet := aFont.CharSet;

   lfOutPrecision := cPrecision[cRotation <> 0];
   lfClipPrecision := CLIP_DEFAULT_PRECIS; {Default}
   lfQuality := PROOF_QUALITY;             {Windows gets a better one if available}
   lfPitchAndFamily := VARIABLE_PITCH;     {Default}
   StrPCopy(lfFaceName, aFont.Name);       {Canvas's font name}
  end;//with Result
 end;//GetLogFont

 procedure PrepareCanvas;
 begin//PrepareCanvas
  if (Flags and DT_CALCRECT <> DT_CALCRECT) and
     (DrawDirection <> ddHorizontal) then
   F_Canvas.Canvas.Font.Handle := CreateFontIndirect(GetLogFont(Font));
 end;//PrepareCanvas

 procedure FreeCanvas;
 begin//FreeCanvas
  if (Flags and DT_CALCRECT <> DT_CALCRECT) and
     (DrawDirection <> ddHorizontal) then
   DeleteObject(F_Canvas.Canvas.Font.Handle);
 end;//FreeCanvas

var
 ll3Text: Tl3PCharLen;
 lText: Il3CString;
 l_DC: HDC;
 lRect: TRect;
 l_ImageLeft,
 l_ImageTop: Integer;
//#UC END# *4F2A461702D8_57039747002E_var*
begin
//#UC START# *4F2A461702D8_57039747002E_impl*
 if Transparent then
  f_Canvas.etoFlags := 0
 else
  f_Canvas.etoFlags := eto_Opaque;
 lText := CCaption;
 if (Flags and DT_CALCRECT <> 0) and (l3IsNil(lText) or ShowAccelChar and
   (l3IsChar(lText, 0, '&')) and (l3Len(lText) = 1)) then
  lText := l3Cat(lText, ' ');
 if not ShowAccelChar then
  Flags := Flags or DT_NOPREFIX;
 if f_EndEllipsis then
  Flags := Flags or DT_END_ELLIPSIS;
 Flags := DrawTextBiDiModeFlags(Flags);
 f_Canvas.Font.AssignFont(Font);
 ll3Text := l3PCharLen(lText);
 f_Canvas.BeginPaint;
 try
  f_Canvas.BackColor := Color;
  f_Canvas.DrawEnabled := True;
  if Transparent then
   SetBkMode(f_Canvas.DC, Windows.TRANSPARENT)
  else
  begin
   SetBkColor(f_Canvas.DC, ColorToRGB(f_Canvas.BackColor));
   SetBkMode(f_Canvas.DC, Windows.OPAQUE);
  end;//Transparent

  if not Enabled then
  begin
   OffsetRect(Rect, 1, 1);
   Canvas.Font.Color := clBtnHighlight;
   f_Canvas.DrawText(ll3Text, Rect, Flags);
   OffsetRect(Rect, -1, -1);
   Canvas.Font.Color := clBtnShadow;
   f_Canvas.DrawText(ll3Text, Rect, Flags);
  end//not Enabled
  else
  begin
   l_DC := f_Canvas.DC;
   PrepareCanvas;
   try
    if (DrawDirection <> ddHorizontal) and
       (Flags and DT_CALCRECT <> DT_CALCRECT) then
    begin
     lRect := Rect;
     lRect.Top := lRect.Bottom;
     f_Canvas.DrawText(ll3Text, lRect, Flags or DT_NOCLIP);
    end//DrawDirection <> ddHorizontal
    else
    begin
     if (Flags and DT_CALCRECT <> DT_CALCRECT) then
     begin
      case f_ImagePosition of
       ipLeft:
        begin
         l_ImageLeft := Rect.Left;
         Rect.Left := Rect.Left + f_ImageIndent + f_ImageList.Width;
        end;
       ipRight:
        begin
         l_ImageLeft := Rect.Right - f_ImageList.Width;
         Rect.Right := Rect.Right - f_ImageIndent - f_ImageList.Width;
        end;
      else
       Assert(False);
       l_ImageLeft := 0;
      end;
      case f_VerticalAligment of
       ev_valCenter:
        begin
         Assert(not WordWrap);
         Rect.Top := Rect.Top + (Self.Height - f_Canvas.Canvas.TextHeight('W')) div 2;
        end;//ev_valCenter
       ev_valBottom:
        begin
         Assert(not WordWrap);
         Rect.Top := Rect.Top + (Self.Height - f_Canvas.Canvas.TextHeight('W'));
        end;//ev_valBottom
      end;//case f_VerticalAligment
     end;//Flags and DT_CALCRECT <> DT_CALCRECT
     f_Canvas.DrawText(ll3Text, Rect, Flags);
     if (Flags and DT_CALCRECT = DT_CALCRECT) then
     begin
      if Assigned(f_ImageList) and (f_ImageIndex >= 0) then
      begin
       if (Rect.Bottom - Rect.Top < f_ImageList.Height) then
        Rect.Bottom := Rect.Top + f_ImageList.Height;
      end;
     end else//Flags and DT_CALCRECT = DT_CALCRECT
     begin
      if (Rect.Bottom - Rect.Top < f_ImageList.Height)
       then l_ImageTop := Rect.Top
       else l_ImageTop := (Rect.Top + Rect.Bottom - f_ImageList.Height) div 2;
      f_ImageList.Draw(f_Canvas.Canvas, l_ImageLeft, l_ImageTop, f_ImageIndex);
     end;//Flags and DT_CALCRECT = DT_CALCRECT
    end;//DrawDirection <> ddHorizontal..
   finally
    FreeCanvas;
   end;//try..finally
  end;//not Enabled
 finally
  f_Canvas.EndPaint;
 end;//try..finally
//#UC END# *4F2A461702D8_57039747002E_impl*
end;//TvtImageLabel.DoDrawText
{$IfEnd} // NOT Defined(NoVCL)

//#UC START# *57039747002Eimpl*
//#UC END# *57039747002Eimpl*

//#UC START# *4AE8541A01AEimpl*
//#UC END# *4AE8541A01AEimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomLabelPrim);
 {* Регистрация TvtCustomLabelPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomLabel);
 {* Регистрация TvtCustomLabel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtStyledLabel);
 {* Регистрация TvtStyledLabel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtImageLabel);
 {* Регистрация TvtImageLabel }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtLabel);
 {* Регистрация TvtLabel }
{$IfEnd} // NOT Defined(NoScripts)

end.
