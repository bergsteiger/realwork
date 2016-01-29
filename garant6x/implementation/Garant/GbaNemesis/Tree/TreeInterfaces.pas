unit TreeInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Tree"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Tree/TreeInterfaces.pas"
// �����: 14.11.2008 22^23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 ������� ����������� ���������� �������::LegalDomain::Tree::TreeInterfaces
//
// ���������� ��� ������ � ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3InternalInterfaces,
  l3TreeInterfaces
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

(*
 InsContextFilter = PureMixIn
   function pm_GetCurrentContextFilter: InscContextFilterState;
   function FiltrateByContext(const aTreeSource: Il3SimpleTree;
    const aCurrentNode: Il3SimpleNode;
    const aFilter: InscContextFilterState;
    out aCurrent: Integer): Il3SimpleTree;
   property CurrentContextFilter: InscContextFilterState
     read pm_GetCurrentContextFilter;
 end;//InsContextFilter
*)

type
 IdsSimpleTree = interface(IvcmViewAreaController)
  {* ������ ������� ����� � �������. }
   ['{05B327B7-32D5-4BF3-A7C2-463B5813E61F}']
   function pm_GetImageList: Il3ImageList;
   function pm_GetSimpleTree: Il3SimpleTree;
   procedure pm_SetSimpleTree(const aValue: Il3SimpleTree);
   procedure CurrentChanged(const aNode: Il3SimpleNode;
    aUpdateWithDelay: Boolean = True);
     {* ��������� ������� ���� ������. �� ��������� ������� ����� �����������
           ���������� ��������, ����� �� ����������� �������� ������������� ���
           ������� �����������. ����� ������������ � ������ ��������� �������
           ���������� ���������� ����� ��������� }
   property ImageList: Il3ImageList
     read pm_GetImageList;
     {* ������ ��� ������ }
   property SimpleTree: Il3SimpleTree
     read pm_GetSimpleTree
     write pm_SetSimpleTree;
     {* ������. ������ �� readonly? }
 end;//IdsSimpleTree

implementation

end.