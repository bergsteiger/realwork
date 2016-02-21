unit K618269589;
 {* [Requestlink:618269589] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K618269589.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK618269589 = class(THTMLtoEVDTest)
  {* [Requestlink:618269589] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK618269589
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK618269589.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK618269589.GetFolder

function TK618269589.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56C8113802F7';
end;//TK618269589.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK618269589.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
