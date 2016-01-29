unit TextMetricsAfterCopyPasteTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Модуль: "w:/common/components/rtl/Garant/Daily/TextMetricsAfterCopyPasteTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EditorTests::TTextMetricsAfterCopyPasteTest
//
// Проверка метрик после вставки-копирования текста.
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
  TextMetricsTest,
  evCustomEditorWindow
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 _ClipboardOperations_Parent_ = TTextMetricsTest;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}
 _SelectOperation_Parent_ = _ClipboardOperations_;
 {$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}
 TTextMetricsAfterCopyPasteTest = {abstract} class(_SelectOperation_)
  {* Проверка метрик после вставки-копирования текста. }
 protected
 // overridden protected methods
   {$If defined(nsTest) AND not defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
   {$IfEnd} //nsTest AND not NoVCM
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TTextMetricsAfterCopyPasteTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork,
  l3Base,
  evOp,
  l3InternalInterfaces,
  evTypes
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

{$Include w:\common\components\rtl\Garant\ScriptEngine\ClipboardOperations.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\EditorUsers\SelectOperation.imp.pas}

// start class TTextMetricsAfterCopyPasteTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TTextMetricsAfterCopyPasteTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4D19DD6A0378_var*
//#UC END# *4BE13147032C_4D19DD6A0378_var*
begin
//#UC START# *4BE13147032C_4D19DD6A0378_impl*
 inherited;
 SelectDocument(aForm.Text);
 CopyAndPaste2DocumentBottom(aForm.Text);
//#UC END# *4BE13147032C_4D19DD6A0378_impl*
end;//TTextMetricsAfterCopyPasteTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TTextMetricsAfterCopyPasteTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TTextMetricsAfterCopyPasteTest.GetFolder

function TTextMetricsAfterCopyPasteTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D19DD6A0378';
end;//TTextMetricsAfterCopyPasteTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.