unit K540412066;
 {* [Requestlink:540412066] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K540412066.pas"
// Стереотип: "TestCase"
// Элемент модели: "K540412066" MUID: (53900E7D039A)
// Имя типа: "TK540412066"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK540412066 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:540412066] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK540412066
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *53900E7D039Aimpl_uses*
 //#UC END# *53900E7D039Aimpl_uses*
;

function TK540412066.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.10';
end;//TK540412066.GetFolder

function TK540412066.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53900E7D039A';
end;//TK540412066.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK540412066.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
