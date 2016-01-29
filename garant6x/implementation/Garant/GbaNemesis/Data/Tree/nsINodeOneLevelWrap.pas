unit nsINodeOneLevelWrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// �����: ������ �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsINodeOneLevelWrap.pas"
// �����: 2004/04/20 11:08:38
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::Tree::TnsINodeOneLevelWrap
//
// ������� �������������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsINodeWrap,
  l3TreeInterfaces
  ;

type
 TnsINodeOneLevelWrap = class(TnsINodeWrap)
  {* ������� �������������� ������ }
 protected
 // overridden protected methods
   function DoGetChild: Il3SimpleNode; override;
     {* ���������� ������� ��������� ������� ������ }
   function GetHasChild: Boolean; override;
     {* ���������� ������� ����������� ���� ���� �� �������� ���� }
   function GetMaybeChild: Boolean; override;
     {* ���������� ������� ����������� ����� �� ���� ����� �������� ���� }
 end;//TnsINodeOneLevelWrap

implementation

// start class TnsINodeOneLevelWrap

function TnsINodeOneLevelWrap.DoGetChild: Il3SimpleNode;
//#UC START# *4909A13402E2_468275E600B1_var*
//#UC END# *4909A13402E2_468275E600B1_var*
begin
//#UC START# *4909A13402E2_468275E600B1_impl*
 Result := nil;
//#UC END# *4909A13402E2_468275E600B1_impl*
end;//TnsINodeOneLevelWrap.DoGetChild

function TnsINodeOneLevelWrap.GetHasChild: Boolean;
//#UC START# *4909A1790056_468275E600B1_var*
//#UC END# *4909A1790056_468275E600B1_var*
begin
//#UC START# *4909A1790056_468275E600B1_impl*
 Result := False;
//#UC END# *4909A1790056_468275E600B1_impl*
end;//TnsINodeOneLevelWrap.GetHasChild

function TnsINodeOneLevelWrap.GetMaybeChild: Boolean;
//#UC START# *4909A1AA0089_468275E600B1_var*
//#UC END# *4909A1AA0089_468275E600B1_var*
begin
//#UC START# *4909A1AA0089_468275E600B1_impl*
 Result := False;
//#UC END# *4909A1AA0089_468275E600B1_impl*
end;//TnsINodeOneLevelWrap.GetMaybeChild

end.