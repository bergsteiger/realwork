unit K512248597;
 {* [Requestlink:512248597] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K512248597.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK512248597 = class(TEVDtoRTFWriterTest)
  {* [Requestlink:512248597] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK512248597
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK512248597.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK512248597.GetFolder

function TK512248597.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '52DF9692021D';
end;//TK512248597.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK512248597.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
