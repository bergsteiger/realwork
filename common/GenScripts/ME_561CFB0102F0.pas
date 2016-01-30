unit K607531290;
 {* [RequestLink:607531290] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K607531290.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK607531290 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:607531290] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK607531290
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607531290.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK607531290.GetFolder

function TK607531290.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '561CFB0102F0';
end;//TK607531290.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607531290.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
