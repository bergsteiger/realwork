unit OldTreeInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Model"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Model/OldTreeInterfaces.pas"
// �����: 29.09.2009 19:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 ������� ����������� ���������� �������::LegalDomain::Model::OldTreeInterfaces
//
// ���������� ��� ������ �� ������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3Interfaces
  ;

type
 InsWrapperNode = interface(IUnknown)
  {* ��������� ����� ��� �������� ������� ���������� ����������� ��������� }
   ['{056B6F80-4891-4D37-AA3B-0979EC152427}']
   function pm_GetName: Tl3WString;
   procedure pm_SetName(const aValue: Tl3WString);
   function pm_GetComment: Tl3WString;
   procedure pm_SetComment(const aValue: Tl3WString);
   property Name: Tl3WString
     read pm_GetName
     write pm_SetName;
   property Comment: Tl3WString
     read pm_GetComment
     write pm_SetComment;
 end;//InsWrapperNode
{$IfEnd} //not Admin

implementation

end.