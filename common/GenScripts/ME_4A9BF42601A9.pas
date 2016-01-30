unit List_Module;
 {* Работа со списком документов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\List_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , bsOpenListInfo
 , DocumentInterfaces
 , PrimPrimListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3TreeInterfaces
 , PrimListOptions_Form
 , Common_FormDefinitions_Controls
 , PrimListInfoOptions_Form
 , PrimListAnalizer_Form
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
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
 , l3StringIDEx
 , ListUserTypes_lftNone_UserType
 , WorkWithListInterfaces
 , bsTypes
 , l3Interfaces
 , l3Tree_TLB
 , afwInterfaces
 , DynamicDocListUnit
 , DynamicTreeUnit
 , DocumentUnit
 , PreviewInterfaces
 , l3InternalInterfaces
 , PrimListInterfaces
 , FiltersUnit
 , nsTypes
 , BaloonWarningUserTypes_remListModified_UserType
 , nevBase
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , ListInfoUserTypes_liListInfo_UserType
 , FiltersUserTypes_utFilters_UserType
 , SimpleListInterfaces
 , SynchroViewUserTypes_svSynchroView_UserType
 , nevTools
 , evdInterfaces
 , DocumentAndListInterfaces
 , FoldersDomainInterfaces
 , bsTypesNew
 , DocumentUserTypes_dftDocSynchroView_UserType
 , BaloonWarningUserTypes_WarnJuror_UserType
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_WarnOnControl_UserType
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , BaloonWarningUserTypes_WarnRedaction_UserType
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
 , ListAnalizeUserTypes_Analize_UserType
 , PrimListAnalize_Form
;

const
 fm_ListAnalizerForm: TvcmFormDescriptor = (rFormID : (rName : 'ListAnalizerForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TListAnalizerForm }

type
 TefList = {final} class(TPrimListOptionsForm, ListFormDef)
  {* Список }
 end;//TefList

 TefListInfo = {final} class(TPrimListInfoOptionsForm, ListInfoFormDef)
  {* Справка к списку }
 end;//TefListInfo

 ListAnalizerFormDef = interface
  {* Идентификатор формы ListAnalizer }
  ['{534B1ADF-ACC6-4DD9-AF54-C92914E3CBA4}']
 end;//ListAnalizerFormDef

 TListAnalizerForm = {final} class(TPrimListAnalizerForm, ListAnalizerFormDef)
  {* Анализ списка }
 end;//TListAnalizerForm

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

 TListAnalizeForm = {final} class(TPrimListAnalizeForm, ListAnalizeFormDef)
  {* Анализ списка }
 end;//TListAnalizeForm

 TListModule = class
  {* Работа со списком документов }
  protected
   function TryOpenDocument(const aList: IdeList;
    const aContainer: IvcmContainer): Boolean;
  public
   procedure MakeListAnalizer(const aTree: Il3SimpleTree);
   procedure OpenList(const aList: IdeList;
    const aContainer: IvcmContainer);
    {* Открывает список в указанном контейнере }
   procedure OpenListWithReplace(const aList: IdeList;
    const aContainer: IvcmContainer);
    {* Открывает список в указанном контейнере. БЕЗ сохранения в историю. [$164601301] }
 end;//TListModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DocumentUserTypes_dftDrugSynchroView_UserType
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , nsListEvents
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , PresentationInterfaces
 , resWarnImages
 , Base_Operations_Strange_Controls
 , Search_Strange_Controls
 , WorkWithList_ListOperations_Controls
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ListAnalizerKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , SysUtils
 , l3Base
 {$If NOT Defined(NoScripts)}
 , ListAnalizeKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , sdsList
 , ListInterfaces
;

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

{$If NOT Defined(NoVCM)}
class function Tfs_List.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA4D6C7036F_var*
//#UC END# *4FFE854A009B_4AA4D6C7036F_var*
begin
//#UC START# *4FFE854A009B_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA4D6C7036F_impl*
end;//Tfs_List.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function Tfs_List.GetFormSetImplementation: RvcmFormSet;
 {* Возвращает класс реализации сборки }
//#UC START# *52973E60005E_4AA4D6C7036F_var*
//#UC END# *52973E60005E_4AA4D6C7036F_var*
begin
//#UC START# *52973E60005E_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52973E60005E_4AA4D6C7036F_impl*
end;//Tfs_List.GetFormSetImplementation
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure Tfs_List.InitForms(const aParams: IvcmFormSetRefreshParams);
 {* Вызывается при создании сборки перед Refresh для инициализации нужных флажков на сборке. }
//#UC START# *52EA619F02FA_4AA4D6C7036F_var*
//#UC END# *52EA619F02FA_4AA4D6C7036F_var*
begin
//#UC START# *52EA619F02FA_4AA4D6C7036F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52EA619F02FA_4AA4D6C7036F_impl*
end;//Tfs_List.InitForms
{$IfEnd} // NOT Defined(NoVCM)

function TListModule.TryOpenDocument(const aList: IdeList;
 const aContainer: IvcmContainer): Boolean;
//#UC START# *4AA4D7EA0094_4A9BF42601A9_var*
//#UC END# *4AA4D7EA0094_4A9BF42601A9_var*
begin
//#UC START# *4AA4D7EA0094_4A9BF42601A9_impl*
 l_Info := TbsOpenListInfo.Create(aList);
 try
  case l_Info.LinkType of
   ltDocument:
   begin
    if (l_Info.Data = nil) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=296626118
    // - видимо список пустой и открывать ничего не получится
     Result := false
    else
    begin
     Result := True;
     l_DocInfo := l_Info.Data As IdeDocInfo;
     TnsOpenDocumentFromListEvent.Log(l_DocInfo);
     TdmStdRes.OpenDocument(l_DocInfo, aContainer);
     l_DocInfo := nil;
    end;//l_Info.Data = nil
   end;//ltDocument
   ltList:
    Result := False;
   else
   begin
    Assert(False);
    Result := False;
   end;//else
  end;//case l_Info.LinkType of
 finally
  FreeAndNil(l_Info);
 end;//try..finally
//#UC END# *4AA4D7EA0094_4A9BF42601A9_impl*
end;//TListModule.TryOpenDocument

procedure TListModule.MakeListAnalizer(const aTree: Il3SimpleTree);
//#UC START# *4AA4DB140235_4A9BF42601A9_var*
//#UC END# *4AA4DB140235_4A9BF42601A9_var*
begin
//#UC START# *4AA4DB140235_4A9BF42601A9_impl*
 if (aTree = nil) then
  vcmSay(str_MissingAnalisisTree, [DefDataAdapter.GetDealerInfo], mtInformation)
 else
  TListAnalizerForm.Make(aTree, vcmMakeParams(nil, DefaultContainer), vcm_ztModal);
//#UC END# *4AA4DB140235_4A9BF42601A9_impl*
end;//TListModule.MakeListAnalizer

procedure TListModule.OpenList(const aList: IdeList;
 const aContainer: IvcmContainer);
 {* Открывает список в указанном контейнере }
//#UC START# *4AA4DB5100EF_4A9BF42601A9_var*
//#UC END# *4AA4DB5100EF_4A9BF42601A9_var*
begin
//#UC START# *4AA4DB5100EF_4A9BF42601A9_impl*
 if not TryOpenDocument(aList, aContainer) then
  case aList.List.GetContentType of
   DLC_LEGAL_DOCUMENTS:
    Tfs_List.Make(TsdsList.Make(aList As IdeDocumentList),
                  CheckContainer(aContainer));
   DLC_MEDICAL_DOCUMENTS:
   begin
    l_Cont := CheckContainer(aContainer);
    TdmStdRes.OpenDrugList(aList, l_Cont);
    // Синхронный просмотр открыт по умолчанию (CQ: OIT5-29213):
    // http://mdp.garant.ru/pages/viewpage.action?pageId=96484558
    if l_Cont.HasForm(fm_TextForm.rFormID,
                      vcm_ztAny,
                      True,
                      @l_Form,
                      dftDrugSynchroView) then
     l_Form.SetActiveInParent;
   end;
  end;//case aList.List.GetContentType of
//#UC END# *4AA4DB5100EF_4A9BF42601A9_impl*
end;//TListModule.OpenList

procedure TListModule.OpenListWithReplace(const aList: IdeList;
 const aContainer: IvcmContainer);
 {* Открывает список в указанном контейнере. БЕЗ сохранения в историю. [$164601301] }
//#UC START# *4AA4EF7803A4_4A9BF42601A9_var*
//#UC END# *4AA4EF7803A4_4A9BF42601A9_var*
begin
//#UC START# *4AA4EF7803A4_4A9BF42601A9_impl*
 if not TryOpenDocument(aList, aContainer) then
  Tfs_List.Make(TsdsList.Make(aList As IdeDocumentList),
                aContainer,
                false);
//#UC END# *4AA4EF7803A4_4A9BF42601A9_impl*
end;//TListModule.OpenListWithReplace

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefList);
 {* Регистрация List }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efList.SetFactory(TefList.Make);
 {* Регистрация фабрики формы List }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TefListInfo);
 {* Регистрация ListInfo }
{$IfEnd} // NOT Defined(NoScripts)
 fm_efListInfo.SetFactory(TefListInfo.Make);
 {* Регистрация фабрики формы ListInfo }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TListAnalizerForm);
 {* Регистрация ListAnalizer }
{$IfEnd} // NOT Defined(NoScripts)
 str_fsListCaption.Init;
 {* Инициализация str_fsListCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TListAnalizeForm);
 {* Регистрация ListAnalize }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ListAnalizeForm.SetFactory(TListAnalizeForm.Make);
 {* Регистрация фабрики формы ListAnalize }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
