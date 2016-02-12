unit vcmEntitiesDefIteratorForContextMenu;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntitiesDefIteratorForContextMenu.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmEntityDef;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TvcmEntitiesDefIteratorForContextMenu = class(_l3InterfaceRefListPrim_, IvcmEntitiesDefIterator)
  private
   f_Iter: IvcmEntitiesDefIterator;
   f_Index: Integer;
  protected
   function Get_Next: IvcmEntityDef;
   procedure ClearFields; override;
  public
   constructor Create(const anIter: IvcmEntitiesDefIterator); reintroduce;
   class function Make(const anIter: IvcmEntitiesDefIterator): IvcmEntitiesDefIterator; reintroduce;
 end;//TvcmEntitiesDefIteratorForContextMenu
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmEntityDefForContextMenu
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_51D128930090_var*
//#UC END# *47B07CF403D0_51D128930090_var*
begin
//#UC START# *47B07CF403D0_51D128930090_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_51D128930090_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_51D128930090_var*
//#UC END# *47B2C42A0163_51D128930090_var*
begin
//#UC START# *47B2C42A0163_51D128930090_impl*
 assert(false);
//#UC END# *47B2C42A0163_51D128930090_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_51D128930090_var*
//#UC END# *47B99D4503A2_51D128930090_var*
begin
//#UC START# *47B99D4503A2_51D128930090_impl*
  Result := CI.rA.ContextMenuWeight - CI.rB.ContextMenuWeight;
//#UC END# *47B99D4503A2_51D128930090_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmEntitiesDefIteratorForContextMenu;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

constructor TvcmEntitiesDefIteratorForContextMenu.Create(const anIter: IvcmEntitiesDefIterator);
//#UC START# *51D12A5F02EE_51D128930090_var*
var
 l_E : IvcmEntityDef;
//#UC END# *51D12A5F02EE_51D128930090_var*
begin
//#UC START# *51D12A5F02EE_51D128930090_impl*
 inherited Create;
 f_Index := 0;
 f_Iter := anIter;

 // Это нужно здесь, потому что иначе меняется порядок операций с
 // незаданными (нулевыми) весами
 // http://mdp.garant.ru/pages/viewpage.action?pageId=467276976
 Self.Duplicates := l3_dupAccept;
 Self.Sorted := true;
 while true do
 begin
  l_E := anIter.Next;
  if (l_E = nil) then
   break;
  Self.Add(l_E);
 end;
//#UC END# *51D12A5F02EE_51D128930090_impl*
end;//TvcmEntitiesDefIteratorForContextMenu.Create

class function TvcmEntitiesDefIteratorForContextMenu.Make(const anIter: IvcmEntitiesDefIterator): IvcmEntitiesDefIterator;
var
 l_Inst : TvcmEntitiesDefIteratorForContextMenu;
begin
 l_Inst := Create(anIter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmEntitiesDefIteratorForContextMenu.Make

function TvcmEntitiesDefIteratorForContextMenu.Get_Next: IvcmEntityDef;
//#UC START# *49956DB300D6_51D128930090get_var*
//#UC END# *49956DB300D6_51D128930090get_var*
begin
//#UC START# *49956DB300D6_51D128930090get_impl*
 if (f_Index >= Self.Count) then
  Result := nil
 else
 begin
  Result := TvcmEntityDefForContextMenu.Make(Self.Items[f_Index]);
  Inc(f_Index);
 end;
//#UC END# *49956DB300D6_51D128930090get_impl*
end;//TvcmEntitiesDefIteratorForContextMenu.Get_Next

procedure TvcmEntitiesDefIteratorForContextMenu.ClearFields;
begin
 f_Iter := nil;
 inherited;
end;//TvcmEntitiesDefIteratorForContextMenu.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
