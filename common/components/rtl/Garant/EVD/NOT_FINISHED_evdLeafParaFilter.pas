unit NOT_FINISHED_evdLeafParaFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/NOT_FINISHED_evdLeafParaFilter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::EVD::Generators::TevdLeafParaFilter
//
// �����, ����������� "���������" ������. ��������� ����������
// �������� ������� TevdLeafParaFilter.ParaTypeForFiltering
// (���� ����� ����������� ���� ���) � TevdLeafParaFilter.NeedWritePara
// (���� ����� ����������� ��������� ����� ��� �������
// ���������� �������� � �������� �������). ������
// ���������������� ������ ����������� � ������ TevdLeafParaFilter.DoWritePara,
// ���������� �������, ����� ������� ��������� � ����������
// ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base,
  k2TagFilter,
  l3Variant
  ;

type
 TevdLeafParaFilter = class(Tk2TagFilter)
  {* �����, ����������� "���������" ������. ��������� ����������
 �������� ������� TevdLeafParaFilter.ParaTypeForFiltering
(���� ����� ����������� ���� ���) � TevdLeafParaFilter.NeedWritePara
(���� ����� ����������� ��������� ����� ��� �������
���������� �������� � �������� �������). ������
���������������� ������ ����������� � ������ TevdLeafParaFilter.DoWritePara,
���������� �������, ����� ������� ��������� � ����������
������ }
 protected
 // protected methods
   function ParaTypeForFiltering: Tk2Type; virtual;
     {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; virtual;
     {* ���������� ����� �� ����������� ���������� ����� }
   procedure DoWritePara(aLeaf: Tl3Variant); virtual;
     {* ������ ����������� ������ � ���������. ��������� ������� ��������� � ���������� ������ }
 end;//TevdLeafParaFilter

implementation

// start class TevdLeafParaFilter

function TevdLeafParaFilter.ParaTypeForFiltering: Tk2Type;
//#UC START# *49E488070386_49E487650342_var*
//#UC END# *49E488070386_49E487650342_var*
begin
//#UC START# *49E488070386_49E487650342_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E488070386_49E487650342_impl*
end;//TevdLeafParaFilter.ParaTypeForFiltering

function TevdLeafParaFilter.NeedWritePara(aLeaf: Tl3Variant): Boolean;
//#UC START# *49E48829016F_49E487650342_var*
//#UC END# *49E48829016F_49E487650342_var*
begin
//#UC START# *49E48829016F_49E487650342_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E48829016F_49E487650342_impl*
end;//TevdLeafParaFilter.NeedWritePara

procedure TevdLeafParaFilter.DoWritePara(aLeaf: Tl3Variant);
//#UC START# *49E4883E0176_49E487650342_var*
//#UC END# *49E4883E0176_49E487650342_var*
begin
//#UC START# *49E4883E0176_49E487650342_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E4883E0176_49E487650342_impl*
end;//TevdLeafParaFilter.DoWritePara

end.