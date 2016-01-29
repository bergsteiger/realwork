unit alcuAsyncSubmitterManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/alcuAsyncSubmitterManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Server::Managers::TalcuAsyncSubmitterManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  l3ProtoObject
  {$If defined(AppServerSide) AND defined(ServerTasks)}
  ,
  alcuServerAsyncExecutionInterfaces
  {$IfEnd} //AppServerSide AND ServerTasks
  ,
  alcuBaseEngineHolder,
  alcuTaskExecutingList,
  dt_Types
  {$If not defined(Nemesis)}
  ,
  csProcessTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
type
 TalcuAsyncSubmitterManager = class(Tl3ProtoObject {$If defined(AppServerSide) AND defined(ServerTasks)}, IalcuAsyncSubmitterManager{$IfEnd} //AppServerSide AND ServerTasks
 )
 private
 // private fields
   f_BaseEngineHolder : TalcuBaseEngineHolder;
   f_ExecutingList : TalcuTaskExecutingList;
 protected
 // realized methods
   {$If defined(AppServerSide) AND defined(ServerTasks)}
   function Get_ServerHostName: AnsiString;
   {$IfEnd} //AppServerSide AND ServerTasks
   {$If defined(AppServerSide) AND defined(ServerTasks)}
   function Get_ServerPort: Integer;
   {$IfEnd} //AppServerSide AND ServerTasks
   {$If defined(AppServerSide) AND defined(ServerTasks)}
   procedure GetUserAccountByID(anID: TUserID;
    out theName: AnsiString;
    out thePassword: AnsiString);
     {* Получить логин/пароль по ID }
   {$IfEnd} //AppServerSide AND ServerTasks
   {$If defined(AppServerSide) AND defined(ServerTasks)}
   function IsUserLogined(aUserID: TUserID): Boolean;
   {$IfEnd} //AppServerSide AND ServerTasks
   {$If defined(AppServerSide) AND defined(ServerTasks)}
   procedure SendAbortNotification(anID: TUserID);
   {$IfEnd} //AppServerSide AND ServerTasks
   {$If defined(AppServerSide) AND defined(ServerTasks)}
   function EnterTaskExecution(const aTask: TddProcessTask): Boolean;
   {$IfEnd} //AppServerSide AND ServerTasks
   {$If defined(AppServerSide) AND defined(ServerTasks)}
   procedure LeaveTaskExecution(const aTask: TddProcessTask);
   {$IfEnd} //AppServerSide AND ServerTasks
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aBaseEngineHolder: TalcuBaseEngineHolder); reintroduce;
   class function Make(const aBaseEngineHolder: TalcuBaseEngineHolder): IalcuAsyncSubmitterManager; reintroduce;
     {* Сигнатура фабрики TalcuAsyncSubmitterManager.Make }
 end;//TalcuAsyncSubmitterManager
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  dt_UserTypes
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  dt_User
  {$IfEnd} //not Nemesis
  ,
  SysUtils
  {$If not defined(Nemesis)}
  ,
  CsNotification
  {$IfEnd} //not Nemesis
  ,
  l3Types,
  l3Base,
  daUtils
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}

// start class TalcuAsyncSubmitterManager

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
end;

{$If defined(AppServerSide) AND defined(ServerTasks)}
function TalcuAsyncSubmitterManager.Get_ServerHostName: AnsiString;
//#UC START# *53CCB9F20088_53CCC324034Bget_var*
//#UC END# *53CCB9F20088_53CCC324034Bget_var*
begin
//#UC START# *53CCB9F20088_53CCC324034Bget_impl*
 Result := f_BaseEngineHolder.BaseEngine.ServerHostName;
//#UC END# *53CCB9F20088_53CCC324034Bget_impl*
end;//TalcuAsyncSubmitterManager.Get_ServerHostName
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
function TalcuAsyncSubmitterManager.Get_ServerPort: Integer;
//#UC START# *53CCBA0D01C7_53CCC324034Bget_var*
//#UC END# *53CCBA0D01C7_53CCC324034Bget_var*
begin
//#UC START# *53CCBA0D01C7_53CCC324034Bget_impl*
 Result := f_BaseEngineHolder.BaseEngine.ServerPort;
//#UC END# *53CCBA0D01C7_53CCC324034Bget_impl*
end;//TalcuAsyncSubmitterManager.Get_ServerPort
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
procedure TalcuAsyncSubmitterManager.GetUserAccountByID(anID: TUserID;
  out theName: AnsiString;
  out thePassword: AnsiString);
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
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
function TalcuAsyncSubmitterManager.IsUserLogined(aUserID: TUserID): Boolean;
//#UC START# *53CCBA9702A7_53CCC324034B_var*
//#UC END# *53CCBA9702A7_53CCC324034B_var*
begin
//#UC START# *53CCBA9702A7_53CCC324034B_impl*
 Result := f_BaseEngineHolder.BaseEngine.CSServer.ActiveClients.IsLogged(aUserID);
//#UC END# *53CCBA9702A7_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.IsUserLogined
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
procedure TalcuAsyncSubmitterManager.SendAbortNotification(anID: TUserID);
//#UC START# *53CF91EC007A_53CCC324034B_var*
//#UC END# *53CF91EC007A_53CCC324034B_var*
begin
//#UC START# *53CF91EC007A_53CCC324034B_impl*
 f_BaseEngineHolder.BaseEngine.CSServer.Notifier.SendNotify(anID, ntAbortAsyncRun, 0, '');
//#UC END# *53CF91EC007A_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.SendAbortNotification
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
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
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
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
{$IfEnd} //AppServerSide AND ServerTasks

procedure TalcuAsyncSubmitterManager.Cleanup;
//#UC START# *479731C50290_53CCC324034B_var*
//#UC END# *479731C50290_53CCC324034B_var*
begin
//#UC START# *479731C50290_53CCC324034B_impl*
 FreeAndNil(f_BaseEngineHolder);
 FreeAndNil(f_ExecutingList);
 inherited Cleanup;
//#UC END# *479731C50290_53CCC324034B_impl*
end;//TalcuAsyncSubmitterManager.Cleanup

{$IfEnd} //AppServerSide

end.