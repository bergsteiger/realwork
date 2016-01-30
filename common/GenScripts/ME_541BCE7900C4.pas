unit K565269737;
 {* [Requestlink:565269737] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K565269737.pas"
// Стереотип: "TestCase"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK565269737 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:565269737] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK565269737
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK565269737.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK565269737.GetFolder

function TK565269737.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '541BCE7900C4';
end;//TK565269737.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK565269737.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
