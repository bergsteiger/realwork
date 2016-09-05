unit K537233020;
 {* [Requestlink:537233020] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K537233020.pas"
// Стереотип: "TestCase"
// Элемент модели: "K537233020" MUID: (537F13DD031D)
// Имя типа: "TK537233020"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK537233020 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:537233020] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK537233020
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *537F13DD031Dimpl_uses*
 //#UC END# *537F13DD031Dimpl_uses*
;

function TK537233020.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK537233020.GetFolder

function TK537233020.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '537F13DD031D';
end;//TK537233020.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK537233020.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
