unit K540414514;
 {* [Requestlink:540414514] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K540414514.pas"
// Стереотип: "TestCase"
// Элемент модели: "K540414514" MUID: (53903EFB0324)
// Имя типа: "TK540414514"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK540414514 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:540414514] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK540414514
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK540414514.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK540414514.GetFolder

function TK540414514.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53903EFB0324';
end;//TK540414514.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540414514.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
