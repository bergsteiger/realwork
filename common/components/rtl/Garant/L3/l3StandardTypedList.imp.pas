{$IfNDef l3StandardTypedList_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3StandardTypedList.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "l3StandardTypedList" MUID: (47B594B50330)
// Имя типа: "_l3StandardTypedList_"

{$Define l3StandardTypedList_imp}

 _DataType_ = Tl3Ptr;
 _l3FourByteItemList_Parent_ = _l3StandardTypedList_Parent_;
 {$Include w:\common\components\rtl\Garant\L3\l3FourByteItemList.imp.pas}
 _l3StandardTypedList_ = {abstract} class(_l3FourByteItemList_)
  {* Стандартный типизированный список с размером элемента в 4 байта }
  public
   {$If NOT Defined(l3Items_NoSort)}
   constructor MakeSorted(aDuplicates: Tl3Duplicates = l3Types.l3_dupIgnore;
    aSortIndex: Tl3SortIndex = l3_siNative); reintroduce;
    {* Создает сортированный список }
   {$IfEnd} // NOT Defined(l3Items_NoSort)
   constructor Make; reintroduce;
 end;//_l3StandardTypedList_

{$Else l3StandardTypedList_imp}

{$IfNDef l3StandardTypedList_imp_impl}

{$Define l3StandardTypedList_imp_impl}

{$Include w:\common\components\rtl\Garant\L3\l3FourByteItemList.imp.pas}

{$If NOT Defined(l3Items_NoSort)}
constructor _l3StandardTypedList_.MakeSorted(aDuplicates: Tl3Duplicates = l3Types.l3_dupIgnore;
 aSortIndex: Tl3SortIndex = l3_siNative);
 {* Создает сортированный список }
//#UC START# *47B5B269032B_47B594B50330_var*
//#UC END# *47B5B269032B_47B594B50330_var*
begin
//#UC START# *47B5B269032B_47B594B50330_impl*
 Make;
 Duplicates := aDuplicates;
 SortIndex := aSortIndex;
//#UC END# *47B5B269032B_47B594B50330_impl*
end;//_l3StandardTypedList_.MakeSorted
{$IfEnd} // NOT Defined(l3Items_NoSort)

constructor _l3StandardTypedList_.Make;
//#UC START# *47B9868C0046_47B594B50330_var*
//#UC END# *47B9868C0046_47B594B50330_var*
begin
//#UC START# *47B9868C0046_47B594B50330_impl*
 Create;
//#UC END# *47B9868C0046_47B594B50330_impl*
end;//_l3StandardTypedList_.Make

{$EndIf l3StandardTypedList_imp_impl}

{$EndIf l3StandardTypedList_imp}

