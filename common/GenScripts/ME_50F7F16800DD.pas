unit K424386600;
 {* [Requestlink:424386600] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K424386600.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , EVDtoRTFWriterTest
;

type
 TK424386600 = class(TEVDtoRTFWriterTest)
  {* [Requestlink:424386600] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK424386600
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK424386600.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.8';
end;//TK424386600.GetFolder

function TK424386600.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '50F7F16800DD';
end;//TK424386600.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK424386600.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
