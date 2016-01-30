unit K211878862;
 {* [$211878862] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K211878862.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK211878862 = class(TEVDtoNSRCOldWriterTest)
  {* [$211878862] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK211878862
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK211878862.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK211878862.GetFolder

function TK211878862.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BEBDEBA0161';
end;//TK211878862.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK211878862.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
