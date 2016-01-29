unit dMedicFirmList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dMedicFirmList.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::TdMedicFirmList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  MedicInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  l3Types,
  BaseDocumentWithAttributesInterfaces,
  DocumentAndListInterfaces,
  DocumentInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _IvcmRealData_ = IdMedicFirmList;
 {$Include ..\Medic\dMedicFirmDocument.imp.pas}
 TdMedicFirmList = class(_dMedicFirmDocument_, IdMedicFirmList)
 private
 // private fields
   f_dsSynchroViewRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsSynchroViewRef}
   f_MedicFirmList_SynchroView_Form : TMedicFirmList_SynchroView_Areas;
    {* Поле для свойства MedicFirmList_SynchroView_Form}
   f_dsFirmListRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsFirmListRef}
 protected
 // realized methods
   function pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
   function pm_GetMedicFirmListSynchroViewForm: TMedicFirmList_SynchroView_Areas;
   procedure pm_SetMedicFirmListSynchroViewForm(aValue: TMedicFirmList_SynchroView_Areas);
   function pm_GetDsFirmListRef: IvcmFormDataSourceRef;
 protected
 // overridden protected methods
   procedure InitFields; override;
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Make: IdMedicFirmList; reintroduce;
 end;//TdMedicFirmList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmFormDataSourceRef
  {$IfEnd} //not NoVCM
  ,
  l3Utils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdMedicFirmList;

{$Include ..\Medic\dMedicFirmDocument.imp.pas}

// start class TdMedicFirmList

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
end;

function TdMedicFirmList.pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsSynchroViewRef);
end;//TdMedicFirmList.pm_GetDsSynchroViewRef

function TdMedicFirmList.pm_GetMedicFirmListSynchroViewForm: TMedicFirmList_SynchroView_Areas;
 {-}
begin
 Result := f_MedicFirmList_SynchroView_Form;
end;//TdMedicFirmList.pm_GetMedicFirmListSynchroViewForm

procedure TdMedicFirmList.pm_SetMedicFirmListSynchroViewForm(aValue: TMedicFirmList_SynchroView_Areas);
 {-}
begin
 f_MedicFirmList_SynchroView_Form := aValue;
end;//TdMedicFirmList.pm_SetMedicFirmListSynchroViewForm

function TdMedicFirmList.pm_GetDsFirmListRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsFirmListRef);
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

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

procedure TdMedicFirmList.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsSynchroViewRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsFirmListRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdMedicFirmList.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.