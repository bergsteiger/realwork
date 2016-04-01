unit nsDictCachePrim;

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\Diction\nsDictCachePrim.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TnsDictCachePrim" MUID: (4908190C017C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3CacheableBase
 , nsLangList
 , DynamicTreeUnit
 , bsTypes
 , afwInterfaces
;

type
 _afwApplicationDataUpdate_Parent_ = Tl3CacheableBase;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TnsDictCachePrim = class(_afwApplicationDataUpdate_)
  private
   f_AvailableLangs: TnsLangList;
   f_IsRootReceived: Boolean;
    {* определ€ет получали ли мы корень дерева толковани€ с адаптера. ƒл€
           случа€, когда обновились на базу без толкового словар€ и дл€ кнопок
           панели иснтрументов спрашиваем доступные €зыки, это позволит
           избавитс€ от большого количества серверных вызоов }
   f_Root: INodeBase;
  protected
   function pm_GetRoot: INodeBase;
   function DoGetRoot: INodeBase; virtual; abstract;
   procedure Cleanup; override;
    {* ‘ункци€ очистки полей объекта. }
   procedure FinishDataUpdate; override;
   procedure ClearFields; override;
  public
   procedure ClearCache; virtual;
   function ContainsLang(aLang: TbsLanguage): Boolean;
  protected
   property IsRootReceived: Boolean
    read f_IsRootReceived
    write f_IsRootReceived;
    {* определ€ет получали ли мы корень дерева толковани€ с адаптера. ƒл€
           случа€, когда обновились на базу без толкового словар€ и дл€ кнопок
           панели иснтрументов спрашиваем доступные €зыки, это позволит
           избавитс€ от большого количества серверных вызоов }
  public
   property Root: INodeBase
    read pm_GetRoot;
 end;//TnsDictCachePrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , bsConvert
 , DataAdapter
 , nsTypes
 , l3Base
 , afwFacade
;

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

function TnsDictCachePrim.pm_GetRoot: INodeBase;
//#UC START# *490819DA005E_4908190C017Cget_var*
//#UC END# *490819DA005E_4908190C017Cget_var*
begin
//#UC START# *490819DA005E_4908190C017Cget_impl*
 if not IsRootReceived then
 begin
  try
   f_Root := DoGetRoot;
  except
   f_Root := nil;
   // - сюда попадаем например когда толковый словарь пропал
  end;//try..except
  IsRootReceived := True;
 end;//if not IsRootReceived then
 Result := f_Root;
//#UC END# *490819DA005E_4908190C017Cget_impl*
end;//TnsDictCachePrim.pm_GetRoot

procedure TnsDictCachePrim.ClearCache;
//#UC START# *49081A3A00AC_4908190C017C_var*
//#UC END# *49081A3A00AC_4908190C017C_var*
begin
//#UC START# *49081A3A00AC_4908190C017C_impl*
 f_Root := nil;
 IsRootReceived := False;
 l3Free(f_AvailableLangs);
//#UC END# *49081A3A00AC_4908190C017C_impl*
end;//TnsDictCachePrim.ClearCache

function TnsDictCachePrim.ContainsLang(aLang: TbsLanguage): Boolean;
//#UC START# *49081A4F001E_4908190C017C_var*
var
 l_Layers : ILayerIdList;
 l_Index  : Integer;
 l_PLayer : TLayerId;
//#UC END# *49081A4F001E_4908190C017C_var*
begin
//#UC START# *49081A4F001E_4908190C017C_impl*
 Result := False;
 if not Assigned(f_AvailableLangs) and Assigned(Root) then
 begin
  f_AvailableLangs := TnsLangList.Create;
  Root.GetAvailableLayers(l_Layers);
  if l_Layers <> nil then
   for l_Index :=0 to l_Layers.Count - 1 do
   begin
    l_PLayer := l_Layers[l_Index];
    f_AvailableLangs.Add(bsAdapterToBusiness(l_PLayer));
   end;//for l_Index :=0 to l_Layers.GetCount - 1 do
 end;//if Root <> nil then
 // ѕроверим наличие €зыков, они могут быть не созданы в случае открыти€
 // толкового словар€, потом обновлени€ базой без толкового словар€
 if Assigned(f_AvailableLangs) then
  Result := f_AvailableLangs.IndexOf(aLang) >= 0;
//#UC END# *49081A4F001E_4908190C017C_impl*
end;//TnsDictCachePrim.ContainsLang

procedure TnsDictCachePrim.Cleanup;
 {* ‘ункци€ очистки полей объекта. }
//#UC START# *479731C50290_4908190C017C_var*
//#UC END# *479731C50290_4908190C017C_var*
begin
//#UC START# *479731C50290_4908190C017C_impl*
 f_Root := nil;
 l3Free(f_AvailableLangs);
 inherited;
//#UC END# *479731C50290_4908190C017C_impl*
end;//TnsDictCachePrim.Cleanup

procedure TnsDictCachePrim.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4908190C017C_var*
//#UC END# *47EA4E9002C6_4908190C017C_var*
begin
//#UC START# *47EA4E9002C6_4908190C017C_impl*
 inherited;
 ClearCache;
//#UC END# *47EA4E9002C6_4908190C017C_impl*
end;//TnsDictCachePrim.FinishDataUpdate

procedure TnsDictCachePrim.ClearFields;
begin
 f_Root := nil;
 inherited;
end;//TnsDictCachePrim.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
