{$IfNDef m3ListWithFind_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3ListWithFind.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi Low Level::m3::m3CoreObjects::m3ListWithFind
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define m3ListWithFind_imp}
 {$Include ..\m3\m3AutoAllocList.imp.pas}
 _m3ListWithFind_ = {mixin} class(_m3AutoAllocList_)
 protected
 // protected methods
   function CompareKeyByItem(const aKey: _KeyType_;
     const anItem: _ItemType_): Integer; virtual; abstract;
 public
 // public methods
   function FindItemByKey(const aKey: _KeyType_;
     var theIndex: Integer): Boolean;
 end;//_m3ListWithFind_

{$Else m3ListWithFind_imp}


{$Include ..\m3\m3AutoAllocList.imp.pas}

// start class _m3ListWithFind_

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

{$EndIf m3ListWithFind_imp}
