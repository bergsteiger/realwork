unit K177964278;
 {* [$177964278] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K177964278.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK177964278 = class(TEVDtoNSRCOldWriterTest)
  {* [$177964278] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK177964278
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK177964278.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK177964278.GetFolder

function TK177964278.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B7C2470024D';
end;//TK177964278.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK177964278.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
