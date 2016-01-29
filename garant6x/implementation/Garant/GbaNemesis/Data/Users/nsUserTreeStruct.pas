unit nsUserTreeStruct;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Users/nsUserTreeStruct.pas"
// Начат: 22.08.2005 20.30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Users$CommonForAdminAndF1::TnsUserTreeStruct
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  nsDataResetTreeStruct,
  DynamicTreeUnit,
  l3TreeInterfaces,
  bsInterfaces,
  afwInterfaces
  ;

type
 TnsUserTreeStruct = class(TnsDataResetTreeStruct)
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 protected
 // overridden protected methods
   function MakeFilters: Il3TreeFilters; override;
   procedure FillFilters(const aFilters: Il3TreeFilters;
    const anAdapterFilters: InsAdapterFilters); override;
   function SettingsID: TafwSettingId; override;
 public
 // overridden public methods
   constructor Create(const aRoot: INodeBase;
    aShowRoot: Boolean;
    aOneLevel: Boolean = False); override;
 end;//TnsUserTreeStruct

implementation

uses
  DataAdapter,
  SysUtils,
  nsConst,
  nsUserFlagsFilters,
  l3Interfaces,
  SecurityUnit
  ;

// start class TnsUserTreeStruct

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