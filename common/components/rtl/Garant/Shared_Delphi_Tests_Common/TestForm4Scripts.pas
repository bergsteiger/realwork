unit TestForm4Scripts;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Shared Delphi Tests Common"
// Модуль: "w:/common/components/rtl/Garant/Shared_Delphi_Tests_Common/TestForm4Scripts.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Testing Framework::Shared Delphi Tests Common::Tests Res Common::TestForm4Scripts
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(nsTest)}
uses
  GUITestRunner
  ;

procedure LinkTestForm(const aForm: TGUITestRunner);
procedure UnLinkTestForm;
function GetTestForm: TGUITestRunner;
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
var g_TestsForm : TGUITestRunner;

// unit methods

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
{$IfEnd} //nsTest

end.