unit vtFocusLabel;

{ Библиотека ""           }
{ Начал: Люлин А.В.       }
{ Модуль: vtFocusLabel -  }
{ Начат: 29.03.2007 20:12 }
{ $Id: vtFocusLabel.pas,v 1.24 2013/05/14 14:37:20 morozov Exp $ }

// $Log: vtFocusLabel.pas,v $
// Revision 1.24  2013/05/14 14:37:20  morozov
// {RequestLink:449678181}
//
// Revision 1.23  2011/01/21 14:19:44  lulin
// {RequestLink:245209881}.
// - граммар наци.
//
// Revision 1.22  2011/01/21 13:13:46  lulin
// - чистка кода.
//
// Revision 1.21  2011/01/21 08:23:09  vkuprovich
// {RequestLink:228688553}
// Mark (квадратик слева от контрола) стал объемным - [$251334989]
//
// Revision 1.20  2011/01/20 16:06:44  vkuprovich
// {RequestLink:228688553}
// Ссылки в диалогах теперь отображают слева от себя квадратик [$251334731]
//
// Revision 1.19  2010/11/15 16:54:28  lulin
// {RequestLink:241010148}.
//
// Revision 1.18  2010/07/21 06:22:20  oman
// - fix: {RequestLink:220595111}
//
// Revision 1.17  2010/05/27 07:36:51  oman
// - fix: {RequestLink:197493364}
//
// Revision 1.16  2010/03/15 11:09:29  oman
// - new: {RequestLink:197493364}
//
// Revision 1.15  2010/01/27 12:14:59  oman
// - new: развлекаемся с метками {RequestLink:182452345}
//
// Revision 1.14  2010/01/14 17:29:06  lulin
// {RequestLink:177538554}.
//
// Revision 1.13  2010/01/13 14:50:04  lulin
// {RequestLink:177538554}.
//
// Revision 1.11  2009/12/30 10:54:43  lulin
// {RequestLink:175966766}.
//
// Revision 1.10  2009/09/03 06:52:41  oman
// - new: Зачистка - {RequestLink:159369920}
//
// Revision 1.9  2009/09/02 11:48:58  lulin
// {RequestLink:159360578}. №20.
//
// Revision 1.8  2009/01/21 15:30:18  lulin
// - боремся со шрифтами.
//
// Revision 1.7  2008/09/02 12:38:16  lulin
// - <K>: 88080895.
//
// Revision 1.6  2008/09/01 14:19:38  lulin
// - <K>: 112722344.
//
// Revision 1.5  2007/08/14 19:31:40  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.4  2007/05/25 11:57:43  oman
// - fix: Фокусирующую рамку рисуем цветом текста (cq25398)
//
// Revision 1.3  2007/04/24 14:39:14  oman
// - fix: Не было возможности настраивать цвета.
//  Готовим контролы для базового поиска (cq25145)
//
// Revision 1.2  2007/03/29 17:27:12  lulin
// - даем компонентам правильные названия.
//
// Revision 1.1  2007/03/29 17:02:36  lulin
// - отделяем мух от котлет.
//

{$Include vtDefine.inc }

interface

uses
  Windows,
  
  Types,
  Messages,
  Classes,
  Graphics,
  Controls,

  l3Interfaces,
  l3Types,
  l3InternalInterfaces,

  afwTextControl
  ;

type
  TvtFocusLabel = class(TafwTextControl)
  private
  // internal fields
    f_Group          : Boolean;
    f_AutoWidth      : Boolean;
    f_Alignment      : TAlignment;
    f_HighlightColor : TColor;
    f_TextColor      : TColor;
    f_Hyperlink      : Boolean;
    f_DrawWithEllipsis: Boolean;
    f_ShowMark       : Boolean;
  private
  // internal methods
    procedure SetAutoWidth(const Value: Boolean);
      {-}
  private
  // property methods
    procedure pm_SetHyperlink(const Value : Boolean);
      {-}
    procedure pm_SetHighlightColor(const aValue: TColor);
      {-}
    procedure pm_SetTextColor(const aValue: TColor);
      {-}
    procedure pm_SetDrawWithEllipsis(aValue: Boolean);
      {-}
    procedure pm_SetShowMark(aValue: Boolean);
      {-}
  private
    function CalculatedTextColor: TColor;
      {-}
    function CalculatedFontStyle(aStyle: TFontStyles): TFontStyles;
      {-}
    function CalcMarkSpace : Integer;
      {VK. - величина отступа для значка слева от текста }
  private
  // messages
    procedure CMTextChanged(var Message: TMessage);
      message CM_TEXTCHANGED;
      {-}
    procedure CMParentFontChanged(var Message: TMessage);
      message CM_PARENTFONTCHANGED;
      {-}
    procedure WMGetDlgCode(var Message: TWMGetDlgCode);
      message WM_GETDLGCODE;
      {-}
    procedure WMEraseBkgnd(var Message : TWMEraseBkgnd);
      message WM_ERASEBKGND;
      {-}
    procedure WMPaint(var Message : TWMPaint);
      message WM_PAINT;
      {-}
    procedure WMNCPaint(var Message : TWMNCPaint);
      message WM_NCPAINT;
      {-}
    procedure CNKeyDown(var Message : TWMKeyDown);
      message CN_KEYDOWN;
      {-}
  protected
  // Методы интерфейса Il3CommandTarget
  protected
  // protected methods
    function CalcWidth: Integer;
      {-}
    function CalcClientRect : TRect;
      {VK. - подсчитывает размеры прямоугольника всей области контрола }
    function CalcTextRect : TRect;
      {* - подсчитывает размеры прямоугольника текстовой области для Caption. }
    procedure ChangeScale(M, D: Integer);
      override;
      {-}
    procedure DoAutoSize;
      //virtual;
      {-}
    procedure Paint(const CN: Il3Canvas);
      override;
      {-}
    procedure WndProc(var Message: TMessage);
      override;
      {-}
    function  IsHandledShortcut(var Msg: TMessage): Boolean;
      {-}
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
      override;
      {-}
    function NeedUnderLine: Boolean;
      virtual;
      {-}
    procedure KeyDown(var Key: Word; Shift: TShiftState);
      override;
      {-}
    function AllowClickByKeyBoard: Boolean;
      virtual;
      {-}
    function AllowTranslateReturn: Boolean;
      virtual;
      {-}
  public
  // public methods
    constructor Create(AOwner: TComponent);
      override;
      {-}
    function FullWidth: Integer;
      {-}
  public
  // public properties
    property DrawWithEllipsis: Boolean
       read f_DrawWithEllipsis
       write pm_SetDrawWithEllipsis;
      {-}
  published
  // published property
    property Caption;
      {-}
    property TabOrder;
      {-}
    property Alignment: TAlignment read f_Alignment write f_Alignment default taLeftJustify;
      {-}
    property AutoWidth: Boolean read f_AutoWidth write SetAutoWidth default True;
      {-}
    property Enabled;
      {-}
    property Font;
      {-}
    property Color;
      {-}
    property Group: Boolean read f_Group write f_Group default False;
      {-}
    property HighlightColor: TColor read f_HighlightColor write pm_SetHighlightColor default clHighlight;
      {-}
    property Hyperlink: Boolean read f_Hyperlink write pm_SetHyperlink;
      {* - цвет шрифта , когда метка находится не в фокусе. }
    property OnClick;
      {* - цвет шрифта, когда метка находится в фокусе. }
    property ShowMark: Boolean read f_ShowMark write pm_SetShowMark default false;
      {VK. - включает/выключает квадратик слева от текста. }
    property TextColor: TColor read f_TextColor write pm_SetTextColor default clBtnText;
  end;//TvtFocusLabel

implementation

uses
  Forms,

  OvcConst,
  OvcBase,
  OvcCmd,

  l3Units,
  l3String,
  l3Base,
  l3Math,

  afwFacade
  ;

{ TvtFocusLabel }

function TvtFocusLabel.CalcMarkSpace : Integer;
begin
 if f_ShowMark then
  Result := Abs(Font.Height)
 else
  Result := 0;
end;

function TvtFocusLabel.CalcClientRect : TRect;
{-}
begin
 Result := CalcTextRect;
 if f_ShowMark then
  Result.Left := 0;
end;

function TvtFocusLabel.CalcTextRect : TRect;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 with Canvas do
 begin
  BeginPaint;
  try
   Font.AssignFont(Self.Font);
   DrawEnabled := True;
   try
    DrawText(l3PCharLen(CCaption), Result, DT_SINGLELINE or DT_CALCRECT);
    Inc(Result.Right, 3);
    // - запас на рамку
    OffsetRect(Result, CalcMarkSpace, 0);
   finally
    DrawEnabled := False;
   end;//try..finally
  finally
   EndPaint;
  end;//try..finally
 end;//with Canvas
end;

function TvtFocusLabel.CalcWidth: Integer;
begin
 Canvas.Font.AssignFont(Font);
 with CalcClientRect do
  Result := Right - Left;
end;

constructor TvtFocusLabel.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 (* inherited *)
 TabStop   := True;
 Height    := 17;
 Width     := 65;
 Visible   := True;
 (* self *)
 f_Alignment      := taLeftJustify;
 f_Group          := False;
 f_AutoWidth      := True;
 f_HighlightColor := clHighlight;
 f_TextColor      := clBtnText;
 f_ShowMark       := False;
end;

procedure TvtFocusLabel.ChangeScale(M, D: Integer);
var
 l_ScalingFlags: TScalingFlags;
begin
 // Иначе шрифт масштабируется дважды
 // http://mdp.garant.ru/pages/viewpage.action?pageId=449678181
 if (sfFont in ScalingFlags) then
 begin
  l_ScalingFlags := ScalingFlags;
  Exclude(l_ScalingFlags, sfFont);
  ScalingFlags := l_ScalingFlags;
 end;
 inherited;
 DoAutoSize;
end;

procedure TvtFocusLabel.DoAutoSize;
var
 lR : TRect;
begin
 if not l3IsNil(CCaption) then
 begin
  lR := CalcTextRect;
  SetBounds(Left, Top, lR.Right + 2, lR.Bottom + 2);
 end;//not l3IsNil(CCaption)
end;

procedure TvtFocusLabel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if TabStop AND not Focused then
  begin
   SetFocus;
   Invalidate;
  end;//TabStop..
end;

procedure TvtFocusLabel.Paint(const CN : Il3Canvas);
// override;
{-}

var
 l_Rect : Tl3SRect;

 procedure lpDrawText;
 const
  arrAlignment: array [TAlignment] of DWORD = (DT_LEFT, DT_RIGHT, DT_CENTER);
  arrEllipsis: array [Boolean] of DWORD = (0, DT_END_ELLIPSIS);
 begin//lpDrawText
  with CN do
  begin
   with Font do
   begin
    Style := CalculatedFontStyle(Style);
    BackColor := Self.Color;
   end;
   DrawText(l3PCharLen(CCaption), l_Rect.R.WR, arrAlignment[f_Alignment] or arrEllipsis[DrawWithEllipsis]);
  end;
 end;//lpDrawText

 procedure lpDrawMark;
 const
  cMarkBorderColor = $00E09070;
  cMarkAreaColor = $00FFB080;
  cMarkBorderInLeftTopColor = $00FFB890;
  cMarkBorderInRightBottomColor = $00F0A070;
 var
  l_MarkRect : Tl3SRect;
  l_MarkSpace : Integer;
 begin//lpDrawMark
  with CN do
  begin
   l_MarkSpace := CalcMarkSpace;
   l_MarkRect.R.WR := Rect(l3MulDiv(l_MarkSpace,2,5),
                           l3MulDiv(l_MarkSpace,2,5),
                           l3MulDiv(l_MarkSpace,4,5),
                           l3MulDiv(l_MarkSpace,4,5));

   Canvas.Brush.Color := cMarkBorderColor;
   FillRect(l_MarkRect);

   InflateRect(l_MarkRect.R.WR, -1, -1);
   Canvas.Brush.Color := cMarkBorderInLeftTopColor;
   FillRect(l_MarkRect);

   Inc(l_MarkRect.R.WR.Left);
   Inc(l_MarkRect.R.WR.Top);
   Canvas.Brush.Color := cMarkBorderInRightBottomColor;
   FillRect(l_MarkRect);

   Dec(l_MarkRect.R.WR.Right);
   Dec(l_MarkRect.R.WR.Bottom);
   Canvas.Brush.Color := cMarkAreaColor;
   FillRect(l_MarkRect);
  end;//with CN
 end;//lpDrawMark

begin
 inherited;
 with CN do
 begin
  l_Rect.R.WR := ClientRect;
  Font.AssignFont(Self.Font);
  (* FillRect *)
  BackColor := Self.Color;
  FillRect(l_Rect);
  (* Focus *)
  if Focused then
  begin
   BackColor := Self.Color;
   Font.ForeColor := clBlack;
   Canvas.Brush.Color := ColorToRGB(clBlack{CalculatedTextColor}) xor ColorToRGB(Self.Color);
   //Canvas.Brush.Color := clBlack{CalculatedTextColor} xor ColorToRGB(BackColor);
   DrawFocusRect(Tl3SRect(l_Rect));
   Font.AssignFont(Self.Font);
   BackColor := Self.Color;
  end;//if Focused then
  Inc(l_Rect.R.Left);

  (* DrawMark *)
  if f_ShowMark then
  begin
   lpDrawMark;
   Canvas.Brush.Color := ColorToRGB(clBlack{CalculatedTextColor}) xor ColorToRGB(Self.Color);
   Inc(l_Rect.R.Left, CalcMarkSpace);
  end;//f_ShowMark

  (* DrawText *)
  if not l3IsNil(CCaption) then
  begin
   InflateRect(l_Rect.R.WR, -1, -1);
   Canvas.Brush.Style := bsClear;
   if not Enabled then
   begin
    OffsetRect(l_Rect.R.WR, 1, 1);
    Font.ForeColor := clBtnHighlight;
    lpDrawText;
    OffsetRect(l_Rect.R.WR, -1, -1);
    Font.ForeColor := clBtnShadow;
    lpDrawText;
   end//if not Enabled then
   else
   begin
    Font.ForeColor := CalculatedTextColor;
    lpDrawText;
   end;//not Enabled
  end;//if not l3IsNil(CCaption) then
 end;//with CN do
end;

procedure TvtFocusLabel.SetAutoWidth(const Value: Boolean);
begin
  f_AutoWidth := Value;
  if Value then
   DoAutoSize;
end;

procedure TvtFocusLabel.CMTextChanged(var Message: TMessage);
  //message CM_TEXTCHANGED;
  {-}
begin
  if not l3IsNil(CCaption) then
   if f_AutoWidth then
    DoAutoSize;
 inherited;
end;

type
  THackedControl = class(TControl);

procedure TvtFocusLabel.CMParentFontChanged(var Message: TMessage);
var
 F: TFont;
begin
 (* При загрузке не нужно реагировать на изменение родительского шрифта,
    потому, что на больших шрифтах происходит двойное увеличение
    (CMParentFontChanged и Scaled) в следствии чего шрифт меток больше чем у
    остальных компонентов *)
 if csLoading in ComponentState then
 begin
  inherited;
  Exit;
 end;//csLoading in ComponentState
 if Message.wParam <> 0 then
  F := TFont(Message.lParam)
 else
  F := THackedControl(Parent).Font;
 if Assigned(F) then
 begin
  Font.Name := F.Name;
  Font.Size := F.Size;
  DoAutoSize;
 end;//Assigned(F)
end;

procedure TvtFocusLabel.WMEraseBkgnd(var Message : TWMEraseBkgnd);
 //message WM_ERASEBKGND;
begin
 Message.Result := LRESULT(False);
end;

procedure TvtFocusLabel.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
 inherited;
 if csDesigning in ComponentState then
  Message.Result := DLGC_STATIC
 else
  Message.Result := Message.Result or DLGC_WANTCHARS or DLGC_WANTARROWS or DLGC_WANTALLKEYS;
end;

procedure TvtFocusLabel.WndProc(var Message: TMessage);
begin
 case Message.Msg of
  WM_SETFOCUS, WM_KILLFOCUS:
   Repaint;
  WM_KEYDOWN, WM_SYSKEYDOWN:
   IsHandledShortcut(Message);
  CM_ENABLEDCHANGED:
   Repaint;
 end;//case Message.Msg
 inherited WndProc(Message);
end;

function TvtFocusLabel.IsHandledShortcut(var Msg: TMessage): Boolean;
var
 l_Controller : TOvcController;
begin
 Result := false;
 l_Controller := Controller;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
   if TranslateUsing([], Msg, GetTickCount) = ccShortCut then
   begin
    Msg.Result := 0;  {indicate that this message was processed}
    Result := true;
   end;//TranslateUsing([], Msg, GetTickCount) = ccShortCut
end;

procedure TvtFocusLabel.WMNCPaint(var Message: TWMNCPaint);
begin
 if not afw.IsObjectLocked(Self) then
  inherited
 else
  Message.Result := 0;
end;

procedure TvtFocusLabel.WMPaint(var Message: TWMPaint);
Var
 DC: HDC;
 PS: tagPaintStruct;
begin
 if not afw.IsObjectLocked(Self) then
  inherited
 else
 begin
  DC := BeginPaint(Handle, PS);
  EndPaint(Handle, PS);
 end;//not afw.IsObjectLocked(Self)
end;

procedure TvtFocusLabel.pm_SetHyperlink(const Value: Boolean);
begin
 f_Hyperlink := Value;
 case Value of
  True:
   if (Cursor <> crHandPoint) then
    Cursor := crHandPoint;
  False: 
   Cursor := crDefault;
 end;//case Value
 Invalidate;
end;

procedure TvtFocusLabel.CNKeyDown(var Message : TWMKeyDown);
var
 l_Controller  : TOvcController;
 l_Translation : Word;

 procedure TranslateKey;
 var
  F : TCustomForm;
 begin//TranslateKey
  F := GetParentForm(Self);
  if (F <> nil) then with TMessage(Message) do
   Result := F.Perform(CM_DialogKey, wParam, lParam);
 end;//TranslateKey

 procedure TranslateReturn;
 begin//TranslateReturn
  Message.Result := -1;
  if not DoKeyDown(Message) then Broadcast(Message);
  if (Message.Result <> 0) then
   TranslateKey;
 end;//TranslateReturn


begin
 l_Controller := Controller;
 if l_Controller <> nil then
  with l_Controller.EntryCommands do
  begin
   l_Translation := TranslateUsing(OvcCmd.ovcTextEditorCommands,
    TMessage(Message), GetTickCount, Il3CommandTarget(Self));
   case l_Translation of
    ccShortCut:
    begin
     Message.CharCode := 0;
     Message.Result := 1;
     exit;
    end;//ccShortCut
   end;//case l_Translation
  end;//with l_Controller.EntryCommands 
 case Message.CharCode of
  vk_Escape, VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN:
   TranslateKey;
  vk_Return:
  begin
   inherited;
   if (Message.Result = 0) and AllowTranslateReturn then
    TranslateReturn;
  end;//vk_Return
 else
  inherited;
 end;//case Message.CharCode
end;

function TvtFocusLabel.CalculatedTextColor: TColor;
begin
 if HyperLink then
  Result := HighlightColor
 else
  Result := TextColor;
end;

function TvtFocusLabel.CalculatedFontStyle(aStyle: TFontStyles): TFontStyles;
begin
 Result := aStyle;
 if NeedUnderLine then
  Include(Result, fsUnderline);
end;

procedure TvtFocusLabel.pm_SetHighlightColor(const aValue: TColor);
begin
 if f_HighlightColor <> aValue then
 begin
  f_HighlightColor := aValue;
  Invalidate;
 end;//f_HighlightColor <> aValue
end;

procedure TvtFocusLabel.pm_SetShowMark(aValue: Boolean);
begin
 if (f_ShowMark <> aValue) then
 begin
  f_ShowMark := aValue;
  Invalidate;
 end;//f_ShowMark <> aValue
end;

procedure TvtFocusLabel.pm_SetTextColor(const aValue: TColor);
begin
 if f_TextColor <> aValue then
 begin
  f_TextColor := aValue;
  Invalidate;
 end;//f_TextColor <> aValue
end;

function TvtFocusLabel.NeedUnderLine: Boolean;
begin
 Result := HyperLink;
end;

procedure TvtFocusLabel.KeyDown(var Key: Word; Shift: TShiftState);
begin
 inherited KeyDown(Key, Shift);
 if Enabled and AllowClickByKeyBoard and Assigned(OnClick) and (Key in [vk_Return, vk_Space]) and (Shift = []) then
 begin
  Key := 0;
  Click;
 end;//Enabled..
end;

function TvtFocusLabel.AllowClickByKeyBoard: Boolean;
begin
 Result := HyperLink;
end;

function TvtFocusLabel.AllowTranslateReturn: Boolean;
begin
 Result := True;
end;

function TvtFocusLabel.FullWidth: Integer;
begin
 Result := CalcWidth;
end;

procedure TvtFocusLabel.pm_SetDrawWithEllipsis(aValue: Boolean);
begin
 if aValue <> DrawWithEllipsis then
 begin
  f_DrawWithEllipsis := aValue;
  Invalidate;
 end;//aValue <> DrawWithEllipsis
end;

end.

