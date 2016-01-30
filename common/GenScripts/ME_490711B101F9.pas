unit nsMedicFirmsTreeBase;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsTreeBase.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , l3TreeInterfaces
 , DynamicTreeUnit
 , afwInterfaces
 , bsInterfaces
;

type
 TnsMedicFirmsTreeBase = class(TnsDataResetTreeStruct)
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function MakeFilters: Il3TreeFilters; override;
   procedure FillFilters(const aFilters: Il3TreeFilters;
    const anAdapterFilters: InsAdapterFilters); override;
   function SettingsID: TafwSettingId; override;
   procedure BeforeReset; override;
  public
   constructor Create; reintroduce;
   class function Make: Il3SimpleTree;
 end;//TnsMedicFirmsTreeBase
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , nsConst
 , SysUtils
 , nsMedicFirmListFilters
 , nsTypes
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
