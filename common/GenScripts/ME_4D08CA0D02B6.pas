unit K217685978;
 {* [RequestLink:217685978] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K217685978.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TextMetricsTest
;

type
 TK217685978 = class(TTextMetricsTest)
  {* [RequestLink:217685978] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK217685978
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK217685978.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK217685978.GetFolder

function TK217685978.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D08CA0D02B6';
end;//TK217685978.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK217685978.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
