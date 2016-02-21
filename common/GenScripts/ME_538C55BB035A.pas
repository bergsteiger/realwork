unit K537973358;
 {* [Requestlink:537973358] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K537973358.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537973358 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537973358] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK537973358
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK537973358.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK537973358.GetFolder

function TK537973358.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '538C55BB035A';
end;//TK537973358.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537973358.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
