unit BaseTypesUnit;
 {* ������� ����, ������������ � �������� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\BaseTypesUnit.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
;

const
 {* ����� ���������, ������������ � GblAdapter }
 NODE_FLAG_STORABLE_ENTITY: Integer = 1;
  {* �����, ����������� � Node::flags. ���� BaseEntity::storable == true, �� (Node::flags AND NODE_FLAG_STORABLE_ENTITY) ���������� true }
 PROPERTY_PATH_DELIMITER: PAnsiChar = /;
  {* ������ - ����������� ������ ���� }
 DEFAULT_PRELOAD_CACHE: Cardinal = 50;
  {* ������ �� ��������� ��� ��������� ������������� ��������� ������ ���������. }
 LIBRARY_NAME: PAnsiChar = GblAdapter.dll;
  {* �������� ���������� }
 ALL_DOCUMENTS_KIND: unsigned long long = -1;

type
 TClassId = Cardinal;
  {* ������������� ������ ������� }

 TObjectId = Cardinal;
  {* ������������� ������� ������ ������ }

 TPId = record
  {* Persistent ID, ��� ��� ������������� �������� ��������. }
  class_id: TClassId;
   {* ������������� ������ }
  object_id: TObjectId;
   {* ������������� ������� }
 end;//TPId

 TDate = record
  {* ����. }
  day: unsigned short;
   {* ����� }
  month: unsigned short;
   {* ����� }
  year: unsigned short;
   {* ���. }
 //#UC START# *456EA6F00109publ*
 //#UC END# *456EA6F00109publ*
 end;//TDate

 TDateInterval = record
  {* �������� ��� (����������). }
  start: TDate;
   {* ��������� ���� }
  finish: TDate;
   {* ����������� ���� }
 end;//TDateInterval

 TTime = record
  {* ����� }
  hour: unsigned short;
   {* ���� }
  min: unsigned short;
   {* ������ }
  sec: unsigned short;
   {* ������� }
 end;//TTime

 TDateTime = record
  {* ���� � ����� }
  date: TDate;
   {* ���� }
  time: TTime;
   {* ����� }
 end;//TDateTime

 TLanguages = (
  {* ����� }
  LG_RUSSIAN
   {* ������� }
  , LG_ENGLISH
   {* ���������� }
  , LG_FRENCH
   {* ����������� }
  , LG_GERMAN
   {* �������� }
  , LG_SPANISH
   {* ��������� }
  , LG_ITALIAN
   {* ����������� }
 );//TLanguages

 INamedElement = interface
  {* ����������� �������. }
  ['{E6AAFF18-FAD7-4E46-A586-CEEC45905094}']
  function Get_name: IString;
  procedure Set_name(const aValue: IString);
  function Get_comment: IString;
  procedure Set_comment(const aValue: IString);
  property name: IString
   read Get_name
   write Set_name;
   {* ��� }
  property comment: IString
   read Get_comment
   write Set_comment;
   {* ����������� }
 end;//INamedElement

 ConstantModify = class
  {* ���������� ��������� ��� ������� �������� ����������� ���������. }
 end;//ConstantModify

 AccessDenied = class
  {* ������������ � ������ ��������� ���� �������. }
 end;//AccessDenied

 InvalidTimeStamp = class
  {* ���������� ������������ � ������ ���� ����������� �������� �� ����� ���� ��������� �� ������, �� ������� �������� ����� �������������. �������� ���������� ��������� �����. }
 end;//InvalidTimeStamp

 StorageLocked = class
  {* ���� ����������� }
 end;//StorageLocked

 Unsupported = class
  {* ������������ � ������ ���� ��������� �������� �� �������������� ��������. }
 end;//Unsupported

 NotSaved = class
  {* ������������ ��� ������� ���������/������������ ��������� � ������������� (�.� �� ����������� � ����� ��������, �������� � ������) ������� }
 end;//NotSaved

 FoldersNotAvailable = class
  {* ����� ����������.
������������ � ������, ���� � ������������ ��� ������� � ������. }
 end;//FoldersNotAvailable

 CanNotFindData = class
  {* ����������� ������ �� �������.
������������ � ������, ���� ������ ����������� �� �������� get_<something> �����������. }
 end;//CanNotFindData

 DuplicateNode = class
  {* ��������� � ������ ���������� ���� � ������, ��� ��� ���� ����� �� ����. ��� ���� ������������ ������������ ����� �����. }
 end;//DuplicateNode

 InvalidType = class
  {* ������ ��� ������ }
 end;//InvalidType

 CanNotSave = class
  {* ������ �� ����� ���� ������� }
 end;//CanNotSave

 InvalidXMLType = class
  {* ������ ��� ������� XML }
 end;//InvalidXMLType

 AllContentIsFiltered = class
  {* �� ���������� �������������, ��� ������������ ������-������ }
 end;//AllContentIsFiltered

 TCodePage = short;
  {* ����� ������� �������� }

 IEntityStorage = interface
  {* ��������� ��������� }
  ['{D4613491-81A1-4AD8-B51E-95923E4DA97A}']
  procedure get_content_type;
   {* �������� ��� ����������� }
  procedure get_cached_content;
   {* �������� ��������� }
 end;//IEntityStorage

 IEntityBase = interface
  {* ������� ����������� ��������� ��� ���������. ������ ��������� ������ �������� ����������� BaseTreeSupport::BaseEntity . }
  ['{AC2E64E2-18A5-4F4A-B16F-A186B4F6BB37}']
  function Get_is_saved: Boolean;
  function Get_is_changed: Boolean;
  function Get_eid: Cardinal; { can raise Unsupported }
  function save_to(var storage: IEntityStorage): IEntityStorage; { can raise AccessDenied, Unsupported, NotSaved, DuplicateNode, CanNotSave }
   {* ������������ �������� ������� ���������. }
  function append_to(var storage: IEntityStorage): IEntityStorage; { can raise ConstantModify, AccessDenied, Unsupported, CanNotSave }
   {* ��������� � ����  ���������� ��������� �������.
��������� � � ����� ������������ ������� }
  property is_saved: Boolean
   read Get_is_saved;
   {* ������� ���� ��� ������ ������ ��� �������� � ���� ������. ��� �� ����������� ������� ������� ���������� ������� ����� �������� (���� ����� �����). ��� �� ����������� �������� �������� save ������ ����������. }
  property is_changed: Boolean
   read Get_is_changed;
   {* �������� ����������� }
  property eid: Cardinal
   read Get_eid;
   {* ������������� }
 end;//IEntityBase

 EmptyResult = class
  {* ������������ ��� �������� �� ��������� ������ � ������, ���� ��������� ���������� ������, � ��� ���������� ������� ������������ ������. }
 end;//EmptyResult

 TItemStatus = (
  {* ������ ��������. }
  IS_ABOLISHED
   {* ������� ���� }
  , IS_ACTIVE
   {* ����������� }
  , IS_PREACTIVE
   {* �� ������� � ���� }
  , IS_UNKNOWN
   {* ����������� }
 );//TItemStatus

 TNavigatorMenuItemType = (
  {* ��������� ���� ��������� ��������� ����. }
  NM_FOLDER
   {* ������������� - �����. }
  , NM_RUBRICATOR
   {* ��������� �� ��������������. }
  , NM_ATTRIBUTE_SEARCH
   {* ����� �� ���������. }
  , NM_SITUATION_SEARCH
   {* ����� �� ��������. }
  , NM_PUBLISH_SOURCE_SEARCH
   {* ����� �� ��������� �������������. }
  , NM_SINGLE_CONTEXT_SEARCH
   {* ��������� (�������) ����� �� ���������. }
  , NM_SINGLE_ATTRIBUTE_SEARCH
   {* ��������� (�������) ����� �� ������������ ��������. }
  , NM_SINGLE_DATE_NUMBER_SEARCH
   {* ��������� (�������) ����� �� ���� � ������. }
  , NM_FILTER_5X
   {* �������� ������� �-�� ������ 5.�. }
  , NM_ATTRIBUTE_SEARCH_5X
   {* �������� ������ �� ��������� �-�� ������ 5.�. }
  , NM_SITUATION_SEARCH_5X
   {* �������� ������ �� ��������� �-�� ������ 5.�. }
  , NM_UPDATE
   {* ����������. }
  , NM_CONFIGURATION_LIST
   {* ������ ������������. }
  , NM_LIST
   {* ������. }
  , NM_COMPLECT_INFO
   {* ���������� � ���������. }
  , NM_DOCUMENT
   {* �������� }
  , NM_LAW_NAVIGATOR_FOLDER
   {* ����� "�������� ���������" }
  , NM_BUSINESS_INFO_FOLDER
   {* ����� "���������� ����������" }
  , NM_SEARCH_FOLDER
   {* ����� "�����" }
  , NM_UPDATE_FOLDER
   {* ����� "����������" }
  , NM_RECENTLY_DOCUMENTS_FOLDER
   {* ����� "��������� �������� ���������" }
  , NM_EXPLANATORY_DICTIONARY
   {* �������� ������� }
  , NM_NEW_DOCS
   {* ����� ��������� }
  , NM_PRIME_FOLDER
   {* ����� ���� ����� }
  , NM_REVIEW
   {* ����� ���� ������ ���������������� }
  , NM_NEWS_LINE
   {* ����������� }
  , NM_SEARCH_WITH_LAW_SUPPORT
   {* ����� ����: ����� � �������� ���������� }
  , NM_LAW_SUPPORT
   {* ����� ����: �������� ��������� }
  , NM_CALENDAR
  , NM_BUSINESS_REFERENCES
  , NM_HOT_INFORMATION
  , NM_CODEX
   {* ������� }
  , NM_FORMS
   {* ����� ��������� }
  , NM_MONITORINGS
   {* ����������� }
  , NM_PHARM_SEARCH
   {* ����� � ������� }
  , NM_INPHARM
   {* ������ }
  , NM_PHARM_LEK
   {* ������������� ��������� }
  , NM_PHARM_FIRMS
   {* ����� ������������� }
  , NM_PHARM_DICT
   {* ������� ����������� �������� }
  , NM_PHARM_BASIC_SECTION
   {* �������� ������� ����������� }
  , NM_TAXES_AND_FINANCE
   {* ������ � ������� }
  , NM_BUSINESS_REFERENCES_FOLDER
   {* ����� ������-������� }
  , NM_LEGAL_ISSUES
   {* ����������� ������� }
  , NM_HR
   {* �������� � ����� }
  , NM_BUDGET_ORGS
   {* ���. � ������������� ���������� }
  , NM_LAW_FOR_ALL
   {* ����� ��� ���� }
 );//TNavigatorMenuItemType

 TSearchResultType = (
  {* ��� ���������� ������ }
  SRT_DOCUMENT_LIST
   {* ������ ������ ���������� }
  , SRT_AUTOREFERAT
   {* ������ ����������� }
  , SRT_CONSULTATION
   {* ������� ������������ }
 );//TSearchResultType

 ISearchEntity = interface
  {* ��������, ������������ � ����� finish_process �� �������� ����������, ��� ��������� ������ }
  ['{8299FB1B-C061-4407-84D9-AF61A0E35754}']
  function Get_result_type: TSearchResultType;
  function Get_document_count: size;
  function Get_entry_count: size;
  function Get_edition_count: size;
  property result_type: TSearchResultType
   read Get_result_type;
   {* ��� ���������� ������ (������, �����������, ������������) }
  property document_count: size
   read Get_document_count;
   {* ���������� ��������� ���������� }
  property entry_count: size
   read Get_entry_count;
   {* ���������� ��������� }
  property edition_count: size
   read Get_edition_count;
   {* ���������� �������� }
 end;//ISearchEntity

 TSortOrder = (
  {* ����������� ����������. }
  SO_ASCENDING
   {* �� ����������� ��������. }
  , SO_DESCENDING
   {* �� �������� ��������. }
 );//TSortOrder

 TSortType = (
  {* ��� ����������. }
  ST_PRIORITY
   {* ���������� �� ����������� ���� }
  , ST_CREATE_DATE
   {* ���������� �� ���� �������� }
  , ST_LAST_EDIT_DATE
   {* ���������� �� ���� ���������� ��������� }
  , ST_NOT_SORTED
   {* �� ������������ }
  , ST_RELEVANCE
   {* ���������� �� ������������� }
 );//TSortType

 TSortParams = record
  {* ��������� ����������. }
  sort_order: TSortOrder;
   {* ������� ���������� }
  sort_type: TSortType;
   {* ��� ����������� }
 end;//TSortParams

 TTextSearchOptionType = (
  {* ���� ������ �� ��������� }
  TSO_TEXT
   {* ����� �� ������ }
  , TSO_NAME
   {* ����� �� ��������� }
  , TSO_PARA
   {* ����� �� ��������� }
  , TSO_SENTENCE
   {* ����� �� ����������� }
 );//TTextSearchOptionType

 IVariant = interface
  {* ��� ������ ��� ����������� }
  ['{0B872568-888B-4CC1-B7ED-D0E555EDA7B7}']
  function get_long: Integer; { can raise InvalidType }
   {* ������� ����� }
  function get_bool: Boolean; { can raise InvalidType }
   {* ������� ������ �������� }
  function get_string: IString; { can raise InvalidType }
   {* ������� ������ }
  function get_object: IUnknown; { can raise InvalidType }
   {* ������� ������ }
 end;//IVariant

 ILanguagesList = array of TLanguages;
  {* ������ ������ }

 IStringList = array of IString;
  {* ��������� ����� }

 InternalDatabaseError = class
  {* ��������� ��������� ������ ��� ��������� � ���� }
 end;//InternalDatabaseError

 NoSession = class
  {* ������������� �� �������, ������� ����� ��������� ������ � ��������� ������, �.�. ����� ������ }
 end;//NoSession

 DuplicateName = class
  {* ������� � ����� ������ ��� ����������, � ��� � ����� ��������� ������ }
 end;//DuplicateName

 TUid = Integer;
  {* ������������� ������������ ��� ������ }

 TListNodeType = (
  LNT_SUB
   {* ��� }
  , LNT_PARA
   {* �������� }
  , LNT_EXTERNAL_OBJECT
   {* ������, ����������� �� ������� ���������� }
  , LNT_EXTERNAL_LINK
  , LNT_DOCUMENT_ABOLISHED
   {* ���������� ���� �������� }
  , LNT_DOCUMENT_ACTIVE
   {* �������� }
  , LNT_DOCUMENT_PREACTIVE
   {* �� ���������� � ���� �������� }
  , LNT_DOCUMENT_UNKNOWN
   {* ����������� ��� }
  , LNT_EDITION_ABOLISHED
   {* ���������� ���� �������� }
  , LNT_EDITION_ACTIVE
   {* ���������� �������� }
  , LNT_EDITION_PREACTIVE
   {* ��������, ������� ��� �� ��������� }
  , LNT_EDITION_UNKNOWN
   {* ����������� ��� �������� }
  , LNT_EDITIONS_GROUP
   {* ���� �������� }
  , LNT_BLOCK
   {* ���� }
  , LNT_DRUG_ANNULED
   {* �������� ����������� }
  , LNT_DRUG_NARCOTIC
   {* ������������� �������� }
  , LNT_DRUG_NONANNULED_NONNARCOTIC
   {* ����������� ��������������� �������� }
  , LNT_FORM_ANNULED
   {* �������������� ����� ��������� }
  , LNT_FORM_RUSSIAN_IMPORTANT
   {* �������������� ���������� �������� }
  , LNT_FORM_NONRUSSIAN_IMPORTANT
   {* �������������� ����������� �������� }
  , LNT_FORM_RUSSIAN_NONIMPORTANT
   {* ���������� �������� }
  , LNT_FORM_NONRUSSIAN_NONIMPORTANT
   {* ����������� �������� }
  , LNT_FIRM
   {* ����� }
  , LNT_AAK
   {* �������� ��� }
 );//TListNodeType

 TBaseTypesObjectId = TObjectId;
  {* ��� ������ ����, �.�. ���� �������� � ������� ActiveX � ��� ObjectId � ������ Document }

function TDate_make: TDate; overload;
 {* ������� ������� ���� }
function TDate_make(y: unsigned short;
 m: unsigned short;
 d: unsigned short): TDate; overload;
 {* ������� �������� ���� }
class function make(result_type: TSearchResultType;
 document_count: size;
 entry_count: size;
 edition_count: size): BadFactoryType; overload;
 {* ������� }
class function make(const search_entity): BadFactoryType; overload;
 {* ������� }
class function make: BadFactoryType;
 {* ������� }
class function make_long(value: Integer): BadFactoryType;
 {* ������� ������ ������ ���� }
class function make_bool(value: Boolean): BadFactoryType;
 {* ������� ������ ������ bool }
class function make_string(var value: IString): BadFactoryType;
 {* ������� ������ ������ IString }
class function make_object(var value: IUnknown): BadFactoryType;
 {* ������� ������ ������ ������� }

implementation

uses
 l3ImplUses
;

function TDate_make: TDate;
 {* ������� ������� ���� }
//#UC START# *462C9BE5030D_456EA6F00109_var*
//#UC END# *462C9BE5030D_456EA6F00109_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *462C9BE5030D_456EA6F00109_impl*
 !!! Needs to be implemented !!!
//#UC END# *462C9BE5030D_456EA6F00109_impl*
end;//TDate_make

function TDate_make(y: unsigned short;
 m: unsigned short;
 d: unsigned short): TDate;
 {* ������� �������� ���� }
//#UC START# *462C9BF10128_456EA6F00109_var*
//#UC END# *462C9BF10128_456EA6F00109_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *462C9BF10128_456EA6F00109_impl*
 !!! Needs to be implemented !!!
//#UC END# *462C9BF10128_456EA6F00109_impl*
end;//TDate_make

class function make(result_type: TSearchResultType;
 document_count: size;
 entry_count: size;
 edition_count: size): BadFactoryType;
 {* ������� }
var
 l_Inst : ISearchEntity;
begin
 l_Inst := Create(result_type, document_count, entry_count, edition_count);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const search_entity): BadFactoryType;
 {* ������� }
var
 l_Inst : ISearchEntity;
begin
 l_Inst := Create(search_entity);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
 {* ������� }
var
 l_Inst : IVariant;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make_long(value: Integer): BadFactoryType;
 {* ������� ������ ������ ���� }
var
 l_Inst : IVariant;
begin
 l_Inst := Create(value);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make_long

class function make_bool(value: Boolean): BadFactoryType;
 {* ������� ������ ������ bool }
var
 l_Inst : IVariant;
begin
 l_Inst := Create(value);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make_bool

class function make_string(var value: IString): BadFactoryType;
 {* ������� ������ ������ IString }
var
 l_Inst : IVariant;
begin
 l_Inst := Create(value);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make_string

class function make_object(var value: IUnknown): BadFactoryType;
 {* ������� ������ ������ ������� }
var
 l_Inst : IVariant;
begin
 l_Inst := Create(value);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make_object

end.
