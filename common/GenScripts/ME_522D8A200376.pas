unit K480822492;
 {* [Requestlink:480822492] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K480822492.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoEVDTest
;

type
 TK480822492 = class(TNSRCtoEVDTest)
  {* [Requestlink:480822492] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK480822492
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK480822492.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.9';
end;//TK480822492.GetFolder

function TK480822492.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '522D8A200376';
end;//TK480822492.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK480822492.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
