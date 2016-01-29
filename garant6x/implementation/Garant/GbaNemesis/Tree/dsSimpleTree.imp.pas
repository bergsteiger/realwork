{$IfNDef dsSimpleTree_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tree"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Tree/dsSimpleTree.imp.pas"
// Начат: 2005/8/3 13:49:6
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Базовые определения предметной области::LegalDomain::Tree::Tree::dsSimpleTree
//
// Бизнес объект формы с деревом
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsSimpleTree_imp}
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 _dsSimpleTree_ = {abstract vac} class(_vcmFormDataSource_, IdsSimpleTree, InsDropListener)
  {* Бизнес объект формы с деревом }
 private
 // private fields
   f_SimpleTree : Il3SimpleTree;
   f_IsFirstMake : Boolean;
    {* Поле для свойства IsFirstMake}
   f_MovingCurrent : Il3SimpleNode;
    {* Поле для свойства MovingCurrent}
   f_PrevMovingCurrent : Il3SimpleNode;
    {* Поле для свойства PrevMovingCurrent}
   f_ChangeCurrentTime : Cardinal;
    {* Поле для свойства ChangeCurrentTime}
   f_UpdateCurrentTimer : TTimer;
    {* Поле для свойства UpdateCurrentTimer}
   f_Current : Il3SimpleNode;
    {* Поле для свойства Current}
 private
 // private methods
   procedure OnUpdateCurrent(aSender: TObject);
   procedure MovingFinished;
     {* перемещение закончено }
 protected
 // property methods
   function pm_GetUpdateCurrentTimer: TTimer;
 protected
 // realized methods
   procedure DataDropped;
     {* данные приняты объектом }
   function pm_GetImageList: Il3ImageList;
   function pm_GetSimpleTree: Il3SimpleTree;
   procedure pm_SetSimpleTree(const aValue: Il3SimpleTree);
   procedure CurrentChanged(const aNode: Il3SimpleNode;
    aUpdateWithDelay: Boolean = True);
     {* изменился текущий узел дерева. По умолчанию включён режим отложенного
           обновления текущего, чтобы не обновлялось свзянное представление при
           быстром перемещении. Когда пользователь в дереве открывает элемент
           отложенное обновление нужно выключать }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   function MakeDisplayName: IvcmCString; override;
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure DoInit; override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure DoCurrentChanged(const aNode: Il3SimpleNode); virtual;
     {* сменился текущий. }
   function MakeImageList: Il3ImageList; virtual;
     {* - создать иконки дерева. }
   function MakeSimpleTree: Il3SimpleTree; virtual; abstract;
     {* Создать данные дерева }
   procedure UpdateSimpleTree(const aOld: Il3SimpleTree;
    const aNew: Il3SimpleTree); virtual;
     {* - обновить данные дерева. }
   procedure DoDataDropped; virtual;
   function RefreshSimpleTree: Il3SimpleTree;
     {* обнуляет SimpleTree и получает его заново }
 private
 // private properties
   property MovingCurrent: Il3SimpleNode
     read f_MovingCurrent
     write f_MovingCurrent;
     {* текущий перемещаемый в дереве, которым ещё не было обновлено связанное
           представление }
   property PrevMovingCurrent: Il3SimpleNode
     read f_PrevMovingCurrent
     write f_PrevMovingCurrent;
     {* предыдущий текущий узел в дереве, используется для определения конца
          перемещения }
   property ChangeCurrentTime: Cardinal
     read f_ChangeCurrentTime
     write f_ChangeCurrentTime;
     {* время последнего обновления текущего }
   property UpdateCurrentTimer: TTimer
     read pm_GetUpdateCurrentTimer;
   property Current: Il3SimpleNode
     read f_Current
     write f_Current;
     {* текущий узел, данные которого показываются в связанном представлении
           (например список и зона синхронного просмотра) }
 protected
 // protected properties
   property IsFirstMake: Boolean
     read f_IsFirstMake;
 end;//_dsSimpleTree_

{$Else dsSimpleTree_imp}


{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

const
   { Times }
  ns_UpdateTime = 100;
   { время с момента обновления текущего после которого можно снова обновлять связанное представление }

// start class _dsSimpleTree_

function _dsSimpleTree_.pm_GetUpdateCurrentTimer: TTimer;
//#UC START# *492152570031_47F0C1410011get_var*
//#UC END# *492152570031_47F0C1410011get_var*
begin
//#UC START# *492152570031_47F0C1410011get_impl*
 if f_UpdateCurrentTimer = nil then
 begin
  f_UpdateCurrentTimer := TTimer.Create(nil);
  with f_UpdateCurrentTimer do
  begin
   Enabled := False;
   OnTimer := OnUpdateCurrent;
   Interval := ns_UpdateTime;
  end;//with f_UpdateCurrentTimer do
 end;//if f_UpdateCurrentTimer = nil then
 Result := f_UpdateCurrentTimer;
//#UC END# *492152570031_47F0C1410011get_impl*
end;//_dsSimpleTree_.pm_GetUpdateCurrentTimer

procedure _dsSimpleTree_.DoCurrentChanged(const aNode: Il3SimpleNode);
//#UC START# *47F0C1BF0314_47F0C1410011_var*
//#UC END# *47F0C1BF0314_47F0C1410011_var*
begin
//#UC START# *47F0C1BF0314_47F0C1410011_impl*

//#UC END# *47F0C1BF0314_47F0C1410011_impl*
end;//_dsSimpleTree_.DoCurrentChanged

function _dsSimpleTree_.MakeImageList: Il3ImageList;
//#UC START# *47F465F80149_47F0C1410011_var*
//#UC END# *47F465F80149_47F0C1410011_var*
begin
//#UC START# *47F465F80149_47F0C1410011_impl*
 Result := vtMakeImageListWrapper(vtStdResources.Images);
//#UC END# *47F465F80149_47F0C1410011_impl*
end;//_dsSimpleTree_.MakeImageList

procedure _dsSimpleTree_.UpdateSimpleTree(const aOld: Il3SimpleTree;
  const aNew: Il3SimpleTree);
//#UC START# *47FC718400FA_47F0C1410011_var*
//#UC END# *47FC718400FA_47F0C1410011_var*
begin
//#UC START# *47FC718400FA_47F0C1410011_impl*
 if (aOld <> nil) then
  aOld.Unsubscribe(InsDropListener(Self));
 f_SimpleTree := aNew;
 if (aNew <> nil) then
  aNew.Subscribe(InsDropListener(Self));
//#UC END# *47FC718400FA_47F0C1410011_impl*
end;//_dsSimpleTree_.UpdateSimpleTree

procedure _dsSimpleTree_.OnUpdateCurrent(aSender: TObject);
//#UC START# *492140830112_47F0C1410011_var*
//#UC END# *492140830112_47F0C1410011_var*
begin
//#UC START# *492140830112_47F0C1410011_impl*
 if MovingCurrent = PrevMovingCurrent then
 begin
  UpdateCurrentTimer.Enabled := False;
  MovingFinished;
 end
 else
  PrevMovingCurrent := MovingCurrent;
//#UC END# *492140830112_47F0C1410011_impl*
end;//_dsSimpleTree_.OnUpdateCurrent

procedure _dsSimpleTree_.MovingFinished;
//#UC START# *49214097027A_47F0C1410011_var*
var
 l_Node: INodeBase;
 l_Root: INodeBase;
 l_NewCurrent : INodeBase;
 l_ST         : Il3SimpleTree;
//#UC END# *49214097027A_47F0C1410011_var*
begin
//#UC START# *49214097027A_47F0C1410011_impl*
 ChangeCurrentTime := GetTickCount;
 l_ST := pm_GetSimpleTree;
 // Разворачиваем обратно ноду (если можем) K-122667444 
 if Assigned(l_ST) and Supports(l_ST.RootNode, INodeBase, l_Root) and
    Supports(MovingCurrent, INodeBase, l_Node) then
 begin
  l_Root.FindNode(l_Node, l_NewCurrent);
  Current := TnsNewCachableNode.Make(l_NewCurrent);
 end
 else
  Current := MovingCurrent;
 DoCurrentChanged(Current);
 ChangeCurrentTime := GetTickCount;
//#UC END# *49214097027A_47F0C1410011_impl*
end;//_dsSimpleTree_.MovingFinished

procedure _dsSimpleTree_.DoDataDropped;
//#UC START# *49215CE702B9_47F0C1410011_var*
//#UC END# *49215CE702B9_47F0C1410011_var*
begin
//#UC START# *49215CE702B9_47F0C1410011_impl*
 
//#UC END# *49215CE702B9_47F0C1410011_impl*
end;//_dsSimpleTree_.DoDataDropped

function _dsSimpleTree_.RefreshSimpleTree: Il3SimpleTree;
//#UC START# *4978163E03A0_47F0C1410011_var*
//#UC END# *4978163E03A0_47F0C1410011_var*
begin
//#UC START# *4978163E03A0_47F0C1410011_impl*
 pm_SetSimpleTree(nil);
 Result := pm_GetSimpleTree;
//#UC END# *4978163E03A0_47F0C1410011_impl*
end;//_dsSimpleTree_.RefreshSimpleTree

procedure _dsSimpleTree_.DataDropped;
//#UC START# *48FEE96D03AD_47F0C1410011_var*
//#UC END# *48FEE96D03AD_47F0C1410011_var*
begin
//#UC START# *48FEE96D03AD_47F0C1410011_impl*
  DoDataDropped;
//#UC END# *48FEE96D03AD_47F0C1410011_impl*
end;//_dsSimpleTree_.DataDropped

function _dsSimpleTree_.pm_GetImageList: Il3ImageList;
//#UC START# *491DD57603A3_47F0C1410011get_var*
//#UC END# *491DD57603A3_47F0C1410011get_var*
begin
//#UC START# *491DD57603A3_47F0C1410011get_impl*
 Result := MakeImageList;
//#UC END# *491DD57603A3_47F0C1410011get_impl*
end;//_dsSimpleTree_.pm_GetImageList

function _dsSimpleTree_.pm_GetSimpleTree: Il3SimpleTree;
//#UC START# *491DD5A10199_47F0C1410011get_var*
//#UC END# *491DD5A10199_47F0C1410011get_var*
begin
//#UC START# *491DD5A10199_47F0C1410011get_impl*
 if not Assigned(f_SimpleTree) then
 begin
  pm_SetSimpleTree(MakeSimpleTree);
  f_IsFirstMake := False;
 end;//if not Assigned(f_SimpleTree) then
 Result := f_SimpleTree;
//#UC END# *491DD5A10199_47F0C1410011get_impl*
end;//_dsSimpleTree_.pm_GetSimpleTree

procedure _dsSimpleTree_.pm_SetSimpleTree(const aValue: Il3SimpleTree);
//#UC START# *491DD5A10199_47F0C1410011set_var*
var
 l_Old: Il3SimpleTree;
//#UC END# *491DD5A10199_47F0C1410011set_var*
begin
//#UC START# *491DD5A10199_47F0C1410011set_impl*
 l_Old := f_SimpleTree;
  // - нужно увеличить счетчик ссылок, чтобы не получилось, что f_SimpleTree
  //   в процессе обработки отпустили, а кто либо продолжит работу с "const aOld";
 try
  UpdateSimpleTree(l_Old, aValue);
 finally
  l_Old := nil;
 end;//try..finally
//#UC END# *491DD5A10199_47F0C1410011set_impl*
end;//_dsSimpleTree_.pm_SetSimpleTree

procedure _dsSimpleTree_.CurrentChanged(const aNode: Il3SimpleNode;
  aUpdateWithDelay: Boolean = True);
//#UC START# *491DD5C90095_47F0C1410011_var*

 procedure lp_UpdateMovingCurrent;
 var
  l_Node           : INodeBase;
  l_UnfilteredNode : INodeBase;
 begin
  if Assigned(aNode) then
  begin
   if Supports(aNode, INodeBase, l_Node) then
   try
    // При фильтрации, View дерева может умереть раньше чем, узел этого View, с
    // которым после умирания работать будет нельзя, поэтому получаем
    // нефильтрованный вариант узла (CQ: OIT5-28558):
    l_Node.GetUnfilteredNode(l_UnfilteredNode);
    try
     MovingCurrent := TnsNewCachableNode.Make(l_UnfilteredNode);
    finally
     l_UnfilteredNode := nil;
    end;//try..finally
   finally
    l_Node := nil;
   end//try..finally
   else
    Assert(False);
  end
  else
   MovingCurrent := nil;
 end;//lp_UpdateMovingCurrent

//#UC END# *491DD5C90095_47F0C1410011_var*
begin
//#UC START# *491DD5C90095_47F0C1410011_impl*
 lp_UpdateMovingCurrent;
 if not aUpdateWithDelay then
 begin
  MovingFinished;
  Exit;
 end;//if not aUpdateWithDelay then
 if UpdateCurrentTimer.Enabled then
  Exit
 else
  if (GetTickCount - ChangeCurrentTime < ns_UpdateTime) then
   UpdateCurrentTimer.Enabled := True
  else
   MovingFinished;
//#UC END# *491DD5C90095_47F0C1410011_impl*
end;//_dsSimpleTree_.CurrentChanged

procedure _dsSimpleTree_.Cleanup;
//#UC START# *479731C50290_47F0C1410011_var*
//#UC END# *479731C50290_47F0C1410011_var*
begin
//#UC START# *479731C50290_47F0C1410011_impl*
 FreeAndNil(f_UpdateCurrentTimer);
 pm_SetSimpleTree(nil);
 inherited;
//#UC END# *479731C50290_47F0C1410011_impl*
end;//_dsSimpleTree_.Cleanup

{$If not defined(NoVCM)}
function _dsSimpleTree_.MakeDisplayName: IvcmCString;
//#UC START# *491476B001D3_47F0C1410011_var*
var
 l_ST : Il3SimpleTree;
//#UC END# *491476B001D3_47F0C1410011_var*
begin
//#UC START# *491476B001D3_47F0C1410011_impl*
 l_ST := pm_GetSimpleTree;
 if Assigned(l_ST) and Assigned(l_ST.RootNode) then
  Result := l3CStr(l_ST.RootNode)
 else
  Result := nil;
//#UC END# *491476B001D3_47F0C1410011_impl*
end;//_dsSimpleTree_.MakeDisplayName
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure _dsSimpleTree_.DoInit;
//#UC START# *492BF7900310_47F0C1410011_var*
//#UC END# *492BF7900310_47F0C1410011_var*
begin
//#UC START# *492BF7900310_47F0C1410011_impl*
 inherited;
 f_IsFirstMake := True;
//#UC END# *492BF7900310_47F0C1410011_impl*
end;//_dsSimpleTree_.DoInit
{$IfEnd} //not NoVCM

procedure _dsSimpleTree_.ClearFields;
 {-}
begin
 MovingCurrent := nil;
 PrevMovingCurrent := nil;
 Current := nil;
 inherited;
end;//_dsSimpleTree_.ClearFields

{$EndIf dsSimpleTree_imp}
