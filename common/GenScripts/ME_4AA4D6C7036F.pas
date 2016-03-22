unit fsList;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\fsList.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "List" MUID: (4AA4D6C7036F)
// Имя типа: "Tfs_List"

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
 {$If NOT Defined(NoVCM)}
 , vcmFormSet
 {$IfEnd} // NOT Defined(NoVCM)
 , ListUserTypes_lftNone_UserType
 , Common_FormDefinitions_Controls
 , WorkWithListInterfaces
 , bsTypes
 , l3Interfaces
 , l3Tree_TLB
 , afwInterfaces
 , DynamicDocListUnit
 , l3TreeInterfaces
 , PrimPrimListInterfaces
 , DynamicTreeUnit
 , DocumentUnit
 , PreviewInterfaces
 , l3InternalInterfaces
 , PrimListInterfaces
 , FiltersUnit
 , DocumentInterfaces
 , nsTypes
 , ListInfoUserTypes_liListInfo_UserType
 , FiltersUserTypes_utFilters_UserType
 , SimpleListInterfaces
 , SynchroViewUserTypes_svSynchroView_UserType
 , nevTools
 , evdInterfaces
 , DocumentAndListInterfaces
 , FoldersDomainInterfaces
 , bsTypesNew
 , ListAnalizeUserTypes_Analize_UserType
 , BaloonWarningUserTypes_remListModified_UserType
 , nevBase
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , DocumentUserTypes_dftDocSynchroView_UserType
 , AttributesUserTypes_fAttributeSynchroView_UserType
 , BaseDocumentWithAttributesInterfaces
 , DocumentUserTypes_dftRelatedSynchroView_UserType
 , DocInfoInterfaces
 , DocumentUserTypes_dftAnnotationSynchroView_UserType
 , ListUserTypes_lftSimilarDocumentsSynchroView_UserType
 , ListUserTypes_lftUserCRList1_SynchorForm_UserType
 , ListUserTypes_lftUserCRList2_SynchorForm_UserType
 , ListUserTypes_lftCorrespondentsSynchroForm_UserType
 , ListUserTypes_lftRespondentsSynchroForm_UserType
 , DocumentWithFlashUserTypes_dwftSynchro_UserType
 , BaloonWarningUserTypes_WarnJuror_UserType
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_WarnOnControl_UserType
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , BaloonWarningUserTypes_WarnRedaction_UserType
;

type
 // remListModified

 // remListFiltered

 // remTimeMachineWarning

 // List

 // ListInfo

 // Filters

 // WarnJuror

 // WarnPreActive

 // WarnIsAbolished

 // WarnOnControl

 // WarnInactualDocument

 // WarnRedaction

 // Text

 // Attributes

 // Related

 // Annotation

 // Similar

 // UserCR1

 // UserCR2

 // Correspondents

 // Respondents

 // DocumentWithFlash

 // SynchroView

 // ListAnalize

 Tfs_List = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetFormSetImplementation: RvcmFormSet; override;
    {* Возвращает класс реализации сборки }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitForms(const aParams: IvcmFormSetRefreshParams); override;
    {* Вызывается при создании сборки перед Refresh для инициализации нужных флажков на сборке. }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function List_Parent_lftNone_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
   function ListInfo_Child_liListInfo_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для ListInfo }
   function Filters_Navigator_utFilters_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Filters }
   function SynchroView_Child_svSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для SynchroView }
   function Text_Child_dftDocSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function WarnJuror_Child_WarnJuror_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnJuror }
   function WarnPreActive_Child_WarnPreActive_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnPreActive }
   function WarnIsAbolished_Child_WarnIsAbolished_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnIsAbolished }
   function WarnOnControl_Child_WarnOnControl_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnOnControl }
   function WarnInactualDocument_Child_WarnInactualDocument_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnInactualDocument }
   function WarnRedaction_Child_WarnRedaction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnRedaction }
   function Attributes_Child_fAttributeSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   function Related_Child_dftRelatedSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Related }
   function Annotation_Child_dftAnnotationSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Annotation }
   function Similar_Child_lftSimilarDocumentsSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Similar }
   function UserCR1_Child_lftUserCRList1_SynchorForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserCR1 }
   function UserCR2_Child_lftUserCRList2_SynchorForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для UserCR2 }
   function Correspondents_Child_lftCorrespondentsSynchroForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Correspondents }
   function Respondents_Child_lftRespondentsSynchroForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Respondents }
   function DocumentWithFlash_Child_dwftSynchro_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для DocumentWithFlash }
   function ListAnalize_Child_Analize_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для ListAnalize }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_List;
    {* Метод получения экземпляра синглетона Tfs_List }
 end;//Tfs_List
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

{$If NOT Defined(NoVCM)}
var g_Tfs_List: Tfs_List = nil;
 {* Экземпляр синглетона Tfs_List }

const
 {* Локализуемые строки List$FSFCaptionLocalConstants }
 str_fsListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsListCaption'; rValue : 'Список');
  {* Заголовок фабрики сборки форм "List$FSF" }

procedure Tfs_ListFree;
 {* Метод освобождения экземпляра синглетона Tfs_List }
begin
 l3Free(g_Tfs_List);
end;//Tfs_ListFree

function Tfs_List.List_Parent_lftNone_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
//#UC START# *6FB33409D9C1_4AA4D6C7036F_var*
//#UC END# *6FB33409D9C1_4AA4D6C7036F_var*
begin
//#UC START# *6FB33409D9C1_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *6FB33409D9C1_4AA4D6C7036F_impl*
end;//Tfs_List.List_Parent_lftNone_NeedMakeForm

function Tfs_List.remListModified_Child_remListModified_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListModified }
//#UC START# *342B21360CC5_4AA4D6C7036F_var*
//#UC END# *342B21360CC5_4AA4D6C7036F_var*
begin
//#UC START# *342B21360CC5_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *342B21360CC5_4AA4D6C7036F_impl*
end;//Tfs_List.remListModified_Child_remListModified_NeedMakeForm

function Tfs_List.remListFiltered_Child_remListFiltered_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remListFiltered }
//#UC START# *5BCADCEB9914_4AA4D6C7036F_var*
//#UC END# *5BCADCEB9914_4AA4D6C7036F_var*
begin
//#UC START# *5BCADCEB9914_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5BCADCEB9914_4AA4D6C7036F_impl*
end;//Tfs_List.remListFiltered_Child_remListFiltered_NeedMakeForm

function Tfs_List.remTimeMachineWarning_Child_remTimeMachineWarning_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для remTimeMachineWarning }
//#UC START# *911209B60194_4AA4D6C7036F_var*
//#UC END# *911209B60194_4AA4D6C7036F_var*
begin
//#UC START# *911209B60194_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *911209B60194_4AA4D6C7036F_impl*
end;//Tfs_List.remTimeMachineWarning_Child_remTimeMachineWarning_NeedMakeForm

function Tfs_List.ListInfo_Child_liListInfo_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для ListInfo }
//#UC START# *B716F973183E_4AA4D6C7036F_var*
//#UC END# *B716F973183E_4AA4D6C7036F_var*
begin
//#UC START# *B716F973183E_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *B716F973183E_4AA4D6C7036F_impl*
end;//Tfs_List.ListInfo_Child_liListInfo_NeedMakeForm

function Tfs_List.Filters_Navigator_utFilters_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Filters }
//#UC START# *0251143D9C2A_4AA4D6C7036F_var*
//#UC END# *0251143D9C2A_4AA4D6C7036F_var*
begin
//#UC START# *0251143D9C2A_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *0251143D9C2A_4AA4D6C7036F_impl*
end;//Tfs_List.Filters_Navigator_utFilters_NeedMakeForm

function Tfs_List.SynchroView_Child_svSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для SynchroView }
//#UC START# *9FCD1BA2F2AA_4AA4D6C7036F_var*
//#UC END# *9FCD1BA2F2AA_4AA4D6C7036F_var*
begin
//#UC START# *9FCD1BA2F2AA_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *9FCD1BA2F2AA_4AA4D6C7036F_impl*
end;//Tfs_List.SynchroView_Child_svSynchroView_NeedMakeForm

function Tfs_List.Text_Child_dftDocSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *85A4E289C38C_4AA4D6C7036F_var*
//#UC END# *85A4E289C38C_4AA4D6C7036F_var*
begin
//#UC START# *85A4E289C38C_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *85A4E289C38C_4AA4D6C7036F_impl*
end;//Tfs_List.Text_Child_dftDocSynchroView_NeedMakeForm

function Tfs_List.WarnJuror_Child_WarnJuror_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnJuror }
//#UC START# *109FC801028D_4AA4D6C7036F_var*
//#UC END# *109FC801028D_4AA4D6C7036F_var*
begin
//#UC START# *109FC801028D_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *109FC801028D_4AA4D6C7036F_impl*
end;//Tfs_List.WarnJuror_Child_WarnJuror_NeedMakeForm

function Tfs_List.WarnPreActive_Child_WarnPreActive_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnPreActive }
//#UC START# *D86AFFD2967B_4AA4D6C7036F_var*
//#UC END# *D86AFFD2967B_4AA4D6C7036F_var*
begin
//#UC START# *D86AFFD2967B_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *D86AFFD2967B_4AA4D6C7036F_impl*
end;//Tfs_List.WarnPreActive_Child_WarnPreActive_NeedMakeForm

function Tfs_List.WarnIsAbolished_Child_WarnIsAbolished_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnIsAbolished }
//#UC START# *0F58FEF40E1B_4AA4D6C7036F_var*
//#UC END# *0F58FEF40E1B_4AA4D6C7036F_var*
begin
//#UC START# *0F58FEF40E1B_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *0F58FEF40E1B_4AA4D6C7036F_impl*
end;//Tfs_List.WarnIsAbolished_Child_WarnIsAbolished_NeedMakeForm

function Tfs_List.WarnOnControl_Child_WarnOnControl_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnOnControl }
//#UC START# *C52D22EAD2F8_4AA4D6C7036F_var*
//#UC END# *C52D22EAD2F8_4AA4D6C7036F_var*
begin
//#UC START# *C52D22EAD2F8_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *C52D22EAD2F8_4AA4D6C7036F_impl*
end;//Tfs_List.WarnOnControl_Child_WarnOnControl_NeedMakeForm

function Tfs_List.WarnInactualDocument_Child_WarnInactualDocument_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnInactualDocument }
//#UC START# *057C3FAD26BE_4AA4D6C7036F_var*
//#UC END# *057C3FAD26BE_4AA4D6C7036F_var*
begin
//#UC START# *057C3FAD26BE_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *057C3FAD26BE_4AA4D6C7036F_impl*
end;//Tfs_List.WarnInactualDocument_Child_WarnInactualDocument_NeedMakeForm

function Tfs_List.WarnRedaction_Child_WarnRedaction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnRedaction }
//#UC START# *A228BB8F2A03_4AA4D6C7036F_var*
//#UC END# *A228BB8F2A03_4AA4D6C7036F_var*
begin
//#UC START# *A228BB8F2A03_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *A228BB8F2A03_4AA4D6C7036F_impl*
end;//Tfs_List.WarnRedaction_Child_WarnRedaction_NeedMakeForm

function Tfs_List.Attributes_Child_fAttributeSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
//#UC START# *2FAB58377E16_4AA4D6C7036F_var*
//#UC END# *2FAB58377E16_4AA4D6C7036F_var*
begin
//#UC START# *2FAB58377E16_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *2FAB58377E16_4AA4D6C7036F_impl*
end;//Tfs_List.Attributes_Child_fAttributeSynchroView_NeedMakeForm

function Tfs_List.Related_Child_dftRelatedSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Related }
//#UC START# *0FEAFCC70644_4AA4D6C7036F_var*
//#UC END# *0FEAFCC70644_4AA4D6C7036F_var*
begin
//#UC START# *0FEAFCC70644_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *0FEAFCC70644_4AA4D6C7036F_impl*
end;//Tfs_List.Related_Child_dftRelatedSynchroView_NeedMakeForm

function Tfs_List.Annotation_Child_dftAnnotationSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Annotation }
//#UC START# *68972697CE72_4AA4D6C7036F_var*
//#UC END# *68972697CE72_4AA4D6C7036F_var*
begin
//#UC START# *68972697CE72_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *68972697CE72_4AA4D6C7036F_impl*
end;//Tfs_List.Annotation_Child_dftAnnotationSynchroView_NeedMakeForm

function Tfs_List.Similar_Child_lftSimilarDocumentsSynchroView_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Similar }
//#UC START# *C316D7C78319_4AA4D6C7036F_var*
//#UC END# *C316D7C78319_4AA4D6C7036F_var*
begin
//#UC START# *C316D7C78319_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *C316D7C78319_4AA4D6C7036F_impl*
end;//Tfs_List.Similar_Child_lftSimilarDocumentsSynchroView_NeedMakeForm

function Tfs_List.UserCR1_Child_lftUserCRList1_SynchorForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для UserCR1 }
//#UC START# *D097F08CEE8D_4AA4D6C7036F_var*
//#UC END# *D097F08CEE8D_4AA4D6C7036F_var*
begin
//#UC START# *D097F08CEE8D_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *D097F08CEE8D_4AA4D6C7036F_impl*
end;//Tfs_List.UserCR1_Child_lftUserCRList1_SynchorForm_NeedMakeForm

function Tfs_List.UserCR2_Child_lftUserCRList2_SynchorForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для UserCR2 }
//#UC START# *007B9C4DB09A_4AA4D6C7036F_var*
//#UC END# *007B9C4DB09A_4AA4D6C7036F_var*
begin
//#UC START# *007B9C4DB09A_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *007B9C4DB09A_4AA4D6C7036F_impl*
end;//Tfs_List.UserCR2_Child_lftUserCRList2_SynchorForm_NeedMakeForm

function Tfs_List.Correspondents_Child_lftCorrespondentsSynchroForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Correspondents }
//#UC START# *937D73DDC0E5_4AA4D6C7036F_var*
//#UC END# *937D73DDC0E5_4AA4D6C7036F_var*
begin
//#UC START# *937D73DDC0E5_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *937D73DDC0E5_4AA4D6C7036F_impl*
end;//Tfs_List.Correspondents_Child_lftCorrespondentsSynchroForm_NeedMakeForm

function Tfs_List.Respondents_Child_lftRespondentsSynchroForm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Respondents }
//#UC START# *636D98E47B0D_4AA4D6C7036F_var*
//#UC END# *636D98E47B0D_4AA4D6C7036F_var*
begin
//#UC START# *636D98E47B0D_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *636D98E47B0D_4AA4D6C7036F_impl*
end;//Tfs_List.Respondents_Child_lftRespondentsSynchroForm_NeedMakeForm

function Tfs_List.DocumentWithFlash_Child_dwftSynchro_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для DocumentWithFlash }
//#UC START# *7261C6CD1CBA_4AA4D6C7036F_var*
//#UC END# *7261C6CD1CBA_4AA4D6C7036F_var*
begin
//#UC START# *7261C6CD1CBA_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *7261C6CD1CBA_4AA4D6C7036F_impl*
end;//Tfs_List.DocumentWithFlash_Child_dwftSynchro_NeedMakeForm

function Tfs_List.ListAnalize_Child_Analize_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для ListAnalize }
//#UC START# *570EAC1EEEC8_4AA4D6C7036F_var*
//#UC END# *570EAC1EEEC8_4AA4D6C7036F_var*
begin
//#UC START# *570EAC1EEEC8_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *570EAC1EEEC8_4AA4D6C7036F_impl*
end;//Tfs_List.ListAnalize_Child_Analize_NeedMakeForm

class function Tfs_List.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_List <> nil;
end;//Tfs_List.Exists

class function Tfs_List.Instance: Tfs_List;
 {* Метод получения экземпляра синглетона Tfs_List }
begin
 if (g_Tfs_List = nil) then
 begin
  l3System.AddExitProc(Tfs_ListFree);
  g_Tfs_List := Create;
 end;
 Result := g_Tfs_List;
end;//Tfs_List.Instance

procedure Tfs_List.InitFields;
//#UC START# *47A042E100E2_4AA4D6C7036F_var*
//#UC END# *47A042E100E2_4AA4D6C7036F_var*
begin
//#UC START# *47A042E100E2_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA4D6C7036F_impl*
end;//Tfs_List.InitFields

class function Tfs_List.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA4D6C7036F_var*
//#UC END# *4FFE854A009B_4AA4D6C7036F_var*
begin
//#UC START# *4FFE854A009B_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA4D6C7036F_impl*
end;//Tfs_List.GetInstance

function Tfs_List.GetFormSetImplementation: RvcmFormSet;
 {* Возвращает класс реализации сборки }
//#UC START# *52973E60005E_4AA4D6C7036F_var*
//#UC END# *52973E60005E_4AA4D6C7036F_var*
begin
//#UC START# *52973E60005E_4AA4D6C7036F_impl*
 Result := TfstList;
//#UC END# *52973E60005E_4AA4D6C7036F_impl*
end;//Tfs_List.GetFormSetImplementation

procedure Tfs_List.InitForms(const aParams: IvcmFormSetRefreshParams);
 {* Вызывается при создании сборки перед Refresh для инициализации нужных флажков на сборке. }
//#UC START# *52EA619F02FA_4AA4D6C7036F_var*
var
 l_FormSet: IfstList;
 l_SetData: IdList;
 l_SDS: IsdsList;
 
 function lp_IsOrdinalCRSelected(aCRType: TlstCRType;
   out aId: TnsUserCRListId): Boolean;
 var
  I: TnsUserCRListId;
 begin
  for I := Low(TnsUserCRListId) to High(TnsUserCRListId) do
  begin
   with l_SetData.UserCRListInfo[I] do
    Result := (ListType = aCRType) and not bsIsCRNodeAreNotAllDocuments(Node);
   if Result then
   begin
    aId := I;
    Break;
   end;//if Result then
  end;//for I := Low(TnsUserCRListId) to
 end;//lp_IsOrdinalCRSelected

  function lpCRNeedMake(const aDSRef : IvcmFormDataSourceRef;
                        const aType  : TlstCRType;
                        const aNeedMake: TvcmNeedMakeDS): TvcmNeedMakeDS;
  var
   l_List             : TnsUserCRListId;
   l_IsFullCRSelected : Boolean;
  begin
   Result := aNeedMake;
   with aDSRef do
   begin
    l_IsFullCRSelected := lp_IsOrdinalCRSelected(aType, l_List);
    // Отметим, что вместо пользовательской вкладки показывается полный СКР:
    if l_IsFullCRSelected then
     l_SetData.UserCRListInfo[l_List].wKindOfList := bs_ulFullCR;
    // Откроем нормальную СКР вместо пользовательской
    if (aNeedMake = vcm_nmNo) and l_IsFullCRSelected then
    begin
     Result := {StateIfNeedShowFullCRList}vcm_nmYes;
     // Закроем пользовательскую вкладку
     case l_List of
      ulFirst:
       begin
        l_SetData.dsUserCR1Ref.Referred := nil;
        Result := vcm_nmYes;
       end;
      ulSecond:
       begin
        l_SetData.dsUserCR2Ref.Referred := nil;
        Result := vcm_nmYes;
       end;
     end;//case l_List of
    end//if (NeedMake = vcm_nmNo) ...
    else
     // Закроем форму СКР потому, что она была открыта по причине установки
     // пользовательской вкладки в настройках с типом "Все документы", а теперь
     // пользователь установил другой тип
     if (aNeedMake = {StateIfNeedShowFullCRList}vcm_nmYes) and not l_IsFullCRSelected then
     begin
      aDSRef.Referred := nil;
      Result := vcm_nmNo;
     end;
   end;//with aDSRef do
  end;//lpCRNeedMake

  procedure lp_InitUserCRList(const aValue: TnsUserCRListId);
  var
   l_Temp: IbsUserCRListInfoModify;

   function lp_IsUserCRListChanged: Boolean;
   begin
    l_Temp.Assign(l_SetData.UserCRListInfo[aValue]);
     // - скопируем, чтобы позднее сравнить изменились ли параметры
     //   пользовательской вкладки:
    with l_SetData.UserCRListInfo[aValue] do
    begin
     wListType := bsUserCRList(aValue);
     wNode := bsUserCRNode(aValue);
     wHas := l_SDS.IsTypedCRSelected(aValue) and (ListType <> crtNone) and
      l_SDS.HasTypedCRinBigBase(aValue);
     wKindOfList := bs_ulUserCR;
    end;//with SetData.UserCRListInfo[ulSecond] do
    Result := not l_Temp.IsSame(l_SetData.UserCRListInfo[aValue]);
     // - проверим изменились ли данные;
   end;//lp_ReadSettings

   procedure lp_UpdateDSUserCRList;
   begin
    // Инициируем переполучение бизнес объекта для вкладки:
    with l_SetData do
     case aValue of
      ulFirst:
       begin
        dsUserCR1Ref.Referred := nil;
        l_FormSet.UserCR1NeedMakeDS := vcm_nmNo;
       end;
      ulSecond:
       begin
        dsUserCR2Ref.Referred := nil;
        l_FormSet.UserCR2NeedMakeDS := vcm_nmNo;
       end;
      else
       Assert(False);
     end;//case aValue of
   end;//lp_UpdateDSUserCRList

  begin
   l_Temp := TbsUserCRListInfo.Make;
   try
    // Проверим изменились ли параметры:
    if lp_IsUserCRListChanged then
     // Инициируем переполучение бизнес объктов:
     lp_UpdateDSUserCRList;
   finally
    l_Temp := nil;
   end;//try..finally
  end;//lp_InitUserCRList

const
 cNeedMakeDSArr: array[Boolean] of TvcmNeedMakeDS = (vcm_nmNo, vcm_nmYes);

  function lp_CheckRelatedDocNeedMakeDS: TvcmNeedMakeDS;
  begin
   Result := cNeedMakeDSArr[l_SDS.IsRelatedDocActive];
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=565006651
  end;

  function lp_CheckAttributesNeedMakeDS: TvcmNeedMakeDS;
  begin
   Result := cNeedMakeDSArr[l_SDS.IsAttributesActive];
  end;

//#UC END# *52EA619F02FA_4AA4D6C7036F_var*
begin
//#UC START# *52EA619F02FA_4AA4D6C7036F_impl*
 inherited;
 // Для инициализации флажков на сборке нужен реальный SDS, его SetData и
 // сам FormSet, т.к. эта инициализация вызывается перед Refresh, при уже
 // существующей сборке. Получить SDS и его SetData нужно как-то цивилизованнее
 if Supports(aParams.DataSource, IsdsList, l_SDS) then
 try
  if Supports(aParams.DataSource.DataForSave, IdList, l_SetData) then
  try
   if Supports(aParams.FormSet, IfstList, l_FormSet) then
   try
     if not afw.Settings.LoadBoolean(pi_Document_Sheets_Translation,
      dv_Document_Sheets_Translation) then
     l_SetData.dsTranslationRef.Clear;
     // Первый пользовательский список КР:
     lp_InitUserCRList(ulFirst);
     // Второй список КР:
     lp_InitUserCRList(ulSecond);
     // Если в качестве пользовательского СР выбраны "Все документы", то открывается
     // обычный СКР, который можно типизировать:
     l_FormSet.RespondentsNeedMakeDS := lpCRNeedMake(l_SDS.DsRespondentsRef, crtRespondents,
      l_FormSet.RespondentsNeedMakeDS);
     l_FormSet.CorrespondentsNeedMakeDS := lpCRNeedMake(l_SDS.DsCorrespondentsRef, crtCorrespondents,
      l_FormSet.CorrespondentsNeedMakeDS);
     l_FormSet.FiltersNeedMakeDS := CheckNeedMakeFilters(l_FormSet.FiltersNeedMakeDS);

    l_FormSet.RelatedDocNeedMakeDS := lp_CheckRelatedDocNeedMakeDS;

    l_FormSet.AttributesNeedMakeDS := lp_CheckAttributesNeedMakeDS;

   finally
    l_FormSet := nil;
   end;
  finally
   l_SetData := nil;
  end;
 finally
  l_SDS := nil;
 end;
//#UC END# *52EA619F02FA_4AA4D6C7036F_impl*
end;//Tfs_List.InitForms

initialization
 str_fsListCaption.Init;
 {* Инициализация str_fsListCaption }
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
