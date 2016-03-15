unit K619320841;
 {* [Requestlink:618678791]. Лишниее выравнивание. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619320841.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK619320841 = class(THTMLtoEVDFull)
  {* [Requestlink:618678791]. Лишниее выравнивание. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619320841
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619320841.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK619320841.GetFolder

function TK619320841.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E26DA00141';
end;//TK619320841.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619320841.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
