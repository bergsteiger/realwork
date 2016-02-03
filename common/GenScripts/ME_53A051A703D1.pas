unit alcuTaskListBase;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuTaskListBase.pas"
// Стереотип: "UtilityPack"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3IntfUses
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
 , alcuTaskListBasePrim
 , alcuTaskListPrim
 , SyncObjs
 , l3Interfaces
 , l3NotifyPtrList
;

type
 alcuTasksIterator_ForEachF_Action = function(anItem: TddProcessTask): Boolean;
  {* Тип подитеративной функции для alcuTasksIterator.ForEachF }

 alcuTasksIterator_ForOneF_Action = function(anItem: TddProcessTask): Boolean;
  {* Тип подитеративной функции для alcuTasksIterator.ForOneF }

 alcuTasksIterator_ForOneByIDF_Action = function(anItem: TddProcessTask): Boolean;
  {* Тип подитеративной функции для alcuTasksIterator.ForOneByIDF }

 (*
 alcuTasksIterator = interface
  procedure ForEachF(anAction: alcuTasksIterator_ForEachF_Action);
  procedure ForOneF(anAction: alcuTasksIterator_ForOneF_Action;
   anIndex: Integer);
  function ForOneByIDF(anAction: alcuTasksIterator_ForOneByIDF_Action;
   const aTaskID: AnsiString): Boolean;
 end;//alcuTasksIterator
 *)

 _l3CriticalSectionHolder_Parent_ = TalcuTaskListBasePrim;
 {$Include l3CriticalSectionHolder.imp.pas}
 _l3ChangingWithLock_Parent_ = _l3CriticalSectionHolder_;
 {$Include l3ChangingWithLock.imp.pas}
 TalcuTaskListBase = class(_l3ChangingWithLock_)
  private
   f_Items: TalcuTaskListPrim;
    {* Поле для свойства Items }
  protected
   function pm_GetCount: Integer;
   function NeedSort: Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Clear;
   procedure ForEachF(anAction: alcuTasksIterator_ForEachF_Action);
   procedure ForOneF(anAction: alcuTasksIterator_ForOneF_Action;
    anIndex: Integer);
   function ForOneByIDF(anAction: alcuTasksIterator_ForOneByIDF_Action;
    const aTaskID: AnsiString): Boolean;
  protected
   property Items: TalcuTaskListPrim
    read f_Items;
  public
   property Count: Integer
    read pm_GetCount;
 end;//TalcuTaskListBase

function L2_alcuTasksIterator_ForEachF_Action(anAction: pointer): alcuTasksIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для alcuTasksIterator.ForEachF }
function L2_alcuTasksIterator_ForOneF_Action(anAction: pointer): alcuTasksIterator_ForOneF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для alcuTasksIterator.ForOneF }
function L2_alcuTasksIterator_ForOneByIDF_Action(anAction: pointer): alcuTasksIterator_ForOneByIDF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для alcuTasksIterator.ForOneByIDF }
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

implementation

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3Types
;

function L2_alcuTasksIterator_ForEachF_Action(anAction: pointer): alcuTasksIterator_ForEachF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для alcuTasksIterator.ForEachF }
asm
 jmp l3LocalStub
end;//L2_alcuTasksIterator_ForEachF_Action

function L2_alcuTasksIterator_ForOneF_Action(anAction: pointer): alcuTasksIterator_ForOneF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для alcuTasksIterator.ForOneF }
asm
 jmp l3LocalStub
end;//L2_alcuTasksIterator_ForOneF_Action

function L2_alcuTasksIterator_ForOneByIDF_Action(anAction: pointer): alcuTasksIterator_ForOneByIDF_Action;
 {* Функция формирования заглушки для ЛОКАЛЬНОЙ подитеративной функции для alcuTasksIterator.ForOneByIDF }
asm
 jmp l3LocalStub
end;//L2_alcuTasksIterator_ForOneByIDF_Action

{$Include l3CriticalSectionHolder.imp.pas}

{$Include l3ChangingWithLock.imp.pas}

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

procedure TalcuTaskListBase.ForEachF(anAction: alcuTasksIterator_ForEachF_Action);
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

procedure TalcuTaskListBase.ForOneF(anAction: alcuTasksIterator_ForOneF_Action;
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

function TalcuTaskListBase.ForOneByIDF(anAction: alcuTasksIterator_ForOneByIDF_Action;
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
 {* Функция очистки полей объекта. }
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
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

end.
