unit K327821495;
 {* [RequestLink:327821495] }

// Модуль: "w:\common\components\rtl\Garant\Archi_Tests\K327821495.pas"
// Стереотип: "TestCase"
// Элемент модели: "K327821495" MUID: (4F1934B0037D)
// Имя типа: "TK327821495"

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , StgIndexTest
;

type
 TK327821495 = class(TStgIndexTest)
  {* [RequestLink:327821495] }
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK327821495
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 //#UC START# *4F1934B0037Dimpl_uses*
 //#UC END# *4F1934B0037Dimpl_uses*
;

function TK327821495.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'DBTests';
end;//TK327821495.GetFolder

function TK327821495.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4F1934B0037D';
end;//TK327821495.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK327821495.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
