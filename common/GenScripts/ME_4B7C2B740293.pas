unit K177964498;
 {* [$177964498] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K177964498.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK177964498 = class(TEVDtoNSRCPlusWriterTest)
  {* [$177964498] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK177964498
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK177964498.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK177964498.GetFolder

function TK177964498.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B7C2B740293';
end;//TK177964498.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK177964498.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
