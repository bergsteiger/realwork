unit nsUserTreeStruct;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Users\nsUserTreeStruct.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsUserTreeStruct" MUID: (4906E96C0364)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsDataResetTreeStruct
 , DynamicTreeUnit
 , l3TreeInterfaces
 , afwInterfaces
 , bsInterfaces
;

type
 TnsUserTreeStruct = class(TnsDataResetTreeStruct)
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function MakeFilters: Il3TreeFilters; override;
   procedure FillFilters(const aFilters: Il3TreeFilters;
    const anAdapterFilters: InsAdapterFilters); override;
   function SettingsID: TafwSettingId; override;
  public
   constructor Create(const aRoot: INodeBase;
    aShowRoot: Boolean;
    aOneLevel: Boolean = False); override;
 end;//TnsUserTreeStruct

implementation

uses
 l3ImplUses
 , DataAdapter
 , SysUtils
 , nsConst
 , nsUserFlagsFilters
 , l3Interfaces
 , SecurityUnit
;

function TnsUserTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_4906E96C0364_var*
//#UC END# *48FF64F60078_4906E96C0364_var*
begin
//#UC START# *48FF64F60078_4906E96C0364_impl*
 Result := defDataAdapter.GetUsersTree;
//#UC END# *48FF64F60078_4906E96C0364_impl*
end;//TnsUserTreeStruct.ReAqurieUnfilteredRoot

constructor TnsUserTreeStruct.Create(const aRoot: INodeBase;
 aShowRoot: Boolean;
 aOneLevel: Boolean = False);
//#UC START# *48FDD9270194_4906E96C0364_var*
//#UC END# *48FDD9270194_4906E96C0364_var*
begin
//#UC START# *48FDD9270194_4906E96C0364_impl*
 inherited Create(aRoot, aShowRoot, aOneLevel);
 ChangeExpand(Get_RootNode.Child, sbSelect);
//#UC END# *48FDD9270194_4906E96C0364_impl*
end;//TnsUserTreeStruct.Create

function TnsUserTreeStruct.MakeFilters: Il3TreeFilters;
//#UC START# *48FF4C25031E_4906E96C0364_var*
//#UC END# *48FF4C25031E_4906E96C0364_var*
begin
//#UC START# *48FF4C25031E_4906E96C0364_impl*
 Result := TnsUserFlagsFilters.Make;
//#UC END# *48FF4C25031E_4906E96C0364_impl*
end;//TnsUserTreeStruct.MakeFilters

procedure TnsUserTreeStruct.FillFilters(const aFilters: Il3TreeFilters;
 const anAdapterFilters: InsAdapterFilters);
//#UC START# *48FF520E03A0_4906E96C0364_var*
var
 l_Filters: InsUserFlagsFilters;
//#UC END# *48FF520E03A0_4906E96C0364_var*
begin
//#UC START# *48FF520E03A0_4906E96C0364_impl*
 inherited FillFilters(aFilters, anAdapterFilters);
 if Supports(aFilters, InsUserFlagsFilters, l_Filters) then
 begin
  if Assigned(l_Filters.PermanentUserFlags) then
   anAdapterFilters.UserFlags.SetFlags(l_Filters.PermanentUserFlags.UserFlag);
  if Assigned(l_Filters.UserFlags) then
   with anAdapterFilters.UserFlags do
    SetFlags(GetFlags or l_Filters.UserFlags.UserFlag);
  if Assigned(l_Filters.Group) then
   with anAdapterFilters.UserFlags do
   begin
    SetFlags(GetFlags or UFF_GROUP_UID);
    SetGroupUid(l_Filters.Group.GroupUID);
   end;
 end;
//#UC END# *48FF520E03A0_4906E96C0364_impl*
end;//TnsUserTreeStruct.FillFilters

function TnsUserTreeStruct.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_4906E96C0364_var*
//#UC END# *48FF56D003E6_4906E96C0364_var*
begin
//#UC START# *48FF56D003E6_4906E96C0364_impl*
 Result := gi_cpUserList;
//#UC END# *48FF56D003E6_4906E96C0364_impl*
end;//TnsUserTreeStruct.SettingsID

end.
