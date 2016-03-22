unit K444993775;
 {* [Requestlink:444993775] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K444993775.pas"
// Стереотип: "TestCase"
// Элемент модели: "K444993775" MUID: (5155731800A1)
// Имя типа: "TK444993775"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK444993775 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:444993775] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK444993775
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK444993775.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK444993775.GetFolder

function TK444993775.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5155731800A1';
end;//TK444993775.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK444993775.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
