unit nsDictionTree;
 {* ������ ��������� �������. }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDictionTree.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsDictionTree" MUID: (46836BA203A1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDataResetTreeStruct
 , bsTypes
 , CommonDictionInterfaces
 , l3TreeInterfaces
 , bsInterfaces
 , l3Interfaces
 , DynamicTreeUnit
 , afwInterfaces
 , nsFilterableTreeStruct
;

type
 TnsDictionTree = class(TnsDataResetTreeStruct)
  {* ������ ��������� �������. }
  private
   f_DictionKind: TnsDictionKind;
    {* ���� ��� �������� DictionKind }
  protected
   function pm_GetLanguage: TbsLanguage; virtual;
   function DictFilters: InsLayeredTreeFilters;
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function MakeChildNode(const aChild: INodeBase): Il3SimpleNode; override;
   constructor CreateFiltered(const aNewRoot: INodeBase;
    aSource: TnsFilterableTreeStruct;
    const aFilters: Il3TreeFilters); override;
   function MakeFilters: Il3TreeFilters; override;
   procedure FillFilters(const aFilters: Il3TreeFilters;
    const anAdapterFilters: InsAdapterFilters); override;
   function SettingsID: TafwSettingId; override;
   procedure BeforeReset; override;
  public
   constructor Create(aKind: TnsDictionKind;
    const aRoot: INodeBase;
    aShowRoot: Boolean;
    aOneLevel: Boolean = False); reintroduce;
   class function Make(aKind: TnsDictionKind;
    aLang: TbsLanguage;
    const anActiveContext: Il3CString = nil;
    CalcPartialContext: Boolean = False): Il3SimpleTree;
  private
   property Language: TbsLanguage
    read pm_GetLanguage;
  public
   property DictionKind: TnsDictionKind
    read f_DictionKind;
 end;//TnsDictionTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDictListChild
 , bsConvert
 , SysUtils
 , nsLayeredTreeFilters
 , nsConst
 , nsLayerFilter
 , l3String
 , nsDictCache
 , nsMedicDictCache
 , nsINodeOneLevelWrap
 , nsDayTipsDictCache
;

function TnsDictionTree.pm_GetLanguage: TbsLanguage;
//#UC START# *490823D301BE_46836BA203A1get_var*
//#UC END# *490823D301BE_46836BA203A1get_var*
begin
//#UC START# *490823D301BE_46836BA203A1get_impl*
 Assert(Assigned(DictFilters.Layer));
 Result := bsAdapterToBusiness(DictFilters.Layer.LayerID);
//#UC END# *490823D301BE_46836BA203A1get_impl*
end;//TnsDictionTree.pm_GetLanguage

constructor TnsDictionTree.Create(aKind: TnsDictionKind;
 const aRoot: INodeBase;
 aShowRoot: Boolean;
 aOneLevel: Boolean = False);
//#UC START# *556C49A400D8_46836BA203A1_var*
//#UC END# *556C49A400D8_46836BA203A1_var*
begin
//#UC START# *556C49A400D8_46836BA203A1_impl*
 inherited Create(aRoot, aShowRoot, aOneLevel);
 f_DictionKind := aKind;
//#UC END# *556C49A400D8_46836BA203A1_impl*
end;//TnsDictionTree.Create

class function TnsDictionTree.Make(aKind: TnsDictionKind;
 aLang: TbsLanguage;
 const anActiveContext: Il3CString = nil;
 CalcPartialContext: Boolean = False): Il3SimpleTree;
//#UC START# *490823A102D3_46836BA203A1_var*
var
 l_Tree: TnsDictionTree;
 l_Filterable: Il3FilterableTree;
 l_TreeFilters: InsLayeredTreeFilters;
 l_Current: Integer;
 l_ContainsLang: Boolean;
//#UC END# *490823A102D3_46836BA203A1_var*
begin
//#UC START# *490823A102D3_46836BA203A1_impl*
 case aKind of
  ns_dkDiction: l_ContainsLang := TnsDictCache.Instance.ContainsLang(aLang);
  ns_dkMedic,
  ns_dkDayTips: l_ContainsLang := True;//TnsCommonDictCache.Instance.ContainsLang(aLang);
 else
  Assert(False);
 end;
 if l_ContainsLang then
 begin
  case aKind of
   ns_dkDiction: l_Tree := Create(aKind, TnsDictCache.Instance.Root, False);
   ns_dkMedic: l_Tree := Create(aKind, TnsMedicDictCache.Instance.Root, False);
   ns_dkDayTips: l_Tree := Create(aKind, TnsDayTipsDictCache.Instance.Root, False);
  else
   Assert(False);
  end;
  try
   if aKind = ns_dkDiction then
   begin
    l_Filterable := l_Tree;
    Supports(l_Tree.CloneFilters, InsLayeredTreeFilters, l_TreeFilters);
    Result := l_Filterable.MakeFiltered(l_TreeFilters.SetLayer(TnsLayerFilter.Make(bsBusinessToAdapter(aLang))),
                                        nil,
                                        l_Current,
                                        True);
   end else
    Result := l_Tree;
   if not l3IsNil(anActiveContext) and (Supports(Result, Il3FilterableTree, l_Filterable)) then
   begin
    Result := l_Filterable.MakeFiltered(l_Filterable.CloneFilters.SetContext(anActiveContext),
                                        nil,
                                        l_Current,
                                        True,
                                        CalcPartialContext);
    if not Assigned(Result) or (Result.CountView <= 0) then
     Result := l_Filterable as Il3SimpleTree;
   end;
  finally;
   FreeAndNil(l_Tree);
  end;
 end
 else
  Result := nil;
//#UC END# *490823A102D3_46836BA203A1_impl*
end;//TnsDictionTree.Make

function TnsDictionTree.DictFilters: InsLayeredTreeFilters;
//#UC START# *4908241B0118_46836BA203A1_var*
//#UC END# *4908241B0118_46836BA203A1_var*
begin
//#UC START# *4908241B0118_46836BA203A1_impl*
 Supports(Filters, InsLayeredTreeFilters, Result);
//#UC END# *4908241B0118_46836BA203A1_impl*
end;//TnsDictionTree.DictFilters

function TnsDictionTree.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_46836BA203A1_var*
//#UC END# *48FF64F60078_46836BA203A1_var*
begin
//#UC START# *48FF64F60078_46836BA203A1_impl*
 Result := TnsDictCache.Instance.Root; 
//#UC END# *48FF64F60078_46836BA203A1_impl*
end;//TnsDictionTree.ReAqurieUnfilteredRoot

function TnsDictionTree.MakeChildNode(const aChild: INodeBase): Il3SimpleNode;
//#UC START# *48FEE50002EB_46836BA203A1_var*
//#UC END# *48FEE50002EB_46836BA203A1_var*
begin
//#UC START# *48FEE50002EB_46836BA203A1_impl*
 if f_DictionKind = ns_dkDiction then
  Result := TnsDictListChild.Make(aChild, Language)
 else
  Result := TnsINodeOneLevelWrap.Make(aChild);
//#UC END# *48FEE50002EB_46836BA203A1_impl*
end;//TnsDictionTree.MakeChildNode

constructor TnsDictionTree.CreateFiltered(const aNewRoot: INodeBase;
 aSource: TnsFilterableTreeStruct;
 const aFilters: Il3TreeFilters);
//#UC START# *48FF458602EC_46836BA203A1_var*
//#UC END# *48FF458602EC_46836BA203A1_var*
begin
//#UC START# *48FF458602EC_46836BA203A1_impl*
 Assert(aSource is TnsDictionTree);
 inherited CreateFiltered(aNewRoot, aSource, aFilters);
 f_DictionKind := TnsDictionTree(aSource).DictionKind;
//#UC END# *48FF458602EC_46836BA203A1_impl*
end;//TnsDictionTree.CreateFiltered

function TnsDictionTree.MakeFilters: Il3TreeFilters;
//#UC START# *48FF4C25031E_46836BA203A1_var*
//#UC END# *48FF4C25031E_46836BA203A1_var*
begin
//#UC START# *48FF4C25031E_46836BA203A1_impl*
 Result := TnsLayeredTreeFilters.Make;
//#UC END# *48FF4C25031E_46836BA203A1_impl*
end;//TnsDictionTree.MakeFilters

procedure TnsDictionTree.FillFilters(const aFilters: Il3TreeFilters;
 const anAdapterFilters: InsAdapterFilters);
//#UC START# *48FF520E03A0_46836BA203A1_var*
var
 l_Filters: InsLayeredTreeFilters;
//#UC END# *48FF520E03A0_46836BA203A1_var*
begin
//#UC START# *48FF520E03A0_46836BA203A1_impl*
 inherited FillFilters(aFilters, anAdapterFilters);
 if Supports(aFilters, InsLayeredTreeFilters, l_Filters) and Assigned(l_Filters.Layer) then
  anAdapterFilters.Layer.SetLayer(l_Filters.Layer.LayerID);
//#UC END# *48FF520E03A0_46836BA203A1_impl*
end;//TnsDictionTree.FillFilters

function TnsDictionTree.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_46836BA203A1_var*
//#UC END# *48FF56D003E6_46836BA203A1_var*
begin
//#UC START# *48FF56D003E6_46836BA203A1_impl*
 Result := gi_cpDiction;
//#UC END# *48FF56D003E6_46836BA203A1_impl*
end;//TnsDictionTree.SettingsID

procedure TnsDictionTree.BeforeReset;
//#UC START# *48FF64E700E5_46836BA203A1_var*
//#UC END# *48FF64E700E5_46836BA203A1_var*
begin
//#UC START# *48FF64E700E5_46836BA203A1_impl*
 inherited;
 TnsDictCache.Instance.ClearCache;
//#UC END# *48FF64E700E5_46836BA203A1_impl*
end;//TnsDictionTree.BeforeReset
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
