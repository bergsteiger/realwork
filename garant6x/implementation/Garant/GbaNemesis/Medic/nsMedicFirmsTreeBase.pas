unit nsMedicFirmsTreeBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/nsMedicFirmsTreeBase.pas"
// Начат: 2008/03/21 11:36:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic$Unit::TnsMedicFirmsTreeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  nsDataResetTreeStruct,
  bsInterfaces,
  afwInterfaces,
  DynamicTreeUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMedicFirmsTreeBase = class(TnsDataResetTreeStruct)
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
 protected
 // overridden protected methods
   function MakeFilters: Il3TreeFilters; override;
   procedure FillFilters(const aFilters: Il3TreeFilters;
    const anAdapterFilters: InsAdapterFilters); override;
   function SettingsID: TafwSettingId; override;
   procedure BeforeReset; override;
 public
 // public methods
   constructor Create; reintroduce;
   class function Make: Il3SimpleTree;
 end;//TnsMedicFirmsTreeBase
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  nsConst,
  SysUtils,
  nsMedicFirmListFilters,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsMedicFirmsTreeBase

constructor TnsMedicFirmsTreeBase.Create;
//#UC START# *490711E203CD_490711B101F9_var*
//#UC END# *490711E203CD_490711B101F9_var*
begin
//#UC START# *490711E203CD_490711B101F9_impl*
 inherited Create(ReAqurieUnfilteredRoot, False);
//#UC END# *490711E203CD_490711B101F9_impl*
end;//TnsMedicFirmsTreeBase.Create

class function TnsMedicFirmsTreeBase.Make: Il3SimpleTree;
//#UC START# *490711F30323_490711B101F9_var*
var
 l_Tree: TnsMedicFirmsTreeBase;
//#UC END# *490711F30323_490711B101F9_var*
begin
//#UC START# *490711F30323_490711B101F9_impl*
 if not defDataAdapter.IsInpharmExists then
 begin
  Result := nil;
  Exit;
 end;
 l_Tree := Create;
 try
  Result := l_Tree;
 finally;
  FreeAndNil(l_Tree);
 end;
//#UC END# *490711F30323_490711B101F9_impl*
end;//TnsMedicFirmsTreeBase.Make

function TnsMedicFirmsTreeBase.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_490711B101F9_var*
//#UC END# *48FF64F60078_490711B101F9_var*
begin
//#UC START# *48FF64F60078_490711B101F9_impl*
 Result := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(AT_PHARM_FIRM));
//#UC END# *48FF64F60078_490711B101F9_impl*
end;//TnsMedicFirmsTreeBase.ReAqurieUnfilteredRoot

function TnsMedicFirmsTreeBase.MakeFilters: Il3TreeFilters;
//#UC START# *48FF4C25031E_490711B101F9_var*
//#UC END# *48FF4C25031E_490711B101F9_var*
begin
//#UC START# *48FF4C25031E_490711B101F9_impl*
 Result := TnsMedicFirmListFilters.Make;
//#UC END# *48FF4C25031E_490711B101F9_impl*
end;//TnsMedicFirmsTreeBase.MakeFilters

procedure TnsMedicFirmsTreeBase.FillFilters(const aFilters: Il3TreeFilters;
  const anAdapterFilters: InsAdapterFilters);
//#UC START# *48FF520E03A0_490711B101F9_var*
var
 l_Filters: InsMedicFirmListFilters;
 l_Node: INodeBase;
//#UC END# *48FF520E03A0_490711B101F9_var*
begin
//#UC START# *48FF520E03A0_490711B101F9_impl*
 inherited FillFilters(aFilters, anAdapterFilters);
 l_Node := nil;
 if Supports(aFilters, InsMedicFirmListFilters, l_Filters) and Assigned(l_Filters.Country) then
 begin
  if not Supports(l_Filters.Country.Country, INodeBase, l_Node) then
   if Assigned(Root) then
    Supports(Root.Child, INodeBase, l_Node);
  if Assigned(l_Node) then
   anAdapterFilters.Country.SetCountry(l_Node);
 end;
//#UC END# *48FF520E03A0_490711B101F9_impl*
end;//TnsMedicFirmsTreeBase.FillFilters

function TnsMedicFirmsTreeBase.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_490711B101F9_var*
//#UC END# *48FF56D003E6_490711B101F9_var*
begin
//#UC START# *48FF56D003E6_490711B101F9_impl*
 Result := gi_cpMedicFirms;
//#UC END# *48FF56D003E6_490711B101F9_impl*
end;//TnsMedicFirmsTreeBase.SettingsID

procedure TnsMedicFirmsTreeBase.BeforeReset;
//#UC START# *48FF64E700E5_490711B101F9_var*
var
 l_Filters: InsMedicFirmListFilters;
//#UC END# *48FF64E700E5_490711B101F9_var*
begin
//#UC START# *48FF64E700E5_490711B101F9_impl*
 inherited BeforeReset;
 if Supports(Filters, InsMedicFirmListFilters, l_Filters) and Assigned(l_Filters.Country) then
  l_Filters.Country.Country := nil;
//#UC END# *48FF64E700E5_490711B101F9_impl*
end;//TnsMedicFirmsTreeBase.BeforeReset

{$IfEnd} //not Admin AND not Monitorings

end.