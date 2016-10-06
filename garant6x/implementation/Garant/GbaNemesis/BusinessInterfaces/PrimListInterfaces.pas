unit PrimListInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\BusinessInterfaces\PrimListInterfaces.pas"
// ���������: "Interfaces"
// ������� ������: "PrimListInterfaces" MUID: (4B1D394B00E5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DynamicDocListUnit
 , DynamicTreeUnit
 , l3TreeInterfaces
 , bsTypes
 , PrimPrimListInterfaces
 , FiltersUnit
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
