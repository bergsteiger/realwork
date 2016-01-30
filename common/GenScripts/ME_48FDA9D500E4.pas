{$IfNDef nsNodeNotifierImplementation_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNodeNotifierImplementation.imp.pas"
// Стереотип: "Impurity"

{$Define nsNodeNotifierImplementation_imp}

 _nsNodeNotifierBase_Parent_ = _nsNodeNotifierImplementation_Parent_;
 {$Include nsNodeNotifierBase.imp.pas}
 _nsNodeNotifierImplementation_ = class(_nsNodeNotifierBase_, INodeNotifier)
  protected
   procedure OldChanging;
   procedure OldChanged;
   procedure change_children_count(node_index: TVisibleIndex;
    delta: Integer;
    const index_path: INodeIndexPath;
    child_index: TIndexInParent);
    {* нотификация об изменении кол-ва видимых детей на ноде с указвнным индексом. В случае если изменение нод внутри рута не последовательное и не от начала, индекс должен быть задан как -1. 
parent_path - путь к УЗЛУ в котором произашли изменения (если delta < 0 - удаление, если delta > 0 - вставка)
    left_child_index - индекс ребенка в узле: если удаление, то начиная с которого (включительно) мы удаляем delta элементорв; если вставка, то сразу после которого вы вставляем delta элементов.
    left_child_index, может принять "специальное" значение IIP_BEFORE_LEFT_CHILD (-1) - означающее элемент "до первого" - например для вставки в начало детей. }
   procedure reset_children_count;
    {* устанавливает кол-во детей = 0 }
   function is_root_visible: Boolean;
    {* признак аутлайнера что он с видимым рутом }
   function is_one_level: Boolean;
    {* признак аутлайнера что он одноуровневый }
   procedure invalidate(const index_path: INodeIndexPath);
    {* нотификация о необходимости перерисовки. Должна вызываться после change_children_count (которые можно группирвать) или самостоятельно при изменении дерева не связанном с кол-вом детей.
    parent_path - путь к НОДЕ в которой произашли изменения }
   procedure changing;
    {* Начало итерации изменения дерева }
   procedure changed;
    {* Конец итерации изменения дерева }
   function get_id: TNotifierID;
    {* Возвращает уникальный идентификатор объекта }
 end;//_nsNodeNotifierImplementation_

{$Else nsNodeNotifierImplementation_imp}

{$IfNDef nsNodeNotifierImplementation_imp_impl}

{$Define nsNodeNotifierImplementation_imp_impl}

{$Include nsNodeNotifierBase.imp.pas}

procedure _nsNodeNotifierImplementation_.OldChanging;
//#UC START# *48FDAA2000B3_48FDA9D500E4_var*
//#UC END# *48FDAA2000B3_48FDA9D500E4_var*
begin
//#UC START# *48FDAA2000B3_48FDA9D500E4_impl*
 inherited Changing;
//#UC END# *48FDAA2000B3_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.OldChanging

procedure _nsNodeNotifierImplementation_.OldChanged;
//#UC START# *48FDAA330353_48FDA9D500E4_var*
//#UC END# *48FDAA330353_48FDA9D500E4_var*
begin
//#UC START# *48FDAA330353_48FDA9D500E4_impl*
 inherited Changed;
//#UC END# *48FDAA330353_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.OldChanged

procedure _nsNodeNotifierImplementation_.change_children_count(node_index: TVisibleIndex;
 delta: Integer;
 const index_path: INodeIndexPath;
 child_index: TIndexInParent);
 {* нотификация об изменении кол-ва видимых детей на ноде с указвнным индексом. В случае если изменение нод внутри рута не последовательное и не от начала, индекс должен быть задан как -1. 
parent_path - путь к УЗЛУ в котором произашли изменения (если delta < 0 - удаление, если delta > 0 - вставка)
    left_child_index - индекс ребенка в узле: если удаление, то начиная с которого (включительно) мы удаляем delta элементорв; если вставка, то сразу после которого вы вставляем delta элементов.
    left_child_index, может принять "специальное" значение IIP_BEFORE_LEFT_CHILD (-1) - означающее элемент "до первого" - например для вставки в начало детей. }
//#UC START# *45EEC8E102FE_48FDA9D500E4_var*
var
 l_Data: TnsThreadCallParamsRec;
//#UC END# *45EEC8E102FE_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E102FE_48FDA9D500E4_impl*
 if IsInGetByVisibleIndex then
  // Дерево разворачивалось в процессе получения узла
  f_CountViewChanged := True;

 if (GetCurrentThreadID = MainThreadID) then
  ChangeChildrenCountPrim(aNodeIndex, aDelta, aIndexPath, aChildIndex)
 else
 begin
  with l_Data do
  begin
   rNodeIndex := aNodeIndex;
   rDelta := aDelta;
   rIndexPath := aIndexPath;
   rChildIndex := aChildIndex;
  end;//with l_Data
  Synchronize(ChangeChildrenCountThread, @l_Data, SizeOf(l_Data), [l_Data.rIndexPath]);
 end;//GetCurrentThreadID = MainThreadID
//#UC END# *45EEC8E102FE_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.change_children_count

procedure _nsNodeNotifierImplementation_.reset_children_count;
 {* устанавливает кол-во детей = 0 }
//#UC START# *45EEC8E10303_48FDA9D500E4_var*
//#UC END# *45EEC8E10303_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10303_48FDA9D500E4_impl*
 ResetChildrenCountPrim;
//#UC END# *45EEC8E10303_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.reset_children_count

function _nsNodeNotifierImplementation_.is_root_visible: Boolean;
 {* признак аутлайнера что он с видимым рутом }
//#UC START# *45EEC8E10304_48FDA9D500E4_var*
//#UC END# *45EEC8E10304_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10304_48FDA9D500E4_impl*
 Result := GetShowRoot;
//#UC END# *45EEC8E10304_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.is_root_visible

function _nsNodeNotifierImplementation_.is_one_level: Boolean;
 {* признак аутлайнера что он одноуровневый }
//#UC START# *45EEC8E10305_48FDA9D500E4_var*
//#UC END# *45EEC8E10305_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10305_48FDA9D500E4_impl*
 Result := IsOneLevelPrim;
//#UC END# *45EEC8E10305_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.is_one_level

procedure _nsNodeNotifierImplementation_.invalidate(const index_path: INodeIndexPath);
 {* нотификация о необходимости перерисовки. Должна вызываться после change_children_count (которые можно группирвать) или самостоятельно при изменении дерева не связанном с кол-вом детей.
    parent_path - путь к НОДЕ в которой произашли изменения }
//#UC START# *45EEC8E10306_48FDA9D500E4_var*
var
 l_Data: TnsThreadCallParamsRec;
//#UC END# *45EEC8E10306_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10306_48FDA9D500E4_impl*
 if (GetCurrentThreadID = MainThreadID) then
  InvalidatePrim
 else
 begin
  with l_Data do
  begin
   rNodeIndex := 0;
   rDelta := 0;
   rIndexPath := nil;
   rChildIndex := 0;
  end;//with l_Data
  Synchronize(InvalidateThread, @l_Data, SizeOf(l_Data));
 end;
//#UC END# *45EEC8E10306_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.invalidate

procedure _nsNodeNotifierImplementation_.changing;
 {* Начало итерации изменения дерева }
//#UC START# *45EEC8E10308_48FDA9D500E4_var*
//#UC END# *45EEC8E10308_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10308_48FDA9D500E4_impl*
 // Эта операция целенаправлено не синхронизируется с основной триадой, а выполняется сразу
 // т.к. в ней идет запоминание текущих нод, которые влидну только непосредственно в момент этого вызова
 //
 // Причем в ходе обработки НЕ РЕКОМЕНДУЕТСЯ создавать/убивать кэшируемые объекты на классах
 // которые общаются с адаптером - это может приводить к следующему дедлоку
 // майн - убивает объект подписанный на адаптерную нотификацию
 //        входит в добавление в кэш с захватом критической секции
 // этот поток - Адаптер перед каждой нотификацией захватывает адаптерный мьютекс
 //              создает/убивает кэшируемый объект при этом встает на критической секции
 // майн - выполняет Cleanup и пытается отписаться от адаптерной нотификации и встает на
 //        адаптерном мьютексе
 ChangingPrim;
//#UC END# *45EEC8E10308_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.changing

procedure _nsNodeNotifierImplementation_.changed;
 {* Конец итерации изменения дерева }
//#UC START# *45EEC8E10309_48FDA9D500E4_var*
var
 l_Data: TnsThreadCallParamsRec;
//#UC END# *45EEC8E10309_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10309_48FDA9D500E4_impl*
 if (GetCurrentThreadID = MainThreadID) then
  ChangedPrim
 else
 begin
  with l_Data do
  begin
   rNodeIndex := 0;
   rDelta := 0;
   rIndexPath := nil;
   rChildIndex := 0;
  end;//with l_Data
  Synchronize(ChangedThread, @l_Data, SizeOf(l_Data));
 end;
//#UC END# *45EEC8E10309_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.changed

function _nsNodeNotifierImplementation_.get_id: TNotifierID;
 {* Возвращает уникальный идентификатор объекта }
//#UC START# *475E4B020072_48FDA9D500E4_var*
//#UC END# *475E4B020072_48FDA9D500E4_var*
begin
//#UC START# *475E4B020072_48FDA9D500E4_impl*
 Result := TNotifierID(Self);
//#UC END# *475E4B020072_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.get_id

{$EndIf nsNodeNotifierImplementation_imp_impl}

{$EndIf nsNodeNotifierImplementation_imp}

