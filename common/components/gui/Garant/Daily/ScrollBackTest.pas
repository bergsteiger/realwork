unit ScrollBackTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Daily/ScrollBackTest.pas"
// Начат: 25.05.2010 18:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TScrollBackTest
//
// Тест скроллирования документа в обратную сторону
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
 TScrollBackTest = {abstract} class(TPrimScrollTest)
  {* Тест скроллирования документа в обратную сторону }
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
 end;//TScrollBackTest
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

// start class TScrollBackTest

procedure TScrollBackTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4BFBDEA300F4_var*
//#UC END# *4BE419AF0217_4BFBDEA300F4_var*
begin
//#UC START# *4BE419AF0217_4BFBDEA300F4_impl*
 ScrollBack(aForm, '');
//#UC END# *4BE419AF0217_4BFBDEA300F4_impl*
end;//TScrollBackTest.DoVisit

function TScrollBackTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TScrollBackTest.GetFolder

function TScrollBackTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BFBDEA300F4';
end;//TScrollBackTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.