unit K180060897;
 {* [$180060897] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K180060897.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK180060897 = class(TEVDtoNSRCOldWriterTest)
  {* [$180060897] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK180060897
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK180060897.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK180060897.GetFolder

function TK180060897.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B7D0B5D02BA';
end;//TK180060897.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK180060897.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
