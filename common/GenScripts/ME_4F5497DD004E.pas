unit K342865677;
 {* [RequestLink:342865677] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K342865677.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK342865677 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:342865677] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK342865677
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK342865677.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRC 7.7';
end;//TK342865677.GetFolder

function TK342865677.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F5497DD004E';
end;//TK342865677.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK342865677.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
