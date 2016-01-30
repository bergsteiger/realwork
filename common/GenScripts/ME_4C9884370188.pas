unit K235054083;
 {* [RequestLink:235054083]. }

// Модуль: "w:\common\components\rtl\Garant\Daily\K235054083.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoBothNSRCWriterTest
;

type
 TK235054083 = class(TEVDtoBothNSRCWriterTest)
  {* [RequestLink:235054083]. }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK235054083
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK235054083.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK235054083.GetFolder

function TK235054083.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C9884370188';
end;//TK235054083.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK235054083.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
