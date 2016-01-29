{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit sdMain;

interface
{$I dc.inc}
Uses
  {$IFDEF D6}
  RTLConsts,
  {$ENDIF}
  Windows, Classes, dcDSLib, dcConsts, dcsystem;

Const
  DreamDebuggerKey=SDreamRegKey+'DreamScriptDebugger';
  DreamDebuggerPath='Path';

Const
  SharedBufferSize=64*1024;

  InitializtionMutex='ScriptDebuggerInitMutex';
  GlobalMutexName='ScriptDebuggerMutex';

  GlobalFileMappingName='ScriptDebuggerData';

  GlobalCallEventName='ScriptDebuggerCallEvent';
  GlobalRetEventName='ScriptDebuggerRetEvent';

  ServerDataInEventName='ScriptDebuggerDataInEvent';
  ServerDataOutEventName='ScriptDebuggerDataOutEvent';

  ClientDataInEventName=ServerDataOutEventName;
  ClientDataOutEventName=ServerDataInEventName;

  GlobalDataMutexName='ScriptDebuggerMutex';
  EventPrefix='ScriptDebuggerEvent_';

  //String constants
  SEmptyProjectName='Unnamed project block';
  SEmptyUnitName='Unnamed unit block';

  //Error messages
  SErrInvalidCommand='Invalid command';
  SErrInvalidClientMode='Invalid client mode';

Type
  TDebuggerCommand=
  (
   dcAddProject,        //Data in: CallEventName,RetEventName:String,hanlde of project:Integer DataOut:Connect Haandle
   dcConnectDebuggerToProject,
                        //Data in: Connect Handle
   dcRemoveProject,     //Data in: Connect Handle
   dcOnClose,           //Data in: Connect Handle
   dcOnBreakPoint,      //Data in: Connect Handle,AUnitHandle:Integer;ALine:Integer,BreakType:TBreakType
   dcOnException        //Data in: Connect Handle,ExceptStr:String;AUntiHandle:Integer;ALine:Integer
  );

  TClientCommand=
  (
    ccAddBreakPoint,       //Data in: handle of Project:Integer,AUnitHAndle:Integer;ALine:Integer;Data out:BreakPointHandle:Integer
    ccCauseBreak,          //Data in: handle of project:Integer
    ccConnect,             //Data in: handle of project:Integer
    ccDisconnect,          //Data in: handle of project:Integer
    ccEvaluate,            //Data in: handle of project:Integer;Expr:String;Data out:Result:String;Error:Boolean
    ccGetApplicationHandle,//Data in: handle of project:Integer,Dataout handle of application:String;
    ccGetApplicationName,  //Data in: handle of project:Integer,Data out: name of script:String
    ccGetName,             //Data in: handle of project:Integer,Data out: name of script:String
    ccGetStackFrames,      //Data in: handle of project:Integer,Data out: StackCount:Integer{,UnitHandle:Integer,Line:Integer,Str:String}
    ccGetUnitName,         //Data in: handle of project:Integer,handle of units:Integer,Data out: name of script:String
    ccGetUnits,            //Data in: handle of project:Integer,Data out: unit count:Integer{,unit handle:Integer}
    ccGetUnitText,         //Data in: handle of project:Integer,handle of unit:Integer,Data out: text:String
    ccGetVarList,          //Data in: handle of project:Integer,handle of unit:Integer,Data out: VarCount:Integer{,VarData:String}
    ccOnDebuggerClose,
    ccRemoveBreakPoint,    //Data in: handle of project:Integer,handle of breakpoint:Integer;
    ccResumeFromBreakPoint,//Data in: handle of project:Integer,ALine:Integer;BreakResumeType:TBreakResumeType
    ccRunToLine,           //Data in: handle of project,ALine:Integer
    ccSetBPData            //Data in: handle of breakpoint,BreakPointParts:TBreakPointsParts,{UnitHandle:Integer,}{Line:Integer,}{Enabled:Boolean,}{Condition,}{PassCount:Integer}
  );

  TBreakPointPart=(bpUnit,bpLine,bpEnabled,bpCondition,bpPassCount);
  TBreakPointParts=Set Of TBreakPointPart;
  TNotifyAction=(naAdd,naChange,naRemove,naStateChanged,naSubItemAdd,naSubItemChanged,naSubItemRemove,naUserAction);
  TProjectAction=(paConnectDebuggerToProject);

  //If AUnitHandle=0 then ALine=count of stack frames
  TGetStackFramesProc=Procedure(AUnitHandle:Integer;ALine:Integer;Const Str:String) Of Object;

  TDelphiDebugger=Class;

  TScriptProject=Class
    Procedure AddBreakPoint(BreakPoint:TCustomBreakPoint);virtual;abstract;
    Procedure CauseBreak;virtual;abstract;
    Procedure ConnectDebugger(DelphiDebugger:TDelphiDebugger);virtual;abstract;
    Procedure DisconnectDebugger;virtual;abstract;
    Function  Evaluate(Const Expression:String;TimeOut:Integer;AllowSideEffects:Boolean;Var StrResult:String):Boolean;virtual;abstract;
    Function  GetApplicationHandle:Integer;virtual;abstract;
    Function  GetApplicationName:String;virtual;abstract;
    Function  GetName:String;virtual;abstract;
    Procedure GetStackFrames(GetStackFrames:TGetStackFramesProc);virtual;abstract;
    Function  GetUnitName(UnitHandle:Integer):String;virtual;abstract;
    Procedure GetUnits(UnitList:TList);virtual;abstract;
    Function  GetUnitText(UnitHandle:Integer):String;virtual;abstract;
    Function  GetUnitParser(UnitHandle:Integer):TSimpleParser;virtual;abstract;
    Procedure OnDebuggerClose;virtual;abstract;
    Procedure RemoveBreakPoint(BreakPoint:TCustomBreakPoint);virtual;abstract;
    Procedure ResumeFromBreakPoint(bra:TBreakResumeType);virtual;abstract;
    function  CheckBreakPoint(UnitHandle:Integer;ALine:Integer): boolean;virtual;abstract;
    Procedure RunToLine(UnitHandle:Integer;ALine:Integer);virtual;abstract;
    Procedure SetBPData(BreakPoint:TCustomBreakPoint;BreakPointParts:TBreakPointParts);virtual;abstract;
    Procedure GetVarList(AList: TStrings);virtual;abstract;
  End;

  TBreakEvent=Procedure(Project:TScriptProject;AUnitHandle:Integer;ALine:Integer) Of Object;
  TExceptionEvent=Procedure(Project:TScriptProject;Const ExceptStr:String;AUnitHandle:Integer;ALine:Integer) Of Object;

  TSimpleEvent=Procedure Of Object;

  TDelphiDebugger=Class
  Private
    FOnBreakPoint:TBreakEvent;
    FOnClose:TSimpleEvent;
    FOnException:TExceptionEvent;
    FProject:TScriptProject;
    Procedure SetProject(Value:TScriptProject);
  Public
    Destructor Destroy;override;

    Procedure DoBreakPoint(Project:TScriptProject;AUnitHandle:Integer;ALine:Integer);
    Procedure DoClose;
    Procedure DoException(Project:TScriptProject;Const ExceptStr:String;AUnitHandle:Integer;ALine:Integer);
    Procedure DoProjectClosed(Project:TScriptProject);

    Property OnBreakPoint:TBreakEvent read FOnBreakPoint write FOnBreakPoint;
    Property OnClose:TSimpleEvent read FOnClose write FOnClose;
    Property OnException:TExceptionEvent read FOnException write FOnException;
    Property Project:TScriptProject read FProject write SetProject;
  End;

  TRecordList=Class(TObject)
  Private
    FCapacity:Integer;
    FCount:Integer;
    FItemSize:Integer;
    FList:Pointer;
    Procedure CheckIndex(Index:Integer);
  Protected
    Function Compare(Item1,Item2:Pointer):Integer;virtual;
    Function GetItem(Index:Integer):Pointer;virtual;
    Procedure InternalDelete(Index:Integer);virtual;
    Procedure SetItem(Index:Integer;Item:Pointer);virtual;
    Procedure SetCapacity(NewCapacity:Integer);virtual;
    Procedure SetCount(NewCount: Integer);virtual;
  Public
    Constructor Create(AItemSize:Integer);
    Destructor Destroy;override;

    Function Add(Item:Pointer):Integer;virtual;
    Procedure Clear;virtual;
    Procedure Delete(Index:Integer);virtual;
    Class Procedure Error(Const Msg:String;Data:Integer);virtual;
    Function First:Pointer;
    Function GetAddPlace:Pointer;
    Function GetInsertPlace(Index:Integer):Pointer;
    Procedure Grow;virtual;
    Function IndexOf(Item:Pointer):Integer;virtual;
    Procedure Insert(Index:Integer;Item:Pointer);virtual;
    Function Last:Pointer;
    Function Remove(Item:Pointer):Integer;

    Property Capacity:Integer read FCapacity write SetCapacity;
    Property Count:Integer read FCount write SetCount;
    Property Items[Index:Integer]:Pointer read GetItem write SetItem; default;
    Property ItemSize:Integer read FItemSize;
    Property List:Pointer read FList;
  End;

  TDebuggerEvent=Procedure(Project:TScriptProject;Action:TNotifyAction;SubItem:Pointer) Of Object;

Function AddProject(Project:TScriptProject):Integer;
Procedure AddProjectUnit(Project:TScriptProject;UnitHandle:Integer);
Procedure CloseDebugger;
Procedure Error(const Message:String);
Procedure ErrorFmt(Const Message:String;Const Data:Array Of Const);
Function GetProjectCount:Integer;
Function GetProject(Index:Integer):TScriptProject;
Procedure LockProjectList;
Procedure OnConnectDebuggerToProject(Project:TScriptProject);
Procedure ProjectStateChanged(Project:TScriptProject);
Procedure RegisterProjectHandler(DebuggerEvents:TDebuggerEvent);
Procedure RemoveProject(Project:TScriptProject);
Procedure RemoveProjectUnit(Project:TScriptProject;UnitHandle:Integer);
Procedure UnLockProjectList;
Procedure UnRegisterProjectHandler(DebuggerEvent:TDebuggerEvent);
Procedure UpdateProject(Project:TScriptProject);
Procedure UpdateUnitText(Project:TScriptProject;UnitHandle:Integer);

{$IFDEF DEBUG_}
Procedure OutTraceString(Const Str:String);
{$ENDIF}

implementation
Uses SysUtils, Consts;

Const
  SErrInvalidItemSize='Invalid item size (%d)';

{ TDelphiDebugger }

Destructor TDelphiDebugger.Destroy;
Begin
  Inherited;
End;

Procedure TDelphiDebugger.DoBreakPoint( Project:TScriptProject;AUnitHandle:Integer;ALine:Integer);
Begin
  If Assigned(FOnBreakPoint) Then
    FOnBreakPoint(Project,AUnitHandle,ALine);
End;

Procedure TDelphiDebugger.DoClose;
Begin
  If Assigned(FOnClose) Then
    FOnClose;
End;

Procedure TDelphiDebugger.DoException(Project:TScriptProject;Const ExceptStr:String;AUnitHandle:Integer;ALine:Integer);
Begin
 If Assigned(FOnException) Then
   FOnException(Project,ExceptStr,AUnitHandle,ALine);
End;

Procedure TDelphiDebugger.DoProjectClosed(Project:TScriptProject);
Begin
  If FProject=Project Then
    FProject:=Nil;
End;

Procedure TDelphiDebugger.SetProject(Value:TScriptProject);
Begin
  If FProject=Value Then
    Exit;
  If FProject<>Nil Then
    FProject.DisconnectDebugger;
  FProject:=Value;
  If FProject<>Nil Then
    FProject.ConnectDebugger(Self);
End;

{ TRecordList }

Type
  ERecordListError=Class(Exception);

Constructor TRecordList.Create(AItemSize:Integer);
Begin
  Inherited Create;
  If AItemSize<=0 Then
    Error(SErrInvalidItemSize,AItemSize);
  FItemSize:=AItemSize;  
End;

Destructor TRecordList.Destroy;
Begin
  Clear;
End;

Function TRecordList.Add(Item:Pointer):Integer;
Begin
  Result:=FCount;
  Move(Item^,GetAddPlace^,FItemSize);
End;

Procedure TRecordList.CheckIndex(Index:Integer);
Begin
  If (Index<0) Or (Index>=FCount) then
    Error(SListIndexError,Index);
End;

Procedure TRecordList.Clear;
Begin
  SetCount(0);
  SetCapacity(0);
End;

Function TRecordList.Compare(Item1,Item2:Pointer):Integer;
Begin
  If CompareMem(Item1,Item2,FItemSize) Then
    Result:=0
  Else
    Result:=2;  
End;

Procedure TRecordList.Delete(Index:Integer);
Begin
  CheckIndex(Index);
  InternalDelete(Index);
End;

Class Procedure TRecordList.Error(Const Msg:String;Data:Integer);

  Function ReturnAddr:Pointer;
  Asm
     MOV     EAX,[EBP+4]
  End;

Begin
  Raise ERecordListError.CreateFmt(Msg,[Data]) At ReturnAddr;
End;

Function TRecordList.First:Pointer;
Begin
  Result:=GetItem(0);
End;

Function TRecordList.GetItem(Index:Integer):Pointer;
Begin
  CheckIndex(Index);
  Result:=Pointer(Integer(FList)+Index*FItemSize);
End;

Function TRecordList.GetAddPlace:Pointer;
Begin
  If FCount=FCapacity then
    Grow;
  Result:=FList;
  Inc(Integer(Result),FCount*FItemSize);
  Inc(FCount);  
End;

Function TRecordList.GetInsertPlace(Index:Integer):Pointer;
Begin
  If (Index<0) Or (Index>FCount) then
    Error(SListIndexError,Index);
  If FCount=FCapacity then
    Grow;
  Result:=Pointer(Integer(FList)+Index*FItemSize);
  If Index<FCount then
    System.Move(Result^,PChar(Result)[FItemSize],
      (FCount-Index)*FItemSize);
  Inc(FCount);
End;


Procedure TRecordList.Grow;
Var
  Delta:Integer;
Begin
  If FCapacity>64 Then
    Delta:=FCapacity Div 4
  Else
    If FCapacity > 8 Then
      Delta:=16
    Else
      Delta:=4;
  SetCapacity(FCapacity+Delta);
End;

Function TRecordList.IndexOf(Item:Pointer):Integer;
Var
  ItemPos:Pointer;
Begin
  Result:=0;
  ItemPos:=FList;
  While (Result<FCount) And (Compare(ItemPos,Item)<>0) Do
  Begin
    Inc(Result);
    Inc(Integer(ItemPos),FItemSize);
  End;
  If Result=FCount then
    Result:=-1;
End;

Procedure TRecordList.Insert(Index:Integer;Item:Pointer);
Begin
  Move(Item^,GetInsertPlace(Index)^,FItemSize);
End;

Procedure TRecordList.InternalDelete(Index:Integer);
Var
  ItemPos:Integer;
Begin
  Dec(FCount);
  If Index < FCount then
  Begin
    ItemPos:=Index*ItemSize;
    System.Move(PChar(FList)[ItemPos+FItemSize],PChar(FList)[ItemPos],
      (FCount-Index)*FItemSize);
  End;
End;

Function TRecordList.Last:Pointer;
Begin
  Result:=GetItem(FCount-1);
End;

Procedure TRecordList.SetItem(Index: Integer; Item: Pointer);
Begin
  CheckIndex(Index);
  Move(Item^,PChar(FList)[Index*FItemSize],FItemSize);
End;

Function TRecordList.Remove(Item:Pointer):Integer;
Begin
  Result:=IndexOf(Item);
  If Result>=0 then
    Delete(Result);
End;

Procedure TRecordList.SetCapacity(NewCapacity: Integer);
Begin
  If NewCapacity<FCount Then
    Error(SListCapacityError, NewCapacity);
  If NewCapacity<>FCapacity then
  Begin
    ReallocMem(FList,NewCapacity*FItemSize);
    FCapacity:=NewCapacity;
  End;
End;

Procedure TRecordList.SetCount(NewCount: Integer);
Var
  I:Integer;
Begin
  If NewCount<0 Then
    Error(SListCountError,NewCount);
  If NewCount>FCapacity then
    SetCapacity(NewCount);
  If NewCount>FCount Then
    FillChar(PChar(FList)[FCount*FItemSize],(NewCount-FCount)*FItemSize,0)
  Else
    For I := FCount-1 DownTo NewCount Do
      Delete(I);
  FCount:=NewCount;
End;

Var
  CriticalSection:TRTLCriticalSection;
  ProjectList:TList;
  HandlersList:TRecordList;

Procedure NotifyHandlers(Const Project:TScriptProject;Action:TNotifyAction;SubItem:Pointer);forward;

Function AddProject(Project:TScriptProject):Integer;
Begin
  Result:=ProjectList.IndexOf(Nil);
  If Result<0 Then
    Result:=ProjectList.Add(Project)
  Else
    ProjectList[Result]:=Project;
  NotifyHandlers(Project,naAdd,Nil);
End;

Procedure AddProjectUnit(Project:TScriptProject;UnitHandle:Integer);
Begin
  NotifyHandlers(Project,naSubItemAdd,Pointer(UnitHandle));
End;

Procedure CloseDebugger;
Var
  I:Integer;
  Project:TScriptProject;
Begin
  LockProjectList;
  Try
    For I:=ProjectList.Count-1 DownTo 0 Do
    Begin
      Project:=ProjectList[I];
      If Project<>Nil Then
        Project.OnDebuggerClose;
      End;
  Finally
   UnLockProjectList;
  End;
End;

Procedure Error(Const Message:String);
Begin
   Raise Exception.Create(Message);
End;

Procedure ErrorFmt(Const Message:String;Const Data:Array Of Const);
Begin
  Error(Format(Message,Data));
End;

Procedure NotifyHandlers(Const Project:TScriptProject;Action:TNotifyAction;SubItem:Pointer);
Var
  I:Integer;
Begin
  If HandlersList=Nil Then
    Exit;
  For I:=0 To HandlersList.Count-1 Do
     TDebuggerEvent(HandlersList[I]^)(Project,Action,SubItem)
End;

Function GetProjectCount:Integer;
Begin
  Result:=ProjectList.Count;
End;

Function GetProject(Index:Integer):TScriptProject;
Begin
  Result:=TScriptProject(ProjectList[Index]);
End;

Procedure LockProjectList;
Begin
  EnterCriticalSection(CriticalSection);
End;

Procedure OnConnectDebuggerToProject(Project:TScriptProject);
Begin
  NotifyHandlers(Project,naUserAction,Pointer(paConnectDebuggerToProject));
End;

Procedure ProjectStateChanged(Project:TScriptProject);
Begin
  NotifyHandlers(Project,naStateChanged,Nil);
End;

Procedure RegisterProjectHandler(DebuggerEvents:TDebuggerEvent);
Begin
  If HandlersList=Nil Then
    HandlersList:=TRecordList.Create(SizeOf(TDebuggerEvent));
  HandlersList.Add(@TMethod(DebuggerEvents));
End;

Procedure RemoveProject(Project:TScriptProject);
Var
  Index:Integer;
Begin
  NotifyHandlers(Project,naRemove,Nil);
  Index:=ProjectList.IndexOf(Pointer(Project));

  ProjectList[Index]:=Nil;
  If Index=ProjectList.Count-1 Then
    While (ProjectList.Count>0) And (ProjectList[ProjectList.Count-1]=Nil) Do
      ProjectList.Delete(ProjectList.Count-1)
End;

Procedure RemoveProjectUnit(Project:TScriptProject;UnitHandle:Integer);
Begin
  NotifyHandlers(Project,naSubItemRemove,Pointer(UnitHandle));
End;

Procedure UnLockProjectList;
Begin
  LeaveCriticalSection(CriticalSection);
End;

Procedure UnRegisterProjectHandler(DebuggerEvent:TDebuggerEvent);
Begin
  HandlersList.Remove(@TMethod(DebuggerEvent));
  If HandlersList.Count=0 Then
  Begin
    HandlersList.Free;
    HandlersList:=Nil;
  End;
End;

Procedure UpdateProject(Project:TScriptProject);
Begin
  NotifyHandlers(Project,naChange,Nil);
End;

Procedure UpdateUnitText(Project:TScriptProject;UnitHandle:Integer);
Begin
  NotifyHandlers(Project,naSubItemChanged,Pointer(UnitHandle));
End;

{$IFDEF DEBUG_}
Const
  TraceFileName='C:\trace.txt';
  TraceMutexName='TraceMutexName';

Var
  TraceMutex:THandle;

Procedure OutTraceString(Const Str:String);
Var
  OutFile:Text;
Begin
  WaitForSingleObject(TraceMutex,Infinite);
  Try
    AssignFile(OutFile,TraceFileName);
    If FileExists(TraceFileName) Then
      Append(OutFile)
    Else
      Rewrite(OutFile);
    WriteLn(OutFile,'ProcessID='+IntToHex(GetCurrentProcessID,4)+' ThreadID='+IntToHex(GetCurrentThreadID,4)+' Ticks=',GetTickCount,' ',Str);
    CloseFile(OutFile);
  Finally
    ReleaseMutex(TraceMutex);
  End;
End;
{$ENDIF}

Initialization
  InitializeCriticalSection(CriticalSection);
  ProjectList:=TList.Create;
  {$IFDEF DEBUG_}
  DeleteFile(TraceFileName);
  If TraceMutex=0 Then
    TraceMutex:=CreateMutex(Nil,False,TraceMutexName);
  {$ENDIF}

Finalization
  DeleteCriticalSection(CriticalSection);
  ProjectList.Free;
  {$IFDEF DEBUG_}
  CloseHandle(TraceMutex)
  {$ENDIF}
end.
