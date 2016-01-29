unit nsQueryInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Search"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsQueryInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<InternalInterfaces::Category>> F1 ������� ����������� ���������� �������::LegalDomain::Search::nsQueryInterfaces
//
// ���������� ���������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  BaseTreeSupportUnit,
  DynamicTreeUnit,
  FiltersUnit,
  SearchUnit,
  l3Interfaces,
  nevBase
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  nevTools,
  evQueryCardInt,
  SysUtils
  ;

type
 IqaReq = interface(IqaReqPrim)
  {* ��������. }
   ['{B9BA7D8C-0C61-4A22-9EDC-B70335A54A59}']
   function CanAdd: Boolean;
     {* ��������� ����� �� �������� ��� ���� ���� � ��������� }
   function CanOpenTree: Boolean;
     {* ��������� ����� �� ������� ���� ������ ��������� }
   function GetReqAsString(const aSeparator: Il3CString): Il3CString;
   procedure Save;
     {* ��������� ������ Save }
   procedure Load;
     {* ��������� ������ Load }
   procedure CheckAttr;
     {* ��������� ������ CheckAttr }
   procedure ReqClear;
     {* ��������� ������ ReqClear }
   procedure OpenSelectWindow;
     {* ��������� ������ OpenSelectWindow }
   function IsSet(aElseDefaultValue: Boolean = False): Boolean;
     {* ���� True, �� � ���������� ����������� �������� }
   procedure MakeFieldValue;
     {* ��������� ������ MakeFieldValue }
   function GetReqAsStrings: Il3StringsEx;
   function Get_EditorReq: IevReq;
   function Get_TagCaption: Il3CString;
   function Get_TagName: Il3CString;
   function Get_Multi: Boolean;
   property EditorReq: IevReq
     read Get_EditorReq;
     {* ������ �� ���������� �������. }
   property TagCaption: Il3CString
     read Get_TagCaption;
     {* ��������� �������� (��� ����� ����� �����). }
   property TagName: Il3CString
     read Get_TagName;
   property Multi: Boolean
     read Get_Multi;
 end;//IqaReq

 IqaReqAttribute = interface(InevBase)
   ['{C11BAF96-0B89-49D1-A817-4FBAB1703FC3}']
   procedure GetAttributesFromView(const aRoot: INodeBase);
     {* ���������� ����� �������� �� ������ (������ ���� �����) � ������������� ����� � ��������� ����������� ���� }
 end;//IqaReqAttribute

 IqaDateReq = interface(InevBase)
   ['{F6258940-B98D-46CD-BCF3-0883F5AD6D75}']
   function Get_StartDate: TDateTime;
   procedure Set_StartDate(aValue: TDateTime);
   function Get_EndDate: TDateTime;
   procedure Set_EndDate(aValue: TDateTime);
   property StartDate: TDateTime
     read Get_StartDate
     write Set_StartDate;
   property EndDate: TDateTime
     read Get_EndDate
     write Set_EndDate;
 end;//IqaDateReq

 IqaDateReqDataHolder = interface(IUnknown)
   ['{ED3483B1-9004-4E27-B7E1-8201B5B6ED7E}']
   function IsStartDateEmpty: Boolean;
   function IsEndDateEmpty: Boolean;
   function Get_StartDate: TDateTime;
   procedure Set_StartDate(aValue: TDateTime);
   function Get_EndDate: TDateTime;
   procedure Set_EndDate(aValue: TDateTime);
   function Get_IsOk: Boolean;
   procedure Set_IsOk(aValue: Boolean);
   function Get_ReqCaption: Il3CString;
   property StartDate: TDateTime
     read Get_StartDate
     write Set_StartDate;
   property EndDate: TDateTime
     read Get_EndDate
     write Set_EndDate;
   property IsOk: Boolean
     read Get_IsOk
     write Set_IsOk;
   property ReqCaption: Il3CString
     read Get_ReqCaption;
 end;//IqaDateReqDataHolder

 IqaPhoneReq = interface(InevBase)
   ['{C2D7E151-6854-498E-BD1E-AF69559645B4}']
   function Get_Code: Il3CString;
   procedure Set_Code(const aValue: Il3CString);
   function Get_Number: Il3CString;
   procedure Set_Number(const aValue: Il3CString);
   property Code: Il3CString
     read Get_Code
     write Set_Code;
   property Number: Il3CString
     read Get_Number
     write Set_Number;
 end;//IqaPhoneReq

 TlgQueryType = (
  {* ��� ������� �� ����� }
   lg_qtNone // �������������� ��� �������
 , lg_qtKeyWord // �� ��������
 , lg_qtAttribute // �� ���������� (�����)
 , lg_qtPublishedSource // �� ��������� �������������
 , lg_qtPostingOrder // ����� ��������
 , lg_qtLegislationReview // ����� ����������������
 , lg_qtSendConsultation // ������ �� �������� ���������, ��� ���� ����� �� ��������������, ������ ������ �� ��������� � �������� ������
 , lg_qtBaseSearch // ������� �����
 , lg_qtInpharmSearch // �������������� ���������
 );//TlgQueryType

 IqaHistory = interface(InevBase)
  {* ��������� ������ ��� ���������� TasMgrSearch � �������. }
   ['{03B3AFE7-3939-4277-8A11-B6DE67F81E57}']
   function Get_Query: IQuery;
   procedure Set_Query(const aValue: IQuery);
   function Get_Filter: INode;
   procedure Set_Filter(const aValue: INode);
   function Get_DataReset: Boolean;
   function Get_ConsultationSended: Boolean;
   procedure Set_ConsultationSended(aValue: Boolean);
   property Query: IQuery
     read Get_Query
     write Set_Query;
   property Filter: INode
     read Get_Filter
     write Set_Filter;
   property DataReset: Boolean
     read Get_DataReset;
   property ConsultationSended: Boolean
     read Get_ConsultationSended
     write Set_ConsultationSended;
 end;//IqaHistory

 InsQueryContainer = interface(InevBase)
  {* ��������� ������� }
   ['{92581E99-13D7-4C5A-B620-A6B8DE9C471C}']
   function Get_Query: IQuery;
   procedure Set_Query(const aValue: IQuery);
   property Query: IQuery
     read Get_Query
     write Set_Query;
 end;//InsQueryContainer

(*
 MqaMorphoReq = PureMixIn
   procedure FillReqListAsString(const aList: Il3StringsEx);
 end;//MqaMorphoReq
*)

 TOnDateQuery = procedure (const aValue: IqaDateReqDataHolder) of object;

 InsQueryFormState = interface(InsQueryContainer)
   ['{641BDCBA-CAB1-4F91-BC99-64E5DAC1CAD4}']
   function Get_Tag: Il3CString;
   procedure Set_Tag(const aValue: Il3CString);
   function Get_Filter: IFilterFromQuery;
   procedure Set_Filter(const aValue: IFilterFromQuery);
   property Tag: Il3CString
     read Get_Tag
     write Set_Tag;
   property Filter: IFilterFromQuery
     read Get_Filter
     write Set_Filter;
 end;//InsQueryFormState

 EqaException = class(Exception)
 private
 // private fields
   f_ErrorControl : IevEditorControlField;
    {* ���� ��� �������� ErrorControl}
 public
 // overridden public methods
   destructor Destroy; override;
 public
 // public methods
   constructor Create(const anErrorControl: IevEditorControlField;
     const Msg: AnsiString); reintroduce;
   constructor CreateFmt(const anErrorControl: IevEditorControlField;
     const Msg: AnsiString;
     const Args: array of const);
 public
 // public properties
   property ErrorControl: IevEditorControlField
     read f_ErrorControl;
 end;//EqaException

 EqaRequiredValue = class(EqaException)
  {* �� ����� ������������ �������� }
 end;//EqaRequiredValue

 EqaDuplicateValue = class(EqaException)
  {* ������������� �������� �������� }
 end;//EqaDuplicateValue

 EqaInvalidValue = class(EqaException)
  {* �������� �������� ��������� }
 end;//EqaInvalidValue

 EqaSilentAbort = class(EqaException)
 end;//EqaSilentAbort

 EaqExceptionClass = class of EqaException;

 IqaMgrSearch = interface(InevBase)
   ['{9FE88AB2-D21E-42CF-8982-B95BBA19075B}']
   procedure FinishOpenTree(const aRoot: INodeBase;
     const aReq: IqaReq);
   procedure ReadSettings;
     {* ��������� ������ ReadSettings }
   procedure WriteSettings;
     {* ��������� ������ WriteSettings }
   procedure InitUpdate;
     {* ��������� ������ InitUpdate }
   procedure Clear;
     {* ��������� ������ Clear }
   procedure ClearContextMistakes;
     {* ��������� ������ ClearContextMistakes }
   procedure AddValue(const aView: InevView);
   procedure DeleteValue(const aView: InevView);
   procedure DeleteAll;
     {* ��������� ������ DeleteAll }
   procedure OpenSelectWindow;
     {* ��������� ������ OpenSelectWindow }
   function ChangableReq: IqaReq;
     {* ������������ �������� ��� ��������� ��������� }
   function GetName4Query: Il3CString;
     {* ���������� ��� ��� ������� }
   function GetCurrentReq: IqaReq;
     {* ���������� ������� �������� ��� �������� }
   function GetCurrentField: IevEditorControlField;
     {* ���������� ������� ������� ��� ��������� }
   procedure CreateTree(const aQueryCard: IevQueryCard);
   function Save(aIgnoreError: Boolean = False): Boolean;
   procedure Load;
     {* ��������� ������ Load }
   function IsSomeFieldFilled(aElseDefaultValue: Boolean): Boolean;
   procedure ChangeStateAll(aExpand: Boolean);
   procedure Check;
     {* ��������� ������ Check }
   procedure DateQuery(const aValue: IqaDateReq);
   procedure ModifiedChanged(aValue: Boolean);
   procedure ExecQuery;
     {* ��������� ������ ExecQuery }
   function FindAttr(const aTagName: Il3CString): IqaReq;
     {* ���������� ������� �� ����� }
   function GettingFromView: Boolean;
   procedure StartGettingFromView;
     {* ��������� ������ StartGettingFromView }
   procedure FinishGettingFromView;
     {* ��������� ������ FinishGettingFromView }
   function Get_Query: IQuery;
   procedure Set_Query(const aValue: IQuery);
   function Get_QueryType: TlgQueryType;
   function Get_IsQueryNew: Boolean;
   function Get_Modified: Boolean;
   procedure Set_Modified(aValue: Boolean);
   function Get_FromHistory: Boolean;
   procedure Set_FromHistory(aValue: Boolean);
   function Get_QueryCard: IevQueryCard;
   {$If not defined(Admin) AND not defined(Monitorings)}
   function Get_HistoryValues: IvcmStrings;
   {$IfEnd} //not Admin AND not Monitorings
   property Query: IQuery
     read Get_Query
     write Set_Query;
     {* ������. }
   property QueryType: TlgQueryType
     read Get_QueryType;
   property IsQueryNew: Boolean
     read Get_IsQueryNew;
     {* �������� �� ������ �����, �.�. �� ����������� �� ���� }
   property Modified: Boolean
     read Get_Modified
     write Set_Modified;
     {* ������� ������������� ������������� �� ������� ���������� ���������� }
   property FromHistory: Boolean
     read Get_FromHistory
     write Set_FromHistory;
   property QueryCard: IevQueryCard
     read Get_QueryCard;
     {* ������ �� ��������� ����� � ���������� }
    {$If not defined(Admin) AND not defined(Monitorings)}
   property HistoryValues: IvcmStrings
     read Get_HistoryValues;
    {$IfEnd} //not Admin AND not Monitorings
 end;//IqaMgrSearch

 IqaMorphoReq = interface(InevBase)
   ['{359454B3-855C-4E1F-BB52-DD2D62B85936}']
  // MqaMorphoReq
   procedure FillReqListAsString(const aList: Il3StringsEx);
 end;//IqaMorphoReq
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
// start class EqaException

constructor EqaException.Create(const anErrorControl: IevEditorControlField;
  const Msg: AnsiString);
//#UC START# *52330EEE0192_52330CD700F3_var*
//#UC END# *52330EEE0192_52330CD700F3_var*
begin
//#UC START# *52330EEE0192_52330CD700F3_impl*
 inherited Create(Msg);
 f_ErrorControl := anErrorControl;
//#UC END# *52330EEE0192_52330CD700F3_impl*
end;//EqaException.Create

constructor EqaException.CreateFmt(const anErrorControl: IevEditorControlField;
  const Msg: AnsiString;
  const Args: array of const);
//#UC START# *52330F130017_52330CD700F3_var*
//#UC END# *52330F130017_52330CD700F3_var*
begin
//#UC START# *52330F130017_52330CD700F3_impl*
 inherited CreateFmt(Msg, Args);
 f_ErrorControl := anErrorControl;
//#UC END# *52330F130017_52330CD700F3_impl*
end;//EqaException.CreateFmt

destructor EqaException.Destroy;
//#UC START# *48077504027E_52330CD700F3_var*
//#UC END# *48077504027E_52330CD700F3_var*
begin
//#UC START# *48077504027E_52330CD700F3_impl*
 f_ErrorControl := nil;
 inherited;
//#UC END# *48077504027E_52330CD700F3_impl*
end;//EqaException.Destroy
{$IfEnd} //not Admin

end.