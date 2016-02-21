unit K610951982;
 {* [Requestlink:610951982] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K610951982.pas"
// Стереотип: "TestCase"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK610951982 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:610951982] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK610951982
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK610951982.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.12';
end;//TK610951982.GetFolder

function TK610951982.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '565D366A0111';
end;//TK610951982.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK610951982.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
