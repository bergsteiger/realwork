unit vcmOperationsDefIteratorForContextMenu;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmOperationsDefIteratorForContextMenu.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmUserControls
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmOperationDef;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfaceRefListPrim.imp.pas}
 TvcmOperationsDefIteratorForContextMenu = class(_l3InterfaceRefListPrim_, IvcmOperationsDefIterator)
  private
   f_Iter: IvcmOperationsDefIterator;
   f_Index: Integer;
  protected
   function Get_Next: IvcmOperationDef;
   procedure ClearFields; override;
  public
   constructor Create(const anIter: IvcmOperationsDefIterator); reintroduce;
   class function Make(const anIter: IvcmOperationsDefIterator): IvcmOperationsDefIterator; reintroduce;
 end;//TvcmOperationsDefIteratorForContextMenu
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
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
//#UC START# *47B07CF403D0_51D14918034E_var*
//#UC END# *47B07CF403D0_51D14918034E_var*
begin
//#UC START# *47B07CF403D0_51D14918034E_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_51D14918034E_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_51D14918034E_var*
//#UC END# *47B2C42A0163_51D14918034E_var*
begin
//#UC START# *47B2C42A0163_51D14918034E_impl*
 assert(false);
//#UC END# *47B2C42A0163_51D14918034E_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_51D14918034E_var*
//#UC END# *47B99D4503A2_51D14918034E_var*
begin
//#UC START# *47B99D4503A2_51D14918034E_impl*
 Result := CI.rA.ContextMenuWeight - CI.rB.ContextMenuWeight;
//#UC END# *47B99D4503A2_51D14918034E_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmOperationsDefIteratorForContextMenu;

{$Include l3InterfaceRefListPrim.imp.pas}

constructor TvcmOperationsDefIteratorForContextMenu.Create(const anIter: IvcmOperationsDefIterator);
//#UC START# *51D149B9038D_51D14918034E_var*
var
 l_E : IvcmOperationDef;
//#UC END# *51D149B9038D_51D14918034E_var*
begin
//#UC START# *51D149B9038D_51D14918034E_impl*
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
//#UC END# *51D149B9038D_51D14918034E_impl*
end;//TvcmOperationsDefIteratorForContextMenu.Create

class function TvcmOperationsDefIteratorForContextMenu.Make(const anIter: IvcmOperationsDefIterator): IvcmOperationsDefIterator;
var
 l_Inst : TvcmOperationsDefIteratorForContextMenu;
begin
 l_Inst := Create(anIter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmOperationsDefIteratorForContextMenu.Make

function TvcmOperationsDefIteratorForContextMenu.Get_Next: IvcmOperationDef;
//#UC START# *4995645B02C7_51D14918034Eget_var*
//#UC END# *4995645B02C7_51D14918034Eget_var*
begin
//#UC START# *4995645B02C7_51D14918034Eget_impl*
 if (f_Index >= Self.Count) then
  Result := nil
 else
 begin
  Result := Self.Items[f_Index];
  Inc(f_Index);
 end;
//#UC END# *4995645B02C7_51D14918034Eget_impl*
end;//TvcmOperationsDefIteratorForContextMenu.Get_Next

procedure TvcmOperationsDefIteratorForContextMenu.ClearFields;
begin
 f_Iter := nil;
 inherited;
end;//TvcmOperationsDefIteratorForContextMenu.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

end.
