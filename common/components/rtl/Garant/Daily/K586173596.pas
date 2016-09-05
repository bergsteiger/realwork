unit K586173596;
 {* [Requestlink:586173596] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K586173596.pas"
// Стереотип: "TestCase"
// Элемент модели: "K586173596" MUID: (54C646E4015A)
// Имя типа: "TK586173596"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , HTMLtoEVDTest
;

type
 TK586173596 = class(THTMLtoEVDTest)
  {* [Requestlink:586173596] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK586173596
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *54C646E4015Aimpl_uses*
 //#UC END# *54C646E4015Aimpl_uses*
;

function TK586173596.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK586173596.GetFolder

function TK586173596.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '54C646E4015A';
end;//TK586173596.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK586173596.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
