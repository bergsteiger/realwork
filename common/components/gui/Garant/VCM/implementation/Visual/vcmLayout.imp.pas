{$IfNDef vcmLayout_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmLayout.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM$Visual::Layouts::vcmLayout
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmLayout_imp}
{$If not defined(NoVCM)}
 _vcmLayout_ = {abstract mixin} class(_vcmLayout_Parent_)
 protected
 // protected methods
   procedure MakeControls; virtual;
   procedure InitEntities; virtual;
     {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
     const aNew: IvcmFormDataSource); virtual;
   procedure SetControlsResources; virtual;
     {* Установить контролам ресурсы для интернационализации }
   procedure EntitiesInited; virtual;
     {* Вызывается после того как все операции зарегистрированы }
   procedure InitControls; virtual;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); virtual;
     {* Изменился источник данных. Для перекрытия в потомках }
 public
 // public methods
   function GetIsMainObjectForm: Boolean; virtual;
 end;//_vcmLayout_
{$Else}

 _vcmLayout_ = _vcmLayout_Parent_;

{$IfEnd} //not NoVCM

{$Else vcmLayout_imp}

{$If not defined(NoVCM)}

// start class _vcmLayout_

procedure _vcmLayout_.MakeControls;
//#UC START# *500004A60200_500004240202_var*
//#UC END# *500004A60200_500004240202_var*
begin
//#UC START# *500004A60200_500004240202_impl*
//#UC END# *500004A60200_500004240202_impl*
end;//_vcmLayout_.MakeControls

procedure _vcmLayout_.InitEntities;
//#UC START# *5000105E028C_500004240202_var*
//#UC END# *5000105E028C_500004240202_var*
begin
//#UC START# *5000105E028C_500004240202_impl*
//#UC END# *5000105E028C_500004240202_impl*
end;//_vcmLayout_.InitEntities

procedure _vcmLayout_.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
  const aNew: IvcmFormDataSource);
//#UC START# *5000109C01F9_500004240202_var*
//#UC END# *5000109C01F9_500004240202_var*
begin
//#UC START# *5000109C01F9_500004240202_impl*
//#UC END# *5000109C01F9_500004240202_impl*
end;//_vcmLayout_.SignalDataSourceChanged

function _vcmLayout_.GetIsMainObjectForm: Boolean;
//#UC START# *501174B10018_500004240202_var*
//#UC END# *501174B10018_500004240202_var*
begin
//#UC START# *501174B10018_500004240202_impl*
 Result := (_Instance_R_(Self).ZoneType = vcm_ztParent);
//#UC END# *501174B10018_500004240202_impl*
end;//_vcmLayout_.GetIsMainObjectForm

procedure _vcmLayout_.SetControlsResources;
//#UC START# *4B62D10B031B_500004240202_var*
//#UC END# *4B62D10B031B_500004240202_var*
begin
//#UC START# *4B62D10B031B_500004240202_impl*
//#UC END# *4B62D10B031B_500004240202_impl*
end;//_vcmLayout_.SetControlsResources

procedure _vcmLayout_.EntitiesInited;
//#UC START# *4AE1948900DE_500004240202_var*
//#UC END# *4AE1948900DE_500004240202_var*
begin
//#UC START# *4AE1948900DE_500004240202_impl*
//#UC END# *4AE1948900DE_500004240202_impl*
end;//_vcmLayout_.EntitiesInited

procedure _vcmLayout_.InitControls;
//#UC START# *4A8E8F2E0195_500004240202_var*
//#UC END# *4A8E8F2E0195_500004240202_var*
begin
//#UC START# *4A8E8F2E0195_500004240202_impl*
//#UC END# *4A8E8F2E0195_500004240202_impl*
end;//_vcmLayout_.InitControls

procedure _vcmLayout_.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_500004240202_var*
//#UC END# *497469C90140_500004240202_var*
begin
//#UC START# *497469C90140_500004240202_impl*
//#UC END# *497469C90140_500004240202_impl*
end;//_vcmLayout_.NotifyDataSourceChanged

{$IfEnd} //not NoVCM

{$EndIf vcmLayout_imp}
