unit fsMedicFirmList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsMedicFirmList.pas"
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
 , PrimMedicFirmList_mflMain_UserType
 , Common_FormDefinitions_Controls
 , MedicInterfaces
 , l3InternalInterfaces
 , l3TreeInterfaces
 , DocumentInterfaces
 , PreviewInterfaces
 , l3Interfaces
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , nsTypes
 , PrimMedicListSynchroView_mlsfMedicFirm_UserType
 , afwInterfaces
 , DynamicDocListUnit
 , PrimPrimListInterfaces
 , bsTypes
 , DynamicTreeUnit
 , DocumentUnit
 , nevTools
 , FoldersDomainInterfaces
 , FiltersUnit
 , DocumentAndListInterfaces
 , bsTypesNew
 , DocumentUserTypes_dftMedicFirmSynchroView_UserType
 , ListUserTypes_lftProducedDrugsSynchroForm_UserType
 , AttributesUserTypes_fAttributeSynchroView_UserType
 , BaseDocumentWithAttributesInterfaces
;

type
 // MedicFirmList

 // Text

 // List

 // Attributes

 // MedicListSynchroView

 Tfs_MedicFirmList = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function MedicFirmList_Parent_mflMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для MedicFirmList }
   function MedicListSynchroView_Child_mlsfMedicFirm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для MedicListSynchroView }
   function Text_Child_dftMedicFirmSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function List_Child_lftProducedDrugsSynchroForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для List }
   function Attributes_Child_fAttributeSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_MedicFirmList;
    {* Метод получения экземпляра синглетона Tfs_MedicFirmList }
 end;//Tfs_MedicFirmList
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

var g_Tfs_MedicFirmList: Tfs_MedicFirmList = nil;
 {* Экземпляр синглетона Tfs_MedicFirmList }

const
 {* Локализуемые строки MedicFirmListCaptionLocalConstants }
 str_fsMedicFirmListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicFirmListCaption'; rValue : 'Фармацевтические фирмы');
  {* Заголовок фабрики сборки форм "MedicFirmList" }

procedure Tfs_MedicFirmListFree;
 {* Метод освобождения экземпляра синглетона Tfs_MedicFirmList }
begin
 l3Free(g_Tfs_MedicFirmList);
end;//Tfs_MedicFirmListFree

function Tfs_MedicFirmList.MedicFirmList_Parent_mflMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для MedicFirmList }
//#UC START# *4F700CE0EF53_4AA7A19E01D0_var*
//#UC END# *4F700CE0EF53_4AA7A19E01D0_var*
begin
//#UC START# *4F700CE0EF53_4AA7A19E01D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F700CE0EF53_4AA7A19E01D0_impl*
end;//Tfs_MedicFirmList.MedicFirmList_Parent_mflMain_NeedMakeForm

function Tfs_MedicFirmList.MedicListSynchroView_Child_mlsfMedicFirm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для MedicListSynchroView }
//#UC START# *F68008EDD490_4AA7A19E01D0_var*
//#UC END# *F68008EDD490_4AA7A19E01D0_var*
begin
//#UC START# *F68008EDD490_4AA7A19E01D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *F68008EDD490_4AA7A19E01D0_impl*
end;//Tfs_MedicFirmList.MedicListSynchroView_Child_mlsfMedicFirm_NeedMakeForm

function Tfs_MedicFirmList.Text_Child_dftMedicFirmSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *53493DB7D7CB_4AA7A19E01D0_var*
//#UC END# *53493DB7D7CB_4AA7A19E01D0_var*
begin
//#UC START# *53493DB7D7CB_4AA7A19E01D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *53493DB7D7CB_4AA7A19E01D0_impl*
end;//Tfs_MedicFirmList.Text_Child_dftMedicFirmSynchroView_NeedMakeForm

function Tfs_MedicFirmList.List_Child_lftProducedDrugsSynchroForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
//#UC START# *EC9F1705DC7B_4AA7A19E01D0_var*
//#UC END# *EC9F1705DC7B_4AA7A19E01D0_var*
begin
//#UC START# *EC9F1705DC7B_4AA7A19E01D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *EC9F1705DC7B_4AA7A19E01D0_impl*
end;//Tfs_MedicFirmList.List_Child_lftProducedDrugsSynchroForm_NeedMakeForm

function Tfs_MedicFirmList.Attributes_Child_fAttributeSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
//#UC START# *3A3C5FCF6C93_4AA7A19E01D0_var*
//#UC END# *3A3C5FCF6C93_4AA7A19E01D0_var*
begin
//#UC START# *3A3C5FCF6C93_4AA7A19E01D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A3C5FCF6C93_4AA7A19E01D0_impl*
end;//Tfs_MedicFirmList.Attributes_Child_fAttributeSynchroView_NeedMakeForm

class function Tfs_MedicFirmList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_MedicFirmList <> nil;
end;//Tfs_MedicFirmList.Exists

class function Tfs_MedicFirmList.Instance: Tfs_MedicFirmList;
 {* Метод получения экземпляра синглетона Tfs_MedicFirmList }
begin
 if (g_Tfs_MedicFirmList = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicFirmListFree);
  g_Tfs_MedicFirmList := Create;
 end;
 Result := g_Tfs_MedicFirmList;
end;//Tfs_MedicFirmList.Instance

procedure Tfs_MedicFirmList.InitFields;
//#UC START# *47A042E100E2_4AA7A19E01D0_var*
//#UC END# *47A042E100E2_4AA7A19E01D0_var*
begin
//#UC START# *47A042E100E2_4AA7A19E01D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA7A19E01D0_impl*
end;//Tfs_MedicFirmList.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_MedicFirmList.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA7A19E01D0_var*
//#UC END# *4FFE854A009B_4AA7A19E01D0_var*
begin
//#UC START# *4FFE854A009B_4AA7A19E01D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA7A19E01D0_impl*
end;//Tfs_MedicFirmList.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_fsMedicFirmListCaption.Init;
 {* Инициализация str_fsMedicFirmListCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
