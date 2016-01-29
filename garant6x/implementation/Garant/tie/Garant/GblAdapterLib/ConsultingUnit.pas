unit ConsultingUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ConsultingUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Consulting
//
// ���������� ��� ������ �� ������� ��
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  BaseTypesUnit,
  StartUnit,
  DynamicDocListUnit,
  FoldersUnit,
  DocumentUnit
  ;

type
 TEstimationValue = (
  {* ��������� ������ }
   EV_UNDEFINED // ������ �� ����������
 , EV_VERY_GOOD // �����!!!
 , EV_GOOD // ������
 , EV_NORMAL // �����
 , EV_BAD // ������ �����...
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

 IEstimation = interface(IUnknown)
  {* ������ }
   ['{DD01B380-09FE-4476-8789-20B2291FE41B}']
   function GetValue: TEstimationValue; stdcall;
   procedure SetValue(aValue: TEstimationValue); stdcall;
   function GetText: IString; stdcall;
   procedure SetText(const aValue: IString); stdcall;
   property value: TEstimationValue
     read GetValue
     write SetValue;
     {* ������ }
   property text: IString
     read GetText
     write SetText;
     {* ����������� � ������ }
 end;//IEstimation

 OldFormatConsultation = class
  {* ������������ ������� ������� }
 end;//OldFormatConsultation

 TConsultationStatus = Cardinal;

 IParasList = array of IString;

const
  { ������� ������������ }
 CS_SENT : TConsultationStatus = 1024;
  { ���������� }
 CS_PAYMENT_REQUEST : TConsultationStatus = 1;
  { ������ �� ������ }
 CS_ANSWER_RECEIVED : TConsultationStatus = 2;
  { ������� ����� }
 CS_READ : TConsultationStatus = 4;
 CS_ESTIMATION_SENT : TConsultationStatus = 8;
  { ���������� ������ }
 CS_DRAFTS : TConsultationStatus = 16;
  { �������, �� �� ���������� }
 CS_PAYMENT_REFUSAL : TConsultationStatus = 32;
  { ������ ��������� }
 CS_PAYMENT_CONFIRM : TConsultationStatus = 64;
 CS_VALIDATION_FAILED : TConsultationStatus = 128;
 CS_ANSWER_NOT_CONFIRM : TConsultationStatus = 256;
 CS_READ_NOT_CONFIRM : TConsultationStatus = 512;

type
 IConsultation = interface(IEntityBase)
  {* ������������ }
   ['{69D87373-CAC1-4228-9F26-4E46D2A8CBE9}']
   function GetStatus: TConsultationStatus; stdcall;
   function GetId: IString; stdcall;
   function GetCreationDate: TDateTime; stdcall;
   function GetModificationDate: TDateTime; stdcall;
   function GetName: IString; stdcall;
   function GetQueryData: IString; stdcall;
   function GetUserName: IString; stdcall;
   function GetExpertInfo: IParasList; stdcall;
   function GetExpertName: IString; stdcall;
   function GetReplyDate: TDate; stdcall;
   function GetType: ; stdcall;
   procedure GetAnswer(out aRet {: IDocument}); stdcall; // can raise Deleted, OldFormatConsultation
     {* �������� ����������� ��� ����� �� ������ }
   procedure GetQuery(out aRet {: IDocument}); stdcall; // can raise Deleted, OldFormatConsultation
     {* �������� ������ }
   procedure GetDocumentList(out aRet {: IDynList}); stdcall; // can raise NoDocumentList, Deleted, OldFormatConsultation
     {* �������� ������ ���������� ������ }
   procedure SendEstimation(const aValue: IEstimation); stdcall; // can raise NoConnection, NoSubscription, Deleted
     {* ��������� ������ }
   procedure CreateEstimation(out aRet {: IEstimation}); stdcall;
     {* ������� ������ }
   procedure PaymentConfirm(aAnswer: Boolean); stdcall; // can raise NoConnection, PaymentForbidden
     {* ���������� (answer = true)/���������� (false) �� ������ }
   procedure Read; stdcall; // can raise Deleted
     {* �������� ������������ ��� ����������� }
   function HasList: ByteBool; stdcall; // can raise Deleted
   function HasEstimation: ByteBool; stdcall; // can raise Deleted
   function HasPaymentInformation: ByteBool; stdcall; // can raise Deleted
   procedure GetQueryByParas(out aRet {: IParasList}); stdcall;
     {* �������� ������ � ���� ������ ���������� }
   procedure GetAnswerData(out aIsEvd: Boolean; out aRet {: IParasList}); stdcall;
   property status: TConsultationStatus
     read GetStatus;
     {* ������ ������������ }
   property id: IString
     read GetId;
     {* ������������� ������������ }
   property creation_date: TDateTime
     read GetCreationDate;
     {* ���� �������� }
   property modification_date: TDateTime
     read GetModificationDate;
     {* ���� ���������� ��������� ������� }
   property name: IString
     read GetName;
     {* ��� ������������ (����� �������) }
   property query_data: IString
     read GetQueryData;
   property user_name: IString
     read GetUserName;
   property expert_info: IParasList
     read GetExpertInfo;
   property expert_name: IString
     read GetExpertName;
   property reply_date: TDate
     read GetReplyDate;
   property type: 
     read GetType;
 end;//IConsultation

 TTemplateType = (
  {* ��� ������� }
   PREANSWER_TEMPLATE // ������ ������� �� ������
 , ANSWER_TEMPLATE // ������ ������
 , QUERY_TEMPLATE // ������ �������
 );//TTemplateType

 IConsultationManager = interface(IUnknown)
  {* �������� ������������ }
   ['{713794D3-0F90-4EE5-AF5D-644D9091DA0C}']
   function CheckInternetChannel: ByteBool; stdcall;
     {* �������� �������� ������ }
   function CheckConsultingAvailable: ByteBool; stdcall;
     {* �������� ����������� ���������������� ����� }
   procedure DeleteConsultation(var aForDelete: IConsultation); stdcall; // can raise NotDeleted, Deleted
     {* ������� ������������ }
   function UpdateNotReadedConsultations: Cardinal; stdcall;
     {* ���������� ���������� ������������� ������������ }
   procedure LoadFromXml(aFileName: PAnsiChar); stdcall; // can raise AccessDenied, InvalidXMLType
     {* ��������� ������������ �� ����� }
   function CantReceiveAnswer: ByteBool; stdcall;
     {* �������� � ������������� �������� ������ (true - ����� �������� ���� ��������) }
   procedure CreateQueryWithNoticeUser; stdcall;
     {* �������� ����������� ������������ � ����������� }
 end;//IConsultationManager

 IConsultingTemplateInfo = interface(IUnknown)
  {* ���������� ��� �������� �����������. ������ � ���� ���� 2 ������� (preanswer � answer). ����� ������ ����� ��� ������������ ���������� � get_template_type }
   ['{3613E72E-8CD0-4D45-B517-BD45F9764A82}']
   procedure GetPreanswerTemplate(out aRet {: IStream}); stdcall;
   procedure GetAnswerTemplate(out aRet {: IStream}); stdcall;
   procedure GetDealerInfo(out aRet {: IString}); stdcall;
     {* ���������� � ���������, ������� ����� ���� ����� ��� �������. ��. [$100008775] }
   function GetTemplateType(const aConsultation: IConsultation): TTemplateType; stdcall; // can raise Deleted
     {* ���������� ����� ������ ����� ��� ����������� ������������ }
   procedure GetQueryTemplate(out aRet {: IStream}); stdcall;
     {* �������� ������ ��� ������� }
 end;//IConsultingTemplateInfo

//#UC START# *457007DB002Eunit_intf*
//#UC END# *457007DB002Eunit_intf*

implementation

end.