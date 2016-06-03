unit NOT_COMPLETED_dDrugList;
 {* Данные сборки "Список лекартсвенных препаратов". }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Drug\NOT_COMPLETED_dDrugList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdDrugList" MUID: (47EB3E410033)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MedicInterfaces
 , l3TreeInterfaces
 , DynamicDocListUnit
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Types
 , BaseDocumentWithAttributesInterfaces
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _IvcmRealData_ = IdDrugList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Drug\dBaseDrugDocument.imp.pas}
 TdDrugList = class(_dBaseDrugDocument_, IdDrugList)
  {* Данные сборки "Список лекартсвенных препаратов". }
  private
   f_NodeForPositioning: Il3SimpleNode;
   f_List: IDynList;
   f_dsFiltersRef: IvcmFormDataSourceRef;
    {* Ссылка на "Бизнес объект "Фильтры"" }
   f_dsDrugListRef: IvcmFormDataSourceRef;
    {* Ссылка на "Бизнес объект "Список лекарственных препаратов"" }
   f_dsListInfoRef: IvcmFormDataSourceRef;
    {* Ссылка на "справка к списку" }
   f_dsSynchroViewRef: IvcmFormDataSourceRef;
    {* Ссылка на "Бизнес объект "Синхронный просмотра"" }
   f_DrugList_SynchroView_Form: TDrugList_SynchroView_Areas;
    {* Форма синхронного просмотра }
  protected
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
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   class function Make: IdDrugList; reintroduce;
    {* Фабричный метод }
 end;//TdDrugList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Utils
;

type _Instance_R_ = TdDrugList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Drug\dBaseDrugDocument.imp.pas}

class function TdDrugList.Make: IdDrugList;
 {* Фабричный метод }
var
 l_Inst : TdDrugList;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdDrugList.Make

function TdDrugList.pm_GetDsFiltersRef: IvcmFormDataSourceRef;
//#UC START# *0048137F6167_47EB3E410033get_var*
//#UC END# *0048137F6167_47EB3E410033get_var*
begin
//#UC START# *0048137F6167_47EB3E410033get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0048137F6167_47EB3E410033get_impl*
end;//TdDrugList.pm_GetDsFiltersRef

function TdDrugList.pm_GetDsDrugListRef: IvcmFormDataSourceRef;
//#UC START# *38AF3FCA8739_47EB3E410033get_var*
//#UC END# *38AF3FCA8739_47EB3E410033get_var*
begin
//#UC START# *38AF3FCA8739_47EB3E410033get_impl*
 !!! Needs to be implemented !!!
//#UC END# *38AF3FCA8739_47EB3E410033get_impl*
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
//#UC START# *6DCE2C2DE35F_47EB3E410033get_var*
//#UC END# *6DCE2C2DE35F_47EB3E410033get_var*
begin
//#UC START# *6DCE2C2DE35F_47EB3E410033get_impl*
 !!! Needs to be implemented !!!
//#UC END# *6DCE2C2DE35F_47EB3E410033get_impl*
end;//TdDrugList.pm_GetDsListInfoRef

function TdDrugList.pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
//#UC START# *8C15EA0B7407_47EB3E410033get_var*
//#UC END# *8C15EA0B7407_47EB3E410033get_var*
begin
//#UC START# *8C15EA0B7407_47EB3E410033get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8C15EA0B7407_47EB3E410033get_impl*
end;//TdDrugList.pm_GetDsSynchroViewRef

function TdDrugList.pm_GetDrugListSynchroViewForm: TDrugList_SynchroView_Areas;
//#UC START# *B53EF7286977_47EB3E410033get_var*
//#UC END# *B53EF7286977_47EB3E410033get_var*
begin
//#UC START# *B53EF7286977_47EB3E410033get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B53EF7286977_47EB3E410033get_impl*
end;//TdDrugList.pm_GetDrugListSynchroViewForm

procedure TdDrugList.pm_SetDrugListSynchroViewForm(aValue: TDrugList_SynchroView_Areas);
//#UC START# *B53EF7286977_47EB3E410033set_var*
//#UC END# *B53EF7286977_47EB3E410033set_var*
begin
//#UC START# *B53EF7286977_47EB3E410033set_impl*
 !!! Needs to be implemented !!!
//#UC END# *B53EF7286977_47EB3E410033set_impl*
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

{$If NOT Defined(NoVCM)}
procedure TdDrugList.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_47EB3E410033_var*
//#UC END# *4B16B8CF0307_47EB3E410033_var*
begin
//#UC START# *4B16B8CF0307_47EB3E410033_impl*
 inherited;
 // больше ничего не копируем ибо не надо вроде - http://mdp.garant.ru/pages/viewpage.action?pageId=173511144&focusedCommentId=173512002#comment-173512002
//#UC END# *4B16B8CF0307_47EB3E410033_impl*
end;//TdDrugList.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure TdDrugList.ClearFields;
begin
 f_NodeForPositioning := nil;
 f_dsFiltersRef := nil;
 f_dsDrugListRef := nil;
 f_dsListInfoRef := nil;
 f_dsSynchroViewRef := nil;
 inherited;
end;//TdDrugList.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
