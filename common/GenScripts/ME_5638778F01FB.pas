unit K610504218;
 {* [Requestlink:610504218] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K610504218.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610504218 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610504218] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK610504218
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK610504218.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK610504218.GetFolder

function TK610504218.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5638778F01FB';
end;//TK610504218.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610504218.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
