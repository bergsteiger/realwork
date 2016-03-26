unit PreviewTest;

// Модуль: "w:\common\components\gui\Garant\Daily\PreviewTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TPreviewTest" MUID: (4E5BD013008D)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PreviewTestBefore278833302
;

type
 TPreviewTest = {abstract} class(TPreviewTestBefore278833302)
  protected
   function IsBefore278833302: Boolean; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TPreviewTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
 , vcmBase
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TPreviewTest.IsBefore278833302: Boolean;
//#UC START# *4E5BD02E029C_4E5BD013008D_var*
//#UC END# *4E5BD02E029C_4E5BD013008D_var*
begin
//#UC START# *4E5BD02E029C_4E5BD013008D_impl*
 Result := false;
//#UC END# *4E5BD02E029C_4E5BD013008D_impl*
end;//TPreviewTest.IsBefore278833302

function TPreviewTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TPreviewTest.GetFolder

function TPreviewTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E5BD013008D';
end;//TPreviewTest.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
