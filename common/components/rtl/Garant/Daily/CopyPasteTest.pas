unit CopyPasteTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/CopyPasteTest.pas"
// Начат: 17.09.2010 15:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TCopyPasteTest
//
// Тест копирования/вставки через буфер обмена
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  nevTools,
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  ,
  l3Variant
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _CursorMover_Parent_ = TTextViaEditorProcessor;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}
 _ClipboardOperations_Parent_ = _CursorMover_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}
 TCopyPasteTest = {abstract} class(_ClipboardOperations_)
  {* Тест копирования/вставки через буфер обмена }
 protected
 // realized methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   function DoSelect(aText: TevCustomEditorWindow;
     const anOp: Il3OpPack): InevRange; virtual; abstract;
     {* Выделяет текст в редакторе }
 end;//TCopyPasteTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  k2Prim,
  evTypes,
  TestFrameWork,
  evMsgCode,
  evOp,
  l3Base,
  l3InternalInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\CursorMover.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}

// start class TCopyPasteTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TCopyPasteTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4C93529B018C_var*
var
 l_Op : Il3OpPack;
 l_Selection : InevSelection;
 l_Range : InevRange;
//#UC END# *4BE13147032C_4C93529B018C_var*
begin
//#UC START# *4BE13147032C_4C93529B018C_impl*
 with aForm.Text do
 begin
  l_Op := StartOp;
  try
   l_Selection := Selection;
   if (l_Selection <> nil) then
   begin
    l_Range := DoSelect(aForm.Text, l_Op);
    l_Selection.Select(l_Range, false);
    Assert(not aForm.Text.Selection.Collapsed);
    CopyToClipboard(aForm.Text);
    Select(ev_stDocument);
    Self.PasteFromClipboard(aForm.Text);
    ClearClipboard;
   end; // if (l_Selection <> nil) then
  finally
   l_Op := nil;
  end;//try..finally
 end;//aForm.Text
//#UC END# *4BE13147032C_4C93529B018C_impl*
end;//TCopyPasteTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TCopyPasteTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TCopyPasteTest.GetFolder

function TCopyPasteTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C93529B018C';
end;//TCopyPasteTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.