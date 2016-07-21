unit IntegrationProjectUnit;
 {* ����� ��� ������� ���������� }

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\IntegrationProjectUnit.pas"
// ���������: "Interfaces"
// ������� ������: "IntegrationProject" MUID: (463F4DE5003E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
  function GetIntegrationEnabled: ByteBool; stdcall;
  procedure GetIntegrationComplectId(out aRet
   {* IString }); stdcall; { can raise CanNotFindData }
   {* ���������� ������������� ��������. }
  function GetObjectByXml(xml: PAnsiChar;
   out result: IUnknown): TIntegrationType; stdcall; { can raise CanNotFindData, InvalidXMLType, CantCreateObject }
   {* ����� ���������� ������ �� ��������� xml-� }
  property IntegrationEnabled: ByteBool
   read GetIntegrationEnabled;
   {* �������� �� � ������ ����������� ��� ������� ������������ }
 end;//IIntegration

implementation

uses
 l3ImplUses
;

end.
