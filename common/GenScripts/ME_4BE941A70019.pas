unit K210438353;
 {* [RequestLink:210438353] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K210438353.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK210438353 = class(TEVDtoNSRCPlusWriterTest)
  {* [RequestLink:210438353] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK210438353
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK210438353.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.5';
end;//TK210438353.GetFolder

function TK210438353.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4BE941A70019';
end;//TK210438353.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK210438353.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
