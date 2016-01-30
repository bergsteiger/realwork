unit K247300520;
 {* [RequestLink:247300520] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K247300520.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoBlockTest
;

type
 TK247300520 = class(TAutoBlockTest)
  {* [RequestLink:247300520] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK247300520
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK247300520.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK247300520.GetFolder

function TK247300520.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D08F3E3023E';
end;//TK247300520.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK247300520.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
