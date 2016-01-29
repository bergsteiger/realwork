{$IfNDef vcmChromeLikeTabIconUpdater_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmChromeLikeTabIconUpdater.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmChromeLikeTabIconUpdater
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmChromeLikeTabIconUpdater_imp}
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
 _vcmChromeLikeTabIconUpdater_ = {mixin} class(_vcmChromeLikeTabIconUpdater_Parent_, IvcmFormSetIconProvider)
 protected
 // realized methods
   function pm_GetFormSetImageIndex: Integer;
   function pm_GetCanDefineFormSetIcon: Boolean;
 protected
 // overridden protected methods
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   procedure FormInsertedIntoContainer; override;
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
     const aNew: IvcmFormDataSource); override;
 protected
 // protected methods
   function DoGetTabImageIndex: Integer; virtual;
   procedure UpdateTabIcon;
   function DoGetCanDefineFormSetIcon: Boolean; virtual;
 end;//_vcmChromeLikeTabIconUpdater_
{$Else}

 _vcmChromeLikeTabIconUpdater_ = _vcmChromeLikeTabIconUpdater_Parent_;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$Else vcmChromeLikeTabIconUpdater_imp}

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class _vcmChromeLikeTabIconUpdater_

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

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$EndIf vcmChromeLikeTabIconUpdater_imp}
