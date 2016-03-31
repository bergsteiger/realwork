{$IfNDef GUIAppTester_imp}

// Модуль: "w:\common\components\rtl\Garant\Shared_Delphi_Tests_Common\GUIAppTester.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "GUIAppTester" MUID: (52F21A610247)
// Имя типа: "_GUIAppTester_"

{$Define GUIAppTester_imp}

{$If Defined(nsTest)}
 _GUIAppTester_ = {abstract} class(_GUIAppTester_Parent_)
  {* Базовый тестер GUI-приложений }
  private
   class procedure DoIdle(Sender: TObject;
    var Done: Boolean);
  protected
   class function CalcBatchMode: Boolean; virtual; abstract;
  public
   {$If Defined(InsiderTest)}
   class function IsBatchMode: Boolean;
   {$IfEnd} // Defined(InsiderTest)
   class procedure ReadyToRun;
    {* Вызывается непосредственно перед запуском приложения, например для инициализации/запуска тестов }
 end;//_GUIAppTester_

{$Else Defined(nsTest)}

_GUIAppTester_ = _GUIAppTester_Parent_;

{$IfEnd} // Defined(nsTest)
{$Else GUIAppTester_imp}

{$IfNDef GUIAppTester_imp_impl}

{$Define GUIAppTester_imp_impl}

{$If Defined(nsTest)}
var g_IsBatchMode: Boolean = False;
var g_IsBatchModeValid: Boolean = False;
var g_Debugger: TtfwScriptDebugger_Form;
var g_TestsForm: TGUITestRunner;
var g_InRun: Boolean = False;

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

{$If Defined(InsiderTest)}
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
{$IfEnd} // Defined(InsiderTest)

class procedure _GUIAppTester_.ReadyToRun;
 {* Вызывается непосредственно перед запуском приложения, например для инициализации/запуска тестов }
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
{$IfEnd} // Defined(nsTest)

{$EndIf GUIAppTester_imp_impl}

{$EndIf GUIAppTester_imp}

