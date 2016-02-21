unit K590745463;
 {* [Requestlink:590745463] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K590745463.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK590745463 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:590745463] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK590745463
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK590745463.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK590745463.GetFolder

function TK590745463.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55013A8C0059';
end;//TK590745463.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590745463.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
