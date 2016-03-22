unit K619725311;
 {* [Requestlink:619725311] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619725311.pas"
// Стереотип: "TestCase"
// Элемент модели: "K619725311" MUID: (56E809B1018D)
// Имя типа: "TK619725311"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDFull
;

type
 TK619725311 = class(THTMLtoEVDFull)
  {* [Requestlink:619725311] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619725311
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619725311.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK619725311.GetFolder

function TK619725311.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56E809B1018D';
end;//TK619725311.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619725311.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
