unit ddTextSegmentsList;

// Модуль: "w:\common\components\rtl\Garant\dd\ddTextSegmentsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddTextSegmentsList" MUID: (525D40F1024C)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddTextSegment
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddTextSegment;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddTextSegmentsList = class(_l3UncomparabeObjectRefList_)
  private
   f_HasHyperlink: Boolean;
    {* Поле для свойства HasHyperlink }
   f_HasSegment: Boolean;
    {* Поле для свойства HasSegment }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoDelete(Index: Integer); override;
    {* Удаляет элемент с индексом Index. Не проверяет валидность индекса. }
   procedure DirectInsert(anIndex: Integer;
    const aData: _ItemType_); override;
    {* Непосредственное удаление элемента. Без проверки валидности индекса. }
  public
   function Add(const anItem: _ItemType_): Integer; override;
    {* Добавляет элемент списка. }
   procedure Clear; override;
  public
   property HasHyperlink: Boolean
    read f_HasHyperlink;
   property HasSegment: Boolean
    read f_HasSegment;
 end;//TddTextSegmentsList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_525D40F1024C_var*
//#UC END# *47B2C42A0163_525D40F1024C_var*
begin
//#UC START# *47B2C42A0163_525D40F1024C_impl*
 Assert(false);
//#UC END# *47B2C42A0163_525D40F1024C_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_525D40F1024C_var*
//#UC END# *47B99D4503A2_525D40F1024C_var*
begin
//#UC START# *47B99D4503A2_525D40F1024C_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
 Assert(false);
//#UC END# *47B99D4503A2_525D40F1024C_impl*
end;//CompareExistingItems

type _Instance_R_ = TddTextSegmentsList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

procedure TddTextSegmentsList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_525D40F1024C_var*
//#UC END# *479731C50290_525D40F1024C_var*
begin
//#UC START# *479731C50290_525D40F1024C_impl*
 inherited;
 f_HasHyperlink := False;
 f_HasSegment := False;
//#UC END# *479731C50290_525D40F1024C_impl*
end;//TddTextSegmentsList.Cleanup

function TddTextSegmentsList.Add(const anItem: _ItemType_): Integer;
 {* Добавляет элемент списка. }
//#UC START# *47A750E70096_525D40F1024C_var*
//#UC END# *47A750E70096_525D40F1024C_var*
begin
//#UC START# *47A750E70096_525D40F1024C_impl*
 if anItem.IsHyperlink then
  f_HasHyperlink := True
 else
  f_HasSegment := True;
 Result := inherited Add(anItem)
//#UC END# *47A750E70096_525D40F1024C_impl*
end;//TddTextSegmentsList.Add

procedure TddTextSegmentsList.Clear;
//#UC START# *47B1C16D0188_525D40F1024C_var*
//#UC END# *47B1C16D0188_525D40F1024C_var*
begin
//#UC START# *47B1C16D0188_525D40F1024C_impl*
 inherited;
 f_HasHyperlink := False;
 f_HasSegment := False;
//#UC END# *47B1C16D0188_525D40F1024C_impl*
end;//TddTextSegmentsList.Clear

procedure TddTextSegmentsList.DoDelete(Index: Integer);
 {* Удаляет элемент с индексом Index. Не проверяет валидность индекса. }
//#UC START# *47B4895F01BE_525D40F1024C_var*
var
 i: Integer;
//#UC END# *47B4895F01BE_525D40F1024C_var*
begin
//#UC START# *47B4895F01BE_525D40F1024C_impl*
 inherited;
 for i := 0 to Count - 1 do
 begin
  if Items[i].IsHyperlink then
   f_HasHyperlink := True
  else
   f_HasSegment := True;
  if f_HasSegment and f_HasSegment then Break;
 end; // for i := 0 to Count - 1 do
//#UC END# *47B4895F01BE_525D40F1024C_impl*
end;//TddTextSegmentsList.DoDelete

procedure TddTextSegmentsList.DirectInsert(anIndex: Integer;
 const aData: _ItemType_);
 {* Непосредственное удаление элемента. Без проверки валидности индекса. }
//#UC START# *47B49EC50034_525D40F1024C_var*
//#UC END# *47B49EC50034_525D40F1024C_var*
begin
//#UC START# *47B49EC50034_525D40F1024C_impl*
 if aData.IsHyperlink then
  f_HasHyperlink := True
 else
  f_HasSegment := True;
 inherited 
/
//#UC END# *47B49EC50034_525D40F1024C_impl*
end;//TddTextSegmentsList.DirectInsert

end.
