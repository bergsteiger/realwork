unit Autoreferat_InternalOperations_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Autoreferat_InternalOperations_Controls.pas"
// Стереотип: "VCMControls"

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
  {* Класс для вызова операции DateInterval.OpenInt }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции DateInterval.OpenInt у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции DateInterval.OpenInt у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции DateInterval.OpenInt у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции DateInterval.OpenInt у контейнера }
 end;//Op_DateInterval_OpenInt
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции DateInterval.OpenInt у сущности }
//#UC START# *6AFD6E8DD994_32B115C22595_var*
//#UC END# *6AFD6E8DD994_32B115C22595_var*
begin
//#UC START# *6AFD6E8DD994_32B115C22595_impl*
 !!! Needs to be implemented !!!
//#UC END# *6AFD6E8DD994_32B115C22595_impl*
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции DateInterval.OpenInt у агрегации }
//#UC START# *9B3D2E7C63E4_32B115C22595_var*
//#UC END# *9B3D2E7C63E4_32B115C22595_var*
begin
//#UC START# *9B3D2E7C63E4_32B115C22595_impl*
 !!! Needs to be implemented !!!
//#UC END# *9B3D2E7C63E4_32B115C22595_impl*
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции DateInterval.OpenInt у формы }
//#UC START# *B301CD786AA1_32B115C22595_var*
//#UC END# *B301CD786AA1_32B115C22595_var*
begin
//#UC START# *B301CD786AA1_32B115C22595_impl*
 !!! Needs to be implemented !!!
//#UC END# *B301CD786AA1_32B115C22595_impl*
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции DateInterval.OpenInt у контейнера }
//#UC START# *25CA0B80FF03_32B115C22595_var*
//#UC END# *25CA0B80FF03_32B115C22595_var*
begin
//#UC START# *25CA0B80FF03_32B115C22595_impl*
 !!! Needs to be implemented !!!
//#UC END# *25CA0B80FF03_32B115C22595_impl*
end;//Op_DateInterval_OpenInt.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
