{$IfNDef ListTest_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBoxTest"
// Модуль: "ListTest.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: TestCaseMixIn::Class Shared Delphi Sand Box::SandBoxTest::FinalContainersTests::ListTest
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define ListTest_imp}
{$If defined(nsTest)}
 _ListTest_ = class(TTestCase)
 protected
 // protected methods
   function CreateList: _ListType_;
     {* Создаёт список для тестирования }
 end;//_ListTest_
{$Else}

 _ListTest_ = TTestCase;

{$IfEnd} //nsTest

{$Else ListTest_imp}

{$If defined(nsTest)}

// start class _ListTest_

function _ListTest_.CreateList: _ListType_;
//#UC START# *51E80E0D030D_51E80DD30125_var*
//#UC END# *51E80E0D030D_51E80DD30125_var*
begin
//#UC START# *51E80E0D030D_51E80DD30125_impl*
 Result := _ListType_.Create;
//#UC END# *51E80E0D030D_51E80DD30125_impl*
end;//_ListTest_.CreateList

{$IfEnd} //nsTest

{$EndIf ListTest_imp}
