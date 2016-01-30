unit K483405717;
 {* [RequestLink:483405717] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K483405717.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

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
