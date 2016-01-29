unit ChangeAllTablesTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/ChangeAllTablesTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TChangeAllTablesTest
//
// Работа со всеми таблицами документа.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evCustomEditor,
  TextViaEditorProcessor,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TChangeAllTablesTest = {abstract} class(TTextViaEditorProcessor)
  {* Работа со всеми таблицами документа. }
 protected
 // realized methods
   procedure Process(aForm: TPrimTextLoadForm); override;
     {* Собственно процесс обработки текста }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 protected
 // protected methods
   procedure ApplyEditorTool(aEditor: TevCustomEditor); virtual; abstract;
     {* Вызов инструмента из редактора }
 end;//TChangeAllTablesTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  evTypes,
  TestFrameWork,
  vcmBase,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3Base
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

// start class TChangeAllTablesTest

procedure TChangeAllTablesTest.Process(aForm: TPrimTextLoadForm);
//#UC START# *4BE13147032C_4C3FEB280134_var*
//#UC END# *4BE13147032C_4C3FEB280134_var*
begin
//#UC START# *4BE13147032C_4C3FEB280134_impl*
 aForm.Text.Select(ev_stDocument);
 ApplyEditorTool(aForm.Text);
//#UC END# *4BE13147032C_4C3FEB280134_impl*
end;//TChangeAllTablesTest.Process

function TChangeAllTablesTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TChangeAllTablesTest.GetFolder

function TChangeAllTablesTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C3FEB280134';
end;//TChangeAllTablesTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.