unit evdChildrenCountEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/evdChildrenCountEliminator.pas"
// �����: 29.09.2011 15:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdChildrenCountEliminator
//
// ���������� ChildrenCount �� ������ ���������, ����� �� �������������� ������ ������ ���
// ����������� �� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2TagFilter,
  l3Variant
  ;

type
 TevdChildrenCountEliminator = class(Tk2TagFilter)
  {* ���������� ChildrenCount �� ������ ���������, ����� �� �������������� ������ ������ ��� ����������� �� ������� }
 protected
 // overridden protected methods
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
 end;//TevdChildrenCountEliminator

implementation

uses
  k2Tags
  ;

// start class TevdChildrenCountEliminator

procedure TevdChildrenCountEliminator.DoAddAtomEx(AtomIndex: Integer;
  const Value: Ik2Variant);
//#UC START# *4A2D1634025B_4E84542E03B5_var*
//#UC END# *4A2D1634025B_4E84542E03B5_var*
begin
//#UC START# *4A2D1634025B_4E84542E03B5_impl*
 if (AtomIndex = k2_tiChildren) then
  Exit;
 inherited;
//#UC END# *4A2D1634025B_4E84542E03B5_impl*
end;//TevdChildrenCountEliminator.DoAddAtomEx

end.