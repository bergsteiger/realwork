{$IfNDef vcmChromeLikeTabIconUpdater_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmChromeLikeTabIconUpdater.imp.pas"
// Стереотип: "Impurity"

{$Define vcmChromeLikeTabIconUpdater_imp}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
 _vcmChromeLikeTabIconUpdater_ = class(_vcmChromeLikeTabIconUpdater_Parent_, IvcmFormSetIconProvider)
  protected
   function DoGetTabImageIndex: Integer; virtual;
   procedure UpdateTabIcon;
   function DoGetCanDefineFormSetIcon: Boolean; virtual;
   function pm_GetFormSetImageIndex: Integer;
   function pm_GetCanDefineFormSetIcon: Boolean;
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   procedure FormInsertedIntoContainer; override;
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
 end;//_vcmChromeLikeTabIconUpdater_

{$Else NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}

_vcmChromeLikeTabIconUpdater_ = _vcmChromeLikeTabIconUpdater_Parent_;

{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)
{$Else vcmChromeLikeTabIconUpdater_imp}

{$IfNDef vcmChromeLikeTabIconUpdater_imp_impl}

{$Define vcmChromeLikeTabIconUpdater_imp_impl}

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
function _vcmChromeLikeTabIconUpdater_.DoGetTabImageIndex: Integer;
//#UC START# *543E3AA801D0_543E3A600253_var*
//#UC END# *543E3AA801D0_543E3A600253_var*
begin
//#UC START# *543E3AA801D0_543E3A600253_impl*
 Result := 0;
//#UC END# *543E3AA801D0_543E3A600253_impl*
end;//_vcmChromeLikeTabIconUpdater_.DoGetTabImageIndex

procedure _vcmChromeLikeTabIconUpdater_.UpdateTabIcon;
//#UC START# *543E466602DF_543E3A600253_var*
//#UC END# *543E466602DF_543E3A600253_var*
begin
//#UC START# *543E466602DF_543E3A600253_impl*
 TvcmTabbedContainerFormDispatcher.Instance.UpdateFormTabIcon(Self);
//#UC END# *543E466602DF_543E3A600253_impl*
end;//_vcmChromeLikeTabIconUpdater_.UpdateTabIcon

function _vcmChromeLikeTabIconUpdater_.DoGetCanDefineFormSetIcon: Boolean;
//#UC START# *544609B9032D_543E3A600253_var*
//#UC END# *544609B9032D_543E3A600253_var*
begin
//#UC START# *544609B9032D_543E3A600253_impl*
 Result := True;
//#UC END# *544609B9032D_543E3A600253_impl*
end;//_vcmChromeLikeTabIconUpdater_.DoGetCanDefineFormSetIcon

function _vcmChromeLikeTabIconUpdater_.pm_GetFormSetImageIndex: Integer;
//#UC START# *53B649240001_543E3A600253get_var*
//#UC END# *53B649240001_543E3A600253get_var*
begin
//#UC START# *53B649240001_543E3A600253get_impl*
 Result := DoGetTabImageIndex;
//#UC END# *53B649240001_543E3A600253get_impl*
end;//_vcmChromeLikeTabIconUpdater_.pm_GetFormSetImageIndex

function _vcmChromeLikeTabIconUpdater_.pm_GetCanDefineFormSetIcon: Boolean;
//#UC START# *54460951001B_543E3A600253get_var*
//#UC END# *54460951001B_543E3A600253get_var*
begin
//#UC START# *54460951001B_543E3A600253get_impl*
 Result := DoGetCanDefineFormSetIcon;
//#UC END# *54460951001B_543E3A600253get_impl*
end;//_vcmChromeLikeTabIconUpdater_.pm_GetCanDefineFormSetIcon

procedure _vcmChromeLikeTabIconUpdater_.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_543E3A600253_var*
//#UC END# *49803F5503AA_543E3A600253_var*
begin
//#UC START# *49803F5503AA_543E3A600253_impl*
 inherited;
 UpdateTabIcon;
//#UC END# *49803F5503AA_543E3A600253_impl*
end;//_vcmChromeLikeTabIconUpdater_.DoInit

procedure _vcmChromeLikeTabIconUpdater_.FormInsertedIntoContainer;
//#UC START# *4F7C65380244_543E3A600253_var*
//#UC END# *4F7C65380244_543E3A600253_var*
begin
//#UC START# *4F7C65380244_543E3A600253_impl*
 inherited;
 UpdateTabIcon;
//#UC END# *4F7C65380244_543E3A600253_impl*
end;//_vcmChromeLikeTabIconUpdater_.FormInsertedIntoContainer

procedure _vcmChromeLikeTabIconUpdater_.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
//#UC START# *5000109C01F9_543E3A600253_var*
//#UC END# *5000109C01F9_543E3A600253_var*
begin
//#UC START# *5000109C01F9_543E3A600253_impl*
 inherited;
 if (not VCMClosing) and (aNew <> nil) then
  UpdateTabIcon;
//#UC END# *5000109C01F9_543E3A600253_impl*
end;//_vcmChromeLikeTabIconUpdater_.SignalDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

{$EndIf vcmChromeLikeTabIconUpdater_imp_impl}

{$EndIf vcmChromeLikeTabIconUpdater_imp}

