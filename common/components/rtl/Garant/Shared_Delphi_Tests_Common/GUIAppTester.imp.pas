{$IfNDef GUIAppTester_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Shared Delphi Tests Common"
// Модуль: "w:/common/components/rtl/Garant/Shared_Delphi_Tests_Common/GUIAppTester.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Testing Framework::Shared Delphi Tests Common::Tests Res Common::GUIAppTester
//
// Базовый тестер GUI-приложений
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define GUIAppTester_imp}
{$If defined(nsTest)}
 _GUIAppTester_ = {abstract mixin} class(_GUIAppTester_Parent_)
  {* Базовый тестер GUI-приложений }
 private
 // private methods
   class procedure DoIdle(Sender: TObject;
     var Done: Boolean);
 protected
 // protected methods
   class function CalcBatchMode: Boolean; virtual; abstract;
 public
 // public methods
    {$If defined(InsiderTest) AND defined(nsTest)}
   class function IsBatchMode: Boolean;
    {$IfEnd} //InsiderTest AND nsTest
   class procedure ReadyToRun;
     {* Вызывается непосредственно перед запуском приложения, например для инициализации/запуска тестов }
 end;//_GUIAppTester_
{$Else}

 _GUIAppTester_ = _GUIAppTester_Parent_;

{$IfEnd} //nsTest

{$Else GUIAppTester_imp}

{$If defined(nsTest)}

var
   g_IsBatchMode : Boolean = false;
var
   g_IsBatchModeValid : Boolean = false;
var
   g_Debugger : TtfwScriptDebugger_Form;
var
   g_TestsForm : TGUITestRunner;
var
   g_InRun : Boolean = false;

// start class _GUIAppTester_

class procedure _GUIAppTester_.DoIdle(Sender: TObject;
  var Done: Boolean);
//#UC START# *4DA3361A0305_52F21A610247_var*
//#UC END# *4DA3361A0305_52F21A610247_var*
begin
//#UC START# *4DA3361A0305_52F21A610247_impl*
 if not g_InRun then
 begin
  g_InRun := true;
  try
   KTestRunner.RunRegisteredTests;
  except
   // - давим все исключения, чтобы нормально выйти
  end;//try..except
  Application.Terminate;
  l3System.ClearClipboard;
 end;//not g_InRun
//#UC END# *4DA3361A0305_52F21A610247_impl*
end;//_GUIAppTester_.DoIdle

{$If defined(InsiderTest) AND defined(nsTest)}
class function _GUIAppTester_.IsBatchMode: Boolean;
//#UC START# *4DA476580343_52F21A610247_var*
//#UC END# *4DA476580343_52F21A610247_var*
begin
//#UC START# *4DA476580343_52F21A610247_impl*
 if not g_IsBatchModeValid then
 begin
  g_IsBatchMode := CalcBatchMode;
  g_IsBatchModeValid := true;
 end;//not g_IsBatchModeValid
 Result := g_IsBatchMode;
//#UC END# *4DA476580343_52F21A610247_impl*
end;//_GUIAppTester_.IsBatchMode
{$IfEnd} //InsiderTest AND nsTest

class procedure _GUIAppTester_.ReadyToRun;
//#UC START# *4F79B9D500D7_52F21A610247_var*
//#UC END# *4F79B9D500D7_52F21A610247_var*
begin
//#UC START# *4F79B9D500D7_52F21A610247_impl*
 if IsBatchMode then
 begin
  Application.OnIdle := {_Instance_R_(dmStdRes)}Self.DoIdle;
  Tl3BatchService.Instance.EnterBatchMode;
 end//IsBatchMode
 else
 begin
  Application.CreateForm(TGUITestRunner, g_TestsForm);
  g_TestsForm.DisableClose := true;
  g_TestsForm.Suite := registeredTests;
  //g_TestsForm.FormStyle := fsStayOnTop;
  g_TestsForm.Show;
  g_TestsForm.LoadFormPlacement;
  Application.CreateForm(TtfwScriptDebugger_Form, g_Debugger);
  g_DebuggerForm := g_Debugger;
  g_TestsForm.ShowDebugForm;
 end;//IsBatchMode
//#UC END# *4F79B9D500D7_52F21A610247_impl*
end;//_GUIAppTester_.ReadyToRun

{$IfEnd} //nsTest

{$EndIf GUIAppTester_imp}
