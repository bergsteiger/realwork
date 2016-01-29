unit ExcludedTests;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnitTuning"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/DUnitTuning/ExcludedTests.pas"
// Начат: 19.0.2010 18:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Testing Framework::DUnitTuning::Source::TExcludedTests
//
// Тесты, которые не надо запускать - [$227477825].
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3StringList
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
type
 TExcludedTests = class(Tl3StringList)
  {* Тесты, которые не надо запускать - [$227477825]. }
 public
 // public methods
   class function Exists: Boolean;
     {* Определяет создан ли экземпляр синглетона }
 public
 // singleton factory method
   class function Instance: TExcludedTests;
    {- возвращает экземпляр синглетона. }
 end;//TExcludedTests
{$IfEnd} //nsTest AND not NotTunedDUnit

implementation

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  l3Base {a}
  ;
{$IfEnd} //nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(NotTunedDUnit)}


// start class TExcludedTests

var g_TExcludedTests : TExcludedTests = nil;

procedure TExcludedTestsFree;
begin
 l3Free(g_TExcludedTests);
end;

class function TExcludedTests.Instance: TExcludedTests;
begin
 if (g_TExcludedTests = nil) then
 begin
  l3System.AddExitProc(TExcludedTestsFree);
  g_TExcludedTests := Create;
 end;
 Result := g_TExcludedTests;
end;


class function TExcludedTests.Exists: Boolean;
//#UC START# *4C446BAE00A3_4C44675A0269_var*
//#UC END# *4C446BAE00A3_4C44675A0269_var*
begin
//#UC START# *4C446BAE00A3_4C44675A0269_impl*
 Result := (g_TExcludedTests <> nil);
//#UC END# *4C446BAE00A3_4C44675A0269_impl*
end;//TExcludedTests.Exists

{$IfEnd} //nsTest AND not NotTunedDUnit

end.