unit K210043510;
 {* [RequestLink:210043510] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K210043510.pas"
// Стереотип: "TestCase"
// Элемент модели: "K210043510" MUID: (4BE2AA0D00ED)
// Имя типа: "TK210043510"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK210043510 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:210043510] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK210043510
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210043510.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK210043510.GetFolder

function TK210043510.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE2AA0D00ED';
end;//TK210043510.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210043510.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
