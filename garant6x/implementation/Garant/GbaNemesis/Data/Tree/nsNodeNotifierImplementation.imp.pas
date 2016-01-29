{$IfNDef nsNodeNotifierImplementation_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsNodeNotifierImplementation.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::nsNodeNotifierImplementation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsNodeNotifierImplementation_imp}
 _nsNodeNotifierBase_Parent_ = _nsNodeNotifierImplementation_Parent_;
 {$Include ..\Tree\nsNodeNotifierBase.imp.pas}
 _nsNodeNotifierImplementation_ = {mixin} class(_nsNodeNotifierBase_, INodeNotifier)
 protected
 // realized methods
   procedure ChangeChildrenCount(aNodeIndex: TVisibleIndex;
    aDelta: Integer;
    const aIndexPath: INodeIndexPath;
    aChildIndex: TIndexInParent); stdcall;
     {* нотификация об изменении кол-ва видимых детей на ноде с указвнным индексом. В случае если изменение нод внутри рута не последовательное и не от начала, индекс должен быть задан как -1. 
parent_path - путь к УЗЛУ в котором произашли изменения (если delta < 0 - удаление, если delta > 0 - вставка)
    left_child_index - индекс ребенка в узле: если удаление, то начиная с которого (включительно) мы удаляем delta элементорв; если вставка, то сразу после которого вы вставляем delta элементов.
    left_child_index, может принять "специальное" значение IIP_BEFORE_LEFT_CHILD (-1) - означающее элемент "до первого" - например для вставки в начало детей. }
   procedure ResetChildrenCount; stdcall;
     {* устанавливает кол-во детей = 0 }
   function IsRootVisible: ByteBool; stdcall;
     {* признак аутлайнера что он с видимым рутом }
   function IsOneLevel: ByteBool; stdcall;
     {* признак аутлайнера что он одноуровневый }
   procedure Invalidate(const aIndexPath: INodeIndexPath); stdcall;
     {* нотификация о необходимости перерисовки. Должна вызываться после change_children_count (которые можно группирвать) или самостоятельно при изменении дерева не связанном с кол-вом детей.
    parent_path - путь к НОДЕ в которой произашли изменения }
   procedure Changing; stdcall;
     {* Начало итерации изменения дерева }
   procedure Changed; stdcall;
     {* Конец итерации изменения дерева }
   function GetId: TNotifierID; stdcall;
     {* Возвращает уникальный идентификатор объекта }
 protected
 // protected methods
   procedure OldChanging;
   procedure OldChanged;
 end;//_nsNodeNotifierImplementation_

{$Else nsNodeNotifierImplementation_imp}

{$Include ..\Tree\nsNodeNotifierBase.imp.pas}

// start class _nsNodeNotifierImplementation_

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

procedure _nsNodeNotifierImplementation_.ChangeChildrenCount(aNodeIndex: TVisibleIndex;
  aDelta: Integer;
  const aIndexPath: INodeIndexPath;
  aChildIndex: TIndexInParent);
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
end;//_nsNodeNotifierImplementation_.ChangeChildrenCount

procedure _nsNodeNotifierImplementation_.ResetChildrenCount;
//#UC START# *45EEC8E10303_48FDA9D500E4_var*
//#UC END# *45EEC8E10303_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10303_48FDA9D500E4_impl*
 ResetChildrenCountPrim;
//#UC END# *45EEC8E10303_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.ResetChildrenCount

function _nsNodeNotifierImplementation_.IsRootVisible: ByteBool;
//#UC START# *45EEC8E10304_48FDA9D500E4_var*
//#UC END# *45EEC8E10304_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10304_48FDA9D500E4_impl*
 Result := GetShowRoot;
//#UC END# *45EEC8E10304_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.IsRootVisible

function _nsNodeNotifierImplementation_.IsOneLevel: ByteBool;
//#UC START# *45EEC8E10305_48FDA9D500E4_var*
//#UC END# *45EEC8E10305_48FDA9D500E4_var*
begin
//#UC START# *45EEC8E10305_48FDA9D500E4_impl*
 Result := IsOneLevelPrim;
//#UC END# *45EEC8E10305_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.IsOneLevel

procedure _nsNodeNotifierImplementation_.Invalidate(const aIndexPath: INodeIndexPath);
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
end;//_nsNodeNotifierImplementation_.Invalidate

procedure _nsNodeNotifierImplementation_.Changing;
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
end;//_nsNodeNotifierImplementation_.Changing

procedure _nsNodeNotifierImplementation_.Changed;
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
end;//_nsNodeNotifierImplementation_.Changed

function _nsNodeNotifierImplementation_.GetId: TNotifierID;
//#UC START# *475E4B020072_48FDA9D500E4_var*
//#UC END# *475E4B020072_48FDA9D500E4_var*
begin
//#UC START# *475E4B020072_48FDA9D500E4_impl*
 Result := TNotifierID(Self);
//#UC END# *475E4B020072_48FDA9D500E4_impl*
end;//_nsNodeNotifierImplementation_.GetId

{$EndIf nsNodeNotifierImplementation_imp}
