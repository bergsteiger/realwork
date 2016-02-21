unit nsAttributeTreeStruct;
 {* Коллеги, а чем это от TnsAttrOneLevelStruct отличается? }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsAttributeTreeStruct.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsDataResetTreeStruct
 , l3TreeInterfaces
 , l3Interfaces
 , DynamicTreeUnit
 , afwInterfaces
 , nsFilterableTreeStruct
 , bsInterfaces
 , SearchDomainInterfaces
;

type
 _nsTaggedTreeInfo_Parent_ = TnsDataResetTreeStruct;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsTaggedTreeInfo.imp.pas}
 TnsAttributeTreeStruct = class(_nsTaggedTreeInfo_)
  {* Коллеги, а чем это от TnsAttrOneLevelStruct отличается? }
  protected
   function ReAqurieUnfilteredRoot: INodeBase; override;
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
   class function Make(const aTag: Il3CString;
    aShowRoot: Boolean): Il3SimpleTree;
    {* Создаёт дерево }
 end;//TnsAttributeTreeStruct

implementation

uses
 l3ImplUses
 , nsConst
 , nsTypes
 , nsAttributeTreeFilters
 , SysUtils
 , l3String
 , nsAttributeTreeCacheNew
 , bsUtils
;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Search\nsTaggedTreeInfo.imp.pas}

class function TnsAttributeTreeStruct.Make(const aTag: Il3CString;
 aShowRoot: Boolean): Il3SimpleTree;
 {* Создаёт дерево }
//#UC START# *49086BA900AA_468364C70131_var*
var
 l_Node: INodeBase;
 l_Interface: InsTaggedTreeInfo;
//#UC END# *49086BA900AA_468364C70131_var*
begin
//#UC START# *49086BA900AA_468364C70131_impl*
 Result := nil;
 l_Node := TnsAttributeTreeCacheNew.Instance.AttributeRoot[aTag];
 try
  if (l_Node <> nil) then
  begin
   Result := inherited Make(l_Node, aShowRoot);
   if Supports(Result, InsTaggedTreeInfo, l_Interface) then
    l_Interface.Tag := aTag;
  end;//l_Node <> nil
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *49086BA900AA_468364C70131_impl*
end;//TnsAttributeTreeStruct.Make

function TnsAttributeTreeStruct.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_468364C70131_var*
//#UC END# *48FF64F60078_468364C70131_var*
begin
//#UC START# *48FF64F60078_468364C70131_impl*
 if not l3IsNil(Tag) then
  case BeenReseted of
   rtsRoot :
    Result := TnsAttributeTreeCacheNew.Instance.AttributeRoot[Tag];
   else
    Result := inherited ReAqurieUnfilteredRoot;
  end
 else
  Result := inherited ReAqurieUnfilteredRoot;
//#UC END# *48FF64F60078_468364C70131_impl*
end;//TnsAttributeTreeStruct.ReAqurieUnfilteredRoot

constructor TnsAttributeTreeStruct.CreateFiltered(const aNewRoot: INodeBase;
 aSource: TnsFilterableTreeStruct;
 const aFilters: Il3TreeFilters);
//#UC START# *48FF458602EC_468364C70131_var*
//#UC END# *48FF458602EC_468364C70131_var*
begin
//#UC START# *48FF458602EC_468364C70131_impl*
 inherited;
 if aSource is TnsAttributeTreeStruct then
  AssignInfo(aSource as InsTaggedTreeInfo);
//#UC END# *48FF458602EC_468364C70131_impl*
end;//TnsAttributeTreeStruct.CreateFiltered

function TnsAttributeTreeStruct.MakeFilters: Il3TreeFilters;
//#UC START# *48FF4C25031E_468364C70131_var*
//#UC END# *48FF4C25031E_468364C70131_var*
begin
//#UC START# *48FF4C25031E_468364C70131_impl*
 Result := TnsAttributeTreeFilters.Make;
//#UC END# *48FF4C25031E_468364C70131_impl*
end;//TnsAttributeTreeStruct.MakeFilters

procedure TnsAttributeTreeStruct.FillFilters(const aFilters: Il3TreeFilters;
 const anAdapterFilters: InsAdapterFilters);
//#UC START# *48FF520E03A0_468364C70131_var*
var
 l_Filters: InsAttributeTreeFilters;
//#UC END# *48FF520E03A0_468364C70131_var*
begin
//#UC START# *48FF520E03A0_468364C70131_impl*
 inherited;
 if Supports(aFilters, InsAttributeTreeFilters, l_Filters) then
  case l_Filters.FIlterType of
   ns_ftTrim: anAdapterFilters.Trim.SetIsTrimmed(True);
   ns_ftTrimLeaf: anAdapterFilters.MakeTrimLeafFilter;
   ns_ftBlocks: anAdapterFilters.MakeBlocksFilter;
   ns_ftInpharm: anAdapterFilters.MakeInpharmFilter;
  end;
//#UC END# *48FF520E03A0_468364C70131_impl*
end;//TnsAttributeTreeStruct.FillFilters

function TnsAttributeTreeStruct.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_468364C70131_var*
//#UC END# *48FF56D003E6_468364C70131_var*
begin
//#UC START# *48FF56D003E6_468364C70131_impl*
 Result := nsEStr(Tag);
//#UC END# *48FF56D003E6_468364C70131_impl*
end;//TnsAttributeTreeStruct.SettingsID

procedure TnsAttributeTreeStruct.BeforeReset;
//#UC START# *48FF64E700E5_468364C70131_var*
//#UC END# *48FF64E700E5_468364C70131_var*
begin
//#UC START# *48FF64E700E5_468364C70131_impl*
 TnsAttributeTreeCacheNew.Instance.Clear;
 inherited;
//#UC END# *48FF64E700E5_468364C70131_impl*
end;//TnsAttributeTreeStruct.BeforeReset

procedure TnsAttributeTreeStruct.TagChanged;
 {* Tag сменился }
//#UC START# *490071C401C8_468364C70131_var*
//#UC END# *490071C401C8_468364C70131_var*
begin
//#UC START# *490071C401C8_468364C70131_impl*
 inherited;
 ReAquireContextFilterParams;
//#UC END# *490071C401C8_468364C70131_impl*
end;//TnsAttributeTreeStruct.TagChanged

end.
