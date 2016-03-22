unit K252086528;
 {* [$252086528] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K252086528.pas"
// Стереотип: "TestCase"
// Элемент модели: "K252086528" MUID: (4D46BC0D00F9)
// Имя типа: "TK252086528"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , OutlinerWithEVDStyleNodes
;

type
 TK252086528 = class(TOutlinerWithEVDStyleNodes)
  {* [$252086528] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK252086528
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
;

function TK252086528.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK252086528.GetFolder

function TK252086528.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D46BC0D00F9';
end;//TK252086528.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK252086528.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
