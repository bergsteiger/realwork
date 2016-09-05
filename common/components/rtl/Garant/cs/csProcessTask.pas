unit csProcessTask;

interface

{$Include CsDefine.inc}

uses
 Classes,
 CsDataPipe,
 ddProgressObj,
 ddServerTask,
 l3LongintList,
 CsTaskTypes,
 daTypes,
 DT_Const,

  {$If defined(AppServerSide)}
 csMessageManager,
  {$IfEnd defined(AppServerSide)}

 k2Base, l3Types,

 ddProcessTaskPrim,
 l3InterfacePtrList,
 csTaskResult
 ;

type
 TddProcessTask = class;

 IcsExternalTaskAbortProcessor = interface(IUnknown)
   ['{40349F73-8FCB-46B2-B835-902D4DAB3F3E}']
   function ProcessAbort(const aTask: TddProcessTask): Boolean;
     {* Если успешно абортировала задачу вернет True. Тогда штатная обработка обключается }
 end;//IcsExternalTaskAbortProcessor

 IcsRunTaskServices = interface(IUnknown)
   ['{38851828-B75C-4B6B-8017-90CA9E1ADC3E}']
   procedure AddActiveTask(const aTask: TddProcessTask);
   procedure SendTextMessage(anUserID: TdaUserID;
    const aMessage: AnsiString);
 end;//IcsRunTaskServises

 IcsFileTransferServices = interface(IUnknown)
   ['{FB5B417E-E4BB-4834-A0BD-940697670FB9}']
   function TransferFile(const aTargetFolder: AnsiString;
    const aSourceFileName: AnsiString;
    const aTargetFileName: AnsiString): Boolean;
 end;//IcsFileTransferServices

 PcsExternalTaskAbortProcessor = ^IcsExternalTaskAbortProcessor;

  TddProcessTask = class(TddProcessTaskPrim)
  private
    f_Aborted: Boolean;
    f_Deleting: Boolean;
    f_WasDeliveredAfterRun : Boolean;
    f_RunComment: AnsiString;
    f_RunProgress: Long;
    f_AbortProcessorList : Tl3InterfacePtrList;
    f_TaskResult: TcsTaskResult;
    function pm_GetDelayed: Boolean;
    function pm_GetReadyToDelivery: Boolean;
    function pm_GetEnabled: Boolean;
    procedure pm_SetEnabled(const Value: Boolean);
    function DoExternalAbort: Boolean;
    procedure ReportError;
  protected
    function RequireDelivery: Boolean; virtual;
  {$If defined(AppServerSide)}
    procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); virtual;
  {$IfEnd defined(AppServerSide)}
    procedure DoRun(const aContext: TddRunContext); virtual;
    procedure DoAbort; virtual;

    procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
    procedure DoWriteResult(aPipe: TcsDataPipe); virtual;
    procedure Cleanup; override;
    function GetTaskResultClass: TcsTaskResultClass; virtual;
    function AllowSimultaneousRun: Boolean; virtual;
  {$IfDef Archi}
  public
  {$EndIf Archi}
    property StatusW: TcsTaskStatus write pm_SetStatus;
  public
    constructor Create(aUserID: TdaUserID); override;
    function CanSimultaneousRunWith(const aTask: TddProcessTask): Boolean; virtual;
    function IgnoreStrangeExitCode: Boolean; virtual;
    procedure Abort;
    function NeedProcess: Boolean;
    procedure Done;
    procedure AsyncError(const aErrorMessage: String = '');
    procedure Error(const aErrorMessage: String = '');
  {$If defined(AppServerSide) or defined(ServerAssistantSide)}
    procedure Run(const aContext: TddRunContext);
  {$IfEnd defined(AppServerSide) or defined(ServerAssistantSide)}
  {$If defined(AppServerSide)}
    procedure RunSuccessfullyFinished(const aServices: IcsRunTaskServices);
  {$IfEnd defined(AppServerSide)}
  {$If defined(AppServerSide)}
    procedure RunEnded(const aServices: IcsRunTaskServices); virtual;
      // Не важно удачно или нет - будет выдернут всегда
  {$IfEnd defined(AppServerSide)}
    function HasFilesToTransfer: Boolean; virtual;
    function TransferFiles(const aService: IcsFileTransferServices): Boolean; virtual;
    function ExpandTransferFileName(const aFileName: String; out theBasePath, theFileName: String): Boolean; virtual;
    procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
    procedure WriteResult(aPipe: TcsDataPipe);
    property Aborted: Boolean read f_Aborted;
    property Delayed: Boolean read pm_GetDelayed;
    property ReadyToDelivery: Boolean read pm_GetReadyToDelivery;
    property Enabled: Boolean read pm_GetEnabled write pm_SetEnabled;
    property Status: TcsTaskStatus read pm_GetStatus;
    function CompareWith(anObject: TddProcessTask): Integer;
    procedure CorrectStatus; virtual;
    procedure RequestQuery;
    procedure RequestDelete;
    procedure RequestFrozen;
    procedure RequestFrozenRun;
    procedure RequestDelivery;
    procedure RequestDelivering;
    procedure RequestRun;
    procedure RequestAsyncRun;
    procedure SetProgress(AProgress: Long; const aMsg: AnsiString);
    procedure AsyncErrorIfRunning(const aErrorMessage: String = '');
  {$If defined(AppServerSide)}
    procedure SetupServerSideConfigParams; virtual;
  {$IfEnd defined(AppServerSide)}
    procedure RegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
     {* Сигнатура метода RegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor) }
    procedure UnRegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
     {* Сигнатура метода UnRegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor) }
    procedure SetCommentToDefault;
    procedure SaveTaskToPipe(aPipe: TCsDataPipe);
    function IsHiddenFromUser: Boolean; virtual;
    function IsUnimportant(aNow: TDateTime = 0; MaxDayAge: Integer = 2): Boolean;
    property RunProgress: Long read f_RunProgress;
    property RunComment: AnsiString read f_RunComment;
    property TaskResult: TcsTaskResult read f_TaskResult;
  end;//TddProcessTask

type
 TcsTaskCompareKind = (
  cs_tckByPriority,
  cs_tckByStatus,
  cs_tckByUser,
  cs_tckByDate
 );

function CompareTaskStatus(aStatus1, aStatus2: TcsTaskStatus): Integer;

function CompareTaskByPriority(const A, B: TddProcessTask): Integer;
function CompareTaskByStatus(const A, B: TddProcessTask): Integer;
function CompareTaskByUser(const A: TddProcessTask; const UserA: AnsiString; const B: TddProcessTask; const UserB: AnsiString): Integer;
function CompareTaskByDate(const A, B: TddProcessTask): Integer;
function CompareTaskByKind(aKind: TcsTaskCompareKind; const A: TddProcessTask; const UserA: AnsiString; const B: TddProcessTask; const UserB: AnsiString): Integer;

implementation

uses
  l3Base,
  l3Except,
  SysUtils,
  l3FileUtils,
  l3Memory,

  daDataProvider,

  k2Tags,
  ProcessTask_Const,

  Math,
  DateUtils,
  TypInfo,

  ddTaskItemPrim,

  csTaskChangeHelper;

const
 TaskStatusSortWeight: array[TcsTaskStatus] of Integer = (
  100, // cs_tsNone
  5,   // cs_tsQuery { в очереди }
  10,  // cs_tsRun { выполняется }
  0,   // cs_tsFrozen { заморожено }
  15,  // cs_tsFrozenRun{ заморожено }
  20,  // cs_tsReadyToDelivery { ожидание доставки пользователю }
  40,  // cs_tsDone { обработано }
  30,  // cs_tsDeleted { удалено }
  35,  // cs_tsError { выполнение привело к ошибке }
  0,   // cs_tsDelayed { выполнение отложено до ЕО }
  20,  // cs_tsDelivering { выполняется доставка результатов }
  10,  // cs_tsAsyncRun { Исполнение в отцепленном процессе }
  35,  // cs_tsAsyncError { выполнение в отцепленном процессе привело к ошибке }
  35   // cs_tsAborting { выполнение прерывается }
 );

function CompareTaskForActiveList(const A, B: TddProcessTask): Integer;
begin
 if (A = B) then
  Result := 0
 else
 begin
  Result:= CompareValue(A.Priority, B.Priority);
  if Result = 0 then
  begin
   Result := CompareDateTime(A.Date, B.Date);
   if Result = 0 then
    Result := CompareValue(A.UserID, B.UserID);
   if Result = 0 then
    Result := CompareValue(Ord(A.TaskType), Ord(B.TaskType));
   if Result = 0 then
    Result := CompareStr(A.TaskID, B.TaskID);
  end;
 end;
end;


function CompareTaskStatus(aStatus1, aStatus2: TcsTaskStatus): Integer;
begin
 Result := CompareValue(TaskStatusSortWeight[aStatus1], TaskStatusSortWeight[aStatus2]);
end;

function DefaultCompareTail(const A, B: TddProcessTask): Integer;
begin
 Result := CompareDateTime(B.Date, A.Date); // Новые - в начало.
 if Result = 0 then
  Result := CompareValue(A.UserID, B.UserID);
 if Result = 0 then
  Result := CompareValue(Ord(A.TaskType), Ord(B.TaskType));
 if Result = 0 then
  Result := CompareStr(A.TaskID, B.TaskID);
end;

function CompareTaskByPriority(const A, B: TddProcessTask): Integer;
begin
 if (A = B) then
  Result := 0
 else
 begin
  Result:= CompareValue(A.Priority, B.Priority);
  if Result = 0 then
   Result := DefaultCompareTail(A, B);
 end;
end;

function CompareTaskByStatus(const A, B: TddProcessTask): Integer;
begin
 if (A = B) then
  Result := 0
 else
 begin
  Result:= CompareTaskStatus(A.Status, B.Status);
  if Result = 0 then
   Result:= CompareTaskByPriority(A, B);
 end;
end;

function CompareTaskByUser(const A: TddProcessTask; const UserA: AnsiString; const B: TddProcessTask; const UserB: AnsiString): Integer;
begin
 if (A = B) then
  Result := 0
 else
 begin
  Result:= CompareStr(UserA, UserB);
  if Result = 0 then
   Result:= CompareTaskByPriority(A, B);
 end;
end;

function CompareTaskByKind(aKind: TcsTaskCompareKind; const A: TddProcessTask; const UserA: AnsiString; const B: TddProcessTask; const UserB: AnsiString): Integer;
begin
 case aKind of
  cs_tckByPriority:
   Result := CompareTaskByPriority(A, B);
  cs_tckByStatus:
   Result := CompareTaskByStatus(A, B);
  cs_tckByUser:
   Result := CompareTaskByUser(A, UserA, B, UserB);
  cs_tckByDate:
   Result := CompareTaskByDate(A, B);
 else
  Assert(False);
  Result := 0;
 end;
end;

function CompareTaskByDate(const A, B: TddProcessTask): Integer;
begin
 Result := DefaultCompareTail(A, B);
end;
{
******************************** TddProcessTask ********************************
}

procedure TddProcessTask.Abort;
begin
  f_Aborted:= True;
  if not DoExternalAbort then
    DoAbort;
  if not (Status in (cs_tsFinishedStatuses + [cs_tsReadyToDelivery, cs_tsDelivering])) then
  begin
    StatusW := cs_tsAborting;
    SetCommentToDefault;
  end;
end;

procedure TddProcessTask.RequestDelivery;
begin
 if RequireDelivery then
 begin
  l3System.Msg2Log('Задача с идентификатором ' + TaskID + ' метится для доставки. Статус задачи: ' + GetEnumName(TypeInfo(TcsTaskStatus), ord(Status)));
  StatusW := cs_tsReadyToDelivery;
  SetCOmmentToDefault;
  l3System.Msg2Log('Задача с идентификатором ' + TaskID + ' помечена для доставки. Статус задачи: ' + GetEnumName(TypeInfo(TcsTaskStatus), ord(Status)));
 end
 else
  Done;
end;

procedure TddProcessTask.Done;
begin
 //Clear; // раз задача выполнена, никакая информация уже не нужна
 if f_Deleting then
 begin
  StatusW := cs_tsDeleted;
  SetCommentToDefault;
 end
 else
  if f_Aborted then
  begin
   if not (Status in cs_tsErrorStatuses) then
   begin
    StatusW := cs_tsError;
    SetCommentToDefault;
   end;
  end
  else
   if not (Status in cs_tsErrorStatuses) then
   begin
    if not f_WasDeliveredAfterRun then
     if ReadyToDelivery then
      l3System.Stack2Log('Задача с идентификатором ' + TaskID + ' метится как выполненая. Статус задачи: ' + GetEnumName(TypeInfo(TcsTaskStatus), ord(Status)));
    StatusW := cs_tsDone;
    SetCommentToDefault;
   end;
end;

procedure TddProcessTask.DoRun(const aContext: TddRunContext);
begin
 {$IfDef nsTest}
 Assert(false, Format('Не перекрыт метод %s.DoRun', [ClassName]));
 {$Else  nsTest}
 l3System.Msg2Log('Не перекрыт метод %s.DoRun', [ClassName], l3_msgLevel3);
 {$EndIf nsTest}
end;

procedure TddProcessTask.Error(const aErrorMessage: String = '');
begin
 if aErrorMessage = '' then
  Self.Comment := 'Выполнение завершилось ошибкой'
 else
  Self.Comment := aErrorMessage;
 StatusW:= cs_tsError;
 ReportError;
end;

procedure TddProcessTask.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
var
 l_Status : TcsTaskStatus;
begin
 inherited;
 aStream.Read(l_Status, SizeOf(l_Status));
 StatusW := l_Status;
 Self.Comment := ReadString(aStream);
 DocumentIDList.Load(aStream);
end;

function TddProcessTask.pm_GetDelayed: Boolean;
begin
 Result := Status = cs_tsDelayed;
end;

function TddProcessTask.pm_GetReadyToDelivery: Boolean;
begin
 Result := Status = cs_tsReadyToDelivery;
end;

function TddProcessTask.pm_GetEnabled: Boolean;
begin
 Result := Status = cs_tsQuery;
end;

procedure TddProcessTask.RequestFrozen;
begin
 StatusW := cs_tsFrozen;
 SetCommentToDefault;
end;

procedure TddProcessTask.pm_SetEnabled(const Value: Boolean);
begin
 if (Status in [cs_tsQuery, cs_tsFrozen]) then
 begin
  if Value then
   RequestQuery
  else
   RequestFrozen;
 end;//Status in [cs_tsQuery, cs_tsFrozen]
end;

procedure TddProcessTask.RequestRun;
begin
 f_Aborted := False;
 f_Deleting := False;
 f_WasDeliveredAfterRun := false;
 if Status <> cs_tsAsyncRun then
 begin
   StatusW := cs_tsRun;
   SetCommentToDefault;
 end;
end;

  {$If defined(AppServerSide) or defined(ServerAssistantSide)}
procedure TddProcessTask.Run(const aContext: TddRunContext);
begin
 RequestRun;
 try
  TaskResult.TaskID := TaskID;
  GlobalDataProvider.BeginImpersonate(UserID);
  try
   DoRun(aContext);
  finally
   GlobalDataProvider.EndImpersonate;
  end;
 except
  on E: Exception do
  begin
   {$IfDef nsTest}
   raise;
   {$Else  nsTest}
   if not (E is El3AbortLoad) and not (E is EAbort) then
   begin
    StatusW := cs_tsError;
    l3System.Msg2Log(Format('TASKERROR fired for task: %s (%s)', [Self.Comment, Self.TaskID]));
    l3System.Exception2Log(E);
   end;
   {$EndIf nsTest}
  end;
 end;//try..except
end;
  {$IfEnd defined(AppServerSide) or defined(ServerAssistantSide)}

procedure TddProcessTask.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
var
 l_Status : TcsTaskStatus;
begin
 f_Aborted := False;
 f_Deleting := False;
 inherited;
 l_Status := Self.Status;
 aStream.Write(l_Status, SizeOf(l_Status));
 WriteString(aStream, Comment);
 DocumentIDList.Save(aStream);
end;

procedure TddProcessTask.DoWriteResult(aPipe: TcsDataPipe);
begin
end;

procedure TddProcessTask.WriteResult(aPipe: TcsDataPipe);
begin
 DoWriteResult(aPipe);
 f_WasDeliveredAfterRun := true;
end;

function TddProcessTask.CompareWith(anObject: TddProcessTask): Integer;
begin
 Result := CompareTaskForActiveList(Self, anObject);
end;

procedure TddProcessTask.CorrectStatus;
begin
 if (Self.Status in cs_tsRunningStatuses + [cs_tsFrozenRun]) then
  RequestQuery
 else
 if (Self.Status = cs_tsDelivering) then
  RequestDelivery;
end;

procedure TddProcessTask.RequestQuery;
begin
 Self.StatusW := cs_tsQuery;
 SetCommentToDefault;
end;

procedure TddProcessTask.RequestDelete;
begin
 if Status in (cs_tsRunningStatuses + [cs_tsAborting]) then
 begin
  f_Deleting := True;
  Comment := 'Задача удаляется';
 end
 else
 begin
  Self.StatusW := cs_tsDeleted;
  SetCommentToDefault;
 end;
end;

procedure TddProcessTask.RequestDelivering;
begin
 Self.StatusW := cs_tsDelivering;
 SetCommentToDefault;
end;

function TddProcessTask.NeedProcess: Boolean;
begin
  Result := Status in [cs_tsQuery];
end;

procedure TddProcessTask.ReportError;
begin
 if Aborted then
  l3System.Msg2Log('Task aborted by user: %s (%s)', [Self.Comment, Self.TaskID])
 else
 begin
  l3System.Stack2Log(Format('TASKERROR fired for task: %s (%s)', [Self.Comment, Self.TaskID]));
  TcsTaskChangeHelper.Instance.TaskGotErrorStatus;
 end;
end;

procedure TddProcessTask.AsyncError(const aErrorMessage: String = '');
begin
 if aErrorMessage = '' then
   Self.Comment := 'асинхронное выполнение завершилось ошибкой'
 else
   Self.Comment := aErrorMessage;
 StatusW:= cs_tsAsyncError;
 ReportError;
end;

procedure TddProcessTask.SetProgress(AProgress: Long;
  const aMsg: AnsiString);
begin
  if (f_RunComment <> aMsg) or (RunProgress <> aProgress) then
  begin
    f_RunComment := aMsg;
    f_RunProgress := aProgress;
    Changed(cs_tsNone);
  end;
end;

procedure TddProcessTask.DoAbort;
begin
//  l3System.Msg2Log('Не определен механизм Abort для задач типа '+ClassName);
// Do nothing
end;

procedure TddProcessTask.RequestAsyncRun;
begin
  StatusW := cs_tsAsyncRun;
  SetCommentToDefault;
end;

procedure TddProcessTask.AsyncErrorIfRunning(const aErrorMessage: String);
begin
 if Status in cs_tsRunningStatuses then
   AsyncError(aErrorMessage);
end;

  {$If defined(AppServerSide)}
procedure TddProcessTask.SetupServerSideConfigParams;
begin
// Do nothing;
end;
  {$IfEnd defined(AppServerSide)}

procedure TddProcessTask.Cleanup;
begin
  l3Free(f_TaskResult);
  l3Free(f_AbortProcessorList);
  inherited;
end;

procedure TddProcessTask.RegisterAbortProcessor(
  const aProcessor: IcsExternalTaskAbortProcessor);
begin
  f_AbortProcessorList.Add(aProcessor);
end;

procedure TddProcessTask.UnRegisterAbortProcessor(
  const aProcessor: IcsExternalTaskAbortProcessor);
begin
  f_AbortProcessorList.Remove(aProcessor);
end;

constructor TddProcessTask.Create(aUserID: TdaUserID);
begin
  inherited Create(aUserID);
  f_AbortProcessorList := Tl3InterfacePtrList.Make;
  f_TaskResult := GetTaskResultClass.Create;
end;

function TddProcessTask.DoExternalAbort: Boolean;
var
  l_Found: Boolean;

  function DoIt(aData: PcsExternalTaskAbortProcessor; Index: Long): Bool;
  begin
    if aData^.ProcessAbort(Self) then
    begin
      l_Found := True;
      Result := False;
    end
    else
      Result := True;
  end;

begin
  l_Found := False;
  f_AbortProcessorList.IterateAllF(l3L2IA(@DoIt));
  Result := l_Found;
end;

function TddProcessTask.RequireDelivery: Boolean;
begin
  Result := False;
end;

  {$If defined(AppServerSide)}
procedure TddProcessTask.RunSuccessfullyFinished(const aServices: IcsRunTaskServices);
begin
 if Status in cs_tsRunningStatuses then
  try
   DoRunSuccessfullyFinished(aServices);
   RequestDelivery;
  except
   on E: Exception do
   begin
    {$IfDef nsTest}
    raise;
    {$Else  nsTest}
    if not (E is El3AbortLoad) and not (E is EAbort) then
    begin
     StatusW := cs_tsError;
     l3System.Msg2Log(Format('TASKERROR fired for task: %s (%s)', [Self.Comment, Self.TaskID]));
     l3System.Exception2Log(E);
    end;
    {$EndIf nsTest}
   end;
  end;//try..except
end;
  {$IfEnd defined(AppServerSide)}

  {$If defined(AppServerSide)}
procedure TddProcessTask.DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices);
begin
// Do nothing;
end;
  {$IfEnd defined(AppServerSide)}

function TddProcessTask.GetTaskResultClass: TcsTaskResultClass;
begin
  Result := TcsTaskResult;
end;

function TddProcessTask.AllowSimultaneousRun: Boolean;
begin
  Result := True;
end;

procedure TddProcessTask.RequestFrozenRun;
begin
 StatusW := cs_tsFrozenRun;
end;

function TddProcessTask.CanSimultaneousRunWith(
  const aTask: TddProcessTask): Boolean;
begin
 Result := (aTask = Self) or (ClassName <> aTask.ClassName) or AllowSimultaneousRun;
end;

function TddProcessTask.IgnoreStrangeExitCode: Boolean;
begin
 Result := False;
end;

  {$If defined(AppServerSide)}
procedure TddProcessTask.RunEnded(const aServices: IcsRunTaskServices);
begin
// Do nothing
end;
  {$IfEnd defined(AppServerSide)}

procedure TddProcessTask.SetCommentToDefault;
begin
 case Status of
  cs_tsQuery: Comment := 'ожидание выполнения';
  cs_tsRun: Comment := 'выполняется';
  cs_tsFrozen: Comment := 'заморожено';
  cs_tsReadyToDelivery: Comment := 'ожидает доставки пользователю';
  cs_tsDone: Comment := 'выполнено';
  cs_tsDeleted: Comment := 'удалено';
  cs_tsError: Comment := 'выполнение завершилось ошибкой';
  cs_tsDelivering: Comment := 'доставляется';
  cs_tsAsyncRun: Comment := 'выполняется асинхронно';
  cs_tsAsyncError: Comment := 'асинхронное выполнение завершилось ошибкой';
  cs_tsAborting: Comment := 'выполнение прерывается';
 end;
end;

function TddProcessTask.HasFilesToTransfer: Boolean;
begin
 Result := False;
end;

function TddProcessTask.TransferFiles(
  const aService: IcsFileTransferServices): Boolean;
begin
 Result := False;
end;

function TddProcessTask.ExpandTransferFileName(
  const aFileName: String; out theBasePath, theFileName: String): Boolean;
begin
 Result := False;
end;

procedure TddProcessTask.SaveTaskToPipe(aPipe: TCsDataPipe);
var
  l_Stream: Tl3MemoryStream;
begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  SaveTo(l_Stream, True);
  l_Stream.Seek(0, 0);
  aPipe.WriteStream(l_Stream);
 finally
  l3Free(l_Stream);
 end;
end;

function TddProcessTask.IsHiddenFromUser: Boolean;
begin
 Result := False;
end;

function TddProcessTask.IsUnimportant(aNow: TDateTime = 0; MaxDayAge: Integer = 2): Boolean;
begin
 if aNow = 0 then
  aNow := Now;
 Result := (Status in [cs_tsDone]) and (IsHiddenFromUser or ((aNow - Self.Date) >= MaxDayAge));
end;

end.
