unit IntegrationProjectUnit;
 {* ����� ��� ������� ���������� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\IntegrationProjectUnit.pas"
// ���������: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
;

type
 TIntegrationType = (
  {* ��� ������� }
  IT_LISTENTRYINFO
   {* �������� }
  , IT_LIST
   {* ������ }
  , IT_QUERY
   {* ������ }
 );//TIntegrationType

 CantCreateObject = class
  {* � ���� ������������ ������ ��� ���������� ������� }
 end;//CantCreateObject

 IIntegration = interface
  {* ��������� ��� ������ � �������� ���������� }
  ['{7D2AE9F6-BB67-44E2-B9AC-705E2293178D}']
  function Get_integration_enabled: Boolean;
  function get_integration_complect_id: IString; { can raise CanNotFindData }
   {* ���������� ������������� ��������. }
  function get_object_by_xml(xml: PAnsiChar;
   out result: IUnknown): TIntegrationType; { can raise CanNotFindData, InvalidXMLType, CantCreateObject }
   {* ����� ���������� ������ �� ��������� xml-� }
  property integration_enabled: Boolean
   read Get_integration_enabled;
   {* �������� �� � ������ ����������� ��� ������� ������������ }
 end;//IIntegration

class function make: BadFactoryType;
 {* ������� }

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
 {* ������� }
var
 l_Inst : IIntegration;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
