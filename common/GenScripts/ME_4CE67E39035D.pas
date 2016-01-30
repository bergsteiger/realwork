unit K242843959;
 {* [RequestLink:242843959] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K242843959.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoNSRCTest
;

type
 TK242843959 = class(TNSRCtoNSRCTest)
  {* [RequestLink:242843959] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK242843959
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK242843959.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK242843959.GetFolder

function TK242843959.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4CE67E39035D';
end;//TK242843959.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK242843959.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
