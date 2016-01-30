unit evdAllSubsEliminator;

// ������: "w:\common\components\rtl\Garant\EVD\evdAllSubsEliminator.pas"
// ���������: "SimpleClass"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , k2Base
 , l3Variant
;

type
 TevdAllSubsEliminator = class(TevdLeafParaFilter)
  protected
   function ParaTypeForFiltering: Tk2Type; override;
    {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* ���������� ����� �� ����������� ���������� ����� }
 end;//TevdAllSubsEliminator

implementation

uses
 l3ImplUses
 , k2Tags
 , Sub_Const
;

function TevdAllSubsEliminator.ParaTypeForFiltering: Tk2Type;
 {* �������, ������������ ��� �������, ��� ������� ����� ����������� ���������� }
//#UC START# *49E488070386_4EC116A50211_var*
//#UC END# *49E488070386_4EC116A50211_var*
begin
//#UC START# *49E488070386_4EC116A50211_impl*
 Result := k2_idSub; 
//#UC END# *49E488070386_4EC116A50211_impl*
end;//TevdAllSubsEliminator.ParaTypeForFiltering

function TevdAllSubsEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* ���������� ����� �� ����������� ���������� ����� }
//#UC START# *49E48829016F_4EC116A50211_var*
//#UC END# *49E48829016F_4EC116A50211_var*
begin
//#UC START# *49E48829016F_4EC116A50211_impl*
 Result := false;
//#UC END# *49E48829016F_4EC116A50211_impl*
end;//TevdAllSubsEliminator.NeedWritePara

end.
