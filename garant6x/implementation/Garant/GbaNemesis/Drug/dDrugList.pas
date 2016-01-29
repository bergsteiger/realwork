unit dDrugList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Drug"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Drug/dDrugList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Drug::DrugData::TdDrugList
//
// Данные сборки "Список лекартсвенных препаратов".
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
  DynamicDocListUnit,
  l3TreeInterfaces,
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
 _IvcmRealData_ = IdDrugList;
 {$Include ..\Drug\dBaseDrugDocument.imp.pas}
 TdDrugList = class(_dBaseDrugDocument_, IdDrugList)
  {* Данные сборки "Список лекартсвенных препаратов". }
 private
 // private fields
   f_NodeForPositioning : Il3SimpleNode;
   f_List : IDynList;
   f_dsFiltersRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsFiltersRef}
   f_dsDrugListRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsDrugListRef}
   f_dsListInfoRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsListInfoRef}
   f_dsSynchroViewRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsSynchroViewRef}
   f_DrugList_SynchroView_Form : TDrugList_SynchroView_Areas;
    {* Поле для свойства DrugList_SynchroView_Form}
 protected
 // realized methods
   function pm_GetDsFiltersRef: IvcmFormDataSourceRef;
   function pm_GetDsDrugListRef: IvcmFormDataSourceRef;
   function pm_GetList: IDynList;
   procedure pm_SetList(const aValue: IDynList);
   function pm_GetNodeForPositioning: Il3SimpleNode;
   procedure pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
   function pm_GetDsListInfoRef: IvcmFormDataSourceRef;
   function pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
   function pm_GetDrugListSynchroViewForm: TDrugList_SynchroView_Areas;
   procedure pm_SetDrugListSynchroViewForm(aValue: TDrugList_SynchroView_Areas);
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
   class function Make: IdDrugList; reintroduce;
     {* Фабричный метод }
 end;//TdDrugList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmFormDataSourceRef
  {$IfEnd} //not NoVCM
  ,
  SysUtils,
  l3Utils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdDrugList;

{$Include ..\Drug\dBaseDrugDocument.imp.pas}

// start class TdDrugList

class function TdDrugList.Make: IdDrugList;
var
 l_Inst : TdDrugList;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdDrugList.pm_GetDsFiltersRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsFiltersRef);
end;//TdDrugList.pm_GetDsFiltersRef

function TdDrugList.pm_GetDsDrugListRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsDrugListRef);
end;//TdDrugList.pm_GetDsDrugListRef

function TdDrugList.pm_GetList: IDynList;
//#UC START# *47F37CF2000D_47EB3E410033get_var*
//#UC END# *47F37CF2000D_47EB3E410033get_var*
begin
//#UC START# *47F37CF2000D_47EB3E410033get_impl*
 Result := f_List;
//#UC END# *47F37CF2000D_47EB3E410033get_impl*
end;//TdDrugList.pm_GetList

procedure TdDrugList.pm_SetList(const aValue: IDynList);
//#UC START# *47F37CF2000D_47EB3E410033set_var*
//#UC END# *47F37CF2000D_47EB3E410033set_var*
begin
//#UC START# *47F37CF2000D_47EB3E410033set_impl*
 f_List := aValue;
//#UC END# *47F37CF2000D_47EB3E410033set_impl*
end;//TdDrugList.pm_SetList

function TdDrugList.pm_GetNodeForPositioning: Il3SimpleNode;
//#UC START# *47FF3A4C03E7_47EB3E410033get_var*
//#UC END# *47FF3A4C03E7_47EB3E410033get_var*
begin
//#UC START# *47FF3A4C03E7_47EB3E410033get_impl*
 Result := f_NodeForPositioning;
//#UC END# *47FF3A4C03E7_47EB3E410033get_impl*
end;//TdDrugList.pm_GetNodeForPositioning

procedure TdDrugList.pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
//#UC START# *47FF3A4C03E7_47EB3E410033set_var*
//#UC END# *47FF3A4C03E7_47EB3E410033set_var*
begin
//#UC START# *47FF3A4C03E7_47EB3E410033set_impl*
 f_NodeForPositioning := aValue;
//#UC END# *47FF3A4C03E7_47EB3E410033set_impl*
end;//TdDrugList.pm_SetNodeForPositioning

function TdDrugList.pm_GetDsListInfoRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsListInfoRef);
end;//TdDrugList.pm_GetDsListInfoRef

function TdDrugList.pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsSynchroViewRef);
end;//TdDrugList.pm_GetDsSynchroViewRef

function TdDrugList.pm_GetDrugListSynchroViewForm: TDrugList_SynchroView_Areas;
 {-}
begin
 Result := f_DrugList_SynchroView_Form;
end;//TdDrugList.pm_GetDrugListSynchroViewForm

procedure TdDrugList.pm_SetDrugListSynchroViewForm(aValue: TDrugList_SynchroView_Areas);
 {-}
begin
 f_DrugList_SynchroView_Form := aValue;
end;//TdDrugList.pm_SetDrugListSynchroViewForm

procedure TdDrugList.InitFields;
//#UC START# *47A042E100E2_47EB3E410033_var*
//#UC END# *47A042E100E2_47EB3E410033_var*
begin
//#UC START# *47A042E100E2_47EB3E410033_impl*
 inherited;
 f_DrugList_SynchroView_Form := sva_DrugList_SynchroView_Document;
//#UC END# *47A042E100E2_47EB3E410033_impl*
end;//TdDrugList.InitFields

{$If not defined(NoVCM)}
procedure TdDrugList.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_47EB3E410033_var*
//#UC END# *4B16B8CF0307_47EB3E410033_var*
begin
//#UC START# *4B16B8CF0307_47EB3E410033_impl*
 inherited;
 // больше ничего не копируем ибо не надо вроде - http://mdp.garant.ru/pages/viewpage.action?pageId=173511144&focusedCommentId=173512002#comment-173512002
//#UC END# *4B16B8CF0307_47EB3E410033_impl*
end;//TdDrugList.AssignData
{$IfEnd} //not NoVCM

procedure TdDrugList.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_NodeForPositioning := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsFiltersRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsDrugListRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsListInfoRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsSynchroViewRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TdDrugList.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.