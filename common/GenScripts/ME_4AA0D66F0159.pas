unit Inpharm_Module;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Inpharm_Module.pas"
// Стереотип: "VCMFormsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimPrimListInterfaces
 , CommonDictionInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , Common_FormDefinitions_Controls
 , DictionContainerUserTypes_slqtMedicDiction_UserType
 , PrimCommonDiction_utMedicDiction_UserType
 , DynamicTreeUnit
 , DocumentUnit
 , bsTypesNew
 , DocumentUserTypes_dftMedDictEntry_UserType
 , DocumentAndListInterfaces
 , F1Like_FormDefinitions_Controls
 , AttributesUserTypes_fDocAttribute_UserType
 , BaseDocumentWithAttributesInterfaces
 , DocumentUserTypes_dftMedicFirm_UserType
 , nevTools
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , l3Interfaces
 , ListUserTypes_lftProducedDrugs_UserType
 , MedicInterfaces
 , DynamicDocListUnit
 , l3TreeInterfaces
 , PreviewInterfaces
 , l3InternalInterfaces
 , FiltersUnit
 , nsTypes
 , DocumentUserTypes_dftDrug_UserType
 , ContentsUserTypes_utDrugContents_UserType
 , WorkWithDocumentInterfaces
 , ListUserTypes_lftDrugInternationalNameSynonyms_UserType
 , PrimMedicListSynchroView_mlsfDrugList_UserType
 , DocumentUserTypes_dftDrugSynchroView_UserType
 , ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType
 , AttributesUserTypes_fAttributeSynchroView_UserType
 , ListUserTypes_lftDrugList_UserType
 , BaloonWarningUserTypes_remListModified_UserType
 , nevBase
 , BaloonWarningUserTypes_remListFiltered_UserType
 , BaloonWarningUserTypes_remTimeMachineWarning_UserType
 , FiltersUserTypes_utFilters_UserType
 , SimpleListInterfaces
 , ListInfoUserTypes_liListInfo_UserType
 , PrimMedicFirmList_mflMain_UserType
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , PrimMedicListSynchroView_mlsfMedicFirm_UserType
 , DocumentUserTypes_dftMedicFirmSynchroView_UserType
 , ListUserTypes_lftProducedDrugsSynchroForm_UserType
 , InpharmMainMenu_Form
 , PrimMedicFirmListOptions_Form
 , PrimMedicListSynchroView_Form
 , nsLogEvent
 , InpharmMainMenu_ut_mmmMain_UserType
 , InpharmInterfaces
;

type
 // en_CommonDiction_utMedicDiction

 // TextForm_dftMedDictEntry

 // AttributesForm_fDocAttribute

 // Child

 // DictionContainer

 Tfs_MedicDiction = {final} class(TvcmFormSetFactory)
  {* Словарь медицинских терминов }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function DictionContainer_Parent_slqtMedicDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для DictionContainer }
   function en_CommonDiction_utMedicDiction_Navigator_utMedicDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для en_CommonDiction_utMedicDiction }
   function TextForm_dftMedDictEntry_Parent_dftMedDictEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для TextForm_dftMedDictEntry }
   function Child_Child_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Child }
   function AttributesForm_fDocAttribute_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для AttributesForm_fDocAttribute }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_MedicDiction;
    {* Метод получения экземпляра синглетона Tfs_MedicDiction }
 end;//Tfs_MedicDiction

 // Text

 // List

 // Attributes

 Tfs_MedicFirmDocument = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Text_Parent_dftMedicFirm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function List_Child_lftProducedDrugs_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для List }
   function Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_MedicFirmDocument;
    {* Метод получения экземпляра синглетона Tfs_MedicFirmDocument }
 end;//Tfs_MedicFirmDocument

 // Text

 // Attributes

 // Contents

 // Synonyms

 Tfs_DrugDocument = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Text_Parent_dftDrug_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   function Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Attributes }
   function Contents_Navigator_utDrugContents_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Contents }
   function Synonyms_Child_lftDrugInternationalNameSynonyms_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Synonyms }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_DrugDocument;
    {* Метод получения экземпляра синглетона Tfs_DrugDocument }
 end;//Tfs_DrugDocument

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

 Ten_MedicMainMenu = {final} class(TInpharmMainMenuForm, MedicMainMenuFormDef)
  {* справочник ГАРАНТ-ИнФарм: Лекарства и фирмы }
 end;//Ten_MedicMainMenu

 Ten_MedicFirmList = {final} class(TPrimMedicFirmListOptionsForm, MedicFirmListFormDef)
  {* Фармацевтические фирмы (полный список) }
 end;//Ten_MedicFirmList

 Ten_MedicListSynchroView = {final} class(TPrimMedicListSynchroViewForm, MedicListSynchroViewFormDef)
  {* Синхронный просмотр }
 end;//Ten_MedicListSynchroView

 TnsOpenPharmFirmDocumentEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsOpenPharmFirmDocumentEvent

 TnsOpenPharmDocumentEvent = class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsOpenPharmDocumentEvent

 TnsOpenMedicDictionaryEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenMedicDictionaryEvent

 TnsOpenMedicFirmsEvent = class(TnsLogEvent)
  public
   class procedure Log;
 end;//TnsOpenMedicFirmsEvent

 // Main

 Tfs_InpharmMainMenu = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Main_Parent_ut_mmmMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Main }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_InpharmMainMenu;
    {* Метод получения экземпляра синглетона Tfs_InpharmMainMenu }
 end;//Tfs_InpharmMainMenu

 TInpharmModule = class
  protected
   procedure OpenMedicDictionPrim(const aSDS: IsdsCommonDiction;
    const aContainer: IvcmContainer);
   procedure MedicDiction;
    {* Словарь медицинских терминов }
   procedure MedicFirms; overload;
    {* Фармацевтические фирмы }
   procedure DrugList;
    {* Список выпускаемых препаратов }
   procedure MedicMainMenu;
    {* Основное меню ИнФарм }
  public
   procedure OpenMedicDiction(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenDrugDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenDrugList(const aList: IdeList;
    const aContainer: IvcmContainer);
   procedure MedicFirms(const aContainer: IvcmContainer); overload;
   procedure OpenInpharmMainMenu(const aContainer: IvcmContainer);
   procedure OpenDrugListIfNeeded(const aContainer: IvcmContainer);
 end;//TInpharmModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , sdsInpharmMainMenu
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 , SysUtils
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MedicMainMenuKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MedicFirmListKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , MedicListSynchroViewKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , LoggingUnit
 , sdsMedicDiction
 , sdsMedicFirmDocument
 , sdsDrugDocument
 , sdsDrugList
 , DataAdapter
 , deListSet
 , sdsMedicFirmList
;

var g_Tfs_MedicDiction: Tfs_MedicDiction = nil;
 {* Экземпляр синглетона Tfs_MedicDiction }
var g_Tfs_MedicFirmDocument: Tfs_MedicFirmDocument = nil;
 {* Экземпляр синглетона Tfs_MedicFirmDocument }
var g_Tfs_DrugDocument: Tfs_DrugDocument = nil;
 {* Экземпляр синглетона Tfs_DrugDocument }
var g_Tfs_DrugList: Tfs_DrugList = nil;
 {* Экземпляр синглетона Tfs_DrugList }
var g_Tfs_MedicFirmList: Tfs_MedicFirmList = nil;
 {* Экземпляр синглетона Tfs_MedicFirmList }
var g_Tfs_InpharmMainMenu: Tfs_InpharmMainMenu = nil;
 {* Экземпляр синглетона Tfs_InpharmMainMenu }

const
 {* Локализуемые строки MedicDictionCaptionLocalConstants }
 str_fsMedicDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicDictionCaption'; rValue : 'Словарь медицинских терминов');
  {* Заголовок фабрики сборки форм "MedicDiction" }

const
 {* Локализуемые строки MedicFirmDocumentCaptionLocalConstants }
 str_fsMedicFirmDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicFirmDocumentCaption'; rValue : 'Описание фирмы');
  {* Заголовок фабрики сборки форм "MedicFirmDocument" }

const
 {* Локализуемые строки DrugDocumentCaptionLocalConstants }
 str_fsDrugDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDrugDocumentCaption'; rValue : 'Препарат');
  {* Заголовок фабрики сборки форм "DrugDocument" }

const
 {* Локализуемые строки DrugListCaptionLocalConstants }
 str_fsDrugListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDrugListCaption'; rValue : 'Список препаратов');
  {* Заголовок фабрики сборки форм "DrugList" }

const
 {* Локализуемые строки MedicFirmListCaptionLocalConstants }
 str_fsMedicFirmListCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsMedicFirmListCaption'; rValue : 'Фармацевтические фирмы');
  {* Заголовок фабрики сборки форм "MedicFirmList" }

procedure Tfs_MedicDictionFree;
 {* Метод освобождения экземпляра синглетона Tfs_MedicDiction }
begin
 l3Free(g_Tfs_MedicDiction);
end;//Tfs_MedicDictionFree

procedure Tfs_MedicFirmDocumentFree;
 {* Метод освобождения экземпляра синглетона Tfs_MedicFirmDocument }
begin
 l3Free(g_Tfs_MedicFirmDocument);
end;//Tfs_MedicFirmDocumentFree

procedure Tfs_DrugDocumentFree;
 {* Метод освобождения экземпляра синглетона Tfs_DrugDocument }
begin
 l3Free(g_Tfs_DrugDocument);
end;//Tfs_DrugDocumentFree

procedure Tfs_DrugListFree;
 {* Метод освобождения экземпляра синглетона Tfs_DrugList }
begin
 l3Free(g_Tfs_DrugList);
end;//Tfs_DrugListFree

procedure Tfs_MedicFirmListFree;
 {* Метод освобождения экземпляра синглетона Tfs_MedicFirmList }
begin
 l3Free(g_Tfs_MedicFirmList);
end;//Tfs_MedicFirmListFree

procedure Tfs_InpharmMainMenuFree;
 {* Метод освобождения экземпляра синглетона Tfs_InpharmMainMenu }
begin
 l3Free(g_Tfs_InpharmMainMenu);
end;//Tfs_InpharmMainMenuFree

function Tfs_MedicDiction.DictionContainer_Parent_slqtMedicDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для DictionContainer }
//#UC START# *2E79C71E8DBE_4AA12BA501E4_var*
//#UC END# *2E79C71E8DBE_4AA12BA501E4_var*
begin
//#UC START# *2E79C71E8DBE_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E79C71E8DBE_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.DictionContainer_Parent_slqtMedicDiction_NeedMakeForm

function Tfs_MedicDiction.en_CommonDiction_utMedicDiction_Navigator_utMedicDiction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для en_CommonDiction_utMedicDiction }
//#UC START# *05BB4AF4B2B3_4AA12BA501E4_var*
//#UC END# *05BB4AF4B2B3_4AA12BA501E4_var*
begin
//#UC START# *05BB4AF4B2B3_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *05BB4AF4B2B3_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.en_CommonDiction_utMedicDiction_Navigator_utMedicDiction_NeedMakeForm

function Tfs_MedicDiction.TextForm_dftMedDictEntry_Parent_dftMedDictEntry_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для TextForm_dftMedDictEntry }
//#UC START# *9CD5DFE766E3_4AA12BA501E4_var*
//#UC END# *9CD5DFE766E3_4AA12BA501E4_var*
begin
//#UC START# *9CD5DFE766E3_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *9CD5DFE766E3_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.TextForm_dftMedDictEntry_Parent_dftMedDictEntry_NeedMakeForm

function Tfs_MedicDiction.Child_Child_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Child }
//#UC START# *C55392708AE7_4AA12BA501E4_var*
//#UC END# *C55392708AE7_4AA12BA501E4_var*
begin
//#UC START# *C55392708AE7_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *C55392708AE7_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.Child_Child_NeedMakeForm

function Tfs_MedicDiction.AttributesForm_fDocAttribute_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для AttributesForm_fDocAttribute }
//#UC START# *7A8349EDE74B_4AA12BA501E4_var*
//#UC END# *7A8349EDE74B_4AA12BA501E4_var*
begin
//#UC START# *7A8349EDE74B_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A8349EDE74B_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.AttributesForm_fDocAttribute_Child_fDocAttribute_NeedMakeForm

class function Tfs_MedicDiction.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_MedicDiction <> nil;
end;//Tfs_MedicDiction.Exists

class function Tfs_MedicDiction.Instance: Tfs_MedicDiction;
 {* Метод получения экземпляра синглетона Tfs_MedicDiction }
begin
 if (g_Tfs_MedicDiction = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicDictionFree);
  g_Tfs_MedicDiction := Create;
 end;
 Result := g_Tfs_MedicDiction;
end;//Tfs_MedicDiction.Instance

procedure Tfs_MedicDiction.InitFields;
//#UC START# *47A042E100E2_4AA12BA501E4_var*
//#UC END# *47A042E100E2_4AA12BA501E4_var*
begin
//#UC START# *47A042E100E2_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_MedicDiction.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA12BA501E4_var*
//#UC END# *4FFE854A009B_4AA12BA501E4_var*
begin
//#UC START# *4FFE854A009B_4AA12BA501E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA12BA501E4_impl*
end;//Tfs_MedicDiction.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

function Tfs_MedicFirmDocument.Text_Parent_dftMedicFirm_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *D85D66FEA6B3_4AA12BC400A6_var*
//#UC END# *D85D66FEA6B3_4AA12BC400A6_var*
begin
//#UC START# *D85D66FEA6B3_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *D85D66FEA6B3_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.Text_Parent_dftMedicFirm_NeedMakeForm

function Tfs_MedicFirmDocument.List_Child_lftProducedDrugs_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для List }
//#UC START# *994991B7C174_4AA12BC400A6_var*
//#UC END# *994991B7C174_4AA12BC400A6_var*
begin
//#UC START# *994991B7C174_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *994991B7C174_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.List_Child_lftProducedDrugs_NeedMakeForm

function Tfs_MedicFirmDocument.Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
//#UC START# *7DB1333E9147_4AA12BC400A6_var*
//#UC END# *7DB1333E9147_4AA12BC400A6_var*
begin
//#UC START# *7DB1333E9147_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *7DB1333E9147_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.Attributes_Child_fDocAttribute_NeedMakeForm

class function Tfs_MedicFirmDocument.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_MedicFirmDocument <> nil;
end;//Tfs_MedicFirmDocument.Exists

class function Tfs_MedicFirmDocument.Instance: Tfs_MedicFirmDocument;
 {* Метод получения экземпляра синглетона Tfs_MedicFirmDocument }
begin
 if (g_Tfs_MedicFirmDocument = nil) then
 begin
  l3System.AddExitProc(Tfs_MedicFirmDocumentFree);
  g_Tfs_MedicFirmDocument := Create;
 end;
 Result := g_Tfs_MedicFirmDocument;
end;//Tfs_MedicFirmDocument.Instance

procedure Tfs_MedicFirmDocument.InitFields;
//#UC START# *47A042E100E2_4AA12BC400A6_var*
//#UC END# *47A042E100E2_4AA12BC400A6_var*
begin
//#UC START# *47A042E100E2_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_MedicFirmDocument.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA12BC400A6_var*
//#UC END# *4FFE854A009B_4AA12BC400A6_var*
begin
//#UC START# *4FFE854A009B_4AA12BC400A6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA12BC400A6_impl*
end;//Tfs_MedicFirmDocument.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

function Tfs_DrugDocument.Text_Parent_dftDrug_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *3DC42139205B_4AA12BE1014F_var*
//#UC END# *3DC42139205B_4AA12BE1014F_var*
begin
//#UC START# *3DC42139205B_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *3DC42139205B_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.Text_Parent_dftDrug_NeedMakeForm

function Tfs_DrugDocument.Attributes_Child_fDocAttribute_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Attributes }
//#UC START# *E2D36E154285_4AA12BE1014F_var*
//#UC END# *E2D36E154285_4AA12BE1014F_var*
begin
//#UC START# *E2D36E154285_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *E2D36E154285_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.Attributes_Child_fDocAttribute_NeedMakeForm

function Tfs_DrugDocument.Contents_Navigator_utDrugContents_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Contents }
//#UC START# *D6D6612D957E_4AA12BE1014F_var*
//#UC END# *D6D6612D957E_4AA12BE1014F_var*
begin
//#UC START# *D6D6612D957E_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *D6D6612D957E_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.Contents_Navigator_utDrugContents_NeedMakeForm

function Tfs_DrugDocument.Synonyms_Child_lftDrugInternationalNameSynonyms_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Synonyms }
//#UC START# *2B6BF0B8EC3B_4AA12BE1014F_var*
//#UC END# *2B6BF0B8EC3B_4AA12BE1014F_var*
begin
//#UC START# *2B6BF0B8EC3B_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *2B6BF0B8EC3B_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.Synonyms_Child_lftDrugInternationalNameSynonyms_NeedMakeForm

class function Tfs_DrugDocument.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_DrugDocument <> nil;
end;//Tfs_DrugDocument.Exists

class function Tfs_DrugDocument.Instance: Tfs_DrugDocument;
 {* Метод получения экземпляра синглетона Tfs_DrugDocument }
begin
 if (g_Tfs_DrugDocument = nil) then
 begin
  l3System.AddExitProc(Tfs_DrugDocumentFree);
  g_Tfs_DrugDocument := Create;
 end;
 Result := g_Tfs_DrugDocument;
end;//Tfs_DrugDocument.Instance

procedure Tfs_DrugDocument.InitFields;
//#UC START# *47A042E100E2_4AA12BE1014F_var*
//#UC END# *47A042E100E2_4AA12BE1014F_var*
begin
//#UC START# *47A042E100E2_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_DrugDocument.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA12BE1014F_var*
//#UC END# *4FFE854A009B_4AA12BE1014F_var*
begin
//#UC START# *4FFE854A009B_4AA12BE1014F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA12BE1014F_impl*
end;//Tfs_DrugDocument.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

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

class procedure TnsOpenPharmFirmDocumentEvent.Log(const aDoc: IDocument);
//#UC START# *4B14D8D10222_4B14D8AE00D4_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B14D8D10222_4B14D8AE00D4_var*
begin
//#UC START# *4B14D8D10222_4B14D8AE00D4_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_OPEN_PHARM_FIRM_DOCUMENT, l_Data);
//#UC END# *4B14D8D10222_4B14D8AE00D4_impl*
end;//TnsOpenPharmFirmDocumentEvent.Log

class procedure TnsOpenPharmDocumentEvent.Log(const aDoc: IDocument);
//#UC START# *4B14D98900BD_4B14D96C038A_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B14D98900BD_4B14D96C038A_var*
begin
//#UC START# *4B14D98900BD_4B14D96C038A_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_OPEN_PHARM_DOCUMENT, l_Data);
//#UC END# *4B14D98900BD_4B14D96C038A_impl*
end;//TnsOpenPharmDocumentEvent.Log

class procedure TnsOpenMedicDictionaryEvent.Log;
//#UC START# *4B14DA27026F_4B14DA170298_var*
//#UC END# *4B14DA27026F_4B14DA170298_var*
begin
//#UC START# *4B14DA27026F_4B14DA170298_impl*
 GetLogger.AddEvent(LE_OPEN_MEDIC_DICTIONARY, MakeParamsList);
//#UC END# *4B14DA27026F_4B14DA170298_impl*
end;//TnsOpenMedicDictionaryEvent.Log

class procedure TnsOpenMedicFirmsEvent.Log;
//#UC START# *4B14DA6B00F9_4B14DA6101E3_var*
//#UC END# *4B14DA6B00F9_4B14DA6101E3_var*
begin
//#UC START# *4B14DA6B00F9_4B14DA6101E3_impl*
 GetLogger.AddEvent(LE_OPEN_MEDIC_FIRMS, MakeParamsList);
//#UC END# *4B14DA6B00F9_4B14DA6101E3_impl*
end;//TnsOpenMedicFirmsEvent.Log

function Tfs_InpharmMainMenu.Main_Parent_ut_mmmMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Main }
//#UC START# *C1D9743E0694_550C0EE00301_var*
//#UC END# *C1D9743E0694_550C0EE00301_var*
begin
//#UC START# *C1D9743E0694_550C0EE00301_impl*
 !!! Needs to be implemented !!!
//#UC END# *C1D9743E0694_550C0EE00301_impl*
end;//Tfs_InpharmMainMenu.Main_Parent_ut_mmmMain_NeedMakeForm

class function Tfs_InpharmMainMenu.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_InpharmMainMenu <> nil;
end;//Tfs_InpharmMainMenu.Exists

class function Tfs_InpharmMainMenu.Instance: Tfs_InpharmMainMenu;
 {* Метод получения экземпляра синглетона Tfs_InpharmMainMenu }
begin
 if (g_Tfs_InpharmMainMenu = nil) then
 begin
  l3System.AddExitProc(Tfs_InpharmMainMenuFree);
  g_Tfs_InpharmMainMenu := Create;
 end;
 Result := g_Tfs_InpharmMainMenu;
end;//Tfs_InpharmMainMenu.Instance

procedure Tfs_InpharmMainMenu.InitFields;
//#UC START# *47A042E100E2_550C0EE00301_var*
//#UC END# *47A042E100E2_550C0EE00301_var*
begin
//#UC START# *47A042E100E2_550C0EE00301_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_550C0EE00301_impl*
end;//Tfs_InpharmMainMenu.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_InpharmMainMenu.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_550C0EE00301_var*
//#UC END# *4FFE854A009B_550C0EE00301_var*
begin
//#UC START# *4FFE854A009B_550C0EE00301_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_550C0EE00301_impl*
end;//Tfs_InpharmMainMenu.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

procedure TInpharmModule.OpenMedicDiction(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
//#UC START# *4AA11B7A0009_4AA0D66F0159_var*
//#UC END# *4AA11B7A0009_4AA0D66F0159_var*
begin
//#UC START# *4AA11B7A0009_4AA0D66F0159_impl*
 OpenMedicDictionPrim(TsdsMedicDiction.Make(aDocInfo), aContainer);
//#UC END# *4AA11B7A0009_4AA0D66F0159_impl*
end;//TInpharmModule.OpenMedicDiction

procedure TInpharmModule.OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
//#UC START# *4AA11BE70139_4AA0D66F0159_var*
//#UC END# *4AA11BE70139_4AA0D66F0159_var*
begin
//#UC START# *4AA11BE70139_4AA0D66F0159_impl*
 TnsOpenPharmFirmDocumentEvent.Log(aDocInfo.Doc);
 Tfs_MedicFirmDocument.Make(TsdsMedicFirmDocument.Make(aDocInfo),
                            aContainer);
//#UC END# *4AA11BE70139_4AA0D66F0159_impl*
end;//TInpharmModule.OpenMedicFirmDocument

procedure TInpharmModule.OpenDrugDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
//#UC START# *4AA11CE70112_4AA0D66F0159_var*
//#UC END# *4AA11CE70112_4AA0D66F0159_var*
begin
//#UC START# *4AA11CE70112_4AA0D66F0159_impl*
 TnsOpenPharmDocumentEvent.Log(aDocInfo.Doc);
 Tfs_DrugDocument.Make(TsdsDrugDocument.Make(aDocInfo), aContainer);
//#UC END# *4AA11CE70112_4AA0D66F0159_impl*
end;//TInpharmModule.OpenDrugDocument

procedure TInpharmModule.OpenDrugList(const aList: IdeList;
 const aContainer: IvcmContainer);
//#UC START# *4AA4D413008C_4AA0D66F0159_var*
//#UC END# *4AA4D413008C_4AA0D66F0159_var*
begin
//#UC START# *4AA4D413008C_4AA0D66F0159_impl*
 Tfs_DrugList.Make(TsdsDrugList.Make(aList), aContainer);
//#UC END# *4AA4D413008C_4AA0D66F0159_impl*
end;//TInpharmModule.OpenDrugList

procedure TInpharmModule.OpenMedicDictionPrim(const aSDS: IsdsCommonDiction;
 const aContainer: IvcmContainer);
//#UC START# *4AA52C670101_4AA0D66F0159_var*
//#UC END# *4AA52C670101_4AA0D66F0159_var*
begin
//#UC START# *4AA52C670101_4AA0D66F0159_impl*
 TnsOpenMedicDictionaryEvent.Log;
 Tfs_MedicDiction.Make(aSDS, aContainer);
//#UC END# *4AA52C670101_4AA0D66F0159_impl*
end;//TInpharmModule.OpenMedicDictionPrim

procedure TInpharmModule.MedicDiction;
 {* Словарь медицинских терминов }
//#UC START# *4AB9FC8F027A_4AA0D66F0159_var*
//#UC END# *4AB9FC8F027A_4AA0D66F0159_var*
begin
//#UC START# *4AB9FC8F027A_4AA0D66F0159_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9FC8F027A_4AA0D66F0159_impl*
end;//TInpharmModule.MedicDiction

procedure TInpharmModule.MedicFirms;
 {* Фармацевтические фирмы }
//#UC START# *4AB9FCE902EC_4AA0D66F0159_var*
//#UC END# *4AB9FCE902EC_4AA0D66F0159_var*
begin
//#UC START# *4AB9FCE902EC_4AA0D66F0159_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9FCE902EC_4AA0D66F0159_impl*
end;//TInpharmModule.MedicFirms

procedure TInpharmModule.DrugList;
 {* Список выпускаемых препаратов }
//#UC START# *4AB9FD0601CF_4AA0D66F0159_var*
//#UC END# *4AB9FD0601CF_4AA0D66F0159_var*
begin
//#UC START# *4AB9FD0601CF_4AA0D66F0159_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9FD0601CF_4AA0D66F0159_impl*
end;//TInpharmModule.DrugList

procedure TInpharmModule.MedicMainMenu;
 {* Основное меню ИнФарм }
//#UC START# *4AB9FD6F017A_4AA0D66F0159_var*
//#UC END# *4AB9FD6F017A_4AA0D66F0159_var*
begin
//#UC START# *4AB9FD6F017A_4AA0D66F0159_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB9FD6F017A_4AA0D66F0159_impl*
end;//TInpharmModule.MedicMainMenu

procedure TInpharmModule.MedicFirms(const aContainer: IvcmContainer);
//#UC START# *4AC0F93D01AB_4AA0D66F0159_var*
//#UC END# *4AC0F93D01AB_4AA0D66F0159_var*
begin
//#UC START# *4AC0F93D01AB_4AA0D66F0159_impl*
 if defDataAdapter.IsInpharmExists AND
    not CheckContainer(aContainer).HasForm(fm_en_MedicFirmList.rFormID,
                                           vcm_ztMain,
                                           True,
                                           nil,
                                           Ord(mflMain)) then
 begin
  TnsOpenMedicFirmsEvent.Log;
  Tfs_MedicFirmList.Make(TsdsMedicFirmList.Make(nil),
                         CheckContainer(aContainer));
 end;//not lp_HasListForm
//#UC END# *4AC0F93D01AB_4AA0D66F0159_impl*
end;//TInpharmModule.MedicFirms

procedure TInpharmModule.OpenInpharmMainMenu(const aContainer: IvcmContainer);
//#UC START# *530340E702A3_4AA0D66F0159_var*
//#UC END# *530340E702A3_4AA0D66F0159_var*
begin
//#UC START# *530340E702A3_4AA0D66F0159_impl*
  if defDataAdapter.IsInpharmExists then
  begin
   l_FormId := fm_en_MedicMainMenu.rFormID;
   if CheckContainer(aContainer).NativeMainForm.HasForm(l_FormId, vcm_ztParent) then
    Exit;
   //Ten_MedicMainMenu.Make(vcmMakeParams(nil, CheckContainer(aContainer)), vcm_ztParent, Ord(ut_mmmMain));
   Tfs_InpharmMainMenu.Make(TsdsInpharmMainMenu.Make, CheckContainer(aContainer));
  end;//defDataAdapter.IsInpharmExists
//#UC END# *530340E702A3_4AA0D66F0159_impl*
end;//TInpharmModule.OpenInpharmMainMenu

procedure TInpharmModule.OpenDrugListIfNeeded(const aContainer: IvcmContainer);
//#UC START# *530513060354_4AA0D66F0159_var*
//#UC END# *530513060354_4AA0D66F0159_var*
begin
//#UC START# *530513060354_4AA0D66F0159_impl*
 TdmStdRes.OpenList(TdeListSet.Make(defDataAdapter.NativeAdapter.MakeDynList(SLK_ALL_ALLOWED_DRUGS)), aContainer);
//#UC END# *530513060354_4AA0D66F0159_impl*
end;//TInpharmModule.OpenDrugListIfNeeded

initialization
 str_fsMedicDictionCaption.Init;
 {* Инициализация str_fsMedicDictionCaption }
 str_fsMedicFirmDocumentCaption.Init;
 {* Инициализация str_fsMedicFirmDocumentCaption }
 str_fsDrugDocumentCaption.Init;
 {* Инициализация str_fsDrugDocumentCaption }
 str_fsDrugListCaption.Init;
 {* Инициализация str_fsDrugListCaption }
 str_fsMedicFirmListCaption.Init;
 {* Инициализация str_fsMedicFirmListCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MedicMainMenu);
 {* Регистрация MedicMainMenu }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_MedicMainMenu.SetFactory(Ten_MedicMainMenu.Make);
 {* Регистрация фабрики формы MedicMainMenu }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MedicFirmList);
 {* Регистрация MedicFirmList$Form }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_MedicFirmList.SetFactory(Ten_MedicFirmList.Make);
 {* Регистрация фабрики формы MedicFirmList$Form }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_MedicListSynchroView);
 {* Регистрация MedicListSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
 fm_en_MedicListSynchroView.SetFactory(Ten_MedicListSynchroView.Make);
 {* Регистрация фабрики формы MedicListSynchroView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
