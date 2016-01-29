unit NOT_FINISHED_vcmMainForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/NOT_FINISHED_vcmMainForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmMainForm
//
// Базовый класс для главной формы приложения построенного на библиотеке vcm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  afwInterfaces,
  vcmInterfaces,
  vcmMainFormModelPart,
  Messages
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _vcmComponentDestroyer_Parent_ = TvcmMainFormModelPart;
 {$Include ..\Visual\vcmComponentDestroyer.imp.pas}
 TvcmMainForm = class(_vcmComponentDestroyer_, IafwMainForm, IvcmContainerMaker)
  {* Базовый класс для главной формы приложения построенного на библиотеке vcm }
 protected
 // realized methods
   function pm_GetStatusBar: IafwStatusBar;
   procedure pm_SetStatusBar(const aValue: IafwStatusBar);
   function pm_GetStatus: IafwStatus;
   procedure pm_SetStatus(const aValue: IafwStatus);
   function MakeContainer: IvcmContainer;
 protected
 // protected methods
   function DoMakeClone(aNeedShow: Boolean): TvcmMainForm; virtual;
   procedure BecomeMainForm; virtual;
   function LimitOpenedWindowsCount: Boolean; virtual;
   procedure UpdateMainCaption; virtual;
   procedure DoExitApplication; virtual;
 end;//TvcmMainForm
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  vcmIEntityList,
  vcmMainFormRes,
  vcmDockManagerList,
  vcmLockListenerList,
  vcmFormDispatcherListenerList
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  vcmMenuManager,
  vcmFormsUtils
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  ,
  SysUtils,
  vcmEntityForm,
  vcmForm,
  vcmMessages
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

type _Instance_R_ = TvcmMainForm;

{$Include ..\Visual\vcmComponentDestroyer.imp.pas}

// start class TvcmMainForm

function TvcmMainForm.DoMakeClone(aNeedShow: Boolean): TvcmMainForm;
//#UC START# *537DB1C100A8_49525C7A0114_var*
//#UC END# *537DB1C100A8_49525C7A0114_var*
begin
//#UC START# *537DB1C100A8_49525C7A0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *537DB1C100A8_49525C7A0114_impl*
end;//TvcmMainForm.DoMakeClone

procedure TvcmMainForm.BecomeMainForm;
//#UC START# *5385908301A7_49525C7A0114_var*
//#UC END# *5385908301A7_49525C7A0114_var*
begin
//#UC START# *5385908301A7_49525C7A0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *5385908301A7_49525C7A0114_impl*
end;//TvcmMainForm.BecomeMainForm

function TvcmMainForm.LimitOpenedWindowsCount: Boolean;
//#UC START# *53AD2E740057_49525C7A0114_var*
//#UC END# *53AD2E740057_49525C7A0114_var*
begin
//#UC START# *53AD2E740057_49525C7A0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AD2E740057_49525C7A0114_impl*
end;//TvcmMainForm.LimitOpenedWindowsCount

procedure TvcmMainForm.UpdateMainCaption;
//#UC START# *53BCE11B01BB_49525C7A0114_var*
//#UC END# *53BCE11B01BB_49525C7A0114_var*
begin
//#UC START# *53BCE11B01BB_49525C7A0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *53BCE11B01BB_49525C7A0114_impl*
end;//TvcmMainForm.UpdateMainCaption

procedure TvcmMainForm.DoExitApplication;
//#UC START# *53C6123F0050_49525C7A0114_var*
//#UC END# *53C6123F0050_49525C7A0114_var*
begin
//#UC START# *53C6123F0050_49525C7A0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *53C6123F0050_49525C7A0114_impl*
end;//TvcmMainForm.DoExitApplication

function TvcmMainForm.pm_GetStatusBar: IafwStatusBar;
//#UC START# *473D96130328_49525C7A0114get_var*
//#UC END# *473D96130328_49525C7A0114get_var*
begin
//#UC START# *473D96130328_49525C7A0114get_impl*
 !!! Needs to be implemented !!!
//#UC END# *473D96130328_49525C7A0114get_impl*
end;//TvcmMainForm.pm_GetStatusBar

procedure TvcmMainForm.pm_SetStatusBar(const aValue: IafwStatusBar);
//#UC START# *473D96130328_49525C7A0114set_var*
//#UC END# *473D96130328_49525C7A0114set_var*
begin
//#UC START# *473D96130328_49525C7A0114set_impl*
 !!! Needs to be implemented !!!
//#UC END# *473D96130328_49525C7A0114set_impl*
end;//TvcmMainForm.pm_SetStatusBar

function TvcmMainForm.pm_GetStatus: IafwStatus;
//#UC START# *473D968101D2_49525C7A0114get_var*
//#UC END# *473D968101D2_49525C7A0114get_var*
begin
//#UC START# *473D968101D2_49525C7A0114get_impl*
 !!! Needs to be implemented !!!
//#UC END# *473D968101D2_49525C7A0114get_impl*
end;//TvcmMainForm.pm_GetStatus

procedure TvcmMainForm.pm_SetStatus(const aValue: IafwStatus);
//#UC START# *473D968101D2_49525C7A0114set_var*
//#UC END# *473D968101D2_49525C7A0114set_var*
begin
//#UC START# *473D968101D2_49525C7A0114set_impl*
 !!! Needs to be implemented !!!
//#UC END# *473D968101D2_49525C7A0114set_impl*
end;//TvcmMainForm.pm_SetStatus

function TvcmMainForm.MakeContainer: IvcmContainer;
//#UC START# *53ABACBB02D0_49525C7A0114_var*
//#UC END# *53ABACBB02D0_49525C7A0114_var*
begin
//#UC START# *53ABACBB02D0_49525C7A0114_impl*
 !!! Needs to be implemented !!!
//#UC END# *53ABACBB02D0_49525C7A0114_impl*
end;//TvcmMainForm.MakeContainer

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmMainForm
 TtfwClassRef.Register(TvcmMainForm);
{$IfEnd} //not NoScripts AND not NoVCM

end.