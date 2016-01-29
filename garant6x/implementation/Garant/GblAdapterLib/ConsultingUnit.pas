unit ConsultingUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/ConsultingUnit.pas"
// Delphi ���������� ��� �������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Consulting
//
// ���������� ��� ������ �� ������� ��
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, StartUnit
	, DynamicDocListUnit
	, FoldersUnit
	, DocumentUnit
	//#UC START# *4423F94903C8_457007DB002E_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_457007DB002E_UNIT_FOR_Stream*
	;

type

IEstimation = interface;
{ - ��������������� �������� IEstimation. }

IParasList = interface;
{ - ��������������� �������� IParasList. }

IConsultation = interface;
{ - ��������������� �������� IConsultation. }

IConsultationManager = interface;
{ - ��������������� �������� IConsultationManager. }

IConsultingTemplateInfo = interface;
{ - ��������������� �������� IConsultingTemplateInfo. }


// ��������� ������
PEstimationValue = ^TEstimationValue;
TEstimationValue = (
	EV_UNDEFINED // ������ �� ����������
	, EV_VERY_GOOD // �����!!!
	, EV_GOOD // ������
	, EV_NORMAL // �����
	, EV_BAD // ������ �����...
);

// ��� ������ ���������� � ������
ENoDocumentList = class (Exception);

// ��� ����� � �������� ������������
ENoConnection = class (Exception);

// ��� ������� � ������� - �� �� ��������� �� ������
ENoSubscription = class (Exception);

// � ������������ ��� ���� ���������� ������������
EPaymentForbidden = class (Exception);

// ������ ������� ������������
ENotDeleted = class (Exception);

// ������������ ������� - ��� �������� ���������
EDeleted = class (Exception);

// ������������ ������� �������
EOldFormatConsultation = class (Exception);

PConsultationStatus = ^TConsultationStatus;
TConsultationStatus = Longword;

// ��� �������
PTemplateType = ^TTemplateType;
TTemplateType = (
	PREANSWER_TEMPLATE // ������ ������� �� ������
	, ANSWER_TEMPLATE // ������ ������
	, QUERY_TEMPLATE // ������ �������
);

// ������
IEstimation = interface (IInterface) ['{DD01B380-09FE-4476-8789-20B2291FE41B}']
	function DontUseMe: Pointer;
	// ����������� � ������
	procedure GetText (out aRet {: IString}); stdcall;
	procedure SetText (const aText: IString); stdcall;

	// ������
	function GetValue (): TEstimationValue; stdcall;
	procedure SetValue (aValue: TEstimationValue); stdcall;
end;

IParasList = interface(IInterface)
['{216C7CF0-D3B9-4F53-B8EF-2F43725AAC07}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - ������ ��� ������� � �������� Count. }
    procedure Clear; stdcall;
      {* �������� ������. }
    procedure Delete(anIndex: Integer); stdcall;
      {* ������� ������� �� ������� Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* ����� ��������� � ���������. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IString); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IString); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IString): Integer; stdcall;
      {* - ��������� ������� Item � �����. }
    procedure Insert(anIndex: Integer; const anItem: IString); stdcall;
      {* - ��������� ������� Item �� ������� Index. }
end;//IParasList

// ������������
IConsultation = interface (IEntityBase) ['{69D87373-CAC1-4228-9F26-4E46D2A8CBE9}']
	// ������� ������
	procedure CreateEstimation (
		out aRet {: IEstimation}
	); stdcall;

	// ���� ��������
	procedure GetCreationDate (out a: TDateTime); stdcall;

	procedure GetExpertInfo (out aRet {: IParasList}); stdcall;

	procedure GetExpertName (out aRet {: IString}); stdcall;

	// �������� ����������� ��� ����� �� ������
	procedure GetAnswer (
		out aRet {: IDocument}
	); stdcall; // can raise EDeleted, EOldFormatConsultation

	procedure GetAnswerData (
		out aIsEvd: Bytebool;
		out aRet {: IParasList}
	); stdcall;

	// �������� ������ ���������� ������
	procedure GetDocumentList (
		out aRet {: IDynList}
	); stdcall; // can raise ENoDocumentList, EDeleted, EOldFormatConsultation

	// �������� ������
	procedure GetQuery (
		out aRet {: IDocument}
	); stdcall; // can raise EDeleted, EOldFormatConsultation

	// �������� ������ � ���� ������ ����������
	procedure GetQueryByParas (
		out aRet {: IParasList}
	); stdcall;

	function HasEstimation (): Bytebool; stdcall; // can raise EDeleted

	function HasList (): Bytebool; stdcall; // can raise EDeleted

	function HasPaymentInformation (): Bytebool; stdcall; // can raise EDeleted

	// ������������� ������������
	procedure GetId (out aRet {: IString}); stdcall;

	// ���� ���������� ��������� �������
	procedure GetModificationDate (out a: TDateTime); stdcall;

	// ��� ������������ (����� �������)
	procedure GetName (out aRet {: IString}); stdcall;

	// ���������� (answer = true)/���������� (false) �� ������
	procedure PaymentConfirm (
		aAnswer: Bytebool
	); stdcall; // can raise ENoConnection, EPaymentForbidden

	procedure GetQueryData (out aRet {: IString}); stdcall;

	// �������� ������������ ��� �����������
	procedure Read (); stdcall; // can raise EDeleted

	procedure GetReplyDate (out a: TDate); stdcall;

	// ��������� ������
	procedure SendEstimation (
		const aValue: IEstimation
	); stdcall; // can raise ENoConnection, ENoSubscription, EDeleted

	// ������ ������������
	function GetStatus (): TConsultationStatus; stdcall;

	procedure GetUserName (out aRet {: IString}); stdcall;
end;

// �������� ������������
IConsultationManager = interface (IInterface) ['{713794D3-0F90-4EE5-AF5D-644D9091DA0C}']
	function DontUseMe: Pointer;
	// �������� � ������������� �������� ������ (true - ����� �������� ���� ��������)
	function CantReceiveAnswer (): Bytebool; stdcall;

	// �������� ����������� ���������������� �����
	function CheckConsultingAvailable (): Bytebool; stdcall;

	// �������� �������� ������
	function CheckInternetChannel (): Bytebool; stdcall;

	// �������� ����������� ������������ � �����������
	procedure CreateQueryWithNoticeUser (); stdcall;

	// ������� ������������
	procedure DeleteConsultation (
		const aForDelete: IConsultation
	); stdcall; // can raise ENotDeleted, EDeleted

	// ��������� ������������ �� �����
	procedure LoadFromXml (
		const aFileName: PAnsiChar
	); stdcall; // can raise EAccessDenied, EInvalidXMLType

	// ���������� ���������� ������������� ������������
	function UpdateNotReadedConsultations (): Longword; stdcall;
end;

// ���������� ��� �������� �����������. ������ � ���� ���� 2 ������� (preanswer � answer). �����
// ������ ����� ��� ������������ ���������� � get_template_type
IConsultingTemplateInfo = interface (IInterface) ['{3613E72E-8CD0-4D45-B517-BD45F9764A82}']
	function DontUseMe: Pointer;
	procedure GetAnswerTemplate (
		out aRet {: IStream}
	); stdcall;

	// ���������� � ���������, ������� ����� ���� ����� ��� �������. ��. [$100008775]
	procedure GetDealerInfo (
		out aRet {: IString}
	); stdcall;

	procedure GetPreanswerTemplate (
		out aRet {: IStream}
	); stdcall;

	// �������� ������ ��� �������
	procedure GetQueryTemplate (
		out aRet {: IStream}
	); stdcall;

	// ���������� ����� ������ ����� ��� ����������� ������������
	function GetTemplateType (
		const aConsultation: IConsultation
	): TTemplateType; stdcall; // can raise EDeleted
end;

const

 { ������� ������������ }
	CS_SENT = TConsultationStatus(1024);
 { ���������� }
	CS_PAYMENT_REQUEST = TConsultationStatus(1);
 { ������ �� ������ }
	CS_ANSWER_RECEIVED = TConsultationStatus(2);
 { ������� ����� }
	CS_READ = TConsultationStatus(4);
	CS_ESTIMATION_SENT = TConsultationStatus(8);
 { ���������� ������ }
	CS_DRAFTS = TConsultationStatus(16);
 { �������, �� �� ���������� }
	CS_PAYMENT_REFUSAL = TConsultationStatus(32);
 { ������ ��������� }
	CS_PAYMENT_CONFIRM = TConsultationStatus(64);
	CS_VALIDATION_FAILED = TConsultationStatus(128);
	CS_ANSWER_NOT_CONFIRM = TConsultationStatus(256);
	CS_READ_NOT_CONFIRM = TConsultationStatus(512);

implementation
end.