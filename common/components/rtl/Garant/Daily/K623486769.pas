unit K623486769;
 {* [Requestlink:623486769] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K623486769.pas"
// Стереотип: "TestCase"
// Элемент модели: "K623486769" MUID: (574EAF4002F2)
// Имя типа: "TK623486769"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK623486769 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:623486769] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK623486769
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK623486769.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '8.0';
end;//TK623486769.GetFolder

function TK623486769.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '574EAF4002F2';
end;//TK623486769.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK623486769.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
