unit evLeafParaDecorationsHolderEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EverestCommon"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/EverestCommon/evLeafParaDecorationsHolderEliminator.pas"
// �����: 30.03.2011 18:53
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EverestCommon::Generators::TevLeafParaDecorationsHolderEliminator
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  k2TagFilter
  ;

type
 TevLeafParaDecorationsHolderEliminator = class(Tk2TagFilter)
 protected
 // overridden protected methods
   function NeedTranslateChildToNext: Boolean; override;
 end;//TevLeafParaDecorationsHolderEliminator

implementation

uses
  LeafParaDecorationsHolder_Const
  ;

// start class TevLeafParaDecorationsHolderEliminator

function TevLeafParaDecorationsHolderEliminator.NeedTranslateChildToNext: Boolean;
//#UC START# *4CA3006302BC_4D9343CE038C_var*
//#UC END# *4CA3006302BC_4D9343CE038C_var*
begin
//#UC START# *4CA3006302BC_4D9343CE038C_impl*
 Result := not CurrentType.IsKindOf(k2_typLeafParaDecorationsHolder);
//#UC END# *4CA3006302BC_4D9343CE038C_impl*
end;//TevLeafParaDecorationsHolderEliminator.NeedTranslateChildToNext

end.