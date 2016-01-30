unit K607751255;
 {* [RequestLink:607751255] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K607751255.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK607751255 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:607751255] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK607751255
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK607751255.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK607751255.GetFolder

function TK607751255.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '56124E780397';
end;//TK607751255.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK607751255.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
