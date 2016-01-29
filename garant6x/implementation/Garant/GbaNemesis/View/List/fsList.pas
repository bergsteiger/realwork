unit fsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/fsList.pas"
// Начат: 31.08.2009 20:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Работа с документом и списком документов::WorkWithList::View::List::List$FP::List$FSF
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  ,
  DocumentAndListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  DocumentUserTypes_dftDocSynchroView_UserType,
  DocumentUserTypes_dftRelatedSynchroView_UserType,
  DocumentUserTypes_dftAnnotationSynchroView_UserType,
  l3StringIDEx,
  ListUserTypes_lftNone_UserType,
  ListUserTypes_lftSimilarDocumentsSynchroView_UserType,
  ListUserTypes_lftCorrespondentsSynchroForm_UserType,
  ListUserTypes_lftRespondentsSynchroForm_UserType,
  ListUserTypes_lftUserCRList1_SynchorForm_UserType,
  ListUserTypes_lftUserCRList2_SynchorForm_UserType,
  ListInfoUserTypes_liListInfo_UserType,
  AttributesUserTypes_fAttributeSynchroView_UserType,
  SynchroViewUserTypes_svSynchroView_UserType,
  DocumentWithFlashUserTypes_dwftSynchro_UserType,
  FiltersUserTypes_utFilters_UserType,
  Common_FormDefinitions_Controls,
  WorkWithListInterfaces,
  DocInfoInterfaces,
  BaseDocumentWithAttributesInterfaces,
  BaloonWarningUserTypes_WarnJuror_UserType,
  BaloonWarningUserTypes_WarnPreActive_UserType,
  BaloonWarningUserTypes_WarnIsAbolished_UserType,
  BaloonWarningUserTypes_WarnOnControl_UserType,
  BaloonWarningUserTypes_WarnInactualDocument_UserType,
  BaloonWarningUserTypes_WarnRedaction_UserType,
  BaloonWarningUserTypes_remListModified_UserType,
  BaloonWarningUserTypes_remListFiltered_UserType,
  BaloonWarningUserTypes_remTimeMachineWarning_UserType,
  ListAnalizeUserTypes_Analize_UserType
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  ,
  nevBase,
  nsTypes,
  DocumentInterfaces,
  bsTypes,
  l3Interfaces,
  l3Tree_TLB,
  afwInterfaces,
  DynamicDocListUnit,
  l3TreeInterfaces,
  PrimPrimListInterfaces,
  FiltersUnit,
  DocumentUnit,
  DynamicTreeUnit,
  PreviewInterfaces,
  l3InternalInterfaces,
  PrimListInterfaces,
  SimpleListInterfaces,
  nevTools,
  bsTypesNew,
  FoldersDomainInterfaces,
  evdInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSet
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  ,
  vcmBaseTypes
  {$IfEnd} //not NoVCM

  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_List = {final fsf} class(TvcmFormSetFactory)
  private
   function CheckNeedMakeFilters(aNeedMakeDS: TvcmNeedMakeDS = vcm_nmYes): TvcmNeedMakeDS;
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function GetFormSetImplementation: RvcmFormSet; override;
     {* Возвращает класс реализации сборки }
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure InitForms(const aParams: IvcmFormSetRefreshParams); override;
     {* Вызывается при создании сборки перед Refresh для инициализации нужных флажков на сборке. }
    {$IfEnd} //not NoVCM
  public
  // public methods
   function ListParentLftNoneNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для List }
   function RemListModifiedChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для remListModified }
   function RemListFilteredChildRemListFilteredNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для remListFiltered }
   function RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для remTimeMachineWarning }
   function ListInfoChildLiListInfoNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для ListInfo }
   function FiltersNavigatorUtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Filters }
   function SynchroViewChildSvSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для SynchroView }
   function TextChildDftDocSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Text }
   function WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnJuror }
   function WarnPreActiveChildWarnPreActiveNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnPreActive }
   function WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnIsAbolished }
   function WarnOnControlChildWarnOnControlNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnOnControl }
   function WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnInactualDocument }
   function WarnRedactionChildWarnRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для WarnRedaction }
   function AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Attributes }
   function RelatedChildDftRelatedSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Related }
   function AnnotationChildDftAnnotationSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Annotation }
   function SimilarChildLftSimilarDocumentsSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Similar }
   function UserCR1ChildLftUserCRList1SynchorFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для UserCR1 }
   function UserCR2ChildLftUserCRList2SynchorFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для UserCR2 }
   function CorrespondentsChildLftCorrespondentsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Correspondents }
   function RespondentsChildLftRespondentsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Respondents }
   function DocumentWithFlashChildDwftSynchroNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для DocumentWithFlash }
   function ListAnalizeChildAnalizeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для ListAnalize }
  public
  // singleton factory method
    class function Instance: Tfs_List;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_List
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  l3MessageID,
  SysUtils {a},
  vcmControllers,
  fstList,
  nsConst,
  afwFacade,
  fstListInterfaces,
  bsUtils,
  bsUserCRListInfo
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_List

var g_Tfs_List : Tfs_List = nil;

procedure Tfs_ListFree;
begin
 l3Free(g_Tfs_List);
end;

class function Tfs_List.Instance: Tfs_List;
begin
 if (g_Tfs_List = nil) then
 begin
  l3System.AddExitProc(Tfs_ListFree);
  g_Tfs_List := Create;
 end;
 Result := g_Tfs_List;
end;

var
    { Локализуемые строки List$FSFCaptionLocalConstants }
   str_fsListCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fsListCaption'; rValue : 'Список');
    { Заголовок фабрики сборки форм "List$FSF" }

// start class Tfs_List

function Tfs_List.ListParentLftNoneNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsList;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.ListParentLftNoneNeedMakeForm

function Tfs_List.RemListModifiedChildRemListModifiedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.RemListModifiedChildRemListModifiedNeedMakeForm

function Tfs_List.RemListFilteredChildRemListFilteredNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.RemListFilteredChildRemListFilteredNeedMakeForm

function Tfs_List.RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm

function Tfs_List.ListInfoChildLiListInfoNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsListInfo;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.ListInfoChildLiListInfoNeedMakeForm

function Tfs_List.FiltersNavigatorUtFiltersNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsFilters;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.FiltersNavigatorUtFiltersNeedMakeForm

function Tfs_List.SynchroViewChildSvSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsSynchroView;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.SynchroViewChildSvSynchroViewNeedMakeForm

function Tfs_List.TextChildDftDocSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsBaseDocument;
begin
 if Supports(aDataSource, IsdsBaseDocument, l_UseCase) then
  try
   aNew := l_UseCase.dsDocument;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.TextChildDftDocSynchroViewNeedMakeForm

function Tfs_List.WarnJurorChildWarnJurorNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnJurorChildWarnJurorNeedMakeForm

function Tfs_List.WarnPreActiveChildWarnPreActiveNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnPreActiveChildWarnPreActiveNeedMakeForm

function Tfs_List.WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm

function Tfs_List.WarnOnControlChildWarnOnControlNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnOnControlChildWarnOnControlNeedMakeForm

function Tfs_List.WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm

function Tfs_List.WarnRedactionChildWarnRedactionNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsTextBaloonWarning;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.WarnRedactionChildWarnRedactionNeedMakeForm

function Tfs_List.AttributesChildFAttributeSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsBaseDocumentWithAttributes;
begin
 if Supports(aDataSource, IsdsBaseDocumentWithAttributes, l_UseCase) then
  try
   aNew := l_UseCase.dsAttributes;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.AttributesChildFAttributeSynchroViewNeedMakeForm

function Tfs_List.RelatedChildDftRelatedSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsRelatedDoc;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.RelatedChildDftRelatedSynchroViewNeedMakeForm

function Tfs_List.AnnotationChildDftAnnotationSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsAnnotation;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.AnnotationChildDftAnnotationSynchroViewNeedMakeForm

function Tfs_List.SimilarChildLftSimilarDocumentsSynchroViewNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsSimilarDocuments;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.SimilarChildLftSimilarDocumentsSynchroViewNeedMakeForm

function Tfs_List.UserCR1ChildLftUserCRList1SynchorFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsUserCR1;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.UserCR1ChildLftUserCRList1SynchorFormNeedMakeForm

function Tfs_List.UserCR2ChildLftUserCRList2SynchorFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsUserCR2;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.UserCR2ChildLftUserCRList2SynchorFormNeedMakeForm

function Tfs_List.CorrespondentsChildLftCorrespondentsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsCorrespondents;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.CorrespondentsChildLftCorrespondentsSynchroFormNeedMakeForm

function Tfs_List.RespondentsChildLftRespondentsSynchroFormNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsRespondents;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.RespondentsChildLftRespondentsSynchroFormNeedMakeForm

function Tfs_List.DocumentWithFlashChildDwftSynchroNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsDocInfo;
begin
 if Supports(aDataSource, IsdsDocInfo, l_UseCase) then
  try
   aNew := l_UseCase.dsDocumentWithFlash;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.DocumentWithFlashChildDwftSynchroNeedMakeForm

function Tfs_List.ListAnalizeChildAnalizeNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
var
 l_UseCase : IsdsList;
begin
 if Supports(aDataSource, IsdsList, l_UseCase) then
  try
   aNew := l_UseCase.dsListAnalize;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_List.ListAnalizeChildAnalizeNeedMakeForm

procedure Tfs_List.InitFields;
 {-}
begin
 inherited;
 with AddZone('List', vcm_ztParent, fm_efList, lftNone) do
 begin
  with AddZone('remListModified', vcm_ztChild, fm_WarningBaloonForm, remListModified) do
  begin
   OnNeedMakeForm := RemListModifiedChildRemListModifiedNeedMakeForm;
  end;
  with AddZone('remListFiltered', vcm_ztChild, fm_WarningBaloonForm, remListFiltered) do
  begin
   OnNeedMakeForm := RemListFilteredChildRemListFilteredNeedMakeForm;
  end;
  with AddZone('remTimeMachineWarning', vcm_ztChild, fm_WarningBaloonForm, remTimeMachineWarning) do
  begin
   OnNeedMakeForm := RemTimeMachineWarningChildRemTimeMachineWarningNeedMakeForm;
  end;
  OnNeedMakeForm := ListParentLftNoneNeedMakeForm;
 end;
 with AddZone('ListInfo', vcm_ztChild, fm_efListInfo, liListInfo) do
 begin
  OnNeedMakeForm := ListInfoChildLiListInfoNeedMakeForm;
 end;
 with AddZone('Filters', vcm_ztNavigator, fm_enFilters, utFilters, CheckNeedMakeFilters) do
 begin
  ActivateIfUpdate := wafAlways;
  OnNeedMakeForm := FiltersNavigatorUtFiltersNeedMakeForm;
 end;
 with AddZone('SynchroView', vcm_ztChild, fm_fcSynchroView, svSynchroView) do
 begin
  with AddZone('Text', vcm_ztChild, fm_TextForm, dftDocSynchroView) do
  begin
   with AddZone('WarnJuror', vcm_ztChild, fm_SynchroView_WarningBaloonForm, WarnJuror) do
   begin
    OnNeedMakeForm := WarnJurorChildWarnJurorNeedMakeForm;
   end;
   with AddZone('WarnPreActive', vcm_ztChild, fm_SynchroView_WarningBaloonForm, WarnPreActive) do
   begin
    OnNeedMakeForm := WarnPreActiveChildWarnPreActiveNeedMakeForm;
   end;
   with AddZone('WarnIsAbolished', vcm_ztChild, fm_SynchroView_WarningBaloonForm, WarnIsAbolished) do
   begin
    OnNeedMakeForm := WarnIsAbolishedChildWarnIsAbolishedNeedMakeForm;
   end;
   with AddZone('WarnOnControl', vcm_ztChild, fm_SynchroView_WarningBaloonForm, WarnOnControl) do
   begin
    OnNeedMakeForm := WarnOnControlChildWarnOnControlNeedMakeForm;
   end;
   with AddZone('WarnInactualDocument', vcm_ztChild, fm_SynchroView_WarningBaloonForm, WarnInactualDocument) do
   begin
    OnNeedMakeForm := WarnInactualDocumentChildWarnInactualDocumentNeedMakeForm;
   end;
   with AddZone('WarnRedaction', vcm_ztChild, fm_SynchroView_WarningBaloonForm, WarnRedaction) do
   begin
    OnNeedMakeForm := WarnRedactionChildWarnRedactionNeedMakeForm;
   end;
   OnNeedMakeForm := TextChildDftDocSynchroViewNeedMakeForm;
  end;
  with AddZone('Attributes', vcm_ztChild, fm_AttributesForm, fAttributeSynchroView) do
  begin
   OnNeedMakeForm := AttributesChildFAttributeSynchroViewNeedMakeForm;
  end;
  with AddZone('Related', vcm_ztChild, fm_TextForm, dftRelatedSynchroView) do
  begin
   OnNeedMakeForm := RelatedChildDftRelatedSynchroViewNeedMakeForm;
  end;
  with AddZone('Annotation', vcm_ztChild, fm_TextForm, dftAnnotationSynchroView) do
  begin
   OnNeedMakeForm := AnnotationChildDftAnnotationSynchroViewNeedMakeForm;
  end;
  with AddZone('Similar', vcm_ztChild, fm_efList, lftSimilarDocumentsSynchroView) do
  begin
   OnNeedMakeForm := SimilarChildLftSimilarDocumentsSynchroViewNeedMakeForm;
  end;
  with AddZone('UserCR1', vcm_ztChild, fm_efList, lftUserCRList1_SynchorForm) do
  begin
   OnNeedMakeForm := UserCR1ChildLftUserCRList1SynchorFormNeedMakeForm;
  end;
  with AddZone('UserCR2', vcm_ztChild, fm_efList, lftUserCRList2_SynchorForm) do
  begin
   OnNeedMakeForm := UserCR2ChildLftUserCRList2SynchorFormNeedMakeForm;
  end;
  with AddZone('Correspondents', vcm_ztChild, fm_efList, lftCorrespondentsSynchroForm) do
  begin
   OnNeedMakeForm := CorrespondentsChildLftCorrespondentsSynchroFormNeedMakeForm;
  end;
  with AddZone('Respondents', vcm_ztChild, fm_efList, lftRespondentsSynchroForm) do
  begin
   OnNeedMakeForm := RespondentsChildLftRespondentsSynchroFormNeedMakeForm;
  end;
  with AddZone('DocumentWithFlash', vcm_ztChild, fm_DocumentWithFlashForm, dwftSynchro) do
  begin
   OnNeedMakeForm := DocumentWithFlashChildDwftSynchroNeedMakeForm;
  end;
  OnNeedMakeForm := SynchroViewChildSvSynchroViewNeedMakeForm;
 end;
 with AddZone('ListAnalize', vcm_ztChild, fm_ListAnalizeForm, Analize) do
 begin
  OnNeedMakeForm := ListAnalizeChildAnalizeNeedMakeForm;
 end;
 Caption := str_fsListCaption.AsCStr;
 OwnerForm := 0;
end;//Tfs_List.InitFields

{$If not defined(NoVCM)}
class function Tfs_List.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_List.GetInstance
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function Tfs_List.GetFormSetImplementation: RvcmFormSet;
//#UC START# *52973E60005E_4AA4D6C7036F_var*
//#UC END# *52973E60005E_4AA4D6C7036F_var*
begin
//#UC START# *52973E60005E_4AA4D6C7036F_impl*
 Result := TfstList;
//#UC END# *52973E60005E_4AA4D6C7036F_impl*
end;//Tfs_List.GetFormSetImplementation
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure Tfs_List.InitForms(const aParams: IvcmFormSetRefreshParams);
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
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

function Tfs_List.CheckNeedMakeFilters(
  aNeedMakeDS: TvcmNeedMakeDS): TvcmNeedMakeDS;
begin
 case aNeedMakeDS of
  vcm_nmYes:
   if not (afw.Settings.LoadBoolean(pi_List_Sheets_Filters, dv_List_Sheets_Filters)) then
    Result := vcm_nmNo
   else
    Result := aNeedMakeDS;
  vcm_nmForce,
  vcm_nmNo:
   Result := aNeedMakeDS;
 end;
end;

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fsListCaption
 str_fsListCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.