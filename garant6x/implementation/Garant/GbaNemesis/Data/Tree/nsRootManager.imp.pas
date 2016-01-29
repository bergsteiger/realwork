{$IfNDef nsRootManager_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsRootManager.imp.pas"
// Начат: 2005/11/22 21:28:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::nsRootManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nsRootManager_imp}
 _nsRootManagerPrim_Parent_ = _nsRootManager_Parent_;
 {$Include ..\Tree\nsRootManagerPrim.imp.pas}
 _nsRootManager_ = {mixin} class(_nsRootManagerPrim_)
 private
 // private fields
   f_GetByVisibleIndexCounter : Integer;
   f_CurrentNodeIndex : Integer;
    {* Поле для свойства CurrentNodeIndex}
   f_CurrentNode : INodeBase;
    {* Поле для свойства CurrentNode}
   f_OneLevel : Boolean;
    {* Поле для свойства OneLevel}
 private
 // private methods
   procedure GetByVisibleIndexStarted;
     {* Скобки, обрамляющие вызов GetByVisibleIndex }
   procedure GetByVisibleIndexFinished;
     {* Скобки, обрамляющие вызов GetByVisibleIndex }
 protected
 // property methods
   function pm_GetCurrentNode: INodeBase;
 protected
 // overridden protected methods
   procedure Cleanup; override;
   function IsInGetByVisibleIndex: Boolean; override;
   function DoChangeChildrenCount(aNodeIndex: TVisibleIndex;
    aDelta: Integer): Integer; override;
   procedure DropCurrent; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   function GetByVisibleIndex(anIndex: Integer): INodeBase; virtual;
     {* возвращает ноду по видимому индексу }
   function GetVisibleIndex(const aNode: INodeBase): Integer;
     {* рассчитываем видимый индекс для ноды }
   function GetINode(anIndex: Integer): INodeBase;
     {* возвращает узел по видимому индексу [0..CountView-1] }
   procedure CursorTop;
     {* переставить курсор на первый видимый элемент }
 protected
 // protected properties
   property OneLevel: Boolean
     read f_OneLevel
     write f_OneLevel;
 public
 // public properties
   property CurrentNodeIndex: Integer
     read f_CurrentNodeIndex;
   property CurrentNode: INodeBase
     read pm_GetCurrentNode;
 end;//_nsRootManager_

{$Else nsRootManager_imp}

{$Include ..\Tree\nsRootManagerPrim.imp.pas}

// start class _nsRootManager_

function _nsRootManager_.pm_GetCurrentNode: INodeBase;
//#UC START# *48FDC5BC0004_48FDC52D0006get_var*
//#UC END# *48FDC5BC0004_48FDC52D0006get_var*
begin
//#UC START# *48FDC5BC0004_48FDC52D0006get_impl*
 if (f_CurrentNode = nil) then
 begin
  if GetShowRoot then
   f_CurrentNode := RootNode
  else
  if (RootNode <> nil) then
   RootNode.GetFirstChild(f_CurrentNode);
  f_CurrentNodeIndex := 0;
 end;//f_CurrentNode = nil
 Result := f_CurrentNode;
//#UC END# *48FDC5BC0004_48FDC52D0006get_impl*
end;//_nsRootManager_.pm_GetCurrentNode

function _nsRootManager_.GetByVisibleIndex(anIndex: Integer): INodeBase;
//#UC START# *48FDC58F0218_48FDC52D0006_var*
var
 l_Index: Integer;
 l_TmpCountViewChanged: Boolean;
//#UC END# *48FDC58F0218_48FDC52D0006_var*
begin
//#UC START# *48FDC58F0218_48FDC52D0006_impl*
 Result := nil;
 GetByVisibleIndexStarted;
 try
  l_TmpCountViewChanged := CountViewChanged;
  try
   if (CurrentNode = nil) then
   begin
    l_Index := anIndex;
    if not GetShowRoot then
     Inc(l_Index);
    if (RootNode <> nil) then
    begin
     RootNode.GetByVisibleIndex(l_Index, Result);
     f_CurrentNode := Result;
     f_CurrentNodeIndex := anIndex;
    end;//RootNode <> nil
   end//CurrentNode = nil
   else
   begin

    if f_OneLevel then  // http://mdp.garant.ru/pages/viewpage.action?pageId=585938594
      CurrentNode.GetBySibblingIndex(anIndex - f_CurrentNodeIndex, Result)
    else
      CurrentNode.GetByVisibleIndex(anIndex - f_CurrentNodeIndex, Result);
    if not CountViewChanged then
    // Если не изменялось количество видимых элементов во время получения текущего - то присваиваем Current
    begin
     f_CurrentNodeIndex := anIndex;
     f_CurrentNode := Result;
    end;//not CountViewChanged
    f_CountViewChanged := False;
   end;//CurrentNode = nil
  finally
   f_CountViewChanged := l_TmpCountViewChanged;
  end;//try..finally
 finally
  GetByVisibleIndexFinished;
 end;//try..finally
//#UC END# *48FDC58F0218_48FDC52D0006_impl*
end;//_nsRootManager_.GetByVisibleIndex

procedure _nsRootManager_.GetByVisibleIndexStarted;
//#UC START# *48FDC5DE02CF_48FDC52D0006_var*
//#UC END# *48FDC5DE02CF_48FDC52D0006_var*
begin
//#UC START# *48FDC5DE02CF_48FDC52D0006_impl*
 Inc(f_GetByVisibleIndexCounter);
//#UC END# *48FDC5DE02CF_48FDC52D0006_impl*
end;//_nsRootManager_.GetByVisibleIndexStarted

procedure _nsRootManager_.GetByVisibleIndexFinished;
//#UC START# *48FDC5EE026F_48FDC52D0006_var*
//#UC END# *48FDC5EE026F_48FDC52D0006_var*
begin
//#UC START# *48FDC5EE026F_48FDC52D0006_impl*
 if f_GetByVisibleIndexCounter > 0 then
  Dec(f_GetByVisibleIndexCounter)
 else
  Assert(f_GetByVisibleIndexCounter > 0, 'Непарный вызов GetByVisibleIndexStarted/Finished');
//#UC END# *48FDC5EE026F_48FDC52D0006_impl*
end;//_nsRootManager_.GetByVisibleIndexFinished

function _nsRootManager_.GetVisibleIndex(const aNode: INodeBase): Integer;
//#UC START# *48FDC60C0328_48FDC52D0006_var*
var
 l_Index            : Integer;
 l_CurrentNodeIndex : Integer;
//#UC END# *48FDC60C0328_48FDC52D0006_var*
begin
//#UC START# *48FDC60C0328_48FDC52D0006_impl*
 Result := -1;
 try
  if (CurrentNode = nil) then
  begin
   if (RootNode <> nil) then
   begin
    Result := RootNode.GetVisibleDelta(aNode);
    if not GetShowRoot then
     Dec(Result);
   end;
  end//CurrentNode = nil
  else
  begin
   l_CurrentNodeIndex := CurrentNodeIndex;
   l_Index := CurrentNode.GetVisibleDelta(aNode);
   Result := l_Index + l_CurrentNodeIndex;
   // - CurrentNodeIndex использовать нельзя, потому что
   //   CurrentNode.GetVisibleDelta(aNode) может вызвать перерисовку
   //   NodeNotifier.Invalidate и CurrentNodeIndex будет равен последнему
   //   отрисованному;
  end;//CurrentNode = nil
 except
  on ENotFound do ; // Ноду не нашли (скорее всего она не видимая), вернем -1
 end;//try..except
//#UC END# *48FDC60C0328_48FDC52D0006_impl*
end;//_nsRootManager_.GetVisibleIndex

function _nsRootManager_.GetINode(anIndex: Integer): INodeBase;
//#UC START# *48FDC628027A_48FDC52D0006_var*
//#UC END# *48FDC628027A_48FDC52D0006_var*
begin
//#UC START# *48FDC628027A_48FDC52D0006_impl*
 if (CurrentNode <> nil) and
    (CurrentNodeIndex = anIndex) then
 begin
  // - возвращаем то, что было запомнено
  Result := CurrentNode;
  Exit;
 end;//CurrentNode <> nil
 if (RootNode = nil) then
  Result := nil
 else
 begin
  if GetShowRoot and (anIndex = 0) then
   Result := RootNode;

  if (Result = nil) then
   Result := GetByVisibleIndex(anIndex);
 end;//RootNode = nil
// SetNewCurrentNode(Result, anIndex);
//#UC END# *48FDC628027A_48FDC52D0006_impl*
end;//_nsRootManager_.GetINode

procedure _nsRootManager_.CursorTop;
//#UC START# *48FDC63903E2_48FDC52D0006_var*
//#UC END# *48FDC63903E2_48FDC52D0006_var*
begin
//#UC START# *48FDC63903E2_48FDC52D0006_impl*
 if (RootNode <> nil) then
 begin
  f_CurrentNode := nil;
  f_CurrentNodeIndex := 0;
 end//RootNode <> nil
 else
  DropCurrent;
//#UC END# *48FDC63903E2_48FDC52D0006_impl*
end;//_nsRootManager_.CursorTop

procedure _nsRootManager_.Cleanup;
//#UC START# *48FD97BC0335_48FDC52D0006_var*
//#UC END# *48FD97BC0335_48FDC52D0006_var*
begin
//#UC START# *48FD97BC0335_48FDC52D0006_impl*
 f_GetByVisibleIndexCounter := 0;
 f_OneLevel := False;
 inherited;
 RootNode := nil;
//#UC END# *48FD97BC0335_48FDC52D0006_impl*
end;//_nsRootManager_.Cleanup

function _nsRootManager_.IsInGetByVisibleIndex: Boolean;
//#UC START# *48FDA0CB01AD_48FDC52D0006_var*
//#UC END# *48FDA0CB01AD_48FDC52D0006_var*
begin
//#UC START# *48FDA0CB01AD_48FDC52D0006_impl*
 Result := (f_GetByVisibleIndexCounter > 0);
//#UC END# *48FDA0CB01AD_48FDC52D0006_impl*
end;//_nsRootManager_.IsInGetByVisibleIndex

function _nsRootManager_.DoChangeChildrenCount(aNodeIndex: TVisibleIndex;
  aDelta: Integer): Integer;
//#UC START# *48FDA0F500F9_48FDC52D0006_var*
//#UC END# *48FDA0F500F9_48FDC52D0006_var*
begin
//#UC START# *48FDA0F500F9_48FDC52D0006_impl*
 if (RootNode <> nil) then
 begin
  if (not GetShowRoot)
  // http://mdp.garant.ru/pages/viewpage.action?pageId=316114353
  // http://mdp.garant.ru/pages/viewpage.action?pageId=316114353&focusedCommentId=328863929#comment-328863929
  and (aNodeIndex > 0)
  //
  then
   Result := aNodeIndex - 1
  else
   Result := aNodeIndex;
  if Assigned(f_CurrentNode) and
     (Result < f_CurrentNodeIndex) then
   // Корректируем индекс текущего элемента, если изменения дерева произошли "выше" него
   if (aDelta < 0) and
      (f_CurrentNodeIndex + aDelta <= Result) then
   begin
    f_CurrentNode := nil;
    f_CurrentNodeIndex := -1;
   end//aDelta < 0..
   else
    Inc(f_CurrentNodeIndex, aDelta);
 end//aNodeIndex = -1
 else
  Result := inherited DoChangeChildrenCount(aNodeIndex, aDelta);
//#UC END# *48FDA0F500F9_48FDC52D0006_impl*
end;//_nsRootManager_.DoChangeChildrenCount

procedure _nsRootManager_.DropCurrent;
//#UC START# *48FDA1F20208_48FDC52D0006_var*
//#UC END# *48FDA1F20208_48FDC52D0006_var*
begin
//#UC START# *48FDA1F20208_48FDC52D0006_impl*
 inherited;
 f_CurrentNode := nil;
 f_CurrentNodeIndex := -1;
//#UC END# *48FDA1F20208_48FDC52D0006_impl*
end;//_nsRootManager_.DropCurrent

procedure _nsRootManager_.ClearFields;
 {-}
begin
 f_CurrentNode := nil;
 inherited;
end;//_nsRootManager_.ClearFields

{$EndIf nsRootManager_imp}
