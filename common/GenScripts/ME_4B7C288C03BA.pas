unit K177964264;
 {* [$177964264] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K177964264.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoNSRCOldWriterTest
;

type
 TK177964264 = class(TEVDtoNSRCOldWriterTest)
  {* [$177964264] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK177964264
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK177964264.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'NSRCTests';
end;//TK177964264.GetFolder

function TK177964264.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4B7C288C03BA';
end;//TK177964264.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK177964264.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
