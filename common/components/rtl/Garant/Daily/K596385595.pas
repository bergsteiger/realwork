unit K596385595;
 {* [Requestlink:596385595] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K596385595.pas"
// Стереотип: "TestCase"
// Элемент модели: "K596385595" MUID: (55277147019D)
// Имя типа: "TK596385595"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , RTFtoEVDWriterTest
;

type
 TK596385595 = class(TRTFtoEVDWriterTest)
  {* [Requestlink:596385595] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK596385595
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *55277147019Dimpl_uses*
 //#UC END# *55277147019Dimpl_uses*
;

function TK596385595.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.11';
end;//TK596385595.GetFolder

function TK596385595.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '55277147019D';
end;//TK596385595.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK596385595.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
