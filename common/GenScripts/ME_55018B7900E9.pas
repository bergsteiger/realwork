unit K590745831;
 {* [Requestlink:590745831] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K590745831.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK590745831 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:590745831] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK590745831
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK590745831.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK590745831.GetFolder

function TK590745831.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55018B7900E9';
end;//TK590745831.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK590745831.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
