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
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Types
;

type
 _FindDataType_ = TmsmModelElementView;
 _l3Searcher_Parent_ = TmsmModelElementListFactoryPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TmsmModelElementListFactory = class(_l3Searcher_)
  private
   procedure RegetViewedListsFor(aWord: TtfwWord;
    const aListName: AnsiString);
  protected
   procedure Reget;
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
 , l3ProtoObject
 , msmElementListsService
 , msmModelElement
 , msmModelElementList
 , l3Memory
 , SysUtils
 , l3Base
 //#UC START# *57F4EE560075impl_uses*
 //#UC END# *57F4EE560075impl_uses*
;

type
 TmsmElementListsServiceImpl = {final} class(Tl3ProtoObject, ImsmElementListsService)
  public
   procedure RegetLists;
   procedure RegetViewedListsFor(aWord: TtfwWord;
    const aListName: AnsiString);
   class function Instance: TmsmElementListsServiceImpl;
    {* Метод получения экземпляра синглетона TmsmElementListsServiceImpl }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TmsmElementListsServiceImpl

var g_TmsmElementListsServiceImpl: TmsmElementListsServiceImpl = nil;
 {* Экземпляр синглетона TmsmElementListsServiceImpl }
var g_TmsmModelElementListFactory: TmsmModelElementListFactory = nil;
 {* Экземпляр синглетона TmsmModelElementListFactory }

procedure TmsmElementListsServiceImplFree;
 {* Метод освобождения экземпляра синглетона TmsmElementListsServiceImpl }
begin
 l3Free(g_TmsmElementListsServiceImpl);
end;//TmsmElementListsServiceImplFree

procedure TmsmModelElementListFactoryFree;
 {* Метод освобождения экземпляра синглетона TmsmModelElementListFactory }
begin
 l3Free(g_TmsmModelElementListFactory);
end;//TmsmModelElementListFactoryFree

procedure TmsmElementListsServiceImpl.RegetLists;
//#UC START# *80F135399528_57FE4E3A03C2_var*
//#UC END# *80F135399528_57FE4E3A03C2_var*
begin
//#UC START# *80F135399528_57FE4E3A03C2_impl*
 if TmsmModelElementListFactory.Exists then
  TmsmModelElementListFactory.Instance.Reget;
//#UC END# *80F135399528_57FE4E3A03C2_impl*
end;//TmsmElementListsServiceImpl.RegetLists

procedure TmsmElementListsServiceImpl.RegetViewedListsFor(aWord: TtfwWord;
 const aListName: AnsiString);
//#UC START# *F7EFF4FD47C2_57FE4E3A03C2_var*
//#UC END# *F7EFF4FD47C2_57FE4E3A03C2_var*
begin
//#UC START# *F7EFF4FD47C2_57FE4E3A03C2_impl*
 if TmsmModelElementListFactory.Exists then
  TmsmModelElementListFactory.Instance.RegetViewedListsFor(aWord, aListName);
//#UC END# *F7EFF4FD47C2_57FE4E3A03C2_impl*
end;//TmsmElementListsServiceImpl.RegetViewedListsFor

class function TmsmElementListsServiceImpl.Instance: TmsmElementListsServiceImpl;
 {* Метод получения экземпляра синглетона TmsmElementListsServiceImpl }
begin
 if (g_TmsmElementListsServiceImpl = nil) then
 begin
  l3System.AddExitProc(TmsmElementListsServiceImplFree);
  g_TmsmElementListsServiceImpl := Create;
 end;
 Result := g_TmsmElementListsServiceImpl;
end;//TmsmElementListsServiceImpl.Instance

class function TmsmElementListsServiceImpl.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TmsmElementListsServiceImpl <> nil;
end;//TmsmElementListsServiceImpl.Exists

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

procedure TmsmModelElementListFactory.Reget;
//#UC START# *57FE4D6400C4_57F4EE560075_var*
var
 l_Index : Integer;
//#UC END# *57FE4D6400C4_57F4EE560075_var*
begin
//#UC START# *57FE4D6400C4_57F4EE560075_impl*
 Lock;
 try
  for l_Index := 0 to Pred(Count) do
   Items[l_Index].Reget;
 finally
  Unlock;
 end;//try..finally
//#UC END# *57FE4D6400C4_57F4EE560075_impl*
end;//TmsmModelElementListFactory.Reget

procedure TmsmModelElementListFactory.RegetViewedListsFor(aWord: TtfwWord;
 const aListName: AnsiString);
//#UC START# *57FF6C9C020B_57F4EE560075_var*
var
 l_Index : Integer;
 l_List : TmsmModelElementList; 
//#UC END# *57FF6C9C020B_57F4EE560075_var*
begin
//#UC START# *57FF6C9C020B_57F4EE560075_impl*
 Lock;
 try
  for l_Index := 0 to Pred(Count) do
  begin
   l_List := Items[l_Index];
   if (l_List.Element.rListName <> aListName) then
    continue; 
   if (l_List.Element.rElement = nil) then
    continue;
   if (l_List.Element.rElement.MainWord = nil) then
    continue; 
   if (l_List.Element.rElement.MainWord.GetRefForCompare = aWord) then
    continue;
   if not l_List.Element.rElement.BoolProp['IsSomeView'] then
    continue;
   if l_List.Element.rElement.IsSameElementView(TmsmModelElement.MakeFromWord(aWord)) then
    l_List.Reget;
  end;//for l_Index
 finally
  Unlock;
 end;//try..finally
//#UC END# *57FF6C9C020B_57F4EE560075_impl*
end;//TmsmModelElementListFactory.RegetViewedListsFor

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

initialization
 TmsmElementListsService.Instance.Alien := TmsmElementListsServiceImpl.Instance;
 {* Регистрация TmsmElementListsServiceImpl }

end.
