unit K531975039;
 {* [Requestlink:531975039] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K531975039.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK531975039 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:531975039] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK531975039
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK531975039.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK531975039.GetFolder

function TK531975039.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '535A4B940172';
end;//TK531975039.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK531975039.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
