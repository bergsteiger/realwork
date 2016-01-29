unit PreviewTestBefore278833302;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "TestFormsTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Daily/PreviewTestBefore278833302.pas"
// Начат: 27.12.2010 16:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Operations For Tests::TestFormsTest::Everest::TPreviewTestBefore278833302
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
  PreviewTestBefore235875079
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
type
 TPreviewTestBefore278833302 = {abstract} class(TPreviewTestBefore235875079)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function IsBefore235875079: Boolean; override;
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TPreviewTestBefore278833302
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

// start class TPreviewTestBefore278833302

function TPreviewTestBefore278833302.GetFolder: AnsiString;
 {-}
begin
 Result := 'Everest';
end;//TPreviewTestBefore278833302.GetFolder

function TPreviewTestBefore278833302.IsBefore235875079: Boolean;
//#UC START# *4D18990C0329_4D18986B03D0_var*
//#UC END# *4D18990C0329_4D18986B03D0_var*
begin
//#UC START# *4D18990C0329_4D18986B03D0_impl*
 Result := false;
//#UC END# *4D18990C0329_4D18986B03D0_impl*
end;//TPreviewTestBefore278833302.IsBefore235875079

function TPreviewTestBefore278833302.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D18986B03D0';
end;//TPreviewTestBefore278833302.GetModelElementGUID

{$IfEnd} //nsTest AND not NoVCM

end.