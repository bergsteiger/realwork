unit K177964664;
 {* [$177964664] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K177964664.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , NSRCtoMemoryTest
;

type
 TK177964664 = class(TNSRCtoMemoryTest)
  {* [$177964664] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK177964664
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK177964664.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK177964664.GetFolder

function TK177964664.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B7D07FD00BF';
end;//TK177964664.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK177964664.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
