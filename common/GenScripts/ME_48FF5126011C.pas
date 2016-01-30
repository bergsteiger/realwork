unit nsAdapterFilters;
 {* Реализация фабрики адаптерных фильтров }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsAdapterFilters.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , bsInterfaces
 , DynamicTreeUnit
 , SecurityUnit
;

type
 TnsAdapterFilters = class(Tl3CacheableBase, InsAdapterFilters)
  {* Реализация фабрики адаптерных фильтров }
  private
   f_Context: IContextFilter;
   f_UserFlags: IUserFilter;
   f_Layer: ILayerFilter;
   f_Trim: ITrimFilter;
   f_TrimLeaf: ITrimLeafFilter;
   f_Country: ICountryFilter;
   f_CutToLeaf: ICutToLeafCountFilter;
   f_Blocks: IBlocksFilter;
   f_Inpharm: IInpharmFilter;
   f_PromptsTreeFilter: IVariantsForDocFilter;
  private
   function ContextFilterUsed: Boolean;
  protected
   procedure ClearFilters;
   function MakeFilterList: IFilterList;
   function FiltersCount: Integer;
   function HasPrefilters: Boolean;
   function MakePrefilterList: IFilterList;
   procedure MakeTrimLeafFilter;
   procedure MakeBlocksFilter;
   function pm_GetContext: IContextFilter;
   function pm_GetUserFlags: IUserFilter;
   function pm_GetLayer: ILayerFilter;
   function pm_GetTrim: ITrimFilter;
   function pm_GetTrimLeaf: ITrimLeafFilter;
   function pm_GetCountry: ICountryFilter;
   function pm_GetCutToLeaf: ICutToLeafCountFilter;
   function pm_GetBlocks: IBlocksFilter;
   function Get_Inpharm: IInpharmFilter;
   procedure MakeInpharmFilter;
   function Get_PromptsTreeFilter: IVariantsForDocFilter;
   function MakePromptsTreeFilter(aDocID: LongWord): IVariantsForDocFilter;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make: InsAdapterFilters; reintroduce;
 end;//TnsAdapterFilters

implementation

uses
 l3ImplUses
 , IOUnit
 , DataAdapter
;

class function TnsAdapterFilters.Make: InsAdapterFilters;
var
 l_Inst : TnsAdapterFilters;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsAdapterFilters.Make

function TnsAdapterFilters.ContextFilterUsed: Boolean;
//#UC START# *4905E86F01BB_48FF5126011C_var*
var
 l_Context: IString;
//#UC END# *4905E86F01BB_48FF5126011C_var*
begin
//#UC START# *4905E86F01BB_48FF5126011C_impl*
 Result := False;
 if Assigned(f_Context) then
 begin
  f_Context.GetContext(l_Context);
  if Assigned(l_Context) and (l_Context.GetLength > 0) then
   Result := True;
 end;//Assigned(f_Context)
//#UC END# *4905E86F01BB_48FF5126011C_impl*
end;//TnsAdapterFilters.ContextFilterUsed

procedure TnsAdapterFilters.ClearFilters;
//#UC START# *4905E946006B_48FF5126011C_var*
//#UC END# *4905E946006B_48FF5126011C_var*
begin
//#UC START# *4905E946006B_48FF5126011C_impl*
 f_Context := nil;
 f_UserFlags := nil;
 f_Layer := nil;
 f_Trim := nil;
 f_TrimLeaf := nil;
 f_Country := nil;
 f_CutToLeaf := nil;
 f_Blocks := nil;
 f_Inpharm := nil;
 f_PromptsTreeFilter := nil;
//#UC END# *4905E946006B_48FF5126011C_impl*
end;//TnsAdapterFilters.ClearFilters

function TnsAdapterFilters.MakeFilterList: IFilterList;
//#UC START# *490595C30161_48FF5126011C_var*

 procedure lp_AddFilter(const aFilter: IFilterForTree);
 begin
  if Assigned(aFilter) then
   Result.Add(aFilter)
 end;

//#UC END# *490595C30161_48FF5126011C_var*
begin
//#UC START# *490595C30161_48FF5126011C_impl*
 Result := defDataAdapter.NativeAdapter.MakeFilterList;
 if ContextFilterUsed then
  lp_AddFilter(f_Context);
 lp_AddFilter(f_UserFlags);
 lp_AddFilter(f_Layer);
 lp_AddFilter(f_Trim);
 lp_AddFilter(f_Country);
 lp_AddFilter(f_CutToLeaf);
 lp_AddFilter(f_Blocks);
 lp_AddFilter(f_Inpharm);
//#UC END# *490595C30161_48FF5126011C_impl*
end;//TnsAdapterFilters.MakeFilterList

function TnsAdapterFilters.FiltersCount: Integer;
//#UC START# *490595D402BD_48FF5126011C_var*
//#UC END# *490595D402BD_48FF5126011C_var*
begin
//#UC START# *490595D402BD_48FF5126011C_impl*
 Result := 0;
 // Считаем количество фильтров
 if ContextFilterUsed then
  inc(Result);
 if Assigned(f_UserFlags) then
  inc(Result);
 if Assigned(f_Layer) then
  inc(Result);
 if Assigned(f_Trim) then
  inc(Result);
 if Assigned(f_TrimLeaf) then
  inc(Result);
 if Assigned(f_Country) then
  inc(Result);
 if Assigned(f_CutToLeaf) then
  inc(Result);
 if Assigned(f_Blocks) then
  inc(Result);
 if Assigned(f_Inpharm) then
  inc(Result);
 if Assigned(f_PromptsTreeFilter) then
  inc(Result);
//#UC END# *490595D402BD_48FF5126011C_impl*
end;//TnsAdapterFilters.FiltersCount

function TnsAdapterFilters.HasPrefilters: Boolean;
//#UC START# *490595E10299_48FF5126011C_var*
//#UC END# *490595E10299_48FF5126011C_var*
begin
//#UC START# *490595E10299_48FF5126011C_impl*
 Result := Assigned(f_TrimLeaf) or Assigned(f_PromptsTreeFilter);
//#UC END# *490595E10299_48FF5126011C_impl*
end;//TnsAdapterFilters.HasPrefilters

function TnsAdapterFilters.MakePrefilterList: IFilterList;
//#UC START# *490595EE0289_48FF5126011C_var*
//#UC END# *490595EE0289_48FF5126011C_var*
begin
//#UC START# *490595EE0289_48FF5126011C_impl*
 Result := defDataAdapter.NativeAdapter.MakeFilterList;
 if Assigned(f_TrimLeaf) then
  Result.Add(f_TrimLeaf);
 if Assigned(f_PromptsTreeFilter) then
  Result.Add(f_PromptsTreeFilter);
//#UC END# *490595EE0289_48FF5126011C_impl*
end;//TnsAdapterFilters.MakePrefilterList

procedure TnsAdapterFilters.MakeTrimLeafFilter;
//#UC START# *490595F90107_48FF5126011C_var*
//#UC END# *490595F90107_48FF5126011C_var*
begin
//#UC START# *490595F90107_48FF5126011C_impl*
 f_TrimLeaf := defDataAdapter.NativeAdapter.MakeTrimLeafFilter;
//#UC END# *490595F90107_48FF5126011C_impl*
end;//TnsAdapterFilters.MakeTrimLeafFilter

procedure TnsAdapterFilters.MakeBlocksFilter;
//#UC START# *4905960301EF_48FF5126011C_var*
//#UC END# *4905960301EF_48FF5126011C_var*
begin
//#UC START# *4905960301EF_48FF5126011C_impl*
 f_Blocks := defDataAdapter.NativeAdapter.MakeBlocksFilter;
//#UC END# *4905960301EF_48FF5126011C_impl*
end;//TnsAdapterFilters.MakeBlocksFilter

function TnsAdapterFilters.pm_GetContext: IContextFilter;
//#UC START# *490596110042_48FF5126011Cget_var*
//#UC END# *490596110042_48FF5126011Cget_var*
begin
//#UC START# *490596110042_48FF5126011Cget_impl*
 if (f_Context = nil) and Assigned(DefDataAdapter) then
  f_Context := defDataAdapter.NativeAdapter.MakeContextFilter;
 Result := f_Context;
//#UC END# *490596110042_48FF5126011Cget_impl*
end;//TnsAdapterFilters.pm_GetContext

function TnsAdapterFilters.pm_GetUserFlags: IUserFilter;
//#UC START# *49059620001F_48FF5126011Cget_var*
//#UC END# *49059620001F_48FF5126011Cget_var*
begin
//#UC START# *49059620001F_48FF5126011Cget_impl*
 if (f_UserFlags = nil) and Assigned(DefDataAdapter) then
  f_UserFlags := defDataAdapter.NativeAdapter.MakeUserFilter;
 Result := f_UserFlags;
//#UC END# *49059620001F_48FF5126011Cget_impl*
end;//TnsAdapterFilters.pm_GetUserFlags

function TnsAdapterFilters.pm_GetLayer: ILayerFilter;
//#UC START# *4905962D0036_48FF5126011Cget_var*
//#UC END# *4905962D0036_48FF5126011Cget_var*
begin
//#UC START# *4905962D0036_48FF5126011Cget_impl*
 if (f_Layer = nil) and Assigned(DefDataAdapter) then
  f_Layer := defDataAdapter.NativeAdapter.MakeLayerFilter;
 Result := f_Layer;
//#UC END# *4905962D0036_48FF5126011Cget_impl*
end;//TnsAdapterFilters.pm_GetLayer

function TnsAdapterFilters.pm_GetTrim: ITrimFilter;
//#UC START# *490596400201_48FF5126011Cget_var*
//#UC END# *490596400201_48FF5126011Cget_var*
begin
//#UC START# *490596400201_48FF5126011Cget_impl*
 if (f_Trim = nil) and Assigned(DefDataAdapter) then
  f_Trim := defDataAdapter.NativeAdapter.MakeTrimFilter;
 Result := f_Trim;
//#UC END# *490596400201_48FF5126011Cget_impl*
end;//TnsAdapterFilters.pm_GetTrim

function TnsAdapterFilters.pm_GetTrimLeaf: ITrimLeafFilter;
//#UC START# *4905964F0196_48FF5126011Cget_var*
//#UC END# *4905964F0196_48FF5126011Cget_var*
begin
//#UC START# *4905964F0196_48FF5126011Cget_impl*
 if (f_TrimLeaf = nil) and Assigned(DefDataAdapter) then
  MakeTrimLeafFilter;
 Result := f_TrimLeaf;
//#UC END# *4905964F0196_48FF5126011Cget_impl*
end;//TnsAdapterFilters.pm_GetTrimLeaf

function TnsAdapterFilters.pm_GetCountry: ICountryFilter;
//#UC START# *4905965B03A2_48FF5126011Cget_var*
//#UC END# *4905965B03A2_48FF5126011Cget_var*
begin
//#UC START# *4905965B03A2_48FF5126011Cget_impl*
 if (f_Country = nil) and Assigned(DefDataAdapter) then
  f_Country := defDataAdapter.NativeAdapter.MakeCountryFilter;
 Result := f_Country;
//#UC END# *4905965B03A2_48FF5126011Cget_impl*
end;//TnsAdapterFilters.pm_GetCountry

function TnsAdapterFilters.pm_GetCutToLeaf: ICutToLeafCountFilter;
//#UC START# *49059668030F_48FF5126011Cget_var*
//#UC END# *49059668030F_48FF5126011Cget_var*
begin
//#UC START# *49059668030F_48FF5126011Cget_impl*
 if (f_CutToLeaf = nil) and Assigned(DefDataAdapter) then
  f_CutToLeaf := defDataAdapter.NativeAdapter.MakeCutToLeafCountFilter;
 Result := f_CutToLeaf;
//#UC END# *49059668030F_48FF5126011Cget_impl*
end;//TnsAdapterFilters.pm_GetCutToLeaf

function TnsAdapterFilters.pm_GetBlocks: IBlocksFilter;
//#UC START# *4905967D0333_48FF5126011Cget_var*
//#UC END# *4905967D0333_48FF5126011Cget_var*
begin
//#UC START# *4905967D0333_48FF5126011Cget_impl*
 if (f_Blocks = nil) and Assigned(DefDataAdapter) then
  MakeBlocksFilter;
 Result := f_Blocks;
//#UC END# *4905967D0333_48FF5126011Cget_impl*
end;//TnsAdapterFilters.pm_GetBlocks

function TnsAdapterFilters.Get_Inpharm: IInpharmFilter;
//#UC START# *4A8BE475022C_48FF5126011Cget_var*
//#UC END# *4A8BE475022C_48FF5126011Cget_var*
begin
//#UC START# *4A8BE475022C_48FF5126011Cget_impl*
 if (f_Inpharm = nil) and Assigned(DefDataAdapter) then
  MakeInpharmFilter;
 Result := f_Inpharm;
//#UC END# *4A8BE475022C_48FF5126011Cget_impl*
end;//TnsAdapterFilters.Get_Inpharm

procedure TnsAdapterFilters.MakeInpharmFilter;
//#UC START# *4A8BE4990157_48FF5126011C_var*
//#UC END# *4A8BE4990157_48FF5126011C_var*
begin
//#UC START# *4A8BE4990157_48FF5126011C_impl*
 f_Inpharm := defDataAdapter.NativeAdapter.MakeInpharmFilter;
//#UC END# *4A8BE4990157_48FF5126011C_impl*
end;//TnsAdapterFilters.MakeInpharmFilter

function TnsAdapterFilters.Get_PromptsTreeFilter: IVariantsForDocFilter;
//#UC START# *4AA4D48B0234_48FF5126011Cget_var*
//#UC END# *4AA4D48B0234_48FF5126011Cget_var*
begin
//#UC START# *4AA4D48B0234_48FF5126011Cget_impl*
 if (f_PromptsTreeFilter = nil) and Assigned(DefDataAdapter) then
  MakePromptsTreeFilter(0);
 Result := f_PromptsTreeFilter;
//#UC END# *4AA4D48B0234_48FF5126011Cget_impl*
end;//TnsAdapterFilters.Get_PromptsTreeFilter

function TnsAdapterFilters.MakePromptsTreeFilter(aDocID: LongWord): IVariantsForDocFilter;
//#UC START# *4AA4D4B0013D_48FF5126011C_var*
//#UC END# *4AA4D4B0013D_48FF5126011C_var*
begin
//#UC START# *4AA4D4B0013D_48FF5126011C_impl*
 f_PromptsTreeFilter := defDataAdapter.NativeAdapter.MakeVariantsForDocFilter(aDocID);
//#UC END# *4AA4D4B0013D_48FF5126011C_impl*
end;//TnsAdapterFilters.MakePromptsTreeFilter

procedure TnsAdapterFilters.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48FF5126011C_var*
//#UC END# *479731C50290_48FF5126011C_var*
begin
//#UC START# *479731C50290_48FF5126011C_impl*
 ClearFilters;
 inherited;
//#UC END# *479731C50290_48FF5126011C_impl*
end;//TnsAdapterFilters.Cleanup

end.
