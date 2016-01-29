unit bsUserCRListInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Морозов М.А
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/bsUserCRListInfo.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::BaseDocument::TbsUserCRListInfo
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
  bsTypes,
  bsInterfaces,
  DocumentAndListInterfaces,
  bsBase,
  l3Interfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsUserCRListInfo = class(TbsBase, IbsUserCRListInfoModify)
 private
 // private fields
   f_Node : IbsFrozenNode;
   f_Has : Boolean;
   f_ListType : TlstCRType;
   f_KindOfList : TbsUserCRList;
 protected
 // realized methods
   function IsSame(const aValue: IbsUserCRListInfo): Boolean;
     {* определяет равенство }
   function pm_GetHas: Boolean;
   function pm_GetCaption: Il3CString;
   function pm_GetListType: TlstCRType;
   function pm_GetNode: IbsFrozenNode;
   function pm_GetKindOfList: TbsUserCRList;
   procedure Assign(const aValue: IbsUserCRListInfo);
     {* скопировать данные }
   procedure pm_SetWListType(aValue: TlstCRType);
   procedure pm_SetWKindOfList(aValue: TbsUserCRList);
   procedure pm_SetWNode(const aValue: IbsFrozenNode);
   procedure pm_SetWHas(aValue: Boolean);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Make: IbsUserCRListInfoModify; reintroduce;
 end;//TbsUserCRListInfo
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  bsFrozenNode,
  IOUnit,
  nsTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TbsUserCRListInfo

class function TbsUserCRListInfo.Make: IbsUserCRListInfoModify;
var
 l_Inst : TbsUserCRListInfo;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TbsUserCRListInfo.IsSame(const aValue: IbsUserCRListInfo): Boolean;
//#UC START# *4937CC7E0049_493D4E4D0146_var*
//#UC END# *4937CC7E0049_493D4E4D0146_var*
begin
//#UC START# *4937CC7E0049_493D4E4D0146_impl*
 Result := (f_Has = aValue.Has) and pm_GetNode.IsSame(aValue.Node)
  and (f_KindOfList = aValue.KindOfList) and (f_ListType = aValue.ListType);
//#UC END# *4937CC7E0049_493D4E4D0146_impl*
end;//TbsUserCRListInfo.IsSame

function TbsUserCRListInfo.pm_GetHas: Boolean;
//#UC START# *4937CCD101B0_493D4E4D0146get_var*
//#UC END# *4937CCD101B0_493D4E4D0146get_var*
begin
//#UC START# *4937CCD101B0_493D4E4D0146get_impl*
 Result := f_Has;
//#UC END# *4937CCD101B0_493D4E4D0146get_impl*
end;//TbsUserCRListInfo.pm_GetHas

function TbsUserCRListInfo.pm_GetCaption: Il3CString;
//#UC START# *4937CFC80211_493D4E4D0146get_var*
var
 l_Caption: IString;
//#UC END# *4937CFC80211_493D4E4D0146get_var*
begin
//#UC START# *4937CFC80211_493D4E4D0146get_impl*
 if (f_Node <> nil) and f_Node.HasNode then
  f_Node.Value.GetCaption(l_Caption)
 else
  l_Caption := nil;
 Result := nsCStr(l_Caption);
//#UC END# *4937CFC80211_493D4E4D0146get_impl*
end;//TbsUserCRListInfo.pm_GetCaption

function TbsUserCRListInfo.pm_GetListType: TlstCRType;
//#UC START# *4937D00801D6_493D4E4D0146get_var*
//#UC END# *4937D00801D6_493D4E4D0146get_var*
begin
//#UC START# *4937D00801D6_493D4E4D0146get_impl*
 Result := f_ListType;
//#UC END# *4937D00801D6_493D4E4D0146get_impl*
end;//TbsUserCRListInfo.pm_GetListType

function TbsUserCRListInfo.pm_GetNode: IbsFrozenNode;
//#UC START# *4937D06103D0_493D4E4D0146get_var*
//#UC END# *4937D06103D0_493D4E4D0146get_var*
begin
//#UC START# *4937D06103D0_493D4E4D0146get_impl*
 if f_Node = nil then
  f_Node := TbsFrozenNode.Make(nil);
 Result := f_Node;
//#UC END# *4937D06103D0_493D4E4D0146get_impl*
end;//TbsUserCRListInfo.pm_GetNode

function TbsUserCRListInfo.pm_GetKindOfList: TbsUserCRList;
//#UC START# *4937D0E9032C_493D4E4D0146get_var*
//#UC END# *4937D0E9032C_493D4E4D0146get_var*
begin
//#UC START# *4937D0E9032C_493D4E4D0146get_impl*
 Result := f_KindOfList;
//#UC END# *4937D0E9032C_493D4E4D0146get_impl*
end;//TbsUserCRListInfo.pm_GetKindOfList

procedure TbsUserCRListInfo.Assign(const aValue: IbsUserCRListInfo);
//#UC START# *4B17E77A0383_493D4E4D0146_var*
//#UC END# *4B17E77A0383_493D4E4D0146_var*
begin
//#UC START# *4B17E77A0383_493D4E4D0146_impl*
 pm_GetNode.Assign(aValue.Node);
 f_Has := aValue.Has;
 f_ListType := aValue.ListType;
 f_KindOfList := aValue.KindOfList;
//#UC END# *4B17E77A0383_493D4E4D0146_impl*
end;//TbsUserCRListInfo.Assign

procedure TbsUserCRListInfo.pm_SetWListType(aValue: TlstCRType);
//#UC START# *4B17EFED0394_493D4E4D0146set_var*
//#UC END# *4B17EFED0394_493D4E4D0146set_var*
begin
//#UC START# *4B17EFED0394_493D4E4D0146set_impl*
 f_ListType := aValue;
//#UC END# *4B17EFED0394_493D4E4D0146set_impl*
end;//TbsUserCRListInfo.pm_SetWListType

procedure TbsUserCRListInfo.pm_SetWKindOfList(aValue: TbsUserCRList);
//#UC START# *4B17F0040151_493D4E4D0146set_var*
//#UC END# *4B17F0040151_493D4E4D0146set_var*
begin
//#UC START# *4B17F0040151_493D4E4D0146set_impl*
 f_KindOfList := aValue;
//#UC END# *4B17F0040151_493D4E4D0146set_impl*
end;//TbsUserCRListInfo.pm_SetWKindOfList

procedure TbsUserCRListInfo.pm_SetWNode(const aValue: IbsFrozenNode);
//#UC START# *4B17F0150365_493D4E4D0146set_var*
//#UC END# *4B17F0150365_493D4E4D0146set_var*
begin
//#UC START# *4B17F0150365_493D4E4D0146set_impl*
 f_Node := aValue;
//#UC END# *4B17F0150365_493D4E4D0146set_impl*
end;//TbsUserCRListInfo.pm_SetWNode

procedure TbsUserCRListInfo.pm_SetWHas(aValue: Boolean);
//#UC START# *4B17F03C0327_493D4E4D0146set_var*
//#UC END# *4B17F03C0327_493D4E4D0146set_var*
begin
//#UC START# *4B17F03C0327_493D4E4D0146set_impl*
 f_Has := aValue;
//#UC END# *4B17F03C0327_493D4E4D0146set_impl*
end;//TbsUserCRListInfo.pm_SetWHas

procedure TbsUserCRListInfo.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TbsUserCRListInfo.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.