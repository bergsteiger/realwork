unit Document_Module;
 {* Работа с документом }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Document_Module.pas"
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
 , DocumentUnit
 , DocumentDomainInterfaces
 , NavigationInterfaces
 , PresentationInterfaces
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimDocumentWithFlashOptions_Form
 , Common_FormDefinitions_Controls
 , ExTextOptions_Form
 , PrimRedactionsOptions_Form
 , PrimContentsOptions_Form
 , fsAbstractDocument
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
 , DocumentUserTypes_dftDocument_UserType
 , nevTools
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , bsTypesNew
 , l3Interfaces
 , BaloonWarningUserTypes_WarnJuror_UserType
 , WorkWithDocumentInterfaces
 , nsTypes
 , nevBase
 , BaloonWarningUserTypes_WarnPreActive_UserType
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 , BaloonWarningUserTypes_WarnOnControl_UserType
 , BaloonWarningUserTypes_WarnInactualDocument_UserType
 , BaloonWarningUserTypes_WarnTimeMachineOn_UserType
 , BaloonWarningUserTypes_WarnRedaction_UserType
 , BaloonWarningUserTypes_WarnTimeMachineWarning_UserType
 , BaloonWarningUserTypes_WarnTimeMachineException_UserType
 , DocumentWithFlashUserTypes_dwftMain_UserType
 , DocInfoInterfaces
 , evdInterfaces
 , PrimPictureOptions_Form
 , PrimPictureInfoOptions_Form
 , PrimDocNumberQueryOptions_Form
 , PrimDockedWarning_Form
 , PrimAttributesOptions_Form
 , PrimSynchroViewOptions_Form
 , PrimTurnOnTimeMachineOptions_Form
 , nsLogEvent
 , PrimWarningBaloonOptions_Form
;

const
 fm_PictureForm: TvcmFormDescriptor = (rFormID : (rName : 'PictureForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TPictureForm }

const
 fm_DocNumberQueryForm: TvcmFormDescriptor = (rFormID : (rName : 'DocNumberQueryForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TDocNumberQueryForm }

const
 fm_en_TurnOnTimeMachine: TvcmFormDescriptor = (rFormID : (rName : 'en_TurnOnTimeMachine'; rID : 0); rFactory : nil);
  {* Идентификатор формы Ten_TurnOnTimeMachine }

type
 TDocumentWithFlashForm = {final} class(TPrimDocumentWithFlashOptionsForm, DocumentWithFlashFormDef)
 end;//TDocumentWithFlashForm

 TTextForm = {final} class(TExTextOptionsForm, TextFormDef)
  {* Текст документа }
 end;//TTextForm

 TRedactionsForm = {final} class(TPrimRedactionsOptionsForm, RedactionsFormDef)
  {* Редакции }
 end;//TRedactionsForm

 TContentsForm = {final} class(TPrimContentsOptionsForm, ContentsFormDef)
  {* Структура документа }
 end;//TContentsForm

 // WarnJuror

 // WarnPreActive

 // WarnIsAbolished

 // WarnOnControl

 // WarnInactualDocument

 // WarnTimeMachineOn

 // WarnRedaction

 // WarnTimeMachineWarning

 // WarnTimeMachineException

 // Text

 Tfs_Document = {final} class(Tfs_AbstractDocument)
  {* Документ }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Text_Parent_dftDocument_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
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
   function WarnTimeMachineOn_Child_WarnTimeMachineOn_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnTimeMachineOn }
   function WarnRedaction_Child_WarnRedaction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnRedaction }
   function WarnTimeMachineWarning_Child_WarnTimeMachineWarning_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnTimeMachineWarning }
   function WarnTimeMachineException_Child_WarnTimeMachineException_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для WarnTimeMachineException }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_Document;
    {* Метод получения экземпляра синглетона Tfs_Document }
 end;//Tfs_Document

 // Text

 Tfs_DocumentWithFlash = {final} class(Tfs_AbstractDocument)
  {* Схема }
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Text_Parent_dwftMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Text }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_DocumentWithFlash;
    {* Метод получения экземпляра синглетона Tfs_DocumentWithFlash }
 end;//Tfs_DocumentWithFlash

 PictureFormDef = interface
  {* Идентификатор формы Picture }
  ['{9794D84D-10DE-4BC6-A05D-F4C88FBEEBC7}']
 end;//PictureFormDef

 //#UC START# *4AAFCF930362ci*
 //#UC END# *4AAFCF930362ci*
 //#UC START# *4AAFCF930362cit*
 //#UC END# *4AAFCF930362cit*
 TPictureForm = {final} class(TPrimPictureOptionsForm, PictureFormDef)
  {* Рисунок }
 //#UC START# *4AAFCF930362publ*
 //#UC END# *4AAFCF930362publ*
 end;//TPictureForm

 Ten_PictureInfo = {final} class(TPrimPictureInfoOptionsForm)
  {* Информация о картинке }
 end;//Ten_PictureInfo

 DocNumberQueryFormDef = interface
  {* Идентификатор формы DocNumberQuery }
  ['{A522FA71-1132-495B-A68D-0533C12052F1}']
 end;//DocNumberQueryFormDef

 TDocNumberQueryForm = {final} class(TPrimDocNumberQueryOptionsForm, DocNumberQueryFormDef)
  {* Открыть документ по номеру }
 end;//TDocNumberQueryForm

 TWarningForm = {final} class(TPrimDockedWarningForm, WarningFormDef)
  {* Предупреждение }
 end;//TWarningForm

 TAttributesForm = {final} class(TPrimAttributesOptionsForm, AttributesFormDef)
  {* Информация о документе }
 end;//TAttributesForm

 TfcSynchroView = {final} class(TPrimSynchroViewOptionsForm, SynchroViewFormDef)
  {* Синхронный просмотр }
 end;//TfcSynchroView

 TurnOnTimeMachineFormDef = interface
  {* Идентификатор формы TurnOnTimeMachine }
  ['{A410D5AE-D083-4A07-A820-B7E6DCB07A55}']
 end;//TurnOnTimeMachineFormDef

 Ten_TurnOnTimeMachine = {final} class(TPrimTurnOnTimeMachineOptionsForm, TurnOnTimeMachineFormDef)
  {* Включить Машину времени }
 end;//Ten_TurnOnTimeMachine

 TWarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, WarningBaloonFormDef)
  {* Баллон с предупреждением }
 end;//TWarningBaloonForm

 TSynchroView_WarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, SynchroView_WarningBaloonFormDef)
  {* Баллон с предупреждением для документа в синхронном просмотре }
 end;//TSynchroView_WarningBaloonForm

 TTranslation_WarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, Translation_WarningBaloonFormDef)
  {* Балон с предупреждением для перевода }
 end;//TTranslation_WarningBaloonForm

 TUserCR1_WarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, UserCR1_WarningBaloonFormDef)
 end;//TUserCR1_WarningBaloonForm

 TUserCR2_WarningBaloonForm = {final} class(TPrimWarningBaloonOptionsForm, UserCR2_WarningBaloonFormDef)
 end;//TUserCR2_WarningBaloonForm

 TDocumentModule = class
  {* Работа с документом }
  protected
   procedure OpenDocOnNumber;
    {* Открыть документ по номеру }
  public
   procedure OpenDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* Открывает документ }
   function OpenEntityAsDocument(const anEntity: IUnknown;
    const aContainer: IvcmContainer): IDocument;
   function SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
   procedure OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenExternalObject(const aContainer: IvcmContainer;
    const aData: InsLinkedObjectData);
   procedure OpenPicture(const aContainer: IvcmContainer;
    const aData: InsLinkedObjectData);
   procedure OpenPictureInfo(const aContainer: IvcmContainer;
    const aData: InsLinkedObjectDescription);
   procedure OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine);
   procedure OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
    const anAggregate: IvcmAggregate);
   procedure MakeBaloonForm(aCaller: TvcmContainerForm;
    aUserType: TvcmEffectiveUserType;
    const aWarning: IdsWarning);
   class function DocumentShowChangesInfoSetting: Boolean;
    {* Метод для получения значения настройки "Показывать историю изменений в документе" }
   class procedure WriteDocumentShowChangesInfoSetting(aValue: Boolean);
    {* Метод для записи значения настройки "Показывать историю изменений в документе" }
 end;//TDocumentModule
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Document_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentShowChangesInfoSettingRes
 , stDocumentShowChangesInfoItem
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsManagers
 , sdsDocument
 , sdsDocumentWithFlash
 , BaseTypesUnit
 , deDocInfo
 , SysUtils
 , nsExternalObjectPrim
 , ExternalObjectUnit
 , nsConst
 , nsUtils
 , afwFacade
 , nsOpenDocOnNumberData
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , DocumentWithFlashKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TextKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , RedactionsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ContentsKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , bsUtils
 , l3MessageID
 , l3Base
 {$If NOT Defined(NoScripts)}
 , PictureKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , PictureInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , DocNumberQueryKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , WarningConst
 {$If NOT Defined(NoScripts)}
 , WarningKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , AttributesKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SynchroViewKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TurnOnTimeMachineKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , LoggingUnit
 {$If NOT Defined(NoScripts)}
 , WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , SynchroView_WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , Translation_WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , UserCR1_WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , UserCR2_WarningBaloonKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TnsOpenDocumentByNumber = {final} class(TnsLogEvent)
  public
   class procedure Log(aDocID: Integer);
 end;//TnsOpenDocumentByNumber

var g_Tfs_Document: Tfs_Document = nil;
 {* Экземпляр синглетона Tfs_Document }
var g_Tfs_DocumentWithFlash: Tfs_DocumentWithFlash = nil;
 {* Экземпляр синглетона Tfs_DocumentWithFlash }

const
 {* Локализуемые строки DocumentCaptionLocalConstants }
 str_fsDocumentCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDocumentCaption'; rValue : 'Текст');
  {* Заголовок фабрики сборки форм "Document" }

const
 {* Локализуемые строки DocumentWithFlash$FSFCaptionLocalConstants }
 str_fsDocumentWithFlashCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsDocumentWithFlashCaption'; rValue : 'Схема');
  {* Заголовок фабрики сборки форм "DocumentWithFlash$FSF" }

const
 {* Локализуемые строки ut_PictureInfoLocalConstants }
 str_ut_PictureInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_PictureInfoCaption'; rValue : 'Информация о картинке');
  {* Заголовок пользовательского типа "Информация о картинке" }

const
 {* Локализуемые строки ut_DocNumberQueryLocalConstants }
 str_ut_DocNumberQueryCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_DocNumberQueryCaption'; rValue : 'Открыть документ по номеру');
  {* Заголовок пользовательского типа "Открыть документ по номеру" }

const
 {* Локализуемые строки ut_TurnOnTimeMachineLocalConstants }
 str_ut_TurnOnTimeMachineCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TurnOnTimeMachineCaption'; rValue : 'Включить Машину времени');
  {* Заголовок пользовательского типа "Включить Машину времени" }

procedure Tfs_DocumentFree;
 {* Метод освобождения экземпляра синглетона Tfs_Document }
begin
 l3Free(g_Tfs_Document);
end;//Tfs_DocumentFree

procedure Tfs_DocumentWithFlashFree;
 {* Метод освобождения экземпляра синглетона Tfs_DocumentWithFlash }
begin
 l3Free(g_Tfs_DocumentWithFlash);
end;//Tfs_DocumentWithFlashFree

function Tfs_Document.Text_Parent_dftDocument_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *DF28287EBCC9_4AA126C401AD_var*
//#UC END# *DF28287EBCC9_4AA126C401AD_var*
begin
//#UC START# *DF28287EBCC9_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *DF28287EBCC9_4AA126C401AD_impl*
end;//Tfs_Document.Text_Parent_dftDocument_NeedMakeForm

function Tfs_Document.WarnJuror_Child_WarnJuror_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnJuror }
//#UC START# *25A9BEF142E9_4AA126C401AD_var*
//#UC END# *25A9BEF142E9_4AA126C401AD_var*
begin
//#UC START# *25A9BEF142E9_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *25A9BEF142E9_4AA126C401AD_impl*
end;//Tfs_Document.WarnJuror_Child_WarnJuror_NeedMakeForm

function Tfs_Document.WarnPreActive_Child_WarnPreActive_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnPreActive }
//#UC START# *3D661BE47244_4AA126C401AD_var*
//#UC END# *3D661BE47244_4AA126C401AD_var*
begin
//#UC START# *3D661BE47244_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *3D661BE47244_4AA126C401AD_impl*
end;//Tfs_Document.WarnPreActive_Child_WarnPreActive_NeedMakeForm

function Tfs_Document.WarnIsAbolished_Child_WarnIsAbolished_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnIsAbolished }
//#UC START# *DC9C49363B56_4AA126C401AD_var*
//#UC END# *DC9C49363B56_4AA126C401AD_var*
begin
//#UC START# *DC9C49363B56_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *DC9C49363B56_4AA126C401AD_impl*
end;//Tfs_Document.WarnIsAbolished_Child_WarnIsAbolished_NeedMakeForm

function Tfs_Document.WarnOnControl_Child_WarnOnControl_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnOnControl }
//#UC START# *ADB5561ABC86_4AA126C401AD_var*
//#UC END# *ADB5561ABC86_4AA126C401AD_var*
begin
//#UC START# *ADB5561ABC86_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *ADB5561ABC86_4AA126C401AD_impl*
end;//Tfs_Document.WarnOnControl_Child_WarnOnControl_NeedMakeForm

function Tfs_Document.WarnInactualDocument_Child_WarnInactualDocument_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnInactualDocument }
//#UC START# *A0E6E9A93B48_4AA126C401AD_var*
//#UC END# *A0E6E9A93B48_4AA126C401AD_var*
begin
//#UC START# *A0E6E9A93B48_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *A0E6E9A93B48_4AA126C401AD_impl*
end;//Tfs_Document.WarnInactualDocument_Child_WarnInactualDocument_NeedMakeForm

function Tfs_Document.WarnTimeMachineOn_Child_WarnTimeMachineOn_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnTimeMachineOn }
//#UC START# *354A37DBC5E2_4AA126C401AD_var*
//#UC END# *354A37DBC5E2_4AA126C401AD_var*
begin
//#UC START# *354A37DBC5E2_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *354A37DBC5E2_4AA126C401AD_impl*
end;//Tfs_Document.WarnTimeMachineOn_Child_WarnTimeMachineOn_NeedMakeForm

function Tfs_Document.WarnRedaction_Child_WarnRedaction_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnRedaction }
//#UC START# *36AE71BFE5A8_4AA126C401AD_var*
//#UC END# *36AE71BFE5A8_4AA126C401AD_var*
begin
//#UC START# *36AE71BFE5A8_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *36AE71BFE5A8_4AA126C401AD_impl*
end;//Tfs_Document.WarnRedaction_Child_WarnRedaction_NeedMakeForm

function Tfs_Document.WarnTimeMachineWarning_Child_WarnTimeMachineWarning_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnTimeMachineWarning }
//#UC START# *8676CCD264AD_4AA126C401AD_var*
//#UC END# *8676CCD264AD_4AA126C401AD_var*
begin
//#UC START# *8676CCD264AD_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *8676CCD264AD_4AA126C401AD_impl*
end;//Tfs_Document.WarnTimeMachineWarning_Child_WarnTimeMachineWarning_NeedMakeForm

function Tfs_Document.WarnTimeMachineException_Child_WarnTimeMachineException_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для WarnTimeMachineException }
//#UC START# *37EF13598A94_4AA126C401AD_var*
//#UC END# *37EF13598A94_4AA126C401AD_var*
begin
//#UC START# *37EF13598A94_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *37EF13598A94_4AA126C401AD_impl*
end;//Tfs_Document.WarnTimeMachineException_Child_WarnTimeMachineException_NeedMakeForm

class function Tfs_Document.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_Document <> nil;
end;//Tfs_Document.Exists

class function Tfs_Document.Instance: Tfs_Document;
 {* Метод получения экземпляра синглетона Tfs_Document }
begin
 if (g_Tfs_Document = nil) then
 begin
  l3System.AddExitProc(Tfs_DocumentFree);
  g_Tfs_Document := Create;
 end;
 Result := g_Tfs_Document;
end;//Tfs_Document.Instance

procedure Tfs_Document.InitFields;
//#UC START# *47A042E100E2_4AA126C401AD_var*
//#UC END# *47A042E100E2_4AA126C401AD_var*
begin
//#UC START# *47A042E100E2_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA126C401AD_impl*
end;//Tfs_Document.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_Document.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA126C401AD_var*
//#UC END# *4FFE854A009B_4AA126C401AD_var*
begin
//#UC START# *4FFE854A009B_4AA126C401AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA126C401AD_impl*
end;//Tfs_Document.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

function Tfs_DocumentWithFlash.Text_Parent_dwftMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Text }
//#UC START# *7296B8CF664D_4AA126F9032A_var*
//#UC END# *7296B8CF664D_4AA126F9032A_var*
begin
//#UC START# *7296B8CF664D_4AA126F9032A_impl*
 !!! Needs to be implemented !!!
//#UC END# *7296B8CF664D_4AA126F9032A_impl*
end;//Tfs_DocumentWithFlash.Text_Parent_dwftMain_NeedMakeForm

class function Tfs_DocumentWithFlash.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_DocumentWithFlash <> nil;
end;//Tfs_DocumentWithFlash.Exists

class function Tfs_DocumentWithFlash.Instance: Tfs_DocumentWithFlash;
 {* Метод получения экземпляра синглетона Tfs_DocumentWithFlash }
begin
 if (g_Tfs_DocumentWithFlash = nil) then
 begin
  l3System.AddExitProc(Tfs_DocumentWithFlashFree);
  g_Tfs_DocumentWithFlash := Create;
 end;
 Result := g_Tfs_DocumentWithFlash;
end;//Tfs_DocumentWithFlash.Instance

procedure Tfs_DocumentWithFlash.InitFields;
//#UC START# *47A042E100E2_4AA126F9032A_var*
//#UC END# *47A042E100E2_4AA126F9032A_var*
begin
//#UC START# *47A042E100E2_4AA126F9032A_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_4AA126F9032A_impl*
end;//Tfs_DocumentWithFlash.InitFields

{$If NOT Defined(NoVCM)}
class function Tfs_DocumentWithFlash.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_4AA126F9032A_var*
//#UC END# *4FFE854A009B_4AA126F9032A_var*
begin
//#UC START# *4FFE854A009B_4AA126F9032A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_4AA126F9032A_impl*
end;//Tfs_DocumentWithFlash.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

//#UC START# *4AAFCF930362impl*
//#UC END# *4AAFCF930362impl*

class procedure TnsOpenDocumentByNumber.Log(aDocID: Integer);
//#UC START# *4B150AAA0334_4B150A890212_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B150AAA0334_4B150A890212_var*
begin
//#UC START# *4B150AAA0334_4B150A890212_impl*
 l_Data := MakeParamsList;
 l_Data.AddULong(aDocID);
 GetLogger.AddEvent(LE_OPEN_DOCUMENT_BY_NUMBER, l_Data);
//#UC END# *4B150AAA0334_4B150A890212_impl*
end;//TnsOpenDocumentByNumber.Log

procedure TDocumentModule.OpenDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* Открывает документ }

 procedure CheckAlive;
 //#UC START# *4AA118F20394__var*
 //#UC END# *4AA118F20394__var*
 begin
 //#UC START# *4AA118F20394__impl*
  if Assigned(aDocInfo.Doc) and not aDocInfo.Doc.IsAlive then
   raise ETryOpenMissingDocument.Create('');
 //#UC END# *4AA118F20394__impl*
 end;//CheckAlive

//#UC START# *4AA11788033F_498B135601B6_var*
//#UC END# *4AA11788033F_498B135601B6_var*
begin
//#UC START# *4AA11788033F_498B135601B6_impl*
 {$IfDef vcmUseProfilers}
 ProfilersManager.Document.Start;
 try
 {$EndIf vcmUseProfilers}
  case aDocInfo.DocType of
   // http://mdp.garant.ru/pages/viewpage.action?pageId=482247952
   DT_DOCUMENT, DT_BOOK, DT_REF:
    Tfs_Document.Make(TsdsDocument.Make(aDocInfo),
                      CheckContainer(aContainer));
   DT_EXPLANATORY:
   begin
    CheckAlive;
    TdmStdRes.OpenDictionary(aDocInfo, CheckContainer(aContainer));
   end;//DT_EXPLANATORY
   DT_TIP:
   begin
    CheckAlive;
    TdmStdRes.OpenTip(aDocInfo, CheckContainer(aContainer));
   end;//DT_TIP
   DT_MEDICAL_EXPLANATORY:
   begin
    CheckAlive;
    TdmStdRes.OpenMedicDiction(aDocInfo, CheckContainer(aContainer));
   end;//DT_MEDICAL_EXPLANATORY
   DT_MEDICAL_FIRM:
   begin
    CheckAlive;
    TdmStdRes.OpenMedicFirmDocument(aDocInfo, CheckContainer(aContainer));
   end;//DT_MEDICAL_FIRM
   DT_MEDICAL_DOCUMENT:
   begin
    TdmStdRes.OpenDrugDocument(aDocInfo, CheckContainer(aContainer));
   end;//DT_MEDICAL_DOCUMENT
   DT_FLASH:
    Tfs_DocumentWithFlash.Make(TsdsDocumentWithFlash.Make(aDocInfo),
                               CheckContainer(aContainer));
   DT_ACTUAL_ANALYTICS:
    TdmStdRes.MakeAAC(aDocInfo, CheckContainer(aContainer));
   DT_ACTUAL_ANALYTICS_CONTENTS:
    TdmStdRes.MakeAACContents(aDocInfo, CheckContainer(aContainer));
   else
    Assert(false);
  end//case l_DocInfo.Doc.GetDocType of
 {$IfDef vcmUseProfilers}
 finally
  ProfilersManager.Document.FormSetCreated;
 end;//try..finally
 {$EndIf vcmUseProfilers}
//#UC END# *4AA11788033F_498B135601B6_impl*
end;//TDocumentModule.OpenDocument

function TDocumentModule.OpenEntityAsDocument(const anEntity: IUnknown;
 const aContainer: IvcmContainer): IDocument;
var l_Bookmark: IBookmark;
var l_JBookmark: IJournalBookmark;
var l_DocInfo: IdeDocInfo;
//#UC START# *4AA1327E0334_498B135601B6_var*
var
 l_Para : TParaId;
//#UC END# *4AA1327E0334_498B135601B6_var*
begin
//#UC START# *4AA1327E0334_498B135601B6_impl*
 Result := nil;
 if Supports(anEntity, IBookmark, l_Bookmark) then
 begin
  try
   l_Bookmark.GetDocument(Result);
  except
   on ECanNotFindData do ;
  end;//try..except
  try
   if (Result <> nil) then
    l_Para := l_Bookmark.GetParagraph
   else
    l_Para := 0;
   if (l_Para <> 0) then
    l_DocInfo := TdeDocInfo.Make(Result, TbsDocPos_PID(l_Para))
   else
    l_DocInfo := TdeDocInfo.Make(Result, TbsDocPos_C(dptBookmark, l_Bookmark.GetEid));
  except
   on ENotSaved do
    l_DocInfo := TdeDocInfo.Make(Result, TbsDocPos_PID(l_Bookmark.GetParagraph));
  end;//try..except
 end//if Supports(anEntity, IBookmark, l_Bookmark) then
 else
 if Supports(anEntity, IJournalBookmark, l_JBookmark) then
 begin
  try
   l_JBookmark.GetDocument(Result);
  except
   on ECanNotFindData do ;
  end;//try..except
  l_DocInfo := TdeDocInfo.Make(Result, TbsDocPos_PID(l_JBookMark.GetParaID));
 end//if Supports(anEntity, IBookmark, l_Bookmark) then
 else
 if Supports(anEntity, IDocument, Result) then
  l_DocInfo := TdeDocInfo.Make(Result);
 if Assigned(Result) then
  OpenDocument(l_DocInfo, aContainer);
//#UC END# *4AA1327E0334_498B135601B6_impl*
end;//TDocumentModule.OpenEntityAsDocument

function TDocumentModule.SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
//#UC START# *4AA13F010182_498B135601B6_var*
//#UC END# *4AA13F010182_498B135601B6_var*
begin
//#UC START# *4AA13F010182_498B135601B6_impl*
 Result := OpenEntityAsDocument(aBaseEntity, nil);
 if (Result = nil) then
  vcmAsk(err_BookmarkHasNoDocument);
//#UC END# *4AA13F010182_498B135601B6_impl*
end;//TDocumentModule.SafeOpenDocument

procedure TDocumentModule.OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
//#UC START# *4AA4C6090157_498B135601B6_var*
//#UC END# *4AA4C6090157_498B135601B6_var*
begin
//#UC START# *4AA4C6090157_498B135601B6_impl*
 if (aDocInfo.Doc.GetDocType <> DT_FLASH) then
  OpenDocument(aDocInfo, aContainer);
//#UC END# *4AA4C6090157_498B135601B6_impl*
end;//TDocumentModule.OpenDocumentWithCheck

procedure TDocumentModule.OpenExternalObject(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectData);
//#UC START# *4AAFCF8001A8_498B135601B6_var*
//#UC END# *4AAFCF8001A8_498B135601B6_var*
begin
//#UC START# *4AAFCF8001A8_498B135601B6_impl*
 Result := nil;
 if aData.IsPicture then
 begin
  vcmDispatcher.FormDispatcher.Lock;
  try
   Result := OpenPicture(aContainer, aData);
  finally
   vcmDispatcher.FormDispatcher.UnLock;
  end;//try..finally
 end//aData.IsPicture
 else
 begin
  if vcmAsk(qr_OpenExternalQuery, [aData.ObjectTitle]) then
   nsExecuteExternalObject(aData as IExternalObject);
 end;//aData.IsPicture
//#UC END# *4AAFCF8001A8_498B135601B6_impl*
end;//TDocumentModule.OpenExternalObject

procedure TDocumentModule.OpenPicture(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectData);
//#UC START# *4AB12B14001A_498B135601B6_var*
var
 l_Params: IvcmMakeParams;
//#UC END# *4AB12B14001A_498B135601B6_var*
begin
//#UC START# *4AB12B14001A_498B135601B6_impl*
 l_Params := vcmCheckAggregate(vcmMakeParams(nil,
                                             CheckContainer(aContainer)));
 Result := TPictureForm.Make(l_Params);
 if (aData <> nil) then
  op_Picture_InitNewContent.Call(Result, aData);
//#UC END# *4AB12B14001A_498B135601B6_impl*
end;//TDocumentModule.OpenPicture

procedure TDocumentModule.OpenPictureInfo(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectDescription);
//#UC START# *4AB12F3700CB_498B135601B6_var*
//#UC END# *4AB12F3700CB_498B135601B6_var*
begin
//#UC START# *4AB12F3700CB_498B135601B6_impl*
 Result := Ten_PictureInfo.Make(aData, vcmMakeParams(nil, CheckContainer(aContainer)));
//#UC END# *4AB12F3700CB_498B135601B6_impl*
end;//TDocumentModule.OpenPictureInfo

procedure TDocumentModule.OpenDocOnNumber;
 {* Открыть документ по номеру }
var l_Data: InsOpenDocOnNumberData;
//#UC START# *4AB133720122_498B135601B6_var*
//#UC END# *4AB133720122_498B135601B6_var*
begin
//#UC START# *4AB133720122_498B135601B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AB133720122_498B135601B6_impl*
end;//TDocumentModule.OpenDocOnNumber

procedure TDocumentModule.OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine);
//#UC START# *4B26253C0205_498B135601B6_var*
//#UC END# *4B26253C0205_498B135601B6_var*
begin
//#UC START# *4B26253C0205_498B135601B6_impl*
 Result := Ten_TurnOnTimeMachine.Make(anIntf);
//#UC END# *4B26253C0205_498B135601B6_impl*
end;//TDocumentModule.OpenTurnOnTimeMachine

procedure TDocumentModule.OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
 const anAggregate: IvcmAggregate);
//#UC START# *4ED90DDC00A5_498B135601B6_var*
//#UC END# *4ED90DDC00A5_498B135601B6_var*
begin
//#UC START# *4ED90DDC00A5_498B135601B6_impl*
 Result := TRedactionsForm.Make(vcmMakeParams(anAggregate, CheckContainer(nil)),
                                vcm_ztModal,
                                0,
                                nil,
                                anEditionsHolder.EditionsList);
//#UC END# *4ED90DDC00A5_498B135601B6_impl*
end;//TDocumentModule.OpenEditionsListModal

procedure TDocumentModule.MakeBaloonForm(aCaller: TvcmContainerForm;
 aUserType: TvcmEffectiveUserType;
 const aWarning: IdsWarning);
//#UC START# *4F7D90530076_498B135601B6_var*
//#UC END# *4F7D90530076_498B135601B6_var*
begin
//#UC START# *4F7D90530076_498B135601B6_impl*
  Result := TWarningBaloonForm.Make(vcmMakeParams(nil{f_sdsMainWindow{?}, aCaller, aCaller),
                                    vcm_ztReminder,
                                    aUserType,
                                    nil,
                                    aWarning);
//#UC END# *4F7D90530076_498B135601B6_impl*
end;//TDocumentModule.MakeBaloonForm

class function TDocumentModule.DocumentShowChangesInfoSetting: Boolean;
 {* Метод для получения значения настройки "Показывать историю изменений в документе" }
//#UC START# *F439A1EC5B50_498B135601B6_var*
//#UC END# *F439A1EC5B50_498B135601B6_var*
begin
//#UC START# *F439A1EC5B50_498B135601B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *F439A1EC5B50_498B135601B6_impl*
end;//TDocumentModule.DocumentShowChangesInfoSetting

class procedure TDocumentModule.WriteDocumentShowChangesInfoSetting(aValue: Boolean);
 {* Метод для записи значения настройки "Показывать историю изменений в документе" }
//#UC START# *81ECFA778427_498B135601B6_var*
//#UC END# *81ECFA778427_498B135601B6_var*
begin
//#UC START# *81ECFA778427_498B135601B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *81ECFA778427_498B135601B6_impl*
end;//TDocumentModule.WriteDocumentShowChangesInfoSetting

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDocumentWithFlashForm);
 {* Регистрация DocumentWithFlash }
{$IfEnd} // NOT Defined(NoScripts)
 fm_DocumentWithFlashForm.SetFactory(TDocumentWithFlashForm.Make);
 {* Регистрация фабрики формы DocumentWithFlash }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTextForm);
 {* Регистрация Text }
{$IfEnd} // NOT Defined(NoScripts)
 fm_TextForm.SetFactory(TTextForm.Make);
 {* Регистрация фабрики формы Text }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TRedactionsForm);
 {* Регистрация Redactions }
{$IfEnd} // NOT Defined(NoScripts)
 fm_RedactionsForm.SetFactory(TRedactionsForm.Make);
 {* Регистрация фабрики формы Redactions }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TContentsForm);
 {* Регистрация Contents }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ContentsForm.SetFactory(TContentsForm.Make);
 {* Регистрация фабрики формы Contents }
 str_fsDocumentCaption.Init;
 {* Инициализация str_fsDocumentCaption }
 str_fsDocumentWithFlashCaption.Init;
 {* Инициализация str_fsDocumentWithFlashCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPictureForm);
 {* Регистрация Picture }
{$IfEnd} // NOT Defined(NoScripts)
 fm_PictureForm.SetFactory(TPictureForm.Make);
 {* Регистрация фабрики формы Picture }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_PictureInfo);
 {* Регистрация PictureInfo }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_PictureInfoCaption.Init;
 {* Инициализация str_ut_PictureInfoCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TDocNumberQueryForm);
 {* Регистрация DocNumberQuery }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_DocNumberQueryCaption.Init;
 {* Инициализация str_ut_DocNumberQueryCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TWarningForm);
 {* Регистрация Warning }
{$IfEnd} // NOT Defined(NoScripts)
 fm_WarningForm.SetFactory(TWarningForm.Make);
 {* Регистрация фабрики формы Warning }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TAttributesForm);
 {* Регистрация Attributes }
{$IfEnd} // NOT Defined(NoScripts)
 fm_AttributesForm.SetFactory(TAttributesForm.Make);
 {* Регистрация фабрики формы Attributes }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TfcSynchroView);
 {* Регистрация SynchroView }
{$IfEnd} // NOT Defined(NoScripts)
 fm_fcSynchroView.SetFactory(TfcSynchroView.Make);
 {* Регистрация фабрики формы SynchroView }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_TurnOnTimeMachine);
 {* Регистрация TurnOnTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_TurnOnTimeMachineCaption.Init;
 {* Инициализация str_ut_TurnOnTimeMachineCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TWarningBaloonForm);
 {* Регистрация WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_WarningBaloonForm.SetFactory(TWarningBaloonForm.Make);
 {* Регистрация фабрики формы WarningBaloon }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSynchroView_WarningBaloonForm);
 {* Регистрация SynchroView_WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_SynchroView_WarningBaloonForm.SetFactory(TSynchroView_WarningBaloonForm.Make);
 {* Регистрация фабрики формы SynchroView_WarningBaloon }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTranslation_WarningBaloonForm);
 {* Регистрация Translation_WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_Translation_WarningBaloonForm.SetFactory(TTranslation_WarningBaloonForm.Make);
 {* Регистрация фабрики формы Translation_WarningBaloon }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TUserCR1_WarningBaloonForm);
 {* Регистрация UserCR1_WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_UserCR1_WarningBaloonForm.SetFactory(TUserCR1_WarningBaloonForm.Make);
 {* Регистрация фабрики формы UserCR1_WarningBaloon }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TUserCR2_WarningBaloonForm);
 {* Регистрация UserCR2_WarningBaloon }
{$IfEnd} // NOT Defined(NoScripts)
 fm_UserCR2_WarningBaloonForm.SetFactory(TUserCR2_WarningBaloonForm.Make);
 {* Регистрация фабрики формы UserCR2_WarningBaloon }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
