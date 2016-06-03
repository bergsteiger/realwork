unit MedicInterfaces;
 {* ���������� ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\MedicInterfaces.pas"
// ���������: "ControllerInterfaces"
// ������� ������: "MedicInterfaces" MUID: (491D7C9603B2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DynamicDocListUnit
 , DynamicTreeUnit
 , l3Interfaces
 , l3Types
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypes
 , DocumentAndListInterfaces
 , TreeInterfaces
 , SimpleListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , PreviewInterfaces
 , DocumentInterfaces
 , WorkWithListInterfaces
 , WorkWithDocumentInterfaces
 , BaseDocumentWithAttributesInterfaces
 , afwInterfaces
 , PrimPrimListInterfaces
 , DocumentUnit
 , l3InternalInterfaces
 , FiltersUnit
 , nsTypesNew
 , nsTypes
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , bsTypesNew
 , nevTools
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , AdapterFacade
;

type
 IdsDrugList = interface(IdsList)
  {* ������ �������������� ����������. }
  ['{13487696-EC72-4DC3-BDB4-5F694850B5CD}']
 end;//IdsDrugList

 IdsMedicFirmList = interface(IdsSimpleTree)
  {* ������ ���� �������������� }
  ['{8FAFD273-1097-47E0-9EEC-E9D1191A268F}']
  function pm_GetCurrentCountryFilter: Il3SimpleNode;
  function pm_GetCountryFilterTree: Il3SimpleTree;
  function pm_GetCurrentContextFilter: InscContextFilterState;
  function FiltrateByCountry(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   const aFilter: Il3SimpleNode;
   out aCurrent: Integer): Il3SimpleTree;
  function MakeNewDocInfo: IdeDocInfo;
  procedure AddBookmark;
   {* �������� �������� �� ������� �������� }
  function GetNodeID(const aNode: Il3SimpleNode): Integer;
  function MakeSuperPreview(const aTree: Il3SimpleTree;
   WithTexts: Boolean = True): InsSuperComplexDocumentPreview;
   {* ������� ���������������� ������ }
  function FullName: Il3CString;
  function ExportDocuments(const aTree: Il3SimpleTree;
   aOnlySelection: Boolean;
   const aPath: Il3CString;
   aFormat: TnsFileFormat): Boolean;
   {* ��������� ���������� ��������� �� ���� � ��������� �������. ���������� ������� ����, ��� ����-�� ��������� }
  function MergeDocuments(const aTree: Il3SimpleTree;
   aOnlySelection: Boolean;
   const aFileName: Il3CString;
   aFormat: TnsFileFormat;
   NeedPrintTopic: Boolean = True): Boolean;
   {* ��������� ���������� ��������� � ���� ���� � ��������� �������. ��������, ���� �������, �� ������ "�����: <���������� ����� ���������>". ���������� ������� ����, ��� ����-�� ��������� }
  function FiltrateByContext(const aTreeSource: Il3SimpleTree;
   const aCurrentNode: Il3SimpleNode;
   const aFilter: InscContextFilterState;
   out aCurrent: Integer): Il3SimpleTree;
  property CurrentCountryFilter: Il3SimpleNode
   read pm_GetCurrentCountryFilter;
  property CountryFilterTree: Il3SimpleTree
   read pm_GetCountryFilterTree;
  property CurrentContextFilter: InscContextFilterState
   read pm_GetCurrentContextFilter;
 end;//IdsMedicFirmList

 IsdsBaseDrugDocument = interface(IsdsBaseDocumentWithAttributes)
  {* ������� ��������� ��� ������ ���������� � �������� ���������. }
  ['{90664228-FAFF-44F1-A2FC-350217546D6E}']
  function pm_GetDsDrugInternationalNameSynonims: IdsDrugList;
  function pm_GetHasDrugInternationalNameSynonims: Boolean;
  function pm_GetDsDrugInternationalNameSynonimsRef: IvcmViewAreaControllerRef;
  property dsDrugInternationalNameSynonims: IdsDrugList
   read pm_GetDsDrugInternationalNameSynonims;
   {* ������ ������ "�������� �� �������������� ��������" }
  property HasDrugInternationalNameSynonims: Boolean
   read pm_GetHasDrugInternationalNameSynonims;
   {* ���������� ��� ���� ������ ��� "������ ������ "�������� �� �������������� ��������"" }
  property dsDrugInternationalNameSynonimsRef: IvcmViewAreaControllerRef
   read pm_GetDsDrugInternationalNameSynonimsRef;
   {* ������ �� "������ ������ "�������� �� �������������� ��������"" }
 end;//IsdsBaseDrugDocument

 IdsDrugListSynchroView = interface(IdsSimpleListSynchroView)
  ['{91069BD6-0C29-49BE-8A13-81BBF0B721D8}']
  function pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
  function pm_GetHasDrugInternationalNameSynonims: Boolean;
  procedure OpenDrugInternationalNameSynonims;
   {* ��������� ViewArea "������ ������ "�������� �� �������������� ��������"" }
  property IsDrugInternationalNameSynonimsActive: Boolean
   read pm_GetIsDrugInternationalNameSynonimsActive;
   {* ���������� ��� ������� ViewArea "������ ������ "�������� �� �������������� ��������"" }
  property HasDrugInternationalNameSynonims: Boolean
   read pm_GetHasDrugInternationalNameSynonims;
   {* ���������� ��� ���� ������ ��� "������ ������ "�������� �� �������������� ��������"" }
 end;//IdsDrugListSynchroView

 IsdsMedicFirmDocumentPrim = interface(IsdsBaseDocumentWithAttributes)
  {* �������� �����-������������� }
  ['{7A977021-25D3-46BD-81C9-5B9B5423441C}']
  function pm_GetDsDrugList: IdsDrugList;
  function pm_GetDsDrugListRef: IvcmViewAreaControllerRef;
  procedure OpenDrugList;
  property dsDrugList: IdsDrugList
   read pm_GetDsDrugList;
   {* ������ ������������ ���������� }
  property dsDrugListRef: IvcmViewAreaControllerRef
   read pm_GetDsDrugListRef;
   {* ������ �� "������ ������������ ����������" }
 end;//IsdsMedicFirmDocumentPrim

 IdsMedicFirmListSynchroView = interface(IdsSimpleListSynchroView)
  ['{87707134-F8E1-4FCC-A852-F041F7903ADE}']
  function pm_GetIsDrugListActive: Boolean;
  function pm_GetHasDrugList: Boolean;
  procedure OpenDrugList;
   {* ��������� ViewArea "������ ������������ ����������" }
  property IsDrugListActive: Boolean
   read pm_GetIsDrugListActive;
   {* ���������� ��� ������� ViewArea "������ ������������ ����������" }
  property HasDrugList: Boolean
   read pm_GetHasDrugList;
   {* ���������� ��� ���� ������ ��� "������ ������������ ����������" }
 end;//IdsMedicFirmListSynchroView

 IsdsDrugDocument = interface(IsdsBaseDrugDocument)
  ['{ADAC08A5-E56C-4824-AD47-C323B95FAF42}']
  procedure OpenDrugInternationalNameSynonims;
   {* ������� ������ ��������� �� �������������� ��������. }
  function As_IucpDocumentWithContents: IucpDocumentWithContents;
   {* ����� ���������� ������ ���������� � IucpDocumentWithContents }
 end;//IsdsDrugDocument

 IdBaseDrugDocument = interface(IdBaseDocumentWithAttributes)
  {* ������ ������ �������� ��������� }
  ['{FFFCC861-301D-4047-9292-5446D66B80EA}']
  function pm_GetDsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
  function pm_GetHasDrugInternationalNameSynonims: Tl3Bool;
  procedure pm_SetHasDrugInternationalNameSynonims(aValue: Tl3Bool);
  property dsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef
   read pm_GetDsDrugInternationalNameSynonimsRef;
   {* ������ �� "������ ������ "�������� �� �������������� ��������"" }
  property HasDrugInternationalNameSynonims: Tl3Bool
   read pm_GetHasDrugInternationalNameSynonims
   write pm_SetHasDrugInternationalNameSynonims;
   {* ���� �� "������ ������ "�������� �� �������������� ��������"" }
 end;//IdBaseDrugDocument

 IdDrugDocument = interface(IdBaseDrugDocument)
  ['{2F82042B-37B4-4C38-A7FD-339389DACAE2}']
  function pm_GetContentsTree: IdeSimpleTree;
  procedure pm_SetContentsTree(const aValue: IdeSimpleTree);
  function pm_GetDsContentsRef: IvcmFormDataSourceRef;
  property ContentsTree: IdeSimpleTree
   read pm_GetContentsTree
   write pm_SetContentsTree;
  property dsContentsRef: IvcmFormDataSourceRef
   read pm_GetDsContentsRef;
   {* ������ �� "����������" }
 end;//IdDrugDocument

 TDrugList_SynchroView_Areas = (
  {* ���� ��� ��� "������ ������ "���������� ���������"" }
  sva_DrugList_SynchroView_None
   {* ���� �� ���������� }
  , sva_DrugList_SynchroView_Document
   {* ���������� �������� }
  , sva_DrugList_SynchroView_Attributes
   {* �������� ��������� }
  , sva_DrugList_SynchroView_DrugInternationalNameSynonims
   {* ������ ������ "�������� �� �������������� ��������" }
 );//TDrugList_SynchroView_Areas

 IdMedicFirmDocument = interface(IdBaseDocumentWithAttributes)
  {* ������ �������� �����-������������� }
  ['{2658E4F6-DC6A-4EAC-A340-04141AC9B7F3}']
  function pm_GetDsDrugListRef: IvcmFormDataSourceRef;
  property dsDrugListRef: IvcmFormDataSourceRef
   read pm_GetDsDrugListRef;
   {* ������ �� "������ ������������ ����������" }
 end;//IdMedicFirmDocument

 TMedicFirmList_SynchroView_Areas = (
  {* ���� ��� ��� "dsSynchroView" }
  sva_MedicFirmList_SynchroView_None
   {* ���� �� ���������� }
  , sva_MedicFirmList_SynchroView_Document
   {* ���������� �������� }
  , sva_MedicFirmList_SynchroView_Attributes
   {* �������� ��������� }
  , sva_MedicFirmList_SynchroView_DrugList
   {* ������ ������������ ���������� }
 );//TMedicFirmList_SynchroView_Areas

 IsdsMedicFirmList = interface(IsdsMedicFirmDocumentPrim)
  ['{D8FA6A6A-BDAF-491E-8DD7-FF58BB0A7834}']
  function pm_GetDsFirmList: IdsMedicFirmList;
  function pm_GetDsSynchroView: IdsMedicFirmListSynchroView;
  function pm_GetIsDocumentActive: Boolean;
  function pm_GetIsAttributesActive: Boolean;
  function pm_GetIsDrugListActive: Boolean;
  function pm_GetDsFirmListRef: IvcmViewAreaControllerRef;
  function pm_GetDsSynchroViewRef: IvcmViewAreaControllerRef;
  procedure OpenDocument;
   {* ��������� ViewArea "���������� ��������" }
  procedure OpenAttributes;
   {* ��������� ViewArea "�������� ���������" }
  procedure OpenDrugList;
   {* ��������� ViewArea "������ ������������ ����������" }
  property dsFirmList: IdsMedicFirmList
   read pm_GetDsFirmList;
  property dsSynchroView: IdsMedicFirmListSynchroView
   read pm_GetDsSynchroView;
  property IsDocumentActive: Boolean
   read pm_GetIsDocumentActive;
   {* ���������� ��� ������� ViewArea "���������� ��������" }
  property IsAttributesActive: Boolean
   read pm_GetIsAttributesActive;
   {* ���������� ��� ������� ViewArea "�������� ���������" }
  property IsDrugListActive: Boolean
   read pm_GetIsDrugListActive;
   {* ���������� ��� ������� ViewArea "������ ������������ ����������" }
  property dsFirmListRef: IvcmViewAreaControllerRef
   read pm_GetDsFirmListRef;
   {* ������ �� "" }
  property dsSynchroViewRef: IvcmViewAreaControllerRef
   read pm_GetDsSynchroViewRef;
   {* ������ �� "" }
 end;//IsdsMedicFirmList

 IsdsDrugList = interface(IsdsBaseDrugDocument)
  {* ������ ������������� ����������. }
  ['{74CACD27-B8F6-4D4D-A683-F7E57D9A3AB0}']
  function pm_GetDsBaloonWarning: IdsWarning;
  function pm_GetDsDrugList: IdsDrugList;
  function pm_GetDsSynchroView: IdsDrugListSynchroView;
  function pm_GetDsFilters: IdsFilters;
  function pm_GetDsListInfo: IdsListInfo;
  function pm_GetIsDocumentActive: Boolean;
  function pm_GetIsAttributesActive: Boolean;
  function pm_GetIsDrugInternationalNameSynonimsActive: Boolean;
  function pm_GetDsDrugListRef: IvcmViewAreaControllerRef;
  function pm_GetDsSynchroViewRef: IvcmViewAreaControllerRef;
  function pm_GetDsFiltersRef: IvcmViewAreaControllerRef;
  function pm_GetDsListInfoRef: IvcmViewAreaControllerRef;
  procedure UpdateListInfo;
   {* - �������� ���������� � ������. }
  procedure OpenDocument;
   {* ��������� ViewArea "���������� ��������" }
  procedure OpenAttributes;
   {* ��������� ViewArea "�������� ���������" }
  procedure OpenDrugInternationalNameSynonims;
   {* ��������� ViewArea "������ ������ "�������� �� �������������� ��������"" }
  function As_IucpFilters: IucpFilters;
   {* ����� ���������� ������ ���������� � IucpFilters }
  function As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
   {* ����� ���������� ������ ���������� � IucpNodeForPositioningHolder }
  function As_InsWarningGenerator: InsWarningGenerator;
   {* ����� ���������� ������ ���������� � InsWarningGenerator }
  function As_IsdsListPrim: IsdsListPrim;
   {* ����� ���������� ������ ���������� � IsdsListPrim }
  function As_IsdsListNameHolder: IsdsListNameHolder;
   {* ����� ���������� ������ ���������� � IsdsListNameHolder }
  property dsBaloonWarning: IdsWarning
   read pm_GetDsBaloonWarning;
  property dsDrugList: IdsDrugList
   read pm_GetDsDrugList;
   {* ������ ������ "������ ������������� ����������" }
  property dsSynchroView: IdsDrugListSynchroView
   read pm_GetDsSynchroView;
   {* ������ ������ "���������� ���������" }
  property dsFilters: IdsFilters
   read pm_GetDsFilters;
   {* ������ ������ "�������" }
  property dsListInfo: IdsListInfo
   read pm_GetDsListInfo;
   {* ������� � ������ }
  property IsDocumentActive: Boolean
   read pm_GetIsDocumentActive;
   {* ���������� ��� ������� ViewArea "���������� ��������" }
  property IsAttributesActive: Boolean
   read pm_GetIsAttributesActive;
   {* ���������� ��� ������� ViewArea "�������� ���������" }
  property IsDrugInternationalNameSynonimsActive: Boolean
   read pm_GetIsDrugInternationalNameSynonimsActive;
   {* ���������� ��� ������� ViewArea "������ ������ "�������� �� �������������� ��������"" }
  property dsDrugListRef: IvcmViewAreaControllerRef
   read pm_GetDsDrugListRef;
   {* ������ �� "������ ������ "������ ������������� ����������"" }
  property dsSynchroViewRef: IvcmViewAreaControllerRef
   read pm_GetDsSynchroViewRef;
   {* ������ �� "������ ������ "���������� ���������"" }
  property dsFiltersRef: IvcmViewAreaControllerRef
   read pm_GetDsFiltersRef;
   {* ������ �� "������ ������ "�������"" }
  property dsListInfoRef: IvcmViewAreaControllerRef
   read pm_GetDsListInfoRef;
   {* ������ �� "������� � ������" }
 end;//IsdsDrugList

 IsdsMedicFirmDocument = interface(IsdsMedicFirmDocumentPrim)
  ['{BD66E4DC-A91C-4A73-8894-494363727FC7}']
 end;//IsdsMedicFirmDocument

 IdeMedicFirmList = interface
  ['{3E8AFFE2-F80B-408A-9E79-A4A1546387FC}']
  function pm_GetCurrent: INodeBase;
  procedure pm_SetCurrent(const aValue: INodeBase);
  function pm_GetCountryFilterTree: Il3SimpleTree;
  procedure pm_SetCountryFilterTree(const aValue: Il3SimpleTree);
  function pm_GetCurrentCountryFilter: Il3SimpleNode;
  procedure pm_SetCurrentCountryFilter(const aValue: Il3SimpleNode);
  function As_IdeDocInfo: IdeDocInfo;
   {* ����� ���������� ������ ���������� � IdeDocInfo }
  property Current: INodeBase
   read pm_GetCurrent
   write pm_SetCurrent;
  property CountryFilterTree: Il3SimpleTree
   read pm_GetCountryFilterTree
   write pm_SetCountryFilterTree;
  property CurrentCountryFilter: Il3SimpleNode
   read pm_GetCurrentCountryFilter
   write pm_SetCurrentCountryFilter;
 end;//IdeMedicFirmList

 IdMedicFirmList = interface(IdMedicFirmDocument)
  {* ������ ������ ����-�������������� }
  ['{E631BB7C-DF43-45ED-9C6A-912E8B2D0DA5}']
  function pm_GetMedicFirmListSynchroViewForm: TMedicFirmList_SynchroView_Areas;
  procedure pm_SetMedicFirmListSynchroViewForm(aValue: TMedicFirmList_SynchroView_Areas);
  function pm_GetDsFirmListRef: IvcmFormDataSourceRef;
  function pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
  property MedicFirmList_SynchroView_Form: TMedicFirmList_SynchroView_Areas
   read pm_GetMedicFirmListSynchroViewForm
   write pm_SetMedicFirmListSynchroViewForm;
   {* ����� ����������� ��������� }
  property dsFirmListRef: IvcmFormDataSourceRef
   read pm_GetDsFirmListRef;
   {* ������ �� "dsFirmList" }
  property dsSynchroViewRef: IvcmFormDataSourceRef
   read pm_GetDsSynchroViewRef;
   {* ������ �� "dsSynchroView" }
 end;//IdMedicFirmList

 IdDrugList = interface(IdBaseDrugDocument)
  {* ������ ������ "������ ������������� ����������" }
  ['{543D1270-8FDD-4393-AD06-F20A14F61DC0}']
  function pm_GetList: IDynList;
  procedure pm_SetList(const aValue: IDynList);
  function pm_GetNodeForPositioning: Il3SimpleNode;
  procedure pm_SetNodeForPositioning(const aValue: Il3SimpleNode);
  function pm_GetDrugListSynchroViewForm: TDrugList_SynchroView_Areas;
  procedure pm_SetDrugListSynchroViewForm(aValue: TDrugList_SynchroView_Areas);
  function pm_GetDsDrugListRef: IvcmFormDataSourceRef;
  function pm_GetDsSynchroViewRef: IvcmFormDataSourceRef;
  function pm_GetDsFiltersRef: IvcmFormDataSourceRef;
  function pm_GetDsListInfoRef: IvcmFormDataSourceRef;
  property List: IDynList
   read pm_GetList
   write pm_SetList;
   {* ������ ����������. }
  property NodeForPositioning: Il3SimpleNode
   read pm_GetNodeForPositioning
   write pm_SetNodeForPositioning;
   {* - ���� ��� ���������������� � ������. }
  property DrugList_SynchroView_Form: TDrugList_SynchroView_Areas
   read pm_GetDrugListSynchroViewForm
   write pm_SetDrugListSynchroViewForm;
   {* ����� ����������� ��������� }
  property dsDrugListRef: IvcmFormDataSourceRef
   read pm_GetDsDrugListRef;
   {* ������ �� "������ ������ "������ ������������� ����������"" }
  property dsSynchroViewRef: IvcmFormDataSourceRef
   read pm_GetDsSynchroViewRef;
   {* ������ �� "������ ������ "���������� ���������"" }
  property dsFiltersRef: IvcmFormDataSourceRef
   read pm_GetDsFiltersRef;
   {* ������ �� "������ ������ "�������"" }
  property dsListInfoRef: IvcmFormDataSourceRef
   read pm_GetDsListInfoRef;
   {* ������ �� "������� � ������" }
 end;//IdDrugList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
