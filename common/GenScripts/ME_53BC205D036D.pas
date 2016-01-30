unit K553427493;
 {* [RequestLink:553427493] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K553427493.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BadEVDTest
;

type
 TK553427493 = class(TBadEVDTest)
  {* [RequestLink:553427493] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK553427493
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK553427493.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'BadEVD';
end;//TK553427493.GetFolder

function TK553427493.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53BC205D036D';
end;//TK553427493.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK553427493.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
