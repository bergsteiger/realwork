unit K601686929;
 {* [Requestlink:601686929] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K601686929.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK601686929 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:601686929] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK601686929
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK601686929.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK601686929.GetFolder

function TK601686929.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5593A65D025A';
end;//TK601686929.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK601686929.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
