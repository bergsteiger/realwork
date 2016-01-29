unit vtLabel;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/vtLabel.pas"
// Начат: 03.02.2012
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::Labels::TvtLabel
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3Interfaces,
  afwInterfaces,
  evdTypes,
  Messages
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  l3GraphicControlCanvas,
  l3PureMixIns,
  Classes,
  Types
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
 // private fields
   f_Canvas : Tl3GraphicControlCanvas;
   f_InAdjustBounds : Boolean;
   f_EndEllipsis : Boolean;
    {* Поле для свойства EndEllipsis}
   f_CCaption : Il3CString;
    {* Поле для свойства CCaption}
   f_VerticalAligment : TevVerticalAligment;
    {* Поле для свойства VerticalAligment}
   f_DrawDirection : TvtDrawDirection;
    {* Поле для свойства DrawDirection}
   f_Caption : Tl3DString;
    {* Поле для свойства Caption}
 private
 // private methods
   procedure WMGetText(var Msg: TMessage); message WM_GetText;
   procedure WMGetTextLength(var Msg: TMessage); message WM_GetTextLength;
   procedure WMSetText(var Msg: TMessage); message WM_SetText;
 protected
 // property methods
   procedure pm_SetEndEllipsis(aValue: Boolean);
   procedure pm_SetDrawDirection(aValue: TvtDrawDirection);
   function pm_GetCaption: Tl3DString; virtual;
   procedure pm_SetCaption(aValue: Tl3DString); virtual;
 protected
 // realized methods
   function pm_GetCCaption: IafwCString;
   procedure pm_SetCCaption(const aValue: IafwCString);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCL)}
   procedure AdjustBounds; override;
   {$IfEnd} //not NoVCL
   {$If defined(l3HackedVCL) AND not defined(NoVCL)}
   function GetLabelText: AnsiString; override;
   {$IfEnd} //l3HackedVCL AND not NoVCL
   {$If not defined(NoVCL)}
   procedure DoDrawText(var Rect: TRect;
    Flags: Integer); override;
   {$IfEnd} //not NoVCL
   {$If not defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
   {$IfEnd} //not NoVCL
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   {$If defined(DesignTimeLibrary)}
   function CheckStamp(const aGUID: TGUID): Boolean;
   {$IfEnd} //DesignTimeLibrary
   function CaptionStored: Boolean;
     {* "Функция определяющая, что свойство Caption сохраняется" }
 public
 // public properties
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
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked,
  l3String,
  afwVCL,
  Graphics,
  l3Types,
  l3MinMax
  ;

type
  THackLink = class(TControlActionLink)
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
// start class TvtCustomLabel

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

{$If defined(DesignTimeLibrary)}
function TvtCustomLabel.CheckStamp(const aGUID: TGUID): Boolean;
//#UC START# *4F293EBE00D9_4F29240F0204_var*
//#UC END# *4F293EBE00D9_4F29240F0204_var*
begin
//#UC START# *4F293EBE00D9_4F29240F0204_impl*
 Result := false;
//#UC END# *4F293EBE00D9_4F29240F0204_impl*
end;//TvtCustomLabel.CheckStamp
{$IfEnd} //DesignTimeLibrary

function TvtCustomLabel.CaptionStored: Boolean;
//#UC START# *6B1BE297C357_4F29240F0204_var*
//#UC END# *6B1BE297C357_4F29240F0204_var*
begin
//#UC START# *6B1BE297C357_4F29240F0204_impl*
 Result := not l3IsNil(CCaption) AND
           ((ActionLink = nil) or not THackLink(ActionLink).IsCaptionLinked);
//#UC END# *6B1BE297C357_4F29240F0204_impl*
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

{$If not defined(NoVCL)}
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
{$IfEnd} //not NoVCL

{$If defined(l3HackedVCL) AND not defined(NoVCL)}
function TvtCustomLabel.GetLabelText: AnsiString;
//#UC START# *4F2A45C40091_4F29240F0204_var*
//#UC END# *4F2A45C40091_4F29240F0204_var*
begin
//#UC START# *4F2A45C40091_4F29240F0204_impl*
 Result := l3Str(CCaption);
//#UC END# *4F2A45C40091_4F29240F0204_impl*
end;//TvtCustomLabel.GetLabelText
{$IfEnd} //l3HackedVCL AND not NoVCL

{$If not defined(NoVCL)}
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

   if fsBold in aFont.Style then lfWeight := FW_BOLD else lfWeight := FW_NORMAL;
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
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
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
{$IfEnd} //not NoVCL

procedure TvtCustomLabel.ClearFields;
 {-}
begin
 CCaption := nil;
 inherited;
end;//TvtCustomLabel.ClearFields

//#UC START# *4F29240F0204impl*
//#UC END# *4F29240F0204impl*

//#UC START# *4AE8541A01AEimpl*
//#UC END# *4AE8541A01AEimpl*

initialization
{$If not defined(NoScripts)}
// Регистрация TvtCustomLabelPrim
 TtfwClassRef.Register(TvtCustomLabelPrim);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TvtCustomLabel
 TtfwClassRef.Register(TvtCustomLabel);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация TvtLabel
 TtfwClassRef.Register(TvtLabel);
{$IfEnd} //not NoScripts

end.