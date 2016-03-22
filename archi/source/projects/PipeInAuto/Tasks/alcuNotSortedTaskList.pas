unit alcuNotSortedTaskList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuNotSortedTaskList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::TasksLists::TalcuNotSortedTaskList
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
  alcuTaskListBase
  ;
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
const
  { Consts }
 cMaxDayAge = 2;

type
 TalcuNotSortedTaskList = class(TalcuTaskListBase)
 public
 // public methods
   function Add(anItem: TddProcessTask): Integer;
   function Has(anItem: TddProcessTask): Boolean;
   procedure PackUnimportant(MaxDayAge: Integer = cMaxDayAge);
 end;//TalcuNotSortedTaskList
{$IfEnd} //AppServerSide AND ServerTasks

implementation

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  SysUtils
  ;
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}

// start class TalcuNotSortedTaskList

function TalcuNotSortedTaskList.Add(anItem: TddProcessTask): Integer;
//#UC START# *53A1A06B0290_53A19980030C_var*
//#UC END# *53A1A06B0290_53A19980030C_var*
begin
//#UC START# *53A1A06B0290_53A19980030C_impl*
 Changing;
 try
  Lock;
  try
   Result := Items.Add(anItem);
  finally
   Unlock;
  end;//try..finally
 finally
  Changed;
 end;
//#UC END# *53A1A06B0290_53A19980030C_impl*
end;//TalcuNotSortedTaskList.Add

function TalcuNotSortedTaskList.Has(anItem: TddProcessTask): Boolean;
//#UC START# *53A1A65A030A_53A19980030C_var*
//#UC END# *53A1A65A030A_53A19980030C_var*
begin
//#UC START# *53A1A65A030A_53A19980030C_impl*
 Lock;
 try
  Result := (Items.IndexOf(anItem) >= 0);
 finally
  Unlock;
 end;//try..finally
//#UC END# *53A1A65A030A_53A19980030C_impl*
end;//TalcuNotSortedTaskList.Has

procedure TalcuNotSortedTaskList.PackUnimportant(MaxDayAge: Integer = cMaxDayAge);
//#UC START# *55F283340044_53A19980030C_var*
var
 l_IDX: Integer;
 l_Found: Boolean;
 l_Now: TDateTime;
//#UC END# *55F283340044_53A19980030C_var*
begin
//#UC START# *55F283340044_53A19980030C_impl*
 Lock;
 try
  l_Found := False;
  l_Now := Now;
  for l_IDX := Items.Count - 1 downto 0 do
   if (Items[l_IDX].IsUnimportant(l_Now, MaxDayAge)) then
    l_Found := True;
  if not l_Found then
   Exit;
  Changing;
  try
   for l_IDX := Items.Count - 1 downto 0 do
    if (Items[l_IDX].IsUnimportant(l_Now, MaxDayAge)) then
     Items.Delete(l_IDX);
  finally
   Changed;
  end;
 finally
  Unlock;
 end;//try..finally
//#UC END# *55F283340044_53A19980030C_impl*
end;//TalcuNotSortedTaskList.PackUnimportant

{$IfEnd} //AppServerSide AND ServerTasks

end.