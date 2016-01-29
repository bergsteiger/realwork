unit IntegrationProjectUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "GblAdapterLib"
// ������: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/IntegrationProjectUnit.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// ����� ��� ������� ����������
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
  BaseTypesUnit
  ;

type
 TIntegrationType = (
  {* ��� ������� }
   IT_LISTENTRYINFO // ��������
 , IT_LIST // ������
 , IT_QUERY // ������
 );//TIntegrationType

 CantCreateObject = class
  {* � ���� ������������ ������ ��� ���������� ������� }
 end;//CantCreateObject

 IIntegration = interface(IUnknown)
  {* ��������� ��� ������ � �������� ���������� }
   ['{7D2AE9F6-BB67-44E2-B9AC-705E2293178D}']
   function GetIntegrationEnabled: ByteBool; stdcall;
   procedure GetIntegrationComplectId(out aRet {: IString}); stdcall; // can raise CanNotFindData
     {* ���������� ������������� ��������. }
   function GetObjectByXml(aXml: PAnsiChar;
    out aResult: IUnknown): TIntegrationType; stdcall; // can raise CanNotFindData, InvalidXMLType, CantCreateObject
     {* ����� ���������� ������ �� ��������� xml-� }
   property integration_enabled: ByteBool
     read GetIntegrationEnabled;
     {* �������� �� � ������ ����������� ��� ������� ������������ }
 end;//IIntegration

implementation

end.