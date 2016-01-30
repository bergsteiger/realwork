unit K276535467;
 {* [$276535467] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K276535467.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCPlusWriterTest
;

type
 TK276535467 = class(TEVDtoNSRCPlusWriterTest)
  {* [$276535467] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK276535467
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK276535467.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRC 7.7';
end;//TK276535467.GetFolder

function TK276535467.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4E314A010210';
end;//TK276535467.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK276535467.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
