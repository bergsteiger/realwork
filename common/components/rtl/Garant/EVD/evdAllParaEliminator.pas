unit evdAllParaEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/evdAllParaEliminator.pas"
// �����: 12.07.2011 14:54
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdAllParaEliminator
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  evdLeafParaFilter,
  k2Base,
  l3Variant
  ;

type
 TevdAllParaEliminator = class(TevdLeafParaFilter)
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
     {* ���������� ����� �� ����������� ���������� ����� }
 end;//TevdAllParaEliminator

implementation

uses
  Para_Const
  ;

// start class TevdAllParaEliminator

function TevdAllParaEliminator.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_4E1C278402E2_var*
//#UC END# *49E488070386_4E1C278402E2_var*
begin
//#UC START# *49E488070386_4E1C278402E2_impl*
 Result := k2_typPara;
//#UC END# *49E488070386_4E1C278402E2_impl*
end;//TevdAllParaEliminator.ParaTypeForFiltering

function TevdAllParaEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
//#UC START# *49E48829016F_4E1C278402E2_var*
//#UC END# *49E48829016F_4E1C278402E2_var*
begin
//#UC START# *49E48829016F_4E1C278402E2_impl*
 Result := false;
//#UC END# *49E48829016F_4E1C278402E2_impl*
end;//TevdAllParaEliminator.NeedWritePara

end.