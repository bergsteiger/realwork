unit fsDrugList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsDrugList.pas"
// Стереотип: "VCMFormSetFactory"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimMedicListSynchroView_mlsfDrugList_UserType
 , Common_FormDefinitions_Controls
 , MedicInterfaces
 , l3Interfaces
 , afwInterfaces
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 , bsTypes
 , DynamicTreeUnit
 , l3TreeInterfaces
 , DocumentUnit
 , PreviewInterfaces
 , nevTools
 , DocumentInterfaces
 , l3InternalInterfaces
 , FoldersDomainInterfaces
 , FiltersUnit
 , DocumentAndListInterfaces
 , nsTypes
 , bsTypesNew
 , ListUserTypes_lftDrugList_UserType
 , FiltersUserTypes_utFilters_UserType
 , SimpleListInterfaces
 , ListInfoUserTypes_liListInfo_UserType
 , DocumentUserTypes_dftDrugSynchroView_UserType
 , ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType
 , AttributesUserTypes_fAttributeSynchroView_UserType
 , BaseDocumentWithAttributesInterfaces
 , BaloonWarningUserTypes_remListModified_UserType
 , nevBase
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
;

type
 // Text

 // Synonyms

 // Attributes

 // Synchro

 // remListModified

 // remListFiltered

 // remTimeMachineWarning

 // List

 // Filters

 // ListInfo

 Tfs_DrugList = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Synchro_Child_mlsfDrugList_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Synchro }
   function Text_Child_dftDrugSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function Synonyms_Child_lftDrugInternationalNameSynonymsSynchroForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Synonyms }
   function Attributes_Child_fAttributeSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   function List_Parent_lftDrugList_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для List }
   function remListModified_Child_remListModified_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListModified }
   function remListFiltered_Child_remListFiltered_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remListFiltered }
   function remTimeMachineWarning_Child_remTimeMachineWarning_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для remTimeMachineWarning }
   function Filters_Navigator_utFilters_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Filters }
   function ListInfo_Child_liListInfo_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для ListInfo }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_DrugList;
    {* Метод получения экземпляра синглетона Tfs_DrugList }
 end;//Tfs_DrugList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 , SysUtils
 , l3Base
;

var g_Tfs_DrugList: Tfs_DrugList = nil;
 {* Экземпляр синглетона Tfs_DrugList }

const
 {* Локализуемые строки DrugListCaptionLocalConstants }
 str_fsDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDrugListCaption'; rValue : 'Список препаратов');
  {* Заголовок фабрики сборки форм "DrugList" }

procedure Tfs_DrugListFree;
 {* Метод освобождения экземпляра синглетона Tfs_DrugList }
begin
 l3Free(g_Tfs_DrugList);
end;//Tfs_DrugListFree

function Tfs_DrugList.Synchro_Child_mlsfDrugList_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Synchro }
//#UC START# *F74313583E52_4AA4D3F40235_var*
//#UC END# *F74313583E52_4AA4D3F40235_var*
begin
//#UC START# *F74313583E52_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *F74313583E52_4AA4D3F40235_impl*
end;//Tfs_DrugList.Synchro_Child_mlsfDrugList_NeedMakeForm

function Tfs_DrugList.Text_Child_dftDrugSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *82BC769FEF20_4AA4D3F40235_var*
//#UC END# *82BC769FEF20_4AA4D3F40235_var*
begin
//#UC START# *82BC769FEF20_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *82BC769FEF20_4AA4D3F40235_impl*
end;//Tfs_DrugList.Text_Child_dftDrugSynchroView_NeedMakeForm

function Tfs_DrugList.Synonyms_Child_lftDrugInternationalNameSynonymsSynchroForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Synonyms }
//#UC START# *FC30801875B9_4AA4D3F40235_var*
//#UC END# *FC30801875B9_4AA4D3F40235_var*
begin
//#UC START# *FC30801875B9_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *FC30801875B9_4AA4D3F40235_impl*
end;//Tfs_DrugList.Synonyms_Child_lftDrugInternationalNameSynonymsSynchroForm_NeedMakeForm

function Tfs_DrugList.Attributes_Child_fAttributeSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
//#UC START# *2A0F78DEE328_4AA4D3F40235_var*
//#UC END# *2A0F78DEE328_4AA4D3F40235_var*
begin
//#UC START# *2A0F78DEE328_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *2A0F78DEE328_4AA4D3F40235_impl*
end;//Tfs_DrugList.Attributes_Child_fAttributeSynchroView_NeedMakeForm

function Tfs_DrugList.List_Parent_lftDrugList_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
//#UC START# *A0D8C5BC4D60_4AA4D3F40235_var*
//#UC END# *A0D8C5BC4D60_4AA4D3F40235_var*
begin
//#UC START# *A0D8C5BC4D60_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *A0D8C5BC4D60_4AA4D3F40235_impl*
end;//Tfs_DrugList.List_Parent_lftDrugList_NeedMakeForm

function Tfs_DrugList.remListModified_Child_remListModified_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListModified }
//#UC START# *63FC0435D388_4AA4D3F40235_var*
//#UC END# *63FC0435D388_4AA4D3F40235_var*
begin
//#UC START# *63FC0435D388_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *63FC0435D388_4AA4D3F40235_impl*
end;//Tfs_DrugList.remListModified_Child_remListModified_NeedMakeForm

function Tfs_DrugList.remListFiltered_Child_remListFiltered_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListFiltered }
//#UC START# *47E604BA2AE1_4AA4D3F40235_var*
//#UC END# *47E604BA2AE1_4AA4D3F40235_var*
begin
//#UC START# *47E604BA2AE1_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E604BA2AE1_4AA4D3F40235_impl*
end;//Tfs_DrugList.remListFiltered_Child_remListFiltered_NeedMakeForm

function Tfs_DrugList.remTimeMachineWarning_Child_remTimeMachineWarning_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remTimeMachineWarning }
//#UC START# *8E8F30B9521E_4AA4D3F40235_var*
//#UC END# *8E8F30B9521E_4AA4D3F40235_var*
begin
//#UC START# *8E8F30B9521E_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E8F30B9521E_4AA4D3F40235_impl*
end;//Tfs_DrugList.remTimeMachineWarning_Child_remTimeMachineWarning_NeedMakeForm

function Tfs_DrugList.Filters_Navigator_utFilters_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Filters }
//#UC START# *43735BF854EE_4AA4D3F40235_var*
//#UC END# *43735BF854EE_4AA4D3F40235_var*
begin
//#UC START# *43735BF854EE_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *43735BF854EE_4AA4D3F40235_impl*
end;//Tfs_DrugList.Filters_Navigator_utFilters_NeedMakeForm

function Tfs_DrugList.ListInfo_Child_liListInfo_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для ListInfo }
//#UC START# *A104A12AB6B7_4AA4D3F40235_var*
//#UC END# *A104A12AB6B7_4AA4D3F40235_var*
begin
//#UC START# *A104A12AB6B7_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *A104A12AB6B7_4AA4D3F40235_impl*
end;//Tfs_DrugList.ListInfo_Child_liListInfo_NeedMakeForm

class function Tfs_DrugList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_DrugList <> nil;
end;//Tfs_DrugList.Exists

class function Tfs_DrugList.Instance: Tfs_DrugList;
 {* Метод получения экземпляра синглетона Tfs_DrugList }
begin
 if (g_Tfs_DrugList = nil) then
 begin
  l3System.AddExitProc(Tfs_DrugListFree);
  g_Tfs_DrugList := Create;
 end;
 Result := g_Tfs_DrugList;
end;//Tfs_DrugList.Instance

procedure Tfs_DrugList.InitFields;
//#UC START# *47A042E100E2_4AA4D3F40235_var*
//#UC END# *47A042E100E2_4AA4D3F40235_var*
begin
//#UC START# *47A042E100E2_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA4D3F40235_impl*
end;//Tfs_DrugList.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_DrugList.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA4D3F40235_var*
//#UC END# *4FFE854A009B_4AA4D3F40235_var*
begin
//#UC START# *4FFE854A009B_4AA4D3F40235_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA4D3F40235_impl*
end;//Tfs_DrugList.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_fsDrugListCaption.Init;
 {* Инициализация str_fsDrugListCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
