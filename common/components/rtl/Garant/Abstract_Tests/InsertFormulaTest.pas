unit InsertFormulaTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Abstract Tests"
// Модуль: "w:/common/components/rtl/Garant/Abstract_Tests/InsertFormulaTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Abstract Tests::EditorTests::TInsertFormulaTest
//
// Тест на вставку формулы.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Abstract_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  TextViaEditorProcessor
  {$IfEnd} //nsTest AND not NoVCM
  
  {$If defined(nsTest) AND not defined(NoVCM)}
  ,
  PrimTextLoad_Form
  {$IfEnd} //nsTest AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TInsertFormulaTest = {abstract} class(TTextViaEditorProcessor)
  {* Тест на вставку формулы. }
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
   function GetFormulaText: AnsiString; virtual; abstract;
 end;//TInsertFormulaTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
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
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TInsertFormulaTest

{$If defined(nsTest) AND not defined(NoVCM)}
procedure TInsertFormulaTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4DAFEAAD012D_var*
//#UC END# *4BE13147032C_4DAFEAAD012D_var*
begin
//#UC START# *4BE13147032C_4DAFEAAD012D_impl*
 aForm.Text.InsertFormula(GetFormulaText);
//#UC END# *4BE13147032C_4DAFEAAD012D_impl*
end;//TInsertFormulaTest.Process
{$IfEnd} //nsTest AND not NoVCM

function TInsertFormulaTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EditorTests';
end;//TInsertFormulaTest.GetFolder

function TInsertFormulaTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4DAFEAAD012D';
end;//TInsertFormulaTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.