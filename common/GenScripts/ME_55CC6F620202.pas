unit K605147298;
 {* [Requestlink:605147298] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K605147298.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK605147298 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:605147298] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK605147298
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK605147298.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK605147298.GetFolder

function TK605147298.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55CC6F620202';
end;//TK605147298.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK605147298.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
