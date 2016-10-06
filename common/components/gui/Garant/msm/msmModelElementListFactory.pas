unit msmModelElementListFactory;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementListFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementListFactory" MUID: (57F4EE560075)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , msmModelElementListFactoryPrim
 , msmElementViews
 , msmModelElements
 , l3Types
;

type
 _FindDataType_ = TmsmModelElementView;
 _l3Searcher_Parent_ = TmsmModelElementListFactoryPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TmsmModelElementListFactory = class(_l3Searcher_)
  protected
   procedure InitFields; override;
  public
   class function Make(const anElement: TmsmModelElementView): ImsmModelElementList;
   class function Instance: TmsmModelElementListFactory;
    {* Метод получения экземпляра синглетона TmsmModelElementListFactory }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmModelElementListFactory

implementation

uses
 l3ImplUses
 , msmModelElementList
 , l3Memory
 , SysUtils
 , l3Base
 //#UC START# *57F4EE560075impl_uses*
 //#UC END# *57F4EE560075impl_uses*
;

var g_TmsmModelElementListFactory: TmsmModelElementListFactory = nil;
 {* Экземпляр синглетона TmsmModelElementListFactory }

procedure TmsmModelElementListFactoryFree;
 {* Метод освобождения экземпляра синглетона TmsmModelElementListFactory }
begin
 l3Free(g_TmsmModelElementListFactory);
end;//TmsmModelElementListFactoryFree

{$If not Declared(_ItemType_)}type _ItemType_ = TmsmModelElementList;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_57F4EE560075_var*
//#UC END# *47B9BAFD01F4_57F4EE560075_var*
begin
//#UC START# *47B9BAFD01F4_57F4EE560075_impl*
 Result := anItem.Element.CompareListKey(aData);
//#UC END# *47B9BAFD01F4_57F4EE560075_impl*
end;//CompareItemWithData

type _Instance_R_ = TmsmModelElementListFactory;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

class function TmsmModelElementListFactory.Make(const anElement: TmsmModelElementView): ImsmModelElementList;
//#UC START# *57F4F4FD005D_57F4EE560075_var*
var
 l_Index : Integer;
 l_List : TmsmModelElementList;
//#UC END# *57F4F4FD005D_57F4EE560075_var*
begin
//#UC START# *57F4F4FD005D_57F4EE560075_impl*
 with Instance do
 begin
  if {Self.}FindData(anElement, l_Index) then
   Result := {Self.}Items[l_Index]
  else
  begin
   l_List := TmsmModelElementList.Create(anElement);
   try
    {Self.}Add(l_List);
    Result := l_List;
   finally
    FreeAndNil(l_List);
   end;//try..finally
  end;//Self.FindData(anElement, l_Index)
 end;//with Instance
//#UC END# *57F4F4FD005D_57F4EE560075_impl*
end;//TmsmModelElementListFactory.Make

class function TmsmModelElementListFactory.Instance: TmsmModelElementListFactory;
 {* Метод получения экземпляра синглетона TmsmModelElementListFactory }
begin
 if (g_TmsmModelElementListFactory = nil) then
 begin
  l3System.AddExitProc(TmsmModelElementListFactoryFree);
  g_TmsmModelElementListFactory := Create;
 end;
 Result := g_TmsmModelElementListFactory;
end;//TmsmModelElementListFactory.Instance

class function TmsmModelElementListFactory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmModelElementListFactory <> nil;
end;//TmsmModelElementListFactory.Exists

procedure TmsmModelElementListFactory.InitFields;
//#UC START# *47A042E100E2_57F4EE560075_var*
//#UC END# *47A042E100E2_57F4EE560075_var*
begin
//#UC START# *47A042E100E2_57F4EE560075_impl*
 inherited;
 Sorted := true;
 Duplicates := l3_dupError;
//#UC END# *47A042E100E2_57F4EE560075_impl*
end;//TmsmModelElementListFactory.InitFields

end.
