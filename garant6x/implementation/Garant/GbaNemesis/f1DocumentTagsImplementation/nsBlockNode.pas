unit nsBlockNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "f1DocumentTagsImplementation"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/f1DocumentTagsImplementation/nsBlockNode.pas"
// �����: 2005/06/23 16:38:20
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::f1DocumentTagsImplementation::DocumentTagNodes::TnsBlockNode
//
// ���� ���������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsBlockNodePrim,
  l3Variant
  ;

type
 TnsBlockNode = class(TnsBlockNodePrim)
  {* ���� ���������. }
 protected
 // overridden protected methods
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); override;
 end;//TnsBlockNode

implementation

uses
  k2Tags
  ;

// start class TnsBlockNode

procedure TnsBlockNode.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
  All: Boolean);
//#UC START# *49A545D501F6_467FCEA901AC_var*
//#UC END# *49A545D501F6_467FCEA901AC_var*
begin
//#UC START# *49A545D501F6_467FCEA901AC_impl*
 if not All then
  Attr[k2_tiShortName];
 inherited;
//#UC END# *49A545D501F6_467FCEA901AC_impl*
end;//TnsBlockNode.DoIterateProperties

end.