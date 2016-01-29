{$IfNDef vcmChromeLikeTabUpdater_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmChromeLikeTabUpdater.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmChromeLikeTabUpdater
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmChromeLikeTabUpdater_imp}
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
 _vcmChromeLikeTabUpdater_ = {mixin} class(_vcmChromeLikeTabUpdater_Parent_, IvcmFormSetIconProvider)
 private
 // private fields
   f_LastUpdatedUserType : TvcmUserType;
   f_WasUpdate : Boolean;
   f_LastUpdatedCaption : IvcmCString;
 protected
 // realized methods
   function pm_GetFormSetImageIndex: Integer;
   function pm_GetCanDefineFormSetIcon: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   function InsertForm(const aForm: IvcmEntityForm): Boolean; override;
 protected
 // protected methods
   function DoGetFormSetImageIndex: Integer; virtual; abstract;
   procedure UpdateChromeLikeTab;
   function NeedUpdateChromeLikeTab: Boolean; virtual;
   function NeedUpdateChromeLikeTabCaption(const aCaption: IvcmCString): Boolean; virtual;
   procedure UpdateChromeLikeTabCaption(const aCaption: IvcmCString);
 end;//_vcmChromeLikeTabUpdater_
{$Else}

 _vcmChromeLikeTabUpdater_ = _vcmChromeLikeTabUpdater_Parent_;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$Else vcmChromeLikeTabUpdater_imp}

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class _vcmChromeLikeTabUpdater_

procedure _vcmChromeLikeTabUpdater_.UpdateChromeLikeTab;
//#UC START# *53B6800D01AC_53B6495D0309_var*
//#UC END# *53B6800D01AC_53B6495D0309_var*
begin
//#UC START# *53B6800D01AC_53B6495D0309_impl*
 {$If not defined(Admin) AND not defined(Monitorings)}
 if NeedUpdateChromeLikeTab then
 begin
  TvcmTabbedContainerFormDispatcher.Instance.UpdateTab(As_IvcmEntityForm);
  f_LastUpdatedUserType := UserType;
  f_WasUpdate := True;
 end;
 {$IfEnd}
//#UC END# *53B6800D01AC_53B6495D0309_impl*
end;//_vcmChromeLikeTabUpdater_.UpdateChromeLikeTab

function _vcmChromeLikeTabUpdater_.NeedUpdateChromeLikeTab: Boolean;
//#UC START# *53B6803301BD_53B6495D0309_var*
//#UC END# *53B6803301BD_53B6495D0309_var*
begin
//#UC START# *53B6803301BD_53B6495D0309_impl*
 {$If not defined(Admin) AND not defined(Monitorings)}
 Result := (TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs) AND
  ((f_LastUpdatedUserType <> UserType) OR (not f_WasUpdate));
 {$Else not defined(Admin) AND not defined(Monitorings)}
 Result := False;
 {$IfEnd}
//#UC END# *53B6803301BD_53B6495D0309_impl*
end;//_vcmChromeLikeTabUpdater_.NeedUpdateChromeLikeTab

function _vcmChromeLikeTabUpdater_.NeedUpdateChromeLikeTabCaption(const aCaption: IvcmCString): Boolean;
//#UC START# *53BCF20B013C_53B6495D0309_var*
//#UC END# *53BCF20B013C_53B6495D0309_var*
begin
//#UC START# *53BCF20B013C_53B6495D0309_impl*
 {$If not defined(Admin) AND not defined(Monitorings)}
 Result := (f_LastUpdatedCaption = nil) OR
  l3IsNil(f_LastUpdatedCaption) OR
  (not l3Same(f_LastUpdatedCaption, aCaption, True));
 {$Else not defined(Admin) AND not defined(Monitorings)}
 Result := False;
 {$IfEnd}
//#UC END# *53BCF20B013C_53B6495D0309_impl*
end;//_vcmChromeLikeTabUpdater_.NeedUpdateChromeLikeTabCaption

procedure _vcmChromeLikeTabUpdater_.UpdateChromeLikeTabCaption(const aCaption: IvcmCString);
//#UC START# *53BCF25E00F4_53B6495D0309_var*
//#UC END# *53BCF25E00F4_53B6495D0309_var*
begin
//#UC START# *53BCF25E00F4_53B6495D0309_impl*
 {$If not defined(Admin) AND not defined(Monitorings)}
 if NeedUpdateChromeLikeTabCaption(aCaption) then
 begin
  TvcmTabbedContainerFormDispatcher.Instance.UpdateTabCaption(As_IvcmEntityForm,
   aCaption);
  f_LastUpdatedCaption := aCaption;
 end;
 {$IfEnd}
//#UC END# *53BCF25E00F4_53B6495D0309_impl*
end;//_vcmChromeLikeTabUpdater_.UpdateChromeLikeTabCaption

function _vcmChromeLikeTabUpdater_.pm_GetFormSetImageIndex: Integer;
//#UC START# *53B649240001_53B6495D0309get_var*
//#UC END# *53B649240001_53B6495D0309get_var*
begin
//#UC START# *53B649240001_53B6495D0309get_impl*
 Result := DoGetFormSetImageIndex;
//#UC END# *53B649240001_53B6495D0309get_impl*
end;//_vcmChromeLikeTabUpdater_.pm_GetFormSetImageIndex

function _vcmChromeLikeTabUpdater_.pm_GetCanDefineFormSetIcon: Boolean;
//#UC START# *54460951001B_53B6495D0309get_var*
//#UC END# *54460951001B_53B6495D0309get_var*
begin
//#UC START# *54460951001B_53B6495D0309get_impl*
 Result := True;
//#UC END# *54460951001B_53B6495D0309get_impl*
end;//_vcmChromeLikeTabUpdater_.pm_GetCanDefineFormSetIcon

procedure _vcmChromeLikeTabUpdater_.Cleanup;
//#UC START# *479731C50290_53B6495D0309_var*
//#UC END# *479731C50290_53B6495D0309_var*
begin
//#UC START# *479731C50290_53B6495D0309_impl*
 f_LastUpdatedCaption := nil;
 inherited;
//#UC END# *479731C50290_53B6495D0309_impl*
end;//_vcmChromeLikeTabUpdater_.Cleanup

procedure _vcmChromeLikeTabUpdater_.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_53B6495D0309_var*
//#UC END# *49803F5503AA_53B6495D0309_var*
begin
//#UC START# *49803F5503AA_53B6495D0309_impl*
 inherited;
 f_LastUpdatedUserType := vcm_utAny;
 f_WasUpdate := False;
 f_LastUpdatedCaption := nil;
//#UC END# *49803F5503AA_53B6495D0309_impl*
end;//_vcmChromeLikeTabUpdater_.DoInit

function _vcmChromeLikeTabUpdater_.InsertForm(const aForm: IvcmEntityForm): Boolean;
//#UC START# *4AD44CA20001_53B6495D0309_var*
//#UC END# *4AD44CA20001_53B6495D0309_var*
begin
//#UC START# *4AD44CA20001_53B6495D0309_impl*
 Result := inherited InsertForm(aForm);
 {$If not defined(Admin) AND not defined(Monitorings)}
 if Result then
  UpdateChromeLikeTab;
 {$IfEnd}  
//#UC END# *4AD44CA20001_53B6495D0309_impl*
end;//_vcmChromeLikeTabUpdater_.InsertForm

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$EndIf vcmChromeLikeTabUpdater_imp}
