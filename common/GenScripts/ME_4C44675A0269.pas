unit ExcludedTests;
 {* Тесты, которые не надо запускать - [$227477825]. }

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\ExcludedTests.pas"
// Стереотип: "SimpleClass"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , l3StringList
;

type
 TExcludedTests = class(Tl3StringList)
  {* Тесты, которые не надо запускать - [$227477825]. }
  public
   class function Exists: Boolean;
    {* Определяет создан ли экземпляр синглетона }
   class function Instance: TExcludedTests;
    {* Метод получения экземпляра синглетона TExcludedTests }
 end;//TExcludedTests
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TExcludedTests: TExcludedTests = nil;
 {* Экземпляр синглетона TExcludedTests }

procedure TExcludedTestsFree;
 {* Метод освобождения экземпляра синглетона TExcludedTests }
begin
 l3Free(g_TExcludedTests);
end;//TExcludedTestsFree

class function TExcludedTests.Exists: Boolean;
 {* Определяет создан ли экземпляр синглетона }
//#UC START# *4C446BAE00A3_4C44675A0269_var*
//#UC END# *4C446BAE00A3_4C44675A0269_var*
begin
//#UC START# *4C446BAE00A3_4C44675A0269_impl*
 Result := (g_TExcludedTests <> nil);
//#UC END# *4C446BAE00A3_4C44675A0269_impl*
end;//TExcludedTests.Exists

class function TExcludedTests.Instance: TExcludedTests;
 {* Метод получения экземпляра синглетона TExcludedTests }
begin
 if (g_TExcludedTests = nil) then
 begin
  l3System.AddExitProc(TExcludedTestsFree);
  g_TExcludedTests := Create;
 end;
 Result := g_TExcludedTests;
end;//TExcludedTests.Instance
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

end.
