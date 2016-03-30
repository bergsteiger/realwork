unit ConsultingUnit;
 {* ���������� ��� ������ �� ������� �� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ConsultingUnit.pas"
// ���������: "Interfaces"
// ������� ������: "Consulting" MUID: (457007DB002E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , StartUnit
 , DynamicDocListUnit
 , FoldersUnit
 , DocumentUnit
 //#UC START# *457007DB002Eintf_uses*
 //#UC END# *457007DB002Eintf_uses*
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
  function GetValue: TEstimationValue; stdcall;
  procedure SetValue(aValue: TEstimationValue); stdcall;
  function GetText: IString; stdcall;
  procedure SetText(const aValue: IString); stdcall;
  property Value: TEstimationValue
   read GetValue
   write SetValue;
   {* ������ }
  property Text: IString
   read GetText
   write SetText;
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
  function GetStatus: TConsultationStatus; stdcall; { can raise Deleted }
  function GetId: IString; stdcall; { can raise Deleted }
  function GetCreationDate: TDateTime; stdcall; { can raise Deleted }
  function GetModificationDate: TDateTime; stdcall; { can raise Deleted }
  function GetName: IString; stdcall; { can raise Deleted }
  function GetQueryData: IString; stdcall; { can raise Deleted }
  function GetUserName: IString; stdcall; { can raise Deleted }
  function GetExpertInfo: IParasList; stdcall; { can raise Deleted }
  function GetExpertName: IString; stdcall; { can raise Deleted }
  function GetReplyDate: TDate; stdcall; { can raise Deleted }
  procedure GetType; stdcall; { can raise Deleted }
  function GetAnswer: IDocument; stdcall; { can raise Deleted, OldFormatConsultation }
   {* �������� ����������� ��� ����� �� ������ }
  function GetQuery: IDocument; stdcall; { can raise Deleted, OldFormatConsultation }
   {* �������� ������ }
  function GetDocumentList: IDynList; stdcall; { can raise NoDocumentList, Deleted, OldFormatConsultation }
   {* �������� ������ ���������� ������ }
  procedure SendEstimation(const value: IEstimation); stdcall; { can raise NoConnection, NoSubscription, Deleted }
   {* ��������� ������ }
  function CreateEstimation: IEstimation; stdcall;
   {* ������� ������ }
  procedure PaymentConfirm(answer: Boolean); stdcall; { can raise NoConnection, PaymentForbidden }
   {* ���������� (answer = true)/���������� (false) �� ������ }
  procedure Read; stdcall; { can raise Deleted }
   {* �������� ������������ ��� ����������� }
  function HasList: ByteBool; stdcall; { can raise Deleted }
  function HasEstimation: ByteBool; stdcall; { can raise Deleted }
  function HasPaymentInformation: ByteBool; stdcall; { can raise Deleted }
  function GetQueryByParas: IParasList; stdcall;
   {* �������� ������ � ���� ������ ���������� }
  function GetAnswerData(out is_evd: Boolean): IParasList; stdcall;
  property Status: TConsultationStatus
   read GetStatus;
   {* ������ ������������ }
  property Id: IString
   read GetId;
   {* ������������� ������������ }
  property CreationDate: TDateTime
   read GetCreationDate;
   {* ���� �������� }
  property ModificationDate: TDateTime
   read GetModificationDate;
   {* ���� ���������� ��������� ������� }
  property Name: IString
   read GetName;
   {* ��� ������������ (����� �������) }
  property QueryData: IString
   read GetQueryData;
  property UserName: IString
   read GetUserName;
  property ExpertInfo: IParasList
   read GetExpertInfo;
  property ExpertName: IString
   read GetExpertName;
  property ReplyDate: TDate
   read GetReplyDate;
  property Type: 
   read GetType;
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
  function CheckInternetChannel: ByteBool; stdcall;
   {* �������� �������� ������ }
  function CheckConsultingAvailable: ByteBool; stdcall;
   {* �������� ����������� ���������������� ����� }
  procedure DeleteConsultation(var for_delete: IConsultation); stdcall; { can raise NotDeleted, Deleted }
   {* ������� ������������ }
  function UpdateNotReadedConsultations: Cardinal; stdcall;
   {* ���������� ���������� ������������� ������������ }
  procedure LoadFromXml(file_name: PAnsiChar); stdcall; { can raise AccessDenied, InvalidXMLType }
   {* ��������� ������������ �� ����� }
  function CantReceiveAnswer: ByteBool; stdcall;
   {* �������� � ������������� �������� ������ (true - ����� �������� ���� ��������) }
  procedure CreateQueryWithNoticeUser; stdcall;
   {* �������� ����������� ������������ � ����������� }
 end;//IConsultationManager

 IConsultingTemplateInfo = interface
  {* ���������� ��� �������� �����������. ������ � ���� ���� 2 ������� (preanswer � answer). ����� ������ ����� ��� ������������ ���������� � get_template_type }
  ['{3613E72E-8CD0-4D45-B517-BD45F9764A82}']
  function GetPreanswerTemplate: IStream; stdcall;
  function GetAnswerTemplate: IStream; stdcall;
  function GetDealerInfo: IString; stdcall;
   {* ���������� � ���������, ������� ����� ���� ����� ��� �������. ��. [$100008775] }
  function GetTemplateType(const consultation: IConsultation): TTemplateType; stdcall; { can raise Deleted }
   {* ���������� ����� ������ ����� ��� ����������� ������������ }
  function GetQueryTemplate: IStream; stdcall;
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

implementation

uses
 l3ImplUses
 //#UC START# *457007DB002Eimpl_uses*
 //#UC END# *457007DB002Eimpl_uses*
;

end.
