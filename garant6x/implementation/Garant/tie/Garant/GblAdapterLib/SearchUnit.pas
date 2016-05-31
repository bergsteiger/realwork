unit SearchUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SearchUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Search" MUID: (45EEAA8E034E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DynamicDocListUnit
 , FoldersUnit
 , DocumentUnit
 , DynamicTreeUnit
 , FiltersUnit
 , ProgressIndicatorSupportUnit
 , SearchDefinesUnit
 , SearchProgressIndicatorUnit
;

const
 {* ��������� ��� �������� - �121160631 }
 AT_CONSULTATION_TEXT: PAnsiChar = AT_CONSULTATION_TEXT;
 AT_LAW_SUPPORT_TEXT: PAnsiChar = AT_LAW_SUPPORT_TEXT;
 AT_TEXT: PAnsiChar = AT_TEXT;
 AT_TEXT_NAME: PAnsiChar = AT_TEXT_NAME;
 AT_TEXT_BODY: PAnsiChar = AT_TEXT_BODY;
 AT_THEMES_NAME: PAnsiChar = AT_THEMES_NAME;
 AT_CONSULTATION_DESCRIPTION: PAnsiChar = AT_CONSULTATION_DESCRIPTION;
 AT_USER_NAME: PAnsiChar = AT_USER_NAME;
 AT_EMAIL: PAnsiChar = AT_EMAIL;
 AT_PHARM_NAME: PAnsiChar = AT_PHARM_NAME;
 AT_PHARM_TEXT: PAnsiChar = AT_PHARM_TEXT;
 AT_SHORT_LIST: PAnsiChar = AT_SHORT_LIST;
 AT_USER_PHONE: PAnsiChar = AT_USER_PHONE;
 QCT_PRIME: PAnsiChar = QCT_PRIME;
  {* �������� ������ }
 QCT_ATTRIBUTE: PAnsiChar = QCT_ATTRIBUTE;
  {* �������� ��� }
 QCT_REVIEW: PAnsiChar = QCT_REVIEW;
  {* �������� ������ �� ���������� ���������������� }
 QCT_CONSULTING: PAnsiChar = QCT_CONSULTING;
  {* �������� ������� � ����������� }
 QCT_PHARM: PAnsiChar = QCT_PHARM;
  {* �������� ������� }

type
 TQueryType = (
  QT_KEYWORD
  , QT_ATTRIBUTE
  , QT_PUBLISHED_SOURCE
  , QT_COMMENTS
  , QT_REVIEW
  , QT_MAIL_LIST
  , QT_RUBRICATOR
  , QT_CONSULT
  , QT_HANDYCRAFT_CONSULT
  , QT_DETAIL
   {* ����������� ��� }
  , QT_BASE_SEARCH
   {* �������� �������� ������ }
  , QT_PHARM_SEARCH
   {* ����� � ������� }
 );//TQueryType

 TQueryTagType = (
  QTT_CONTEXT
  , QTT_NODE
  , QTT_DATE
  , QTT_PHONE_NUMBER
   {* ����� �������� }
 );//TQueryTagType

 IQueryAttribute = interface
  ['{F7B99D7B-8104-4890-A107-57D3524BDEE1}']
  function GetType: TQueryTagType; stdcall;
  procedure Clear; stdcall;
  function GetTag: TAttributeTag; stdcall;
  property Type: TQueryTagType
   read GetType;
 end;//IQueryAttribute

 TQueryLogicOperation = (
  {* ��������� ���������� �������� ��� ����������� ��������� ��������� � �������. }
  QLO_AND
   {* ���������� �. }
  , QLO_OR
   {* ���������� ���. }
  , QLO_AND_NOT
   {* �����.
������ ���������� �������� ������������ ������ ��� ��������� ������ �������� ������� - Search::get_query_forms. ��� ��������� ���� �������� �� ����� �������� QueryNode, � ��� ������������ ���� negative. }
 );//TQueryLogicOperation

 IQueryPhoneNumberAttribute = interface(IQueryAttribute)
  {* ������� ����� }
  ['{D08C1696-445B-4611-93D3-D9B172B925AB}']
  function GetPhoneNumber: IString; stdcall;
  procedure SetPhoneNumber(const aValue: IString); stdcall;
  function GetCityCode: IString; stdcall;
  procedure SetCityCode(const aValue: IString); stdcall;
  property PhoneNumber: IString
   read GetPhoneNumber
   write SetPhoneNumber;
  property CityCode: IString
   read GetCityCode
   write SetCityCode;
 end;//IQueryPhoneNumberAttribute

 TQueryNodeValue = record
  node: INodeBase;
  operation: TQueryLogicOperation;
 end;//TQueryNodeValue

 TContextValue = record
  context: IString;
  operation: TQueryLogicOperation;
 end;//TContextValue

 IContextValueList = array of TContextValue;

 TDateValue = record
  from: TDate;
  to: TDate;
  operation: TQueryLogicOperation;
 end;//TDateValue

 IDateValueList = array of TDateValue;

 IQueryDateAttribute = interface(IQueryAttribute)
  ['{3CAD67CD-205A-4E98-9240-49311D9B33D2}']
  function GetValues: IDateValueList; stdcall;
  procedure AddValue(operation: TQueryLogicOperation;
   const from: TDate;
   const to: TDate); stdcall;
  property Values: IDateValueList
   read GetValues;
 end;//IQueryDateAttribute

 INodeValueList = array of TQueryNodeValue;

 IQueryNodeAttribute = interface(IQueryAttribute)
  ['{6BD5D1EC-803B-4923-BAB6-DBBC28685620}']
  function GetValues: INodeValueList; stdcall;
  procedure AddValue(operation: TQueryLogicOperation;
   var node: INodeBase); stdcall;
  property Values: INodeValueList
   read GetValues;
 end;//IQueryNodeAttribute

 IQueryAttributeList = array of IQueryAttribute;

 IOperationList = array of TQueryLogicOperation;

 IQueryContextAttribute = interface(IQueryAttribute)
  ['{3219EAF4-9E07-4548-9955-B0B8460FB3C8}']
  function GetValues: IContextValueList; stdcall;
  procedure AddValue(operation: TQueryLogicOperation;
   var context: IString); stdcall;
  property Values: IContextValueList
   read GetValues;
 end;//IQueryContextAttribute

 IAttributeInfo = interface
  ['{866DFFF9-C146-4174-B3A8-831190DFEA4D}']
  function GetIsExist: ByteBool; stdcall;
  function GetAvailableOperations: IOperationList; stdcall;
  function GetDefaultValue: IQueryAttribute; stdcall;
   {* �������� ��������� �������� �������� }
  property IsExist: ByteBool
   read GetIsExist;
  property AvailableOperations: IOperationList
   read GetAvailableOperations;
 end;//IAttributeInfo

 IContextWordList = array of IString;
  {* ������ ���� }

 NoDefaultValue = class
  {* ��� �������� ��� �������� �� ��������� }
 end;//NoDefaultValue

 IQuery = interface(IEntityBase)
  {* ��������� �������������� ������ � ��������. ������� ����� ���������� ����������� � ����� ����������.
��������� ������ ����������� ��� ������ ����� QueryOperationNode � QueryAttributeNode, ��������������� � ���� ����������� ��������� ������. }
  ['{73F075AC-4899-45B6-8C26-44A4C1EAA2C2}']
  function GetCount: Cardinal; stdcall;
  function GetType: TQueryType; stdcall;
  function GetDate: TDate; stdcall;
  function GetAttributes: IQueryAttributeList; stdcall;
  procedure Execute(var filtrate_list: IDynList;
   var progress: IProgressIndicatorForSearch;
   out cancel_process: ICancelSearch); stdcall;
  function GetContextAttribute(tag: TAttributeTag): IQueryContextAttribute; stdcall;
  function GetNodeAttribute(tag: TAttributeTag): IQueryNodeAttribute; stdcall;
  function GetDateAttribute(tag: TAttributeTag): IQueryDateAttribute; stdcall;
  procedure Clear; stdcall;
  function AttributesByTag(tag: TAttributeTag): IQueryAttributeList; stdcall;
  function Clone: IQuery; stdcall;
  procedure SendQuery; stdcall;
   {* ��������� ������ �� ������������ }
  function GetPhoneNumberAttribute(tag: TAttributeTag): IQueryPhoneNumberAttribute; stdcall;
  procedure BuildQuery; stdcall;
  procedure SetName(var name: IString); stdcall;
  function GetName: IString; stdcall;
  function GetComment: IString; stdcall;
  procedure SetComment(var comment: IString); stdcall;
  function IsFilterQuery: ByteBool; stdcall;
   {* ������� �� ������ � ������� }
  property Count: Cardinal
   read GetCount;
   {* ���������� ��������� ���������� ��� ��������� ������. }
  property Type: TQueryType
   read GetType;
  property Date: TDate
   read GetDate;
  property Attributes: IQueryAttributeList
   read GetAttributes;
 end;//IQuery

 IQueryList = array of IQuery;
  {* ������ ��������. }

 TAttributeFilterType = (
  AFT_NONE
  , AFT_TRIM
 );//TAttributeFilterType

 ISearch = interface
  {* �����. }
  ['{E15D4E0A-900B-460A-BC2C-F35D282B3766}']
  function GetIsMorphoExist: ByteBool; stdcall;
  function CreateQuery(type: TQueryType): IQuery; stdcall;
   {* ������� ����� ��������� ������. � ��������� ��������� ������� �� ��������� ���������� �������� QueryOperationNode � ��������� LO_AND. }
  function GetAttributeInfo(tag: TAttributeTag): IAttributeInfo; stdcall;
  function GetExampleTextCount: Cardinal; stdcall;
   {* �������� ���������� �������� }
  function GetExampleText(pos: Cardinal): IString; stdcall; { can raise CanNotFindData }
   {* �������� ����� ������� �� �������� ������� pos }
  function GetDocumentsWithoutClass: IDynList; stdcall;
   {* ������ ���������� ��� ������� CLASS }
  function GetDocumentsWithoutIncluded: IDynList; stdcall;
   {* C����� ���������� � �������� vanonced � ��� ������� vincluded }
  function GetDocumentsWithoutKey: IDynList; stdcall;
   {* C����� ���������� ��� ������� key }
  function CorrectContext(const context_for_check: IContextWordList;
   for_inpharm: Boolean;
   out corrected_context: IContextWordList): IContextWordList; stdcall;
   {* ���������� ������ ����, ������� �� ������ ��������������� � ����������������� ������ }
  property IsMorphoExist: ByteBool
   read GetIsMorphoExist;
 end;//ISearch

 QueryNotExecuted = class
 end;//QueryNotExecuted

 IFullAttributeInfo = interface(IAttributeInfo)
  {* ���������� �� �������� ��� �� }
  ['{5898650D-3C1B-4820-AA3E-6C7A9809F267}']
  function GetTag: IString; stdcall;
  property Tag: IString
   read GetTag;
 end;//IFullAttributeInfo

 IAttributeList = array of IFullAttributeInfo;

 IQueryCardInfo = interface
  {* ����������, ��������� � ��������� ������� }
  ['{F9D884BA-B356-4A7C-8997-D3E74A8FB8F1}']
  function GetEvdCard: IStream; stdcall; { can raise CanNotFindData }
  class function Create; stdcall;
  function GetExistAttrs: IAttributeList; stdcall;
   {* �������� ������ ������������ ��������� ��� �� }
  property EvdCard: IStream
   read GetEvdCard;
 end;//IQueryCardInfo

 IAttributesHelper = interface
  {* ���������� �� ���������, ������� �������� �� �������� �������� }
  ['{03CD2930-3AE2-4CC9-9BE4-501A2B758C64}']
  function AttributeKWExists: ByteBool; stdcall;
  function AttributePublishSourceExists: ByteBool; stdcall;
 end;//IAttributesHelper

function Make(var node_: INodeBase;
 operation_: TQueryLogicOperation); overload; stdcall;
function Make; overload; stdcall;
 {* ����������� �� ��������� }
function Make(var context_: IString); overload; stdcall;
function Make; overload; stdcall;
 {* ����������� �� ��������� }
function Make; stdcall;
 {* ����������� �� ��������� }

implementation

uses
 l3ImplUses
;

function Make(var node_: INodeBase;
 operation_: TQueryLogicOperation);
//#UC START# *46151C4A0238_45EEE65400FB_var*
//#UC END# *46151C4A0238_45EEE65400FB_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *46151C4A0238_45EEE65400FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *46151C4A0238_45EEE65400FB_impl*
end;//Make

function Make;
 {* ����������� �� ��������� }
//#UC START# *473064CF02EE_45EEE65400FB_var*
//#UC END# *473064CF02EE_45EEE65400FB_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *473064CF02EE_45EEE65400FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *473064CF02EE_45EEE65400FB_impl*
end;//Make

function Make(var context_: IString);
//#UC START# *461A637E0017_45EEE4310209_var*
//#UC END# *461A637E0017_45EEE4310209_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *461A637E0017_45EEE4310209_impl*
 !!! Needs to be implemented !!!
//#UC END# *461A637E0017_45EEE4310209_impl*
end;//Make

function Make;
 {* ����������� �� ��������� }
//#UC START# *4730657502FD_45EEE4310209_var*
//#UC END# *4730657502FD_45EEE4310209_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4730657502FD_45EEE4310209_impl*
 !!! Needs to be implemented !!!
//#UC END# *4730657502FD_45EEE4310209_impl*
end;//Make

function Make;
 {* ����������� �� ��������� }
//#UC START# *47306DD6030D_45EEE5C6012B_var*
//#UC END# *47306DD6030D_45EEE5C6012B_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *47306DD6030D_45EEE5C6012B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47306DD6030D_45EEE5C6012B_impl*
end;//Make

end.
