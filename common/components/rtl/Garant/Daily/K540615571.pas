unit K540615571;
 {* [Requestlink:540414514] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K540615571.pas"
// Стереотип: "TestCase"
// Элемент модели: "K540615571" MUID: (539181DB00B8)
// Имя типа: "TK540615571"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK540615571 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:540414514] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK540615571
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
;

function TK540615571.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK540615571.GetFolder

function TK540615571.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '539181DB00B8';
end;//TK540615571.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540615571.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
