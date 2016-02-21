unit K585129079;
 {* [RequestLink:585129079] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K585129079.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK585129079 = class(TRTFtoEVDWriterTest)
  {* [RequestLink:585129079] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK585129079
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK585129079.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK585129079.GetFolder

function TK585129079.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54919A8E036E';
end;//TK585129079.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK585129079.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
