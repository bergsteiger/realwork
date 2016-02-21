unit alcuAsyncSubmitterManager;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\alcuAsyncSubmitterManager.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 {$If Defined(ServerTasks)}
 , alcuServerAsyncExecutionInterfaces
 {$IfEnd} // Defined(ServerTasks)
 , alcuBaseEngineHolder
 , alcuTaskExecutingList
 , dt_Types
 {$If NOT Defined(Nemesis)}
 , csProcessTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TalcuAsyncSubmitterManager = class(Tl3ProtoObject{$If Defined(ServerTasks)}
 , IalcuAsyncSubmitterManager
 {$IfEnd} // Defined(ServerTasks)
 )
  private
   f_BaseEngineHolder: TalcuBaseEngineHolder;
   f_ExecutingList: TalcuTaskExecutingList;
  protected
   {$If Defined(ServerTasks)}
   function Get_ServerHostName: AnsiString;
   {$IfEnd} // Defined(ServerTasks)
   {$If Defined(ServerTasks)}
   function Get_ServerPort: Integer;
   {$IfEnd} // Defined(ServerTasks)
   {$If Defined(ServerTasks)}
   procedure GetUserAccountByID(anID: TUserID;
    out theName: AnsiString;
    out thePassword: AnsiString);
    {* Получить логин/пароль по ID }
   {$IfEnd} // Defined(ServerTasks)
   {$If Defined(ServerTasks)}
   function IsUserLogined(aUserID: TUserID): Boolean;
   {$IfEnd} // Defined(ServerTasks)
   {$If Defined(ServerTasks)}
   procedure SendAbortNotification(anID: TUserID);
   {$IfEnd} // Defined(ServerTasks)
   {$If Defined(ServerTasks)}
   function EnterTaskExecution(const aTask: TddProcessTask): Boolean;
   {$IfEnd} // Defined(ServerTasks)
   {$If Defined(ServerTasks)}
   procedure LeaveTaskExecution(const aTask: TddProcessTask);
   {$IfEnd} // Defined(ServerTasks)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aBaseEngineHolder: TalcuBaseEngineHolder); reintroduce;
   class function Make(const aBaseEngineHolder: TalcuBaseEngineHolder): IalcuAsyncSubmitterManager; reintroduce;
 end;//TalcuAsyncSubmitterManager
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_UserTypes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_User
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , CsNotification
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Types
 , l3Base
 , daUtils
;

constructor TalcuAsyncSubmitterManager.Create(const aBaseEngineHolder: TalcuBaseEngineHolder);
//#UC START# *53CCF63B0139_53CCC324034B_var*
//#UC END# *53CCF63B0139_53CCC324034B_var*
begin
//#UC START# *53CCF63B0139_53CCC324034B_impl*
 inherited Create;
 Assert(Assigned(aBaseEngineHolder));
 aBaseEngineHolder.SetRefTo(f_BaseEngineHolder);
 f_ExecutingList := TalcuTaskExecutingList.Make;
//#UC END# *53CCF63B0139_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.Create

class function TalcuAsyncSubmitterManager.Make(const aBaseEngineHolder: TalcuBaseEngineHolder): IalcuAsyncSubmitterManager;
var
 l_Inst : TalcuAsyncSubmitterManager;
begin
 l_Inst := Create(aBaseEngineHolder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TalcuAsyncSubmitterManager.Make

{$If Defined(ServerTasks)}
function TalcuAsyncSubmitterManager.Get_ServerHostName: AnsiString;
//#UC START# *53CCB9F20088_53CCC324034Bget_var*
//#UC END# *53CCB9F20088_53CCC324034Bget_var*
begin
//#UC START# *53CCB9F20088_53CCC324034Bget_impl*
 Result := f_BaseEngineHolder.BaseEngine.ServerHostName;
//#UC END# *53CCB9F20088_53CCC324034Bget_impl*
end;//TalcuAsyncSubmitterManager.Get_ServerHostName
{$IfEnd} // Defined(ServerTasks)

{$If Defined(ServerTasks)}
function TalcuAsyncSubmitterManager.Get_ServerPort: Integer;
//#UC START# *53CCBA0D01C7_53CCC324034Bget_var*
//#UC END# *53CCBA0D01C7_53CCC324034Bget_var*
begin
//#UC START# *53CCBA0D01C7_53CCC324034Bget_impl*
 Result := f_BaseEngineHolder.BaseEngine.ServerPort;
//#UC END# *53CCBA0D01C7_53CCC324034Bget_impl*
end;//TalcuAsyncSubmitterManager.Get_ServerPort
{$IfEnd} // Defined(ServerTasks)

{$If Defined(ServerTasks)}
procedure TalcuAsyncSubmitterManager.GetUserAccountByID(anID: TUserID;
 out theName: AnsiString;
 out thePassword: AnsiString);
 {* Получить логин/пароль по ID }
//#UC START# *53CCBA3D0104_53CCC324034B_var*
var
 l_User: TArchiUser;
//#UC END# *53CCBA3D0104_53CCC324034B_var*
begin
//#UC START# *53CCBA3D0104_53CCC324034B_impl*
 l_User := UserManager.UserByID(anID);
 Assert(Assigned(l_User));
 theName := l_User.LoginName;
 thePassword := l_User.Password;
//#UC END# *53CCBA3D0104_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.GetUserAccountByID
{$IfEnd} // Defined(ServerTasks)

{$If Defined(ServerTasks)}
function TalcuAsyncSubmitterManager.IsUserLogined(aUserID: TUserID): Boolean;
//#UC START# *53CCBA9702A7_53CCC324034B_var*
//#UC END# *53CCBA9702A7_53CCC324034B_var*
begin
//#UC START# *53CCBA9702A7_53CCC324034B_impl*
 Result := f_BaseEngineHolder.BaseEngine.CSServer.ActiveClients.IsLogged(aUserID);
//#UC END# *53CCBA9702A7_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.IsUserLogined
{$IfEnd} // Defined(ServerTasks)

{$If Defined(ServerTasks)}
procedure TalcuAsyncSubmitterManager.SendAbortNotification(anID: TUserID);
//#UC START# *53CF91EC007A_53CCC324034B_var*
//#UC END# *53CF91EC007A_53CCC324034B_var*
begin
//#UC START# *53CF91EC007A_53CCC324034B_impl*
 f_BaseEngineHolder.BaseEngine.CSServer.Notifier.SendNotify(anID, ntAbortAsyncRun, 0, '');
//#UC END# *53CF91EC007A_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.SendAbortNotification
{$IfEnd} // Defined(ServerTasks)

{$If Defined(ServerTasks)}
function TalcuAsyncSubmitterManager.EnterTaskExecution(const aTask: TddProcessTask): Boolean;
//#UC START# *53D0AB57028E_53CCC324034B_var*
var
  l_Result: Boolean;
  l_NeedAdd: Boolean;
  l_Counter: TalcuTaskExecutionCounter;


 function SearchTask(aCounter: PalcuTaskExecutionCounter; Index: Long): Bool;
 begin
   Result := True;
   if aCounter.Task = aTask then
   begin
     aCounter.Counter := aCounter.Counter + 1;
     l_NeedAdd := False;
     l_Result := True;
     Result := False;
     Exit;
   end;
   if not UserIsService(aCounter.Task.UserID) and (aCounter.Task.UserID = aTask.UserID) and (aCounter.Task <> aTask) then
     l_Result := False;
   if not aTask.CanSimultaneousRunWith(aCounter.Task) then
     l_Result := False;
 end;

//#UC END# *53D0AB57028E_53CCC324034B_var*
begin
//#UC START# *53D0AB57028E_53CCC324034B_impl*
 l_Result := True;
 l_NeedAdd := True;
 f_ExecutingList.IterateAllF(l3L2IA(@SearchTask));
 if l_Result and l_NeedAdd then
 begin
  l_Counter := TalcuTaskExecutionCounter.Create(aTask);
  try
   l_Counter.Counter := 1;
   f_ExecutingList.Add(l_Counter);
  finally
   FreeANdNil(l_Counter);
  end;
 end;
 Result := l_Result;
//#UC END# *53D0AB57028E_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.EnterTaskExecution
{$IfEnd} // Defined(ServerTasks)

{$If Defined(ServerTasks)}
procedure TalcuAsyncSubmitterManager.LeaveTaskExecution(const aTask: TddProcessTask);
//#UC START# *53D0AB7A03A7_53CCC324034B_var*
var
  l_IndexToDelete: Long;

 function DoIt(aCounter: PalcuTaskExecutionCounter; Index: Long): Bool;
 begin
   if aCounter.Task = aTask then
   begin
     Result := False;
     aCounter.Counter := aCounter.Counter - 1;
     if aCounter.Counter = 0 then
       l_IndexToDelete := Index;
   end
   else
     Result := True;
 end;

//#UC END# *53D0AB7A03A7_53CCC324034B_var*
begin
//#UC START# *53D0AB7A03A7_53CCC324034B_impl*
 l_IndexToDelete := -1;
 f_ExecutingList.IterateAllF(l3L2IA(@DoIt));
 if l_IndexToDelete <> -1 then
   f_ExecutingList.Delete(l_IndexToDelete);
//#UC END# *53D0AB7A03A7_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.LeaveTaskExecution
{$IfEnd} // Defined(ServerTasks)

procedure TalcuAsyncSubmitterManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53CCC324034B_var*
//#UC END# *479731C50290_53CCC324034B_var*
begin
//#UC START# *479731C50290_53CCC324034B_impl*
 FreeAndNil(f_BaseEngineHolder);
 FreeAndNil(f_ExecutingList);
 inherited Cleanup;
//#UC END# *479731C50290_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.Cleanup
{$IfEnd} // Defined(AppServerSide)

end.
