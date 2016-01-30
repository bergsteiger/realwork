{$IfNDef vcmLayout_imp}

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmLayout.imp.pas"
// ���������: "Impurity"

{$Define vcmLayout_imp}

{$If NOT Defined(NoVCM)}
 _vcmLayout_ = {abstract} class(_vcmLayout_Parent_)
  protected
   procedure MakeControls; virtual;
   procedure InitEntities; virtual;
    {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); virtual;
   procedure SetControlsResources; virtual;
    {* ���������� ��������� ������� ��� ������������������� }
   procedure EntitiesInited; virtual;
    {* ���������� ����� ���� ��� ��� �������� ���������������� }
   procedure InitControls; virtual;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); virtual;
    {* ��������� �������� ������. ��� ���������� � �������� }
  public
   function GetIsMainObjectForm: Boolean; virtual;
 end;//_vcmLayout_

{$Else NOT Defined(NoVCM)}

_vcmLayout_ = _vcmLayout_Parent_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmLayout_imp}

{$IfNDef vcmLayout_imp_impl}

{$Define vcmLayout_imp_impl}

{$If NOT Defined(NoVCM)}
procedure _vcmLayout_.MakeControls;
//#UC START# *500004A60200_500004240202_var*
//#UC END# *500004A60200_500004240202_var*
begin
//#UC START# *500004A60200_500004240202_impl*
//#UC END# *500004A60200_500004240202_impl*
end;//_vcmLayout_.MakeControls

procedure _vcmLayout_.InitEntities;
 {* �������������� �������� �� �� dfm.
             ����� ��� ���������� ��������� ��� �������� VCM �� ������ }
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
 {* ���������� ��������� ������� ��� ������������������� }
//#UC START# *4B62D10B031B_500004240202_var*
//#UC END# *4B62D10B031B_500004240202_var*
begin
//#UC START# *4B62D10B031B_500004240202_impl*
//#UC END# *4B62D10B031B_500004240202_impl*
end;//_vcmLayout_.SetControlsResources

procedure _vcmLayout_.EntitiesInited;
 {* ���������� ����� ���� ��� ��� �������� ���������������� }
//#UC START# *4AE1948900DE_500004240202_var*
//#UC END# *4AE1948900DE_500004240202_var*
begin
//#UC START# *4AE1948900DE_500004240202_impl*
//#UC END# *4AE1948900DE_500004240202_impl*
end;//_vcmLayout_.EntitiesInited

procedure _vcmLayout_.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_500004240202_var*
//#UC END# *4A8E8F2E0195_500004240202_var*
begin
//#UC START# *4A8E8F2E0195_500004240202_impl*
//#UC END# *4A8E8F2E0195_500004240202_impl*
end;//_vcmLayout_.InitControls

procedure _vcmLayout_.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* ��������� �������� ������. ��� ���������� � �������� }
//#UC START# *497469C90140_500004240202_var*
//#UC END# *497469C90140_500004240202_var*
begin
//#UC START# *497469C90140_500004240202_impl*
//#UC END# *497469C90140_500004240202_impl*
end;//_vcmLayout_.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmLayout_imp_impl}

{$EndIf vcmLayout_imp}

