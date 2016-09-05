unit vtNavigatorFormListPrim;
 {* Список форм навигатора, который позволяет искать элемент в списка по ключу объект. }

// Модуль: "w:\common\components\gui\Garant\VT\vtNavigatorFormListPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvtNavigatorFormListPrim" MUID: (47D68267011D)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vtNavigatorFormListPrimPrim
 , l3Types
;

type
 TvtFormHandlerID = record
  {* Ключ для поиска элемента по объекту. }
  rObject: TObject;
   {* Ключ поиска - объект }
 end;//TvtFormHandlerID

 _FindDataType_ = TvtFormHandlerID;
 _l3Searcher_Parent_ = TvtNavigatorFormListPrimPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TvtNavigatorFormListPrim = class(_l3Searcher_)
  {* Список форм навигатора, который позволяет искать элемент в списка по ключу объект. }
 end;//TvtNavigatorFormListPrim

function TvtFormHandlerID_C(anObject: TObject): TvtFormHandlerID;
 {* Возвращает заполненную запись }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vtNavigatorForm
 , l3Memory
 //#UC START# *47D68267011Dimpl_uses*
 //#UC END# *47D68267011Dimpl_uses*
;

function TvtFormHandlerID_C(anObject: TObject): TvtFormHandlerID;
 {* Возвращает заполненную запись }
//#UC START# *4B7039C60392_47D67F4A01EA_var*
//#UC END# *4B7039C60392_47D67F4A01EA_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B7039C60392_47D67F4A01EA_impl*
 Result.rObject := anObject;
//#UC END# *4B7039C60392_47D67F4A01EA_impl*
end;//TvtFormHandlerID_C

{$If not Declared(_ItemType_)}type _ItemType_ = TvtNavigatorForm;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_47D68267011D_var*
//#UC END# *47B9BAFD01F4_47D68267011D_var*
begin
//#UC START# *47B9BAFD01F4_47D68267011D_impl*
 Assert(aSortIndex = l3_siNative);
 Result := Integer(anItem.CloseHandler.Form) - Integer(aData.rObject);
//#UC END# *47B9BAFD01F4_47D68267011D_impl*
end;//CompareItemWithData

type _Instance_R_ = TvtNavigatorFormListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
