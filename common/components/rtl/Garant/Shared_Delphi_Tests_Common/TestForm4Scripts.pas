unit TestForm4Scripts;

// Модуль: "w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\TestForm4Scripts.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "TestForm4Scripts" MUID: (51349B6001D3)

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , GUITestRunner
;

procedure LinkTestForm(const aForm: TGUITestRunner);
procedure UnLinkTestForm;
function GetTestForm: TGUITestRunner;
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 //#UC START# *51349B6001D3impl_uses*
 //#UC END# *51349B6001D3impl_uses*
;

var g_TestsForm: TGUITestRunner;

procedure LinkTestForm(const aForm: TGUITestRunner);
//#UC START# *51349D1803A7_51349B6001D3_var*
//#UC END# *51349D1803A7_51349B6001D3_var*
begin
//#UC START# *51349D1803A7_51349B6001D3_impl*
 g_TestsForm := aForm;
//#UC END# *51349D1803A7_51349B6001D3_impl*
end;//LinkTestForm

procedure UnLinkTestForm;
//#UC START# *51349D2D0187_51349B6001D3_var*
//#UC END# *51349D2D0187_51349B6001D3_var*
begin
//#UC START# *51349D2D0187_51349B6001D3_impl*
 g_TestsForm := nil;
//#UC END# *51349D2D0187_51349B6001D3_impl*
end;//UnLinkTestForm

function GetTestForm: TGUITestRunner;
//#UC START# *51349D4E02CB_51349B6001D3_var*
//#UC END# *51349D4E02CB_51349B6001D3_var*
begin
//#UC START# *51349D4E02CB_51349B6001D3_impl*
 Result := g_TestsForm;
//#UC END# *51349D4E02CB_51349B6001D3_impl*
end;//GetTestForm
{$IfEnd} // Defined(nsTest)

end.
