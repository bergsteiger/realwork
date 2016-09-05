unit K255958998;
 {* [$255958998] }

// Модуль: "w:\common\components\rtl\Garant\Daily\K255958998.pas"
// Стереотип: "TestCase"
// Элемент модели: "K255958998" MUID: (4D7776F00162)
// Имя типа: "TK255958998"

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ComplexScrollParams
;

type
 TK255958998 = class(TComplexScrollParams)
  {* [$255958998] }
  protected
   function GetSubNumber(aFirst: Boolean): Integer; override;
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
 end;//TK255958998
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4D7776F00162impl_uses*
 //#UC END# *4D7776F00162impl_uses*
;

function TK255958998.GetSubNumber(aFirst: Boolean): Integer;
//#UC START# *4D7779F503A4_4D7776F00162_var*
//#UC END# *4D7779F503A4_4D7776F00162_var*
begin
//#UC START# *4D7779F503A4_4D7776F00162_impl*
 if aFirst then
  Result := 20021
 else
  Result := 10002
//#UC END# *4D7779F503A4_4D7776F00162_impl*
end;//TK255958998.GetSubNumber

function TK255958998.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := '7.7';
end;//TK255958998.GetFolder

function TK255958998.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '4D7776F00162';
end;//TK255958998.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK255958998.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
