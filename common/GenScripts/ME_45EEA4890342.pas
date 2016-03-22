unit ExternalOperationUnit;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ExternalOperationUnit.pas"
// ���������: "Interfaces"
// ������� ������: "ExternalOperation" MUID: (45EEA4890342)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
;

const
 EOI_ESTIMATION: Cardinal = 1;
  {* ������� ����� }
 EOI_PAYMENT_CONFIRM: Cardinal = 2;
  {* ������������� ������ }
 EOI_PAYMENT_REFUSAL: Cardinal = 3;
  {* ������ ��������� }
 EOI_OPEN_ATTRIBUTE_CARD: Cardinal = 4;
 EOI_SHOW_HELP_TOPIC: Cardinal = 5;
 EOI_CHANGE_COLLAPSED: Cardinal = 6;
 EOI_CHECK_LEGAL_ADVISE_AVAILABLE: Cardinal = 7;
 EOI_CONSULTATION_CALL_GARANT: Cardinal = 8;
  {* ������ �� www.garant.ru � ����������� � ����������� }
 EOI_SHOW_CONSULTATION_LIST: Cardinal = 9;
  {* �������� ������ � ������������ }
 EOI_SHOW_LC_HELP: Cardinal = 10;
  {* ������ �� �������-�������� ��������� ��������� }
 EOI_CHANGES_INSIDE_TABLE: Cardinal = 11;

type
 IExternalOperation = interface
  {* ������ �� �������� }
  ['{71ECDD4A-0455-4800-BD55-7ECB739949A7}']
  function Get_id: TObjectId;
  property id: TObjectId
   read Get_id;
 end;//IExternalOperation

class function make(id: TObjectId): BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make(id: TObjectId): BadFactoryType;
var
 l_Inst : IExternalOperation;
begin
 l_Inst := Create(id);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
