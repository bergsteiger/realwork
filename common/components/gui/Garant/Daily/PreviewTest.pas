unit PreviewTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Модуль: "w:/common/components/gui/Garant/Daily/PreviewTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TPreviewTest
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
  PreviewTestBefore278833302
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TPreviewTest = {abstract} class(TPreviewTestBefore278833302)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   function IsBefore278833302: Boolean; override;
 end;//TPreviewTest
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

// start class TPreviewTest

function TPreviewTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TPreviewTest.GetFolder

function TPreviewTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4E5BD013008D';
end;//TPreviewTest.GetModelElementGUID

function TPreviewTest.IsBefore278833302: Boolean;
//#UC START# *4E5BD02E029C_4E5BD013008D_var*
//#UC END# *4E5BD02E029C_4E5BD013008D_var*
begin
//#UC START# *4E5BD02E029C_4E5BD013008D_impl*
 Result := false;
//#UC END# *4E5BD02E029C_4E5BD013008D_impl*
end;//TPreviewTest.IsBefore278833302

{$IfEnd} //nsTest AND not NoVCM

end.