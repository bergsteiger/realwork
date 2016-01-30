unit K530839239;
 {* [Requestlink:530839239] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K530839239.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK530839239 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:530839239] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK530839239
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK530839239.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK530839239.GetFolder

function TK530839239.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5357965602B8';
end;//TK530839239.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK530839239.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
