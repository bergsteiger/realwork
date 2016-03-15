unit K619725459;
 {* [Requestlink:619725459] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619725459.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK619725459 = class(THTMLtoEVDFull)
  {* [Requestlink:619725459] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619725459
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619725459.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK619725459.GetFolder

function TK619725459.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E809DC0227';
end;//TK619725459.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619725459.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
