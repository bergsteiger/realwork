unit alcuTaskListBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuTaskListBase.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi$AutoPipeServer$Garant::Tasks::TasksLists::alcuTaskListBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  ,
  alcuTaskListPrim,
  alcuTaskListBasePrim,
  SyncObjs,
  l3Interfaces,
  l3NotifyPtrList
  ;

type
  alcuTasksIterator_ForEachF_Action = function (anItem: TddProcessTask): Boolean;
   {* Тип подитеративной функции для alcuTasksIterator.ForEachF }

  alcuTasksIterator_ForOneF_Action = function (anItem: TddProcessTask): Boolean;
   {* Тип подитеративной функции для alcuTasksIterator.ForOneF }

  alcuTasksIterator_ForOneByIDF_Action = function (anItem: TddProcessTask): Boolean;
   {* Тип подитеративной функции для alcuTasksIterator.ForOneByIDF }

(*
 alcuTasksIterator = PureMixIn
   {iterator} procedure ForEachF(anAction: alcuTasksIterator_ForEachF_Action);
   {iterator} procedure ForOneF(anAction: alcuTasksIterator_ForOneF_Action;
    anIndex: Integer);
   {iterator} function ForOneByIDF(anAction: alcuTasksIterator_ForOneByIDF_Action;
    const aTaskID: AnsiString): Boolean;
 end;//alcuTasksIterator
*)

 _l3CriticalSectionHolder_Parent_ = TalcuTaskListBasePrim;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 _l3ChangingWithLock_Parent_ = _l3CriticalSectionHolder_;
 {$Include w:\common\components\rtl\Garant\L3\l3ChangingWithLock.imp.pas}
 TalcuTaskListBase = class(_l3ChangingWithLock_)
 private
 // private fields
   f_Items : TalcuTaskListPrim;
    {* Поле для свойства Items}
 protected
 // property methods
   function pm_GetCount: Integer;
 public
 // realized methods
   {iterator} procedure ForEachF(anAction: alcuTasksIterator_ForEachF_Action);
   {iterator} procedure ForOneF(anAction: alcuTasksIterator_ForOneF_Action;
    anIndex: Integer);
   {iterator} function ForOneByIDF(anAction: alcuTasksIterator_ForOneByIDF_Action;
    const aTaskID: AnsiString): Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   function NeedSort: Boolean; virtual;
 public
 // public methods
   procedure Clear;
 protected
 // protected properties
   property Items: TalcuTaskListPrim
     read f_Items;
 public
 // public properties
   property Count: Integer
     read pm_GetCount;
 end;//TalcuTaskListBase
function L2AlcuTasksIteratorForEachFAction(anAction: pointer): alcuTasksIterator_ForEachF_Action;
   {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для alcuTasksIterator.ForEachF }
function L2AlcuTasksIteratorForOneFAction(anAction: pointer): alcuTasksIterator_ForOneF_Action;
   {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для alcuTasksIterator.ForOneF }
function L2AlcuTasksIteratorForOneByIDFAction(anAction: pointer): alcuTasksIterator_ForOneByIDF_Action;
   {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для alcuTasksIterator.ForOneByIDF }
{$IfEnd} //AppServerSide AND ServerTasks

implementation

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  l3Base,
  SysUtils,
  l3Types
  ;

// start class alcuTasksIterator

function L2AlcuTasksIteratorForEachFAction(anAction: pointer): alcuTasksIterator_ForEachF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2AlcuTasksIteratorForEachFAction

function L2AlcuTasksIteratorForOneFAction(anAction: pointer): alcuTasksIterator_ForOneF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2AlcuTasksIteratorForOneFAction

function L2AlcuTasksIteratorForOneByIDFAction(anAction: pointer): alcuTasksIterator_ForOneByIDF_Action;
 {-}
asm
 jmp l3LocalStub
end;//L2AlcuTasksIteratorForOneByIDFAction
{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3ChangingWithLock.imp.pas}

// start class TalcuTaskListBase

procedure TalcuTaskListBase.Clear;
//#UC START# *53A063C502F6_53A038090050_var*
//#UC END# *53A063C502F6_53A038090050_var*
begin
//#UC START# *53A063C502F6_53A038090050_impl*
 Changing;
 try
  Lock;
  try
   f_Items.Clear;
  finally
   Unlock;
  end;//try..finally
 finally
  Changed;
 end;
//#UC END# *53A063C502F6_53A038090050_impl*
end;//TalcuTaskListBase.Clear

function TalcuTaskListBase.NeedSort: Boolean;
//#UC START# *53A196850107_53A038090050_var*
//#UC END# *53A196850107_53A038090050_var*
begin
//#UC START# *53A196850107_53A038090050_impl*
 Result := false;
//#UC END# *53A196850107_53A038090050_impl*
end;//TalcuTaskListBase.NeedSort

function TalcuTaskListBase.pm_GetCount: Integer;
//#UC START# *53A064490063_53A038090050get_var*
//#UC END# *53A064490063_53A038090050get_var*
begin
//#UC START# *53A064490063_53A038090050get_impl*
(* Lock;
 try*)
  Result := f_Items.Count;
(* finally
  Unlock;
 end;//try..finally*)
//#UC END# *53A064490063_53A038090050get_impl*
end;//TalcuTaskListBase.pm_GetCount

{iterator} procedure TalcuTaskListBase.ForEachF(anAction: alcuTasksIterator_ForEachF_Action);
//#UC START# *53A04652024A_53A038090050_var*

 function DoIt(aData : PObject; anIndex : Integer) : Boolean;
 begin
  Result := anAction(TddProcessTask(aData^));
 end;
 
var
 Hack : Pointer absolute anAction;
//#UC END# *53A04652024A_53A038090050_var*
begin
//#UC START# *53A04652024A_53A038090050_impl*
 try
  Lock;
  try
   f_Items.IterateAllF(l3L2IA(@DoIt));
  finally
   Unlock;
  end;//try..finally
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *53A04652024A_53A038090050_impl*
end;//TalcuTaskListBase.ForEachF

{iterator} procedure TalcuTaskListBase.ForOneF(anAction: alcuTasksIterator_ForOneF_Action;
  anIndex: Integer);
//#UC START# *53A199A802C9_53A038090050_var*
var
 Hack : Pointer absolute anAction;
//#UC END# *53A199A802C9_53A038090050_var*
begin
//#UC START# *53A199A802C9_53A038090050_impl*
 try
  Lock;
  try
   if (anIndex >= 0) AND (anIndex < f_Items.Count) then
    anAction(f_Items[anIndex]);
  finally
   Unlock;
  end;//try..finally
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
//#UC END# *53A199A802C9_53A038090050_impl*
end;//TalcuTaskListBase.ForOneF

{iterator} function TalcuTaskListBase.ForOneByIDF(anAction: alcuTasksIterator_ForOneByIDF_Action;
  const aTaskID: AnsiString): Boolean;
//#UC START# *546B5A73038A_53A038090050_var*

var
 l_Found : TddProcessTask;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  if anItem.TaskID = aTaskID then
  begin
   anItem.SetRefTo(l_Found);
   //anAction(anItem);
   ForOneByIDF := true;
   Result := false;
  end//anItem.TaskID = aTaskID
  else
   Result := true;
 end;

var
 Hack : Pointer absolute anAction;

//#UC END# *546B5A73038A_53A038090050_var*
begin
//#UC START# *546B5A73038A_53A038090050_impl*
 Result := false;
 l_Found := nil;
 try
 // Result := nil;
  try
   ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   if (l_Found <> nil) then
    anAction(l_Found);
  finally
   l3FreeLocalStub(Hack);
  end;//try..finally
 finally
  FreeAndNil(l_Found);
 end;//try..finally
//#UC END# *546B5A73038A_53A038090050_impl*
end;//TalcuTaskListBase.ForOneByIDF

procedure TalcuTaskListBase.Cleanup;
//#UC START# *479731C50290_53A038090050_var*
//#UC END# *479731C50290_53A038090050_var*
begin
//#UC START# *479731C50290_53A038090050_impl*
 FreeAndNil(f_Items);
 inherited;
//#UC END# *479731C50290_53A038090050_impl*
end;//TalcuTaskListBase.Cleanup

procedure TalcuTaskListBase.InitFields;
//#UC START# *47A042E100E2_53A038090050_var*
//#UC END# *47A042E100E2_53A038090050_var*
begin
//#UC START# *47A042E100E2_53A038090050_impl*
 inherited;
 if NeedSort then
  f_Items := TalcuTaskListPrim.MakeSorted(l3_dupError)
 else
  f_Items := TalcuTaskListPrim.Create;
//#UC END# *47A042E100E2_53A038090050_impl*
end;//TalcuTaskListBase.InitFields
{$IfEnd} //AppServerSide AND ServerTasks

end.