{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcdsClient;

interface
{$I dc.inc}

Uses Windows, SysUtils, dcRPC, dcDScript, dcDSLib;

Procedure AddDelphiProject(Project:TDSProject);
Procedure CloseProject(Project:TDSProject);
Procedure ConnectDebuggerToProject(Project:TDSProject);
Procedure RemoveDelphiProject(Project:TDSProject);
Procedure ProjectOnBreakPoint(Project:TDSProject;UnitHandle:Integer;ALine:Integer);
Procedure ProjectOnClose(Project:TDSProject);
Procedure ProjectOnException(Project:TDSProject;AException:Exception;AUnitHandle,ALine:Integer);

Function Connect:Boolean;
Procedure Disconnect;

implementation
Uses Classes, sdMain;

Const
  SErrDebuggerClosed='Connection with debugger is lost';
  
Type
  TProjectListItem=Record
    Project:TDSProject;
    ConnectHandle:Integer;
  End;

  PProjectListItem=^TProjectListItem;

Var
  ConnectHandles:TRecordList;
  CriticalSection:TRTLCriticalSection;

{$IFDEF DEBUG_}
Function InDebugMode:Boolean;
Begin
  Result:=False;
End;
{$ENDIF}

Procedure LockClientProjectList;
Begin
  EnterCriticalSection(CriticalSection);
End;

Procedure UnLockClientProjectList;
Begin
  LeaveCriticalSection(CriticalSection);
End;

Procedure AddToProjectList(Project:TDSProject;ConnectHandle:Integer);
Var
  Item:PProjectListItem;
Begin
  LockClientProjectList;
  Try
    If ConnectHandles=Nil Then
      ConnectHandles:=TRecordList.Create(SizeOf(TProjectListItem));
    Item:=ConnectHandles.GetAddPlace;
    Item.Project:=Project;
    Item.ConnectHandle:=ConnectHandle;
  Finally
    UnLockClientProjectList;
  End;
End;

Function FindConnectHandleByProject(Project:TDSProject):Integer;
Var
  I:Integer;
  Item:PProjectListItem;
Begin
  LockClientProjectList;
    Try
    If ConnectHandles<>Nil Then
      For I:=0 To ConnectHandles.Count-1 Do
      Begin
        Item:=ConnectHandles[I];
        If Item.Project=Project Then
        Begin
          Result:=Item.ConnectHandle;
          Exit;
        End;
      End;
    Result:=-1;
  Finally
    UnLockClientProjectList;
  End;
End;

Function FindIndexByProject(Project:TDSProject):Integer;
Var
  I:Integer;
  Item:PProjectListItem;
Begin
  LockClientProjectList;
  Try
    If ConnectHandles<>Nil Then
      For I:=0 To ConnectHandles.Count-1 Do
      Begin
        Item:=ConnectHandles[I];
        If Item.Project=Project Then
        Begin
          Result:=I;
          Exit;
        End;
      End;
    Result:=-1;
  Finally
   UnLockClientProjectList;
  End;  
End;

Procedure RemoveFromProjectList(Project:TDSProject);
Var
  Index:Integer;
Begin
  LockClientProjectList;
  Try
    Index:=FindIndexByProject(Project);
    If Index>=0 Then
    Begin
      ConnectHandles.Delete(Index);
      If ConnectHandles.Count=0 Then
      Begin
        ConnectHandles.Free;
        ConnectHandles:=Nil;
      End;
    End;
  Finally
    UnLockClientProjectList;
  End
End;

Procedure ConnectionLost(Project:TDSProject);
Begin
  RemoveFromProjectList(Project);
  Error(SErrDebuggerClosed);
End;

Type
  TClientThread=Class(TClientStub)
  Private
    FProject:TDSProject;
    Procedure AddProject(Project:TDSProject);
    Procedure CodePrologEx(IsLock:Boolean;Project:TDSProject;Command:TDebuggerCommand);
    Procedure CodePrologCommon(IsLock:Boolean;Command:TDebuggerCommand);
    Procedure DoDebuggerClose;
    Procedure ProcessAddBreakPoint;
    Procedure ProcessCauseBreak;
    Procedure ProcessConnect;
    Procedure ProcessDisconnect;
    Procedure ProcessEvaluate;
    Procedure ProcessGetApplicationHandle;
    Procedure ProcessGetApplicationName;
    Procedure ProcessGetName;
    Procedure ProcessGetStackFrames;
    Procedure ProcessGetUnitName;
    Procedure ProcessGetUnits;
    Procedure ProcessGetUnitText;
    Procedure ProcessGetVarList;
    Procedure ProcessOnDebuggerClose;
    Procedure ProcessRemoveBreakPoint;
    Procedure ProcessResumeFromBreakPoint;
    Procedure ProcessRunToLine;
    Procedure ProcessSetBPData;
    Procedure ProcProlog(Project:TDSProject;Command:TDebuggerCommand);
    Procedure RemoveProject(Project:TDSProject);
    Procedure ProjectConnectDebuggerToProject(Project:TDSProject);
    Procedure ProjectOnBreakPoint(Project:TDSProject;UnitHandle:Integer;ALine:Integer);
    Procedure ProjectOnClose(Project:TDSProject);
    Procedure ProjectOnExeption(Project:TDSProject;AException:Exception;AUnitHandle:Integer;ALine:Integer);
  Protected
    Procedure DoCall;override;
    Procedure Execute;override;
    Procedure InitEvents;override;
    Procedure InitIPC;override;
  Public
    Constructor Create(Suspend:Boolean);
    Destructor Destroy;override;

  End;

Constructor TClientThread.Create(Suspend:Boolean);
Begin
  Inherited;
End;

Destructor TClientThread.Destroy;
Begin
  Inherited;
End;

Procedure TClientThread.AddProject(Project:TDSProject);
Var
  ConnectHandle:Integer;
Begin
  Try
    Try
      CodePrologCommon(True,dcAddProject);
      IPCClient.WriteStr(ClientCallEvent.Name);
      IPCClient.WriteStr(ClientRetEvent.Name);
      IPCClient.WriteInt(Integer(Project));
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      UnLockRet;
      Raise;
    End;
    WaitReturn;
    Try
      IPCClient.BeginRead;
      ConnectHandle:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;
    AddToProjectList(Project,ConnectHandle);
  Except
    ConnectionLost(Project);
  End;
End;

Procedure TClientThread.CodePrologEx(IsLock:Boolean;Project:TDSProject;Command:TDebuggerCommand);
Var
  ConnectHandle:Integer;
Begin
  CodePrologCommon(IsLock,Command);
  ConnectHandle:=FindConnectHandleByProject(Project);
  IPCClient.WriteInt(ConnectHandle);
End;

Procedure TClientThread.CodePrologCommon(IsLock:Boolean;Command:TDebuggerCommand);
Begin
  With IPCClient Do
  Begin
    If IsLock Then
      LockRet;
    IPCClient.BeginWrite;
    CallType:=ctCall;
    IPCClient.Write(Command,SizeOf(Command));
  End;
End;

Procedure TClientThread.DoCall;
Const
  Commands:Array[TClientCommand] Of Pointer=(
   @TClientThread.ProcessAddBreakPoint,       @TClientThread.ProcessCauseBreak,
   @TClientThread.ProcessConnect,             @TClientThread.ProcessDisconnect,
   @TClientThread.ProcessEvaluate,            @TClientThread.ProcessGetApplicationHandle,
   @TClientThread.ProcessGetApplicationName,  @TClientThread.ProcessGetName,
   @TClientThread.ProcessGetStackFrames,      @TClientThread.ProcessGetUnitName,
   @TClientThread.ProcessGetUnits,            @TClientThread.ProcessGetUnitText,
   @TClientThread.ProcessGetVarList,
   @TClientThread.ProcessOnDebuggerClose,     @TClientThread.ProcessRemoveBreakPoint,
   @TClientThread.ProcessResumeFromBreakPoint,@TClientThread.ProcessRunToLine,
   @TClientThread.ProcessSetBPData);
Type
  TObjectProc=Procedure(Self:Pointer);
Var
  Command:TClientCommand;
Begin
  Try
    IPCClient.BeginRead;
    IPCClient.Read(Command,SizeOf(Command));
    Try
      TObjectProc(Commands[Command])(Self);
    Except
      IPCClient.EndRead;
      Raise;
    End;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: DoCall Exceptiom');
    {$ENDIF}
  End;
End;

Procedure TClientThread.DoDebuggerClose;
Begin
  FProject.OnDebuggerClose;
End;

Procedure TClientThread.Execute;
Begin
  FreeOnTerminate:=True;
  Inherited;
End;

Procedure TClientThread.InitEvents;
Begin
  ClientCallEvent:=GenerateEvent(IPCClient.Mutex);
  ClientRetEvent:=GenerateEvent(IPCClient.Mutex);
  ServerCallEvent:=TEvent.Create(GlobalCallEventName,False);
  ServerRetEvent:=TEvent.Create(GlobalRetEventName,False);
End;

Procedure TClientThread.InitIPC;
Begin
  IPCClient.DataInEvent:=TEvent.Create(ClientDataInEventName,False);
  IPCClient.DataOutEvent:=TEvent.Create(ClientDataOutEventName,False);
  IPCClient.Mutex:=TMutex.Create(GlobalDataMutexName);
  IPCClient.SharedMem:=TSharedMem.Create(GlobalFileMappingName,SharedBufferSize);
End;

Procedure TClientThread.ProcessAddBreakPoint;
Var
  Project:TDSProject;
  AUnitHandle:Integer;
  ALine:Integer;
  AEnabled:Boolean;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
      AUnitHandle:=IPCClient.ReadInt;
      ALine:=IPCClient.ReadInt;
      AEnabled:=IPCClient.ReadBool;
    Finally
      IPCClient.EndRead;
    End;
    Try
      CallType:=ctRet;
      IPCClient.BeginWrite;
      Try
        Project.LockBreakPoints;
        IPCClient.WriteInt(Project.AddBreakPoint(AUnitHandle,ALine,AEnabled));
      Finally
        Project.UnLockBreakPoints;
      End;
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      Raise;
    End;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessAddBreakPoint Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessCauseBreak;
Var
  Project:TDSProject;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
    Finally
      IPCClient.EndRead;
    End;  
    Project.CauseBreak;
    Return;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessCauseBreak Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessConnect;
Var
  ProjectHandle:Integer;
Begin
  Try
    Try
      ProjectHandle:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;  
    TDSProject(ProjectHandle).ConnectDebugger;
    Return;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessConnect Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessDisconnect;
Var
  ProjectHandle:Integer;
Begin
  Try
    Try
      ProjectHandle:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;  
    TDSProject(ProjectHandle).DisconnectDebugger;
    Return;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessDisconnect Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessEvaluate;
Var
  Project:TDSProject;
  UnitHandle:Integer;
  Expr:String;
  Result:String;
  IsError:Boolean;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
      UnitHandle:=IPCClient.ReadInt;
      Expr:=IPCClient.ReadStr;
    Finally
      IPCClient.EndRead;
    End;  
    Project.Evaluate(UnitHandle,Expr,Result,IsError);
    CallType:=ctRet;
    IPCClient.BeginWrite;
    Try
      IPCClient.WriteStr(Result);
      IPCClient.WriteBool(IsError);
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      Raise;
    End;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessEvaludate Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessGetApplicationHandle;
Begin
  Try
    IPCClient.EndRead;
    CallType:=ctRet;
    IPCClient.BeginWrite;
    Try
      IPCClient.WriteInt(GetCurrentProcessID);
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      Raise;
    End;  
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessGetApplicationHandle Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessGetApplicationName;
Var
  ProjectHandle:Integer;
Begin
  Try
    Try
      ProjectHandle:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;  
    CallType:=ctRet;
    IPCClient.BeginWrite;
    Try
      IPCClient.WriteStr(TDSProject(ProjectHandle).GetApplicationName);
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      Raise;
    End;  
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessGetApplicationName Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessGetName;
Var
  ProjectHandle:Integer;
Begin
  Try
    Try
      ProjectHandle:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;  
    CallType:=ctRet;
    IPCClient.BeginWrite;
    Try
      IPCClient.WriteStr(TDSProject(ProjectHandle).GetName);
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      Raise;
    End;  
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessGetName Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessGetStackFrames;
Var
  Project:TDSProject;
  UnitHandle:Integer;
  Line:Integer;
  Str:String;
  I:Integer;
  StackFrameCount:Integer;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
    Finally
      IPCClient.EndRead;
    End;  
    CallType:=ctRet;
    IPCClient.BeginWrite;
    Try
      StackFrameCount:=Project.GetStackFrameCount;
      IPCClient.WriteInt(StackFrameCount);
      For I:=0 To StackFrameCount-1 Do
      Begin
        Project.GetStackFrame(I,UnitHandle,Line,Str);
        IPCClient.WriteInt(UnitHandle);
        IPCClient.WriteInt(Line);
        IPCClient.WriteStr(Str);
      End;
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      Raise;
    End;  
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessGetStackFrames Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessGetUnitName;
Var
  Project:TDSProject;
  UnitHandle:Integer;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
      UnitHandle:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;  
    CallType:=ctRet;
    IPCClient.BeginWrite;
    Try
      IPCClient.WriteStr(Project.GetUnitName(UnitHandle));
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      Raise;
    End;  
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessGetUnitName Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessGetUnits;
Var
  Project:TDSProject;
  I:Integer;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
    Finally
      IPCClient.EndRead;
    End;  
    CallType:=ctRet;
    IPCClient.BeginWrite;
    Try
      With Project Do
      Begin
        LockUnits;
        Try
          IPCClient.WriteInt(UnitCount);
          For I:=0 To UnitCount-1 Do
            IPCClient.WriteInt(Units[I]);
        Finally
          UnLockUnits;
        End;
      End;
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      Raise;
    End;  
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessGetUnits Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessGetUnitText;
Var
  Project:TDSProject;
  UnitHandle:Integer;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
      UnitHandle:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;
    CallType:=ctRet;
    IPCClient.BeginWrite;
    Try
      IPCClient.WriteStr(Project.GetUnitText(UnitHandle));
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      Raise;
    End;  
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessGetUnitText Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessGetVarList;
Var
  I:Integer;
  Project:TDSProject;
  UnitHandle:Integer;
  Strings:TStringList;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
      UnitHandle:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;
    CallType:=ctRet;
    IPCClient.BeginWrite;
    Try
      Strings:=TStringList.Create;
      Try
        Project.GetVarList(UnitHandle,Strings);
        IPCClient.WriteInt(Strings.Count);
        For I:=0 To Strings.Count-1 Do
          IPCClient.WriteStr(Strings[I]);
      IPCClient.EndWrite;
      Finally
        Strings.Free;
      End;
    Except
      IPCClient.UnLock;
      Raise;
    End;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessGetVarList Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessOnDebuggerClose;
Begin
  Try
    Try
      FProject:=TDSProject(IPCClient.ReadInt);
      InSynchronize:=True;
      Try
        Synchronize(DoDebuggerClose);
      Finally
        InSynchronize:=False;
      End;
    Finally
      IPCClient.EndRead;
    End;  
    Return;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessOnDebuggerClose Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessRemoveBreakPoint;
Var
  Project:TDSProject;
  ABreakPoint:Integer;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
      ABreakPoint:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;  
    Project.LockBreakPoints;
    Try
      Project.RemoveBreakPoint(ABreakPoint);
    Finally
      Project.UnLockBreakPoints;
    End;
    Return;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessRemoveBreakPoint Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessResumeFromBreakPoint;
Var
  ProjectHandle:Integer;
  ResumeType:TBreakResumeType;
Begin
  Try
    Try
      ProjectHandle:=IPCClient.ReadInt;
      IPCClient.Read(ResumeType,SizeOf(ResumeType));
    Finally
      IPCClient.EndRead;
    End;  
    Return;
    TDSProject(ProjectHandle).ResumeFromBreakPoint(ResumeType);
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessResumeFromBreakPoint Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessRunToLine;
Var
  Project:TDSProject;
  UnitHandle:Integer;
  ALine:Integer;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
      UnitHandle:=IPCClient.ReadInt;
      ALine:=IPCClient.ReadInt;
    Finally
      IPCClient.EndRead;
    End;  
    Return;
    Project.RunToLine(UnitHandle,ALine);
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessRunToLine Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcessSetBPData;
Var
  Project:TDSProject;
  BreakPoint:TCustomBreakPoint;
  BreakPointParts:TBreakPointParts;
  I:TBreakPointPart;
Begin
  Try
    Try
      Project:=TDSProject(IPCClient.ReadInt);
      Project.LockBreakPoints;
      Try
        BreakPoint:=TCustomBreakPoint(IPCClient.ReadInt);
        BreakPointParts:=TBreakPointParts(Byte(IPCClient.ReadInt));
        For I:=Low(TBreakPointPart) To High(TBreakPointPart) Do
        Begin
          If I In BreakPointParts Then
          Case I Of
            bpUnit:BreakPoint.UnitHandle:=IPCClient.ReadInt;
            bpLine:BreakPoint.Line:=IPCClient.ReadInt;
            bpEnabled:BreakPoint.Enabled:=IPCClient.ReadBool;
            bpCondition:BreakPoint.Condition:=IPCClient.ReadStr;
            bpPassCount:BreakPoint.PassCount:=IPCClient.ReadInt;
          End;
        End;
      Finally
        Project.UnLockBreakPoints;
      End;
    Finally
      IPCClient.EndRead;
    End;  
    Return;
  Except
    {$IFDEF DEBUG_}
    If InDebugMode Then
      OutTraceString('Client: ProcessSetBPData Exception');
    {$ENDIF}
  End;
End;

Procedure TClientThread.ProcProlog(Project:TDSProject;Command:TDebuggerCommand);
Begin
  CodePrologEx(True,Project,Command);
End;

Procedure TClientThread.ProjectConnectDebuggerToProject(Project:TDSProject);
Begin
  Try
    Try
      ProcProlog(Project,dcConnectDebuggerToProject);
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      UnLockRet;
      Raise;
    End;
    WaitReturn;
  Except
    ConnectionLost(Project);
  End;
End;

Procedure TClientThread.ProjectOnBreakPoint(Project:TDSProject;UnitHandle:Integer;ALine:Integer);
Begin
  Try
    Try
      ProcProlog(Project,dcOnBreakPoint);
      IPCClient.WriteInt(UnitHandle);
      IPCClient.WriteInt(ALine);
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      UnLockRet;
      Raise;
    End;
    WaitReturn;
  Except
    ConnectionLost(Project);
  End;  
End;

Procedure TClientThread.ProjectOnClose(Project:TDSProject);
Begin
  Try
    Try
      ProcProlog(Project,dcOnClose);
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      UnLockRet;
      Raise;
    End;
    WaitReturn;
  Except
    ConnectionLost(Project);
  End;  
End;

Procedure TClientThread.ProjectOnExeption(Project:TDSProject;AException:Exception;AUnitHandle:Integer;ALine:Integer);
Begin
  Try
    Try
      ProcProlog(Project,dcOnException);
      IPCClient.WriteStr(AException.Message);
      IPCClient.WriteInt(AUnitHandle);
      IPCClient.WriteInt(ALine);
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      UnLockRet;
      Raise;
    End;
    WaitReturn;
  Except
    ConnectionLost(Project);
  End;  
End;

Procedure TClientThread.RemoveProject(Project:TDSProject);
Begin
  Try
    Try
      ProcProlog(Project,dcRemoveProject);
      IPCClient.EndWrite;
    Except
      IPCClient.UnLock;
      UnLockRet;
      Raise;
    End;
    WaitReturn;
    RemoveFromProjectList(Project);
  Except
    ConnectionLost(Project);
  End;
End;

Const
  SErrNotConnected='Not connected';

Var
  ClientThread:TClientThread;
  UseCount:Integer;

//Global functions

Procedure CheckConnected;
Begin
  If ClientThread=Nil Then
    Error(SErrNotConnected);
End;

Procedure AddDelphiProject(Project:TDSProject);
Begin
  CheckConnected;
  ClientThread.AddProject(Project);
End;

Procedure CloseProject(Project:TDSproject);
Begin
  RemoveFromProjectList(Project);
  Disconnect;
End;

Function Connect:Boolean;
Var
  AHandle:THandle;
Begin
  AHandle:=OpenFileMapping(FILE_MAP_ALL_ACCESS,False,GlobalFileMappingName);
  Result:=AHandle<>0;
  If Result Then
  Begin
    CloseHandle(AHandle);
    InitializeCriticalSection(CriticalSection);
    If ClientThread=Nil Then
    Begin
      ClientThread:=TClientThread.Create(False);
      UseCount:=0;
    End;
    Inc(UseCount);
  End;
End;

Procedure Disconnect;
Begin
  If ClientThread=Nil Then
    Exit;
  Dec(UseCount);
  If UseCount=0 Then
  Begin
    ClientThread.Terminate;
    ClientThread:=Nil;
    DeleteCriticalSection(CriticalSection);
  End;
End;

Procedure ConnectDebuggerToProject(Project:TDSProject);
Begin
  ClientThread.ProjectConnectDebuggerToProject(Project);
End;

Procedure ProjectOnBreakPoint(Project:TDSProject;UnitHandle:Integer;ALine:Integer);
Begin
  CheckConnected;
  ClientThread.ProjectOnBreakPoint(Project,UnitHandle,ALine);
End;

Procedure ProjectOnClose(Project:TDSProject);
Begin
  CheckConnected;
  ClientThread.ProjectOnClose(Project);
End;

Procedure RemoveDelphiProject(Project:TDSProject);
Begin
  CheckConnected;
  ClientThread.RemoveProject(Project);
End;

Procedure ProjectOnException(Project:TDSProject;AException:Exception;AUnitHandle,ALine:Integer);
Begin
  CheckConnected;
  ClientThread.ProjectOnExeption(Project,AException,AUnitHandle,ALine);
End;

end.
