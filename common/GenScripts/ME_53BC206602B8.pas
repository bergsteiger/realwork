unit K553427493_notBad;
 {* [RequestLink:553427493] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K553427493_notBad.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BadEVDTest
;

type
 TK553427493_notBad = class(TBadEVDTest)
  {* [RequestLink:553427493] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK553427493_notBad
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK553427493_notBad.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BadEVD';
end;//TK553427493_notBad.GetFolder

function TK553427493_notBad.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53BC206602B8';
end;//TK553427493_notBad.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK553427493_notBad.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
