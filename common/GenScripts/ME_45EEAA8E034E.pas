unit SearchUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\SearchUnit.pas"
// ���������: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , SearchDefinesUnit
 , IOUnit
 , DynamicTreeUnit
 , BaseTypesUnit
 , DynamicDocListUnit
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
  function Get_type: TQueryTagType;
  procedure clear;
  function get_tag: TAttributeTag;
  property type: TQueryTagType
   read Get_type;
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
  function Get_phone_number: IString;
  procedure Set_phone_number(const aValue: IString);
  function Get_city_code: IString;
  procedure Set_city_code(const aValue: IString);
  property phone_number: IString
   read Get_phone_number
   write Set_phone_number;
  property city_code: IString
   read Get_city_code
   write Set_city_code;
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
  function Get_values: IDateValueList;
  procedure add_value(operation: TQueryLogicOperation;
   const from: TDate;
   const to: TDate);
  property values: IDateValueList
   read Get_values;
 end;//IQueryDateAttribute

 INodeValueList = array of TQueryNodeValue;

 IQueryNodeAttribute = interface(IQueryAttribute)
  ['{6BD5D1EC-803B-4923-BAB6-DBBC28685620}']
  function Get_values: INodeValueList;
  procedure add_value(operation: TQueryLogicOperation;
   var node: INodeBase);
  property values: INodeValueList
   read Get_values;
 end;//IQueryNodeAttribute

 IQueryAttributeList = array of IQueryAttribute;

 IOperationList = array of TQueryLogicOperation;

 IQueryContextAttribute = interface(IQueryAttribute)
  ['{3219EAF4-9E07-4548-9955-B0B8460FB3C8}']
  function Get_values: IContextValueList;
  procedure add_value(operation: TQueryLogicOperation;
   var context: IString);
  property values: IContextValueList
   read Get_values;
 end;//IQueryContextAttribute

 IAttributeInfo = interface
  ['{866DFFF9-C146-4174-B3A8-831190DFEA4D}']
  function Get_is_exist: Boolean;
  function Get_available_operations: IOperationList;
  function get_default_value: IQueryAttribute;
   {* �������� ��������� �������� �������� }
  property is_exist: Boolean
   read Get_is_exist;
  property available_operations: IOperationList
   read Get_available_operations;
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
  function Get_count: Cardinal;
  function Get_type: TQueryType;
  function Get_date: TDate;
  function Get_attributes: IQueryAttributeList;
  procedure execute(var filtrate_list: IDynList;
   var progress: IProgressIndicatorForSearch;
   out cancel_process: ICancelSearch);
  function get_context_attribute(tag: TAttributeTag): IQueryContextAttribute;
  function get_node_attribute(tag: TAttributeTag): IQueryNodeAttribute;
  function get_date_attribute(tag: TAttributeTag): IQueryDateAttribute;
  procedure clear;
  function attributes_by_tag(tag: TAttributeTag): IQueryAttributeList;
  function clone: IQuery;
  procedure send_query;
   {* ��������� ������ �� ������������ }
  function get_phone_number_attribute(tag: TAttributeTag): IQueryPhoneNumberAttribute;
  procedure build_query;
  procedure set_name(var name: IString);
  function get_name: IString;
  function get_comment: IString;
  procedure set_comment(var comment: IString);
  function is_filter_query: Boolean;
   {* ������� �� ������ � ������� }
  property count: Cardinal
   read Get_count;
   {* ���������� ��������� ���������� ��� ��������� ������. }
  property type: TQueryType
   read Get_type;
  property date: TDate
   read Get_date;
  property attributes: IQueryAttributeList
   read Get_attributes;
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
  function Get_is_morpho_exist: Boolean;
  function create_query(type: TQueryType): IQuery;
   {* ������� ����� ��������� ������. � ��������� ��������� ������� �� ��������� ���������� �������� QueryOperationNode � ��������� LO_AND. }
  function get_attribute_info(tag: TAttributeTag): IAttributeInfo;
  function get_example_text_count: Cardinal;
   {* �������� ���������� �������� }
  function get_example_text(pos: Cardinal): IString; { can raise CanNotFindData }
   {* �������� ����� ������� �� �������� ������� pos }
  function get_documents_without_class: IDynList;
   {* ������ ���������� ��� ������� CLASS }
  function get_documents_without_included: IDynList;
   {* C����� ���������� � �������� vanonced � ��� ������� vincluded }
  function get_documents_without_key: IDynList;
   {* C����� ���������� ��� ������� key }
  function correct_context(const context_for_check: IContextWordList;
   for_inpharm: Boolean;
   out corrected_context: IContextWordList): IContextWordList;
   {* ���������� ������ ����, ������� �� ������ ��������������� � ����������������� ������ }
  property is_morpho_exist: Boolean
   read Get_is_morpho_exist;
 end;//ISearch

 QueryNotExecuted = class
 end;//QueryNotExecuted

 IFullAttributeInfo = interface(IAttributeInfo)
  {* ���������� �� �������� ��� �� }
  ['{5898650D-3C1B-4820-AA3E-6C7A9809F267}']
  function Get_tag: IString;
  property tag: IString
   read Get_tag;
 end;//IFullAttributeInfo

 IAttributeList = array of IFullAttributeInfo;

 IQueryCardInfo = interface
  {* ����������, ��������� � ��������� ������� }
  ['{F9D884BA-B356-4A7C-8997-D3E74A8FB8F1}']
  function Get_evd_card: IStream; { can raise CanNotFindData }
  class function create: BadFactoryType;
  function get_exist_attrs: IAttributeList;
   {* �������� ������ ������������ ��������� ��� �� }
  property evd_card: IStream
   read Get_evd_card;
 end;//IQueryCardInfo

 IAttributesHelper = interface
  {* ���������� �� ���������, ������� �������� �� �������� �������� }
  ['{03CD2930-3AE2-4CC9-9BE4-501A2B758C64}']
  function attribute_KW_exists: Boolean;
  function attribute_publish_source_exists: Boolean;
 end;//IAttributesHelper

class function make(attribute_tag: TAttributeTag): BadFactoryType;
function TQueryNodeValue_make: TQueryNodeValue; overload;
function TQueryNodeValue_make: TQueryNodeValue; overload;
 {* ����������� �� ��������� }
function TContextValue_make: TContextValue; overload;
function TContextValue_make: TContextValue; overload;
 {* ����������� �� ��������� }
function TDateValue_make: TDateValue;
 {* ����������� �� ��������� }
class function make(attribute_tag: TAttributeTag): BadFactoryType;
class function make(attribute_tag: TAttributeTag): BadFactoryType;
class function make(attribute_tag: TAttributeTag): BadFactoryType;
class function make(tag: TAttributeTag): BadFactoryType;
class function make(type: TQueryType): BadFactoryType;
class function make: BadFactoryType;
class function make(full_info): BadFactoryType;
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(attribute_tag: TAttributeTag): BadFactoryType;
var
 l_Inst : IQueryPhoneNumberAttribute;
begin
 l_Inst := Create(attribute_tag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

function TQueryNodeValue_make: TQueryNodeValue;
//#UC START# *46151C4A0238_45EEE65400FB_var*
//#UC END# *46151C4A0238_45EEE65400FB_var*
begin
//#UC START# *46151C4A0238_45EEE65400FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *46151C4A0238_45EEE65400FB_impl*
end;//TQueryNodeValue_make

function TQueryNodeValue_make: TQueryNodeValue;
 {* ����������� �� ��������� }
//#UC START# *473064CF02EE_45EEE65400FB_var*
//#UC END# *473064CF02EE_45EEE65400FB_var*
begin
//#UC START# *473064CF02EE_45EEE65400FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *473064CF02EE_45EEE65400FB_impl*
end;//TQueryNodeValue_make

function TContextValue_make: TContextValue;
//#UC START# *461A637E0017_45EEE4310209_var*
//#UC END# *461A637E0017_45EEE4310209_var*
begin
//#UC START# *461A637E0017_45EEE4310209_impl*
 !!! Needs to be implemented !!!
//#UC END# *461A637E0017_45EEE4310209_impl*
end;//TContextValue_make

function TContextValue_make: TContextValue;
 {* ����������� �� ��������� }
//#UC START# *4730657502FD_45EEE4310209_var*
//#UC END# *4730657502FD_45EEE4310209_var*
begin
//#UC START# *4730657502FD_45EEE4310209_impl*
 !!! Needs to be implemented !!!
//#UC END# *4730657502FD_45EEE4310209_impl*
end;//TContextValue_make

function TDateValue_make: TDateValue;
 {* ����������� �� ��������� }
//#UC START# *47306DD6030D_45EEE5C6012B_var*
//#UC END# *47306DD6030D_45EEE5C6012B_var*
begin
//#UC START# *47306DD6030D_45EEE5C6012B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47306DD6030D_45EEE5C6012B_impl*
end;//TDateValue_make

class function make(attribute_tag: TAttributeTag): BadFactoryType;
var
 l_Inst : IQueryDateAttribute;
begin
 l_Inst := Create(attribute_tag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(attribute_tag: TAttributeTag): BadFactoryType;
var
 l_Inst : IQueryNodeAttribute;
begin
 l_Inst := Create(attribute_tag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(attribute_tag: TAttributeTag): BadFactoryType;
var
 l_Inst : IQueryContextAttribute;
begin
 l_Inst := Create(attribute_tag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(tag: TAttributeTag): BadFactoryType;
var
 l_Inst : IAttributeInfo;
begin
 l_Inst := Create(tag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(type: TQueryType): BadFactoryType;
var
 l_Inst : IQuery;
begin
 l_Inst := Create(type);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : ISearch;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(full_info): BadFactoryType;
var
 l_Inst : IFullAttributeInfo;
begin
 l_Inst := Create(full_info);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IAttributesHelper;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
