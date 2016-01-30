unit K211878214;
 {* [RequestLink:211878214] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K211878214.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK211878214 = class(TEVDtoNSRCOldWriterTest)
  {* [RequestLink:211878214] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK211878214
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK211878214.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK211878214.GetFolder

function TK211878214.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BEBB7840223';
end;//TK211878214.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK211878214.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
