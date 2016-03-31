{$IfNDef List_imp}

// Модуль: "w:\common\components\SandBox\List.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "List" MUID: (51DEB07E03E4)
// Имя типа: "_List_"

{$Define List_imp}

const
 cItemSize = SizeOf(_ItemType_);

type
 PItemType = ^_ItemType_;

 IndexType = Integer;

 _List_ = class(_List_Parent_)
  {* Абстрактный список значений }
  private
   f_Data: Tl3PtrLoc;
    {* Собственно место хранения данных }
   f_Count: IndexType;
    {* Количество элементов списка }
  private
   procedure ReAllocList(aNewCapacity: IndexType);
   procedure CheckIndex(anIndex: IndexType);
    {* проверяет валидность индекса и поднимает исключение, если он неправильный }
   function ItemSlot(anIndex: IndexType): PItemType;
   function ExpandSize(aTargetSize: IndexType): Cardinal;
   procedure CheckSetItem(anIndex: IndexType);
    {* Проверяет валидность индекса при вставке }
   procedure DirectInsert(anIndex: IndexType;
    const anItem: _ItemType_);
    {* Непосредственная вставка элемента. Без проверки валидности индекса }
   procedure MoveItems(aDst: IndexType;
    aSrc: IndexType;
    aSize: Cardinal);
  protected
   procedure pm_SetCount(aValue: IndexType); { can raise EListError }
   function pm_GetCapacity: IndexType;
   procedure pm_SetCapacity(aValue: IndexType); { can raise EListError }
   function pm_GetItems(anIndex: IndexType): _ItemType_;
   procedure pm_SetItems(anIndex: IndexType;
    const aValue: _ItemType_);
   function pm_GetEmpty: Boolean;
   function pm_GetFirst: _ItemType_; { can raise EListError }
   function pm_GetLast: _ItemType_; { can raise EListError }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Delete(anIndex: IndexType);
    {* удалить элемент с индексом anIndex }
   procedure Insert(anIndex: IndexType;
    const anItem: _ItemType_);
    {* Вставка элемента }
   procedure Add(const anItem: _ItemType_);
    {* Добавляет элемент списка }
   function IndexOf(const anItem: _ItemType_): IndexType;
    {* Возвращает индекс элемента списка или -1, если элемента в списке нет }
   procedure Remove(const anIndex: _ItemType_);
    {* Удаляет элемент из списка }
   procedure Clear;
    {* Очищает список }
  public
   property Count: IndexType
    read f_Count
    write pm_SetCount;
    {* Количество элементов списка }
   property Capacity: IndexType
    read pm_GetCapacity
    write pm_SetCapacity;
    {* Мощность списка }
   property Items[anIndex: IndexType]: _ItemType_
    read pm_GetItems
    write pm_SetItems;
    default;
    {* Элементы списка. }
   property Empty: Boolean
    read pm_GetEmpty;
    {* Список пустой }
   property First: _ItemType_
    read pm_GetFirst;
    {* Первый элемент списка }
   property Last: _ItemType_
    read pm_GetLast;
    {* Последний элемент списка }
 end;//_List_

{$Else List_imp}

{$IfNDef List_imp_impl}

{$Define List_imp_impl}

procedure _List_.pm_SetCount(aValue: IndexType); { can raise EListError }
//#UC START# *51DEB1ED0017_51DEB07E03E4set_var*

 procedure SayBadCount(aNewCount: LongInt);
 begin
  raise EListError.CreateFmt(sListIndexError, [aNewCount]);
 end;

var
 l_Ptr   : PItemType;
 {$IfNDef l3Items_IsUnrefcounted}
 l_Index : Integer;
 {$EndIf  l3Items_IsUnrefcounted}
//#UC END# *51DEB1ED0017_51DEB07E03E4set_var*
begin
//#UC START# *51DEB1ED0017_51DEB07E03E4set_impl*
 if (aValue < 0) then
  SayBadCount(aValue);
 if (aValue < f_Count) then
 begin
  l_Ptr := ItemSlot(aValue);
  {$IfDef l3Items_IsUnrefcounted}
  System.FillChar(l_Ptr^, (f_Count - 1 - aValue) * cItemSize, 0);
  {$Else  l3Items_IsUnrefcounted}
  for l_Index := aValue to f_Count - 1 do
  begin
   FreeItem(l_Ptr^);
   Inc(PMem(l_Ptr), cItemSize);
  end;//for i
  {$EndIf  l3Items_IsUnrefcounted}
 end//aValue < f_Count
 else
 if (aValue > Self.Capacity) then
  ReAllocList(ExpandSize(aValue));
 if (f_Count < aValue) then
  System.FillChar(ItemSlot(f_Count)^, (aValue - f_Count) * cItemSize, 0);
 f_Count := aValue;
//#UC END# *51DEB1ED0017_51DEB07E03E4set_impl*
end;//_List_.pm_SetCount

function _List_.pm_GetCapacity: IndexType;
//#UC START# *51DEB20E0130_51DEB07E03E4get_var*
//#UC END# *51DEB20E0130_51DEB07E03E4get_var*
begin
//#UC START# *51DEB20E0130_51DEB07E03E4get_impl*
 Result := f_Data.GetSize div cItemSize;
//#UC END# *51DEB20E0130_51DEB07E03E4get_impl*
end;//_List_.pm_GetCapacity

procedure _List_.pm_SetCapacity(aValue: IndexType); { can raise EListError }
//#UC START# *51DEB20E0130_51DEB07E03E4set_var*

 procedure SayBadCap(aNewCapacity: IndexType);
 begin
  raise EListError.CreateFmt(sListIndexError, [aNewCapacity]);
 end;

//#UC END# *51DEB20E0130_51DEB07E03E4set_var*
begin
//#UC START# *51DEB20E0130_51DEB07E03E4set_impl*
 if (aValue < 0) then
  SayBadCap(aValue);
 if (pm_GetCapacity <> aValue) then
 begin
  { If the list is shrinking, then update _Count for the smaller size. }
  if (aValue < f_Count) then
   Count := aValue;
  ReAllocList(aValue);
 end;//GetCapacity(Self) <> aValue
//#UC END# *51DEB20E0130_51DEB07E03E4set_impl*
end;//_List_.pm_SetCapacity

function _List_.pm_GetItems(anIndex: IndexType): _ItemType_;
//#UC START# *51DECA1202C5_51DEB07E03E4get_var*
//#UC END# *51DECA1202C5_51DEB07E03E4get_var*
begin
//#UC START# *51DECA1202C5_51DEB07E03E4get_impl*
 CheckIndex(anIndex);
 Result := ItemSlot(anIndex)^;
//#UC END# *51DECA1202C5_51DEB07E03E4get_impl*
end;//_List_.pm_GetItems

procedure _List_.pm_SetItems(anIndex: IndexType;
 const aValue: _ItemType_);
//#UC START# *51DECA1202C5_51DEB07E03E4set_var*
{$IfNDef l3Items_IsAtomic}
var
 l_P : PItemType;
{$EndIf  l3Items_IsAtomic}
//#UC END# *51DECA1202C5_51DEB07E03E4set_var*
begin
//#UC START# *51DECA1202C5_51DEB07E03E4set_impl*
 CheckSetItem(anIndex);
 {$IfDef l3Items_IsAtomic}
 PItemType(ItemSlot(anIndex))^ := aValue;
 {$Else  l3Items_IsAtomic}
 l_P := PItemType(ItemSlot(anIndex));
 if not IsSame(l_P^, aValue) then
 begin
  FreeItem(l_P^);
  FillItem(l_P^, aValue);
 end;//not IsSame(l_P^, anItem)
 {$EndIf l3Items_IsAtomic}
//#UC END# *51DECA1202C5_51DEB07E03E4set_impl*
end;//_List_.pm_SetItems

function _List_.pm_GetEmpty: Boolean;
//#UC START# *51E7FDAC023D_51DEB07E03E4get_var*
//#UC END# *51E7FDAC023D_51DEB07E03E4get_var*
begin
//#UC START# *51E7FDAC023D_51DEB07E03E4get_impl*
 Result := (Count = 0);
//#UC END# *51E7FDAC023D_51DEB07E03E4get_impl*
end;//_List_.pm_GetEmpty

function _List_.pm_GetFirst: _ItemType_; { can raise EListError }
//#UC START# *51E8070603AC_51DEB07E03E4get_var*
//#UC END# *51E8070603AC_51DEB07E03E4get_var*
begin
//#UC START# *51E8070603AC_51DEB07E03E4get_impl*
 Result := Items[0];
//#UC END# *51E8070603AC_51DEB07E03E4get_impl*
end;//_List_.pm_GetFirst

function _List_.pm_GetLast: _ItemType_; { can raise EListError }
//#UC START# *51E8074101B5_51DEB07E03E4get_var*
//#UC END# *51E8074101B5_51DEB07E03E4get_var*
begin
//#UC START# *51E8074101B5_51DEB07E03E4get_impl*
 Result := Items[f_Count - 1];
//#UC END# *51E8074101B5_51DEB07E03E4get_impl*
end;//_List_.pm_GetLast

procedure _List_.ReAllocList(aNewCapacity: IndexType);
//#UC START# *51DEB8770017_51DEB07E03E4_var*
var
 l_Cap : Integer;
 l_Cnt : Integer;
//#UC END# *51DEB8770017_51DEB07E03E4_var*
begin
//#UC START# *51DEB8770017_51DEB07E03E4_impl*
 f_Data.SetSize(aNewCapacity * cItemSize);
 l_Cap := Self.Capacity;
 Assert(l_Cap >= aNewCapacity);
 l_Cnt := f_Count;
 if (l_Cap > l_Cnt) then
  System.FillChar(ItemSlot(l_Cnt)^, (l_Cap - l_Cnt) * cItemSize, 0);
//#UC END# *51DEB8770017_51DEB07E03E4_impl*
end;//_List_.ReAllocList

procedure _List_.CheckIndex(anIndex: IndexType);
 {* проверяет валидность индекса и поднимает исключение, если он неправильный }
//#UC START# *51DEB95E00BD_51DEB07E03E4_var*

 procedure _Error;
 begin
  raise EListError.CreateFmt(SListIndexError + ' from (%d)', [anIndex, f_Count])
 end;

//#UC END# *51DEB95E00BD_51DEB07E03E4_var*
begin
//#UC START# *51DEB95E00BD_51DEB07E03E4_impl*
 if (anIndex < 0) or (anIndex >= f_Count) then
  _Error;
//#UC END# *51DEB95E00BD_51DEB07E03E4_impl*
end;//_List_.CheckIndex

function _List_.ItemSlot(anIndex: IndexType): PItemType;
//#UC START# *51DEBE2D008A_51DEB07E03E4_var*
//#UC END# *51DEBE2D008A_51DEB07E03E4_var*
begin
//#UC START# *51DEBE2D008A_51DEB07E03E4_impl*
 Result := PItemType(f_Data.AsPointer + anIndex * cItemSize);
 assert(Result <> nil);
//#UC END# *51DEBE2D008A_51DEB07E03E4_impl*
end;//_List_.ItemSlot

function _List_.ExpandSize(aTargetSize: IndexType): Cardinal;
//#UC START# *51DEC11F0058_51DEB07E03E4_var*
const
 cIncrArray : array [0..3] of Integer = (64 * 1024, 1024, 128, 4);
 cMaxForTwice : Integer = 1 * 1024 * 1024;
var
 I : Integer;
//#UC END# *51DEC11F0058_51DEB07E03E4_var*
begin
//#UC START# *51DEC11F0058_51DEB07E03E4_impl*
 Assert(aTargetSize > 0);

 Result := aTargetSize;
 if (Result > cMaxForTwice) then
 // большие массивы не удваиваем а подравниваем под 1мб
  Result := (aTargetSize div cMaxForTwice + 1) * cMaxForTwice
 else
 begin
  for I := 0 to High(cIncrArray) do
   if (aTargetSize > cIncrArray[I]) then
   begin
    Result := (aTargetSize div cIncrArray[I]) * cIncrArray[I] * 2;
    Break;
   end;//aTargetSize > cIncrArray[I]
 end;//Result > cMaxForTwic
//#UC END# *51DEC11F0058_51DEB07E03E4_impl*
end;//_List_.ExpandSize

procedure _List_.CheckSetItem(anIndex: IndexType);
 {* Проверяет валидность индекса при вставке }
//#UC START# *51DECAA8035E_51DEB07E03E4_var*
//#UC END# *51DECAA8035E_51DEB07E03E4_var*
begin
//#UC START# *51DECAA8035E_51DEB07E03E4_impl*
 CheckIndex(anIndex);
//#UC END# *51DECAA8035E_51DEB07E03E4_impl*
end;//_List_.CheckSetItem

procedure _List_.Delete(anIndex: IndexType);
 {* удалить элемент с индексом anIndex }
//#UC START# *51E6A2660270_51DEB07E03E4_var*
var
 l_P : PItemType;
//#UC END# *51E6A2660270_51DEB07E03E4_var*
begin
//#UC START# *51E6A2660270_51DEB07E03E4_impl*
 CheckIndex(anIndex);
 l_P := ItemSlot(anIndex);
 Dec(f_Count);
 FreeItem(l_P^);
 if (anIndex <> f_Count) then
  MoveItems(anIndex, Succ(anIndex), f_Count-anIndex);
//#UC END# *51E6A2660270_51DEB07E03E4_impl*
end;//_List_.Delete

procedure _List_.DirectInsert(anIndex: IndexType;
 const anItem: _ItemType_);
 {* Непосредственная вставка элемента. Без проверки валидности индекса }
//#UC START# *51E6A2AA02E4_51DEB07E03E4_var*
var
 l_Cap   : Integer;
 l_Count : Integer;
//#UC END# *51E6A2AA02E4_51DEB07E03E4_var*
begin
//#UC START# *51E6A2AA02E4_51DEB07E03E4_impl*
 l_Count := f_Count;
 l_Cap := Self.Capacity;
 if (l_Count >= l_Cap) then
  ReAllocList(ExpandSize(l_Cap + 1));
 { Make room for the inserted item. }
 Dec(l_Count, anIndex);
 if (l_Count > 0) then
 begin
  MoveItems(anIndex + 1, anIndex + 0, l_Count);
  {$If not defined(l3Items_IsAtomic)}
  FillChar(PMem(ItemSlot(anIndex))^, cItemSize, 0);
  // - это для того, чтобы не оказалось лишней ссылки на строки и/или интерфейсы
  {$IfEnd}
 end;//l_Count > 0
 FillItem(ItemSlot(anIndex)^, anItem);
 Inc(f_Count);
 {$IfDef l3Items_IsAtomic}
 Assert(ItemSlot(anIndex)^ = anItem);
 {$Else  l3Items_IsAtomic}
 {$If (SizeOf(_ItemType_) <= 4) AND not Defined(l3Items_IsProcedured)}
 Assert(ItemSlot(anIndex)^ = anItem);
 {$IfEnd}
 {$EndIf l3Items_IsAtomic}
//#UC END# *51E6A2AA02E4_51DEB07E03E4_impl*
end;//_List_.DirectInsert

procedure _List_.Insert(anIndex: IndexType;
 const anItem: _ItemType_);
 {* Вставка элемента }
//#UC START# *51E6A3140016_51DEB07E03E4_var*

 procedure _Error;
 begin
  raise EListError.CreateFmt(SListIndexError, [anIndex]);
 end;

//#UC END# *51E6A3140016_51DEB07E03E4_var*
begin
//#UC START# *51E6A3140016_51DEB07E03E4_impl*
 if (anIndex < 0) or (anIndex > f_Count) then
  _Error;
 DirectInsert(anIndex, anItem) 
//#UC END# *51E6A3140016_51DEB07E03E4_impl*
end;//_List_.Insert

procedure _List_.MoveItems(aDst: IndexType;
 aSrc: IndexType;
 aSize: Cardinal);
//#UC START# *51E6A8190252_51DEB07E03E4_var*
type
 PInteger = ^Integer;
var
 l_Sz : Integer;
 l_S  : Integer;
 l_D  : Integer;
 l_B  : PMem;
//#UC END# *51E6A8190252_51DEB07E03E4_var*
begin
//#UC START# *51E6A8190252_51DEB07E03E4_impl*
 if (aSize > 0) then
 begin
  l_B := f_Data.AsPointer;
  l_S := aSrc * cItemSize;
  l_D := aDst * cItemSize;
  l_Sz := aSize * cItemSize;
  if (l_Sz = SizeOf(Integer)) then
  begin
   PInteger(l_B + l_D)^ := PInteger(l_B + l_S)^;
   Exit;
  end//l_Sz = SizeOf(Integer)
  else
   Move((l_B + l_S)^, (l_B + l_D)^, l_Sz);
 end;//aSize > 0
//#UC END# *51E6A8190252_51DEB07E03E4_impl*
end;//_List_.MoveItems

procedure _List_.Add(const anItem: _ItemType_);
 {* Добавляет элемент списка }
//#UC START# *51E80192036C_51DEB07E03E4_var*
//#UC END# *51E80192036C_51DEB07E03E4_var*
begin
//#UC START# *51E80192036C_51DEB07E03E4_impl*
 DirectInsert(f_Count, anItem);
//#UC END# *51E80192036C_51DEB07E03E4_impl*
end;//_List_.Add

function _List_.IndexOf(const anItem: _ItemType_): IndexType;
 {* Возвращает индекс элемента списка или -1, если элемента в списке нет }
//#UC START# *51E801D503C5_51DEB07E03E4_var*
var
 l_Index : IndexType;
//#UC END# *51E801D503C5_51DEB07E03E4_var*
begin
//#UC START# *51E801D503C5_51DEB07E03E4_impl*
 Result := -1;
 // - будем пессимистами
 for l_Index := 0 to f_Count - 1 do
 begin
  if IsSame(ItemSlot(l_Index)^, anItem) then
  begin
   Result := l_Index;
   break;
  end;//IsSame(ItemSlot(l_Index)^, anItem)
 end;//for l_Index
//#UC END# *51E801D503C5_51DEB07E03E4_impl*
end;//_List_.IndexOf

procedure _List_.Remove(const anIndex: _ItemType_);
 {* Удаляет элемент из списка }
//#UC START# *51E802290167_51DEB07E03E4_var*
var
 l_Index : IndexType;
//#UC END# *51E802290167_51DEB07E03E4_var*
begin
//#UC START# *51E802290167_51DEB07E03E4_impl*
 l_Index := IndexOf(anIndex);
 if (l_Index >= 0) then
  Delete(l_Index);
//#UC END# *51E802290167_51DEB07E03E4_impl*
end;//_List_.Remove

procedure _List_.Clear;
 {* Очищает список }
//#UC START# *51E8026302B4_51DEB07E03E4_var*
//#UC END# *51E8026302B4_51DEB07E03E4_var*
begin
//#UC START# *51E8026302B4_51DEB07E03E4_impl*
 Count := 0;
//#UC END# *51E8026302B4_51DEB07E03E4_impl*
end;//_List_.Clear

procedure _List_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_51DEB07E03E4_var*
//#UC END# *479731C50290_51DEB07E03E4_var*
begin
//#UC START# *479731C50290_51DEB07E03E4_impl*
 Count := 0;
 f_Data.SetSize(0);
 inherited;
//#UC END# *479731C50290_51DEB07E03E4_impl*
end;//_List_.Cleanup

{$EndIf List_imp_impl}

{$EndIf List_imp}

