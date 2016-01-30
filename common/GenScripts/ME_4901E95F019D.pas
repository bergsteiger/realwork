unit nsUserFlagsFilters;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserFlagsFilters.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3TreeFilters
 , bsInterfaces
 , l3TreeInterfaces
;

type
 TnsUserFlagsFilters = class(Tl3TreeFilters, InsUserFlagsFilters)
  private
   f_Group: InsGroupFilter;
   f_Flags: InsUserFlagsFilter;
   f_PermanentFlags: InsUserFlagsFilter;
  protected
   function pm_GetUserFlags: InsUserFlagsFilter;
   function SetUserFlag(const aFilter: InsUserFlagsFilter): InsUserFlagsFilters;
   function pm_GetGroup: InsGroupFilter;
   function SetGroup(const aFilter: InsGroupFilter): InsUserFlagsFilters;
   function pm_GetPermanentUserFlags: InsUserFlagsFilter;
   function SetPermanentUserFlag(const aFilter: InsUserFlagsFilter): InsUserFlagsFilters;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aSource: Il3TreeFilters); override;
 end;//TnsUserFlagsFilters

implementation

uses
 l3ImplUses
 , nsUserFlagsFilter
 , SysUtils
 , nsGroupFilter
;

function TnsUserFlagsFilters.pm_GetUserFlags: InsUserFlagsFilter;
//#UC START# *4901E691032E_4901E95F019Dget_var*
//#UC END# *4901E691032E_4901E95F019Dget_var*
begin
//#UC START# *4901E691032E_4901E95F019Dget_impl*
 Result := f_Flags;
//#UC END# *4901E691032E_4901E95F019Dget_impl*
end;//TnsUserFlagsFilters.pm_GetUserFlags

function TnsUserFlagsFilters.SetUserFlag(const aFilter: InsUserFlagsFilter): InsUserFlagsFilters;
//#UC START# *4901E6C301FD_4901E95F019D_var*
//#UC END# *4901E6C301FD_4901E95F019D_var*
begin
//#UC START# *4901E6C301FD_4901E95F019D_impl*
 f_Flags := aFilter;
 Result := Self;
//#UC END# *4901E6C301FD_4901E95F019D_impl*
end;//TnsUserFlagsFilters.SetUserFlag

function TnsUserFlagsFilters.pm_GetGroup: InsGroupFilter;
//#UC START# *49F0161A037E_4901E95F019Dget_var*
//#UC END# *49F0161A037E_4901E95F019Dget_var*
begin
//#UC START# *49F0161A037E_4901E95F019Dget_impl*
 Result := f_Group;
//#UC END# *49F0161A037E_4901E95F019Dget_impl*
end;//TnsUserFlagsFilters.pm_GetGroup

function TnsUserFlagsFilters.SetGroup(const aFilter: InsGroupFilter): InsUserFlagsFilters;
//#UC START# *49F019C2015C_4901E95F019D_var*
//#UC END# *49F019C2015C_4901E95F019D_var*
begin
//#UC START# *49F019C2015C_4901E95F019D_impl*
 f_Group := aFilter;
 Result := Self;
//#UC END# *49F019C2015C_4901E95F019D_impl*
end;//TnsUserFlagsFilters.SetGroup

function TnsUserFlagsFilters.pm_GetPermanentUserFlags: InsUserFlagsFilter;
//#UC START# *49F1573C02B4_4901E95F019Dget_var*
//#UC END# *49F1573C02B4_4901E95F019Dget_var*
begin
//#UC START# *49F1573C02B4_4901E95F019Dget_impl*
 Result := f_PermanentFlags;
//#UC END# *49F1573C02B4_4901E95F019Dget_impl*
end;//TnsUserFlagsFilters.pm_GetPermanentUserFlags

function TnsUserFlagsFilters.SetPermanentUserFlag(const aFilter: InsUserFlagsFilter): InsUserFlagsFilters;
//#UC START# *49F157660281_4901E95F019D_var*
//#UC END# *49F157660281_4901E95F019D_var*
begin
//#UC START# *49F157660281_4901E95F019D_impl*
 f_PermanentFlags := aFilter;
 Result := Self;
//#UC END# *49F157660281_4901E95F019D_impl*
end;//TnsUserFlagsFilters.SetPermanentUserFlag

procedure TnsUserFlagsFilters.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4901E95F019D_var*
//#UC END# *479731C50290_4901E95F019D_var*
begin
//#UC START# *479731C50290_4901E95F019D_impl*
 f_Flags := nil;
 f_Group := nil;
 f_PermanentFlags := nil;
 inherited;
//#UC END# *479731C50290_4901E95F019D_impl*
end;//TnsUserFlagsFilters.Cleanup

constructor TnsUserFlagsFilters.Create(const aSource: Il3TreeFilters);
//#UC START# *48FF4F47010F_4901E95F019D_var*
var
 l_Filter: InsUserFlagsFilters;
//#UC END# *48FF4F47010F_4901E95F019D_var*
begin
//#UC START# *48FF4F47010F_4901E95F019D_impl*
 inherited Create(aSource);
 if Supports(aSource, InsUserFlagsFilters, l_Filter) then
 begin
  if Assigned(l_Filter.PermanentUserFlags) then
   f_PermanentFlags := TnsUserFlagsFilter.Make(l_Filter.PermanentUserFlags.UserFlag);
  if Assigned(l_Filter.UserFlags) then
   f_Flags := TnsUserFlagsFilter.Make(l_Filter.UserFlags.UserFlag);
  if Assigned(l_Filter.Group) then
   f_Group := TnsGroupFilter.Make(l_Filter.Group.GroupUID);
 end;
//#UC END# *48FF4F47010F_4901E95F019D_impl*
end;//TnsUserFlagsFilters.Create

end.
