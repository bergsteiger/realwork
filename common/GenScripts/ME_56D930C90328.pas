unit K619321401;
 {* [Requestlink:619321401] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K619321401.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoHTMLWithExternalHyperlinks
;

type
 TK619321401 = class(TEVDtoHTMLWithExternalHyperlinks)
  {* [Requestlink:619321401] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK619321401
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK619321401.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK619321401.GetFolder

function TK619321401.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56D930C90328';
end;//TK619321401.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK619321401.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
