unit K606808786;
 {* [Requestlink:606808786] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K606808786.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK606808786 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:606808786] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK606808786
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK606808786.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK606808786.GetFolder

function TK606808786.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55F67EDA01D1';
end;//TK606808786.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK606808786.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
