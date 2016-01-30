unit K232099823;
 {* [RequestLink:232099823] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K232099823.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK232099823 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLink:232099823] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK232099823
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK232099823.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.6';
end;//TK232099823.GetFolder

function TK232099823.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4C68FC100016';
end;//TK232099823.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK232099823.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
