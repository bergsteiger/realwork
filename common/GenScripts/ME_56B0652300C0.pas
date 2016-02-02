unit K616411367;
 {* [Requestlink:616411367] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K616411367.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK616411367 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:616411367] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK616411367
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK616411367.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK616411367.GetFolder

function TK616411367.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56B0652300C0';
end;//TK616411367.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK616411367.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
