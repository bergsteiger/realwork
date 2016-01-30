{$IfNDef vcmChromeLikeTabUpdater_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabUpdater.imp.pas"
// Стереотип: "Impurity"

{$Define vcmChromeLikeTabUpdater_imp}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 _vcmChromeLikeTabUpdater_ = class(_vcmChromeLikeTabUpdater_Parent_, IvcmFormSetIconProvider)
  private
   f_LastUpdatedUserType: TvcmUserType;
   f_WasUpdate: Boolean;
   f_LastUpdatedCaption: IvcmCString;
  protected
   function DoGetFormSetImageIndex: Integer; virtual; abstract;
   procedure UpdateChromeLikeTab;
   function NeedUpdateChromeLikeTab: Boolean; virtual;
   function NeedUpdateChromeLikeTabCaption(const aCaption: IvcmCString): Boolean; virtual;
   procedure UpdateChromeLikeTabCaption(const aCaption: IvcmCString);
   function pm_GetFormSetImageIndex: Integer;
   function pm_GetCanDefineFormSetIcon: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   function InsertForm(const aForm: IvcmEntityForm): Boolean; override;
 end;//_vcmChromeLikeTabUpdater_

{$Else NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}

_vcmChromeLikeTabUpdater_ = _vcmChromeLikeTabUpdater_Parent_;

{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
{$Else vcmChromeLikeTabUpdater_imp}

{$IfNDef vcmChromeLikeTabUpdater_imp_impl}

{$Define vcmChromeLikeTabUpdater_imp_impl}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53B6495D0309_var*
//#UC END# *479731C50290_53B6495D0309_var*
begin
//#UC START# *479731C50290_53B6495D0309_impl*
 f_LastUpdatedCaption := nil;
 inherited;
//#UC END# *479731C50290_53B6495D0309_impl*
end;//_vcmChromeLikeTabUpdater_.Cleanup

procedure _vcmChromeLikeTabUpdater_.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
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
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$EndIf vcmChromeLikeTabUpdater_imp_impl}

{$EndIf vcmChromeLikeTabUpdater_imp}

