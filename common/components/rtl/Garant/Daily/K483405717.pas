unit K483405717;
 {* [RequestLink:483405717] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K483405717.pas"
// Стереотип: "TestCase"
// Элемент модели: "K483405717" MUID: (52383A1B02DF)
// Имя типа: "TK483405717"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , LostNodeAppConfigTest
;

type
 TK483405717 = class(TLostNodeAppConfigTest)
  {* [RequestLink:483405717] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK483405717
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

function TK483405717.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.9';
end;//TK483405717.GetFolder

function TK483405717.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '52383A1B02DF';
end;//TK483405717.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK483405717.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
