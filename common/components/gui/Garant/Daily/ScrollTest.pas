unit ScrollTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Daily/ScrollTest.pas"
// Начат: 13.05.2010 16:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TScrollTest
//
// Тест скроллирования документа
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
 TScrollTest = {abstract} class(TPrimScrollTest)
  {* Тест скроллирования документа }
 protected
 // realized methods
   procedure DoVisit(aForm: TPrimTextLoadForm); override;
     {* Обработать текст }
 protected
 // overridden protected methods
   function GetNormalFontSize: Integer; override;
     {* Возвращает размер шрифта стиля "Нормальный". 0 - по-умолчанию }
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TScrollTest
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

// start class TScrollTest

procedure TScrollTest.DoVisit(aForm: TPrimTextLoadForm);
//#UC START# *4BE419AF0217_4BEBF13B0076_var*
//#UC END# *4BE419AF0217_4BEBF13B0076_var*
begin
//#UC START# *4BE419AF0217_4BEBF13B0076_impl*
 Scroll(aForm, '');
//#UC END# *4BE419AF0217_4BEBF13B0076_impl*
end;//TScrollTest.DoVisit

function TScrollTest.GetNormalFontSize: Integer;
//#UC START# *4C07AC6F036D_4BEBF13B0076_var*
//#UC END# *4C07AC6F036D_4BEBF13B0076_var*
begin
//#UC START# *4C07AC6F036D_4BEBF13B0076_impl*
 Result := 12;
//#UC END# *4C07AC6F036D_4BEBF13B0076_impl*
end;//TScrollTest.GetNormalFontSize

function TScrollTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TScrollTest.GetFolder

function TScrollTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4BEBF13B0076';
end;//TScrollTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.