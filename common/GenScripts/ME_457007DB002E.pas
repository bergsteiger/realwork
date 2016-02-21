unit ConsultingUnit;
 {* ���������� ��� ������ �� ������� �� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ConsultingUnit.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DocumentUnit
 , DynamicDocListUnit
 , FoldersUnit
;

type
 TEstimationValue = (
  {* ��������� ������ }
  EV_UNDEFINED
   {* ������ �� ���������� }
  , EV_VERY_GOOD
   {* �����!!! }
  , EV_GOOD
   {* ������ }
  , EV_NORMAL
   {* ����� }
  , EV_BAD
   {* ������ �����... }
 );//TEstimationValue

 NoDocumentList = class
  {* ��� ������ ���������� � ������ }
 end;//NoDocumentList

 NoConnection = class
  {* ��� ����� � �������� ������������ }
 end;//NoConnection

 NoSubscription = class
  {* ��� ������� � ������� - �� �� ��������� �� ������ }
 end;//NoSubscription

 PaymentForbidden = class
  {* � ������������ ��� ���� ���������� ������������ }
 end;//PaymentForbidden

 NotDeleted = class
  {* ������ ������� ������������ }
 end;//NotDeleted

 Deleted = class
  {* ������������ ������� - ��� �������� ��������� }
 end;//Deleted

 IEstimation = interface
  {* ������ }
  ['{DD01B380-09FE-4476-8789-20B2291FE41B}']
  function Get_value: TEstimationValue;
  procedure Set_value(aValue: TEstimationValue);
  function Get_text: IString;
  procedure Set_text(const aValue: IString);
  property value: TEstimationValue
   read Get_value
   write Set_value;
   {* ������ }
  property text: IString
   read Get_text
   write Set_text;
   {* ����������� � ������ }
 end;//IEstimation

 OldFormatConsultation = class
  {* ������������ ������� ������� }
 end;//OldFormatConsultation

 TConsultationStatus = Cardinal;

 IParasList = array of IString;

 IConsultation = interface(IEntityBase)
  {* ������������ }
  ['{69D87373-CAC1-4228-9F26-4E46D2A8CBE9}']
  function Get_status: TConsultationStatus; { can raise Deleted }
  function Get_id: IString; { can raise Deleted }
  function Get_creation_date: TDateTime; { can raise Deleted }
  function Get_modification_date: TDateTime; { can raise Deleted }
  function Get_name: IString; { can raise Deleted }
  function Get_query_data: IString; { can raise Deleted }
  function Get_user_name: IString; { can raise Deleted }
  function Get_expert_info: IParasList; { can raise Deleted }
  function Get_expert_name: IString; { can raise Deleted }
  function Get_reply_date: TDate; { can raise Deleted }
  procedure Get_type; { can raise Deleted }
  function get_answer: IDocument; { can raise Deleted, OldFormatConsultation }
   {* �������� ����������� ��� ����� �� ������ }
  function get_query: IDocument; { can raise Deleted, OldFormatConsultation }
   {* �������� ������ }
  function get_document_list: IDynList; { can raise NoDocumentList, Deleted, OldFormatConsultation }
   {* �������� ������ ���������� ������ }
  procedure send_estimation(const value: IEstimation); { can raise NoConnection, NoSubscription, Deleted }
   {* ��������� ������ }
  function create_estimation: IEstimation;
   {* ������� ������ }
  procedure payment_confirm(answer: Boolean); { can raise NoConnection, PaymentForbidden }
   {* ���������� (answer = true)/���������� (false) �� ������ }
  procedure read; { can raise Deleted }
   {* �������� ������������ ��� ����������� }
  function has_list: Boolean; { can raise Deleted }
  function has_estimation: Boolean; { can raise Deleted }
  function has_payment_information: Boolean; { can raise Deleted }
  function get_query_by_paras: IParasList;
   {* �������� ������ � ���� ������ ���������� }
  function get_answer_data(out is_evd: Boolean): IParasList;
  property status: TConsultationStatus
   read Get_status;
   {* ������ ������������ }
  property id: IString
   read Get_id;
   {* ������������� ������������ }
  property creation_date: TDateTime
   read Get_creation_date;
   {* ���� �������� }
  property modification_date: TDateTime
   read Get_modification_date;
   {* ���� ���������� ��������� ������� }
  property name: IString
   read Get_name;
   {* ��� ������������ (����� �������) }
  property query_data: IString
   read Get_query_data;
  property user_name: IString
   read Get_user_name;
  property expert_info: IParasList
   read Get_expert_info;
  property expert_name: IString
   read Get_expert_name;
  property reply_date: TDate
   read Get_reply_date;
  property type: 
   read Get_type;
 end;//IConsultation

 TTemplateType = (
  {* ��� ������� }
  PREANSWER_TEMPLATE
   {* ������ ������� �� ������ }
  , ANSWER_TEMPLATE
   {* ������ ������ }
  , QUERY_TEMPLATE
   {* ������ ������� }
 );//TTemplateType

 IConsultationManager = interface
  {* �������� ������������ }
  ['{713794D3-0F90-4EE5-AF5D-644D9091DA0C}']
  function check_internet_channel: Boolean;
   {* �������� �������� ������ }
  function check_consulting_available: Boolean;
   {* �������� ����������� ���������������� ����� }
  procedure delete_consultation(var for_delete: IConsultation); { can raise NotDeleted, Deleted }
   {* ������� ������������ }
  function update_not_readed_consultations: Cardinal;
   {* ���������� ���������� ������������� ������������ }
  procedure load_from_xml(file_name: PAnsiChar); { can raise AccessDenied, InvalidXMLType }
   {* ��������� ������������ �� ����� }
  function cant_receive_answer: Boolean;
   {* �������� � ������������� �������� ������ (true - ����� �������� ���� ��������) }
  procedure create_query_with_notice_user;
   {* �������� ����������� ������������ � ����������� }
 end;//IConsultationManager

 IConsultingTemplateInfo = interface
  {* ���������� ��� �������� �����������. ������ � ���� ���� 2 ������� (preanswer � answer). ����� ������ ����� ��� ������������ ���������� � get_template_type }
  ['{3613E72E-8CD0-4D45-B517-BD45F9764A82}']
  function get_preanswer_template: IStream;
  function get_answer_template: IStream;
  function get_dealer_info: IString;
   {* ���������� � ���������, ������� ����� ���� ����� ��� �������. ��. [$100008775] }
  function get_template_type(const consultation: IConsultation): TTemplateType; { can raise Deleted }
   {* ���������� ����� ������ ����� ��� ����������� ������������ }
  function get_query_template: IStream;
   {* �������� ������ ��� ������� }
 end;//IConsultingTemplateInfo

const
 {* ������� ������������ }
 CS_SENT: TConsultationStatus = 1024;
  {* ���������� }
 CS_PAYMENT_REQUEST: TConsultationStatus = 1;
  {* ������ �� ������ }
 CS_ANSWER_RECEIVED: TConsultationStatus = 2;
  {* ������� ����� }
 CS_READ: TConsultationStatus = 4;
 CS_ESTIMATION_SENT: TConsultationStatus = 8;
  {* ���������� ������ }
 CS_DRAFTS: TConsultationStatus = 16;
  {* �������, �� �� ���������� }
 CS_PAYMENT_REFUSAL: TConsultationStatus = 32;
  {* ������ ��������� }
 CS_PAYMENT_CONFIRM: TConsultationStatus = 64;
 CS_VALIDATION_FAILED: TConsultationStatus = 128;
 CS_ANSWER_NOT_CONFIRM: TConsultationStatus = 256;
 CS_READ_NOT_CONFIRM: TConsultationStatus = 512;

class function make: BadFactoryType;
 {* ������� }
class function make(const server_consultation;
 var folders_node: IFoldersNode): BadFactoryType;
 {* ������� }
class function make: BadFactoryType;
 {* ������� }
class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* ������� }
var
 l_Inst : IEstimation;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make(const server_consultation;
 var folders_node: IFoldersNode): BadFactoryType;
 {* ������� }
var
 l_Inst : IConsultation;
begin
 l_Inst := Create(server_consultation, folders_node);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
 {* ������� }
var
 l_Inst : IConsultationManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

class function make: BadFactoryType;
var
 l_Inst : IConsultingTemplateInfo;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
