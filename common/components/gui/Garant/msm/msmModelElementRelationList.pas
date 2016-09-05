unit msmModelElementRelationList;
 {* ������ ��� ��������� �� �������� (�����, ��������, ��������) }

// ������: "w:\common\components\gui\Garant\msm\msmModelElementRelationList.pas"
// ���������: "SimpleClass"
// ������� ������: "TmsmModelElementRelationList" MUID: (57B57D5500F6)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmModelElementDir
;

type
 TmsmModelElementRelationList = class(TmsmModelElementDir)
  {* ������ ��� ��������� �� �������� (�����, ��������, ��������) }
  protected
   function IsDir: Boolean; override;
 end;//TmsmModelElementRelationList

implementation

uses
 l3ImplUses
 //#UC START# *57B57D5500F6impl_uses*
 //#UC END# *57B57D5500F6impl_uses*
;

function TmsmModelElementRelationList.IsDir: Boolean;
//#UC START# *57B57DE500CF_57B57D5500F6_var*
//#UC END# *57B57DE500CF_57B57D5500F6_var*
begin
//#UC START# *57B57DE500CF_57B57D5500F6_impl*
 Result := false;
//#UC END# *57B57DE500CF_57B57D5500F6_impl*
end;//TmsmModelElementRelationList.IsDir

end.
