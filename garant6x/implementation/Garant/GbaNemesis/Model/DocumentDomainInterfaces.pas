unit DocumentDomainInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Model"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Model/DocumentDomainInterfaces.pas"
// �����: 10.02.2009 20:45
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 ������� ����������� ���������� �������::LegalDomain::Model::DocumentDomainInterfaces
//
// ������ � ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Interfaces
  ;

type
 InsLinkedObjectDescription = interface(IUnknown)
  {* �������� ���������� � �������� }
   ['{29FA1780-029B-4E08-B914-F0668C44ADEB}']
   function pm_GetID: Integer;
   function pm_GetName: Il3CString;
   function pm_GetShortName: Il3CString;
   property ID: Integer
     read pm_GetID;
   property Name: Il3CString
     read pm_GetName;
   property ShortName: Il3CString
     read pm_GetShortName;
 end;//InsLinkedObjectDescription

 InsLinkedObjectData = interface(IUnknown)
  {* �������� ���������� � �������� � �� ������ }
   ['{650645AC-163D-4C26-82DA-2D307EB68A9F}']
   function Get_IsPicture: Boolean;
   function pm_GetObjectTitle: Il3CString;
   function pm_GetWindowCaption: Il3CString;
   function pm_GetFileName: Il3CString;
   function pm_GetData: IStream;
   function pm_GetDescription: InsLinkedObjectDescription;
   property IsPicture: Boolean
     read Get_IsPicture;
   property ObjectTitle: Il3CString
     read pm_GetObjectTitle;
   property WindowCaption: Il3CString
     read pm_GetWindowCaption;
   property FileName: Il3CString
     read pm_GetFileName;
   property Data: IStream
     read pm_GetData;
   property Description: InsLinkedObjectDescription
     read pm_GetDescription;
 end;//InsLinkedObjectData

implementation

end.