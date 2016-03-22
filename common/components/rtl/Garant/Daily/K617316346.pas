unit K617316346;
 {* [Requestlink:617316346] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K617316346.pas"
// Стереотип: "TestCase"
// Элемент модели: "K617316346" MUID: (56C1ABDB02F0)
// Имя типа: "TK617316346"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDWithApplyTextCorrections
;

type
 TK617316346 = class(THTMLtoEVDWithApplyTextCorrections)
  {* [Requestlink:617316346] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK617316346
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK617316346.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK617316346.GetFolder

function TK617316346.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56C1ABDB02F0';
end;//TK617316346.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK617316346.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
