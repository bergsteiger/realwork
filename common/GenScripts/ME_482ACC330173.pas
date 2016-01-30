unit elCustomEdit;

// Модуль: "w:\common\components\gui\Garant\Everest\elCustomEdit.pas"
// Стереотип: "GuiControl"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomEdit
 , nevTools
 , l3Interfaces
 , Classes
 , Messages
 , evEditorWithOperations
 , nevBase
 , l3InternalInterfaces
 , l3Core
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3StringIDEx
;

type
 //#UC START# *482ACC330173ci*
 //#UC END# *482ACC330173ci*
 //#UC START# *482ACC330173cit*
 //#UC END# *482ACC330173cit*
 TelCustomEdit = class(TevCustomEdit, IelEditStrings)
  private
   f_MaxLengthDelta: Integer;
   f_HyperlinkStart: Integer;
   f_HyperlinkFinish: Integer;
   f_SmartOnResize: Boolean;
    {* Поле для свойства SmartOnResize }
   f_PasswordChar: AnsiChar;
    {* Поле для свойства PasswordChar }
   f_EmptyHintColor: Tl3Color;
    {* Поле для свойства EmptyHintColor }
   f_OnChange: TNotifyEvent;
    {* Поле для свойства OnChange }
   f_CEmptyHint: Il3CString;
    {* Поле для свойства CEmptyHint }
   f_CEmptyHintAdding: Il3CString;
    {* Поле для свойства CEmptyHintAdding }
   f_OnEmptyAddingClick: TNotifyEvent;
    {* Поле для свойства OnEmptyAddingClick }
  protected
   FArrowsSelect: Boolean;
   FRestrictOnTextChange: Integer;
  private
   procedure NotifyPosChange;
   procedure WMNCPaint(var Message: TWMNCPaint);
  protected
   function pm_GetSelStart: Integer;
   procedure pm_SetSelStart(aValue: Integer);
   function pm_GetSelLength: Integer;
   procedure pm_SetSelLength(aValue: Integer);
   function pm_GetCaretX: Integer;
   procedure pm_SetCaretX(aValue: Integer);
   procedure pm_SetNoCaret(aValue: Boolean);
   function pm_GetUseSystemMenu: Boolean;
   procedure pm_SetUseSystemMenu(aValue: Boolean);
   function pm_GetMaxLength: Integer;
   procedure pm_SetMaxLength(aValue: Integer);
   function pm_GetEmptyHint: Tl3DString;
   procedure pm_SetEmptyHint(aValue: Tl3DString);
   function pm_GetCText: Il3CString; virtual;
   procedure pm_SetCText(const aValue: Il3CString); virtual;
   function pm_GetParas: IelEditStrings;
   procedure pm_SetCEmptyHintAdding(const aValue: Il3CString);
   procedure Change; virtual;
   procedure DoChange;
   function DeleteSelection(aFakeDelete: Boolean = False): Il3CString;
   procedure TriggerTextChangedEvent(Sender: TObject;
    var aText: Il3CString;
    var Allow: Boolean); virtual;
   procedure UnSelect;
   procedure SetSelText(const aValue: Il3CString);
   procedure CheckDoc;
   procedure TriggerCaretXChangedEvent(var Value: Integer;
    var Allow: Boolean); virtual;
   procedure Set_ParagraphStrings(anIndex: Integer;
    const aValue: Il3CString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ParaChange; override;
    {* текущий параграф изменился. }
   procedure TextChange; override;
    {* вызывается при смене текста. }
   function GetHorzDelta: Integer; override;
    {* зазор, после которого начинается скроллирование вправо. }
   function GetTopMargin: Integer; override;
    {* Возвращает отступ до текста сверху. }
   function DefineProvideOperations: TevEditorProvideOperationTypes; override;
    {* Какие операции публикуются компонентом. }
   function ProcessHotSpots: Boolean; override;
    {* Обрабатывать ли "горячие точки" на предмет показа Hint'а и мышиного курсора или вызывать поведение по-умолчанию. [$100958718] }
   function GetInfoCanvas: InevInfoCanvas; override;
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   procedure DoCursorChanged; override;
   function SelectWhenUnfocused: Boolean; override;
   procedure RecalcScreenCursor(const aPoint: TPoint;
    var theCursor: TCursor); override;
   {$If NOT Defined(NoVCL)}
   procedure MouseUp(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure ClearFields; override;
  public
   procedure SelectAll;
   procedure ClearUndoRedoLists;
   procedure PaintMistakes(const aWords: Il3StringsEx);
  protected
   property SelStart: Integer
    read pm_GetSelStart
    write pm_SetSelStart;
   property SelLength: Integer
    read pm_GetSelLength
    write pm_SetSelLength;
   property CaretX: Integer
    read pm_GetCaretX
    write pm_SetCaretX;
   property NoCaret: Boolean
    write pm_SetNoCaret;
   property SmartOnResize: Boolean
    read f_SmartOnResize
    write f_SmartOnResize;
   property UseSystemMenu: Boolean
    read pm_GetUseSystemMenu
    write pm_SetUseSystemMenu
    default True;
   property PasswordChar: AnsiChar
    read f_PasswordChar
    write f_PasswordChar
    default #0;
   property MaxLength: Integer
    read pm_GetMaxLength
    write pm_SetMaxLength
    default 0;
   property EmptyHint: Tl3DString
    read pm_GetEmptyHint
    write pm_SetEmptyHint;
   property EmptyHintColor: Tl3Color
    read f_EmptyHintColor
    write f_EmptyHintColor;
   property OnChange: TNotifyEvent
    read f_OnChange
    write f_OnChange;
   property Paras: IelEditStrings
    read pm_GetParas;
  public
   property CText: Il3CString
    read pm_GetCText
    write pm_SetCText;
   property CEmptyHint: Il3CString
    read f_CEmptyHint
    write f_CEmptyHint;
   property CEmptyHintAdding: Il3CString
    read f_CEmptyHintAdding
    write pm_SetCEmptyHintAdding;
   property OnEmptyAddingClick: TNotifyEvent
    read f_OnEmptyAddingClick
    write f_OnEmptyAddingClick;
 //#UC START# *482ACC330173publ*
 protected
   property Wrap
     default false;
   property NeedDefaultPopupMenu
     default true;
   property Ctl3D
     default false;    
   property ParentCtl3D
     default false;    
{   property AutoHeightByText
     default true;
     {-}
 //#UC END# *482ACC330173publ*
 end;//TelCustomEdit

implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Const
 , evSearch
 , evdStyles
 , evTypes
 , evdTypes
 , k2Tags
 , l3Units
 , Graphics
 , Windows
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки Locall }
 str_CEmptiHintAddingSeparator: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CEmptiHintAddingSeparator'; rValue : ', например, ');
  {* ', например, ' }

function TelCustomEdit.pm_GetSelStart: Integer;
//#UC START# *482AF615038E_482ACC330173get_var*
//#UC END# *482AF615038E_482ACC330173get_var*
begin
//#UC START# *482AF615038E_482ACC330173get_impl*
 Result := 0;
 Assert(false);
//#UC END# *482AF615038E_482ACC330173get_impl*
end;//TelCustomEdit.pm_GetSelStart

procedure TelCustomEdit.pm_SetSelStart(aValue: Integer);
//#UC START# *482AF615038E_482ACC330173set_var*
//#UC END# *482AF615038E_482ACC330173set_var*
begin
//#UC START# *482AF615038E_482ACC330173set_impl*
 CheckDoc;
 if (Selection <> nil) then
 // - это может случится, когда комбо сохраняет себя в историю при выборе из дерева
  Selection.Start.MostInner.PositionW := aValue;
//#UC END# *482AF615038E_482ACC330173set_impl*
end;//TelCustomEdit.pm_SetSelStart

function TelCustomEdit.pm_GetSelLength: Integer;
//#UC START# *482AF71E02F5_482ACC330173get_var*
//#UC END# *482AF71E02F5_482ACC330173get_var*
begin
//#UC START# *482AF71E02F5_482ACC330173get_impl*
 CheckDoc;
 Result := Selection.Finish.MostInner.Position - Selection.Start.MostInner.Position;
//#UC END# *482AF71E02F5_482ACC330173get_impl*
end;//TelCustomEdit.pm_GetSelLength

procedure TelCustomEdit.pm_SetSelLength(aValue: Integer);
//#UC START# *482AF71E02F5_482ACC330173set_var*
//#UC END# *482AF71E02F5_482ACC330173set_var*
begin
//#UC START# *482AF71E02F5_482ACC330173set_impl*
 CheckDoc;
 if (aValue <= 0) then
  InevSelection(Selection).Unselect
 else
  Selection.Finish.MostInner.PositionW := Selection.Start.MostInner.Position + aValue;
//#UC END# *482AF71E02F5_482ACC330173set_impl*
end;//TelCustomEdit.pm_SetSelLength

function TelCustomEdit.pm_GetCaretX: Integer;
//#UC START# *482AF7FA00E9_482ACC330173get_var*
//#UC END# *482AF7FA00E9_482ACC330173get_var*
begin
//#UC START# *482AF7FA00E9_482ACC330173get_impl*
 CheckDoc;
 Result := Selection.Cursor.MostInner.Position;
//#UC END# *482AF7FA00E9_482ACC330173get_impl*
end;//TelCustomEdit.pm_GetCaretX

procedure TelCustomEdit.pm_SetCaretX(aValue: Integer);
//#UC START# *482AF7FA00E9_482ACC330173set_var*
//#UC END# *482AF7FA00E9_482ACC330173set_var*
begin
//#UC START# *482AF7FA00E9_482ACC330173set_impl*
 CheckDoc;
 Selection.Cursor.MostInner.PositionW := aValue;
//#UC END# *482AF7FA00E9_482ACC330173set_impl*
end;//TelCustomEdit.pm_SetCaretX

procedure TelCustomEdit.pm_SetNoCaret(aValue: Boolean);
//#UC START# *482B015700A6_482ACC330173set_var*
//#UC END# *482B015700A6_482ACC330173set_var*
begin
//#UC START# *482B015700A6_482ACC330173set_impl*
 if Selection <> nil then
  with Selection do
  begin
   Caret.Visible := not aValue;
   NoCaret := aValue;
  end;//with Selection
//#UC END# *482B015700A6_482ACC330173set_impl*
end;//TelCustomEdit.pm_SetNoCaret

function TelCustomEdit.pm_GetUseSystemMenu: Boolean;
//#UC START# *482B05B9011C_482ACC330173get_var*
//#UC END# *482B05B9011C_482ACC330173get_var*
begin
//#UC START# *482B05B9011C_482ACC330173get_impl*
 Result := NeedDefaultPopupMenu;
//#UC END# *482B05B9011C_482ACC330173get_impl*
end;//TelCustomEdit.pm_GetUseSystemMenu

procedure TelCustomEdit.pm_SetUseSystemMenu(aValue: Boolean);
//#UC START# *482B05B9011C_482ACC330173set_var*
//#UC END# *482B05B9011C_482ACC330173set_var*
begin
//#UC START# *482B05B9011C_482ACC330173set_impl*
 NeedDefaultPopupMenu := aValue;
//#UC END# *482B05B9011C_482ACC330173set_impl*
end;//TelCustomEdit.pm_SetUseSystemMenu

function TelCustomEdit.pm_GetMaxLength: Integer;
//#UC START# *482B1CF0026A_482ACC330173get_var*
//#UC END# *482B1CF0026A_482ACC330173get_var*
begin
//#UC START# *482B1CF0026A_482ACC330173get_impl*
 Result := TextSource.DocumentContainer.DocumentLimits.BruttoCharLimit - f_MaxLengthDelta;
//#UC END# *482B1CF0026A_482ACC330173get_impl*
end;//TelCustomEdit.pm_GetMaxLength

procedure TelCustomEdit.pm_SetMaxLength(aValue: Integer);
//#UC START# *482B1CF0026A_482ACC330173set_var*
//#UC END# *482B1CF0026A_482ACC330173set_var*
begin
//#UC START# *482B1CF0026A_482ACC330173set_impl*
 f_MaxLengthDelta := TextSource.DocumentContainer.DocumentInfo.BruttoCharCount - TextLen;
 TextSource.DocumentContainer.DocumentLimits.BruttoCharLimit := aValue + f_MaxLengthDelta;
//#UC END# *482B1CF0026A_482ACC330173set_impl*
end;//TelCustomEdit.pm_SetMaxLength

function TelCustomEdit.pm_GetEmptyHint: Tl3DString;
//#UC START# *482ADD2E035D_482ACC330173get_var*
//#UC END# *482ADD2E035D_482ACC330173get_var*
begin
//#UC START# *482ADD2E035D_482ACC330173get_impl*
 Result := l3DStr(f_CEmptyHint);
//#UC END# *482ADD2E035D_482ACC330173get_impl*
end;//TelCustomEdit.pm_GetEmptyHint

procedure TelCustomEdit.pm_SetEmptyHint(aValue: Tl3DString);
//#UC START# *482ADD2E035D_482ACC330173set_var*
//#UC END# *482ADD2E035D_482ACC330173set_var*
begin
//#UC START# *482ADD2E035D_482ACC330173set_impl*
 f_CEmptyHint := l3CStr(aValue);
//#UC END# *482ADD2E035D_482ACC330173set_impl*
end;//TelCustomEdit.pm_SetEmptyHint

function TelCustomEdit.pm_GetCText: Il3CString;
//#UC START# *482AE6AB00EA_482ACC330173get_var*
//#UC END# *482AE6AB00EA_482ACC330173get_var*
begin
//#UC START# *482AE6AB00EA_482ACC330173get_impl*
 Result := l3CStr(Buffer);
//#UC END# *482AE6AB00EA_482ACC330173get_impl*
end;//TelCustomEdit.pm_GetCText

procedure TelCustomEdit.pm_SetCText(const aValue: Il3CString);
//#UC START# *482AE6AB00EA_482ACC330173set_var*
//#UC END# *482AE6AB00EA_482ACC330173set_var*
begin
//#UC START# *482AE6AB00EA_482ACC330173set_impl*
 Buffer := l3PCharLen(aValue);
//#UC END# *482AE6AB00EA_482ACC330173set_impl*
end;//TelCustomEdit.pm_SetCText

function TelCustomEdit.pm_GetParas: IelEditStrings;
//#UC START# *482AF0C30294_482ACC330173get_var*
//#UC END# *482AF0C30294_482ACC330173get_var*
begin
//#UC START# *482AF0C30294_482ACC330173get_impl*
 Result := Self;
//#UC END# *482AF0C30294_482ACC330173get_impl*
end;//TelCustomEdit.pm_GetParas

procedure TelCustomEdit.pm_SetCEmptyHintAdding(const aValue: Il3CString);
//#UC START# *4E7880C30037_482ACC330173set_var*
//#UC END# *4E7880C30037_482ACC330173set_var*
begin
//#UC START# *4E7880C30037_482ACC330173set_impl*
 f_CEmptyHintAdding := aValue;
 Invalidate;
//#UC END# *4E7880C30037_482ACC330173set_impl*
end;//TelCustomEdit.pm_SetCEmptyHintAdding

procedure TelCustomEdit.Change;
//#UC START# *482AE42802AE_482ACC330173_var*
//#UC END# *482AE42802AE_482ACC330173_var*
begin
//#UC START# *482AE42802AE_482ACC330173_impl*
 DoChange;
//#UC END# *482AE42802AE_482ACC330173_impl*
end;//TelCustomEdit.Change

procedure TelCustomEdit.DoChange;
//#UC START# *482AF57500EE_482ACC330173_var*
//#UC END# *482AF57500EE_482ACC330173_var*
begin
//#UC START# *482AF57500EE_482ACC330173_impl*
 if Assigned(f_OnChange) then
  f_OnChange(Self);
//#UC END# *482AF57500EE_482ACC330173_impl*
end;//TelCustomEdit.DoChange

function TelCustomEdit.DeleteSelection(aFakeDelete: Boolean = False): Il3CString;
//#UC START# *482AF9ED0091_482ACC330173_var*
//#UC END# *482AF9ED0091_482ACC330173_var*
begin
//#UC START# *482AF9ED0091_482ACC330173_impl*
 Result := nil;
 Assert(false);
//#UC END# *482AF9ED0091_482ACC330173_impl*
end;//TelCustomEdit.DeleteSelection

procedure TelCustomEdit.TriggerTextChangedEvent(Sender: TObject;
 var aText: Il3CString;
 var Allow: Boolean);
//#UC START# *482B0717028A_482ACC330173_var*
//#UC END# *482B0717028A_482ACC330173_var*
begin
//#UC START# *482B0717028A_482ACC330173_impl*
 Allow := true;
//#UC END# *482B0717028A_482ACC330173_impl*
end;//TelCustomEdit.TriggerTextChangedEvent

procedure TelCustomEdit.UnSelect;
//#UC START# *482B085701B9_482ACC330173_var*
//#UC END# *482B085701B9_482ACC330173_var*
begin
//#UC START# *482B085701B9_482ACC330173_impl*
 Assert(false);
//#UC END# *482B085701B9_482ACC330173_impl*
end;//TelCustomEdit.UnSelect

procedure TelCustomEdit.SelectAll;
//#UC START# *482B086F037D_482ACC330173_var*
//#UC END# *482B086F037D_482ACC330173_var*
begin
//#UC START# *482B086F037D_482ACC330173_impl*
 Select(ev_stDocument);
//#UC END# *482B086F037D_482ACC330173_impl*
end;//TelCustomEdit.SelectAll

procedure TelCustomEdit.SetSelText(const aValue: Il3CString);
//#UC START# *482B089803E1_482ACC330173_var*
//#UC END# *482B089803E1_482ACC330173_var*
begin
//#UC START# *482B089803E1_482ACC330173_impl*
 Assert(false);
//#UC END# *482B089803E1_482ACC330173_impl*
end;//TelCustomEdit.SetSelText

procedure TelCustomEdit.ClearUndoRedoLists;
//#UC START# *482B099502B9_482ACC330173_var*
//#UC END# *482B099502B9_482ACC330173_var*
begin
//#UC START# *482B099502B9_482ACC330173_impl*
 Processor.UndoBuffer.Clear;
//#UC END# *482B099502B9_482ACC330173_impl*
end;//TelCustomEdit.ClearUndoRedoLists

procedure TelCustomEdit.CheckDoc;
//#UC START# *482B0F1103D7_482ACC330173_var*
//#UC END# *482B0F1103D7_482ACC330173_var*
begin
//#UC START# *482B0F1103D7_482ACC330173_impl*
 TextSource.DocumentContainer; // - создаём документ, если его не было
 {$IfNDef DesignTimeLibrary}
 Assert(TextSource.DocumentContainer.DocumentInfo.TextParaCount <= 1);
 {$EndIf  DesignTimeLibrary}
//#UC END# *482B0F1103D7_482ACC330173_impl*
end;//TelCustomEdit.CheckDoc

procedure TelCustomEdit.TriggerCaretXChangedEvent(var Value: Integer;
 var Allow: Boolean);
//#UC START# *482C0BBD01CF_482ACC330173_var*
//#UC END# *482C0BBD01CF_482ACC330173_var*
begin
//#UC START# *482C0BBD01CF_482ACC330173_impl*
 Allow := true;
//#UC END# *482C0BBD01CF_482ACC330173_impl*
end;//TelCustomEdit.TriggerCaretXChangedEvent

procedure TelCustomEdit.NotifyPosChange;
//#UC START# *482C0DBB00B8_482ACC330173_var*
var
 l_X : Integer;
 l_A : Boolean;
//#UC END# *482C0DBB00B8_482ACC330173_var*
begin
//#UC START# *482C0DBB00B8_482ACC330173_impl*
 l_X := CaretX;
 l_A := true;
 TriggerCaretXChangedEvent(l_X, l_A);
//#UC END# *482C0DBB00B8_482ACC330173_impl*
end;//TelCustomEdit.NotifyPosChange

procedure TelCustomEdit.PaintMistakes(const aWords: Il3StringsEx);
//#UC START# *483445F4032B_482ACC330173_var*
var
 l_Index : Integer;
 l_Layer : Integer;
//#UC END# *483445F4032B_482ACC330173_var*
begin
//#UC START# *483445F4032B_482ACC330173_impl*
 CheckDoc;
 //PlainText := false;
 // - не надо это, иначе шрифт увеличивается - http://mdp.garant.ru/pages/viewpage.action?pageId=119474414
 with Document.AsObject.Child[0].Attr[k2_tiSegments] do
  if IsValid then
  begin
   if rAtomEx([k2_tiChildren, k2_tiHandle, Ord(ev_slMistakes)], @l_Layer).IsValid then
    DeleteChild(l_Layer);
  end;//IsValid
// Временная заточка по насильному переформатированию - как излечиться автоматический вызов Invalidate при удалении
// сегмента надо будет убрать. К-105578765
 Document.Para[0].Invalidate([nev_spSegments]);
 if (aWords <> nil) then
  for l_Index := 0 to Pred(aWords.Count) do
   Find(TevStrictWordSearcher.Make(l3Str(aWords[l_Index])), TevStyleReplacer.MakeForStyleID(ev_saMistake), [ev_soGlobal, ev_soUseInternalCursor, ev_soReplaceAll, ev_soNoProgress]);
 Find(TevStyleSearcher.Make(ev_saMistake, Ord(ev_slMistakes), ev_spSegments), nil, [ev_soGlobal, ev_soNoException, ev_soNoSelection, ev_soNoProgress]);
 // - встаём на первую опечатку  
//#UC END# *483445F4032B_482ACC330173_impl*
end;//TelCustomEdit.PaintMistakes

procedure TelCustomEdit.WMNCPaint(var Message: TWMNCPaint);
//#UC START# *48998C510192_482ACC330173_var*
var
 l_DC: HDC;
 l_Rect: TRect;
 l_Brush: HBrush;
//#UC END# *48998C510192_482ACC330173_var*
begin
//#UC START# *48998C510192_482ACC330173_impl*
 inherited;
 if (BorderStyle = bsSingle) then
 begin
  GetWindowRect(Handle, l_Rect);
  OffsetRect(l_Rect, -l_Rect.Left, -l_Rect.Top);
  l_DC := GetWindowDC(Handle);
  try
   l_Brush := CreateSolidBrush(ColorToRGB(clBtnShadow));
   try
    FrameRect(l_DC, l_Rect, l_Brush);
   finally
    DeleteObject(l_Brush)
   end;//try..finally
  finally
   ReleaseDC(Handle, l_DC);
  end;//try..finally
 end;//BorderStyle = bsSingle
 Message.Result := 0;
//#UC END# *48998C510192_482ACC330173_impl*
end;//TelCustomEdit.WMNCPaint

procedure TelCustomEdit.Set_ParagraphStrings(anIndex: Integer;
 const aValue: Il3CString);
//#UC START# *482AECDA021C_482ACC330173set_var*
var
 l_Op : InevOp;
 l_X  : Integer;
//#UC END# *482AECDA021C_482ACC330173set_var*
begin
//#UC START# *482AECDA021C_482ACC330173set_impl*
 Assert(anIndex = 0);
 l_Op := StartOp;
 try
  l_Op.DisableReadOnly;
  try
   l_X := CaretX;
   try
    if (aValue = nil) then
    begin
     Document.Range.Text.Modify.InsertString(View, l3CStr(''), l_Op, true, [misfDirect]);
     InevSelection(Selection).Unselect;
    end//aValue = nil
    else
    begin
     Document.Range.Text.Modify.InsertString(View, aValue, l_Op, true, [misfDirect]);
     if (MaxLength <= 0) then
      Assert(Text = l3Str(aValue));
//     if (Text <> l3Str(aValue)) then
//      Document.Range.Text.Modify.InsertString(View, aValue, l_Op, true, [misfDirect]);
    end;//aValue = nil
   finally
    CaretX := l_X;
   end;//try..finally
  finally
   l_Op.EnableReadOnly;
  end;//try..finally
 finally
  l_Op := nil; 
 end;//try..finally
//#UC END# *482AECDA021C_482ACC330173set_impl*
end;//TelCustomEdit.Set_ParagraphStrings

procedure TelCustomEdit.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_482ACC330173_var*
//#UC END# *479731C50290_482ACC330173_var*
begin
//#UC START# *479731C50290_482ACC330173_impl*
 f_CEmptyHintAdding := nil;
 f_CEmptyHint := nil;
 inherited;
//#UC END# *479731C50290_482ACC330173_impl*
end;//TelCustomEdit.Cleanup

procedure TelCustomEdit.InitFields;
//#UC START# *47A042E100E2_482ACC330173_var*
//#UC END# *47A042E100E2_482ACC330173_var*
begin
//#UC START# *47A042E100E2_482ACC330173_impl*
 inherited;
 f_HyperlinkStart := -1;
 f_HyperlinkFinish := -1;
 Wrap := false;
 BorderStyle := bsSingle;
 NeedDefaultPopupMenu := true; 
 Ctl3D := false;
 ParentCtl3D := false;
 //AutoHeightByText := true;
 ControlStyle := ControlStyle + [csFixedHeight];
//#UC END# *47A042E100E2_482ACC330173_impl*
end;//TelCustomEdit.InitFields

procedure TelCustomEdit.ParaChange;
 {* текущий параграф изменился. }
//#UC START# *482BFA340236_482ACC330173_var*
//#UC END# *482BFA340236_482ACC330173_var*
begin
//#UC START# *482BFA340236_482ACC330173_impl*
 NotifyPosChange;
 inherited;
//#UC END# *482BFA340236_482ACC330173_impl*
end;//TelCustomEdit.ParaChange

procedure TelCustomEdit.TextChange;
 {* вызывается при смене текста. }
//#UC START# *482C26D6006A_482ACC330173_var*
//#UC END# *482C26D6006A_482ACC330173_var*
begin
//#UC START# *482C26D6006A_482ACC330173_impl*
 if (FRestrictOnTextChange = 0) then
  Change;
 inherited;
//#UC END# *482C26D6006A_482ACC330173_impl*
end;//TelCustomEdit.TextChange

function TelCustomEdit.GetHorzDelta: Integer;
 {* зазор, после которого начинается скроллирование вправо. }
//#UC START# *482C706503AF_482ACC330173_var*
//#UC END# *482C706503AF_482ACC330173_var*
begin
//#UC START# *482C706503AF_482ACC330173_impl*
 Result := {ETAOIN_SHRDLU_l3CrtIC.DP2LP(PointX(RMargin)).X + }l3Epsilon * 6;
//#UC END# *482C706503AF_482ACC330173_impl*
end;//TelCustomEdit.GetHorzDelta

function TelCustomEdit.GetTopMargin: Integer;
 {* Возвращает отступ до текста сверху. }
//#UC START# *483D718E0143_482ACC330173_var*
(*var
 l_DocHeight : Integer;*)
//#UC END# *483D718E0143_482ACC330173_var*
begin
//#UC START# *483D718E0143_482ACC330173_impl*
 Result := inherited GetTopMargin;
(* l_DocHeight := DocumentFullHeight;
 Result := ((Height - l_DocHeight) div 2) - 1;
 if (Result < 0) then
  Result := 0;*)
//#UC END# *483D718E0143_482ACC330173_impl*
end;//TelCustomEdit.GetTopMargin

function TelCustomEdit.DefineProvideOperations: TevEditorProvideOperationTypes;
 {* Какие операции публикуются компонентом. }
//#UC START# *48735C4A03C3_482ACC330173_var*
//#UC END# *48735C4A03C3_482ACC330173_var*
begin
//#UC START# *48735C4A03C3_482ACC330173_impl*
 Result := inherited DefineProvideOperations - [potPrint];
//#UC END# *48735C4A03C3_482ACC330173_impl*
end;//TelCustomEdit.DefineProvideOperations

function TelCustomEdit.ProcessHotSpots: Boolean;
 {* Обрабатывать ли "горячие точки" на предмет показа Hint'а и мышиного курсора или вызывать поведение по-умолчанию. [$100958718] }
//#UC START# *4875FDAD037A_482ACC330173_var*
//#UC END# *4875FDAD037A_482ACC330173_var*
begin
//#UC START# *4875FDAD037A_482ACC330173_impl*
 Result := false;
//#UC END# *4875FDAD037A_482ACC330173_impl*
end;//TelCustomEdit.ProcessHotSpots

function TelCustomEdit.GetInfoCanvas: InevInfoCanvas;
//#UC START# *489845790346_482ACC330173_var*
//#UC END# *489845790346_482ACC330173_var*
begin
//#UC START# *489845790346_482ACC330173_impl*
 Result := inherited GetInfoCanvas;
 if (Result <> nil) then
  Result.PasswordChar := PasswordChar;
//#UC END# *489845790346_482ACC330173_impl*
end;//TelCustomEdit.GetInfoCanvas

procedure TelCustomEdit.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_482ACC330173_var*
var
 l_H : Il3CString;
 l_Delta : Integer;
 l_X     : Integer;
 l_E     : Tl3SPoint;
 l_Rect  : TRect;
 l_State,
 l_NeedEllipsis : Boolean;
//#UC END# *48C6C044025E_482ACC330173_var*
begin
//#UC START# *48C6C044025E_482ACC330173_impl*
(* l_Delta := GetTopMargin;
 if (l_Delta > 0) then
  CN.MoveWindowOrg(l3SPoint(0, -l_Delta));*)
 // - это уже делается в TevCustomEdit.Paint
 CN.PasswordChar := PasswordChar;
 inherited;
 f_HyperlinkStart := -1;
 f_HyperlinkFinish := -1;
 l_H := CEmptyHint;
 if not l3IsNil(l_H) AND
    (TextSource.DocumentContainer.DocumentInfo.NettoCharCount <= 0) then
 begin
  if (Selection <> nil) then
   l_State := Selection.Caret.Hidden
  else
   l_State := False;
  try
   if (Selection <> nil) then
    Selection.Caret.Hidden := true;

   CN.DrawEnabled := true;
   CN.Font.ForeColor := EmptyHintColor;
   l_Delta := (Height - CN.LP2DP(CN.TextExtent(l_H.AsWStr)).Y) div 2;
   with Document do
    if (AsObject.ChildrenCount > 0) then
     l_X := CN.LP2DP(l3PointX(AsObject.Child[0].IntA[k2_tiFirstIndent])).X
    else
     l_X := 0;
   CN.WindowOrg := l3Point0;
   l_E := CN.LP2DP(CN.StringOut(CN.DP2LP(l3SPoint(l_X, l_Delta)), l_H.AsWStr));
   if not l3IsNil(f_CEmptyHintAdding) then
   begin
    l_E.X := l_E.X + CN.LP2DP(CN.StringOut(CN.DP2LP(l3SPoint(l_E.X + l_X, l_Delta)), str_CEmptiHintAddingSeparator.AsWStr)).X;
    CN.Font.Underline := true;
    f_HyperlinkStart := l_E.X + l_X;
    l_Rect := Rect(l_E.X + l_X, l_Delta, Width - l_Delta, Height - l_Delta);

    CN.DrawText(Tl3PCharLenPrim(f_CEmptyHintAdding.AsWStr),
                l_Rect,
                DT_CALCRECT);

    l_NeedEllipsis := l_Rect.Right > Width - l_Delta;
    if l_NeedEllipsis then
    begin
     l_Rect.Right := Width - l_Delta;

     CN.DrawText(Tl3PCharLenPrim(f_CEmptyHintAdding.AsWStr),
                 l_Rect,
                 DT_END_ELLIPSIS);
    end else
     CN.DrawText(Tl3PCharLenPrim(f_CEmptyHintAdding.AsWStr),
                 l_Rect,
                 0);

    f_HyperlinkFinish := l_Rect.Right;
   end;//not l3IsNil(f_CEmptyHintAdding)
  finally
   if (Selection <> nil) then
    Selection.Caret.Hidden := l_State;
  end;
 end;//not l3IsNil(l_H)
//#UC END# *48C6C044025E_482ACC330173_impl*
end;//TelCustomEdit.Paint

procedure TelCustomEdit.DoCursorChanged;
//#UC START# *48E1F1B1033C_482ACC330173_var*
//#UC END# *48E1F1B1033C_482ACC330173_var*
begin
//#UC START# *48E1F1B1033C_482ACC330173_impl*
 NotifyPosChange;
 inherited;
//#UC END# *48E1F1B1033C_482ACC330173_impl*
end;//TelCustomEdit.DoCursorChanged

function TelCustomEdit.SelectWhenUnfocused: Boolean;
//#UC START# *48E22AD302CE_482ACC330173_var*
//#UC END# *48E22AD302CE_482ACC330173_var*
begin
//#UC START# *48E22AD302CE_482ACC330173_impl*
 Result := false;
//#UC END# *48E22AD302CE_482ACC330173_impl*
end;//TelCustomEdit.SelectWhenUnfocused

procedure TelCustomEdit.RecalcScreenCursor(const aPoint: TPoint;
 var theCursor: TCursor);
//#UC START# *4E788DB902F9_482ACC330173_var*
//#UC END# *4E788DB902F9_482ACC330173_var*
begin
//#UC START# *4E788DB902F9_482ACC330173_impl*
 inherited;
 if not l3IsNil(f_CEmptyHintAdding) then
  if (aPoint.X >= f_HyperlinkStart) AND
     (aPoint.X <= f_HyperlinkFinish) then
   theCursor := crHandPoint;
//#UC END# *4E788DB902F9_482ACC330173_impl*
end;//TelCustomEdit.RecalcScreenCursor

{$If NOT Defined(NoVCL)}
procedure TelCustomEdit.MouseUp(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4E7896270076_482ACC330173_var*
//#UC END# *4E7896270076_482ACC330173_var*
begin
//#UC START# *4E7896270076_482ACC330173_impl*
 if (Button = mbLeft) then
  if Assigned(f_OnEmptyAddingClick) then
   if not l3IsNil(f_CEmptyHintAdding) then
    if (X >= f_HyperlinkStart) AND
       (X <= f_HyperlinkFinish) then
     f_OnEmptyAddingClick(Self);
 inherited;
//#UC END# *4E7896270076_482ACC330173_impl*
end;//TelCustomEdit.MouseUp
{$IfEnd} // NOT Defined(NoVCL)

procedure TelCustomEdit.ClearFields;
begin
 CEmptyHint := nil;
 CEmptyHintAdding := nil;
 inherited;
end;//TelCustomEdit.ClearFields

//#UC START# *482ACC330173impl*
//#UC END# *482ACC330173impl*

initialization
 str_CEmptiHintAddingSeparator.Init;
 {* Инициализация str_CEmptiHintAddingSeparator }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TelCustomEdit);
 {* Регистрация TelCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)

end.
