unit PageCountTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/PageCountTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TPageCountTest
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
  PreviewTest
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TPageCountTest = {abstract} class(TPreviewTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function OnlyCheckPageCount: Boolean; override;
 end;//TPageCountTest
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

// start class TPageCountTest

function TPageCountTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TPageCountTest.GetFolder

function TPageCountTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '51AD98A501F0';
end;//TPageCountTest.GetModelElementGUID

function TPageCountTest.OnlyCheckPageCount: Boolean;
//#UC START# *51AD98E70324_51AD98A501F0_var*
//#UC END# *51AD98E70324_51AD98A501F0_var*
begin
//#UC START# *51AD98E70324_51AD98A501F0_impl*
 Result := True;
//#UC END# *51AD98E70324_51AD98A501F0_impl*
end;//TPageCountTest.OnlyCheckPageCount

{$IfEnd} //nsTest AND not NoVCM

end.