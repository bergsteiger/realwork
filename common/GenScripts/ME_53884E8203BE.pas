unit K538566131;
 {* [Requestlink:538566131] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K538566131.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK538566131 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:538566131] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK538566131
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK538566131.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK538566131.GetFolder

function TK538566131.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53884E8203BE';
end;//TK538566131.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK538566131.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
