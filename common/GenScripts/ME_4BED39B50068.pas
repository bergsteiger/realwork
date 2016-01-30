unit K213254256;
 {* [RequestLink:213254256] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K213254256.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK213254256 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:213254256] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK213254256
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK213254256.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK213254256.GetFolder

function TK213254256.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BED39B50068';
end;//TK213254256.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK213254256.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
