unit RubricatorInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Rubricator"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Rubricator/RubricatorInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 �������� ����������::Rubricator::Rubricator::RubricatorInterfaces
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
  DynamicTreeUnit,
  l3TreeInterfaces,
  MainMenuUnit
  ;

type
 InsRubricatorTree = interface(Il3SimpleTree)
   ['{10D96B1D-DD61-4441-94CF-CE8EE3C1546E}']
   function Get_RootToKeep: INodeBase;
   function Get_MenuSectionItemToKeep: ISectionItem;
   property RootToKeep: INodeBase
     read Get_RootToKeep;
   property MenuSectionItemToKeep: ISectionItem
     read Get_MenuSectionItemToKeep;
 end;//InsRubricatorTree
{$IfEnd} //not Admin AND not Monitorings

implementation

end.