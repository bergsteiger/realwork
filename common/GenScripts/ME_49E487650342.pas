unit NOT_FINISHED_evdLeafParaFilter;
 {* �����, ����������� "���������" ������. ��������� ����������
 �������� ������� TevdLeafParaFilter.ParaTypeForFiltering
(���� ����� ����������� ���� ���) � TevdLeafParaFilter.NeedWritePara
(���� ����� ����������� ��������� ����� ��� �������
���������� �������� � �������� �������). ������
���������������� ������ ����������� � ������ TevdLeafParaFilter.DoWritePara,
���������� �������, ����� ������� ��������� � ����������
������ }

// ������: "w:\common\components\rtl\Garant\EVD\NOT_FINISHED_evdLeafParaFilter.pas"
// ���������: "SimpleClass"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , k2Base
 , l3Variant
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
   function ParaTypeForFiltering: Tk2Type; virtual;
    {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; virtual;
    {* ���������� ����� �� ����������� ���������� ����� }
   procedure DoWritePara(aLeaf: Tl3Variant); virtual;
    {* ������ ����������� ������ � ���������. ��������� ������� ��������� � ���������� ������ }
 end;//TevdLeafParaFilter

implementation

uses
 l3ImplUses
;

function TevdLeafParaFilter.ParaTypeForFiltering: Tk2Type;
 {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
//#UC START# *49E488070386_49E487650342_var*
//#UC END# *49E488070386_49E487650342_var*
begin
//#UC START# *49E488070386_49E487650342_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E488070386_49E487650342_impl*
end;//TevdLeafParaFilter.ParaTypeForFiltering

function TevdLeafParaFilter.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* ���������� ����� �� ����������� ���������� ����� }
//#UC START# *49E48829016F_49E487650342_var*
//#UC END# *49E48829016F_49E487650342_var*
begin
//#UC START# *49E48829016F_49E487650342_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E48829016F_49E487650342_impl*
end;//TevdLeafParaFilter.NeedWritePara

procedure TevdLeafParaFilter.DoWritePara(aLeaf: Tl3Variant);
 {* ������ ����������� ������ � ���������. ��������� ������� ��������� � ���������� ������ }
//#UC START# *49E4883E0176_49E487650342_var*
//#UC END# *49E4883E0176_49E487650342_var*
begin
//#UC START# *49E4883E0176_49E487650342_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E4883E0176_49E487650342_impl*
end;//TevdLeafParaFilter.DoWritePara

end.
