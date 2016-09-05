unit K200901262;
 {* [RequestLink:200901262] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K200901262.pas"
// Стереотип: "TestCase"
// Элемент модели: "K200901262" MUID: (4BB5EDA102EE)
// Имя типа: "TK200901262"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK200901262 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:200901262] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK200901262
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4BB5EDA102EEimpl_uses*
 //#UC END# *4BB5EDA102EEimpl_uses*
;

function TK200901262.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK200901262.GetFolder

function TK200901262.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BB5EDA102EE';
end;//TK200901262.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK200901262.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
