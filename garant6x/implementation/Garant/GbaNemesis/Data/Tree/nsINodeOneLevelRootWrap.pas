unit nsINodeOneLevelRootWrap;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsINodeOneLevelRootWrap.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::Tree::TnsINodeOneLevelRootWrap
//
// ������ �������������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsINodeRootWrap,
  nsINodeWrapBase
  ;

type
 TnsINodeOneLevelRootWrap = class(TnsINodeRootWrap)
  {* ������ �������������� ������ }
 protected
 // overridden protected methods
   function GetChildNodeClass: RnsINodeWrap; override;
     {* ���������� ������� ��������� ������ ���������� ��������� ���� }
 end;//TnsINodeOneLevelRootWrap

implementation

uses
  nsINodeOneLevelWrap
  ;

// start class TnsINodeOneLevelRootWrap

function TnsINodeOneLevelRootWrap.GetChildNodeClass: RnsINodeWrap;
//#UC START# *490989330020_468275C903C6_var*
//#UC END# *490989330020_468275C903C6_var*
begin
//#UC START# *490989330020_468275C903C6_impl*
 Result := TnsINodeOneLevelWrap;
//#UC END# *490989330020_468275C903C6_impl*
end;//TnsINodeOneLevelRootWrap.GetChildNodeClass

end.