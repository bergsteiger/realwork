unit evdMarkEliminator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/evdMarkEliminator.pas"
// �����: 26.05.2011 15:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdMarkEliminator
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
 TevdMarkEliminator = class(TevdLeafParaFilter)
 protected
 // overridden protected methods
   function ParaTypeForFiltering: Tk2Type; override;
     {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
     {* ���������� ����� �� ����������� ���������� ����� }
 end;//TevdMarkEliminator

implementation

uses
  Mark_Const
  ;

// start class TevdMarkEliminator

function TevdMarkEliminator.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_4DDE3E97005C_var*
//#UC END# *49E488070386_4DDE3E97005C_var*
begin
//#UC START# *49E488070386_4DDE3E97005C_impl*
 Result := k2_typMark;
//#UC END# *49E488070386_4DDE3E97005C_impl*
end;//TevdMarkEliminator.ParaTypeForFiltering

function TevdMarkEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
//#UC START# *49E48829016F_4DDE3E97005C_var*
//#UC END# *49E48829016F_4DDE3E97005C_var*
begin
//#UC START# *49E48829016F_4DDE3E97005C_impl*
 Result := false;
//#UC END# *49E48829016F_4DDE3E97005C_impl*
end;//TevdMarkEliminator.NeedWritePara

end.