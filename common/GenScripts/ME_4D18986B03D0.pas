unit PreviewTestBefore278833302;

// Модуль: "w:\common\components\gui\Garant\Daily\PreviewTestBefore278833302.pas"
// Стереотип: "TestCase"
// Элемент модели: "TPreviewTestBefore278833302" MUID: (4D18986B03D0)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PreviewTestBefore235875079
;

type
 TPreviewTestBefore278833302 = {abstract} class(TPreviewTestBefore235875079)
  protected
   function IsBefore235875079: Boolean; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TPreviewTestBefore278833302
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

function TPreviewTestBefore278833302.IsBefore235875079: Boolean;
//#UC START# *4D18990C0329_4D18986B03D0_var*
//#UC END# *4D18990C0329_4D18986B03D0_var*
begin
//#UC START# *4D18990C0329_4D18986B03D0_impl*
 Result := false;
//#UC END# *4D18990C0329_4D18986B03D0_impl*
end;//TPreviewTestBefore278833302.IsBefore235875079

function TPreviewTestBefore278833302.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TPreviewTestBefore278833302.GetFolder

function TPreviewTestBefore278833302.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D18986B03D0';
end;//TPreviewTestBefore278833302.GetModelElementGUID
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
