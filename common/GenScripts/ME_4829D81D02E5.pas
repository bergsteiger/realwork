unit evCustomMemo;
 {* Мемо-поле. }

// Модуль: "w:\common\components\gui\Garant\Everest\evCustomMemo.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evEditorWithOperations
 , l3Interfaces
 , l3Memory
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Core
 , Messages
 , nevBase
 , evCustomEditorModelPart
 , Classes
 , evCustomTextSource
 , l3InternalInterfaces
 , evDef
 , evCustomMemoTextSource
;

const
 def_MemoLMargin = 8;
 def_MemoScrollStyle = evDef.def_MemoScrollStyle;

type
 RevCustomMemoTextSource = class of TevCustomMemoTextSource;

 //#UC START# *4829D81D02E5ci*
 //#UC END# *4829D81D02E5ci*
 //#UC START# *4829D81D02E5cit*
 //#UC END# *4829D81D02E5cit*
 TevCustomMemo = class(TevEditorWithOperations)
  {* Мемо-поле. }
  private
   f_Buf: Tl3MemoryPool;
   f_PlainText: Boolean;
   f_NeedDefaultPopupMenu: Boolean;
    {* Поле для свойства NeedDefaultPopupMenu }
   f_KeepAllFormatting: Boolean;
    {* Поле для свойства KeepAllFormatting }
   f_NeedReplaceQuotes: Boolean;
    {* Поле для свойства NeedReplaceQuotes }
  private
   procedure WMGetText(var Msg: TMessage); message WM_GetText;
   procedure WMGetTextLength(var Msg: TMessage); message WM_GetTextLength;
   procedure WMSetText(var Msg: TMessage); message WM_SetText;
   procedure CMFONTCHANGED(var Msg: TMessage); message CM_FONTCHANGED;
   procedure WMKeyDown(var Msg: TWMKeyDown); message CN_KEYDOWN;
   procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
   procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
   procedure pm_SetNeedDefaultPopupMenu(aValue: Boolean);
   function pm_GetTextLen: Integer;
   function pm_GetBuffer: Tl3WString;
   procedure pm_SetBuffer(const aValue: Tl3WString);
   function pm_GetWrap: Boolean;
   procedure pm_SetWrap(aValue: Boolean);
   function TextSourceClass: RevCustomMemoTextSource; virtual;
   procedure Validate; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure MakeTextSource(out theTextSource: TevCustomTextSource); override;
   function AllowDrawDocumentEdge: Boolean; override;
   function RightIndentMul: Integer; override;
   function WantEnter: Boolean; override;
   function WantTab(aKeyPressed: Boolean = False): Boolean; override;
   procedure TextChange; override;
    {* вызывается при смене текста. }
   procedure SetTextColor(const aCanvas: Il3Canvas); override;
   function pm_GetPlainText: Boolean; override;
   procedure pm_SetPlainText(aValue: Boolean); override;
   procedure Loaded; override;
   function SelectWhenUnfocused: Boolean; override;
   function pm_GetAllowParaType: TevAllowParaTypes; override;
   function AllowAutoSelectByMouse: Boolean; override;
  public
   function UseMemoFontForParagraphs: Boolean; virtual;
   function KeepParaFormattingTag(aTag: Integer): Boolean; virtual;
    {* Сохранять ли элемент оформления }
   constructor Create(AOwner: TComponent); override;
   function MakeExportFilters(aSelection: Boolean;
    aForExport: Boolean): InevTagGenerator; override;
  public
   property NeedDefaultPopupMenu: Boolean
    read f_NeedDefaultPopupMenu
    write pm_SetNeedDefaultPopupMenu
    default True;
   property KeepAllFormatting: Boolean
    read f_KeepAllFormatting
    write f_KeepAllFormatting
    default False;
   property TextLen: Integer
    read pm_GetTextLen;
    {* размер текста. }
   property Buffer: Tl3WString
    read pm_GetBuffer
    write pm_SetBuffer;
    {* текст мемо-поля. }
   property Wrap: Boolean
    read pm_GetWrap
    write pm_SetWrap
    default True;
    {* переносить ли слова по размеру мемо-поля. }
   property NeedReplaceQuotes: Boolean
    read f_NeedReplaceQuotes
    write f_NeedReplaceQuotes
    default True;
 //#UC START# *4829D81D02E5publ*
 public
 // public properties
      property Font;
        {-}
      property AutoSelect
        default true;
        {-}
      property PlainText
        default true;
        {-}
      property LMargin
        default def_MemoLMargin;
        {-}
 //#UC END# *4829D81D02E5publ*
 end;//TevCustomMemo

implementation

uses
 l3ImplUses
 , l3MinMax
 , l3Chars
 , l3String
 , evdInterfaces
 , l3Types
 , evMemoContextMenu
 , SysUtils
 , Graphics
 , nevTools
 , k2Tags
 , k2Facade
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , evExcept
 , Font_Const
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TevCustomMemo.pm_SetNeedDefaultPopupMenu(aValue: Boolean);
//#UC START# *484517360371_4829D81D02E5set_var*
//#UC END# *484517360371_4829D81D02E5set_var*
begin
//#UC START# *484517360371_4829D81D02E5set_impl*
 if (f_NeedDefaultPopupMenu <> aValue) then
 begin
  f_NeedDefaultPopupMenu := aValue;
  if aValue then
   PopupMenu := MemoContextMenu
  else
   PopupMenu := nil;
 end;//f_NeedDefaultPopupMenu <> aValue
//#UC END# *484517360371_4829D81D02E5set_impl*
end;//TevCustomMemo.pm_SetNeedDefaultPopupMenu

function TevCustomMemo.pm_GetTextLen: Integer;
//#UC START# *484517BD02FF_4829D81D02E5get_var*
//#UC END# *484517BD02FF_4829D81D02E5get_var*
begin
//#UC START# *484517BD02FF_4829D81D02E5get_impl*
 if (f_TextSource = nil) OR not f_TextSource.HasDocument then
  Result := 0
 else
  Result := Max(0, TextSource.DocumentContainer.DocumentInfo.BruttoCharCount - cc_EOL_Len);
//#UC END# *484517BD02FF_4829D81D02E5get_impl*
end;//TevCustomMemo.pm_GetTextLen

function TevCustomMemo.pm_GetBuffer: Tl3WString;
//#UC START# *484517DD032E_4829D81D02E5get_var*
var
 l_Len      : Integer;
 l_Format   : Tl3ClipboardFormat;
 l_CodePage : Integer;
//#UC END# *484517DD032E_4829D81D02E5get_var*
begin
//#UC START# *484517DD032E_4829D81D02E5get_impl*
 if (f_TextSource = nil) OR not f_TextSource.HasDocument then
  l3AssignNil(Result)
 else
 begin
  if (f_Buf = nil) then
   f_Buf := Tl3MemoryPool.Create;
  l_CodePage := TextCodePage;
  Case l_CodePage of
   CP_Unicode :
    l_Format := cf_UnicodeText;
   else
    l_Format := cf_Text;
  end;//Case l_CPA.CodePage
  l_Len := TextSource.DocumentContainer.TagReader.
   ReadTag(l_Format, f_Buf As IStream, MakeExportFilters(false, false), nil,
           evd_DefaultStoreFlags + [evd_sfInternal] + [evd_sfStoreParaEnd],
            l_CodePage);
  if (l_CodePage = CP_Unicode) then
   l_Len := l_Len div SizeOf(WideChar);
  Tl3PCharLen(Result).Init(f_Buf.AsPointer, l_Len, l_CodePage);
 end;//f_TextSource = nil..
//#UC END# *484517DD032E_4829D81D02E5get_impl*
end;//TevCustomMemo.pm_GetBuffer

procedure TevCustomMemo.pm_SetBuffer(const aValue: Tl3WString);
//#UC START# *484517DD032E_4829D81D02E5set_var*
var
 l_Op : InevOp;
//#UC END# *484517DD032E_4829D81D02E5set_var*
begin
//#UC START# *484517DD032E_4829D81D02E5set_impl*
 l_Op := StartOp;
 try
  l_Op.DisableReadonly;
  try
   with TextSource do
   begin
    InsertBuf(View, aValue);
    Modified := false;
    MakeCursor;
    Invalidate;
   end;//with TextSource
  finally
   l_Op.EnableReadonly;
  end;//try..finally
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *484517DD032E_4829D81D02E5set_impl*
end;//TevCustomMemo.pm_SetBuffer

function TevCustomMemo.pm_GetWrap: Boolean;
//#UC START# *484518050194_4829D81D02E5get_var*
//#UC END# *484518050194_4829D81D02E5get_var*
begin
//#UC START# *484518050194_4829D81D02E5get_impl*
 Result := WebStyle;
//#UC END# *484518050194_4829D81D02E5get_impl*
end;//TevCustomMemo.pm_GetWrap

procedure TevCustomMemo.pm_SetWrap(aValue: Boolean);
//#UC START# *484518050194_4829D81D02E5set_var*
//#UC END# *484518050194_4829D81D02E5set_var*
begin
//#UC START# *484518050194_4829D81D02E5set_impl*
 WebStyle := aValue;
//#UC END# *484518050194_4829D81D02E5set_impl*
end;//TevCustomMemo.pm_SetWrap

function TevCustomMemo.UseMemoFontForParagraphs: Boolean;
//#UC START# *4D6B97CB00AA_4829D81D02E5_var*
//#UC END# *4D6B97CB00AA_4829D81D02E5_var*
begin
//#UC START# *4D6B97CB00AA_4829D81D02E5_impl*
 Result := PlainText;
//#UC END# *4D6B97CB00AA_4829D81D02E5_impl*
end;//TevCustomMemo.UseMemoFontForParagraphs

function TevCustomMemo.TextSourceClass: RevCustomMemoTextSource;
//#UC START# *482D9D1701E0_4829D81D02E5_var*
//#UC END# *482D9D1701E0_4829D81D02E5_var*
begin
//#UC START# *482D9D1701E0_4829D81D02E5_impl*
 Result := TevCustomMemoTextSource;
//#UC END# *482D9D1701E0_4829D81D02E5_impl*
end;//TevCustomMemo.TextSourceClass

procedure TevCustomMemo.WMGetText(var Msg: TMessage);
//#UC START# *484524F103B7_4829D81D02E5_var*
var
 S : Tl3ConstMemoryStream;
//#UC END# *484524F103B7_4829D81D02E5_var*
begin
//#UC START# *484524F103B7_4829D81D02E5_impl*
 if (PChar(Msg.lParam) = nil) OR (Msg.wParam = 0) then
  Msg.Result := 0
 else 
 if (f_TextSource = nil) OR not f_TextSource.HasDocument then
 begin
  Msg.Result := 0;
  PChar(Msg.lParam)^ := #0;
 end//f_TextSource = nil..
 else
 begin
  S := Tl3ConstMemoryStream.Create(PAnsiChar(Msg.lParam), Msg.wParam{$IfDef XE} * SizeOf(WideChar){$EndIf});
  try
   try
    Msg.Result := TextSource.DocumentContainer.
                   TagReader.ReadTag({$IfDef XE}cf_UnicodeText{$Else}cf_Text{$EndIf}, S,
                                     MakeExportFilters(false, false),
                                     nil,
                                     evd_DefaultStoreFlags + [evd_sfInternal]);
   except
    on EWriteError do ;
    // - попытались записать больше, чем подали буфер, ну и бог с ним
    // http://mdp.garant.ru/pages/viewpage.action?pageId=204114253
   end;//try..except
  finally
   FreeAndNil(S);
  end;//try..finally
 end;//f_TextSource = nil
//#UC END# *484524F103B7_4829D81D02E5_impl*
end;//TevCustomMemo.WMGetText

procedure TevCustomMemo.WMGetTextLength(var Msg: TMessage);
//#UC START# *4845250E02BE_4829D81D02E5_var*
//#UC END# *4845250E02BE_4829D81D02E5_var*
begin
//#UC START# *4845250E02BE_4829D81D02E5_impl*
 Msg.Result := TextLen;
//#UC END# *4845250E02BE_4829D81D02E5_impl*
end;//TevCustomMemo.WMGetTextLength

procedure TevCustomMemo.WMSetText(var Msg: TMessage);
//#UC START# *484525250384_4829D81D02E5_var*
//#UC END# *484525250384_4829D81D02E5_var*
begin
//#UC START# *484525250384_4829D81D02E5_impl*
 if (Msg.lParam <> 0) then
 begin
  Msg.Result := Ord(true);
  Buffer := l3PCharLen(PChar(Msg.lParam));
 end//Msg.lParam <> 0
 else
  Msg.Result := Ord(false);
//#UC END# *484525250384_4829D81D02E5_impl*
end;//TevCustomMemo.WMSetText

procedure TevCustomMemo.CMFONTCHANGED(var Msg: TMessage);
//#UC START# *484525330040_4829D81D02E5_var*
var
 OM : Boolean;
 D  : InevParaList;
//#UC END# *484525330040_4829D81D02E5_var*
begin
//#UC START# *484525330040_4829D81D02E5_impl*
 inherited;
 if UseMemoFontForParagraphs then
 begin
  // - это можно убрать - когда будет честная прозрачность компонент шрифта
  D := Document;
  if D.AsObject.IsValid then
  begin
   OM := TextSource.Modified;
   try
    D.Range.Formatting.Modify(View).SetAtom(View, k2_tiFont, k2_typFont.ObjToTag(Font).AsObject, nil);
   finally
    TextSource.Modified := OM;
   end;//try..finally
  end;//D.IsValid
 end;//UseMemoFontForParagraphs
//#UC END# *484525330040_4829D81D02E5_impl*
end;//TevCustomMemo.CMFONTCHANGED

procedure TevCustomMemo.WMKeyDown(var Msg: TWMKeyDown);
//#UC START# *484525510319_4829D81D02E5_var*

 procedure TranslateKey;
 var
  F : TCustomForm;
 begin//TranslateKey
  F := GetParentForm(Self);
  if (F <> nil) then
   with TMessage(Msg) do
    Result := F.Perform(CM_DialogKey, wParam, lParam);
 end;//TranslateKey

 procedure TranslateReturn;
 begin//TranslateReturn
  Msg.Result := -1;
  if not DoKeyDown(Msg) then
   Broadcast(Msg);
  if (Msg.Result <> 0) then
   TranslateKey;
 end;//TranslateReturn

//#UC END# *484525510319_4829D81D02E5_var*
begin
//#UC START# *484525510319_4829D81D02E5_impl*
  try
   Case Msg.CharCode of
    vk_Escape:
    begin
     // Следующие две строчи, это чтобы ShortCut обработать:
     inherited;
     if (Msg.Result = 0) then
      TranslateKey;
    end;//vk_Escape
    vk_Return:
    begin
(*      if not WantEnter then
     // - чтобы лишний раз не сваливаться в безнадёжную вставку параграфа
      TranslateReturn
     else*)
     // - это нельзя делать, т.к. ShortCut'ы отваливаются
     begin
      inherited;
      if (Msg.Result = 0) then
       TranslateReturn;
     end;//TranslateReturn
    end;//vk_Return
    else
     inherited;
   end;//Case Msg.CharCode
  except
   on EevLimitReached do TranslateReturn;
  end;//try..except
//#UC END# *484525510319_4829D81D02E5_impl*
end;//TevCustomMemo.WMKeyDown

procedure TevCustomMemo.Validate;
//#UC START# *4860F5DF026F_4829D81D02E5_var*
//#UC END# *4860F5DF026F_4829D81D02E5_var*
begin
//#UC START# *4860F5DF026F_4829D81D02E5_impl*
 // - ничего не делаем
//#UC END# *4860F5DF026F_4829D81D02E5_impl*
end;//TevCustomMemo.Validate

function TevCustomMemo.KeepParaFormattingTag(aTag: Integer): Boolean;
 {* Сохранять ли элемент оформления }
//#UC START# *4A8A6D4701CC_4829D81D02E5_var*
//#UC END# *4A8A6D4701CC_4829D81D02E5_var*
begin
//#UC START# *4A8A6D4701CC_4829D81D02E5_impl*
 Case aTag of
  k2_tiStyle,
  k2_tiSpaceBefore,
  k2_tiSpaceAfter,
  k2_tiJustification,
  k2_tiFirstIndent,
  k2_tiFont,
  k2_tiSegments:
   Result := KeepAllFormatting;
  k2_tiLeftIndent,
  k2_tiRightIndent:
   Result := false;
  else
  begin
   Result := true;
   Assert(false);
  end;//else
 end;//Case aTag
//#UC END# *4A8A6D4701CC_4829D81D02E5_impl*
end;//TevCustomMemo.KeepParaFormattingTag

procedure TevCustomMemo.CMEnter(var Message: TCMEnter);
//#UC START# *4C35BF1F02D2_4829D81D02E5_var*
//#UC END# *4C35BF1F02D2_4829D81D02E5_var*
begin
//#UC START# *4C35BF1F02D2_4829D81D02E5_impl*
(* if AutoSelect then
  if (Selection <> nil) then
   InevSelection(Selection).Unselect;*)
 inherited;
//#UC END# *4C35BF1F02D2_4829D81D02E5_impl*
end;//TevCustomMemo.CMEnter

procedure TevCustomMemo.CMExit(var Message: TCMExit);
//#UC START# *4C35C19200EC_4829D81D02E5_var*
//#UC END# *4C35C19200EC_4829D81D02E5_var*
begin
//#UC START# *4C35C19200EC_4829D81D02E5_impl*
 if AutoSelect then
  if (Selection <> nil) then
   InevSelection(Selection).Unselect;
 inherited;
//#UC END# *4C35C19200EC_4829D81D02E5_impl*
end;//TevCustomMemo.CMExit

procedure TevCustomMemo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4829D81D02E5_var*
//#UC END# *479731C50290_4829D81D02E5_var*
begin
//#UC START# *479731C50290_4829D81D02E5_impl*
 FreeAndNil(f_Buf);
 inherited;
//#UC END# *479731C50290_4829D81D02E5_impl*
end;//TevCustomMemo.Cleanup

constructor TevCustomMemo.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4829D81D02E5_var*
//#UC END# *47D1602000C6_4829D81D02E5_var*
begin
//#UC START# *47D1602000C6_4829D81D02E5_impl*
 inherited;
 PlainText := true;
 LMargin := def_MemoLMargin;
 ParentColor := false;
 ScrollStyle := def_MemoScrollStyle;
 Wrap := true;
 AutoSelect := true;
 {$IfDef IsVCMProject}
 NeedDefaultPopupMenu := false;
 {$Else  IsVCMProject}
 NeedDefaultPopupMenu := true;
 {$EndIf IsVCMProject}
 if not (csDesigning in ComponentState) AND NeedDefaultPopupMenu then
  PopupMenu := MemoContextMenu;
 NeedReplaceQuotes := true;
//#UC END# *47D1602000C6_4829D81D02E5_impl*
end;//TevCustomMemo.Create

procedure TevCustomMemo.MakeTextSource(out theTextSource: TevCustomTextSource);
//#UC START# *482BFB0A00E0_4829D81D02E5_var*
var
 l_Suffix : String;  
//#UC END# *482BFB0A00E0_4829D81D02E5_var*
begin
//#UC START# *482BFB0A00E0_4829D81D02E5_impl*
 inherited;
 if (theTextSource = nil) then
 begin
  theTextSource := TextSourceClass.Create(Self);
  l_Suffix := ClassName + '_' + Name;
  while true do
  begin
   try
    theTextSource.Name := 'TextSource' + l_Suffix;
   except
    on EComponentError do
    begin
     l_Suffix := IntToStr(Random(1000));
     continue;
    end;//EComponentError
   end;//try..except
   break;
  end;//while true
  TextSource := TevCustomMemoTextSource(theTextSource);
  // - хак, чтобы не зацикливалось, при обращении к процессору внутри вставки текста http://mdp.garant.ru/pages/viewpage.action?pageId=224134934
  theTextSource.InsertBuf({$IfDef DesignTimeLibrary}nil{$Else}View{$EndIf}, l3PCharLen);
                       // ^ http://mdp.garant.ru/pages/viewpage.action?pageId=95486339
  theTextSource.Modified := false;
  theTextSource.SetSubComponent(true);
 end;//theTextSource = nil
//#UC END# *482BFB0A00E0_4829D81D02E5_impl*
end;//TevCustomMemo.MakeTextSource

function TevCustomMemo.AllowDrawDocumentEdge: Boolean;
//#UC START# *482BFBEE00D5_4829D81D02E5_var*
//#UC END# *482BFBEE00D5_4829D81D02E5_var*
begin
//#UC START# *482BFBEE00D5_4829D81D02E5_impl*
 Result := false;
//#UC END# *482BFBEE00D5_4829D81D02E5_impl*
end;//TevCustomMemo.AllowDrawDocumentEdge

function TevCustomMemo.RightIndentMul: Integer;
//#UC START# *482BFC8E036F_4829D81D02E5_var*
//#UC END# *482BFC8E036F_4829D81D02E5_var*
begin
//#UC START# *482BFC8E036F_4829D81D02E5_impl*
 Result := 0;
//#UC END# *482BFC8E036F_4829D81D02E5_impl*
end;//TevCustomMemo.RightIndentMul

function TevCustomMemo.WantEnter: Boolean;
//#UC START# *482BFCA000E4_4829D81D02E5_var*
var
 l_ParaLimit : Integer;
//#UC END# *482BFCA000E4_4829D81D02E5_var*
begin
//#UC START# *482BFCA000E4_4829D81D02E5_impl*
 if not HasDocument then
  Result := false
 else
 begin
  //Assert(TextSource Is TevCustomMemoTextSource);
  with TextSource.DocumentContainer do
  begin
   l_ParaLimit := DocumentLimits.TextParaLimit;
   if (l_ParaLimit <= 0) then
    Result := true
   else
    Result := (DocumentLimits.TextParaLimit - DocumentInfo.TextParaCount > 0);
  end;//with TextSource.DocumentContainer.DocumentInfo
 end;//not HasDocument
//#UC END# *482BFCA000E4_4829D81D02E5_impl*
end;//TevCustomMemo.WantEnter

function TevCustomMemo.WantTab(aKeyPressed: Boolean = False): Boolean;
//#UC START# *482BFCAE0072_4829D81D02E5_var*
//#UC END# *482BFCAE0072_4829D81D02E5_var*
begin
//#UC START# *482BFCAE0072_4829D81D02E5_impl*
 Result := false;
//#UC END# *482BFCAE0072_4829D81D02E5_impl*
end;//TevCustomMemo.WantTab

function TevCustomMemo.MakeExportFilters(aSelection: Boolean;
 aForExport: Boolean): InevTagGenerator;
//#UC START# *482BFD8601F3_4829D81D02E5_var*
//#UC END# *482BFD8601F3_4829D81D02E5_var*
begin
//#UC START# *482BFD8601F3_4829D81D02E5_impl*
 Result := nil;
//#UC END# *482BFD8601F3_4829D81D02E5_impl*
end;//TevCustomMemo.MakeExportFilters

procedure TevCustomMemo.TextChange;
 {* вызывается при смене текста. }
//#UC START# *482C26D6006A_4829D81D02E5_var*
//#UC END# *482C26D6006A_4829D81D02E5_var*
begin
//#UC START# *482C26D6006A_4829D81D02E5_impl*
 inherited;
 Validate;
//#UC END# *482C26D6006A_4829D81D02E5_impl*
end;//TevCustomMemo.TextChange

procedure TevCustomMemo.SetTextColor(const aCanvas: Il3Canvas);
//#UC START# *4831634B00FF_4829D81D02E5_var*
//#UC END# *4831634B00FF_4829D81D02E5_var*
begin
//#UC START# *4831634B00FF_4829D81D02E5_impl*
 if UseMemoFontForParagraphs then
 begin
  aCanvas.Font.AssignFont(Font);
  if not Enabled then
   aCanvas.Font.ForeColor := clSilver;// clBtnFace;
 end//UseMemoFontForParagraphs
 else
  inherited;
//#UC END# *4831634B00FF_4829D81D02E5_impl*
end;//TevCustomMemo.SetTextColor

function TevCustomMemo.pm_GetPlainText: Boolean;
//#UC START# *484515B3012E_4829D81D02E5get_var*
//#UC END# *484515B3012E_4829D81D02E5get_var*
begin
//#UC START# *484515B3012E_4829D81D02E5get_impl*
 Result := f_PlainText;
//#UC END# *484515B3012E_4829D81D02E5get_impl*
end;//TevCustomMemo.pm_GetPlainText

procedure TevCustomMemo.pm_SetPlainText(aValue: Boolean);
//#UC START# *484515B3012E_4829D81D02E5set_var*
//#UC END# *484515B3012E_4829D81D02E5set_var*
begin
//#UC START# *484515B3012E_4829D81D02E5set_impl*
 f_PlainText := aValue;
//#UC END# *484515B3012E_4829D81D02E5set_impl*
end;//TevCustomMemo.pm_SetPlainText

procedure TevCustomMemo.Loaded;
//#UC START# *484516C00214_4829D81D02E5_var*
//#UC END# *484516C00214_4829D81D02E5_var*
begin
//#UC START# *484516C00214_4829D81D02E5_impl*
 inherited;
 if not Assigned(PopupMenu) AND NeedDefaultPopupMenu then
  PopupMenu := MemoContextMenu;
//#UC END# *484516C00214_4829D81D02E5_impl*
end;//TevCustomMemo.Loaded

function TevCustomMemo.SelectWhenUnfocused: Boolean;
//#UC START# *48E22AD302CE_4829D81D02E5_var*
//#UC END# *48E22AD302CE_4829D81D02E5_var*
begin
//#UC START# *48E22AD302CE_4829D81D02E5_impl*
 Result := inherited SelectWhenUnfocused;
 if not Result then
  if not AutoSelect OR not AllowAutoSelectByMouse then
   if not HasSelection then
    Result := true;
//#UC END# *48E22AD302CE_4829D81D02E5_impl*
end;//TevCustomMemo.SelectWhenUnfocused

function TevCustomMemo.pm_GetAllowParaType: TevAllowParaTypes;
//#UC START# *4B877E7B0330_4829D81D02E5get_var*
//#UC END# *4B877E7B0330_4829D81D02E5get_var*
begin
//#UC START# *4B877E7B0330_4829D81D02E5get_impl*
 Result := [];
//#UC END# *4B877E7B0330_4829D81D02E5get_impl*
end;//TevCustomMemo.pm_GetAllowParaType

function TevCustomMemo.AllowAutoSelectByMouse: Boolean;
//#UC START# *4C346719001A_4829D81D02E5_var*
//#UC END# *4C346719001A_4829D81D02E5_var*
begin
//#UC START# *4C346719001A_4829D81D02E5_impl*
 {$IfDef Archi}
 Result := false;
 {$Else  Archi}
 Result := true;
 {$EndIf Archi}
//#UC END# *4C346719001A_4829D81D02E5_impl*
end;//TevCustomMemo.AllowAutoSelectByMouse

//#UC START# *4829D81D02E5impl*
//#UC END# *4829D81D02E5impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TevCustomMemo);
 {* Регистрация TevCustomMemo }
{$IfEnd} // NOT Defined(NoScripts)

end.
