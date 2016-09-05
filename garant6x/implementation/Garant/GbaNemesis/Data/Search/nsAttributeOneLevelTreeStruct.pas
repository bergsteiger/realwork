unit nsAttributeOneLevelTreeStruct;
 {* Коллеги, это что? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttributeOneLevelTreeStruct.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsAttributeOneLevelTreeStruct" MUID: (4683698E01BC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsOneLevelTreeStruct
 , l3TreeInterfaces
 , DynamicTreeUnit
 , l3Interfaces
 , afwInterfaces
 , nsFilterableTreeStruct
 , bsInterfaces
 , SearchDomainInterfaces
;

type
 _nsTaggedTreeInfo_Parent_ = TnsOneLevelTreeStruct;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsTaggedTreeInfo.imp.pas}
 TnsAttributeOneLevelTreeStruct = class(_nsTaggedTreeInfo_)
  {* Коллеги, это что? }
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
   function GetSelectCount: Integer; override;
   constructor CreateFiltered(const aNewRoot: INodeBase;
    aSource: TnsFilterableTreeStruct;
    const aFilters: Il3TreeFilters); override;
   function MakeFilters: Il3TreeFilters; override;
   procedure FillFilters(const aFilters: Il3TreeFilters;
    const anAdapterFilters: InsAdapterFilters); override;
   function SettingsID: TafwSettingId; override;
   procedure BeforeReset; override;
   procedure TagChanged; override;
    {* Tag сменился }
  public
   class function Make(const aNode: INodeBase;
    aShowRoot: Boolean;
    aCreateView: Boolean): Il3SimpleTree; overload;
    {* Коллеги, это что? Чем это от других Make отличается? }
   class function Make(const aTag: Il3CString;
    aShowRoot: Boolean;
    aCreateView: Boolean): Il3SimpleTree; overload;
    {* Коллеги, это что? Чем это от других Make отличается? }
   class function Make(const aRoot: INodeBase;
    const aCopy: Il3SimpleTree): Il3SimpleTree; overload;
    {* Коллеги, это что? Чем это от других Make отличается? }
   class function Make(const aRoot: INodeBase;
    const aTag: Il3CString;
    aShowRoot: Boolean): Il3SimpleTree; overload;
    {* Коллеги, это что? Чем это от других Make отличается? }
 end;//TnsAttributeOneLevelTreeStruct

implementation

uses
 l3ImplUses
 , nsAttributeTreeFilters
 , DataAdapter
 , SysUtils
 , nsAttributeTreeCacheNew
 , nsTypes
 , l3String
 , bsUtils
 //#UC START# *4683698E01BCimpl_uses*
 //#UC END# *4683698E01BCimpl_uses*
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsTaggedTreeInfo.imp.pas}

class function TnsAttributeOneLevelTreeStruct.Make(const aNode: INodeBase;
 aShowRoot: Boolean;
 aCreateView: Boolean): Il3SimpleTree;
 {* Коллеги, это что? Чем это от других Make отличается? }
//#UC START# *4909D3820227_4683698E01BC_var*
var
 l_FilterList: IFilterList;
 l_Index: Integer;
 l_OneLevelRoot: INodeBase;
 l_Info: InsTaggedTreeInfo;
//#UC END# *4909D3820227_4683698E01BC_var*
begin
//#UC START# *4909D3820227_4683698E01BC_impl*
 if aCreateView then
 begin
// нужно дерево, не шарящее флаги открытия
  l_FilterList := defDataAdapter.NativeAdapter.MakeFilterList;
  try
   aNode.CreateViewEx(l_FilterList, FM_SHARED_NONE, nil, l_Index, 0, True, False, False, l_OneLevelRoot);
  finally
   l_FilterList := nil;
  end;
 end
 else
  l_OneLevelRoot := aNode;
 Result := inherited Make(l_OneLevelRoot, aShowRoot);
 if Supports(Result, InsTaggedTreeInfo, l_Info) then
  l_Info.ServerOneLevel := aCreateView;
//#UC END# *4909D3820227_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.Make

class function TnsAttributeOneLevelTreeStruct.Make(const aTag: Il3CString;
 aShowRoot: Boolean;
 aCreateView: Boolean): Il3SimpleTree;
 {* Коллеги, это что? Чем это от других Make отличается? }
//#UC START# *4909D3A9022D_4683698E01BC_var*
Var
 l_Node         : INodeBase;
 l_TaggedInfo   : InsTaggedTreeInfo;
//#UC END# *4909D3A9022D_4683698E01BC_var*
begin
//#UC START# *4909D3A9022D_4683698E01BC_impl*
 Result := nil;
 l_Node := TnsAttributeTreeCacheNew.Instance.AttributeRoot[aTag];
 try
  Result := Make(l_Node, aShowRoot, aCreateView);
  if Supports(Result, InsTaggedTreeInfo, l_TaggedInfo) then
  begin
   l_TaggedInfo.Tag := aTag;
   l_TaggedInfo.ServerOneLevel := aCreateView;
  end;
 finally
  l_Node := nil;
 end;
//#UC END# *4909D3A9022D_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.Make

class function TnsAttributeOneLevelTreeStruct.Make(const aRoot: INodeBase;
 const aCopy: Il3SimpleTree): Il3SimpleTree;
 {* Коллеги, это что? Чем это от других Make отличается? }
//#UC START# *4909D3CB0242_4683698E01BC_var*
var
 l_Dest, l_Source: InsTaggedTreeInfo;
 l_Tree: Il3FilterableTree;
 l_DestTree: InsInternalFilterableTree;
//#UC END# *4909D3CB0242_4683698E01BC_var*
begin
//#UC START# *4909D3CB0242_4683698E01BC_impl*
 Result := nil;
 if aCopy <> nil then
 begin
  if Supports(aCopy, InsTaggedTreeInfo, l_Source) then
   Result := Make(aRoot, aCopy.ShowRoot, l_Source.ServerOneLevel)
  else
   Result := inherited Make(aRoot, aCopy.ShowRoot);

  if Supports(Result, InsTaggedTreeInfo, l_Dest) and
     Assigned(l_Source) then
   l_Dest.AssignInfo(l_Source);
  if Supports(aCopy, Il3FilterableTree, l_Tree) and
     Supports(l_Dest, InsInternalFilterableTree, l_DestTree) then
   l_DestTree.SetFilters(l_Tree.CloneFilters);
 end;
//#UC END# *4909D3CB0242_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.Make

class function TnsAttributeOneLevelTreeStruct.Make(const aRoot: INodeBase;
 const aTag: Il3CString;
 aShowRoot: Boolean): Il3SimpleTree;
 {* Коллеги, это что? Чем это от других Make отличается? }
//#UC START# *4909D3E601D2_4683698E01BC_var*
var
 l_OneLevelRoot : INodeBase;
 l_TaggedInfo   : InsTaggedTreeInfo;
//#UC END# *4909D3E601D2_4683698E01BC_var*
begin
//#UC START# *4909D3E601D2_4683698E01BC_impl*
 Result := nil;
 try
  Result := Make(aRoot, aShowRoot, false);
  if Supports(Result, InsTaggedTreeInfo, l_TaggedInfo) then
  begin
   l_TaggedInfo.Tag := aTag;
   l_TaggedInfo.ServerOneLevel := false;
  end;
 finally
  l_OneLevelRoot := nil;
 end;
//#UC END# *4909D3E601D2_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.Make

function TnsAttributeOneLevelTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_4683698E01BC_var*
var
 l_Sync: Integer;
//#UC END# *48FF64F60078_4683698E01BC_var*
begin
//#UC START# *48FF64F60078_4683698E01BC_impl*
 if not l3IsNil(Tag) then
  case BeenReseted of
   rtsRoot :
    Result := TnsAttributeTreeCacheNew.Instance.AttributeRoot[Tag];
   rtsOneLevel :
    Result := GetFilteredRoot(TnsAttributeTreeCacheNew.Instance.AttributeRoot[Tag],
                              Filters,
                              nil,
                              l_Sync,
                              True,
                              False,
                              true);
   else
    Result := ReAqurieUnfilteredRoot;
  end
 else
  Result := ReAqurieUnfilteredRoot;
//#UC END# *48FF64F60078_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.ReAqurieUnfilteredRoot

function TnsAttributeOneLevelTreeStruct.GetSelectCount: Integer;
//#UC START# *48FEFE040094_4683698E01BC_var*
//#UC END# *48FEFE040094_4683698E01BC_var*
begin
//#UC START# *48FEFE040094_4683698E01BC_impl*
 if (RootNode = nil) then
  Result := 0
 else
  Result := RootNode.GetFirstLevelChildrenFlagCount(FM_SELECTION);
//#UC END# *48FEFE040094_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.GetSelectCount

constructor TnsAttributeOneLevelTreeStruct.CreateFiltered(const aNewRoot: INodeBase;
 aSource: TnsFilterableTreeStruct;
 const aFilters: Il3TreeFilters);
//#UC START# *48FF458602EC_4683698E01BC_var*
//#UC END# *48FF458602EC_4683698E01BC_var*
begin
//#UC START# *48FF458602EC_4683698E01BC_impl*
 inherited;
 if aSource is TnsAttributeOneLevelTreeStruct then
  AssignInfo(aSource as InsTaggedTreeInfo);
//#UC END# *48FF458602EC_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.CreateFiltered

function TnsAttributeOneLevelTreeStruct.MakeFilters: Il3TreeFilters;
//#UC START# *48FF4C25031E_4683698E01BC_var*
//#UC END# *48FF4C25031E_4683698E01BC_var*
begin
//#UC START# *48FF4C25031E_4683698E01BC_impl*
 Result := TnsAttributeTreeFilters.Make;
//#UC END# *48FF4C25031E_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.MakeFilters

procedure TnsAttributeOneLevelTreeStruct.FillFilters(const aFilters: Il3TreeFilters;
 const anAdapterFilters: InsAdapterFilters);
//#UC START# *48FF520E03A0_4683698E01BC_var*
var
 l_Filters: InsAttributeTreeFilters;
//#UC END# *48FF520E03A0_4683698E01BC_var*
begin
//#UC START# *48FF520E03A0_4683698E01BC_impl*
 inherited;
 if Supports(aFilters, InsAttributeTreeFilters, l_Filters) then
  case l_Filters.FIlterType of
   ns_ftTrim: anAdapterFilters.Trim.SetIsTrimmed(True);
   ns_ftTrimLeaf: anAdapterFilters.TrimLeaf;
   ns_ftBlocks: anAdapterFilters.MakeBlocksFilter;
   ns_ftInpharm: anAdapterFilters.MakeInpharmFilter;
  end;
//#UC END# *48FF520E03A0_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.FillFilters

function TnsAttributeOneLevelTreeStruct.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_4683698E01BC_var*
//#UC END# *48FF56D003E6_4683698E01BC_var*
begin
//#UC START# *48FF56D003E6_4683698E01BC_impl*
 Result := nsEStr(Tag);
//#UC END# *48FF56D003E6_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.SettingsID

procedure TnsAttributeOneLevelTreeStruct.BeforeReset;
//#UC START# *48FF64E700E5_4683698E01BC_var*
//#UC END# *48FF64E700E5_4683698E01BC_var*
begin
//#UC START# *48FF64E700E5_4683698E01BC_impl*
 inherited;
 TnsAttributeTreeCacheNew.Instance.Clear;
 if f_Root <> nil then
 begin
  if Assigned(Tag) and
     ServerOneLevel then
   BeenReseted := rtsOneLevel
  else
   BeenReseted := rtsRoot;
 end
 else
  BeenReseted := rtsNone;
//#UC END# *48FF64E700E5_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.BeforeReset

procedure TnsAttributeOneLevelTreeStruct.TagChanged;
 {* Tag сменился }
//#UC START# *490071C401C8_4683698E01BC_var*
//#UC END# *490071C401C8_4683698E01BC_var*
begin
//#UC START# *490071C401C8_4683698E01BC_impl*
 inherited;
 ReAquireContextFilterParams;
//#UC END# *490071C401C8_4683698E01BC_impl*
end;//TnsAttributeOneLevelTreeStruct.TagChanged

end.
