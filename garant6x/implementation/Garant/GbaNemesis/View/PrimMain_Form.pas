unit PrimMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimMain_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimF1::PrimMain
//
// Главная форма. Общая для всех приложений F1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3StringIDEx,
  l3MessageID,
  MainPrim_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;

var
  { Локализуемые строки Local }
 str_MayExit : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'MayExit'; rValue : 'Вы уверены, что хотите закрыть систему %s?');
  { 'Вы уверены, что хотите закрыть систему %s?' }
 str_ApplicationName : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ApplicationName'; rValue : 'ГАРАНТ');
  { 'ГАРАНТ' }
 str_MayExit_CheckCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_CheckCaption'; rValue : 'Всегда выходить без подтверждения');
  { undefined }
 str_MayExit_SettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_SettingsCaption'; rValue : 'Выход из системы');
  { undefined }
 str_MayExit_LongHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_LongHint'; rValue : 'Подтверждение при выходе из системы');
  { undefined }

type
 TPrimMainForm = {form} class(TMainPrimForm)
  {* Главная форма. Общая для всех приложений F1 }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function NeedTerminateOnExit: Boolean; override;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function AskMayExit: Boolean; override;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCL)}
   procedure DoShow; override;
   {$IfEnd} //not NoVCL
   procedure ActivateDefKeyboardLayout; override;
 end;//TPrimMainForm

implementation

uses
  DataAdapter
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  F1Like_FormDefinitions_Controls,
  nsCustomStyleProcessor
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;

var
   { Варианты выбора для диалога MayExit }
  str_MayExit_Choice_Exit : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_Choice_Exit'; rValue : 'Выйти');
   { 'Выйти' }
  str_MayExit_Choice_Stay : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_Choice_Stay'; rValue : 'Продолжить работу');
   { 'Продолжить работу' }

// start class TPrimMainForm

{$If not defined(NoVCM)}
procedure TPrimMainForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4A92BD85004D_var*
//#UC END# *49803F5503AA_4A92BD85004D_var*
begin
//#UC START# *49803F5503AA_4A92BD85004D_impl*
 inherited;
//#UC END# *49803F5503AA_4A92BD85004D_impl*
end;//TPrimMainForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimMainForm.NeedTerminateOnExit: Boolean;
//#UC START# *4ADDD31E0091_4A92BD85004D_var*
//#UC END# *4ADDD31E0091_4A92BD85004D_var*
begin
//#UC START# *4ADDD31E0091_4A92BD85004D_impl*
 {$IfNDef nsWithoutLogin}
 Result := not defDataAdapter.Authorization.IsServerAlive;
 {$Else   nsWithoutLogin}
 Result := false;
 {$EndIf  nsWithoutLogin}
//#UC END# *4ADDD31E0091_4A92BD85004D_impl*
end;//TPrimMainForm.NeedTerminateOnExit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimMainForm.AskMayExit: Boolean;
//#UC START# *4ADDD5A30139_4A92BD85004D_var*
//#UC END# *4ADDD5A30139_4A92BD85004D_var*
begin
//#UC START# *4ADDD5A30139_4A92BD85004D_impl*
 Result := Ask(str_MayExit, [str_ApplicationName.AsCStr]);
//#UC END# *4ADDD5A30139_4A92BD85004D_impl*
end;//TPrimMainForm.AskMayExit
{$IfEnd} //not NoVCM

{$If not defined(NoVCL)}
procedure TPrimMainForm.DoShow;
//#UC START# *4B321D1301DD_4A92BD85004D_var*
//#UC END# *4B321D1301DD_4A92BD85004D_var*
begin
//#UC START# *4B321D1301DD_4A92BD85004D_impl*
 inherited;
//#UC END# *4B321D1301DD_4A92BD85004D_impl*
end;//TPrimMainForm.DoShow
{$IfEnd} //not NoVCL

procedure TPrimMainForm.ActivateDefKeyboardLayout;
//#UC START# *4F71FA8102BF_4A92BD85004D_var*
//#UC END# *4F71FA8102BF_4A92BD85004D_var*
begin
//#UC START# *4F71FA8102BF_4A92BD85004D_impl*
 inherited;
 defDataAdapter.ActivateDefKeyboardLayout;
//#UC END# *4F71FA8102BF_4A92BD85004D_impl*
end;//TPrimMainForm.ActivateDefKeyboardLayout

initialization
// Инициализация str_MayExit_Choice_Exit
 str_MayExit_Choice_Exit.Init;
// Инициализация str_MayExit_Choice_Stay
 str_MayExit_Choice_Stay.Init;
// Инициализация str_MayExit
 str_MayExit.Init;
 str_MayExit.AddChoice(str_MayExit_Choice_Exit);
 str_MayExit.AddChoice(str_MayExit_Choice_Stay);
 str_MayExit.AddDefaultChoice(str_MayExit_Choice_Exit);
 str_MayExit.SetDlgType(mtConfirmation);
 str_MayExit.SetNeedCheck(true);
 str_MayExit.SetCheckCaption(str_MayExit_CheckCaption);
 str_MayExit.SetSettingsCaption(str_MayExit_SettingsCaption);
 str_MayExit.SetLongHint(str_MayExit_LongHint);
// Инициализация str_ApplicationName
 str_ApplicationName.Init;
// Инициализация str_MayExit_CheckCaption
 str_MayExit_CheckCaption.Init;
// Инициализация str_MayExit_SettingsCaption
 str_MayExit_SettingsCaption.Init;
// Инициализация str_MayExit_LongHint
 str_MayExit_LongHint.Init;
{$If not defined(NoScripts)}
// Регистрация PrimMain
 TtfwClassRef.Register(TPrimMainForm);
{$IfEnd} //not NoScripts

end.