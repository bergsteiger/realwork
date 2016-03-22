{$IfNDef ListTest_imp}

// Модуль: "w:\common\components\SandBox\ListTest.imp.pas"
// Стереотип: "TestCaseMixIn"
// Элемент модели: "ListTest" MUID: (51E80DD30125)
// Имя типа: "_ListTest_"

{$Define ListTest_imp}

{$If Defined(nsTest)}
 _ListTest_ = class(TTestCase)
  protected
   function CreateList: _ListType_;
 end;//_ListTest_

{$Else Defined(nsTest)}

_ListTest_ = TTestCase;

{$IfEnd} // Defined(nsTest)
{$Else ListTest_imp}

{$IfNDef ListTest_imp_impl}

{$Define ListTest_imp_impl}

{$If Defined(nsTest)}
function _ListTest_.CreateList: _ListType_;
//#UC START# *51E80E0D030D_51E80DD30125_var*
//#UC END# *51E80E0D030D_51E80DD30125_var*
begin
//#UC START# *51E80E0D030D_51E80DD30125_impl*
 Result := _ListType_.Create;
//#UC END# *51E80E0D030D_51E80DD30125_impl*
end;//_ListTest_.CreateList
{$IfEnd} // Defined(nsTest)

{$EndIf ListTest_imp_impl}

{$EndIf ListTest_imp}

