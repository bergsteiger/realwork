unit PrimListInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "BusinessInterfaces"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/BusinessInterfaces/PrimListInterfaces.pas"
// �����: 07.12.2009 20:20
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Core::Common::BusinessInterfaces::PrimListInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicDocListUnit,
  DynamicTreeUnit,
  l3TreeInterfaces,
  bsTypes,
  PrimPrimListInterfaces
  ;

type
 IdeDocumentList = interface(IdeList)
  {* ��������� ������ ������� � ������ �������� ����� "enList" }
   ['{8A2B09DF-1DF5-40E9-981D-44110CC01ACC}']
   function pm_GetOpenFrom: TbsListOpenFrom;
   function pm_GetIsChanged: Boolean;
   function CloneWithReplace(const aNewList: IDynList;
    const aNodeForPositioning: Il3SimpleNode): IdeDocumentList;
   property OpenFrom: TbsListOpenFrom
     read pm_GetOpenFrom;
     {* ������ ��� ������ ������ }
   property IsChanged: Boolean
     read pm_GetIsChanged;
 end;//IdeDocumentList

 IdeDocumentListCR = interface(IdeDocumentList)
  {* ������ ��� ������������� ������� ��� ���������������/������������ }
   ['{FD9E2F10-E823-4053-A72F-6D39EF7BDA6E}']
   function pm_GetListType: TlstCRType;
   function pm_GetCategory: INodeBase;
   property ListType: TlstCRType
     read pm_GetListType;
     {* ��� ������ ��������������/����������� }
   property Category: INodeBase
     read pm_GetCategory;
 end;//IdeDocumentListCR
{$IfEnd} //not Admin AND not Monitorings

implementation

end.