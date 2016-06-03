unit NOT_COMPLETED_dMedicFirmList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\NOT_COMPLETED_dMedicFirmList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdMedicFirmList" MUID: (493A66C50034)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MedicInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseDocumentWithAttributesInterfaces
 , l3Types
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _IvcmRealData_ = IdMedicFirmList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\dMedicFirmDocument.imp.pas}
 TdMedicFirmList = class(_dMedicFirmDocument_, IdMedicFirmList)
  private
   f_dsSynchroViewRef: IvcmFormDataSourceRef;
    {* Ссылка на "dsSynchroView" }
   f_MedicFirmList_SynchroView_Form: TMedicFirmList_SynchroView_Areas;
    {* Форма синхронного просмотра }
   f_dsFirmListRef: IvcmFormDataSourceRef;
    {* Ссылка на "dsFirmList" }
  protected
   function pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
   function pm_GetMedicFirmListSynchroViewForm: TMedicFirmList_SynchroView_Areas;
   procedure pm_SetMedicFirmListSynchroViewForm(aValue: TMedicFirmList_SynchroView_Areas);
   function pm_GetDsFirmListRef: IvcmFormDataSourceRef;
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   class function Make: IdMedicFirmList; reintroduce;
 end;//TdMedicFirmList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Utils
;

type _Instance_R_ = TdMedicFirmList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Medic\dMedicFirmDocument.imp.pas}

class function TdMedicFirmList.Make: IdMedicFirmList;
var
 l_Inst : TdMedicFirmList;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdMedicFirmList.Make

function TdMedicFirmList.pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
//#UC START# *2A46ABCE9C2A_493A66C50034get_var*
//#UC END# *2A46ABCE9C2A_493A66C50034get_var*
begin
//#UC START# *2A46ABCE9C2A_493A66C50034get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2A46ABCE9C2A_493A66C50034get_impl*
end;//TdMedicFirmList.pm_GetDsSynchroViewRef

function TdMedicFirmList.pm_GetMedicFirmListSynchroViewForm: TMedicFirmList_SynchroView_Areas;
//#UC START# *9B8E07D2C1BA_493A66C50034get_var*
//#UC END# *9B8E07D2C1BA_493A66C50034get_var*
begin
//#UC START# *9B8E07D2C1BA_493A66C50034get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9B8E07D2C1BA_493A66C50034get_impl*
end;//TdMedicFirmList.pm_GetMedicFirmListSynchroViewForm

procedure TdMedicFirmList.pm_SetMedicFirmListSynchroViewForm(aValue: TMedicFirmList_SynchroView_Areas);
//#UC START# *9B8E07D2C1BA_493A66C50034set_var*
//#UC END# *9B8E07D2C1BA_493A66C50034set_var*
begin
//#UC START# *9B8E07D2C1BA_493A66C50034set_impl*
 !!! Needs to be implemented !!!
//#UC END# *9B8E07D2C1BA_493A66C50034set_impl*
end;//TdMedicFirmList.pm_SetMedicFirmListSynchroViewForm

function TdMedicFirmList.pm_GetDsFirmListRef: IvcmFormDataSourceRef;
//#UC START# *DD81AF5E2804_493A66C50034get_var*
//#UC END# *DD81AF5E2804_493A66C50034get_var*
begin
//#UC START# *DD81AF5E2804_493A66C50034get_impl*
 !!! Needs to be implemented !!!
//#UC END# *DD81AF5E2804_493A66C50034get_impl*
end;//TdMedicFirmList.pm_GetDsFirmListRef

procedure TdMedicFirmList.InitFields;
//#UC START# *47A042E100E2_493A66C50034_var*
//#UC END# *47A042E100E2_493A66C50034_var*
begin
//#UC START# *47A042E100E2_493A66C50034_impl*
 inherited;
 f_MedicFirmList_SynchroView_Form := sva_MedicFirmList_SynchroView_Document;
//#UC END# *47A042E100E2_493A66C50034_impl*
end;//TdMedicFirmList.InitFields

{$If NOT Defined(NoVCM)}
procedure TdMedicFirmList.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_493A66C50034_var*
//#UC END# *4B16B8CF0307_493A66C50034_var*
begin
//#UC START# *4B16B8CF0307_493A66C50034_impl*
 pm_GetDsSynchroViewRef.Assign(aData.dsSynchroViewRef);
 pm_GetDsFirmListRef.Assign(aData.dsFirmListRef);
 inherited;
//#UC END# *4B16B8CF0307_493A66C50034_impl*
end;//TdMedicFirmList.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure TdMedicFirmList.ClearFields;
begin
 f_dsSynchroViewRef := nil;
 f_dsFirmListRef := nil;
 inherited;
end;//TdMedicFirmList.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
