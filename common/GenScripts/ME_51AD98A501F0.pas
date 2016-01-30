unit PageCountTest;

// Модуль: "w:\common\components\gui\Garant\Daily\PageCountTest.pas"
// Стереотип: "TestCase"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PreviewTest
;

type
 TPageCountTest = {abstract} class(TPreviewTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   function OnlyCheckPageCount: Boolean; override;
 end;//TPageCountTest
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , TestFrameWork
;

function TPageCountTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'Everest';
end;//TPageCountTest.GetFolder

function TPageCountTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
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
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
