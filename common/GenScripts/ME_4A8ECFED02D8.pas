unit Autoreferat_InternalOperations_Controls;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Autoreferat_InternalOperations_Controls.pas"
// ���������: "VCMControls"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // DateInterval

 // SelectCurrent

 // NewsThemes

 // Open

 // DateInterval

 Op_DateInterval_OpenInt = class
  {* ����� ��� ������ �������� DateInterval.OpenInt }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� DateInterval.OpenInt � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� DateInterval.OpenInt � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� DateInterval.OpenInt � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� DateInterval.OpenInt � ���������� }
 end;//Op_DateInterval_OpenInt
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� DateInterval.OpenInt � �������� }
//#UC START# *6AFD6E8DD994_32B115C22595_var*
//#UC END# *6AFD6E8DD994_32B115C22595_var*
begin
//#UC START# *6AFD6E8DD994_32B115C22595_impl*
 !!! Needs to be implemented !!!
//#UC END# *6AFD6E8DD994_32B115C22595_impl*
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� DateInterval.OpenInt � ��������� }
//#UC START# *9B3D2E7C63E4_32B115C22595_var*
//#UC END# *9B3D2E7C63E4_32B115C22595_var*
begin
//#UC START# *9B3D2E7C63E4_32B115C22595_impl*
 !!! Needs to be implemented !!!
//#UC END# *9B3D2E7C63E4_32B115C22595_impl*
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� DateInterval.OpenInt � ����� }
//#UC START# *B301CD786AA1_32B115C22595_var*
//#UC END# *B301CD786AA1_32B115C22595_var*
begin
//#UC START# *B301CD786AA1_32B115C22595_impl*
 !!! Needs to be implemented !!!
//#UC END# *B301CD786AA1_32B115C22595_impl*
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� DateInterval.OpenInt � ���������� }
//#UC START# *25CA0B80FF03_32B115C22595_var*
//#UC END# *25CA0B80FF03_32B115C22595_var*
begin
//#UC START# *25CA0B80FF03_32B115C22595_impl*
 !!! Needs to be implemented !!!
//#UC END# *25CA0B80FF03_32B115C22595_impl*
end;//Op_DateInterval_OpenInt.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
