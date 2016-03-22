unit PrimList_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/Forms/PrimList_Form.pas"
// �����: 26.01.2009 18:48
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 ������ � ���������� � ������� ����������::WorkWithList::View::List::PrimList
//
// ������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicDocListUnit,
  DocumentUnit,
  DynamicTreeUnit,
  FiltersUnit,
  l3Interfaces,
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3TreeInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  bsTypes,
  bsInterfaces,
  eeInterfaces,
  DocumentAndListInterfaces,
  TreeInterfaces,
  SimpleListInterfaces
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  ,
  PresentationInterfaces,
  FoldersDomainInterfaces,
  L10nInterfaces,
  PreviewInterfaces,
  eeTreeViewExport,
  l3ProtoObject
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls,
  BaseSearchInterfaces
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  Search_Strange_Controls,
  Common_Strange_Controls,
  nsLogEvent,
  DocumentInterfaces,
  WorkWithList_StatusBar_Controls,
  l3StringIDEx,
  ListUserTypes_lftNone_UserType,
  ListUserTypes_lftRespondent_UserType,
  ListUserTypes_lftCorrespondent_UserType,
  ListUserTypes_lftSynchroView_UserType,
  ListUserTypes_lftCToPart_UserType,
  ListUserTypes_lftConsultation_UserType,
  ListUserTypes_lftSimilarDocumentsSynchroView_UserType,
  ListUserTypes_lftCorrespondentsSynchroForm_UserType,
  ListUserTypes_lftDrugList_UserType,
  ListUserTypes_lftDrugInternationalNameSynonyms_UserType,
  ListUserTypes_lftProducedDrugs_UserType,
  ListUserTypes_lftProducedDrugsSynchroForm_UserType,
  ListUserTypes_lftDrugInternationalNameSynonymsSynchroForm_UserType,
  WorkWithList_ListOperations_Controls,
  Hypertext_Controls_Controls,
  WorkWithListInterfaces,
  nscDocumentListTreeView,
  ListUserTypes_lftRToPart_UserType
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ListUserTypes_lftUserCR1_UserType,
  ListUserTypes_lftUserCR2_UserType,
  ListUserTypes_lftSimilarDocuments_UserType,
  ListUserTypes_lftRespondentsSynchroForm_UserType,
  ListUserTypes_lftUserCRList1_SynchorForm_UserType,
  ListUserTypes_lftUserCRList2_SynchorForm_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  ListUserTypes_lftSimilarDocumentsToFragment_UserType,
  vcmEntityForm {a}
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  vcmControllers {a},
  PrimPrimListInterfaces,
  PrimBaseSearchInterfaces,
  l3Core,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDeleteFromListEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aList: IDynList);
 end;//TnsDeleteFromListEvent

 TnsListExportToFileEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aList: IDynList;
     aCount: Cardinal;
     aSelection: Boolean;
     aTarget: TnsSaveDialogListTarget);
 end;//TnsListExportToFileEvent

const
  { Constants }
 c_SelectionMap : array [Boolean] of Integer = (0, 1);

type
 TnsListPrintPreviewEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aList: IDynList;
     aCount: Cardinal;
     aSelection: Boolean);
 end;//TnsListPrintPreviewEvent

 TnsListExportToWordEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aList: IDynList;
     aCount: Cardinal;
     aSelection: Boolean);
 end;//TnsListExportToWordEvent

 TnsSendListByEmailEvent = {final} class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aList: IDynList;
     aCount: Cardinal;
     aSelection: Boolean);
 end;//TnsSendListByEmailEvent

 TnsViewSameDocumentsEvent = class(TnsLogEvent)
 private
 // private methods
   class procedure Log(const aDoc: IDocument;
    aCount: Cardinal); virtual;
 end;//TnsViewSameDocumentsEvent

  TPrimListFormStateOption = (
    lfoContextFilterState
  , lfoTopItemIndex
  , lfoCurrentIndex
  , lfoTreeStructState
  , lfoInner
  );//TPrimListFormStateOption

  TPrimListFormStateOptions = set of TPrimListFormStateOption;

 IPrimListFormState = interface(IvcmBase)
   ['{05608760-BE05-4CBD-B87E-A50CB768DCA8}']
   function pm_GetInnerState: IvcmBase;
   function pm_GetContextFilterState: IUnknown;
   function pm_GetTreeStructState: InsTreeStructState;
   function pm_GetTopItemIndex: Integer;
   function pm_GetCurrentIndex: Integer;
   function pm_GetOptions: TPrimListFormStateOptions;
   property InnerState: IvcmBase
     read pm_GetInnerState;
   property ContextFilterState: IUnknown
     read pm_GetContextFilterState;
   property TreeStructState: InsTreeStructState
     read pm_GetTreeStructState;
   property TopItemIndex: Integer
     read pm_GetTopItemIndex;
   property CurrentIndex: Integer
     read pm_GetCurrentIndex;
   property Options: TPrimListFormStateOptions
     read pm_GetOptions;
 end;//IPrimListFormState

 _afwApplicationDataUpdate_Parent_ = Tl3ProtoObject;
{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TPrimListFormState = class(_afwApplicationDataUpdate_, IPrimListFormState)
 private
 // private fields
   f_InnerState : IvcmBase;
   f_ContextFilterState : IUnknown;
   f_TreeStructState : InsTreeStructState;
   f_TopItemIndex : Integer;
   f_Options : TPrimListFormStateOptions;
   f_CurrentIndex : Integer;
 protected
 // realized methods
   function pm_GetInnerState: IvcmBase;
   function pm_GetContextFilterState: IUnknown;
   function pm_GetTreeStructState: InsTreeStructState;
   function pm_GetTopItemIndex: Integer;
   function pm_GetOptions: TPrimListFormStateOptions;
   function pm_GetCurrentIndex: Integer;
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
 public
 // overridden public methods
   function QueryInterface(const IID: TGUID;
   out Obj): HResult; override;
     {* �������� ������� ��������� � ��������������, ���� ��� ��������. }
 public
 // public methods
   constructor Create(const aInnerState: IvcmBase;
     const aContextFilterState: IUnknown;
     const aTreeStructState: InsTreeStructState;
     aTopItemIndex: Integer;
     aCurrentIndex: Integer;
     aOptions: TPrimListFormStateOptions); reintroduce;
   class function Make(const aInnerState: IvcmBase;
     const aContextFilterState: IUnknown;
     const aTreeStructState: InsTreeStructState;
     aTopItemIndex: Integer;
     aCurrentIndex: Integer;
     aOptions: TPrimListFormStateOptions): IPrimListFormState; reintroduce;
     {* ��������� ������� TPrimListFormState.Make }
 end;//TPrimListFormState

var
  { ������������ ������ DocumentListHintConst }
 str_lntAAC : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntAAC'; rValue : '������������ �������');
  { '������������ �������' }
 str_lntBlock : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntBlock'; rValue : '��������� � ���������');
  { '��������� � ���������' }
 str_lntDocActive : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDocActive'; rValue : '����������� ��������');
  { '����������� ��������' }
 str_lntDocPreActive : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDocPreActive'; rValue : '�� ���������� � ���� ��������');
  { '�� ���������� � ���� ��������' }
 str_lntDocAbolished : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDocAbolished'; rValue : '���������� ���� ��������');
  { '���������� ���� ��������' }
 str_lntRedaction : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntRedaction'; rValue : '�������� ���������');
  { '�������� ���������' }
 str_lntRedactions : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntRedactions'; rValue : '�������� ���������');
  { '�������� ���������' }
 str_lntDrugAnnuled : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDrugAnnuled'; rValue : '�������������� ��������');
  { '�������������� ��������' }
 str_lntDrugNarcotic : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDrugNarcotic'; rValue : '������ ��������');
  { '������ ��������' }
 str_lntDrugNoAnnuledNoNarcoric : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntDrugNoAnnuledNoNarcoric'; rValue : '����������� ��������');
  { '����������� ��������' }
 str_lntFormAnnuled : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormAnnuled'; rValue : '�������������� ����� ���������');
  { '�������������� ����� ���������' }
 str_lntFormRussianImportant : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormRussianImportant'; rValue : '�������������� ����� ��������� ����������� ������������');
  { '�������������� ����� ��������� ����������� ������������' }
 str_lntFormNoRussianImportant : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormNoRussianImportant'; rValue : '�������������� ����� ��������� ���������� ������������');
  { '�������������� ����� ��������� ���������� ������������' }
 str_lntFormRussianNoImportant : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormRussianNoImportant'; rValue : '����� ��������� ����������� ������������');
  { '����� ��������� ����������� ������������' }
 str_lntFormNoRussianNoImportant : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lntFormNoRussianNoImportant'; rValue : '����������� ����� ���������');
  { '����������� ����� ���������' }

type
 _ListUserTypes_Parent_ = TvcmContainerForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes.imp.pas}
 _PageControlNotification_Parent_ = _ListUserTypes_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}
 _BaseDocument_Parent_ = _PageControlNotification_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
 _StatusBarItems_Parent_ = _BaseDocument_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}
 _BaseSearchPresentation_Parent_ = _StatusBarItems_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}
 _HyperlinkToDocumentProducer_Parent_ = _BaseSearchPresentation_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\HyperlinkToDocumentProducer.imp.pas}
 TPrimListForm = {abstract form} class(_HyperlinkToDocumentProducer_, InsContextSearcher, InsBaseSearchPresentation, InsBaseSearchVisibleWatcher, InsTurnOffTimeMachine)
  {* ������ ���������� }
 private
 // private fields
   f_AllowCallCurrentChangedOnTest : Boolean;
   f_ListPanel : TvtPanel;
    {* ���� ��� �������� ListPanel}
   f_tvList : TnscDocumentListTreeView;
    {* ���� ��� �������� tvList}
   f_cfList : TnscContextFilter;
    {* ���� ��� �������� cfList}
   f_CanSwithToFullList : Boolean;
    {* ���� ��� �������� CanSwithToFullList}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   function IsFilterActive(const aFilter: IFilterFromQuery): Boolean;
   function GetAsDocument(const aNode: INodeBase): IDocument;
   procedure CfListChange(Sender: TObject);
   procedure CfListWrongContext(Sender: TObject);
   procedure TvListCountChanged(Sender: TObject;
     NewCount: Integer);
   procedure TvListAfterFirstPaint(Sender: TObject);
   procedure TvListCurrentIndexChanged(aNew: Integer;
     anOld: Integer);
     {* ������� ����� ������� �������� � ������ }
   function TvListGetItemIconHint(Sender: TObject;
     Index: Integer): Il3CString;
   procedure TvListMakeTreeSource(out theTree: Il3SimpleTree);
   function TvListGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
   procedure TvListActionElement(Sender: TObject;
     Index: Integer);
   procedure TvListCurrentChanged(Sender: TObject;
     NewCurrent: Integer;
     OldCurrent: Integer);
   procedure TvListTreeChanged(aSender: TObject;
     const anOldTree: Il3SimpleTree;
     const aNewTree: Il3SimpleTree);
   procedure TvListRootChanged(aSender: TObject;
     const anOldRoot: IeeNode;
     const aNewRoot: IeeNode);
   procedure TvListSelectCountChanged(aSender: TObject;
     anOldCount: Integer;
     aNewCount: Integer);
   procedure TvListFormatStatusInfo(aSender: TObject;
     var Info: Il3CString;
     aCurrent: Integer;
     aCount: Integer;
     aSelected: Integer);
   procedure TvListNewCharPressed(aChar: AnsiChar);
   procedure TvListCheckFocusedInPaint(aSender: TObject;
     var aFocused: Boolean);
   procedure TvListFooterClick(Sender: TObject);
   function TvListGetNodeType(anIndex: Integer): TbsListNodeType;
   procedure CallCurrentChanged;
     {* ��������� ������ CallCurrentChanged }
 protected
 // property methods
   function pm_GetNoMoreThanOneSelected: Boolean;
   function pm_GetOnlyOneSelected: Boolean;
 protected
 // realized methods
   procedure LftRespondentsSynchroFormQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftRespondentsSynchroForm.OnQueryMaximized }
   procedure LftRToPartQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftRToPart.OnQueryOpen }
   procedure LftCorrespondentsSynchroFormQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftCorrespondentsSynchroForm.OnQueryOpen }
   procedure LftUserCR2QueryOpen(aSender: TObject); override;
     {* ���������� ������� lftUserCR2.OnQueryOpen }
   procedure LftSimilarDocumentsQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftSimilarDocuments.OnQueryOpen }
   procedure LftSimilarDocumentsQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftSimilarDocuments.OnQueryMaximized }
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
     {* ���������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ���������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindContext_Test(const aParams: IvcmTestParamsPrim);
     {* ����� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_FindContext_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ����� }
   {$IfEnd} //not NoVCM
   function pm_GetArea: TnsSearchArea;
   procedure pm_SetArea(aValue: TnsSearchArea);
   function Kind: TnsBaseSearchKind;
   function Find(const aContext: InsBaseSearchContextProvider;
    const aProcessor: InsBaseSearchResultProcessor): Boolean;
   function AllowSearchInTitles: Boolean;
   function IsLocalSearchArea: Boolean;
   procedure ContextChanged(const aNewContext: Il3CString);
   function IsLocalDataReady: Boolean;
   function WindowRequired: Boolean;
   function WindowCloseable: Boolean;
   function CanCloseWindow: Boolean;
   function IsQueryCard: Boolean;
   function TreatSuccessSearchAsManualOpen: Boolean;
   function AutoActivateWindow: Boolean;
   procedure VisibleChanged(aNewVisible: Boolean);
   procedure DoTabActivate; override;
     {* ������� �� ������������ ������� }
   procedure GotoActualRedaction;
     {* ��������� � ������� � ���������� �������� }
   procedure StayInCurrentRedaction;
     {* ��������� � �������� � ������� �������� }
   procedure ChangeDate(aDate: RtlDateTime);
     {* �������� }
   function Get_DisableOps: TnsTurnOffTimeMachineOperations;
   procedure File_SaveToFolder_Test(const aParams: IvcmTestParamsPrim);
     {* ��������� � ����� }
   procedure File_SaveToFolder_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ��������� � ����� }
   procedure File_LoadFromFolder_Test(const aParams: IvcmTestParamsPrim);
     {* ��������� �� ����� }
   procedure File_LoadFromFolder_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ��������� �� ����� }
   procedure Document_AddToControl_Test(const aParams: IvcmTestParamsPrim);
     {* ��������� �� �������� }
   procedure Document_AddToControl_GetState(var State: TvcmOperationStateIndex);
     {* ��������� �� �������� }
   procedure Document_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ��������� �� �������� }
   procedure Document_GetAttributesFrmAct_Test(const aParams: IvcmTestParamsPrim);
     {* ���������� � ��������� }
   procedure Document_GetAttributesFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ���������� � ��������� }
   function Loadable_Load_Execute(const aNode: IeeNode;
    const aData: IUnknown;
    anOp: TListLogicOperation = LLO_NONE): Boolean;
     {* �������, ��� ����� ������� ���� �����? }
   procedure Loadable_Load(const aParams: IvcmExecuteParams);
     {* �������, ��� ����� ������� ���� �����? }
   procedure Document_GetRelatedDocFrmAct_Test(const aParams: IvcmTestParamsPrim);
     {* ������� � ��������� }
   procedure Document_GetRelatedDocFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������� � ��������� }
   {$If not defined(NoVCM)}
   procedure Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
     {* ������ }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Undo_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������ }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
     {* ������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Redo_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Deselect_Test(const aParams: IvcmTestParamsPrim);
     {* ����� ��������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Deselect_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ����� ��������� }
   {$IfEnd} //not NoVCM
   function FindBack(const aContext: InsBaseSearchContextProvider;
    const aProcessor: InsBaseSearchResultProcessor): Boolean;
     {* ������ ����� }
   function FindBackSupported: Boolean;
   function FindBackEnabled: Boolean;
   function FragmentsCountSuffix: Il3CString;
   procedure FillList(const aList: InscStatusBarItemDefsList); override;
     {* ��������� ������ ��������. ��� ���������� � �������� }
   function AllowPrompts: Boolean;
   function PromptsInfo: LongWord;
   function Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
   function Get_VisibleWatcher: InsBaseSearchVisibleWatcher;
   function Get_ContextSearcher: InsContextSearcher;
   procedure LftUserCRList2SynchorFormQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftUserCRList2_SynchorForm.OnQueryOpen }
   function Filterable_Add_Execute(const aFilter: IFilterFromQuery): Boolean;
   procedure Filterable_Add(const aParams: IvcmExecuteParams);
   function Filterable_Delete_Execute(const aFilter: IFilterFromQuery): Boolean;
   procedure Filterable_Delete(const aParams: IvcmExecuteParams);
   function List_GetDeList_Execute: IdeList;
   procedure List_GetDeList(const aParams: IvcmExecuteParams);
   procedure Filterable_ClearAll_Execute;
   procedure Filterable_ClearAll(const aParams: IvcmExecuteParams);
   function Filterable_Refresh_Execute: Boolean;
   procedure Filterable_Refresh(const aParams: IvcmExecuteParams);
   procedure TimeMachine_TimeMachineOffAndReset_Test(const aParams: IvcmTestParamsPrim);
   procedure TimeMachine_TimeMachineOffAndReset_Execute;
   procedure TimeMachine_TimeMachineOffAndReset(const aParams: IvcmExecuteParams);
   procedure List_SetCurrentVisible_Execute;
   procedure List_SetCurrentVisible(const aParams: IvcmExecuteParams);
   procedure TimeMachine_TimeMachineOnOffNew_Test(const aParams: IvcmTestParamsPrim);
     {* �������� ������ ������� }
   procedure TimeMachine_TimeMachineOnOffNew_GetState(var State: TvcmOperationStateIndex);
     {* �������� ������ ������� }
   procedure TimeMachine_TimeMachineOnOffNew_Execute(const aParams: IvcmExecuteParamsPrim);
     {* �������� ������ ������� }
   function SwitchToTextIfPossible: Boolean;
   procedure List_SwitchToFullList_Test(const aParams: IvcmTestParamsPrim);
     {* ��������� ������ ������ }
   procedure List_SwitchToFullList_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ��������� ������ ������ }
   procedure List_ListInfo_Test(const aParams: IvcmTestParamsPrim);
   procedure List_ListInfo_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_Sort_Test(const aParams: IvcmTestParamsPrim);
   procedure List_Sort_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_SortDirection_Test(const aParams: IvcmTestParamsPrim);
   procedure List_SortDirection_GetState(var State: TvcmOperationStateIndex);
   procedure List_SortDirection_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_SpecifyList_Test(const aParams: IvcmTestParamsPrim);
   procedure List_SpecifyList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure List_ExportToXML_Test(const aParams: IvcmTestParamsPrim);
   procedure List_ExportToXML_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Filters_FiltersList_Test(const aParams: IvcmTestParamsPrim);
   procedure Filters_FiltersList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LocalList_PublishSourceSearchInList_Test(const aParams: IvcmTestParamsPrim);
     {* ������ �� ��������� ������������� � ������� ������ }
   procedure LocalList_PublishSourceSearchInList_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������ �� ��������� ������������� � ������� ������ }
   procedure LocalList_Open_Test(const aParams: IvcmTestParamsPrim);
   procedure LocalList_Open_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LocalList_SearchDrugInList_Test(const aParams: IvcmTestParamsPrim);
   procedure LocalList_SearchDrugInList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_GetAnnotationDocFrmAct_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_GetAnnotationDocFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_SimilarDocuments_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_SimilarDocuments_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure CRList_SetType_Test(const aParams: IvcmTestParamsPrim);
   procedure CRList_SetType_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Document_GetGraphicImage_Test(const aParams: IvcmTestParamsPrim);
   procedure Document_GetGraphicImage_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LocalList_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������� ������� ������ � ����� ���� }
   procedure Selection_CopyToNewList_Test(const aParams: IvcmTestParamsPrim);
   procedure Selection_CopyToNewList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Filters_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Selection_Analize_Test(const aParams: IvcmTestParamsPrim);
     {* ������ ������... }
   procedure Selection_Analize_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������ ������... }
   procedure LocalList_SearchInList_Test(const aParams: IvcmTestParamsPrim);
     {* ������ �� ���������� � ������� ������ }
   procedure LocalList_SearchInList_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������ �� ���������� � ������� ������ }
   procedure Filters_FiltersListOpen_Test(const aParams: IvcmTestParamsPrim);
     {* ������� (�������) }
   procedure Filters_FiltersListOpen_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������� (�������) }
   function pm_GetHyperlinkDocID: Integer; override;
   function pm_GetHyperlinkDocumentName: Il3CString; override;
   procedure Filters_InternalClear_Execute;
   procedure Filters_InternalClear(const aParams: IvcmExecuteParams);
   function Get_NeedSaveActiveClassBeforeSearch: Boolean;
   function Filterable_GetListType_Execute: TbsListType;
   procedure Filterable_GetListType(const aParams: IvcmExecuteParams);
   function List_GetDsList_Execute: IdsList;
   procedure List_GetDsList(const aParams: IvcmExecuteParams);
   procedure LftUserCRList1SynchorFormQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftUserCRList1_SynchorForm.OnQueryMaximized }
   procedure List_Analize_Test(const aParams: IvcmTestParamsPrim);
     {* ������ ������ }
   procedure List_Analize_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������ ������ }
   procedure List_AnalizeList_Test(const aParams: IvcmTestParamsPrim);
     {* ������ ������... }
   procedure List_AnalizeList_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������ ������... }
   procedure List_SortForReminders_Test(const aParams: IvcmTestParamsPrim);
     {* ����������� ������ }
   procedure List_SortForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ����������� ������ }
   procedure List_SortDirectionForReminders_Test(const aParams: IvcmTestParamsPrim);
     {* ���������� ����������� ���������� }
   procedure List_SortDirectionForReminders_GetState(var State: TvcmOperationStateIndex);
     {* ���������� ����������� ���������� }
   procedure List_SortDirectionForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ���������� ����������� ���������� }
   procedure List_SpecifyListForReminders_Test(const aParams: IvcmTestParamsPrim);
   procedure List_SpecifyListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure LftProducedDrugsQueryClose(aSender: TObject); override;
     {* ���������� ������� lftProducedDrugs.OnQueryClose }
   function IsSearchLocked: Boolean;
   procedure LftUserCR2QueryClose(aSender: TObject); override;
     {* ���������� ������� lftUserCR2.OnQueryClose }
   procedure LftConsultationQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftConsultation.OnQueryOpen }
   procedure LftRespondentQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftRespondent.OnQueryMaximized }
   procedure LftUserCR1QueryOpen(aSender: TObject); override;
     {* ���������� ������� lftUserCR1.OnQueryOpen }
   procedure LftProducedDrugsQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftProducedDrugs.OnQueryMaximized }
   procedure LftRespondentQueryClose(aSender: TObject); override;
     {* ���������� ������� lftRespondent.OnQueryClose }
   procedure LftUserCR2QueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftUserCR2.OnQueryMaximized }
   procedure LftSimilarDocumentsSynchroViewQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftSimilarDocumentsSynchroView.OnQueryMaximized }
   procedure LftCorrespondentQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftCorrespondent.OnQueryOpen }
   procedure LftCorrespondentsSynchroFormQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftCorrespondentsSynchroForm.OnQueryMaximized }
   procedure LftUserCR1QueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftUserCR1.OnQueryMaximized }
   procedure LftUserCR1QueryClose(aSender: TObject); override;
     {* ���������� ������� lftUserCR1.OnQueryClose }
   procedure LftDrugInternationalNameSynonymsQueryClose(aSender: TObject); override;
     {* ���������� ������� lftDrugInternationalNameSynonyms.OnQueryClose }
   procedure LftSynchroViewQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftSynchroView.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftDrugInternationalNameSynonyms.OnQueryOpen }
   procedure LftConsultationQueryClose(aSender: TObject); override;
     {* ���������� ������� lftConsultation.OnQueryClose }
   procedure LftRToPartQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftRToPart.OnQueryMaximized }
   procedure LftSimilarDocumentsQueryClose(aSender: TObject); override;
     {* ���������� ������� lftSimilarDocuments.OnQueryClose }
   procedure LftSimilarDocumentsToFragmentQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftSimilarDocumentsToFragment.OnQueryMaximized }
   procedure LftRespondentQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftRespondent.OnQueryOpen }
   procedure LftCorrespondentQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftCorrespondent.OnQueryMaximized }
   procedure LftSimilarDocumentsToFragmentQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftSimilarDocumentsToFragment.OnQueryOpen }
   procedure LftProducedDrugsSynchroFormQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftProducedDrugsSynchroForm.OnQueryOpen }
   procedure LftConsultationQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftConsultation.OnQueryMaximized }
   procedure LftCorrespondentQueryClose(aSender: TObject); override;
     {* ���������� ������� lftCorrespondent.OnQueryClose }
   procedure LftSynchroViewQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftSynchroView.OnQueryMaximized }
   procedure LftRespondentsSynchroFormQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftRespondentsSynchroForm.OnQueryOpen }
   procedure LftUserCRList2SynchorFormQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftUserCRList2_SynchorForm.OnQueryMaximized }
   procedure LftUserCRList1SynchorFormQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftUserCRList1_SynchorForm.OnQueryOpen }
   procedure LftSimilarDocumentsSynchroViewQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftSimilarDocumentsSynchroView.OnQueryOpen }
   procedure LftProducedDrugsQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftProducedDrugs.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftDrugInternationalNameSynonyms.OnQueryMaximized }
   procedure LftSimilarDocumentsToFragmentQueryClose(aSender: TObject); override;
     {* ���������� ������� lftSimilarDocumentsToFragment.OnQueryClose }
   procedure LftDrugInternationalNameSynonymsSynchroFormQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftDrugInternationalNameSynonymsSynchroForm.OnQueryOpen }
   procedure LftDrugInternationalNameSynonymsSynchroFormQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftDrugInternationalNameSynonymsSynchroForm.OnQueryMaximized }
   procedure LftProducedDrugsSynchroFormQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftProducedDrugsSynchroForm.OnQueryMaximized }
   procedure LftCToPartQueryMaximized(aSender: TObject); override;
     {* ���������� ������� lftCToPart.OnQueryMaximized }
   procedure LftCToPartQueryOpen(aSender: TObject); override;
     {* ���������� ������� lftCToPart.OnQueryOpen }
 public
 // realized methods
   function SupportDisabled: Boolean;
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
   {$If not defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
     {* ��������� �������� ������. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; override;
     {* ��������� ��������� �����. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; override;
     {* ��������� ��������� �����. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
   function NeedsStatusBarItems: Boolean; override;
     {* ����������, ��� �������� � ��������� ������ ���� ���� ����������� }
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure PageActive; override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
   function NeedMakeHyperlinkToDocument: Boolean; override;
    {$If not defined(NoVCM)}
   function IsAcceptable(aDataUpdate: Boolean): Boolean; override;
     {* ����� �� ��������� ����� � ������� �������� (��������, �� ������� ����) }
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function NeedLoadFormStateForClone(const aState: IvcmBase;
     aStateType: TvcmStateType): Boolean; override;
    {$IfEnd} //not NoVCM
 protected
 // protected fields
   dsSimpleTree : IdsSimpleTree;
   dsList : IdsList;
   dsDocumentList : IdsDocumentList;
   sdsList : IsdsList;
    {* ������}
   BaseSearchSupportQuery : IucbBaseSearchSupportQuery;
   WarningLocker : InsWarningLocker;
   f_SearchArea : TnsSearchArea;
   f_SearchWindowVisible : Boolean;
   ucpFilters : IucpFilters;
   f_SortTypeMap : InsIntegerValueMap;
   f_NeedDropCRList : Boolean;
 protected
 // protected methods
   function HasSelected: Boolean;
   procedure SelectionOpsTest(const aParams: IvcmTestParamsPrim);
   procedure StatusParamsShow;
   procedure OpenCurrentList(const aContainer: IvcmContainer);
     {* ������� ������� ������ }
   procedure AddSelectedToControl(aOnlySet: Boolean);
   procedure ListOpsWithTrialModeTest(const aParams: IvcmTestParamsPrim);
   function MakePreview(WithTexts: Boolean): IafwComplexDocumentPreview;
   procedure SaveList(InitialSaveTitles: Boolean;
     MinSelectedCount: Integer = 2);
   procedure SaveDialogCanClose(Sender: TObject;
     var CanClose: Boolean);
   function ApproxExportCount(aUseSelection: Boolean): Integer;
   function CalcSaveListKind(aTitles: Boolean = True): TbsSaveListKind;
   procedure ListopPrintTest(const aParams: IvcmTestParamsPrim);
   function CreateListName(aHasSelection: Boolean = false): Il3CString;
   procedure OpenInNewWindow;
     {* ��������� ������ � ������� ���� }
   function ForbidOpForDocumentSchema(const aParams: IvcmTestParamsPrim): Boolean;
     {* ��������� �������� ��� ��������� ����� }
   procedure DocumentOpsWithTrialModeTest(const aParams: IvcmTestParamsPrim);
   procedure DocumentOpsTest(const aParams: IvcmTestParamsPrim);
   procedure UpdateFooter;
   function HasContextFiltration: Boolean;
   procedure InitNewContainerBaseSearch(const aContainer: IvcmContainer;
     aOpenKind: TvcmMainFormOpenKind);
   procedure ShowEditorOrList(const aTree: Il3SimpleTree); virtual; abstract;
   function ApplyFilter(const aFilter: IFilterFromQuery;
    aAdd: Boolean = False): Boolean; virtual; abstract;
   function IsListEmpty: Boolean; virtual; abstract;
   function HasCurrent: Boolean;
   procedure DeleteSelectionFromList;
   procedure ClearFilters;
   procedure DoSwitchToFullList;
   procedure ListOpsTest(const aParams: IvcmTestParamsPrim);
   procedure QueryMaximized; virtual; abstract;
   procedure QueryOpen; virtual; abstract;
   procedure SaveToFolders(aOperation: Integer = 0); virtual; abstract;
   function MakeFilterInfo(aType: TnsFolderFilter): InsFolderFilterInfo; virtual; abstract;
   procedure ResetSaveToFolderOperations; virtual; abstract;
   function CheckValidSortTypes(aSortType: TbsValidSortTypes): Boolean; virtual; abstract;
 public
 // public methods
   procedure OpenDocument(const aDoc: IdeDocInfo;
    const aCont: IvcmContainer;
    aNeedReturnFocus: Boolean);
 private
 // private properties
   property OnlyOneSelected: Boolean
     read pm_GetOnlyOneSelected;
 protected
 // protected properties
   property CanSwithToFullList: Boolean
     read f_CanSwithToFullList
     write f_CanSwithToFullList;
   property NoMoreThanOneSelected: Boolean
     read pm_GetNoMoreThanOneSelected;
 public
 // public properties
   property ListPanel: TvtPanel
     read f_ListPanel;
   property tvList: TnscDocumentListTreeView
     read f_tvList;
   property cfList: TnscContextFilter
     read f_cfList;
 end;//TPrimListForm
{$IfEnd} //not Admin AND not Monitorings

  {$If not defined(Admin) AND not defined(Monitorings)}
var
   g_OverrideList : Integer = 0;
  {$IfEnd} //not Admin AND not Monitorings
  {$If not defined(Admin) AND not defined(Monitorings)}
var
   g_SaveToFolders : Integer = 0;
  {$IfEnd} //not Admin AND not Monitorings
  {$If not defined(Admin) AND not defined(Monitorings)}
var
   g_SaveToFoldersSelected : Integer = 0;
  {$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsLogEventData,
  nsLogManager,
  LoggingUnit,
  LoggingWrapperInterfaces,
  l3Base {a},
  vcmBase {a},
  StdRes {a},
  UnderControlUnit,
  l3Nodes,
  nsTrialSupport,
  nsDocumentTools,
  nsExternalObjectPrim,
  nsSaveDialog,
  nsConst,
  Printers,
  afwFacade,
  bsUtils,
  BaseTreeSupportUnit,
  nsUtils,
  BaseTypesUnit,
  nsOpenUtils,
  deList,
  nsListEvents,
  F1Like_InternalOperations_Controls,
  Math,
  DataAdapter,
  vtSaveDialog,
  l3String
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  ,
  l3Tree_TLB,
  nsFiltersContainer,
  evdStyles
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3ControlsTypes,
  ListRes,
  nsExternalObjectModelPart,
  nsTabbedContainerUtils
  {$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
  ,
  vcmTabbedContainerFormDispatcher
  {$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
  ,
  Windows,
  nscDocumentHistory,
  vtLister,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  nsManagers,
  SysUtils {a}
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDefsList
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscStatusBarOperationDef
  {$IfEnd} //Nemesis
  ,
  l3InterfacesMisc,
  nsBaseSearchService,
  evConstStringData,
  evdHyperlinkInfo,
  nsHyperlinkToDocumentProducerConst,
  afwNavigation
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\PageControlNotification.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}

type _Instance_R_ = TPrimListForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\StatusBarItems.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearchPresentation.imp.pas}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\LinksToGarant\HyperlinkToDocumentProducer.imp.pas}

var
   { ������������ ������ Local }
  str_ListFooterCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListFooterCaption'; rValue : '������ ������ ���������� �� �������');
   { '������ ������ ���������� �� �������' }

// start class TPrimListForm

function TPrimListForm.IsFilterActive(const aFilter: IFilterFromQuery): Boolean;
//#UC START# *4C37434901A0_497DDB2B001B_var*
//#UC END# *4C37434901A0_497DDB2B001B_var*
begin
//#UC START# *4C37434901A0_497DDB2B001B_impl*
 if Assigned(dsList) then
  Result := dsList.IsActiveFilter(aFilter)
 else
  Result := False;
//#UC END# *4C37434901A0_497DDB2B001B_impl*
end;//TPrimListForm.IsFilterActive

function TPrimListForm.GetAsDocument(const aNode: INodeBase): IDocument;
//#UC START# *4C3AB1450150_497DDB2B001B_var*
var
 l_BaseEntity: IEntityBase;
 l_ListEntry: IListEntryInfo;
//#UC END# *4C3AB1450150_497DDB2B001B_var*
begin
//#UC START# *4C3AB1450150_497DDB2B001B_impl*
 Result := nil;
 try
  aNode.GetEntity(l_BaseEntity);
  try
   if Supports(l_BaseEntity, IListEntryInfo, l_ListEntry) then
    try
     l_ListEntry.GetDoc(Result);
    finally
     l_ListEntry := nil;
    end;//try..finally
  finally
   l_BaseEntity := nil;
  end;//try..finally
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *4C3AB1450150_497DDB2B001B_impl*
end;//TPrimListForm.GetAsDocument

procedure TPrimListForm.CfListChange(Sender: TObject);
//#UC START# *4F7EEE6D030A_497DDB2B001B_var*
var
 l_Tree: Il3FilterableTree;
 l_Filtered: Il3SimpleTree;
 l_Node: Il3SimpleNode;
 l_NewNodeIndex: Integer;
//#UC END# *4F7EEE6D030A_497DDB2B001B_var*
begin
//#UC START# *4F7EEE6D030A_497DDB2B001B_impl*
 if Supports(tvList.TreeStruct, Il3FilterableTree, l_Tree) then
 try
  l_Node := tvList.GetCurrentNode;
  try
   l_Filtered := l_Tree.MakeFiltered(l_Tree.
                                     CloneFilters.
                                     SetContext(cfList.ActiveContext),
                                     l_Node,
                                     l_NewNodeIndex,
                                     True,
                                     cfList.NeedRefilterTree);
   if Assigned(l_Filtered) and (l_Filtered.CountView > 0) then
   begin
    tvList.TreeStruct := l_Filtered;
    if l_Node <> nil then
     tvList.GotoOnNode(l_Node);
   end;
  finally
   l_Node := nil;
  end;
 finally
  l_Tree := nil;
 end;
//#UC END# *4F7EEE6D030A_497DDB2B001B_impl*
end;//TPrimListForm.CfListChange

procedure TPrimListForm.CfListWrongContext(Sender: TObject);
//#UC START# *4F7EEEA2013D_497DDB2B001B_var*
//#UC END# *4F7EEEA2013D_497DDB2B001B_var*
begin
//#UC START# *4F7EEEA2013D_497DDB2B001B_impl*
 nsBeepWrongContext;
//#UC END# *4F7EEEA2013D_497DDB2B001B_impl*
end;//TPrimListForm.CfListWrongContext

procedure TPrimListForm.TvListCountChanged(Sender: TObject;
  NewCount: Integer);
//#UC START# *4F7EEEF800E8_497DDB2B001B_var*
//#UC END# *4F7EEEF800E8_497DDB2B001B_var*
begin
//#UC START# *4F7EEEF800E8_497DDB2B001B_impl*
 // ��� �������� ���� ������� ����� �������� ���������:
 ShowEditorOrList(nil);
 Dispatcher.UpdateStatus;
// if Assigned(dsList) then
//  dsList.CurrentChanged(tvList.GetCurrentNode, False);
 CallCurrentChanged;
//#UC END# *4F7EEEF800E8_497DDB2B001B_impl*
end;//TPrimListForm.TvListCountChanged

procedure TPrimListForm.TvListAfterFirstPaint(Sender: TObject);
//#UC START# *4F7EEF230221_497DDB2B001B_var*
//#UC END# *4F7EEF230221_497DDB2B001B_var*
begin
//#UC START# *4F7EEF230221_497DDB2B001B_impl*
 {$IfDef vcmUseProfilers}
 if UserType = lftNone then
  ProfilersManager.ListAfterSearch.Finish;
 {$EndIf vcmUseProfilers}
//#UC END# *4F7EEF230221_497DDB2B001B_impl*
end;//TPrimListForm.TvListAfterFirstPaint

procedure TPrimListForm.TvListCurrentIndexChanged(aNew: Integer;
  anOld: Integer);
//#UC START# *4F7EEF450143_497DDB2B001B_var*
//#UC END# *4F7EEF450143_497DDB2B001B_var*
begin
//#UC START# *4F7EEF450143_497DDB2B001B_impl*
 Dispatcher.UpdateStatus;
//#UC END# *4F7EEF450143_497DDB2B001B_impl*
end;//TPrimListForm.TvListCurrentIndexChanged

function TPrimListForm.TvListGetItemIconHint(Sender: TObject;
  Index: Integer): Il3CString;
//#UC START# *4F7EEF8500A8_497DDB2B001B_var*
var
 l_NT: TbsListNodeType;
//#UC END# *4F7EEF8500A8_497DDB2B001B_var*
begin
//#UC START# *4F7EEF8500A8_497DDB2B001B_impl*
 Result := nil;
 if Assigned(dsList) then
 begin
  l_NT := dsList.ListNodeType(tvList.GetNode(Index));
  case l_NT of
   lntAAC: Result := vcmCStr(str_lntAAC);
   lntBlock: Result := vcmCStr(str_lntBlock);
   lntDocActive: Result := vcmCStr(str_lntDocActive);
   lntDocPreActive: Result := vcmCStr(str_lntDocPreActive);
   lntDocAbolished: Result := vcmCStr(str_lntDocAbolished);
   lntRedaction: Result := vcmCStr(str_lntRedaction);
   lntRedactions: Result := vcmCStr(str_lntRedactions);
   lntDrugAnnuled: Result := vcmCStr(str_lntDrugAnnuled);
   lntDrugNarcotic: Result := vcmCStr(str_lntDrugNarcotic);
   lntDrugNoAnnuledNoNarcoric: Result := vcmCStr(str_lntDrugNoAnnuledNoNarcoric);
   lntFormAnnuled: Result := vcmCStr(str_lntFormAnnuled);
   lntFormRussianImportant: Result := vcmCStr(str_lntFormRussianImportant);
   lntFormNoRussianImportant: Result := vcmCStr(str_lntFormNoRussianImportant);
   lntFormRussianNoImportant: Result := vcmCStr(str_lntFormRussianNoImportant);
   lntFormNoRussianNoImportant: Result := vcmCStr(str_lntFormNoRussianNoImportant);
  else
   Result := vcmCStr(str_Empty);
  end;
 end;
//#UC END# *4F7EEF8500A8_497DDB2B001B_impl*
end;//TPrimListForm.TvListGetItemIconHint

procedure TPrimListForm.TvListMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *4F7EEFB001FD_497DDB2B001B_var*
var
 l_Node: INodeBase;
//#UC END# *4F7EEFB001FD_497DDB2B001B_var*
begin
//#UC START# *4F7EEFB001FD_497DDB2B001B_impl*
 if (dsSimpleTree <> nil) then
 begin
  theTree := dsSimpleTree.SimpleTree;
  if (theTree <> nil) then
  begin
   if Supports(theTree.RootNode, INodeBase, l_Node) then
    l_Node.SetAllFlag(FM_SELECTION, False);
   if (dsDocumentList <> nil) and dsDocumentList.IsSnippet then
    theTree.ExpandSubDir(nil, True, 0);
  end;//theTree <> nil
 end//dsSimpleTree <> nil
 else
  theTree := nil;
//#UC END# *4F7EEFB001FD_497DDB2B001B_impl*
end;//TPrimListForm.TvListMakeTreeSource

function TPrimListForm.TvListGetItemImage(Sender: TObject;
  Index: Integer;
  var aImages: TCustomImageList): Integer;
//#UC START# *4F7EEFD601CE_497DDB2B001B_var*
const
 cListNodeTypeImageIndex : array [TbsListNodeType] of Integer = (
  InfoIcon, // lntUnknown,
  SubIcon, // lntBlock
  DocIcon, // lntDocActive
  DocIcon + PreActiveOffset, // lntDocPreActive
  DocIcon + NoActiveOffset, // lntDocAbolished
  ExObjIcon, // lntExternalObject
  WWWIcon, // lntExternalLink
  RedactionIcon, // lntRedaction
  RedactionFolder, // lntRedactions
  DrugAnnuled, // lntDrugAnnuled,
  DrugNarcotic, // lntDrugNarcotic,
  DrugNoAnnuledNoNarcoric, // lntDrugNoAnnuledNoNarcoric,
  FormAnnuled, // lntFormAnnuled,
  FormRussianImportant, // lntFormRussianImportant,
  FormNoRussianImportant, // lntFormNoRussianImportant,
  FormRussianNoImportant, // lntFormRussianNoImportant,
  FormNoRussianNoImportant, // lntFormNoRussianNoImportant
  DocIcon,
  AACDocumentIcon
 );
//#UC END# *4F7EEFD601CE_497DDB2B001B_var*
begin
//#UC START# *4F7EEFD601CE_497DDB2B001B_impl*
 if Assigned(dsList) then
  Result := cListNodeTypeImageIndex[dsList.ListNodeType(tvList.GetNode(Index))]
 else
  Result := -1;
//#UC END# *4F7EEFD601CE_497DDB2B001B_impl*
end;//TPrimListForm.TvListGetItemImage

procedure TPrimListForm.TvListActionElement(Sender: TObject;
  Index: Integer);
//#UC START# *4F7EF0130083_497DDB2B001B_var*
var
 l_DataInfo: IdeDocInfo;
 l_Cont : IvcmContainer;
 l_OpenKind: TvcmMainFormOpenKind;
//#UC END# *4F7EF0130083_497DDB2B001B_var*
begin
//#UC START# *4F7EF0130083_497DDB2B001B_impl*
 if dsList <> nil then
 begin
  // ���������� �������� ���������� ����� �������� ��������� �� ������.
  // �������� �����:
  // - ������� �������� �� ������;
  // - ����������� �������� �������� � ������ �������, ������, ��� ���� �������
  //   ������� � �������� INodeBase.IsSame, �������� ����� �����;
  // - ������� CurrentChanged ������ �� ������, ��� �������� � ������ ����
  //   ������� ��� ����� ��������, ��. �������� (CQ: 20409);
  // - ������� ������� ������������� �����:
  //dsList.CurrentChanged(tvList.GetCurrentNode, False);
  CallCurrentChanged;
  if dsList.OpenDocument(l_DataInfo) then
  try
   Dispatcher.LockCursor;
   try
    l_OpenKind := nsDocumentsFromListOpenKind;
    l_Cont := nsOpenNewWindowTabbed(NativeMainForm, l_OpenKind);
    if (l_Cont = nil) then
     Exit;
    InitNewContainerBaseSearch(l_Cont, l_OpenKind);
    // - http://mdp.garant.ru/pages/viewpage.action?pageId=566792807
    OpenDocument(l_DataInfo, l_Cont, (l_OpenKind = vcm_okInNewTab));
   finally
    Dispatcher.UnlockCursor;
   end;//try..finally
  finally
   l_DataInfo := nil;
  end;//try..finally
 end;//if Assigned(dsDocumentList) then
//#UC END# *4F7EF0130083_497DDB2B001B_impl*
end;//TPrimListForm.TvListActionElement

procedure TPrimListForm.TvListCurrentChanged(Sender: TObject;
  NewCurrent: Integer;
  OldCurrent: Integer);
//#UC START# *4F7EF03501DF_497DDB2B001B_var*
//#UC END# *4F7EF03501DF_497DDB2B001B_var*
begin
//#UC START# *4F7EF03501DF_497DDB2B001B_impl*
 if (dsList <> nil) then
  dsList.CurrentChanged(tvList.GetCurrentNode);
//#UC END# *4F7EF03501DF_497DDB2B001B_impl*
end;//TPrimListForm.TvListCurrentChanged

procedure TPrimListForm.TvListTreeChanged(aSender: TObject;
  const anOldTree: Il3SimpleTree;
  const aNewTree: Il3SimpleTree);
//#UC START# *4F7EF07001DF_497DDB2B001B_var*
//#UC END# *4F7EF07001DF_497DDB2B001B_var*
begin
//#UC START# *4F7EF07001DF_497DDB2B001B_impl*
 ShowEditorOrList(aNewTree);
//#UC END# *4F7EF07001DF_497DDB2B001B_impl*
end;//TPrimListForm.TvListTreeChanged

procedure TPrimListForm.TvListRootChanged(aSender: TObject;
  const anOldRoot: IeeNode;
  const aNewRoot: IeeNode);
//#UC START# *4F7EF09F0325_497DDB2B001B_var*
//#UC END# *4F7EF09F0325_497DDB2B001B_var*
begin
//#UC START# *4F7EF09F0325_497DDB2B001B_impl*
 UpdateFooter;
//#UC END# *4F7EF09F0325_497DDB2B001B_impl*
end;//TPrimListForm.TvListRootChanged

procedure TPrimListForm.TvListSelectCountChanged(aSender: TObject;
  anOldCount: Integer;
  aNewCount: Integer);
//#UC START# *4F7EF0DC0246_497DDB2B001B_var*
//#UC END# *4F7EF0DC0246_497DDB2B001B_var*
begin
//#UC START# *4F7EF0DC0246_497DDB2B001B_impl*
 Dispatcher.UpdateStatus;
//#UC END# *4F7EF0DC0246_497DDB2B001B_impl*
end;//TPrimListForm.TvListSelectCountChanged

procedure TPrimListForm.TvListFormatStatusInfo(aSender: TObject;
  var Info: Il3CString;
  aCurrent: Integer;
  aCount: Integer;
  aSelected: Integer);
//#UC START# *4F7EF12300F6_497DDB2B001B_var*
var
 l_Count: Integer;
const
 c_Count = 100;
//#UC END# *4F7EF12300F6_497DDB2B001B_var*
begin
//#UC START# *4F7EF12300F6_497DDB2B001B_impl*
 if Assigned(dsDocumentList) then
 begin
  // ��� ������� ��������������� �� �������������, ��� ���������� ������,
  // ���������� ������������� �������� �������� (CQ: OIT5-23059):
  if afw.Application.IsInternal and (dsDocumentList.SortType = ST_RELEVANCE) then
   Info := vcmFmt(str_ListStatusInfoWithRelevance, [aCurrent, aCount, aSelected, dsDocumentList.CurrentRelevance]);

  if dsDocumentList.IsShortList then
  begin
   l_Count := dsDocumentList.FullListCount;
   l_Count := l_Count - l_Count mod c_Count;
   if l_Count > 0
    then Info := l3LTrim(l3Cat([Info, vcmFmt(str_ApproxShortListCount, [l_Count])]))
    else Info := l3LTrim(l3Cat([Info, vcmFmt(str_ApproxShortListCountEx, [c_Count])]));
  end;
 end;
//#UC END# *4F7EF12300F6_497DDB2B001B_impl*
end;//TPrimListForm.TvListFormatStatusInfo

procedure TPrimListForm.TvListNewCharPressed(aChar: AnsiChar);
//#UC START# *4F7EF16A0086_497DDB2B001B_var*
//#UC END# *4F7EF16A0086_497DDB2B001B_var*
begin
//#UC START# *4F7EF16A0086_497DDB2B001B_impl*
 if HasContextFiltration then
  cfList.PressChar(aChar);
//#UC END# *4F7EF16A0086_497DDB2B001B_impl*
end;//TPrimListForm.TvListNewCharPressed

procedure TPrimListForm.TvListCheckFocusedInPaint(aSender: TObject;
  var aFocused: Boolean);
//#UC START# *4F7EF18C027D_497DDB2B001B_var*
//#UC END# *4F7EF18C027D_497DDB2B001B_var*
begin
//#UC START# *4F7EF18C027D_497DDB2B001B_impl*
 if not aFocused then
  aFocused := f_SearchWindowVisible;
//#UC END# *4F7EF18C027D_497DDB2B001B_impl*
end;//TPrimListForm.TvListCheckFocusedInPaint

procedure TPrimListForm.TvListFooterClick(Sender: TObject);
//#UC START# *4F7EF1C1030D_497DDB2B001B_var*
//#UC END# *4F7EF1C1030D_497DDB2B001B_var*
begin
//#UC START# *4F7EF1C1030D_497DDB2B001B_impl*
 DoSwitchToFullList;
//#UC END# *4F7EF1C1030D_497DDB2B001B_impl*
end;//TPrimListForm.TvListFooterClick

function TPrimListForm.TvListGetNodeType(anIndex: Integer): TbsListNodeType;
//#UC START# *51DC1AA10279_497DDB2B001B_var*
//#UC END# *51DC1AA10279_497DDB2B001B_var*
begin
//#UC START# *51DC1AA10279_497DDB2B001B_impl*
 Assert(Assigned(dsList));
 Result := dsList.ListNodeType(tvList.GetNode(anIndex));
//#UC END# *51DC1AA10279_497DDB2B001B_impl*
end;//TPrimListForm.TvListGetNodeType

procedure TPrimListForm.CallCurrentChanged;
//#UC START# *5527D24201E7_497DDB2B001B_var*
//#UC END# *5527D24201E7_497DDB2B001B_var*
begin
//#UC START# *5527D24201E7_497DDB2B001B_impl*
 if Assigned(dsList) then
 begin
  f_AllowCallCurrentChangedOnTest := False;
  dsList.CurrentChanged(tvList.GetCurrentNode, False);
 end;
//#UC END# *5527D24201E7_497DDB2B001B_impl*
end;//TPrimListForm.CallCurrentChanged

function TPrimListForm.HasSelected: Boolean;
//#UC START# *4C341EE90370_497DDB2B001B_var*
//#UC END# *4C341EE90370_497DDB2B001B_var*
begin
//#UC START# *4C341EE90370_497DDB2B001B_impl*
 Result := tvList.TreeView.Tree.SelectedCount > 0;
//#UC END# *4C341EE90370_497DDB2B001B_impl*
end;//TPrimListForm.HasSelected

procedure TPrimListForm.SelectionOpsTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3440AB00A0_497DDB2B001B_var*
//#UC END# *4C3440AB00A0_497DDB2B001B_var*
begin
//#UC START# *4C3440AB00A0_497DDB2B001B_impl*
 if aParams.Control = tvList then
  aParams.Op.Flag[vcm_ofEnabled] := not IsListEmpty and HasSelected
 else
  if not aParams.CallControl then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C3440AB00A0_497DDB2B001B_impl*
end;//TPrimListForm.SelectionOpsTest

procedure TPrimListForm.StatusParamsShow;
//#UC START# *4C344155021B_497DDB2B001B_var*
//#UC END# *4C344155021B_497DDB2B001B_var*
begin
//#UC START# *4C344155021B_497DDB2B001B_impl*
 Dispatcher.UpdateStatus;
//#UC END# *4C344155021B_497DDB2B001B_impl*
end;//TPrimListForm.StatusParamsShow

procedure TPrimListForm.OpenCurrentList(const aContainer: IvcmContainer);
//#UC START# *4C3A9EA80160_497DDB2B001B_var*
var
 l_List: IdeList;
//#UC END# *4C3A9EA80160_497DDB2B001B_var*
begin
//#UC START# *4C3A9EA80160_497DDB2B001B_impl*
 if Assigned(dsList) then
 begin
  l_List := dsList.NewList;
  if l_List <> nil then
  try
   TdmStdRes.OpenList(l_List, aContainer);
  finally
   l_List := nil;
  end;{try..finally}
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C3A9EA80160_497DDB2B001B_impl*
end;//TPrimListForm.OpenCurrentList

procedure TPrimListForm.AddSelectedToControl(aOnlySet: Boolean);
//#UC START# *4C3AACCF01DC_497DDB2B001B_var*
var
 l_Tree: Il3ExpandedSimpleTree;

 function SetControlled(const aNode: Il3SimpleNode): Boolean;
 var
  l_Node: INodeBase;
  l_Document: IDocument;
  l_Controllable: IControllable;
 begin
  if Supports(aNode, INodeBase, l_Node) then
  try
   l_Document := GetAsDocument(l_Node);
   if Assigned(l_Document) and TdmStdRes.IsCurEditionActual(l_Document) and
      Supports(l_Document, IControllable, l_Controllable) then
   try
    if not l_Controllable.GetControlled then
     TdmStdRes.AddToControl(l_Controllable);
   finally
    l_Controllable := nil;
   end;
  finally
   l_Node := nil;
  end;
  Result := False;
 end;//SetControlled

var
 l_Count: Integer;
//#UC END# *4C3AACCF01DC_497DDB2B001B_var*
begin
//#UC START# *4C3AACCF01DC_497DDB2B001B_impl*
 l_Count := tvList.TreeView.Tree.SelectedCount;
 if Assigned(dsDocumentList) and
    (l_Count >= 1) then
 begin
  if (l_Count = 1) then
  begin
   if not dsDocumentList.IsUnderControl then
   begin
    dsDocumentList.AddToControl;
    Say(inf_SetDocToControl);
   end
   else //not dsDocumentList.IsUnderControl
    if Ask(qr_RemoveDocumentFromControl) then
     dsDocumentList.DelFromControl;
  end
  else // �������� ��������� ���������
   if Supports(tvList.TreeStruct, Il3ExpandedSimpleTree, l_Tree) then
   begin
    l_Tree.FlagIterateF(l3L2SNA(@SetControlled), FM_SELECTION);
    Say(inf_SetDocsToControl);
   end;
 end;
//#UC END# *4C3AACCF01DC_497DDB2B001B_impl*
end;//TPrimListForm.AddSelectedToControl

procedure TPrimListForm.ListOpsWithTrialModeTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C46BD3E00FD_497DDB2B001B_var*
//#UC END# *4C46BD3E00FD_497DDB2B001B_var*
begin
//#UC START# *4C46BD3E00FD_497DDB2B001B_impl*
 ListOpsTest(aParams);
 nsDisableOperationInTrialMode(aParams);
//#UC END# *4C46BD3E00FD_497DDB2B001B_impl*
end;//TPrimListForm.ListOpsWithTrialModeTest

function TPrimListForm.MakePreview(WithTexts: Boolean): IafwComplexDocumentPreview;
//#UC START# *4C46BDD50220_497DDB2B001B_var*
//#UC END# *4C46BDD50220_497DDB2B001B_var*
var
 l_Node : Il3SimpleNode;
 l_Super : InsSuperComplexDocumentPreview;
begin
//#UC START# *4C46BDD50220_497DDB2B001B_impl*
 Result := nil;
 if Assigned(dsList) then
 begin
  with dsList do
   l_Super := MakeSuperPreview(bsListPrintOnlyFirstLevel(ListType), WithTexts);
  if (l_Super <> nil) and (l_Super.DocumentTitles <> nil) and (l_Super.DocumentTitles.Document <> nil) and
   Supports(tvList.TreeView.CurrentNode, Il3SimpleNode, l_Node) then
   l_Super.DocumentTitles.Document.SetCurrentPagePara(dsList.NodeId(l_Node));
  Result := l_Super;
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C46BDD50220_497DDB2B001B_impl*
end;//TPrimListForm.MakePreview

procedure TPrimListForm.SaveList(InitialSaveTitles: Boolean;
  MinSelectedCount: Integer = 2);
//#UC START# *4C46BEFD00CB_497DDB2B001B_var*
var
 l_Stream     : IStream;
 l_Visualizer : IafwLongProcessVisualizer;
 l_Output: TnsGetGenOutputStruct;
 l_Saved: Boolean;
//#UC END# *4C46BEFD00CB_497DDB2B001B_var*
begin
//#UC START# *4C46BEFD00CB_497DDB2B001B_impl*
 if Assigned(dsList) and not dsList.IsListEmpty then
  try
   l_Stream := nil;
   with dmStdRes do begin
    if afw.Application.IsInternal then
     SaveDialog.DialogKind := ns_sdkListInternal
    else
     SaveDialog.DialogKind := ns_sdkList;

    if InitialSaveTitles then
     SaveDialog.SaveListTarget := ns_sdlkTitles
    else
     SaveDialog.SaveListTarget := ns_sdlkContents;
    SaveDialog.MergeChecked := False;
    SaveDialog.SelectedOnlyEnabled := tvList.TreeView.Tree.SelectedCount >= MinSelectedCount;
    SaveDialog.SelectedOnlyChecked := SaveDialog.SelectedOnlyEnabled;
    //l_PathName := dsList.ListName;
    l_Output := TnsGetGenOutputStruct_Create(dsList.ListName);
    if SaveDialog.SelectedOnlyChecked then
    begin
     if InitialSaveTitles then
      l_Output.rName := l3Fmt(vcmCStr(str_SaveSelectedListPrefix),[l_Output.rName])
     else
      l_Output.rName := l3Fmt(vcmCStr(str_ExportSelectedListPrefix),[l_Output.rName]);
    end;//if SaveDialog.SelectedOnlyChecked then
    SaveDialog.FileName := l3Str(nsPrepareFileName(l_Output.rName));
    SaveDialog.OnCanClose := SaveDialogCanClose;
    try
     if SaveDialog.Execute then
     begin
      if (SaveDialog.SaveListTarget = ns_sdlkTitles) and
         (SaveDialog.SelectedFileFormat = ns_ffXML) and
         defDataAdapter.ListXMLExportEnabled then
      begin
       dsList.SaveToFile(l3PCharLen(SaveDialog.FileName), SaveDialog.SelectedOnlyChecked);
       Exit;
      end;
      TnsListExportToFileEvent.Log(dsList.List, ApproxExportCount(SaveDialog.SelectedOnlyChecked),
        SaveDialog.SelectedOnlyChecked, SaveDialog.SaveListTarget);
      case SaveDialog.SaveListTarget of
       ns_sdlkTitles,
       ns_sdlkIdentifiers:
        begin
         l_Visualizer := bsMakeSaveVisualizer(vcmCStr(str_SaveListVisualizer));
         try
          l_Stream := dsList.ListAsText(CalcSaveListKind(SaveDialog.SaveListTarget = ns_sdlkTitles),
            SaveDialog.SelectedOnlyChecked);
          try
           //http://mdp.garant.ru/pages/viewpage.action?pageId=484813563
           Finalize(l_Output);
           l_Output := TnsGetGenOutputStruct_Create(nsCStr(SaveDialog.FileName));
           if not nsEvdStreamSaveAs(l_Stream,
                                    l_Output,
                                    SaveDialog.SelectedFileFormat,
                                    False) then
           begin
            l_Visualizer := nil;
            Say(err_CannotSave, [l_Output.rName]);
           end;
          finally
            l_Stream := nil;
          end;
         finally
          l_Visualizer := nil;
         end;
        end;
       ns_sdlkContents:
        begin
         afw.ProcessMessages;
         try
          l_Saved := True;
          l_Visualizer := bsMakeSaveVisualizer(vcmCStr(str_SaveDocumentsVisualizer));
          try
           if SaveDialog.MergeChecked then
            l_Saved := dsList.MergeDocuments(bsListPrintOnlyFirstLevel(dsList.ListType),
             SaveDialog.SelectedOnlyChecked, nsCStr(SaveDialog.FileName),
             SaveDialog.SelectedFileFormat, afw.Application.IsInternal)
           else
            l_Saved := dsList.ExportDocuments(bsListPrintOnlyFirstLevel(dsList.ListType),
             SaveDialog.SelectedOnlyChecked, nsCStr(ExtractFilePath(SaveDialog.FileName)),
             SaveDialog.SelectedFileFormat);
          finally
           l_Visualizer := nil;
          end;
           if not l_Saved then
          begin
           if SaveDialog.MergeChecked then
            DeleteFile(SaveDialog.FileName);
            Say(inf_ExportForThisDocumentsImpossible)
          end;
         except
          on ECannotSave do
           Say(err_ListSaveToFileError);
         end{try..except}
        end;
      end;
     end;
    finally
     SaveDialog.OnCanClose := nil;
     Dispatcher.UpdateStatus;
    end;
   end;
  except
   on E: Exception do
    l3System.Exception2Log(E);
  end;
//#UC END# *4C46BEFD00CB_497DDB2B001B_impl*
end;//TPrimListForm.SaveList

procedure TPrimListForm.SaveDialogCanClose(Sender: TObject;
  var CanClose: Boolean);
//#UC START# *4C46C3D50130_497DDB2B001B_var*
//#UC END# *4C46C3D50130_497DDB2B001B_var*
begin
//#UC START# *4C46C3D50130_497DDB2B001B_impl*
 with Sender as TnsSaveDIalog do
 begin
  if (SaveListTarget = ns_sdlkContents) and (ApproxExportCount(SelectedOnlyChecked) > c_MaxDocumentInListLimit) then
   if not afw.Application.IsInternal or not afw.Settings.LoadBoolean(pi_List_ExportWORestrictions, dv_List_ExportWORestrictions) then
   begin
    CanClose := False;
    Say(war_TryToExportTooManyDocs, [c_MaxDocumentInListLimit]);
   end;
  if (SaveListTarget = ns_sdlkTitles) and (ApproxExportCount(SelectedOnlyChecked) > c_MaxTotalDocumentInListLimit) then
   if not afw.Application.IsInternal or not afw.Settings.LoadBoolean(pi_List_ExportWORestrictions, dv_List_ExportWORestrictions) then
   begin
    CanClose := False;
    Say(war_TryToExportTooManyTotalDocs, [c_MaxTotalDocumentInListLimit]);
   end;
 end; 
//#UC END# *4C46C3D50130_497DDB2B001B_impl*
end;//TPrimListForm.SaveDialogCanClose

function TPrimListForm.ApproxExportCount(aUseSelection: Boolean): Integer;
//#UC START# *4C46C40703A2_497DDB2B001B_var*
//#UC END# *4C46C40703A2_497DDB2B001B_var*
begin
//#UC START# *4C46C40703A2_497DDB2B001B_impl*
 if aUseSelection then
  Result := tvList.TreeView.Tree.SelectedCount
 else
  Result := tvList.TreeView.Tree.Root.ThisChildrenCount;
//#UC END# *4C46C40703A2_497DDB2B001B_impl*
end;//TPrimListForm.ApproxExportCount

function TPrimListForm.CalcSaveListKind(aTitles: Boolean = True): TbsSaveListKind;
//#UC START# *4C46C42C019B_497DDB2B001B_var*
//#UC END# *4C46C42C019B_497DDB2B001B_var*
begin
//#UC START# *4C46C42C019B_497DDB2B001B_impl*
 if aTitles then
 begin
  if bsListPrintOnlyFirstLevel(dsList.ListType) then
   Result := bs_slkTitlesFirstLevel
  else
   Result := bs_slkTitlesFullTree
 end
 else
  Result := bs_slkTitlesTopicNumbers
//#UC END# *4C46C42C019B_497DDB2B001B_impl*
end;//TPrimListForm.CalcSaveListKind

procedure TPrimListForm.ListopPrintTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C46CA7A0020_497DDB2B001B_var*
//#UC END# *4C46CA7A0020_497DDB2B001B_var*
begin
//#UC START# *4C46CA7A0020_497DDB2B001B_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsList) and
  (Printer.Printers.Count > 0) and not dsList.IsListEmpty and
  HasCurrent;
//#UC END# *4C46CA7A0020_497DDB2B001B_impl*
end;//TPrimListForm.ListopPrintTest

function TPrimListForm.CreateListName(aHasSelection: Boolean = false): Il3CString;
//#UC START# *4C46CBBD0211_497DDB2B001B_var*
//#UC END# *4C46CBBD0211_497DDB2B001B_var*
begin
//#UC START# *4C46CBBD0211_497DDB2B001B_impl*
 Result := nil;
 if Assigned(dsList) then
 try
  Result := dsList.ListName;
  if aHasSelection then
   Result := vcmFmt(str_SaveSelectedListPrefix, [Result]);
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *4C46CBBD0211_497DDB2B001B_impl*
end;//TPrimListForm.CreateListName

procedure TPrimListForm.OpenInNewWindow;
//#UC START# *4C46E91E0188_497DDB2B001B_var*
var
 l_Container: IvcmContainer;
//#UC END# *4C46E91E0188_497DDB2B001B_var*
begin
//#UC START# *4C46E91E0188_497DDB2B001B_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=414849606
 l_Container := nsNewWindow(NativeMainForm);
 if (l_Container <> nil) then
 try
  OpenCurrentList(l_Container);
 finally
  l_Container := nil;
 end;
//#UC END# *4C46E91E0188_497DDB2B001B_impl*
end;//TPrimListForm.OpenInNewWindow

function TPrimListForm.ForbidOpForDocumentSchema(const aParams: IvcmTestParamsPrim): Boolean;
//#UC START# *4C5289B102E0_497DDB2B001B_var*
//#UC END# *4C5289B102E0_497DDB2B001B_var*
begin
//#UC START# *4C5289B102E0_497DDB2B001B_impl*
 Result := (sdsBaseDocument <> nil) AND (sdsBaseDocument.DocInfo <> nil) AND
           (sdsBaseDocument.DocInfo.Doc <> nil) AND
           (sdsBaseDocument.DocInfo.Doc.GetDocType = DT_FLASH);
 aParams.Op.Flag[vcm_ofEnabled] := not Result;
//#UC END# *4C5289B102E0_497DDB2B001B_impl*
end;//TPrimListForm.ForbidOpForDocumentSchema

procedure TPrimListForm.DocumentOpsWithTrialModeTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C5289E9034B_497DDB2B001B_var*
//#UC END# *4C5289E9034B_497DDB2B001B_var*
begin
//#UC START# *4C5289E9034B_497DDB2B001B_impl*
 DocumentOpsTest(aParams);
 nsDisableOperationInTrialMode(aParams);
//#UC END# *4C5289E9034B_497DDB2B001B_impl*
end;//TPrimListForm.DocumentOpsWithTrialModeTest

procedure TPrimListForm.DocumentOpsTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4C528A1900DC_497DDB2B001B_var*

  function lp_IsValidDocument: Boolean;
  begin
   // ��� ��������� �������� ����������� �� ����������� ��������, ��� ����������
   // ����������� �� ���������� �������� ���:
   if dsDocumentList <> nil then
    Result := dsDocumentList.IsDocument
   else
    Result := dsList <> nil;
  end;//lp_IsValidDocument

//#UC END# *4C528A1900DC_497DDB2B001B_var*
begin
//#UC START# *4C528A1900DC_497DDB2B001B_impl*
 with tvList.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := lp_IsValidDocument and
   NoMoreThanOneSelected and HasCurrent;
//#UC END# *4C528A1900DC_497DDB2B001B_impl*
end;//TPrimListForm.DocumentOpsTest

procedure TPrimListForm.UpdateFooter;
//#UC START# *4F7EF6430383_497DDB2B001B_var*
//#UC END# *4F7EF6430383_497DDB2B001B_var*
begin
//#UC START# *4F7EF6430383_497DDB2B001B_impl*
 tvList.FooterVisible := Assigned(dsDocumentList) and dsDocumentList.IsShortList;
 CanSwithToFullList := tvList.FooterVisible;
 Dispatcher.UpdateStatus;
//#UC END# *4F7EF6430383_497DDB2B001B_impl*
end;//TPrimListForm.UpdateFooter

function TPrimListForm.HasContextFiltration: Boolean;
//#UC START# *4F7EFAA2026F_497DDB2B001B_var*
//#UC END# *4F7EFAA2026F_497DDB2B001B_var*
begin
//#UC START# *4F7EFAA2026F_497DDB2B001B_impl*
 Result := UserType = lftDrugList;
//#UC END# *4F7EFAA2026F_497DDB2B001B_impl*
end;//TPrimListForm.HasContextFiltration

procedure TPrimListForm.InitNewContainerBaseSearch(const aContainer: IvcmContainer;
  aOpenKind: TvcmMainFormOpenKind);
//#UC START# *543E272E0005_497DDB2B001B_var*
//#UC END# *543E272E0005_497DDB2B001B_var*
begin
//#UC START# *543E272E0005_497DDB2B001B_impl*
 Assert(aContainer <> nil);
 if (UserType = lftNone) and
    (aOpenKind in [vcm_okInNewWindow, vcm_okInNewTab]) and
    (dsDocumentList <> nil) and
    (dsDocumentList.OpenFrom in [lofBaseSearch, lofAttributeSearch]) then
  aContainer.InitFromPrevContainer(NativeMainForm, False);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=566792807,
 // http://mdp.garant.ru/pages/viewpage.action?pageId=567573990
//#UC END# *543E272E0005_497DDB2B001B_impl*
end;//TPrimListForm.InitNewContainerBaseSearch
// start class TnsDeleteFromListEvent

class procedure TnsDeleteFromListEvent.Log(const aList: IDynList);
//#UC START# *4B0A86E800FF_4B0A86AD0232_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0A86E800FF_4B0A86AD0232_var*
begin
//#UC START# *4B0A86E800FF_4B0A86AD0232_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 GetLogger.AddEvent(LE_DELETE_FROM_LIST, l_Data);
//#UC END# *4B0A86E800FF_4B0A86AD0232_impl*
end;//TnsDeleteFromListEvent.Log
// start class TnsListExportToFileEvent

class procedure TnsListExportToFileEvent.Log(const aList: IDynList;
  aCount: Cardinal;
  aSelection: Boolean;
  aTarget: TnsSaveDialogListTarget);
//#UC START# *4C46C48700C2_4C46C47002CA_var*
var
 l_Data: InsLogEventData;
const
 c_TypeMap: array [TnsSaveDialogListTarget] of Integer = (0, 1, 2);
//#UC END# *4C46C48700C2_4C46C47002CA_var*
begin
//#UC START# *4C46C48700C2_4C46C47002CA_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddULong(aCount);
 l_Data.AddULong(c_SelectionMap[aSelection]);
 l_Data.AddULong(c_TypeMap[aTarget]);
 GetLogger.AddEvent(LE_LIST_EXPORT_TO_FILE, l_Data);
//#UC END# *4C46C48700C2_4C46C47002CA_impl*
end;//TnsListExportToFileEvent.Log
// start class TnsListPrintPreviewEvent

class procedure TnsListPrintPreviewEvent.Log(const aList: IDynList;
  aCount: Cardinal;
  aSelection: Boolean);
//#UC START# *4C46CAC40062_4C46CAB8035D_var*
var
 l_Data: InsLogEventData;
//#UC END# *4C46CAC40062_4C46CAB8035D_var*
begin
//#UC START# *4C46CAC40062_4C46CAB8035D_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddULong(aCount);
 l_Data.AddULong(c_SelectionMap[aSelection]);
 GetLogger.AddEvent(LE_LIST_PRINT_PREVIEW, l_Data);
//#UC END# *4C46CAC40062_4C46CAB8035D_impl*
end;//TnsListPrintPreviewEvent.Log
// start class TnsListExportToWordEvent

class procedure TnsListExportToWordEvent.Log(const aList: IDynList;
  aCount: Cardinal;
  aSelection: Boolean);
//#UC START# *4C46CC6D02D6_4C46CC5C0104_var*
var
 l_Data: InsLogEventData;
//#UC END# *4C46CC6D02D6_4C46CC5C0104_var*
begin
//#UC START# *4C46CC6D02D6_4C46CC5C0104_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddULong(aCount);
 l_Data.AddULong(c_SelectionMap[aSelection]);
 GetLogger.AddEvent(LE_LIST_EXPORT_TO_WORD, l_Data);
//#UC END# *4C46CC6D02D6_4C46CC5C0104_impl*
end;//TnsListExportToWordEvent.Log
// start class TnsSendListByEmailEvent

class procedure TnsSendListByEmailEvent.Log(const aList: IDynList;
  aCount: Cardinal;
  aSelection: Boolean);
//#UC START# *4C46CD590073_4C46CD36024B_var*
var
 l_Data: InsLogEventData;
//#UC END# *4C46CD590073_4C46CD36024B_var*
begin
//#UC START# *4C46CD590073_4C46CD36024B_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aList);
 l_Data.AddULong(aCount);
 l_Data.AddULong(c_SelectionMap[aSelection]);
 GetLogger.AddEvent(LE_SEND_LIST_BY_EMAIL, l_Data);
//#UC END# *4C46CD590073_4C46CD36024B_impl*
end;//TnsSendListByEmailEvent.Log
// start class TnsViewSameDocumentsEvent

class procedure TnsViewSameDocumentsEvent.Log(const aDoc: IDocument;
  aCount: Cardinal);
//#UC START# *4B0CF288004C_4B0CF2510084_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0CF288004C_4B0CF2510084_var*
begin
//#UC START# *4B0CF288004C_4B0CF2510084_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddULong(aCount);
 GetLogger.AddEvent(LE_VIEW_SAME_DOCUMENTS, l_Data);
//#UC END# *4B0CF288004C_4B0CF2510084_impl*
end;//TnsViewSameDocumentsEvent.Log
{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

// start class TPrimListFormState

constructor TPrimListFormState.Create(const aInnerState: IvcmBase;
  const aContextFilterState: IUnknown;
  const aTreeStructState: InsTreeStructState;
  aTopItemIndex: Integer;
  aCurrentIndex: Integer;
  aOptions: TPrimListFormStateOptions);
//#UC START# *5677BAD7012E_5677B9280204_var*
//#UC END# *5677BAD7012E_5677B9280204_var*
begin
//#UC START# *5677BAD7012E_5677B9280204_impl*
 inherited Create;
 f_InnerState := aInnerState;
 f_ContextFilterState := aContextFilterState;
 f_TreeStructState := aTreeStructState;
 f_TopItemIndex := aTopItemIndex;
 f_CurrentIndex := aCurrentIndex;
 f_Options := aOptions;
//#UC END# *5677BAD7012E_5677B9280204_impl*
end;//TPrimListFormState.Create

class function TPrimListFormState.Make(const aInnerState: IvcmBase;
  const aContextFilterState: IUnknown;
  const aTreeStructState: InsTreeStructState;
  aTopItemIndex: Integer;
  aCurrentIndex: Integer;
  aOptions: TPrimListFormStateOptions): IPrimListFormState;
var
 l_Inst : TPrimListFormState;
begin
 l_Inst := Create(aInnerState, aContextFilterState, aTreeStructState, aTopItemIndex, aCurrentIndex, aOptions);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TPrimListFormState.pm_GetInnerState: IvcmBase;
//#UC START# *5677BA0B01C2_5677B9280204get_var*
//#UC END# *5677BA0B01C2_5677B9280204get_var*
begin
//#UC START# *5677BA0B01C2_5677B9280204get_impl*
 Result := f_InnerState;
//#UC END# *5677BA0B01C2_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetInnerState

function TPrimListFormState.pm_GetContextFilterState: IUnknown;
//#UC START# *5677BA5B0133_5677B9280204get_var*
//#UC END# *5677BA5B0133_5677B9280204get_var*
begin
//#UC START# *5677BA5B0133_5677B9280204get_impl*
 Result := f_ContextFilterState;
//#UC END# *5677BA5B0133_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetContextFilterState

function TPrimListFormState.pm_GetTreeStructState: InsTreeStructState;
//#UC START# *56A8ADEE0129_5677B9280204get_var*
//#UC END# *56A8ADEE0129_5677B9280204get_var*
begin
//#UC START# *56A8ADEE0129_5677B9280204get_impl*
 Result := f_TreeStructState; 
//#UC END# *56A8ADEE0129_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetTreeStructState

function TPrimListFormState.pm_GetTopItemIndex: Integer;
//#UC START# *56A9C9980259_5677B9280204get_var*
//#UC END# *56A9C9980259_5677B9280204get_var*
begin
//#UC START# *56A9C9980259_5677B9280204get_impl*
 Result := f_TopItemIndex;
//#UC END# *56A9C9980259_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetTopItemIndex

function TPrimListFormState.pm_GetOptions: TPrimListFormStateOptions;
//#UC START# *56A9DE4C03A0_5677B9280204get_var*
//#UC END# *56A9DE4C03A0_5677B9280204get_var*
begin
//#UC START# *56A9DE4C03A0_5677B9280204get_impl*
 Result := f_Options;
//#UC END# *56A9DE4C03A0_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetOptions

function TPrimListFormState.pm_GetCurrentIndex: Integer;
//#UC START# *56E152870083_5677B9280204get_var*
//#UC END# *56E152870083_5677B9280204get_var*
begin
//#UC START# *56E152870083_5677B9280204get_impl*
 Result := f_CurrentIndex;
//#UC END# *56E152870083_5677B9280204get_impl*
end;//TPrimListFormState.pm_GetCurrentIndex

function TPrimListFormState.QueryInterface(const IID: TGUID;
  out Obj): HResult;
//#UC START# *47A0AD3A01F7_5677B9280204_var*
//#UC END# *47A0AD3A01F7_5677B9280204_var*
begin
//#UC START# *47A0AD3A01F7_5677B9280204_impl*
 Result := inherited QueryInterface(IID, Obj);
//#UC END# *47A0AD3A01F7_5677B9280204_impl*
end;//TPrimListFormState.QueryInterface

procedure TPrimListFormState.FinishDataUpdate;
//#UC START# *47EA4E9002C6_5677B9280204_var*
//#UC END# *47EA4E9002C6_5677B9280204_var*
begin
//#UC START# *47EA4E9002C6_5677B9280204_impl*
 f_Options := [];
 f_TreeStructState := nil;
//#UC END# *47EA4E9002C6_5677B9280204_impl*
end;//TPrimListFormState.FinishDataUpdate

function TPrimListForm.pm_GetNoMoreThanOneSelected: Boolean;
//#UC START# *4C3AA8E0004C_497DDB2B001Bget_var*
//#UC END# *4C3AA8E0004C_497DDB2B001Bget_var*
begin
//#UC START# *4C3AA8E0004C_497DDB2B001Bget_impl*
 Result := tvList.TreeView.Tree.SelectedCount <= 1;
//#UC END# *4C3AA8E0004C_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetNoMoreThanOneSelected

function TPrimListForm.pm_GetOnlyOneSelected: Boolean;
//#UC START# *4C3AAE7C00D0_497DDB2B001Bget_var*
//#UC END# *4C3AAE7C00D0_497DDB2B001Bget_var*
begin
//#UC START# *4C3AAE7C00D0_497DDB2B001Bget_impl*
 Result := tvList.TreeView.Tree.SelectedCount = 1;
//#UC END# *4C3AAE7C00D0_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetOnlyOneSelected

function TPrimListForm.HasCurrent: Boolean;
//#UC START# *4AF846E90103_497DDB2B001B_var*
//#UC END# *4AF846E90103_497DDB2B001B_var*
begin
//#UC START# *4AF846E90103_497DDB2B001B_impl*
 Result := (tvList.TreeView.Current >= 0);
//#UC END# *4AF846E90103_497DDB2B001B_impl*
end;//TPrimListForm.HasCurrent

procedure TPrimListForm.OpenDocument(const aDoc: IdeDocInfo;
  const aCont: IvcmContainer;
  aNeedReturnFocus: Boolean);
//#UC START# *4B0A69100289_497DDB2B001B_var*

 function lp_IndexInParent: Integer;
 var
  l_Root : Il3SimpleNode;
  l_Node : Il3SimpleNode;
  l_Temp : Il3SimpleNode;
 begin
  l_Node := tvList.GetCurrentNode;
  try
   if Assigned(l_Node) and
     Supports(tvList.TreeStruct.RootNode, Il3SimpleNode, l_Root) then
    while Assigned(l_Node) and not l_Root.IsSame(l_Node.Parent) do
    begin
     l_Temp := l_Node.Parent;
     l_Node := l_Temp;
    end;
   if Assigned(l_Node) then
    Result := Succ(l_Node.IndexInParent)
   else
   begin
    Result := 0;
    Assert(False);
   end;//Assigned(l_Node)
  finally
   l_Node := nil;
  end;//try..finally
 end;//lp_IndexInParent

 procedure lp_MakeCurrentInfo(var aRelevance, aNumber, aSubBlock, aPara: Integer);
 var
  l_ListEntry: IListEntryInfo;
 begin//lp_MakeCurrentInfo
  l_ListEntry := bsListEntryInfo(tvList.GetCurrentNode);
  if l_ListEntry <> nil then
  try
   aRelevance := l_ListEntry.GetRelevance;
   aNumber := lp_IndexInParent;
   aSubBlock := -1;
   aPara := -1;
   case l_ListEntry.GetType of
    PT_SUB: aSubBlock := l_ListEntry.GetPosition;
    PT_PARA: aPara := l_ListEntry.GetPosition;
   end;                                       
  finally
   l_ListEntry := nil;
  end;//try..finally
 end;//lp_MakeCurrentInfo

 procedure lp_RegisterEvent;
 var
  l_Relevance: Integer;
  l_Number: Integer;
  l_SubBlock,
  l_Para: Integer;
 begin//lp_RegisterEvent
  if not (aDoc.Doc.GetDocType in [DT_AUTO_REFERAT]) then
  begin
   lp_MakeCurrentInfo(l_Relevance, l_Number, l_SubBlock, l_Para);
    // - ���������� � �������.
   TnscDocumentHistory.Instance.AddDocument(aDoc.Doc.GetInternalId);
   if aDoc.Doc.GetDocType in [DT_DOCUMENT,
                              DT_FLASH,
                              DT_ACTUAL_ANALYTICS,
                              DT_ACTUAL_ANALYTICS_CONTENTS] then
    TnsOpenDocumentFromListEvent.Log(aDoc.Doc, l_Number, l_Relevance, l_SubBlock, l_Para);
  end;
 end;//lp_RegisterEvent

//#UC END# *4B0A69100289_497DDB2B001B_var*
begin
//#UC START# *4B0A69100289_497DDB2B001B_impl*
 ForceUpdateClassForHistory;
 lp_RegisterEvent;
  // - ������� �������.
 TdmStdRes.OpenDocument(aDoc, aCont);
  // - ������� ��������.
 if aNeedReturnFocus then
  if tvList.CanFocus then
   tvList.SetFocus;
//#UC END# *4B0A69100289_497DDB2B001B_impl*
end;//TPrimListForm.OpenDocument

procedure TPrimListForm.DeleteSelectionFromList;
//#UC START# *4B0A871E038F_497DDB2B001B_var*
//#UC END# *4B0A871E038F_497DDB2B001B_var*
begin
//#UC START# *4B0A871E038F_497DDB2B001B_impl*
  if (dsList <> nil) and not IsListEmpty and
   Ask(qr_DeleteListSelected) then
  begin
   dsList.DeleteNodes;
   TnsDeleteFromListEvent.Log(dsList.List);
  end;
//#UC END# *4B0A871E038F_497DDB2B001B_impl*
end;//TPrimListForm.DeleteSelectionFromList

procedure TPrimListForm.ClearFilters;
//#UC START# *4B557A1C00D1_497DDB2B001B_var*
//#UC END# *4B557A1C00D1_497DDB2B001B_var*
begin
//#UC START# *4B557A1C00D1_497DDB2B001B_impl*
 op_Filters_DeselectAll.Call(Aggregate);
 op_Filterable_ClearAll.Call(Self.As_IvcmEntityForm);
//#UC END# *4B557A1C00D1_497DDB2B001B_impl*
end;//TPrimListForm.ClearFilters

procedure TPrimListForm.DoSwitchToFullList;
//#UC START# *4B557C640258_497DDB2B001B_var*
//#UC END# *4B557C640258_497DDB2B001B_var*
begin
//#UC START# *4B557C640258_497DDB2B001B_impl*
 if Assigned(dsDocumentList) and dsDocumentList.IsShortList then
  TdmStdRes.OpenList{WithReplace}(dsDocumentList.MakeFullList, NativeMainForm);
//#UC END# *4B557C640258_497DDB2B001B_impl*
end;//TPrimListForm.DoSwitchToFullList

procedure TPrimListForm.ListOpsTest(const aParams: IvcmTestParamsPrim);
//#UC START# *4B5580C902B0_497DDB2B001B_var*
//#UC END# *4B5580C902B0_497DDB2B001B_var*
begin
//#UC START# *4B5580C902B0_497DDB2B001B_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsList) and
  not IsListEmpty and HasCurrent;
//#UC END# *4B5580C902B0_497DDB2B001B_impl*
end;//TPrimListForm.ListOpsTest

procedure TPrimListForm.LftRespondentsSynchroFormQueryMaximized(aSender: TObject);
//#UC START# *068F6EC47A8A_497DDB2B001B_var*
//#UC END# *068F6EC47A8A_497DDB2B001B_var*
begin
//#UC START# *068F6EC47A8A_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *068F6EC47A8A_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentsSynchroFormQueryMaximized

procedure TPrimListForm.LftRToPartQueryOpen(aSender: TObject);
//#UC START# *0984ADDC3D53_497DDB2B001B_var*
//#UC END# *0984ADDC3D53_497DDB2B001B_var*
begin
//#UC START# *0984ADDC3D53_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *0984ADDC3D53_497DDB2B001B_impl*
end;//TPrimListForm.LftRToPartQueryOpen

procedure TPrimListForm.LftCorrespondentsSynchroFormQueryOpen(aSender: TObject);
//#UC START# *10133243E89D_497DDB2B001B_var*
//#UC END# *10133243E89D_497DDB2B001B_var*
begin
//#UC START# *10133243E89D_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *10133243E89D_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentsSynchroFormQueryOpen

procedure TPrimListForm.LftUserCR2QueryOpen(aSender: TObject);
//#UC START# *1095984F87C1_497DDB2B001B_var*
//#UC END# *1095984F87C1_497DDB2B001B_var*
begin
//#UC START# *1095984F87C1_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *1095984F87C1_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR2QueryOpen

procedure TPrimListForm.LftSimilarDocumentsQueryOpen(aSender: TObject);
//#UC START# *3D942CB394A8_497DDB2B001B_var*
//#UC END# *3D942CB394A8_497DDB2B001B_var*
begin
//#UC START# *3D942CB394A8_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *3D942CB394A8_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsQueryOpen

procedure TPrimListForm.LftSimilarDocumentsQueryMaximized(aSender: TObject);
//#UC START# *3E3ACC41CC2A_497DDB2B001B_var*
//#UC END# *3E3ACC41CC2A_497DDB2B001B_var*
begin
//#UC START# *3E3ACC41CC2A_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *3E3ACC41CC2A_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsQueryMaximized

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_Copy_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4951284902BD_497DDB2B001Btest_var*
//#UC END# *4951284902BD_497DDB2B001Btest_var*
begin
//#UC START# *4951284902BD_497DDB2B001Btest_impl*
 if (aParams.Control = tvList) then
 begin
  SelectionOpsTest(aParams);
  //nsDisableOperationInTrialMode(aParams);
 end//aParams.Control = tvList
 else
  if not aParams.CallControl then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4951284902BD_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_Copy_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4951284902BD_497DDB2B001Bexec_var*
//#UC END# *4951284902BD_497DDB2B001Bexec_var*
begin
//#UC START# *4951284902BD_497DDB2B001Bexec_impl*
 aParams.CallControl;
//#UC END# *4951284902BD_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_Copy_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_FindContext_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49512B5D0009_497DDB2B001Btest_var*
//#UC END# *49512B5D0009_497DDB2B001Btest_var*
begin
//#UC START# *49512B5D0009_497DDB2B001Btest_impl*
 ListOpsTest(aParams);
 if (BaseSearchSupportQuery <> nil) and
    not BaseSearchSupportQuery.CanRunBaseSearch then
 begin
  aParams.Op.Flag[vcm_ofEnabled] := False;
  aParams.Op.Flag[vcm_ofVisible] := False;
 end;//BaseSearchSupportQuery <> nil
//#UC END# *49512B5D0009_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_FindContext_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_FindContext_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49512B5D0009_497DDB2B001Bexec_var*
//#UC END# *49512B5D0009_497DDB2B001Bexec_var*
begin
//#UC START# *49512B5D0009_497DDB2B001Bexec_impl*
 TdmStdRes.OpenBaseSearch(ns_bsokLocal, nil);
//#UC END# *49512B5D0009_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_FindContext_Execute
{$IfEnd} //not NoVCM

function TPrimListForm.pm_GetArea: TnsSearchArea;
//#UC START# *49513239027A_497DDB2B001Bget_var*
//#UC END# *49513239027A_497DDB2B001Bget_var*
begin
//#UC START# *49513239027A_497DDB2B001Bget_impl*
 Result := f_SearchArea;
//#UC END# *49513239027A_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetArea

procedure TPrimListForm.pm_SetArea(aValue: TnsSearchArea);
//#UC START# *49513239027A_497DDB2B001Bset_var*
//#UC END# *49513239027A_497DDB2B001Bset_var*
begin
//#UC START# *49513239027A_497DDB2B001Bset_impl*
 f_SearchArea := aValue;
//#UC END# *49513239027A_497DDB2B001Bset_impl*
end;//TPrimListForm.pm_SetArea

function TPrimListForm.Kind: TnsBaseSearchKind;
//#UC START# *4951325E03B6_497DDB2B001B_var*
//#UC END# *4951325E03B6_497DDB2B001B_var*
begin
//#UC START# *4951325E03B6_497DDB2B001B_impl*
 Result := ns_bskList;
//#UC END# *4951325E03B6_497DDB2B001B_impl*
end;//TPrimListForm.Kind

function TPrimListForm.Find(const aContext: InsBaseSearchContextProvider;
  const aProcessor: InsBaseSearchResultProcessor): Boolean;
//#UC START# *4951329202AB_497DDB2B001B_var*
//#UC END# *4951329202AB_497DDB2B001B_var*
begin
//#UC START# *4951329202AB_497DDB2B001B_impl*
 Result := False;
//#UC END# *4951329202AB_497DDB2B001B_impl*
end;//TPrimListForm.Find

function TPrimListForm.AllowSearchInTitles: Boolean;
//#UC START# *495132A703DF_497DDB2B001B_var*
//#UC END# *495132A703DF_497DDB2B001B_var*
begin
//#UC START# *495132A703DF_497DDB2B001B_impl*
 Result := True;
//#UC END# *495132A703DF_497DDB2B001B_impl*
end;//TPrimListForm.AllowSearchInTitles

function TPrimListForm.IsLocalSearchArea: Boolean;
//#UC START# *495132B70156_497DDB2B001B_var*
//#UC END# *495132B70156_497DDB2B001B_var*
begin
//#UC START# *495132B70156_497DDB2B001B_impl*
 Result := False;
//#UC END# *495132B70156_497DDB2B001B_impl*
end;//TPrimListForm.IsLocalSearchArea

procedure TPrimListForm.ContextChanged(const aNewContext: Il3CString);
//#UC START# *495132C20005_497DDB2B001B_var*
//#UC END# *495132C20005_497DDB2B001B_var*
begin
//#UC START# *495132C20005_497DDB2B001B_impl*
// Do nothing
//#UC END# *495132C20005_497DDB2B001B_impl*
end;//TPrimListForm.ContextChanged

function TPrimListForm.IsLocalDataReady: Boolean;
//#UC START# *495132CE010F_497DDB2B001B_var*
//#UC END# *495132CE010F_497DDB2B001B_var*
begin
//#UC START# *495132CE010F_497DDB2B001B_impl*
 Result := True;
//#UC END# *495132CE010F_497DDB2B001B_impl*
end;//TPrimListForm.IsLocalDataReady

function TPrimListForm.WindowRequired: Boolean;
//#UC START# *496B4C41023E_497DDB2B001B_var*
//#UC END# *496B4C41023E_497DDB2B001B_var*
begin
//#UC START# *496B4C41023E_497DDB2B001B_impl*
 Result := False;
//#UC END# *496B4C41023E_497DDB2B001B_impl*
end;//TPrimListForm.WindowRequired

function TPrimListForm.WindowCloseable: Boolean;
//#UC START# *496B4C500246_497DDB2B001B_var*
//#UC END# *496B4C500246_497DDB2B001B_var*
begin
//#UC START# *496B4C500246_497DDB2B001B_impl*
 Result := True;
//#UC END# *496B4C500246_497DDB2B001B_impl*
end;//TPrimListForm.WindowCloseable

function TPrimListForm.CanCloseWindow: Boolean;
//#UC START# *496B4CA000B6_497DDB2B001B_var*
//#UC END# *496B4CA000B6_497DDB2B001B_var*
begin
//#UC START# *496B4CA000B6_497DDB2B001B_impl*
 Result := True;
//#UC END# *496B4CA000B6_497DDB2B001B_impl*
end;//TPrimListForm.CanCloseWindow

function TPrimListForm.IsQueryCard: Boolean;
//#UC START# *496B4CD9005F_497DDB2B001B_var*
//#UC END# *496B4CD9005F_497DDB2B001B_var*
begin
//#UC START# *496B4CD9005F_497DDB2B001B_impl*
 Result := False;
//#UC END# *496B4CD9005F_497DDB2B001B_impl*
end;//TPrimListForm.IsQueryCard

function TPrimListForm.TreatSuccessSearchAsManualOpen: Boolean;
//#UC START# *496B4CE30132_497DDB2B001B_var*
//#UC END# *496B4CE30132_497DDB2B001B_var*
begin
//#UC START# *496B4CE30132_497DDB2B001B_impl*
 Result := False;
//#UC END# *496B4CE30132_497DDB2B001B_impl*
end;//TPrimListForm.TreatSuccessSearchAsManualOpen

function TPrimListForm.AutoActivateWindow: Boolean;
//#UC START# *496B4CED0306_497DDB2B001B_var*
//#UC END# *496B4CED0306_497DDB2B001B_var*
begin
//#UC START# *496B4CED0306_497DDB2B001B_impl*
 Result := False;
//#UC END# *496B4CED0306_497DDB2B001B_impl*
end;//TPrimListForm.AutoActivateWindow

procedure TPrimListForm.VisibleChanged(aNewVisible: Boolean);
//#UC START# *496B517202C5_497DDB2B001B_var*
//#UC END# *496B517202C5_497DDB2B001B_var*
begin
//#UC START# *496B517202C5_497DDB2B001B_impl*
 if (f_SearchWindowVisible <> aNewVisible) then
 begin
  f_SearchWindowVisible := aNewVisible;
  tvList.Invalidate;
  //tvList.Perform(msg_vtUpdateScroll, 0, 0);
 end;//f_SearchWindowVisible <> aNewVisible
//#UC END# *496B517202C5_497DDB2B001B_impl*
end;//TPrimListForm.VisibleChanged

procedure TPrimListForm.DoTabActivate;
//#UC START# *497F16AC015A_497DDB2B001B_var*

 function lp_Document: IDocument;
 begin
  if (sdsBaseDocument <> nil) then
   Result := sdsBaseDocument.DocInfo.Doc
  else
   Result := nil
 end;//lp_Document

 function lp_DocumentCount: Cardinal;
 begin
  if (dsList <> nil) then
   Result := Cardinal(bsDocCount(dsList.List))
  else
   Result := 0;
 end;//lp_DocumentCount

//#UC END# *497F16AC015A_497DDB2B001B_var*
begin
//#UC START# *497F16AC015A_497DDB2B001B_impl*
 if (CurUserType <> nil) and
    (UserType in [lftSimilarDocuments]) then
  TnsViewSameDocumentsEvent.Log(lp_Document, lp_DocumentCount);
//#UC END# *497F16AC015A_497DDB2B001B_impl*
end;//TPrimListForm.DoTabActivate

procedure TPrimListForm.GotoActualRedaction;
//#UC START# *49805EED0054_497DDB2B001B_var*
//#UC END# *49805EED0054_497DDB2B001B_var*
begin
//#UC START# *49805EED0054_497DDB2B001B_impl*
 DefDataAdapter.TimeMachine.SwitchOff
//#UC END# *49805EED0054_497DDB2B001B_impl*
end;//TPrimListForm.GotoActualRedaction

procedure TPrimListForm.StayInCurrentRedaction;
//#UC START# *49805EFF013C_497DDB2B001B_var*
//#UC END# *49805EFF013C_497DDB2B001B_var*
begin
//#UC START# *49805EFF013C_497DDB2B001B_impl*
 Assert(False);
//#UC END# *49805EFF013C_497DDB2B001B_impl*
end;//TPrimListForm.StayInCurrentRedaction

procedure TPrimListForm.ChangeDate(aDate: RtlDateTime);
//#UC START# *49805F0D0221_497DDB2B001B_var*
//#UC END# *49805F0D0221_497DDB2B001B_var*
begin
//#UC START# *49805F0D0221_497DDB2B001B_impl*
 Assert(False);
//#UC END# *49805F0D0221_497DDB2B001B_impl*
end;//TPrimListForm.ChangeDate

function TPrimListForm.Get_DisableOps: TnsTurnOffTimeMachineOperations;
//#UC START# *49805F190314_497DDB2B001Bget_var*
//#UC END# *49805F190314_497DDB2B001Bget_var*
begin
//#UC START# *49805F190314_497DDB2B001Bget_impl*
 Result := [ns_offtmStayInCurrentRedaction, ns_offtmChangeDate];
  // - � ������ �������� ������ ���������� ������ �������.
//#UC END# *49805F190314_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_DisableOps

procedure TPrimListForm.File_SaveToFolder_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49885D540232_497DDB2B001Btest_var*
//#UC END# *49885D540232_497DDB2B001Btest_var*
begin
//#UC START# *49885D540232_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not IsListEmpty;
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  aParams.Op.Flag[vcm_ofEnabled] := True;
  with aParams.Op.SubItems do
  begin
   Clear;
   ResetSaveToFolderOperations;
   if (dsList <> nil) and dsList.IsSaved then
    g_OverrideList := Succ(Add(vcmCStr(str_ListSaveOverride)));
   if (dsList <> nil) and dsList.IsSaved or HasSelected then
    g_SaveToFolders := Succ(Add(vcmCStr(str_ListSaveAs)));
   if HasSelected then
    g_SaveToFoldersSelected := Succ(Add(vcmCStr(str_ListSaveSelectedDocuments)));
   // �������� �� ��������� ��������� � ��� ���������
   if Count = 0 then
    g_SaveToFolders := 0;
  end;//with aParams.Op.SubItems do
 end;//if aParams.Op.Flag[vcm_ofEnabled] then
//#UC END# *49885D540232_497DDB2B001Btest_impl*
end;//TPrimListForm.File_SaveToFolder_Test

procedure TPrimListForm.File_SaveToFolder_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49885D540232_497DDB2B001Bexec_var*
//#UC END# *49885D540232_497DDB2B001Bexec_var*
begin
//#UC START# *49885D540232_497DDB2B001Bexec_impl*
 // ��������� � ����� ���� ������ ���� ������ �� ������ ��� ������� ��
 // ShortCut-� ��� ��������� �������� ��������� � ����������� ���� ������
 SaveToFolders(IfThen(aParams.ItemIndex <= 0,
                      IfThen(tvList.TreeView.Tree.SelectedCount > 1,
                             g_SaveToFoldersSelected,
                             g_SaveToFolders),
                      aParams.ItemIndex));
//#UC END# *49885D540232_497DDB2B001Bexec_impl*
end;//TPrimListForm.File_SaveToFolder_Execute

procedure TPrimListForm.File_LoadFromFolder_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49885D59018D_497DDB2B001Btest_var*
//#UC END# *49885D59018D_497DDB2B001Btest_var*
begin
//#UC START# *49885D59018D_497DDB2B001Btest_impl*
 // - ������ �� ������
//#UC END# *49885D59018D_497DDB2B001Btest_impl*
end;//TPrimListForm.File_LoadFromFolder_Test

procedure TPrimListForm.File_LoadFromFolder_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49885D59018D_497DDB2B001Bexec_var*
//#UC END# *49885D59018D_497DDB2B001Bexec_var*
begin
//#UC START# *49885D59018D_497DDB2B001Bexec_impl*
 // ����� ��������
 TdmStdRes.SelectOpen(Self.As_IvcmEntityForm,
                      MakeFilterInfo(ffList),
                      str_ListOpen);
//#UC END# *49885D59018D_497DDB2B001Bexec_impl*
end;//TPrimListForm.File_LoadFromFolder_Execute

procedure TPrimListForm.Document_AddToControl_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *498863B203D0_497DDB2B001Btest_var*
//#UC END# *498863B203D0_497DDB2B001Btest_var*
begin
//#UC START# *498863B203D0_497DDB2B001Btest_impl*
 if HasCurrent and f_AllowCallCurrentChangedOnTest then
  CallCurrentChanged;
 aParams.Op.Flag[vcm_ofEnabled] := HasCurrent
                               and Assigned(dsDocumentList)
                               and not dsDocumentList.IsListEmpty
                               and dsDocumentList.CanAddToControl;
//#UC END# *498863B203D0_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_AddToControl_Test

procedure TPrimListForm.Document_AddToControl_GetState(var State: TvcmOperationStateIndex);
//#UC START# *498863B203D0_497DDB2B001Bgetstate_var*
//#UC END# *498863B203D0_497DDB2B001Bgetstate_var*
begin
//#UC START# *498863B203D0_497DDB2B001Bgetstate_impl*
 if HasCurrent and OnlyOneSelected and Assigned(dsDocumentList) and dsDocumentList.IsUnderControl then
  State := st_user_Document_AddToControl_RemoveFromControl
 else
  State := vcm_DefaultOperationState;
//#UC END# *498863B203D0_497DDB2B001Bgetstate_impl*
end;//TPrimListForm.Document_AddToControl_GetState

procedure TPrimListForm.Document_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *498863B203D0_497DDB2B001Bexec_var*
//#UC END# *498863B203D0_497DDB2B001Bexec_var*
begin
//#UC START# *498863B203D0_497DDB2B001Bexec_impl*
 AddSelectedToControl(True);
//#UC END# *498863B203D0_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_AddToControl_Execute

procedure TPrimListForm.Document_GetAttributesFrmAct_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *498891640253_497DDB2B001Btest_var*
//#UC END# *498891640253_497DDB2B001Btest_var*
begin
//#UC START# *498891640253_497DDB2B001Btest_impl*
 with tvList.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := afw.Application.IsInternal and
                                    NoMoreThanOneSelected and
                                    HasCurrent and
                                    Assigned(dsList) and
                                    dsList.HasAttributes;
//#UC END# *498891640253_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_GetAttributesFrmAct_Test

procedure TPrimListForm.Document_GetAttributesFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *498891640253_497DDB2B001Bexec_var*
//#UC END# *498891640253_497DDB2B001Bexec_var*
begin
//#UC START# *498891640253_497DDB2B001Bexec_impl*
 Op_SynchroView_BecomeActive.Call(Aggregate, ssfAttribute);
//#UC END# *498891640253_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_GetAttributesFrmAct_Execute

function TPrimListForm.Loadable_Load_Execute(const aNode: IeeNode;
  const aData: IUnknown;
  anOp: TListLogicOperation = LLO_NONE): Boolean;
//#UC START# *49895A2102E8_497DDB2B001Bexec_var*

var
 l_List   : IDynList;

 function lp_OpenList: Boolean;
 begin
  Result := (anOp = LLO_NONE);
  if Result then
  begin
    Assert(Assigned(l_List));
    nsOpenList(l_List, NativeMainForm);
  end//Result
 end;

 procedure lp_ApplyLogicOperation;
 begin
  if Assigned(dsList) then
   try
    // �������� ��� ������:
    if dsList.List.GetContentType <> l_List.GetContentType then
    begin
     Say(inf_UncompatibleObjectType);
     Loadable_Load_Execute := false;
     Exit;
    end;//if dsList.List.GetContentType <> l_List.GetContentType then
    // �������� ���������� ��������
    if dsList.ApplyLogicOperation(l_List, anOp) then
    begin
     if dsList.AllDocumentFiltered then
      ShowEditorOrList(nil)
     // ������� ������:
     else
      with tvList do
      begin
       Changing;
       try
        TreeStruct := dsList.SimpleTree;
       finally
        Changed;
       end;//try..finally
      end;//with tvList do
    end;//dsList.ApplyLogicOperation
   except
    on EEmptyResult do
    begin
     Say(war_EmptyList);
     Loadable_Load_Execute := false;
    end;//on EEmptyResult do
   end//except
  else
   Assert(false, '���������, ��� ������ �� ���� ��������');
 end;

var
 l_FolderNode : INode;
 l_Object : IUnknown;
//#UC END# *49895A2102E8_497DDB2B001Bexec_var*
begin
//#UC START# *49895A2102E8_497DDB2B001Bexec_impl*
 Result := true;
 if Supports(aNode, INode, l_FolderNode) then
 try
  try
   l_FolderNode.Open(l_Object);
   try
    Supports(l_Object, IDynList, l_List);
    try
     if not lp_OpenList then
      lp_ApplyLogicOperation;
    finally
     l_List := nil;
    end;//try..finally
   finally
    l_Object := nil;
   end;//try..finally
  except
   on ECanNotFindData do
   begin
    nsSayAdapterObjectMissing(Self, l_FolderNode);
    Result := false;
   end;//on ECanNotFindData do
  end;//try..except
 finally
  l_FolderNode := nil;
 end;//try..finally
//#UC END# *49895A2102E8_497DDB2B001Bexec_impl*
end;//TPrimListForm.Loadable_Load_Execute

procedure TPrimListForm.Loadable_Load(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ILoadable_Load_Params) do
  ResultValue := Loadable_Load_Execute(Node, Data, nOp);
end;

procedure TPrimListForm.Document_GetRelatedDocFrmAct_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *498993C801DC_497DDB2B001Btest_var*
//#UC END# *498993C801DC_497DDB2B001Btest_var*
begin
//#UC START# *498993C801DC_497DDB2B001Btest_impl*
 with tvList.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent and
   Assigned(dsDocumentList) and dsDocumentList.HasRelatedDoc;
//#UC END# *498993C801DC_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_GetRelatedDocFrmAct_Test

procedure TPrimListForm.Document_GetRelatedDocFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *498993C801DC_497DDB2B001Bexec_var*
//#UC END# *498993C801DC_497DDB2B001Bexec_var*
begin
//#UC START# *498993C801DC_497DDB2B001Bexec_impl*
 Op_SynchroView_BecomeActive.Call(Aggregate, ssfRelated);
//#UC END# *498993C801DC_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_GetRelatedDocFrmAct_Execute

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_Undo_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EDFCA2006D_497DDB2B001Btest_var*
//#UC END# *49EDFCA2006D_497DDB2B001Btest_var*
begin
//#UC START# *49EDFCA2006D_497DDB2B001Btest_impl*
 if aParams.Control = tvList then
  aParams.Op.Flag[vcm_ofEnabled] := false
 else
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := false;
//#UC END# *49EDFCA2006D_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_Undo_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_Undo_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EDFCA2006D_497DDB2B001Bexec_var*
//#UC END# *49EDFCA2006D_497DDB2B001Bexec_var*
begin
//#UC START# *49EDFCA2006D_497DDB2B001Bexec_impl*
 aParams.CallControl;
//#UC END# *49EDFCA2006D_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_Undo_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_Redo_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EDFCB100BC_497DDB2B001Btest_var*
//#UC END# *49EDFCB100BC_497DDB2B001Btest_var*
begin
//#UC START# *49EDFCB100BC_497DDB2B001Btest_impl*
 if aParams.Control = tvList then
  aParams.Op.Flag[vcm_ofEnabled] := false
 else
 if not aParams.CallControl then
  aParams.Op.Flag[vcm_ofEnabled] := false;
//#UC END# *49EDFCB100BC_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_Redo_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_Redo_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EDFCB100BC_497DDB2B001Bexec_var*
//#UC END# *49EDFCB100BC_497DDB2B001Bexec_var*
begin
//#UC START# *49EDFCB100BC_497DDB2B001Bexec_impl*
 aParams.CallControl;
//#UC END# *49EDFCB100BC_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_Redo_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_Deselect_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *49EE01BC022E_497DDB2B001Btest_var*
//#UC END# *49EE01BC022E_497DDB2B001Btest_var*
begin
//#UC START# *49EE01BC022E_497DDB2B001Btest_impl*
 if aParams.Control = tvList then
  aParams.Op.Flag[vcm_ofEnabled] := tvList.TreeView.Tree.SelectedCount > 1
 else
  if not aParams.CallControl then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *49EE01BC022E_497DDB2B001Btest_impl*
end;//TPrimListForm.Edit_Deselect_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListForm.Edit_Deselect_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49EE01BC022E_497DDB2B001Bexec_var*
//#UC END# *49EE01BC022E_497DDB2B001Bexec_var*
begin
//#UC START# *49EE01BC022E_497DDB2B001Bexec_impl*
 if (aParams.Control = tvList) then
 begin
  with tvList, tvList.TreeView do
  begin
   TreeStruct.Changing;
   try
    vlbDeselectAllItems;
    Tree.SetFlagMask(CurrentNode, nfSelected, ee_sbSelect);
   finally
    TreeStruct.Changed{Ex(l3_NotChangeCountView)};
   end;//try..finally
  end;//with tvList, tvList.TreeView
  StatusParamsShow;
 end//aParams.Control = tvList
 else
  aParams.CallControl;
//#UC END# *49EE01BC022E_497DDB2B001Bexec_impl*
end;//TPrimListForm.Edit_Deselect_Execute
{$IfEnd} //not NoVCM

function TPrimListForm.FindBack(const aContext: InsBaseSearchContextProvider;
  const aProcessor: InsBaseSearchResultProcessor): Boolean;
//#UC START# *49FEA325027E_497DDB2B001B_var*
//#UC END# *49FEA325027E_497DDB2B001B_var*
begin
//#UC START# *49FEA325027E_497DDB2B001B_impl*
 Result := False;
//#UC END# *49FEA325027E_497DDB2B001B_impl*
end;//TPrimListForm.FindBack

function TPrimListForm.FindBackSupported: Boolean;
//#UC START# *49FEB37C02FB_497DDB2B001B_var*
//#UC END# *49FEB37C02FB_497DDB2B001B_var*
begin
//#UC START# *49FEB37C02FB_497DDB2B001B_impl*
 Result := False;
//#UC END# *49FEB37C02FB_497DDB2B001B_impl*
end;//TPrimListForm.FindBackSupported

function TPrimListForm.FindBackEnabled: Boolean;
//#UC START# *49FEB3960023_497DDB2B001B_var*
//#UC END# *49FEB3960023_497DDB2B001B_var*
begin
//#UC START# *49FEB3960023_497DDB2B001B_impl*
 Result := False;
//#UC END# *49FEB3960023_497DDB2B001B_impl*
end;//TPrimListForm.FindBackEnabled

function TPrimListForm.FragmentsCountSuffix: Il3CString;
//#UC START# *49FFD8230333_497DDB2B001B_var*
//#UC END# *49FFD8230333_497DDB2B001B_var*
begin
//#UC START# *49FFD8230333_497DDB2B001B_impl*
 Result := nil;
//#UC END# *49FFD8230333_497DDB2B001B_impl*
end;//TPrimListForm.FragmentsCountSuffix

procedure TPrimListForm.FillList(const aList: InscStatusBarItemDefsList);
//#UC START# *4A8E5E4702C6_497DDB2B001B_var*
//#UC END# *4A8E5E4702C6_497DDB2B001B_var*
begin
//#UC START# *4A8E5E4702C6_497DDB2B001B_impl*
 with aList do
 begin
  (*
  Add(TnscStatusBarOperationDef.MakeS(TdmStdRes.opcode_Selection_Analize, True));
  *)
  // http://mdp.garant.ru/pages/viewpage.action?pageId=274825697&focusedCommentId=276540205#comment-276540205
 end;//with aList
//#UC END# *4A8E5E4702C6_497DDB2B001B_impl*
end;//TPrimListForm.FillList

function TPrimListForm.AllowPrompts: Boolean;
//#UC START# *4AA4E63900F9_497DDB2B001B_var*
//#UC END# *4AA4E63900F9_497DDB2B001B_var*
begin
//#UC START# *4AA4E63900F9_497DDB2B001B_impl*
 Result := f_SearchArea = ns_saEveryWere;
//#UC END# *4AA4E63900F9_497DDB2B001B_impl*
end;//TPrimListForm.AllowPrompts

function TPrimListForm.PromptsInfo: LongWord;
//#UC START# *4AA4E64E0395_497DDB2B001B_var*
//#UC END# *4AA4E64E0395_497DDB2B001B_var*
begin
//#UC START# *4AA4E64E0395_497DDB2B001B_impl*
 Result := 0;
//#UC END# *4AA4E64E0395_497DDB2B001B_impl*
end;//TPrimListForm.PromptsInfo

function TPrimListForm.SupportDisabled: Boolean;
//#UC START# *4ACA17770179_497DDB2B001B_var*
//#UC END# *4ACA17770179_497DDB2B001B_var*
begin
//#UC START# *4ACA17770179_497DDB2B001B_impl*
 Result := UserType in [lftDrugList,
                        lftDrugInternationalNameSynonyms,
                        lftProducedDrugs,
                        lftProducedDrugsSynchroForm];
//#UC END# *4ACA17770179_497DDB2B001B_impl*
end;//TPrimListForm.SupportDisabled

function TPrimListForm.Get_ContainerForBaseSearch: TnsContainerForBaseSearchInfo;
//#UC START# *4ACA195801CB_497DDB2B001Bget_var*
//#UC END# *4ACA195801CB_497DDB2B001Bget_var*
begin
//#UC START# *4ACA195801CB_497DDB2B001Bget_impl*
 Result.rContainer := nil;
 Result.rZone := vcm_ztAny;
//#UC END# *4ACA195801CB_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_ContainerForBaseSearch

function TPrimListForm.Get_VisibleWatcher: InsBaseSearchVisibleWatcher;
//#UC START# *4AD608860210_497DDB2B001Bget_var*
//#UC END# *4AD608860210_497DDB2B001Bget_var*
begin
//#UC START# *4AD608860210_497DDB2B001Bget_impl*
 Result := Self;
//#UC END# *4AD608860210_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_VisibleWatcher

function TPrimListForm.Get_ContextSearcher: InsContextSearcher;
//#UC START# *4AD6EAA3034A_497DDB2B001Bget_var*
//#UC END# *4AD6EAA3034A_497DDB2B001Bget_var*
begin
//#UC START# *4AD6EAA3034A_497DDB2B001Bget_impl*
 Result := Self;
//#UC END# *4AD6EAA3034A_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_ContextSearcher

procedure TPrimListForm.LftUserCRList2SynchorFormQueryOpen(aSender: TObject);
//#UC START# *4AE19D392515_497DDB2B001B_var*
//#UC END# *4AE19D392515_497DDB2B001B_var*
begin
//#UC START# *4AE19D392515_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *4AE19D392515_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCRList2SynchorFormQueryOpen

function TPrimListForm.Filterable_Add_Execute(const aFilter: IFilterFromQuery): Boolean;
//#UC START# *4AEF0BF70306_497DDB2B001Bexec_var*
//#UC END# *4AEF0BF70306_497DDB2B001Bexec_var*
begin
//#UC START# *4AEF0BF70306_497DDB2B001Bexec_impl*
 Result := ApplyFilter(aFilter, true)
//#UC END# *4AEF0BF70306_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_Add_Execute

procedure TPrimListForm.Filterable_Add(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilterable_Add_Params) do
  ResultValue := Filterable_Add_Execute(Filter);
end;

function TPrimListForm.Filterable_Delete_Execute(const aFilter: IFilterFromQuery): Boolean;
//#UC START# *4AEF0D1A01C3_497DDB2B001Bexec_var*
//#UC END# *4AEF0D1A01C3_497DDB2B001Bexec_var*
begin
//#UC START# *4AEF0D1A01C3_497DDB2B001Bexec_impl*
 Result := (dsList <> nil) AND ApplyFilter(aFilter, false)
//#UC END# *4AEF0D1A01C3_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_Delete_Execute

procedure TPrimListForm.Filterable_Delete(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilterable_Delete_Params) do
  ResultValue := Filterable_Delete_Execute(Filter);
end;

function TPrimListForm.List_GetDeList_Execute: IdeList;
//#UC START# *4AEF28330397_497DDB2B001Bexec_var*
//#UC END# *4AEF28330397_497DDB2B001Bexec_var*
begin
//#UC START# *4AEF28330397_497DDB2B001Bexec_impl*
 if not Assigned(dsList) then
  Result := nil
 else
 if not IsListEmpty then
  Result := TdeList.Make(dsList.List)
 else
  Result := nil;
//#UC END# *4AEF28330397_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_GetDeList_Execute

procedure TPrimListForm.List_GetDeList(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IList_GetDeList_Params) do
  ResultValue := List_GetDeList_Execute;
end;

procedure TPrimListForm.Filterable_ClearAll_Execute;
//#UC START# *4AF80DB80383_497DDB2B001Bexec_var*
var
 l_AllDocumentFiltered: Boolean;
//#UC END# *4AF80DB80383_497DDB2B001Bexec_var*
begin
//#UC START# *4AF80DB80383_497DDB2B001Bexec_impl*
 if dsList <> nil then
 begin
  l_AllDocumentFiltered := dsList.AllDocumentFiltered;
  if dsList.ClearFilters then
  begin
   // ���� ��� ��������� ���� ��������������, �� ����� �������� ������:
   if l_AllDocumentFiltered then
    ShowEditorOrList(nil);
   tvList.TreeStruct := nil;
  end;//if dsList.ClearFilters then
 end;//if dsList <> nil then
//#UC END# *4AF80DB80383_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_ClearAll_Execute

procedure TPrimListForm.Filterable_ClearAll(const aParams: IvcmExecuteParams);
begin
 Filterable_ClearAll_Execute;
end;

function TPrimListForm.Filterable_Refresh_Execute: Boolean;
//#UC START# *4AF810230307_497DDB2B001Bexec_var*
//#UC END# *4AF810230307_497DDB2B001Bexec_var*
begin
//#UC START# *4AF810230307_497DDB2B001Bexec_impl*
 Result := true;
 if Assigned(dsList) and dsList.RefreshFilters then
  tvList.TreeStruct := nil
 else
  Result := false;
//#UC END# *4AF810230307_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_Refresh_Execute

procedure TPrimListForm.Filterable_Refresh(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilterable_Refresh_Params) do
  ResultValue := Filterable_Refresh_Execute;
end;

procedure TPrimListForm.TimeMachine_TimeMachineOffAndReset_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4AF83BEB0393_497DDB2B001Btest_var*
//#UC END# *4AF83BEB0393_497DDB2B001Btest_var*
begin
//#UC START# *4AF83BEB0393_497DDB2B001Btest_impl*
 with aParams do
 begin
  Op.Flag[vcm_ofEnabled] := Assigned(dsDocumentList) and dsDocumentList.IsTimeMachineEnable and
   defDataAdapter.TimeMachine.IsOn;
  if Op.Flag[vcm_ofEnabled] then
   Op.Flag[vcm_ofChecked] := defDataAdapter.TimeMachine.IsOn;
 end;//with aParams do
//#UC END# *4AF83BEB0393_497DDB2B001Btest_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOffAndReset_Test

procedure TPrimListForm.TimeMachine_TimeMachineOffAndReset_Execute;
//#UC START# *4AF83BEB0393_497DDB2B001Bexec_var*
//#UC END# *4AF83BEB0393_497DDB2B001Bexec_var*
begin
//#UC START# *4AF83BEB0393_497DDB2B001Bexec_impl*
 defDataAdapter.TimeMachine.SwitchOff;
//#UC END# *4AF83BEB0393_497DDB2B001Bexec_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOffAndReset_Execute

procedure TPrimListForm.TimeMachine_TimeMachineOffAndReset(const aParams: IvcmExecuteParams);
begin
 TimeMachine_TimeMachineOffAndReset_Execute;
end;

procedure TPrimListForm.List_SetCurrentVisible_Execute;
//#UC START# *4AF84789038B_497DDB2B001Bexec_var*
//#UC END# *4AF84789038B_497DDB2B001Bexec_var*
begin
//#UC START# *4AF84789038B_497DDB2B001Bexec_impl*
 if HasCurrent then
  with tvList, TreeView do
   vlbMakeItemVisible(Current);
//#UC END# *4AF84789038B_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SetCurrentVisible_Execute

procedure TPrimListForm.List_SetCurrentVisible(const aParams: IvcmExecuteParams);
begin
 List_SetCurrentVisible_Execute;
end;

procedure TPrimListForm.TimeMachine_TimeMachineOnOffNew_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4B261EC80086_497DDB2B001Btest_var*
//#UC END# *4B261EC80086_497DDB2B001Btest_var*
begin
//#UC START# *4B261EC80086_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(dsList) and
  dsList.IsTimeMachineEnable and DefDataAdapter.TimeMachine.IsOn;
//#UC END# *4B261EC80086_497DDB2B001Btest_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOnOffNew_Test

procedure TPrimListForm.TimeMachine_TimeMachineOnOffNew_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4B261EC80086_497DDB2B001Bgetstate_var*
//#UC END# *4B261EC80086_497DDB2B001Bgetstate_var*
begin
//#UC START# *4B261EC80086_497DDB2B001Bgetstate_impl*
 if not defDataAdapter.TimeMachine.IsOn then
  State := st_user_TimeMachine_TimeMachineOnOffNew_MachineOn
 else
  State := st_user_TimeMachine_TimeMachineOnOffNew_MachineOff;
//#UC END# *4B261EC80086_497DDB2B001Bgetstate_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOnOffNew_GetState

procedure TPrimListForm.TimeMachine_TimeMachineOnOffNew_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4B261EC80086_497DDB2B001Bexec_var*
//#UC END# *4B261EC80086_497DDB2B001Bexec_var*
begin
//#UC START# *4B261EC80086_497DDB2B001Bexec_impl*
 TdmStdRes.OpenTurnOffTimeMachine(InsTurnOffTimeMachine(Self));
//#UC END# *4B261EC80086_497DDB2B001Bexec_impl*
end;//TPrimListForm.TimeMachine_TimeMachineOnOffNew_Execute

function TPrimListForm.SwitchToTextIfPossible: Boolean;
//#UC START# *4B263ADE02E0_497DDB2B001B_var*
//#UC END# *4B263ADE02E0_497DDB2B001B_var*
begin
//#UC START# *4B263ADE02E0_497DDB2B001B_impl*
 Result := False;
//#UC END# *4B263ADE02E0_497DDB2B001B_impl*
end;//TPrimListForm.SwitchToTextIfPossible

procedure TPrimListForm.List_SwitchToFullList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4B556F56016B_497DDB2B001Btest_var*
//#UC END# *4B556F56016B_497DDB2B001Btest_var*
begin
//#UC START# *4B556F56016B_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := CanSwithToFullList;
 aParams.Op.Flag[vcm_ofVisible] := CanSwithToFullList;
//#UC END# *4B556F56016B_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SwitchToFullList_Test

procedure TPrimListForm.List_SwitchToFullList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4B556F56016B_497DDB2B001Bexec_var*
//#UC END# *4B556F56016B_497DDB2B001Bexec_var*
begin
//#UC START# *4B556F56016B_497DDB2B001Bexec_impl*
 DoSwitchToFullList;
//#UC END# *4B556F56016B_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SwitchToFullList_Execute

procedure TPrimListForm.List_ListInfo_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716AC02AC_497DDB2B001Btest_var*
//#UC END# *4C3716AC02AC_497DDB2B001Btest_var*
begin
//#UC START# *4C3716AC02AC_497DDB2B001Btest_impl*
// aParams.Op.Flag[vcm_ofVisible] := (aParams.Control <> tvList);
 aParams.Op.Flag[vcm_ofEnabled] := (dsList <> nil) and
  not IsListEmpty and (dsList.IsMain);
//#UC END# *4C3716AC02AC_497DDB2B001Btest_impl*
end;//TPrimListForm.List_ListInfo_Test

procedure TPrimListForm.List_ListInfo_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716AC02AC_497DDB2B001Bexec_var*
//#UC END# *4C3716AC02AC_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716AC02AC_497DDB2B001Bexec_impl*
 op_ListInfo_BecomeActive.Call(Aggregate);
//#UC END# *4C3716AC02AC_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_ListInfo_Execute

procedure TPrimListForm.List_Sort_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716C50005_497DDB2B001Btest_var*
var
 l_Strings: IvcmStrings;
 l_StringSource: InsStringsSource;
 l_Res: Boolean;
//#UC END# *4C3716C50005_497DDB2B001Btest_var*
begin
//#UC START# *4C3716C50005_497DDB2B001Btest_impl*
// aParams.Op.Flag[vcm_ofVisible] := (aParams.Control <> tvList);
 // http://mdp.garant.ru/pages/viewpage.action?pageId=476813620
 if (tvList.TreeView.Current < 0) or ((dsDocumentList = nil) or
  (dsDocumentList.IsListEmpty)) or
   ((aParams.Control = nil) {or (aParams.Control = tvList)}) then
   aParams.Op.Flag[vcm_ofEnabled] := False
 else
 begin
  if Assigned(dsDocumentList) then
  begin
   aParams.Op.Flag[vcm_ofEnabled] := True;
   l_Res := CheckValidSortTypes(dsDocumentList.ValidSortTypes);
   l_Strings := aParams.Op.SubItems;
   try
    if (l_Strings <> nil) and
       (l_Res or (l_Strings.Count = 0) or (l_Strings.Count <> f_SortTypeMap.MapSize)) and
       Supports(f_SortTypeMap, InsStringsSource, l_StringSource) then
    try
     l_StringSource.FillStrings(l_Strings);
    finally
     l_StringSource := nil;
    end;//try..finally
   finally
    l_Strings := nil;
   end;//try..finally
   aParams.Op.SelectedString := f_SortTypeMap.ValueToDisplayName(Ord(dsDocumentList.SortType));
  end;//if Assigned(dsDocumentList) then
 end;//if tvList.TreeView.Current < 0 then
//#UC END# *4C3716C50005_497DDB2B001Btest_impl*
end;//TPrimListForm.List_Sort_Test

procedure TPrimListForm.List_Sort_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716C50005_497DDB2B001Bexec_var*
var
 l_SortType : TbsSortType;
 l_NewTree  : Il3SimpleTree;
//#UC END# *4C3716C50005_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716C50005_497DDB2B001Bexec_impl*
 if Assigned(dsDocumentList) then
  with dsDocumentList do
  begin
   CheckValidSortTypes(dsDocumentList.ValidSortTypes);
   l_SortType := TbsSortType(f_SortTypeMap.DisplayNameToValue(aParams.SelectedString));
   if (l_SortType <> SortType) then
    with tvList do
    begin
     l_NewTree := ChangeSortType(TreeStruct,
                                 GetCurrentNode,
                                 l_SortType);
     if Assigned(l_NewTree) then
      ReplaceTreeStructForceAsSame(l_NewTree);
     // ������� ������� �������
     tvList.MakeItemVisible(Current);
    end;//with tvList do
  end;//with dsDocumentList do
//#UC END# *4C3716C50005_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_Sort_Execute

procedure TPrimListForm.List_SortDirection_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716D1012E_497DDB2B001Btest_var*
//#UC END# *4C3716D1012E_497DDB2B001Btest_var*
begin
//#UC START# *4C3716D1012E_497DDB2B001Btest_impl*
 //http://mdp.garant.ru/pages/viewpage.action?pageId=476813620
 aParams.Op.Flag[vcm_ofEnabled] := (HasCurrent and Assigned(dsDocumentList)) and
  (not dsDocumentList.IsListEmpty) and (aParams.Control <> nil) {and (aParams.Control <> tvList)};
//#UC END# *4C3716D1012E_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SortDirection_Test

procedure TPrimListForm.List_SortDirection_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C3716D1012E_497DDB2B001Bgetstate_var*
//#UC END# *4C3716D1012E_497DDB2B001Bgetstate_var*
begin
//#UC START# *4C3716D1012E_497DDB2B001Bgetstate_impl*
 if HasCurrent and Assigned(dsDocumentList) then
  if dsDocumentList.SortOrder = SO_ASCENDING then
   State := st_user_List_SortDirection_Ascending
  else
   State := st_user_List_SortDirection_Descending
 else
  State := vcm_DefaultOperationState;
//#UC END# *4C3716D1012E_497DDB2B001Bgetstate_impl*
end;//TPrimListForm.List_SortDirection_GetState

procedure TPrimListForm.List_SortDirection_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716D1012E_497DDB2B001Bexec_var*
var
 l_newTree : Il3SimpleTree;
//#UC END# *4C3716D1012E_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716D1012E_497DDB2B001Bexec_impl*
 if Assigned(dsDocumentList) then
  with tvList do
  begin
   l_newTree := dsDocumentList.ChangeSortOrder(TreeStruct, GetCurrentNode);
   if Assigned(l_NewTree) then
   begin
    Changing;
    try
     TreeStruct := l_NewTree;
    finally
     Changed;
    end;//try..finally
   end; //if Assigned(l_NewTree) then
  end; //with tvList do
//#UC END# *4C3716D1012E_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SortDirection_Execute

procedure TPrimListForm.List_SpecifyList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716E20109_497DDB2B001Btest_var*
//#UC END# *4C3716E20109_497DDB2B001Btest_var*
begin
//#UC START# *4C3716E20109_497DDB2B001Btest_impl*
 ListOpsTest(aParams);
 if (aParams.Control = nil) {OR (tvList = aParams.Control)} then
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C3716E20109_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SpecifyList_Test

procedure TPrimListForm.List_SpecifyList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716E20109_497DDB2B001Bexec_var*
//#UC END# *4C3716E20109_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716E20109_497DDB2B001Bexec_impl*
 if (dsList.ListType = bs_ltDocument) then
  TdmStdRes.OpenBaseSearch(ns_bsokSpecify, nil)
 else
  TdmStdRes.InpharmSearch(nil, dsList.List, nil);
//#UC END# *4C3716E20109_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SpecifyList_Execute

procedure TPrimListForm.List_ExportToXML_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3716EF02DF_497DDB2B001Btest_var*
//#UC END# *4C3716EF02DF_497DDB2B001Btest_var*
begin
//#UC START# *4C3716EF02DF_497DDB2B001Btest_impl*
 with aParams.Op.SubItems do
  if Count = 0 then
  begin
   Add(vcmCStr(str_WholeListCaption));
   Add(vcmCStr(str_SelectedDocumentsCaption));
  end;//if Count = 0 then
 aParams.Op.Flag[vcm_ofEnabled] := (not IsListEmpty and defDataAdapter.
  ListXMLExportEnabled);
//#UC END# *4C3716EF02DF_497DDB2B001Btest_impl*
end;//TPrimListForm.List_ExportToXML_Test

procedure TPrimListForm.List_ExportToXML_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3716EF02DF_497DDB2B001Bexec_var*
var
 l_SaveDialog : TvtSaveDialog;
//#UC END# *4C3716EF02DF_497DDB2B001Bexec_var*
begin
//#UC START# *4C3716EF02DF_497DDB2B001Bexec_impl*
 if Assigned(dsList) then
 begin
  l_SaveDialog := TvtSaveDialog.Create(Self);
  try
   with l_SaveDialog do
   begin
    Options := Options + [ofOverwritePrompt, ofPathMustExist];
    Filter := vcmConstString(str_XMLFileFilter);
    DefaultExt := vcmConstString(str_XMLFileExtension);
    FileName := ChangeFileExt(l3PStr(nsMyDocumentFolder(dsList.ListName, '.' + DefaultExt)), '');
    if Execute then
    try
     dsList.SaveToFile(l3PCharLen(FileName), (aParams.ItemIndex = 2));
    except
     on ECannotSave do
      Say(err_ListSaveToFileError);
    end;{try..except}
   end;//with l_SaveDialog do
  finally
   FreeAndNil(l_SaveDialog);
  end;{try..finally}
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C3716EF02DF_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_ExportToXML_Execute

procedure TPrimListForm.Filters_FiltersList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3740FA02D7_497DDB2B001Btest_var*

 procedure lp_MakeTree;
 var
  l_List : IvcmNodes;
  l_Node : Il3SimpleNode;
 begin
  l_List := aParams.Op.SubNodes;
  if (l_List <> nil) then
  begin
   l_List.ShowRoot := false;
   //if (l_List.Count = 0) then
   l_List.Clear;
   begin
    l_Node := TnsFiltersContainer.Instance.Filters[dsList.ListType].Tree.RootNode;
    if (l_Node <> nil) then
     l_List.Add(l_Node);
   end;//if (l_List <> nil) then
  end;//if (l_List <> nil) and
 end;//lp_MakeTree

//#UC END# *4C3740FA02D7_497DDB2B001Btest_var*
begin
//#UC START# *4C3740FA02D7_497DDB2B001Btest_impl*
 with aParams do
 begin
  Op.Flag[vcm_ofEnabled] := Assigned(dsList) and (dsList.IsMain);
  if Op.Flag[vcm_ofEnabled] then
   lp_MakeTree;
 end;//with aParams do
//#UC END# *4C3740FA02D7_497DDB2B001Btest_impl*
end;//TPrimListForm.Filters_FiltersList_Test

procedure TPrimListForm.Filters_FiltersList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3740FA02D7_497DDB2B001Bexec_var*
var
 l_Node: Il3Node;
 l_Filter: IFilterFromQuery;
//#UC END# *4C3740FA02D7_497DDB2B001Bexec_var*
begin
//#UC START# *4C3740FA02D7_497DDB2B001Bexec_impl*
 if Supports(aParams.CurrentNode, Il3Node, l_Node) then
  try
   if not op_Filter_ActivateNode.Call(Aggregate, l_Node) then
   begin
    if Supports(l_Node, IFilterFromQuery, l_Filter) then
    try
     ApplyFilter(l_Filter, not IsFilterActive(l_Filter));
    finally
     l_Filter := nil;
    end;//try..finally
   end;//not op_Filter_ActivateNode.Call(Aggregate, l_Node As IeeNode)
  finally
   l_Node := nil;
  end;//try..finally
//#UC END# *4C3740FA02D7_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filters_FiltersList_Execute

procedure TPrimListForm.LocalList_PublishSourceSearchInList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3A96BD0239_497DDB2B001Btest_var*
//#UC END# *4C3A96BD0239_497DDB2B001Btest_var*
begin
//#UC START# *4C3A96BD0239_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IsExists_PublishSourceTag and
  Assigned(dsDocumentList) and not dsDocumentList.IsListEmpty and HasCurrent;
//#UC END# *4C3A96BD0239_497DDB2B001Btest_impl*
end;//TPrimListForm.LocalList_PublishSourceSearchInList_Test

procedure TPrimListForm.LocalList_PublishSourceSearchInList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3A96BD0239_497DDB2B001Bexec_var*
//#UC END# *4C3A96BD0239_497DDB2B001Bexec_var*
begin
//#UC START# *4C3A96BD0239_497DDB2B001Bexec_impl*
 TdmStdRes.PublishSourceSearch(nil, dsList.List);
//#UC END# *4C3A96BD0239_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_PublishSourceSearchInList_Execute

procedure TPrimListForm.LocalList_Open_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3A971300DA_497DDB2B001Btest_var*
//#UC END# *4C3A971300DA_497DDB2B001Btest_var*
begin
//#UC START# *4C3A971300DA_497DDB2B001Btest_impl*
 if IsListEmpty then
  aParams.Op.Flag[vcm_ofEnabled] := False
 else
  aParams.Op.Flag[vcm_ofEnabled] := True;
//#UC END# *4C3A971300DA_497DDB2B001Btest_impl*
end;//TPrimListForm.LocalList_Open_Test

procedure TPrimListForm.LocalList_Open_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3A971300DA_497DDB2B001Bexec_var*
//#UC END# *4C3A971300DA_497DDB2B001Bexec_var*
begin
//#UC START# *4C3A971300DA_497DDB2B001Bexec_impl*
 OpenCurrentList(NativeMainForm);
//#UC END# *4C3A971300DA_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_Open_Execute

procedure TPrimListForm.LocalList_SearchDrugInList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3A97210318_497DDB2B001Btest_var*
//#UC END# *4C3A97210318_497DDB2B001Btest_var*
begin
//#UC START# *4C3A97210318_497DDB2B001Btest_impl*
 // - ������ �� ������
//#UC END# *4C3A97210318_497DDB2B001Btest_impl*
end;//TPrimListForm.LocalList_SearchDrugInList_Test

procedure TPrimListForm.LocalList_SearchDrugInList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3A97210318_497DDB2B001Bexec_var*
//#UC END# *4C3A97210318_497DDB2B001Bexec_var*
begin
//#UC START# *4C3A97210318_497DDB2B001Bexec_impl*
 TdmStdRes.InpharmSearch(nil, dsList.List, nil);
//#UC END# *4C3A97210318_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_SearchDrugInList_Execute

procedure TPrimListForm.Document_GetAnnotationDocFrmAct_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3AA77E00A3_497DDB2B001Btest_var*
//#UC END# *4C3AA77E00A3_497DDB2B001Btest_var*
begin
//#UC START# *4C3AA77E00A3_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent and
  (dsDocumentList <> nil) and (dsDocumentList.HasAnnotation);
//#UC END# *4C3AA77E00A3_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_GetAnnotationDocFrmAct_Test

procedure TPrimListForm.Document_GetAnnotationDocFrmAct_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3AA77E00A3_497DDB2B001Bexec_var*
//#UC END# *4C3AA77E00A3_497DDB2B001Bexec_var*
begin
//#UC START# *4C3AA77E00A3_497DDB2B001Bexec_impl*
 Op_SynchroView_BecomeActive.Call(Aggregate, ssfAnnotation);
//#UC END# *4C3AA77E00A3_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_GetAnnotationDocFrmAct_Execute

procedure TPrimListForm.Document_SimilarDocuments_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3AA78E024D_497DDB2B001Btest_var*
//#UC END# *4C3AA78E024D_497DDB2B001Btest_var*
begin
//#UC START# *4C3AA78E024D_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := NoMoreThanOneSelected and HasCurrent and
  (dsDocumentList <> nil) and (dsDocumentList.HasSimilarDocuments);
//#UC END# *4C3AA78E024D_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_SimilarDocuments_Test

procedure TPrimListForm.Document_SimilarDocuments_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3AA78E024D_497DDB2B001Bexec_var*
//#UC END# *4C3AA78E024D_497DDB2B001Bexec_var*
begin
//#UC START# *4C3AA78E024D_497DDB2B001Bexec_impl*
 op_SynchroView_BecomeActive.Call(Aggregate, ssfSimilarDocuments);
//#UC END# *4C3AA78E024D_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_SimilarDocuments_Execute

procedure TPrimListForm.CRList_SetType_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3AA94D0041_497DDB2B001Btest_var*
var
 l_List : IvcmNodes;
//#UC END# *4C3AA94D0041_497DDB2B001Btest_var*
begin
//#UC START# *4C3AA94D0041_497DDB2B001Btest_impl*
 if Assigned(dsDocumentList) then
 begin
  with aParams do
  begin
   l_List := Op.SubNodes;
   if (l_List <> nil) then
   begin
    with l_List do
    begin
     ShowRoot := false;
     if f_NeedDropCRList or ((l_List.count = 0) and Assigned(dsDocumentList.CRTypeNode)) then
     begin
      Clear;
      f_NeedDropCRList := false;
      if Assigned(dsDocumentList.CRTypeRoot) then
        Add(dsDocumentList.CRTypeRoot);
     end;//if f_NeedDropCRList then
     if Assigned(dsDocumentList.CRTypeNode) then
     begin
      Current := dsDocumentList.CRTypeNode;
      Op.SelectedString := nsCStr(dsDocumentList.CRTypeNode.Text);
     end
     else
      Op.Flag[vcm_ofEnabled] := False;
    end;//with l_List do
   end;//l_List <> nil
  end;//with aParams
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C3AA94D0041_497DDB2B001Btest_impl*
end;//TPrimListForm.CRList_SetType_Test

procedure TPrimListForm.CRList_SetType_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3AA94D0041_497DDB2B001Bexec_var*
var
 l_Node   : Il3Node;
 l_Locker : InsWarningLocker;
//#UC END# *4C3AA94D0041_497DDB2B001Bexec_var*
begin
//#UC START# *4C3AA94D0041_497DDB2B001Bexec_impl*
 if Supports(aParams.CurrentNode, Il3Node, l_Node) and Assigned(dsDocumentList) then
 begin
  if Dispatcher.InOp and not Dispatcher.InOp(true) then
   l_Locker := WarningLocker
  else
   l_Locker := nil;
  if Assigned(l_Locker) then
   l_Locker.LockWarning;
  try
   dsDocumentList.ChangeCRType(l_Node);
  finally
   if Assigned(l_Locker) then
    l_Locker.UnLockWarning;
  end;//try..finally
 end;//Supports(aParams.CurrentNode, Il3Node, l_Node) and Assigned(dsDocumentList)
//#UC END# *4C3AA94D0041_497DDB2B001Bexec_impl*
end;//TPrimListForm.CRList_SetType_Execute

procedure TPrimListForm.Document_GetGraphicImage_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3C77CC012A_497DDB2B001Btest_var*
//#UC END# *4C3C77CC012A_497DDB2B001Btest_var*
begin
//#UC START# *4C3C77CC012A_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C3C77CC012A_497DDB2B001Btest_impl*
end;//TPrimListForm.Document_GetGraphicImage_Test

procedure TPrimListForm.Document_GetGraphicImage_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3C77CC012A_497DDB2B001Bexec_var*
//#UC END# *4C3C77CC012A_497DDB2B001Bexec_var*
begin
//#UC START# *4C3C77CC012A_497DDB2B001Bexec_impl*
 Assert(false);
//#UC END# *4C3C77CC012A_497DDB2B001Bexec_impl*
end;//TPrimListForm.Document_GetGraphicImage_Execute

procedure TPrimListForm.LocalList_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C46E7160275_497DDB2B001Bexec_var*
//#UC END# *4C46E7160275_497DDB2B001Bexec_var*
begin
//#UC START# *4C46E7160275_497DDB2B001Bexec_impl*
 OpenInNewWindow;
//#UC END# *4C46E7160275_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_OpenNewWindow_Execute

procedure TPrimListForm.Selection_CopyToNewList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C46EB11016B_497DDB2B001Btest_var*
//#UC END# *4C46EB11016B_497DDB2B001Btest_var*
begin
//#UC START# *4C46EB11016B_497DDB2B001Btest_impl*
 SelectionOpsTest(aParams);
//#UC END# *4C46EB11016B_497DDB2B001Btest_impl*
end;//TPrimListForm.Selection_CopyToNewList_Test

procedure TPrimListForm.Selection_CopyToNewList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C46EB11016B_497DDB2B001Bexec_var*
var
 l_Data   : IdeList;
 l_Cont : IvcmContainer;
//#UC END# *4C46EB11016B_497DDB2B001Bexec_var*
begin
//#UC START# *4C46EB11016B_497DDB2B001Bexec_impl*
 if Assigned(dsList) then
 begin
  l_Data := dsList.OpenListFromSelectedNodes;
  if Assigned(l_Data) then
  try
   l_Cont := nsOpenNewWindowTabbed(NativeMainForm);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=414849606
   if (l_Cont <> nil) then
   try
    TdmStdRes.OpenList(l_Data, l_Cont);
   finally
    l_Cont := nil;
   end;//try..finally
  finally
   l_Data := nil;
  end;{try..finally}
 end;//if Assigned(dsDocumentList) then
//#UC END# *4C46EB11016B_497DDB2B001Bexec_impl*
end;//TPrimListForm.Selection_CopyToNewList_Execute

procedure TPrimListForm.Filters_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C52AA040095_497DDB2B001Bexec_var*
//#UC END# *4C52AA040095_497DDB2B001Bexec_var*
begin
//#UC START# *4C52AA040095_497DDB2B001Bexec_impl*
 ClearFilters;
//#UC END# *4C52AA040095_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filters_Clear_Execute

procedure TPrimListForm.Selection_Analize_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8103FB02FD_497DDB2B001Btest_var*
//#UC END# *4C8103FB02FD_497DDB2B001Btest_var*
begin
//#UC START# *4C8103FB02FD_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not IsListEmpty and
  {(tvList.TreeView.Tree.SelectedCount = 1) and}
  // http://mdp.garant.ru/pages/viewpage.action?pageId=253662765&focusedCommentId=253663972#comment-253663972
  Assigned(dsDocumentList) and dsDocumentList.CanAnalize;
//#UC END# *4C8103FB02FD_497DDB2B001Btest_impl*
end;//TPrimListForm.Selection_Analize_Test

procedure TPrimListForm.Selection_Analize_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8103FB02FD_497DDB2B001Bexec_var*
//#UC END# *4C8103FB02FD_497DDB2B001Bexec_var*
begin
//#UC START# *4C8103FB02FD_497DDB2B001Bexec_impl*
 if Assigned(dsDocumentList) then
  TdmStdRes.MakeListAnalizer(dsDocumentList.MakeAnalizeTree);
//#UC END# *4C8103FB02FD_497DDB2B001Bexec_impl*
end;//TPrimListForm.Selection_Analize_Execute

procedure TPrimListForm.LocalList_SearchInList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C810A2702D9_497DDB2B001Btest_var*
//#UC END# *4C810A2702D9_497DDB2B001Btest_var*
begin
//#UC START# *4C810A2702D9_497DDB2B001Btest_impl*
 ListOpsTest(aParams);
//#UC END# *4C810A2702D9_497DDB2B001Btest_impl*
end;//TPrimListForm.LocalList_SearchInList_Test

procedure TPrimListForm.LocalList_SearchInList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C810A2702D9_497DDB2B001Bexec_var*
//#UC END# *4C810A2702D9_497DDB2B001Bexec_var*
begin
//#UC START# *4C810A2702D9_497DDB2B001Bexec_impl*
 TdmStdRes.AttributeSearch(nil, dsList.List, nil);
//#UC END# *4C810A2702D9_497DDB2B001Bexec_impl*
end;//TPrimListForm.LocalList_SearchInList_Execute

procedure TPrimListForm.Filters_FiltersListOpen_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C81191003E5_497DDB2B001Btest_var*
//#UC END# *4C81191003E5_497DDB2B001Btest_var*
begin
//#UC START# *4C81191003E5_497DDB2B001Btest_impl*
 // Do nothing
//#UC END# *4C81191003E5_497DDB2B001Btest_impl*
end;//TPrimListForm.Filters_FiltersListOpen_Test

procedure TPrimListForm.Filters_FiltersListOpen_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C81191003E5_497DDB2B001Bexec_var*
//#UC END# *4C81191003E5_497DDB2B001Bexec_var*
begin
//#UC START# *4C81191003E5_497DDB2B001Bexec_impl*
 if (ucpFilters = nil) then
  TdmStdRes.OldSchoolFiltersOpen(Aggregate, nil, Self)
 else
  TdmStdRes.FiltersOpen(ucpFilters);
//#UC END# *4C81191003E5_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filters_FiltersListOpen_Execute

function TPrimListForm.pm_GetHyperlinkDocID: Integer;
//#UC START# *4CDD19B503B1_497DDB2B001Bget_var*
//#UC END# *4CDD19B503B1_497DDB2B001Bget_var*
begin
//#UC START# *4CDD19B503B1_497DDB2B001Bget_impl*
 if (sdsBaseDocument = nil) then
  Result := 0
 else
  try
   if (sdsBaseDocument.DocInfo = nil) OR
      (sdsBaseDocument.DocInfo.Doc = nil) then
    Result := 0
   else
    Result := sdsBaseDocument.DocInfo.Doc.GetInternalId + c_InternalDocShift;
  except
   on ECanNotFindData do
    Result := 0;
  end;//try..except
//#UC END# *4CDD19B503B1_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetHyperlinkDocID

function TPrimListForm.pm_GetHyperlinkDocumentName: Il3CString;
//#UC START# *4CDD1A02013D_497DDB2B001Bget_var*
//#UC END# *4CDD1A02013D_497DDB2B001Bget_var*
begin
//#UC START# *4CDD1A02013D_497DDB2B001Bget_impl*
 if (sdsBaseDocument = nil) then
  Result := nil
 else
  Result := sdsBaseDocument.DocInfo.DocName;
//#UC END# *4CDD1A02013D_497DDB2B001Bget_impl*
end;//TPrimListForm.pm_GetHyperlinkDocumentName

procedure TPrimListForm.Filters_InternalClear_Execute;
//#UC START# *4DBA95ED03B7_497DDB2B001Bexec_var*
//#UC END# *4DBA95ED03B7_497DDB2B001Bexec_var*
begin
//#UC START# *4DBA95ED03B7_497DDB2B001Bexec_impl*
 ClearFilters;
//#UC END# *4DBA95ED03B7_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filters_InternalClear_Execute

procedure TPrimListForm.Filters_InternalClear(const aParams: IvcmExecuteParams);
begin
 Filters_InternalClear_Execute;
end;

function TPrimListForm.Get_NeedSaveActiveClassBeforeSearch: Boolean;
//#UC START# *4F1D607E0027_497DDB2B001Bget_var*
//#UC END# *4F1D607E0027_497DDB2B001Bget_var*
begin
//#UC START# *4F1D607E0027_497DDB2B001Bget_impl*
 Result := true;
//#UC END# *4F1D607E0027_497DDB2B001Bget_impl*
end;//TPrimListForm.Get_NeedSaveActiveClassBeforeSearch

function TPrimListForm.Filterable_GetListType_Execute: TbsListType;
//#UC START# *4F99403A00A5_497DDB2B001Bexec_var*
//#UC END# *4F99403A00A5_497DDB2B001Bexec_var*
begin
//#UC START# *4F99403A00A5_497DDB2B001Bexec_impl*
 if (dsList <> nil) then
  Result := dsList.ListType
 else
  Result := bs_ltNone;
//#UC END# *4F99403A00A5_497DDB2B001Bexec_impl*
end;//TPrimListForm.Filterable_GetListType_Execute

procedure TPrimListForm.Filterable_GetListType(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFilterable_GetListType_Params) do
  ResultValue := Filterable_GetListType_Execute;
end;

function TPrimListForm.List_GetDsList_Execute: IdsList;
//#UC START# *4FE83BFC039C_497DDB2B001Bexec_var*
//#UC END# *4FE83BFC039C_497DDB2B001Bexec_var*
begin
//#UC START# *4FE83BFC039C_497DDB2B001Bexec_impl*
 Result := dsList;
//#UC END# *4FE83BFC039C_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_GetDsList_Execute

procedure TPrimListForm.List_GetDsList(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IList_GetDsList_Params) do
  ResultValue := List_GetDsList_Execute;
end;

procedure TPrimListForm.LftUserCRList1SynchorFormQueryMaximized(aSender: TObject);
//#UC START# *536B8B1C39F1_497DDB2B001B_var*
//#UC END# *536B8B1C39F1_497DDB2B001B_var*
begin
//#UC START# *536B8B1C39F1_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *536B8B1C39F1_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCRList1SynchorFormQueryMaximized

procedure TPrimListForm.List_Analize_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *53DB376C0239_497DDB2B001Btest_var*
//#UC END# *53DB376C0239_497DDB2B001Btest_var*
begin
//#UC START# *53DB376C0239_497DDB2B001Btest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not IsListEmpty and
  {(tvList.TreeView.Tree.SelectedCount = 1) and}
  // http://mdp.garant.ru/pages/viewpage.action?pageId=253662765&focusedCommentId=253663972#comment-253663972
  Assigned(dsDocumentList) and dsDocumentList.CanAnalize and (aParams.Control = tvList);
//#UC END# *53DB376C0239_497DDB2B001Btest_impl*
end;//TPrimListForm.List_Analize_Test

procedure TPrimListForm.List_Analize_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *53DB376C0239_497DDB2B001Bexec_var*
//#UC END# *53DB376C0239_497DDB2B001Bexec_var*
begin
//#UC START# *53DB376C0239_497DDB2B001Bexec_impl*
 if Assigned(dsDocumentList) then
  TdmStdRes.MakeListAnalizer(dsDocumentList.MakeAnalizeTree);
//#UC END# *53DB376C0239_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_Analize_Execute

procedure TPrimListForm.List_AnalizeList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *53FF40030272_497DDB2B001Btest_var*
//#UC END# *53FF40030272_497DDB2B001Btest_var*
begin
//#UC START# *53FF40030272_497DDB2B001Btest_impl*
 List_Analize_Test(aParams);
//#UC END# *53FF40030272_497DDB2B001Btest_impl*
end;//TPrimListForm.List_AnalizeList_Test

procedure TPrimListForm.List_AnalizeList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *53FF40030272_497DDB2B001Bexec_var*
//#UC END# *53FF40030272_497DDB2B001Bexec_var*
begin
//#UC START# *53FF40030272_497DDB2B001Bexec_impl*
 List_Analize_Execute(aParams);
//#UC END# *53FF40030272_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_AnalizeList_Execute

procedure TPrimListForm.List_SortForReminders_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *545B93FE00D1_497DDB2B001Btest_var*
//#UC END# *545B93FE00D1_497DDB2B001Btest_var*
begin
//#UC START# *545B93FE00D1_497DDB2B001Btest_impl*
 List_Sort_Test(aParams);
 if (aParams.Control = tvList) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *545B93FE00D1_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SortForReminders_Test

procedure TPrimListForm.List_SortForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *545B93FE00D1_497DDB2B001Bexec_var*
//#UC END# *545B93FE00D1_497DDB2B001Bexec_var*
begin
//#UC START# *545B93FE00D1_497DDB2B001Bexec_impl*
 List_Sort_Execute(aParams);
//#UC END# *545B93FE00D1_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SortForReminders_Execute

procedure TPrimListForm.List_SortDirectionForReminders_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *545B9440035C_497DDB2B001Btest_var*
//#UC END# *545B9440035C_497DDB2B001Btest_var*
begin
//#UC START# *545B9440035C_497DDB2B001Btest_impl*
 List_SortDirection_Test(aParams);
 if (aParams.Control = tvList) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *545B9440035C_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SortDirectionForReminders_Test

procedure TPrimListForm.List_SortDirectionForReminders_GetState(var State: TvcmOperationStateIndex);
//#UC START# *545B9440035C_497DDB2B001Bgetstate_var*
//#UC END# *545B9440035C_497DDB2B001Bgetstate_var*
begin
//#UC START# *545B9440035C_497DDB2B001Bgetstate_impl*
 if HasCurrent and Assigned(dsDocumentList) then
  if dsDocumentList.SortOrder = SO_ASCENDING then
   State := st_user_List_SortDirectionForReminders_Ascending
  else
   State := st_user_List_SortDirectionForReminders_Descending
 else
  State := vcm_DefaultOperationState;
//#UC END# *545B9440035C_497DDB2B001Bgetstate_impl*
end;//TPrimListForm.List_SortDirectionForReminders_GetState

procedure TPrimListForm.List_SortDirectionForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *545B9440035C_497DDB2B001Bexec_var*
//#UC END# *545B9440035C_497DDB2B001Bexec_var*
begin
//#UC START# *545B9440035C_497DDB2B001Bexec_impl*
 List_SortDirection_Execute(aParams);
//#UC END# *545B9440035C_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SortDirectionForReminders_Execute

procedure TPrimListForm.List_SpecifyListForReminders_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *545B954A035E_497DDB2B001Btest_var*
//#UC END# *545B954A035E_497DDB2B001Btest_var*
begin
//#UC START# *545B954A035E_497DDB2B001Btest_impl*
 List_SpecifyList_Test(aParams);
 if (aParams.Control = tvList) then
   aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *545B954A035E_497DDB2B001Btest_impl*
end;//TPrimListForm.List_SpecifyListForReminders_Test

procedure TPrimListForm.List_SpecifyListForReminders_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *545B954A035E_497DDB2B001Bexec_var*
//#UC END# *545B954A035E_497DDB2B001Bexec_var*
begin
//#UC START# *545B954A035E_497DDB2B001Bexec_impl*
 List_SpecifyList_Execute(aParams);
//#UC END# *545B954A035E_497DDB2B001Bexec_impl*
end;//TPrimListForm.List_SpecifyListForReminders_Execute

procedure TPrimListForm.LftProducedDrugsQueryClose(aSender: TObject);
//#UC START# *5487A60000CE_497DDB2B001B_var*
//#UC END# *5487A60000CE_497DDB2B001B_var*
begin
//#UC START# *5487A60000CE_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *5487A60000CE_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsQueryClose

function TPrimListForm.IsSearchLocked: Boolean;
//#UC START# *561641EE03D8_497DDB2B001B_var*
//#UC END# *561641EE03D8_497DDB2B001B_var*
begin
//#UC START# *561641EE03D8_497DDB2B001B_impl*
 Result := False;
//#UC END# *561641EE03D8_497DDB2B001B_impl*
end;//TPrimListForm.IsSearchLocked

procedure TPrimListForm.LftUserCR2QueryClose(aSender: TObject);
//#UC START# *5B815CDD8F87_497DDB2B001B_var*
//#UC END# *5B815CDD8F87_497DDB2B001B_var*
begin
//#UC START# *5B815CDD8F87_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *5B815CDD8F87_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR2QueryClose

procedure TPrimListForm.LftConsultationQueryOpen(aSender: TObject);
//#UC START# *5E40E10FD4BD_497DDB2B001B_var*
//#UC END# *5E40E10FD4BD_497DDB2B001B_var*
begin
//#UC START# *5E40E10FD4BD_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *5E40E10FD4BD_497DDB2B001B_impl*
end;//TPrimListForm.LftConsultationQueryOpen

procedure TPrimListForm.LftRespondentQueryMaximized(aSender: TObject);
//#UC START# *631A220E9075_497DDB2B001B_var*
//#UC END# *631A220E9075_497DDB2B001B_var*
begin
//#UC START# *631A220E9075_497DDB2B001B_impl*
 QueryMaximized;
//#UC END# *631A220E9075_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentQueryMaximized

procedure TPrimListForm.LftUserCR1QueryOpen(aSender: TObject);
//#UC START# *63544B6D4A1B_497DDB2B001B_var*
//#UC END# *63544B6D4A1B_497DDB2B001B_var*
begin
//#UC START# *63544B6D4A1B_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *63544B6D4A1B_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR1QueryOpen

procedure TPrimListForm.LftProducedDrugsQueryMaximized(aSender: TObject);
//#UC START# *66C365C924D6_497DDB2B001B_var*
//#UC END# *66C365C924D6_497DDB2B001B_var*
begin
//#UC START# *66C365C924D6_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *66C365C924D6_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsQueryMaximized

procedure TPrimListForm.LftRespondentQueryClose(aSender: TObject);
//#UC START# *6784C69651CE_497DDB2B001B_var*
//#UC END# *6784C69651CE_497DDB2B001B_var*
begin
//#UC START# *6784C69651CE_497DDB2B001B_impl*
 if UserType in [lftUserCR1,
                 lftUserCR2,
                 lftSimilarDocuments,
                 lftProducedDrugs,
                 lftDrugInternationalNameSynonyms] then
  op_Switcher_SetFirstPageActive.Call(Container)
 else
  SafeClose;
//#UC END# *6784C69651CE_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentQueryClose

procedure TPrimListForm.LftUserCR2QueryMaximized(aSender: TObject);
//#UC START# *68123CAC609E_497DDB2B001B_var*
//#UC END# *68123CAC609E_497DDB2B001B_var*
begin
//#UC START# *68123CAC609E_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *68123CAC609E_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR2QueryMaximized

procedure TPrimListForm.LftSimilarDocumentsSynchroViewQueryMaximized(aSender: TObject);
//#UC START# *7662726E4743_497DDB2B001B_var*
//#UC END# *7662726E4743_497DDB2B001B_var*
begin
//#UC START# *7662726E4743_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *7662726E4743_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsSynchroViewQueryMaximized

procedure TPrimListForm.LftCorrespondentQueryOpen(aSender: TObject);
//#UC START# *7984D701603A_497DDB2B001B_var*
//#UC END# *7984D701603A_497DDB2B001B_var*
begin
//#UC START# *7984D701603A_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *7984D701603A_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentQueryOpen

procedure TPrimListForm.LftCorrespondentsSynchroFormQueryMaximized(aSender: TObject);
//#UC START# *79CA491C075A_497DDB2B001B_var*
//#UC END# *79CA491C075A_497DDB2B001B_var*
begin
//#UC START# *79CA491C075A_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *79CA491C075A_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentsSynchroFormQueryMaximized

procedure TPrimListForm.LftUserCR1QueryMaximized(aSender: TObject);
//#UC START# *79E93ABBEBFC_497DDB2B001B_var*
//#UC END# *79E93ABBEBFC_497DDB2B001B_var*
begin
//#UC START# *79E93ABBEBFC_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *79E93ABBEBFC_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR1QueryMaximized

procedure TPrimListForm.LftUserCR1QueryClose(aSender: TObject);
//#UC START# *7C26AE9268E7_497DDB2B001B_var*
//#UC END# *7C26AE9268E7_497DDB2B001B_var*
begin
//#UC START# *7C26AE9268E7_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *7C26AE9268E7_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCR1QueryClose

procedure TPrimListForm.LftDrugInternationalNameSynonymsQueryClose(aSender: TObject);
//#UC START# *7CA1B2391F94_497DDB2B001B_var*
//#UC END# *7CA1B2391F94_497DDB2B001B_var*
begin
//#UC START# *7CA1B2391F94_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *7CA1B2391F94_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsQueryClose

procedure TPrimListForm.LftSynchroViewQueryOpen(aSender: TObject);
//#UC START# *7D78C9A85314_497DDB2B001B_var*
//#UC END# *7D78C9A85314_497DDB2B001B_var*
begin
//#UC START# *7D78C9A85314_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *7D78C9A85314_497DDB2B001B_impl*
end;//TPrimListForm.LftSynchroViewQueryOpen

procedure TPrimListForm.LftDrugInternationalNameSynonymsQueryOpen(aSender: TObject);
//#UC START# *8829BBB9E33F_497DDB2B001B_var*
//#UC END# *8829BBB9E33F_497DDB2B001B_var*
begin
//#UC START# *8829BBB9E33F_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *8829BBB9E33F_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsQueryOpen

procedure TPrimListForm.LftConsultationQueryClose(aSender: TObject);
//#UC START# *89247CD8E38D_497DDB2B001B_var*
//#UC END# *89247CD8E38D_497DDB2B001B_var*
begin
//#UC START# *89247CD8E38D_497DDB2B001B_impl*
 op_Switcher_SetFirstPageActive.Call(Container);
//#UC END# *89247CD8E38D_497DDB2B001B_impl*
end;//TPrimListForm.LftConsultationQueryClose

procedure TPrimListForm.LftRToPartQueryMaximized(aSender: TObject);
//#UC START# *910DF1C1598C_497DDB2B001B_var*
//#UC END# *910DF1C1598C_497DDB2B001B_var*
begin
//#UC START# *910DF1C1598C_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *910DF1C1598C_497DDB2B001B_impl*
end;//TPrimListForm.LftRToPartQueryMaximized

procedure TPrimListForm.LftSimilarDocumentsQueryClose(aSender: TObject);
//#UC START# *9144562E25FB_497DDB2B001B_var*
//#UC END# *9144562E25FB_497DDB2B001B_var*
begin
//#UC START# *9144562E25FB_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *9144562E25FB_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsQueryClose

procedure TPrimListForm.LftSimilarDocumentsToFragmentQueryMaximized(aSender: TObject);
//#UC START# *9CAFD9A7C3BD_497DDB2B001B_var*
//#UC END# *9CAFD9A7C3BD_497DDB2B001B_var*
begin
//#UC START# *9CAFD9A7C3BD_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *9CAFD9A7C3BD_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsToFragmentQueryMaximized

procedure TPrimListForm.LftRespondentQueryOpen(aSender: TObject);
//#UC START# *9FBF6C4D3127_497DDB2B001B_var*
//#UC END# *9FBF6C4D3127_497DDB2B001B_var*
begin
//#UC START# *9FBF6C4D3127_497DDB2B001B_impl*
 QueryOpen;
//#UC END# *9FBF6C4D3127_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentQueryOpen

procedure TPrimListForm.LftCorrespondentQueryMaximized(aSender: TObject);
//#UC START# *AC1A36740EA8_497DDB2B001B_var*
//#UC END# *AC1A36740EA8_497DDB2B001B_var*
begin
//#UC START# *AC1A36740EA8_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *AC1A36740EA8_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentQueryMaximized

procedure TPrimListForm.LftSimilarDocumentsToFragmentQueryOpen(aSender: TObject);
//#UC START# *B3625EBE1EED_497DDB2B001B_var*
//#UC END# *B3625EBE1EED_497DDB2B001B_var*
begin
//#UC START# *B3625EBE1EED_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *B3625EBE1EED_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsToFragmentQueryOpen

procedure TPrimListForm.LftProducedDrugsSynchroFormQueryOpen(aSender: TObject);
//#UC START# *B74FCF7BEB24_497DDB2B001B_var*
//#UC END# *B74FCF7BEB24_497DDB2B001B_var*
begin
//#UC START# *B74FCF7BEB24_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *B74FCF7BEB24_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsSynchroFormQueryOpen

procedure TPrimListForm.LftConsultationQueryMaximized(aSender: TObject);
//#UC START# *B8F5E8ADF26A_497DDB2B001B_var*
//#UC END# *B8F5E8ADF26A_497DDB2B001B_var*
begin
//#UC START# *B8F5E8ADF26A_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *B8F5E8ADF26A_497DDB2B001B_impl*
end;//TPrimListForm.LftConsultationQueryMaximized

procedure TPrimListForm.LftCorrespondentQueryClose(aSender: TObject);
//#UC START# *BAF9A43F64B1_497DDB2B001B_var*
//#UC END# *BAF9A43F64B1_497DDB2B001B_var*
begin
//#UC START# *BAF9A43F64B1_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *BAF9A43F64B1_497DDB2B001B_impl*
end;//TPrimListForm.LftCorrespondentQueryClose

procedure TPrimListForm.LftSynchroViewQueryMaximized(aSender: TObject);
//#UC START# *BC1EF73BE90E_497DDB2B001B_var*
//#UC END# *BC1EF73BE90E_497DDB2B001B_var*
begin
//#UC START# *BC1EF73BE90E_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *BC1EF73BE90E_497DDB2B001B_impl*
end;//TPrimListForm.LftSynchroViewQueryMaximized

procedure TPrimListForm.LftRespondentsSynchroFormQueryOpen(aSender: TObject);
//#UC START# *C576738B9A98_497DDB2B001B_var*
//#UC END# *C576738B9A98_497DDB2B001B_var*
begin
//#UC START# *C576738B9A98_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *C576738B9A98_497DDB2B001B_impl*
end;//TPrimListForm.LftRespondentsSynchroFormQueryOpen

procedure TPrimListForm.LftUserCRList2SynchorFormQueryMaximized(aSender: TObject);
//#UC START# *D22B2108D1D7_497DDB2B001B_var*
//#UC END# *D22B2108D1D7_497DDB2B001B_var*
begin
//#UC START# *D22B2108D1D7_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *D22B2108D1D7_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCRList2SynchorFormQueryMaximized

procedure TPrimListForm.LftUserCRList1SynchorFormQueryOpen(aSender: TObject);
//#UC START# *D51A85B5EA94_497DDB2B001B_var*
//#UC END# *D51A85B5EA94_497DDB2B001B_var*
begin
//#UC START# *D51A85B5EA94_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *D51A85B5EA94_497DDB2B001B_impl*
end;//TPrimListForm.LftUserCRList1SynchorFormQueryOpen

procedure TPrimListForm.LftSimilarDocumentsSynchroViewQueryOpen(aSender: TObject);
//#UC START# *D7AA4578D2D1_497DDB2B001B_var*
//#UC END# *D7AA4578D2D1_497DDB2B001B_var*
begin
//#UC START# *D7AA4578D2D1_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *D7AA4578D2D1_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsSynchroViewQueryOpen

procedure TPrimListForm.LftProducedDrugsQueryOpen(aSender: TObject);
//#UC START# *DD3CF6B9A1FE_497DDB2B001B_var*
//#UC END# *DD3CF6B9A1FE_497DDB2B001B_var*
begin
//#UC START# *DD3CF6B9A1FE_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *DD3CF6B9A1FE_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsQueryOpen

procedure TPrimListForm.LftDrugInternationalNameSynonymsQueryMaximized(aSender: TObject);
//#UC START# *DF8DF3016AAE_497DDB2B001B_var*
//#UC END# *DF8DF3016AAE_497DDB2B001B_var*
begin
//#UC START# *DF8DF3016AAE_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *DF8DF3016AAE_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsQueryMaximized

procedure TPrimListForm.LftSimilarDocumentsToFragmentQueryClose(aSender: TObject);
//#UC START# *E15AA3CCAAFD_497DDB2B001B_var*
//#UC END# *E15AA3CCAAFD_497DDB2B001B_var*
begin
//#UC START# *E15AA3CCAAFD_497DDB2B001B_impl*
 LftRespondentQueryClose(aSender);
//#UC END# *E15AA3CCAAFD_497DDB2B001B_impl*
end;//TPrimListForm.LftSimilarDocumentsToFragmentQueryClose

procedure TPrimListForm.LftDrugInternationalNameSynonymsSynchroFormQueryOpen(aSender: TObject);
//#UC START# *E163385C2B4E_497DDB2B001B_var*
//#UC END# *E163385C2B4E_497DDB2B001B_var*
begin
//#UC START# *E163385C2B4E_497DDB2B001B_impl*
 LftRespondentQueryOpen(aSender);
//#UC END# *E163385C2B4E_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsSynchroFormQueryOpen

procedure TPrimListForm.LftDrugInternationalNameSynonymsSynchroFormQueryMaximized(aSender: TObject);
//#UC START# *F57A05E9D1E3_497DDB2B001B_var*
//#UC END# *F57A05E9D1E3_497DDB2B001B_var*
begin
//#UC START# *F57A05E9D1E3_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *F57A05E9D1E3_497DDB2B001B_impl*
end;//TPrimListForm.LftDrugInternationalNameSynonymsSynchroFormQueryMaximized

procedure TPrimListForm.LftProducedDrugsSynchroFormQueryMaximized(aSender: TObject);
//#UC START# *F8F8E6852550_497DDB2B001B_var*
//#UC END# *F8F8E6852550_497DDB2B001B_var*
begin
//#UC START# *F8F8E6852550_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *F8F8E6852550_497DDB2B001B_impl*
end;//TPrimListForm.LftProducedDrugsSynchroFormQueryMaximized

procedure TPrimListForm.LftCToPartQueryMaximized(aSender: TObject);
//#UC START# *FA04A3642350_497DDB2B001B_var*
//#UC END# *FA04A3642350_497DDB2B001B_var*
begin
//#UC START# *FA04A3642350_497DDB2B001B_impl*
 LftRespondentQueryMaximized(aSender);
//#UC END# *FA04A3642350_497DDB2B001B_impl*
end;//TPrimListForm.LftCToPartQueryMaximized

procedure TPrimListForm.LftCToPartQueryOpen(aSender: TObject);
//#UC START# *FEE09FA84BC5_497DDB2B001B_var*
//#UC END# *FEE09FA84BC5_497DDB2B001B_var*
begin
//#UC START# *FEE09FA84BC5_497DDB2B001B_impl*
 LftCorrespondentQueryOpen(aSender);
//#UC END# *FEE09FA84BC5_497DDB2B001B_impl*
end;//TPrimListForm.LftCToPartQueryOpen

procedure TPrimListForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_497DDB2B001B_var*
//#UC END# *47EA4E9002C6_497DDB2B001B_var*
begin
//#UC START# *47EA4E9002C6_497DDB2B001B_impl*
 inherited;
 if not IsAcceptable(True) then
 begin 
  if vcmDispatcher.History.CanBack then
   vcmDispatcher.History.Back(True);
 end;
//#UC END# *47EA4E9002C6_497DDB2B001B_impl*
end;//TPrimListForm.FinishDataUpdate

{$If not defined(NoVCM)}
procedure TPrimListForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
  const aNew: IvcmViewAreaController);
//#UC START# *497469C90140_497DDB2B001B_var*
//#UC END# *497469C90140_497DDB2B001B_var*
begin
//#UC START# *497469C90140_497DDB2B001B_impl*
 inherited;
 f_AllowCallCurrentChangedOnTest := True;

 tvList.SelfDrawNodes := Assigned(dsDocumentList) and dsDocumentList.IsSnippet;
 if tvList.HandleAllocated then
  PostMessage(tvList.Handle, msg_vtInvalidateNCArea, 0, 0);
//#UC END# *497469C90140_497DDB2B001B_impl*
end;//TPrimListForm.NotifyDataSourceChanged
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimListForm.DoSaveState(out theState: IvcmBase;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *49806ED503D5_497DDB2B001B_var*
var
 l_InnerState: IvcmBase;
 l_cfState: IUnknown;
 l_cfStateMaker: IvcmState;
 l_TreeStructStateProvider: InsTreeStructStateProvider;
 l_TreeStructState: InsTreeStructState;
//#UC END# *49806ED503D5_497DDB2B001B_var*
begin
//#UC START# *49806ED503D5_497DDB2B001B_impl*
 theState := nil;
 l_InnerState := nil;
 l_TreeStructState := nil;
 Result := inherited DoSaveState(l_InnerState, aStateType, aForClone);
 if aForClone and tvList.IsTreeAssign then
 begin
  if Supports(tvList.TreeStruct, InsTreeStructStateProvider, l_TreeStructStateProvider) then
   l_TreeStructState := l_TreeStructStateProvider.MakeState;
  if Supports(cfList, IvcmState, l_cfStateMaker) then
   if l_cfStateMaker.SaveState(l_cfState, vcm_stContent) then
    theState := TPrimListFormState.Make(l_InnerState, l_cfState, l_TreeStructState, tvList.TopIndex, tvList.Current,
                                        [lfoContextFilterState, lfoTopItemIndex, lfoCurrentIndex, lfoTreeStructState, lfoInner]);
  if (theState = nil) then
   theState := TPrimListFormState.Make(l_InnerState, nil, nil, 0, 0, [lfoInner]);
 end;
 if (theState = nil) then
  theState := l_InnerState;
//#UC END# *49806ED503D5_497DDB2B001B_impl*
end;//TPrimListForm.DoSaveState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimListForm.DoLoadState(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
//#UC START# *49807428008C_497DDB2B001B_var*
var
 l_StateReceiver: IvcmState;
 l_State: IPrimListFormState;
 l_TreeStructState: InsTreeStructState;
 l_TreeStructStateConsumer: InsTreeStructStateConsumer;
 l_InnerState: IvcmBase;
 l_WasActive: Boolean;
//#UC END# *49807428008C_497DDB2B001B_var*
begin
//#UC START# *49807428008C_497DDB2B001B_impl*
 if (UserType = lftDrugList) and (aStateType = vcm_stContent) then
 begin
  if Supports(aState, IPrimListFormState, l_State) then
  begin
   l_InnerState := l_State.InnerState;
   if (l_State.ContextFilterState <> nil) then
   begin
    if Supports(cfList, IvcmState, l_StateReceiver) then
    begin
     // �� �������������� �������� ������, �� �������� � ���, ���
     // � TnscContextFilter �������� ����� ������-�� ��������� ����,
     // ������� ������� �������
     // http://mdp.garant.ru/pages/viewpage.action?pageId=609593354

     tvList.TreeStruct;
     // - ����� TreeStruct ��������� ��� ��������� � ����������� ������ �����-��
     // ����� ���� ��������
     if (lfoContextFilterState in l_State.Options) then
     begin
      cfList.BeginAssignState;
      l_StateReceiver.LoadState(l_State.ContextFilterState, aStateType);
      l_WasActive := cfList.Active;
      cfList.Active := False;
      // - ���� ����� Active - �������� ������-�� ����� ��������� ��������
      // � ��� �������� � ������� ����
      cfList.EndAssignState;
      cfList.Active := l_WasActive;
     end;
    end;
    Result := True;
   end
   else
    Result := inherited DoLoadState(l_InnerState, aStateType);
  end
  else
   Assert(False)
 end
 else
 begin
  l_InnerState := aState;
  if Supports(aState, IPrimListFormState, l_State) then
  begin
   l_InnerState := l_State.InnerState;
   if (lfoCurrentIndex in l_State.Options) then
    tvList.Current := l_State.CurrentIndex;
   if (lfoTreeStructState in l_State.Options) then
    if Supports(tvList.TreeStruct, InsTreeStructStateConsumer, l_TreeStructStateConsumer) then
     l_TreeStructStateConsumer.AssignState(l_State.TreeStructState);
   if (lfoTopItemIndex in l_State.Options) then
    tvList.TopIndex := l_State.TopItemIndex;
  end;
  Result := inherited DoLoadState(l_InnerState, aStateType);
 end; 
//#UC END# *49807428008C_497DDB2B001B_impl*
end;//TPrimListForm.DoLoadState
{$IfEnd} //not NoVCM

function TPrimListForm.NeedsStatusBarItems: Boolean;
//#UC START# *4A8E5CEC021F_497DDB2B001B_var*
//#UC END# *4A8E5CEC021F_497DDB2B001B_var*
begin
//#UC START# *4A8E5CEC021F_497DDB2B001B_impl*
 Result := (UserType = lftNone);
//#UC END# *4A8E5CEC021F_497DDB2B001B_impl*
end;//TPrimListForm.NeedsStatusBarItems

{$If not defined(NoVCM)}
procedure TPrimListForm.InitControls;
//#UC START# *4A8E8F2E0195_497DDB2B001B_var*
//#UC END# *4A8E8F2E0195_497DDB2B001B_var*
begin
//#UC START# *4A8E8F2E0195_497DDB2B001B_impl*
 inherited;
 ActiveControl := tvList;
 tvList.NonTrackScroll := true;
 tvList.StyleId := ev_saTxtNormalANSI;
 with ListPanel do
 begin
  Left := 0;
  Top := 0;
  Width := 399;
  Height := 493;
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;//with ListPanel
 with cfList do
 begin
  Left := 0;
  Top := 0;
  Width := 399;
  Height := 35;
  ImageIndex := 77;
  ContextFilterTarget := tvList;
  OnChange := cfListChange;
  OnWrongContext := cfListWrongContext;
 end;
 with tvList do
 begin
  Left := 0;
  Top := 35;
  Width := 399;
  Height := 458;
  OnCountChanged := tvListCountChanged;
  OnAfterFirstPaint := tvListAfterFirstPaint;
  OnCurrentIndexChanged := tvListCurrentIndexChanged;
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 0;
  MultiSelect := True;
  MultiStrokeItem := True;
  ActionElementMode := l3_amSecondSingleClick;
  NeedStatus := True;
  OnGetItemIconHint := tvListGetItemIconHint;
  OnMakeTreeSource := tvListMakeTreeSource;
  OnGetItemImage := tvListGetItemImage;
  OnActionElement := tvListActionElement;
  OnCurrentChanged := tvListCurrentChanged;
  OnTreeChanged := tvListTreeChanged;
  OnRootChanged := tvListRootChanged;
  OnSelectCountChanged := tvListSelectCountChanged;
  OnFormatStatusInfo := tvListFormatStatusInfo;
  OnNewCharPressed := tvListNewCharPressed;
  OnCheckFocusedInPaint := tvListCheckFocusedInPaint;
  OnGetNodeType := TvListGetNodeType;
  DragAndDropSupported := True;
  FooterCaption := str_ListFooterCaption.AsStr;
  OnFooterClick := tvListFooterClick;
  SettingId := 'stidListTree';
  InterRowMultiplier := 2;             
  OpenChipColor := $ADADAD; //414849886 
  OpenChipBorderColor := $ADADAD;
 end;
//#UC END# *4A8E8F2E0195_497DDB2B001B_impl*
end;//TPrimListForm.InitControls
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimListForm.PageActive;
//#UC START# *4C52E8030278_497DDB2B001B_var*
//#UC END# *4C52E8030278_497DDB2B001B_var*
begin
//#UC START# *4C52E8030278_497DDB2B001B_impl*
 if (dsList <> nil) then
  dsList.CurrentChanged(tvList.GetCurrentNode);
//#UC END# *4C52E8030278_497DDB2B001B_impl*
end;//TPrimListForm.PageActive
{$IfEnd} //not NoVCM

procedure TPrimListForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_SortTypeMap := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPrimListForm.ClearFields

function TPrimListForm.NeedMakeHyperlinkToDocument: Boolean;
//#UC START# *53EB17EF0306_497DDB2B001B_var*
//#UC END# *53EB17EF0306_497DDB2B001B_var*
begin
//#UC START# *53EB17EF0306_497DDB2B001B_impl*
 Result := NoMoreThanOneSelected AND (not IsListEmpty);
//#UC END# *53EB17EF0306_497DDB2B001B_impl*
end;//TPrimListForm.NeedMakeHyperlinkToDocument

{$If not defined(NoVCM)}
function TPrimListForm.IsAcceptable(aDataUpdate: Boolean): Boolean;
//#UC START# *55127A5401DE_497DDB2B001B_var*
//#UC END# *55127A5401DE_497DDB2B001B_var*
begin
//#UC START# *55127A5401DE_497DDB2B001B_impl*
 case UserType of
  lftDrugList: Result := dsList.IsDataAvailable;
 else
  Result := True;
 end;
//#UC END# *55127A5401DE_497DDB2B001B_impl*
end;//TPrimListForm.IsAcceptable
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimListForm.NeedLoadFormStateForClone(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
//#UC START# *561CB1350027_497DDB2B001B_var*
//#UC END# *561CB1350027_497DDB2B001B_var*
begin
//#UC START# *561CB1350027_497DDB2B001B_impl*
 Result := False;
//#UC END# *561CB1350027_497DDB2B001B_impl*
end;//TPrimListForm.NeedLoadFormStateForClone
{$IfEnd} //not NoVCM

procedure TPrimListForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsSimpleTree := nil;
  dsList := nil;
  dsDocumentList := nil;
  sdsList := nil;
  BaseSearchSupportQuery := nil;
  WarningLocker := nil;
  ucpFilters := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsSimpleTree, dsSimpleTree);
  Supports(aDsNew, IdsList, dsList);
  Supports(aDsNew, IdsDocumentList, dsDocumentList);
  aDsNew.CastUCC(IsdsList, sdsList);
  Supports(aDsNew, IucbBaseSearchSupportQuery, BaseSearchSupportQuery);
  aDsNew.CastUCC(InsWarningLocker, WarningLocker);
  aDsNew.CastUCC(IucpFilters, ucpFilters);
 end;//aDsNew = nil
end;

procedure TPrimListForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_File, nil);
  PublishFormEntity(en_Document, nil);
  PublishFormEntity(en_Loadable, nil);
  PublishFormEntity(en_Filterable, nil);
  PublishFormEntity(en_List, nil);
  PublishFormEntity(en_TimeMachine, nil);
  PublishFormEntity(en_Selection, nil);
  PublishFormEntity(en_LocalList, nil);
  PublishFormEntity(en_Filters, nil);
  PublishFormEntity(en_CRList, nil);
  MakeEntitySupportedByControl(en_Edit, tvList);
  MakeEntitySupportedByControl(en_File, tvList);
  MakeEntitySupportedByControl(en_List, tvList);
  MakeEntitySupportedByControl(en_Selection, tvList);
  MakeEntitySupportedByControl(en_LocalList, tvList);
  MakeEntitySupportedByControl(en_Document, tvList);
  PublishFormEntity(en_DocumentInList, nil);
  MakeEntitySupportedByControl(en_DocumentInList, tvList);
  PublishFormEntity(en_SelectedDocuments, nil);
  MakeEntitySupportedByControl(en_SelectedDocuments, tvList);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Copy, Edit_Copy_Execute, Edit_Copy_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_FindContext, Edit_FindContext_Execute, Edit_FindContext_Test, nil);
  {$IfEnd} //not NoVCM

  PublishOp(en_File, op_SaveToFolder, File_SaveToFolder_Execute, File_SaveToFolder_Test, nil);
  PublishOp(en_File, op_LoadFromFolder, File_LoadFromFolder_Execute, File_LoadFromFolder_Test, nil);
  PublishOp(en_Document, op_AddToControl, Document_AddToControl_Execute, Document_AddToControl_Test, Document_AddToControl_GetState);
  PublishOp(en_Document, op_GetAttributesFrmAct, Document_GetAttributesFrmAct_Execute, Document_GetAttributesFrmAct_Test, nil);
  PublishOpWithResult(en_Loadable, op_Load, Loadable_Load, nil, nil);
  PublishOp(en_Document, op_GetRelatedDocFrmAct, Document_GetRelatedDocFrmAct_Execute, Document_GetRelatedDocFrmAct_Test, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Undo, Edit_Undo_Execute, Edit_Undo_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Redo, Edit_Redo_Execute, Edit_Redo_Test, nil);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Deselect, Edit_Deselect_Execute, Edit_Deselect_Test, nil);
  {$IfEnd} //not NoVCM

  PublishOpWithResult(en_Filterable, op_Add, Filterable_Add, nil, nil);
  PublishOpWithResult(en_Filterable, op_Delete, Filterable_Delete, nil, nil);
  PublishOpWithResult(en_List, op_GetDeList, List_GetDeList, nil, nil);
  PublishOpWithResult(en_Filterable, op_ClearAll, Filterable_ClearAll, nil, nil);
  PublishOpWithResult(en_Filterable, op_Refresh, Filterable_Refresh, nil, nil);
  PublishOpWithResult(en_TimeMachine, op_TimeMachineOffAndReset, TimeMachine_TimeMachineOffAndReset, TimeMachine_TimeMachineOffAndReset_Test, nil);
  PublishOpWithResult(en_List, op_SetCurrentVisible, List_SetCurrentVisible, nil, nil);
  PublishOp(en_TimeMachine, op_TimeMachineOnOffNew, TimeMachine_TimeMachineOnOffNew_Execute, TimeMachine_TimeMachineOnOffNew_Test, TimeMachine_TimeMachineOnOffNew_GetState);
  PublishOp(en_List, op_SwitchToFullList, List_SwitchToFullList_Execute, List_SwitchToFullList_Test, nil);
  PublishOp(en_List, op_ListInfo, List_ListInfo_Execute, List_ListInfo_Test, nil);
  ShowInContextMenu(en_List, op_ListInfo, true);
  PublishOp(en_List, op_Sort, List_Sort_Execute, List_Sort_Test, nil);
  ShowInContextMenu(en_List, op_Sort, true);
  PublishOp(en_List, op_SortDirection, List_SortDirection_Execute, List_SortDirection_Test, List_SortDirection_GetState);
  ShowInContextMenu(en_List, op_SortDirection, true);
  PublishOp(en_List, op_SpecifyList, List_SpecifyList_Execute, List_SpecifyList_Test, nil);
  ShowInContextMenu(en_List, op_SpecifyList, true);
  PublishOp(en_List, op_ExportToXML, List_ExportToXML_Execute, List_ExportToXML_Test, nil);
  ShowInContextMenu(en_List, op_ExportToXML, true);
  PublishOp(en_Filters, op_FiltersList, Filters_FiltersList_Execute, Filters_FiltersList_Test, nil);
  PublishOp(en_LocalList, op_PublishSourceSearchInList, LocalList_PublishSourceSearchInList_Execute, LocalList_PublishSourceSearchInList_Test, nil);
  ShowInContextMenu(en_LocalList, op_PublishSourceSearchInList, true);
  ShowInToolbar(en_LocalList, op_PublishSourceSearchInList, true);
  PublishOp(en_LocalList, op_Open, LocalList_Open_Execute, LocalList_Open_Test, nil);
  ShowInContextMenu(en_LocalList, op_Open, false);
  PublishOp(en_LocalList, op_SearchDrugInList, LocalList_SearchDrugInList_Execute, LocalList_SearchDrugInList_Test, nil);
  ShowInContextMenu(en_LocalList, op_SearchDrugInList, true);
  ShowInToolbar(en_LocalList, op_SearchDrugInList, true);
  PublishOp(en_Document, op_GetAnnotationDocFrmAct, Document_GetAnnotationDocFrmAct_Execute, Document_GetAnnotationDocFrmAct_Test, nil);
  PublishOp(en_Document, op_SimilarDocuments, Document_SimilarDocuments_Execute, Document_SimilarDocuments_Test, nil);
  PublishOp(en_CRList, op_SetType, CRList_SetType_Execute, CRList_SetType_Test, nil, true);
  PublishOp(en_Document, op_GetGraphicImage, Document_GetGraphicImage_Execute, Document_GetGraphicImage_Test, nil);
  PublishOp(en_LocalList, op_OpenNewWindow, LocalList_OpenNewWindow_Execute, nil, nil);
  ShowInContextMenu(en_LocalList, op_OpenNewWindow, true);
  PublishOp(en_Selection, op_CopyToNewList, Selection_CopyToNewList_Execute, Selection_CopyToNewList_Test, nil);
  ShowInContextMenu(en_Selection, op_CopyToNewList, true);
  PublishOp(en_Filters, op_Clear, Filters_Clear_Execute, nil, nil);
  ShowInContextMenu(en_Filters, op_Clear, false);
  ShowInToolbar(en_Filters, op_Clear, false);
  PublishOp(en_Selection, op_Analize, Selection_Analize_Execute, Selection_Analize_Test, nil);
  PublishOp(en_LocalList, op_SearchInList, LocalList_SearchInList_Execute, LocalList_SearchInList_Test, nil);
  ShowInContextMenu(en_LocalList, op_SearchInList, true);
  ShowInToolbar(en_LocalList, op_SearchInList, true);
  PublishOp(en_Filters, op_FiltersListOpen, Filters_FiltersListOpen_Execute, Filters_FiltersListOpen_Test, nil);
  PublishOpWithResult(en_Filters, op_InternalClear, Filters_InternalClear, nil, nil);
  PublishOpWithResult(en_Filterable, op_GetListType, Filterable_GetListType, nil, nil);
  PublishOpWithResult(en_List, op_GetDsList, List_GetDsList, nil, nil);
  PublishOp(en_List, op_Analize, List_Analize_Execute, List_Analize_Test, nil);
  ShowInContextMenu(en_List, op_Analize, true);
  PublishOp(en_List, op_AnalizeList, List_AnalizeList_Execute, List_AnalizeList_Test, nil);
  PublishOp(en_List, op_SortForReminders, List_SortForReminders_Execute, List_SortForReminders_Test, nil);
  ShowInContextMenu(en_List, op_SortForReminders, true);
  ShowInToolbar(en_List, op_SortForReminders, false);
  ContextMenuWeight(en_List, op_SortForReminders, 20);
  PublishOp(en_List, op_SortDirectionForReminders, List_SortDirectionForReminders_Execute, List_SortDirectionForReminders_Test, List_SortDirectionForReminders_GetState);
  ContextMenuWeight(en_List, op_SortDirectionForReminders, 30);
  PublishOp(en_List, op_SpecifyListForReminders, List_SpecifyListForReminders_Execute, List_SpecifyListForReminders_Test, nil);
  ShowInContextMenu(en_List, op_SpecifyListForReminders, true);
  ShowInToolbar(en_List, op_SpecifyListForReminders, false);
  ContextMenuWeight(en_List, op_SpecifyListForReminders, 70);
 end;//with Entities.Entities
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_ExportToXML, false);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_ExportToXML, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_ExportToXML, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_ExportToXML, false);
 {$If not defined(NoVCM)}
 AddUserTypeExclude(lftDrugListName, en_Edit, op_FindContext, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(lftDrugListName, en_Document, op_AddToControl, false);
 AddUserTypeExclude(lftDrugListName, en_List, op_Sort, false);
 AddUserTypeExclude(lftDrugListName, en_List, op_SortDirection, false);
 AddUserTypeExclude(lftDrugListName, en_List, op_SpecifyList, false);
 AddUserTypeExclude(lftDrugListName, en_LocalList, op_PublishSourceSearchInList, false);
 AddUserTypeExclude(lftDrugListName, en_Document, op_GetAnnotationDocFrmAct, false);
 AddUserTypeExclude(lftDrugListName, en_Document, op_SimilarDocuments, false);
 AddUserTypeExclude(lftDrugListName, en_LocalList, op_SearchInList, false);
 {$If not defined(NoVCM)}
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Edit, op_FindContext, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_AddToControl, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_Sort, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_SortDirection, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_SpecifyList, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_LocalList, op_PublishSourceSearchInList, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_GetAnnotationDocFrmAct, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_SimilarDocuments, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_LocalList, op_SearchInList, false);
 {$If not defined(NoVCM)}
 AddUserTypeExclude(lftProducedDrugsName, en_Edit, op_FindContext, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_AddToControl, false);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_Sort, false);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_SortDirection, false);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_SpecifyList, false);
 AddUserTypeExclude(lftProducedDrugsName, en_LocalList, op_PublishSourceSearchInList, false);
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_GetAnnotationDocFrmAct, false);
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_SimilarDocuments, false);
 AddUserTypeExclude(lftProducedDrugsName, en_LocalList, op_SearchInList, false);
 {$If not defined(NoVCM)}
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Edit, op_FindContext, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_AddToControl, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_Sort, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_SortDirection, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_SpecifyList, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_LocalList, op_PublishSourceSearchInList, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_GetAnnotationDocFrmAct, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_SimilarDocuments, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_LocalList, op_SearchInList, false);
 {$If not defined(NoVCM)}
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Edit, op_FindContext, false);
 {$IfEnd} //not NoVCM
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_AddToControl, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_Sort, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_SortDirection, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_SpecifyList, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_LocalList, op_PublishSourceSearchInList, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_GetAnnotationDocFrmAct, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_SimilarDocuments, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_LocalList, op_SearchInList, false);
 AddUserTypeExclude(lftNoneName, en_LocalList, op_Open, false);
 AddUserTypeExclude(lftRespondentName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftCorrespondentName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftSynchroViewName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftCToPartName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftUserCR1Name, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftUserCR2Name, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftConsultationName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftDrugListName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftProducedDrugsName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftRToPartName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_TimeMachine, op_TimeMachineOffAndReset, false);
 AddUserTypeExclude(lftRespondentName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftCorrespondentName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftSynchroViewName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftCToPartName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftUserCR1Name, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftUserCR2Name, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftDrugListName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftRToPartName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_List, op_SetCurrentVisible, false);
 AddUserTypeExclude(lftRespondentName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftCorrespondentName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftSynchroViewName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftCToPartName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftUserCR1Name, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftUserCR2Name, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftConsultationName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftDrugListName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftProducedDrugsName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftRToPartName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_List, op_ListInfo, false);
 AddUserTypeExclude(lftRespondentName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftCorrespondentName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftSynchroViewName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftCToPartName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftUserCR1Name, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftUserCR2Name, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftProducedDrugsName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftRToPartName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Filters, op_FiltersListOpen, false);
 AddUserTypeExclude(lftRespondentName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftCorrespondentName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftSynchroViewName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftCToPartName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftUserCR1Name, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftUserCR2Name, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftDrugListName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftProducedDrugsName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftRToPartName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_File, op_LoadFromFolder, false);
 AddUserTypeExclude(lftRespondentName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftCorrespondentName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftSynchroViewName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftCToPartName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftUserCR1Name, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftUserCR2Name, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftProducedDrugsName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftRToPartName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Filters, op_FiltersList, false);
 AddUserTypeExclude(lftRespondentName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftCorrespondentName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftSynchroViewName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftCToPartName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftUserCR1Name, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftUserCR2Name, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftProducedDrugsName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftRToPartName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Filters, op_Clear, false);
 AddUserTypeExclude(lftRespondentName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftCorrespondentName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftSynchroViewName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftCToPartName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftUserCR1Name, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftUserCR2Name, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftProducedDrugsName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftRToPartName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Filters, op_InternalClear, false);
 AddUserTypeExclude(lftNoneName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftRespondentName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftCorrespondentName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftSynchroViewName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftCToPartName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftUserCR1Name, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftUserCR2Name, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftConsultationName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftRToPartName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_LocalList, op_SearchDrugInList, false);
 AddUserTypeExclude(lftRespondentName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftCorrespondentName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftSynchroViewName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftCToPartName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftUserCR1Name, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftUserCR2Name, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftConsultationName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftDrugListName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftProducedDrugsName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftRToPartName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Selection, op_Analize, false);
 AddUserTypeExclude(lftRespondentName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftCorrespondentName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftSynchroViewName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftCToPartName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftUserCR1Name, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftUserCR2Name, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftConsultationName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftRToPartName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Document, op_GetAttributesFrmAct, false);
 AddUserTypeExclude(lftRespondentName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftCorrespondentName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftSynchroViewName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftCToPartName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftUserCR1Name, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftUserCR2Name, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftConsultationName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftSimilarDocumentsName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftSimilarDocumentsSynchroViewName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftCorrespondentsSynchroFormName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftProducedDrugsName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftRToPartName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_Document, op_GetRelatedDocFrmAct, false);
 AddUserTypeExclude(lftNoneName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftUserCR1Name, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftUserCR2Name, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftConsultationName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftSimilarDocumentsName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftRespondentsSynchroFormName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftUserCRList1_SynchorFormName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftUserCRList2_SynchorFormName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftDrugListName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftProducedDrugsName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftProducedDrugsSynchroFormName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftDrugInternationalNameSynonymsSynchroFormName, en_CRList, op_SetType, true);
 AddUserTypeExclude(lftSimilarDocumentsToFragmentName, en_CRList, op_SetType, true);
end;

procedure TPrimListForm.MakeControls;
begin
 inherited;
 f_ListPanel := TvtPanel.Create(Self);
 f_ListPanel.Name := 'ListPanel';
 f_ListPanel.Parent := Self;
 f_tvList := TnscDocumentListTreeView.Create(Self);
 f_tvList.Name := 'tvList';
 f_tvList.Parent := ListPanel;
 f_cfList := TnscContextFilter.Create(Self);
 f_cfList.Name := 'cfList';
 f_cfList.Parent := ListPanel;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes.imp.pas}
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ListFooterCaption
 str_ListFooterCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntAAC
 str_lntAAC.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntBlock
 str_lntBlock.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntDocActive
 str_lntDocActive.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntDocPreActive
 str_lntDocPreActive.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntDocAbolished
 str_lntDocAbolished.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntRedaction
 str_lntRedaction.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntRedactions
 str_lntRedactions.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntDrugAnnuled
 str_lntDrugAnnuled.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntDrugNarcotic
 str_lntDrugNarcotic.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntDrugNoAnnuledNoNarcoric
 str_lntDrugNoAnnuledNoNarcoric.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntFormAnnuled
 str_lntFormAnnuled.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntFormRussianImportant
 str_lntFormRussianImportant.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntFormNoRussianImportant
 str_lntFormNoRussianImportant.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntFormRussianNoImportant
 str_lntFormRussianNoImportant.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_lntFormNoRussianNoImportant
 str_lntFormNoRussianNoImportant.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� PrimList
 TtfwClassRef.Register(TPrimListForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.