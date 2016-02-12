unit k2OpRefList;
 {* Список операций. }

// Модуль: "w:\common\components\rtl\Garant\K2\k2OpRefList.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2Op
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 //#UC START# *47E3C9C8033Bci*
 {$Define l3Items_NoChanging}
 //#UC END# *47E3C9C8033Bci*
 _ItemType_ = Tk2Op;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 //#UC START# *47E3C9C8033Bcit*
 //#UC END# *47E3C9C8033Bcit*
 Tk2OpRefList = class(_l3UncomparabeObjectRefList_)
  {* Список операций. }
 //#UC START# *47E3C9C8033Bpubl*
 //#UC END# *47E3C9C8033Bpubl*
 end;//Tk2OpRefList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47E3C9C8033B_var*
//#UC END# *47B2C42A0163_47E3C9C8033B_var*
begin
//#UC START# *47B2C42A0163_47E3C9C8033B_impl*
 //aTo.Assign(aFrom);
 Assert(false);
//#UC END# *47B2C42A0163_47E3C9C8033B_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47E3C9C8033B_var*
//#UC END# *47B99D4503A2_47E3C9C8033B_var*
begin
//#UC START# *47B99D4503A2_47E3C9C8033B_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA^.CompareWith(CI.rB^);
 //Result := -1;
 //Assert(false, 'Зачем операции сортировать?');
 // - а вот зачем - http://mdp.garant.ru/pages/viewpage.action?pageId=269066487
 //   не сортировать, а искать.
//#UC END# *47B99D4503A2_47E3C9C8033B_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2OpRefList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

//#UC START# *47E3C9C8033Bimpl*
//#UC END# *47E3C9C8033Bimpl*

end.
