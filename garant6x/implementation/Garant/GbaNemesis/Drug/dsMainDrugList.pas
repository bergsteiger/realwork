unit dsMainDrugList;
 {* ��� ������ ���������� � ������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Drug\dsMainDrugList.pas"
// ���������: "ViewAreaControllerImp"
// ������� ������: "TdsMainDrugList" MUID: (47F5D70E03AB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsDrugList
;

type
 TdsMainDrugList = class(TdsDrugList)
  {* ��� ������ ���������� � ������� ���� }
  protected
   function NotifyAboutChangeCurrent: Boolean; override;
    {* ���������� ������ ������ ���������� � ����� ��������. }
   function DoIsMain: Boolean; override;
    {* - ���������� ������ � �������� ���� ����������. }
 end;//TdsMainDrugList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 //#UC START# *47F5D70E03ABimpl_uses*
 //#UC END# *47F5D70E03ABimpl_uses*
;

function TdsMainDrugList.NotifyAboutChangeCurrent: Boolean;
 {* ���������� ������ ������ ���������� � ����� ��������. }
//#UC START# *47F0D913030D_47F5D70E03AB_var*
//#UC END# *47F0D913030D_47F5D70E03AB_var*
begin
//#UC START# *47F0D913030D_47F5D70E03AB_impl*
 Result := True;
//#UC END# *47F0D913030D_47F5D70E03AB_impl*
end;//TdsMainDrugList.NotifyAboutChangeCurrent

function TdsMainDrugList.DoIsMain: Boolean;
 {* - ���������� ������ � �������� ���� ����������. }
//#UC START# *47FB00640212_47F5D70E03AB_var*
//#UC END# *47FB00640212_47F5D70E03AB_var*
begin
//#UC START# *47FB00640212_47F5D70E03AB_impl*
 Result := True;
//#UC END# *47FB00640212_47F5D70E03AB_impl*
end;//TdsMainDrugList.DoIsMain
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
