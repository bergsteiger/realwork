unit ScrollBackByLineTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/ScrollBackByLineTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TScrollBackByLineTest
//
// Прокрутка построчно снизу вверх
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
  PrimScrollTest,
  PrimTextLoad_Form
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TScrollBackByLineTest = {abstract} class(TPrimScrollTest)
  {* Прокрутка построчно снизу вверх }
 protected
 // realized methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollBackByLineTest
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
uses
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

// start class TScrollBackByLineTest

procedure TScrollBackByLineTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4C45563D00F7_var*
//#UC END# *4BE419AF0217_4C45563D00F7_var*
begin
//#UC START# *4BE419AF0217_4C45563D00F7_impl*
 ScrollByLine(aForm, -1, True, True);
//#UC END# *4BE419AF0217_4C45563D00F7_impl*
end;//TScrollBackByLineTest.DoVisit

function TScrollBackByLineTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TScrollBackByLineTest.GetFolder

function TScrollBackByLineTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C45563D00F7';
end;//TScrollBackByLineTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.