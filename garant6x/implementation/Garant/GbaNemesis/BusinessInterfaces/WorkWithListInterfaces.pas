unit WorkWithListInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "BusinessInterfaces"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/BusinessInterfaces/WorkWithListInterfaces.pas"
// �����: 29.12.2010 17:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Core::Common::BusinessInterfaces::WorkWithListInterfaces
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
  l3Interfaces,
  l3TreeInterfaces,
  bsTypes,
  DocumentAndListInterfaces,
  SimpleListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  PrimListInterfaces,
  WorkWithDocumentInterfaces,
  DocInfoInterfaces,
  BaseDocumentWithAttributesInterfaces,
  vcmInterfaces {a}
  ;

type
 IsdsListPrim = interface(IvcmUseCaseController)
   ['{380821C8-D86F-440A-BB30-BF799B79F0D4}']
   function Get_DsListPrim: IdsList;
   property dsListPrim: IdsList
     read Get_DsListPrim;
 end;//IsdsListPrim

 IucpNodeForPositioningHolder = interface
  {* ���� ��� ���������������� � ������ }
   ['{5C4F5AC0-BBAF-41CB-B1D8-8690E32BE5CD}']
   function pm_GetNodeForPositioning: Il3SimpleNode;
   procedure ReleaseNodeForPositioning;
     {* - ���������� ���� ��� ����������������. }
   property NodeForPositioning: Il3SimpleNode
     read pm_GetNodeForPositioning;
     {* - ��������. }
 end;//IucpNodeForPositioningHolder

 IbsDataProducer = interface(IUnknown)
  {* ��������� ���������� ������. ���������� �������������� ������ �������� ���������� � ������������ ������ ��������� ���� ��� ������� � ��� ������. [$6979611] }
   ['{ECB1072E-A6E4-4493-9595-D1D8BC3C0D2A}']
   function XXXMakeData: Boolean;
     {* ���������� ��� ������� ������ � ������ ������� �����. ��������� ���������� ����� �� ���������� ������ ����� }
 end;//IbsDataProducer

 IdsListInfo = interface(IvcmViewAreaController)
   ['{612D9AC7-4D6B-4F36-8A34-17D995DCB91C}']
   function pm_GetInfo: Tl3WString;
   function pm_GetListName: Il3CString;
   function pm_GetShortListName: Il3CString;
   property Info: Tl3WString
     read pm_GetInfo;
   property ListName: Il3CString
     read pm_GetListName;
   property ShortListName: Il3CString
     read pm_GetShortListName;
 end;//IdsListInfo

 IdsListAnalize = interface(IvcmViewAreaController)
  {* [RequestLink:274825697] }
   ['{22D78E33-7726-4454-AE2B-99555B0EDCCE}']
 end;//IdsListAnalize

 IdsSynchroView = interface(IdsSimpleListSynchroViewPrim)
  {* ������ ������ ����� "fcSynchroView" }
   ['{83616EDD-4DCB-471E-AD2F-C569FD189F15}']
   function pm_GetUserCRListInfo(aId: TnsUserCRListId): IbsUserCRListInfo;
   function pm_GetIsRelatedDocActive: Boolean;
   procedure OpenRelatedDoc;
     {* ��������� ViewArea "������� � ���������" }
   function pm_GetHasRelatedDoc: Boolean;
   function pm_GetIsUserCR1Active: Boolean;
   procedure OpenUserCR1;
     {* ��������� ViewArea "��� ���������������� ���1" }
   function pm_GetHasUserCR1: Boolean;
   function pm_GetIsUserCR2Active: Boolean;
   procedure OpenUserCR2;
     {* ��������� ViewArea "��� ���������������� ���2" }
   function pm_GetHasUserCR2: Boolean;
   function pm_GetIsAnnotationActive: Boolean;
   procedure OpenAnnotation;
     {* ��������� ViewArea "��������� � ���������" }
   function pm_GetHasAnnotation: Boolean;
   function pm_GetIsSimilarDocumentsActive: Boolean;
   procedure OpenSimilarDocuments;
     {* ��������� ViewArea "��� ������� ���������" }
   function pm_GetHasSimilarDocuments: Boolean;
   property UserCRListInfo[aId: TnsUserCRListId]: IbsUserCRListInfo
     read pm_GetUserCRListInfo;
   property IsRelatedDocActive: Boolean
     read pm_GetIsRelatedDocActive;
     {* ���������� ��� ������� ViewArea "������� � ���������" }
   property HasRelatedDoc: Boolean
     read pm_GetHasRelatedDoc;
     {* ���������� ��� ���� ������ ��� "������� � ���������" }
   property IsUserCR1Active: Boolean
     read pm_GetIsUserCR1Active;
     {* ���������� ��� ������� ViewArea "��� ���������������� ���1" }
   property HasUserCR1: Boolean
     read pm_GetHasUserCR1;
     {* ���������� ��� ���� ������ ��� "��� ���������������� ���1" }
   property IsUserCR2Active: Boolean
     read pm_GetIsUserCR2Active;
     {* ���������� ��� ������� ViewArea "��� ���������������� ���2" }
   property HasUserCR2: Boolean
     read pm_GetHasUserCR2;
     {* ���������� ��� ���� ������ ��� "��� ���������������� ���2" }
   property IsAnnotationActive: Boolean
     read pm_GetIsAnnotationActive;
     {* ���������� ��� ������� ViewArea "��������� � ���������" }
   property HasAnnotation: Boolean
     read pm_GetHasAnnotation;
     {* ���������� ��� ���� ������ ��� "��������� � ���������" }
   property IsSimilarDocumentsActive: Boolean
     read pm_GetIsSimilarDocumentsActive;
     {* ���������� ��� ������� ViewArea "��� ������� ���������" }
   property HasSimilarDocuments: Boolean
     read pm_GetHasSimilarDocuments;
     {* ���������� ��� ���� ������ ��� "��� ������� ���������" }
 end;//IdsSynchroView

 TList_SynchroView_Areas = (
  {* ���� ��� ��� "��� ����������� ���������" }
   sva_List_SynchroView_None // ���� �� ����������
 , sva_List_SynchroView_Document // ���������� ��������
 , sva_List_SynchroView_RelatedDoc // ������� � ���������
 , sva_List_SynchroView_UserCR1 // ��� ���������������� ���1
 , sva_List_SynchroView_UserCR2 // ��� ���������������� ���2
 , sva_List_SynchroView_Attributes // �������� ���������
 , sva_List_SynchroView_Annotation // ��������� � ���������
 , sva_List_SynchroView_SimilarDocuments // ��� ������� ���������
 );//TList_SynchroView_Areas

 IdeDocumentListSet = interface(IdeDocumentList)
  {* ������ ��� ������������� ������ _TsdsList - ������ }
   ['{4C8F81E2-2AE2-40CB-A438-9BC463BB53CD}']
   function pm_GetListSynchroViewForm: TList_SynchroView_Areas;
   property List_SynchroView_Form: TList_SynchroView_Areas
     read pm_GetListSynchroViewForm;
     {* ����� ����������� ��������� }
 end;//IdeDocumentListSet

 IsdsListNameHolder = interface(IvcmUseCaseController)
   ['{651DD6B4-7F84-4F8A-8D58-3BB3BBCF4219}']
   function pm_GetShortListName: Il3CString;
   function pm_GetListName: Il3CString;
   property ShortListName: Il3CString
     read pm_GetShortListName;
   property ListName: Il3CString
     read pm_GetListName;
 end;//IsdsListNameHolder

 IsdsList = interface(IsdsDocInfo{, IucpFilters, IucpNodeForPositioningHolder, IbsDataProducer, InsWarningGenerator, IucpBaseSearchSupportQuery, IsdsListPrim, IsdsListNameHolder})
  {* ��������� ������ "������" }
   ['{E355CA8F-709D-46F7-AE2D-8C3FD4CB6F08}']
   function pm_GetDsBaloonWarning: IdsWarning;
   function pm_GetDsListAnalize: IdsListAnalize;
   function pm_GetDsTextBaloonWarning: IdsWarning;
   function pm_GetDsList: IdsDocumentList;
   function pm_GetdsListRef: IvcmViewAreaControllerRef;
   function pm_GetDsSynchroView: IdsSynchroView;
   function pm_GetdsSynchroViewRef: IvcmViewAreaControllerRef;
   function pm_GetDsListInfo: IdsListInfo;
   function pm_GetdsListInfoRef: IvcmViewAreaControllerRef;
   function pm_GetDsFilters: IdsFilters;
   function pm_GetdsFiltersRef: IvcmViewAreaControllerRef;
   function pm_GetHasUserCRList1: Boolean;
   function pm_GetHasUserCRList2: Boolean;
   function pm_GetHasDocument: Boolean;
   function Get_IsShortList: Boolean;
   function pm_GetIsSnippet: Boolean;
   procedure UpdateListInfo;
     {* ��������� ���������� � ������ }
   function MakeFullList(const aNodeForPositioning: Il3SimpleNode): IdeDocumentList;
   function MakeAnalizeTree: Il3SimpleTree;
   procedure ReplaceList(const aList: IDynList);
   function pm_GetIsDocumentActive: Boolean;
   procedure OpenDocument;
     {* ��������� ViewArea "���������� ��������" }
   function pm_GetIsRelatedDocActive: Boolean;
   procedure OpenRelatedDoc;
     {* ��������� ViewArea "������� � ���������" }
   function pm_GetIsUserCR1Active: Boolean;
   procedure OpenUserCR1;
     {* ��������� ViewArea "��� ���������������� ���1" }
   function pm_GetIsUserCR2Active: Boolean;
   procedure OpenUserCR2;
     {* ��������� ViewArea "��� ���������������� ���2" }
   function pm_GetIsAttributesActive: Boolean;
   procedure OpenAttributes;
     {* ��������� ViewArea "�������� ���������" }
   function pm_GetIsAnnotationActive: Boolean;
   procedure OpenAnnotation;
     {* ��������� ViewArea "��������� � ���������" }
   function pm_GetIsSimilarDocumentsActive: Boolean;
   procedure OpenSimilarDocuments;
     {* ��������� ViewArea "��� ������� ���������" }
   property dsBaloonWarning: IdsWarning
     read pm_GetDsBaloonWarning;
   property dsListAnalize: IdsListAnalize
     read pm_GetDsListAnalize;
     {* [RequestLink:274825697] }
   property dsTextBaloonWarning: IdsWarning
     read pm_GetDsTextBaloonWarning;
   property dsList: IdsDocumentList
     read pm_GetDsList;
     {* ��� ����� ������ }
   property dsListRef: IvcmViewAreaControllerRef
     read pm_GetdsListRef;
     {* ������ �� "��� ����� ������" }
   property dsSynchroView: IdsSynchroView
     read pm_GetDsSynchroView;
     {* ��� ����������� ��������� }
   property dsSynchroViewRef: IvcmViewAreaControllerRef
     read pm_GetdsSynchroViewRef;
     {* ������ �� "��� ����������� ���������" }
   property dsListInfo: IdsListInfo
     read pm_GetDsListInfo;
     {* ��� ������� � ������ }
   property dsListInfoRef: IvcmViewAreaControllerRef
     read pm_GetdsListInfoRef;
     {* ������ �� "��� ������� � ������" }
   property dsFilters: IdsFilters
     read pm_GetDsFilters;
     {* ��� ����� ������� }
   property dsFiltersRef: IvcmViewAreaControllerRef
     read pm_GetdsFiltersRef;
     {* ������ �� "��� ����� �������" }
   property HasUserCRList1: Boolean
     read pm_GetHasUserCRList1;
   property HasUserCRList2: Boolean
     read pm_GetHasUserCRList2;
   property HasDocument: Boolean
     read pm_GetHasDocument;
     {* ������ �� � ������ ������ �������� }
   property IsShortList: Boolean
     read Get_IsShortList;
   property IsSnippet: Boolean
     read pm_GetIsSnippet;
   property IsDocumentActive: Boolean
     read pm_GetIsDocumentActive;
     {* ���������� ��� ������� ViewArea "���������� ��������" }
   property IsRelatedDocActive: Boolean
     read pm_GetIsRelatedDocActive;
     {* ���������� ��� ������� ViewArea "������� � ���������" }
   property IsUserCR1Active: Boolean
     read pm_GetIsUserCR1Active;
     {* ���������� ��� ������� ViewArea "��� ���������������� ���1" }
   property IsUserCR2Active: Boolean
     read pm_GetIsUserCR2Active;
     {* ���������� ��� ������� ViewArea "��� ���������������� ���2" }
   property IsAttributesActive: Boolean
     read pm_GetIsAttributesActive;
     {* ���������� ��� ������� ViewArea "�������� ���������" }
   property IsAnnotationActive: Boolean
     read pm_GetIsAnnotationActive;
     {* ���������� ��� ������� ViewArea "��������� � ���������" }
   property IsSimilarDocumentsActive: Boolean
     read pm_GetIsSimilarDocumentsActive;
     {* ���������� ��� ������� ViewArea "��� ������� ���������" }
  // ������ �������������� � ����������� �����������
   function As_IucpFilters: IucpFilters;
   function As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
   function As_IbsDataProducer: IbsDataProducer;
   function As_InsWarningGenerator: InsWarningGenerator;
   function As_IucpBaseSearchSupportQuery: IucpBaseSearchSupportQuery;
   function As_IsdsListPrim: IsdsListPrim;
   function As_IsdsListNameHolder: IsdsListNameHolder;
 end;//IsdsList

 IdList = interface(IdDocInfo)
  {* ������ ���������� ������ }
   ['{5C7039AA-300B-4337-B6E9-C31E72B37F09}']
   function pm_GetList: IDynList;
   procedure pm_SetList(const aValue: IDynList);
   function pm_GetUseDataProducer: Boolean;
   procedure pm_SetUseDataProducer(aValue: Boolean);
   function pm_GetDisableAutoOpenAnnotation: Boolean;
   procedure pm_SetDisableAutoOpenAnnotation(aValue: Boolean);
   function pm_GetListSynchroViewForm: TList_SynchroView_Areas;
   procedure pm_SetListSynchroViewForm(aValue: TList_SynchroView_Areas);
   function pm_GetDefaultListSynchroViewForm: TList_SynchroView_Areas;
   function pm_GetDsListRef: IvcmFormDataSourceRef;
   function pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
   function pm_GetDsListInfoRef: IvcmFormDataSourceRef;
   function pm_GetDsFiltersRef: IvcmFormDataSourceRef;
   function pm_GetNodeForPositioning: Il3SimpleNode;
   procedure pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
   property List: IDynList
     read pm_GetList
     write pm_SetList;
   property UseDataProducer: Boolean
     read pm_GetUseDataProducer
     write pm_SetUseDataProducer;
   property DisableAutoOpenAnnotation: Boolean
     read pm_GetDisableAutoOpenAnnotation
     write pm_SetDisableAutoOpenAnnotation;
   property List_SynchroView_Form: TList_SynchroView_Areas
     read pm_GetListSynchroViewForm
     write pm_SetListSynchroViewForm;
     {* ����� ����������� ��������� }
   property Default_List_SynchroView_Form: TList_SynchroView_Areas
     read pm_GetDefaultListSynchroViewForm;
     {* ����� ����������� ��������� ��-��������� }
   property dsListRef: IvcmFormDataSourceRef
     read pm_GetDsListRef;
     {* ������ �� "��� ����� ������" }
   property dsSynchroViewRef: IvcmFormDataSourceRef
     read pm_GetDsSynchroViewRef;
     {* ������ �� "��� ����������� ���������" }
   property dsListInfoRef: IvcmFormDataSourceRef
     read pm_GetDsListInfoRef;
     {* ������ �� "��� ������� � ������" }
   property dsFiltersRef: IvcmFormDataSourceRef
     read pm_GetDsFiltersRef;
     {* ������ �� "��� ����� �������" }
   property NodeForPositioning: Il3SimpleNode
     read pm_GetNodeForPositioning
     write pm_SetNodeForPositioning;
     {* - ��������. }
 end;//IdList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

end.