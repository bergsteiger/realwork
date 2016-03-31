{$IfNDef m3ListWithFind_imp}

// Модуль: "w:\common\components\rtl\Garant\m3\m3ListWithFind.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "m3ListWithFind" MUID: (545B7E6B00A1)
// Имя типа: "_m3ListWithFind_"

{$Define m3ListWithFind_imp}

 // _KeyType_

 {$Include w:\common\components\rtl\Garant\m3\m3AutoAllocList.imp.pas}
 _m3ListWithFind_ = class(_m3AutoAllocList_)
  protected
   function CompareKeyByItem(const aKey: _KeyType_;
    const anItem: _ItemType_): Integer; virtual; abstract;
  public
   function FindItemByKey(const aKey: _KeyType_;
    var theIndex: Integer): Boolean;
 end;//_m3ListWithFind_

{$Else m3ListWithFind_imp}

{$IfNDef m3ListWithFind_imp_impl}

{$Define m3ListWithFind_imp_impl}

{$Include w:\common\components\rtl\Garant\m3\m3AutoAllocList.imp.pas}

function _m3ListWithFind_.FindItemByKey(const aKey: _KeyType_;
 var theIndex: Integer): Boolean;
//#UC START# *54538E130272_545B7E6B00A1_var*
var
  L, H, i, C: Longint;
//#UC END# *54538E130272_545B7E6B00A1_var*
begin
//#UC START# *54538E130272_545B7E6B00A1_impl*
 theIndex := 0;
 Result := false;
 if not Empty then
 begin
  L := 0;
  H := Pred(Count);
  while (L <= H) do
  begin
   i := (L + H) shr 1;
   C := CompareKeyByItem(aKey, ItemSlot(i)^{Items[i]});
   if (C > 0) then
    L := Succ(i)
   else
   begin
    H := Pred(i);
    if (C = 0) then
    begin
     Result := true;
     L := i;
    end;//C = 0
   end;//C < 0
  end;{while (L..}
  theIndex := L;
 end;//not Empty
//#UC END# *54538E130272_545B7E6B00A1_impl*
end;//_m3ListWithFind_.FindItemByKey

{$EndIf m3ListWithFind_imp_impl}

{$EndIf m3ListWithFind_imp}

