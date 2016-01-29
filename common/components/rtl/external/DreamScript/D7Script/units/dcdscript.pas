{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcdscript;

interface
{$I dc.inc}

uses Sysutils, Classes, extctrls, dcscript, dcDSLib
     {$IFDEF D6},Variants{$ENDIF};

type

  PLineDebugInfo = ^TLineDebugInfo;
  TLineDebugInfo = record
    PCurProgItem: Pointer;
    PNextProgItem: Pointer;
  end;

  TChangeLineNotifyEvent = procedure (ADebugInfo: TLineDebugInfo) of object;
  TCallStackNotifyEvent = procedure (const ANewLine, AOldLine: integer; const ACallName: string; cArgs : integer; pArgs : PArgList) of object;
  TExceptionNotifyEvent = procedure (AExeption: Exception; ADebugInfo: TLineDebugInfo) of object;

type
  TSafedList = class
  private
    FList: TList;
    FCrtlSec: TCrtlSection;
    function Get(Index: Integer): Pointer;
    procedure Put(Index: Integer; Item: Pointer);
    function GetCount: integer;
  public
    constructor Create;
    destructor Destroy; override;
    function Add(Item: Pointer): Integer;
    procedure Clear; virtual;
    procedure Delete(Index: Integer);
    procedure Lock;
    procedure UnLock;
    function First: Pointer;
    function IndexOf(Item: Pointer): Integer;
    function Last: Pointer;
    function Remove(Item: Pointer): Integer;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: Pointer read Get write Put; default;
  end;

  TDSUnit = class;

  TDSBreakPoint = class(TCustomBreakPoint)
  private
    function  GetFileName: string;
    function  GetDSUnit: TDSUnit;
  public
    function CheckCondition: boolean; override;
    property Module: TDSUnit read GetDSUnit;
    property FileName: string read GetFileName;
    constructor CreateDS (const ADSUnit: TDSUnit; const ALine: integer);
    destructor Destroy; override;
  end;

  TDSProject = class
  private
    FDebuggerExist: boolean;
    FConnected: boolean;
    FBreakPointList: TSafedList;
    FUnitsList: TSafedList;
    FSuspended: boolean;
    FApplicationName: string;
    FCrtlSec: TCrtlSection;
    FBreakOnException: boolean;
    FTimer: TTimer;

    function  FindBreakPoint(AUnit: TDSUnit; ALine: integer): integer;
    function  GetBreakPoint(Index: Integer): TDSBreakPoint;
    function  GetBreakPointCount: integer;
    function  GetUnits(Index: Integer): integer;
    function  GetUnitCount: integer;
    procedure _OnTimer(Sender: TObject);
    procedure ClearCallStack;
  protected
    FCallStack: TStrings;
    FResumeAction: TBreakResumeType;
    FStopAtNextLine: boolean;
    FRunToLineInfo: TRunToLineInfo;
    function  ResumeThread: boolean; virtual;
    function  SuspendThread(AUnit: TDSUnit; ALine: integer; AIsException: boolean): boolean; virtual;
    function  CheckBreakPoint (AUnit: TDSUnit; ALine: integer): boolean; virtual;
    procedure AddUnit(AUnit: TDSUnit); virtual;
    procedure RemoveUnit(AUnit: TDSUnit); virtual;
    procedure OnException(AException: Exception; AUnit: TDSUnit; ALine: integer); virtual;
    property  Connected: boolean read FConnected;
    property  DebuggerExist: boolean read FDebuggerExist write FDebuggerExist;
  public
    constructor Create;
    destructor Destroy; override;

    Procedure ConnectToDebugger;
    procedure ResumeFromBreakPoint(brt: TBreakResumeType);
    procedure CauseBreak;
    procedure RunToLine(const AUnit, ALine: Integer);

    procedure ConnectDebugger;
    procedure DisconnectDebugger;
    procedure OnDebuggerClose;

    function  GetApplicationName: string;
    function  GetName: string;

    procedure Evaluate (const AUnit: integer; const AExpress: string; var Res: string; var Error: boolean);

    function  GetUnitName(AUnit: integer): string;
    function  GetUnitText(AUnit: integer): string;
    procedure LockUnits;
    procedure UnLockUnits;
    property  Units[Index:Integer]: integer read GetUnits;
    property  UnitCount: integer read GetUnitCount;

    procedure LockBreakPoints;
    procedure UnLockBreakPoints;
    procedure ClearBreakPoints;
    function  AddBreakPoint(const AUnit, ALine: integer; const AEnabled: boolean): integer;
    function  RemoveBreakPoint(ABreakPoint: integer): boolean;
    property  BreakPoint[Index:Integer]: TDSBreakPoint read GetBreakPoint;
    property  BreakPointCount: integer read GetBreakPointCount;

    function  GetStackFrameCount: integer;
    procedure GetStackFrame(Index: integer; var AUnit, ALine: integer; var StackStr: string);

    property  BreakOnException: boolean read FBreakOnException write FBreakOnException;
    procedure GetVarList(const AUnit: integer; AList: TStrings);
  end;

  TDSProjectRun = class(TDSProject)
  private
    FPrevLine: integer;
    FPrevUnit: TDSUnit;
    FCurrentUnit: TDSUnit;
    FCurrentLine: integer;
    FCallStackState: integer;

    FLastUnitFromStack : TDSUnit;
    FLastLineFromStack : integer;

    function  GetUnitIndexFromName(const AName: string): integer;
    function  GetCallsCount: integer;
    function  GetPRunToLineInfo: PRunToLineInfo;
  public
    constructor Create;
    destructor Destroy; override;

    function  ResumeThread: boolean; override;
    function  SuspendThread(AUnit: TDSUnit; ALine: integer; AIsException: boolean): boolean; override;
    function  CheckBreakPoint (AUnit: TDSUnit; ALine: integer): boolean; override;
    procedure AddUnit(AUnit: TDSUnit); override;
    procedure RemoveUnit(AUnit: TDSUnit); override;
    procedure OnException(AException: Exception; AUnit: TDSUnit; ALine: integer); override;

    function  GetUnitFromName (const AName: string): TDSUnit;
    function  IsValidUnitName(const AName: string) : boolean;
    procedure OnLastUnitLoaded (Sender: TObject);
    procedure OnFirstUnitUnLoaded;
    procedure OnEnterProcedure(AUnit: TDSUnit; ALine: integer; const ACallName: string; cArgs : integer; pArgs : PArgList);
    procedure OnLeaveProcedure;
    procedure SetPrevParams(AUnit: TDSUnit; ALine: integer);
    function  GetStackState: integer;
    procedure SetStackState(ANewState: integer);

    function  CheckDebuggerInSystem(var APath: TFileName):boolean;
    procedure RunDebugger;

    property  CurrentUnit: TDSUnit read FCurrentUnit;
    property  CurrentLine: integer read FCurrentLine;
    property  CallsCount: integer read GetCallsCount;
    property  CallStackState: integer read FCallStackState write FCallStackState;
    property  StopAtNextLine: boolean read FStopAtNextLine write FStopAtNextLine;
    property  ResumeAction: TBreakResumeType read FResumeAction write FResumeAction;
    property  RunToLineInfo: PRunToLineInfo read GetPRunToLineInfo ;
    property  LastUnitFromStack: TDSUnit read FLastUnitFromStack;
    property  LastLineFromStack: integer read FLastLineFromStack;
    property  Connected;
    property  DebuggerExist;
  end;

  TDebugDCScripter = class(TDCScripter)
  public
    property Project;
    property DebugProject;
    property OnLastUnitLoaded;
  end;

  TDSUnit = class
  private
    FRunner: TScriptRunner;
    FDSProject: TDSProjectRun;
    FLocalPrj: TDSProjectRun;
    FScriptText: string;
    FOnDebuggerDisconnect: TNotifyEvent;
    FOnDebuggerConnect: TNotifyEvent;
  public
    constructor Create(ARunner: TScriptRunner);
    destructor Destroy; override;
    procedure Init(const AScript: string);
    function  GetDebugDCScripter: TDebugDCScripter;
    procedure DoDebuggerConnect;
    procedure DoDebuggerDisconnect;
    function  GetText: string;
    function  GetName: string;
    function  _Evaluate(const AExpression: string): OleVariant;
    function  Evaluate(const AExpression: string): string;
    procedure GetVarList(AList: TStrings);
    property  DSProject: TDSProjectRun read FDSProject write FDSProject;
    property  OnDebuggerConnect: TNotifyEvent read FOnDebuggerConnect write FOnDebuggerConnect;
    property  OnDebuggerDisconnect: TNotifyEvent read FOnDebuggerDisconnect write FOnDebuggerDisconnect;
  end;

implementation

uses Windows, Forms, dcdsClient, dcpascal, sdMain, registry, dcApp, dcdreamLib;

type

  TDSStackItem = class(TCustomStackItem)
  private
    function GetModule: TDSUnit;
  public
    constructor CreateDS(AUnit:TDSUnit; ALine:integer);
    destructor Destroy; override;
    property Module: TDSUnit read GetModule;
  end;

function ConvertVarToStrEx(const OleVar: OleVariant; const ASpecifier: TEvaluateSpecifier;
         const Cnt: integer; ASc: TKindOfScript; AStrInBracks: boolean): string;
var
  VarRes : Variant;
  EStr: string;
  Pref_Hex, Pref_Str: string;
begin
  GetPreffixes(ASc, Pref_Hex, Pref_Str);
  with TVarData(OleVar) do
    case vType of
      varDispatch: if (ASpecifier = evsNone) and
                      GetObjectProperty(IDispatch(VDispatch), 'ClassName', 0, nil, VarRes, EStr) and
                      ((VarType(VarRes) = VarOleStr) or (VarType(VarRes) = VarString)) then
                     Result := String(VarRes) + '(' + Pref_Hex + IntToHex(Integer(VDispatch),0) + ')'
                   else
                     Result := Pref_Hex + IntToHex(Integer(VDispatch),0);
    else
      Result := ConvertVarToStr(OleVar, ASpecifier, Cnt, ASc, AStrInBracks,nil);
    end;

end;

{--------------------------TSafedList---------------------------}

constructor TSafedList.Create;
begin
  inherited;
  FList := TList.Create;
  FCrtlSec := TCrtlSection.Create;
end;

{-----------------------------------------------------}

destructor TSafedList.Destroy;
begin
  FList.Free;
  FCrtlSec.Free;
  inherited;
end;

{-----------------------------------------------------}

function TSafedList.Get(Index: Integer): Pointer;
begin
  Result := FList.Items[Index];
end;

{-----------------------------------------------------}

procedure TSafedList.Put(Index: Integer; Item: Pointer);
begin
  FList.Insert(Index, Item);
end;

{-----------------------------------------------------}

function TSafedList.GetCount: integer;
begin
  Result := FList.Count;
end;

{-----------------------------------------------------}

function TSafedList.Add(Item: Pointer): Integer;
begin
  Result := FList.Add (Item);
end;

{-----------------------------------------------------}

procedure TSafedList.Clear;
begin
  FList.Clear;
end;

{-----------------------------------------------------}

procedure TSafedList.Delete(Index: Integer);
begin
  FList.Delete(Index);
end;

{-----------------------------------------------------}

function TSafedList.First: Pointer;
begin
  Result := FList.First;
end;

{-----------------------------------------------------}

function TSafedList.IndexOf(Item: Pointer): Integer;
begin
  Result := FList.IndexOf (Item);
end;

{-----------------------------------------------------}

function TSafedList.Last: Pointer;
begin
  Result := FList.Last;
end;

{-----------------------------------------------------}

function TSafedList.Remove(Item: Pointer): Integer;
begin
  Result := FList.Remove (Item);
end;

{-----------------------------------------------------}

procedure TSafedList.Lock;
begin
  FCrtlSec.Enter;
end;

{-----------------------------------------------------}

procedure TSafedList.UnLock;
begin
  FCrtlSec.Leave;
end;

{-------------------TBreakPoin---------------------------}

function TDSBreakPoint.CheckCondition: boolean;
var
  EvRes: OleVariant;
begin
  Result := Condition = '';
  if not Result then
  begin
    EvRes := GetDSUnit._Evaluate(Condition);
    Result := TVarData(EvRes).VBoolean;
  end;
end;

constructor TDSBreakPoint.CreateDS(const ADSUnit: TDSUnit; const ALine: integer);
begin
  inherited Create(nil);
  UnitHandle := integer(ADSUnit);
  Line := ALine;
  Enabled := true;
end;

{--------------------------------------------------------}

destructor TDSBreakPoint.Destroy;
begin
  inherited;
end;

{--------------------------------------------------------}

function TDSBreakPoint.GetDSUnit: TDSUnit;
begin
  Result := TDSUnit(UnitHandle);
end;

function TDSBreakPoint.GetFileName: string;
begin
  Result := TDSUnit(UnitHandle).GetName;
end;

{---------------TDSProject----------------}

constructor TDSProject.Create;
begin
  inherited;
  FApplicationName := Application.Title + ', ' + Application.MainForm.Caption;
  FBreakPointList := TSafedList.Create;
  FCrtlSec := TCrtlSection.Create;
  FUnitsList := TSafedList.Create;
  FCallStack := TStringList.Create;
  FTimer := TTimer.Create(nil);
  with FTimer do
  begin
    Enabled := false;
    Interval := 100;
    OnTimer := _OnTimer;
  end;
end;

{-------------------------------}

destructor TDSProject.Destroy;
begin
  ClearCallStack;
  ClearBreakPoints;
  FTimer.Free;
  FCallStack.Free;
  FUnitsList.Free;
  FCrtlSec.Free;
  FBreakPointList.Free;
  inherited;
end;

{-------------------------------}

function TDSProject.FindBreakPoint(AUnit: TDSUnit; ALine: integer): integer;
var
  i: integer;
  BrP: TDSBreakPoint;
begin
  for i := 0 to FBreakPointList.Count -1 do
  begin
    BrP := TDSBreakPoint(FBreakPointList.Items[i]);
    if (BrP.Line = ALine) and (BrP.Module = AUnit) then
    begin
      result := i;
      exit;
    end;
  end;
  result := -1;
end;

{-------------------------------}

Procedure TDSProject.ConnectToDebugger;
Begin
  If DebuggerExist Then
    ConnectDebuggerToProject(Self);
End;

{-------------------------------}

function TDSProject.CheckBreakPoint (AUnit: TDSUnit; ALine: integer): boolean;
var
  Idx : integer;
  E: Exception;
  BrP : TDSBreakPoint;
  EMsg: string;
begin
  try
    LockBreakPoints;
    try
      Idx := FindBreakPoint (AUnit, ALine);
      Result := Idx <> -1;
      if Result then
      begin
        BrP := TDSBreakPoint(FBreakPointList.Items[Idx]);
        with BrP do
        begin
            Result := Enabled;
          try
            if Result then
              Result := CheckPassCount and CheckCondition;
          except
            EMsg :=  SEBreakpointBegin + Condition + SEBreakpointEnd + Exception(ExceptObject).Message;
            raise;
          end;
        end;
      end;
    finally
      UnLockBreakPoints;
    end;
  except
    E := Exception.Create(EMsg);
    OnException (E, AUnit, ALine);
    E.Free;
    Result := false;
  end;
end;

{-------------------------------}

function TDSProject.SuspendThread(AUnit: TDSUnit; ALine: integer; AIsException: boolean): boolean;
begin
  FTimer.Enabled := false;
  Result := true;
  FRunToLineInfo.Stop := false;
  FCrtlSec.Enter;
  FSuspended := true;
  FCrtlSec.Leave;
  if not AIsException then
    try
      ProjectOnBreakPoint(self, Integer(AUnit), ALine);
    except
      ResumeThread;
      CloseProject(self);
      exit;
    end;
  while FSuspended do
    Sleep(1);
end;

{-------------------------------}

function TDSProject.ResumeThread: boolean;
begin
  Result := true;
  FCrtlSec.Enter;
  FSuspended := false;
  FCrtlSec.Leave;
end;

{-------------------------------}

procedure TDSProject.AddUnit(AUnit: TDSUnit);
begin
  FUnitsList.Add(AUnit);
end;

{-------------------------------}

procedure TDSProject.RemoveUnit(AUnit: TDSUnit);
begin
  FUnitsList.Remove(AUnit);
end;

{-------------------------------}

procedure TDSProject.OnException(AException: Exception; AUnit: TDSUnit;
  ALine: integer);
begin
  try
    ProjectOnException(self, AException, Integer(AUnit), ALine);
  except
    CloseProject(self);
    exit;
  end;
  SuspendThread(AUnit, ALine, true);
end;

{-------------------------------}

procedure TDSProject.ResumeFromBreakPoint(brt: TBreakResumeType);
begin
  FResumeAction := brt;
  ResumeThread;
  FTimer.Enabled := true;
end;

{-------------------------------}

procedure TDSProject.RunToLine(const AUnit, ALine: Integer);
begin
  if FConnected then
    FStopAtNextLine := false;

  with FRunToLineInfo do
    begin
      Stop := true;
      AtLine := ALine;
      AtUnit := Pointer(AUnit);
      ResumeThread;
      FTimer.Enabled := true;
    end;
end;


{-------------------------------}

procedure TDSProject.CauseBreak;
begin
  if FConnected then
  begin
    FResumeAction := brtNone;
    FStopAtNextLine := true;
  end;
end;

{-------------------------------}

procedure TDSProject.ConnectDebugger;
var
  i : integer;
begin
  FConnected := true;
  FBreakOnException := true;
  for i := 0 to FUnitsList.Count - 1 do
    TDSUnit(FUnitsList.Items[i]).DoDebuggerConnect;
end;

{-------------------------------}

procedure TDSProject.DisconnectDebugger;
var
  i : integer;
begin
  for i := 0 to FUnitsList.Count - 1 do
    TDSUnit(FUnitsList.Items[i]).DoDebuggerDisconnect;
  FBreakOnException := false;
  ClearCallStack;
  ClearBreakPoints;
  ResumeThread;
  FConnected := false;
end;

{-------------------------------}

procedure TDSProject.OnDebuggerClose;
begin
  FDebuggerExist := false;
  Disconnect;
end;

{-------------------------------}

function  TDSProject.GetApplicationName: string;
begin
  Result := FApplicationName;
end;

{-------------------------------}

function TDSProject.GetName: string;
begin
  Result := '';
  if MainIDEObject <> nil then
    if MainIDEObject.ActiveProject <> nil then
        Result := MainIDEObject.ActiveProject.FileName;
  if Result = '' then
  begin
    if FUnitsList.Count <> 0 then
      Result := TDSUnit(FUnitsList.Items[0]).GetName
    else
      Result := '';
  end;
end;

{-------------------------------}

procedure TDSProject.Evaluate (const AUnit: integer; const AExpress: string; var Res: string; var Error: boolean);
begin
  FResumeAction := brtEvaluate;
  try
    Res := TDSUnit(AUnit).Evaluate(AExpress);
    Error := false;
  except
    Res := '[' + Exception(ExceptObject).Message + ']';
    Error := true;
  end;
  FResumeAction := brtNone;
end;

{-------------------------------}

function TDSProject.GetUnitName(AUnit: integer): string;
var
  idx : integer;
begin
  idx := FUnitsList.IndexOf(TDSUnit(AUnit));
  if idx <> - 1 then
    Result := TDSUnit(FUnitsList.Items[idx]).GetName
  else
    Result := '';
end;

{-------------------------------}

function TDSProject.GetUnitText(AUnit: integer): string;
var
  idx : integer;
begin
  idx := FUnitsList.IndexOf(TDSUnit(AUnit));
  if idx <> - 1 then
    Result := TDSUnit(FUnitsList.Items[idx]).GetText
  else
    Result := '';
end;

{-------------------------------}

procedure TDSProject.LockUnits;
begin
  FUnitsList.Lock;
end;

{-------------------------------}

procedure TDSProject.UnLockUnits;
begin
  FUnitsList.UnLock;
end;

{-------------------------------}

function TDSProject.GetUnits(Index: Integer): integer;
begin
  Result := 0;
  if (Index >= 0) and (Index <= FUnitsList.Count - 1) then
    Result := Integer(FUnitsList.Items[Index])
end;

{-------------------------------}

function TDSProject.GetUnitCount: integer;
begin
  Result := FUnitsList.Count;
end;

{-------------------------------}

procedure TDSProject._OnTimer(Sender: TObject);
begin
  FTimer.Enabled := false;
  Application.BringToFront;
end;

{-------------------------------}

procedure TDSProject.ClearCallStack;
var
  i: integer;
begin
  with FCallStack do
  begin
    for i:= 0 to Count -1 do
      TDSStackItem(Objects[i]).Free;
    Clear;
  end;
end;

{-------------------------------}

procedure TDSProject.LockBreakPoints;
begin
  FBreakPointList.Lock;
end;

{-------------------------------}

procedure TDSProject.UnLockBreakPoints;
begin
  FBreakPointList.UnLock;
end;

{-------------------------------}

function TDSProject.GetBreakPoint(Index: Integer): TDSBreakPoint;
begin
  if (Index >= 0) and (Index <= FBreakPointList.Count - 1) then
    Result := TDSBreakPoint(FBreakPointList.Items[Index])
  else
    Result := nil;
end;

{-------------------------------}

function TDSProject.GetBreakPointCount: integer;
begin
  Result := FBreakPointList.Count;
end;

{-------------------------------}

procedure TDSProject.ClearBreakPoints;
begin
  LockBreakPoints;
  try
    while FBreakPointList.Count <> 0 do
    begin
      TObject(FBreakPointList.Items[0]).Free;
      FBreakPointList.Delete(0);
    end;
  finally
    UnLockBreakPoints;
  end;  
end;

{-------------------------------}

function TDSProject.AddBreakPoint(const AUnit, ALine: integer; const AEnabled: boolean): integer;
var
  BrP: TDSBreakPoint;
begin
  if FindBreakPoint (TDSUnit(AUnit), ALine) = -1 then
  begin
    BrP := TDSBreakPoint.CreateDS(TDSUnit(AUnit), ALine);
    BrP.Enabled := AEnabled;
    FBreakPointList.Add(BrP);
    Result := Integer(BrP);
  end
  else
    Result := -1;
end;

{-------------------------------}

function TDSProject.RemoveBreakPoint(ABreakPoint: integer): boolean;
var
  Idx: integer;
begin
  Idx:= FBreakPointList.IndexOf(TDSBreakPoint(ABreakPoint));
  if Idx <> -1 then
  begin
    TDSBreakPoint(FBreakPointList.Items[Idx]).Free;
    FBreakPointList.Delete (Idx);
    Result := true;
  end
  else
    Result := false;
end;

{-------------------------------}

function TDSProject.GetStackFrameCount: integer;
begin
  Result := FCallStack.Count -1; // top level function is hide
end;

{-------------------------------}

procedure TDSProject.GetStackFrame(Index: integer; var AUnit,
  ALine: integer; var StackStr: string);
var
  Item : TDSStackItem;
begin
  if (Index >=0) and (Index <= FCallStack.Count - 2) then
  begin
    Item := TDSStackItem(FCallStack.Objects[Index + 1]); // top level function is hide
    AUnit := Integer(Item.Module);
    ALine := Item.Line;
    StackStr := FCallStack.Strings[Index + 1];
  end;
end;

{-------------------------------}

procedure TDSProject.GetVarList(const AUnit: integer; AList: TStrings);
begin
  TDSUnit(AUnit).GetVarList(AList);
end;

{---------------TDSProjectRun----------------}

constructor TDSProjectRun.Create;
begin
  inherited;
end;

{-------------------------------}

destructor TDSProjectRun.Destroy;
begin
  inherited;
end;

{-------------------------------}

function TDSProjectRun.GetCallsCount: integer;
begin
  Result := FCallStack.Count;
end;

{-------------------------------}

function TDSProjectRun.GetPRunToLineInfo: PRunToLineInfo;
begin
  Result := @FRunToLineInfo;
end;

{-------------------------------}


function  TDSProjectRun.ResumeThread: boolean;
begin
  if FConnected then
  begin
    case FResumeAction of
      brtContinue: FStopAtNextLine := false;
      brtStepInto: FStopAtNextLine := true;
      brtStepOver: FCallStackState := FCallStack.Count;
    end;
    Result := inherited ResumeThread;
  end
  else
    Result := false;
end;

{-------------------------------}

function  TDSProjectRun.SuspendThread(AUnit: TDSUnit; ALine: integer; AIsException: boolean): boolean;
begin
  FCurrentUnit := AUnit;
  FCurrentLine := ALine;
  FStopAtNextLine := false;
  FRunToLineInfo.Stop := false;
  FLastLineFromStack := 0;
  FResumeAction := brtNone;
  if Connected then
    Result := inherited SuspendThread(AUnit, ALine, AIsException)
  else
    Result := false;
end;

{-------------------------------}

function TDSProjectRun.CheckBreakPoint(AUnit: TDSUnit;
  ALine: integer): boolean;
begin
  Result := inherited CheckBreakPoint(AUnit, ALine);
end;

{-------------------------------}

procedure TDSProjectRun.AddUnit(AUnit: TDSUnit);
begin
  inherited AddUnit(AUnit);
end;

{-------------------------------}

procedure TDSProjectRun.RemoveUnit(AUnit: TDSUnit);
begin
  inherited RemoveUnit(AUnit);
end;

{-------------------------------}

procedure TDSProjectRun.OnLastUnitLoaded(Sender: TObject);
begin
  if Connect then
  begin
    DebuggerExist := true;
    try
      AddDelphiProject(self);
    except
      CloseProject(self);
    end;
  end;
end;

{-------------------------------}

procedure TDSProjectRun.OnFirstUnitUnLoaded;
var
  U : TDSUnit;
begin
  if DebuggerExist then
  begin
    try
      if Connected then
        ProjectOnClose(self);
      DebuggerExist := false;
      RemoveDelphiProject(self);
    except
      CloseProject(self);
    end;
  end;
  LockUnits;
  try
    while UnitCount > 0 do
    begin
      U := TDSUnit(Units[0]);
      U.DSProject := nil;
      RemoveUnit(U);
    end;
  finally
    UnLockUnits;
  end;
end;

{-------------------------------}

procedure TDSProjectRun.OnException(AException: Exception; AUnit: TDSUnit;
  ALine: integer);
begin
  inherited;
end;

{-------------------------------}

function TDSProjectRun.GetUnitIndexFromName(const AName: string): integer;
var
  i: integer;
begin
  for i:= 0 to UnitCount - 1 do
    if ExtractFileName(TDSUnit(Units[i]).GetName) = ExtractFileName(AName) then
    begin
      Result := i;
      exit;
    end;
  Result := -1;
end;

{-------------------------------}

function TDSProjectRun.GetUnitFromName(const AName: string): TDSUnit;
var
  Idx: Integer;
begin
  LockUnits;
  try
    Idx := GetUnitIndexFromName(AName);
    if Idx <> -1 then
      Result := TDSUnit(Units[Idx])
    else
      Result := nil;
  finally
    UnLockUnits;
  end;  
end;

{-------------------------------}

function  TDSProjectRun.IsValidUnitName(const AName: string) : boolean;
begin
  Result := GetUnitFromName(AName) <> nil;
end;

{-------------------------------}

procedure TDSProjectRun.OnEnterProcedure(AUnit: TDSUnit; ALine: integer;
  const ACallName: string; cArgs: integer; pArgs: PArgList);
var
  TmpStr: String;
  i: integer;
  StackItem: TDSStackItem;
  Val: OleVariant;
  EvSpec: TEvaluateSpecifier;

  function GetSpecifier(OleVar: OleVariant): TEvaluateSpecifier;
  begin
    if TVarData(Val).vType = varDispatch then
      Result := evsHex
    else
      Result := evsNone;
  end;

begin
  if ALine = 0 then //for add to Stack First Call Level
    StackItem := TDSStackItem.CreateDS(FPrevUnit, FPrevLine)
  else
    StackItem := TDSStackItem.CreateDS(AUnit, ALine);
  TmpStr := ACallName;
  if cArgs > 0 then
  begin
    TmpStr := TmpStr + '(';
    for i := 0 to cArgs - 2 do
    begin
      Val := OleVariant(pArgs^[i]);
      EvSpec := GetSpecifier(Val);
      TmpStr := TmpStr + ConvertVarToStrEx(Val, EvSpec, 0, kscDelphiScript, true) + ',';
    end;
    Val := OleVariant(pArgs^[cArgs - 1]);
    EvSpec := GetSpecifier(Val);
    TmpStr := TmpStr + ConvertVarToStrEx(Val, EvSpec, 0, kscDelphiScript, true) + ')';
  end;
  FCallStack.AddObject(TmpStr, StackItem);
end;

{-------------------------------}

procedure TDSProjectRun.OnLeaveProcedure;
var
  Idx: integer;
  StackItem: TDSStackItem;
begin
  Idx := FCallStack.Count - 1;
  if Idx >= 0 then
  begin
    StackItem := TDSStackItem(FCallStack.Objects[Idx]);
    with StackItem do
    begin
      FLastLineFromStack := Line;
      FLastUnitFromStack := Module;
      StackItem.Free;
      FCallStack.Delete (Idx);
    end;
    if FResumeAction = brtStepOver then
      if (FCallStack.Count = 0) and (FCallStackState <> 0) then
        FCallStackState := 1 // stop for next time
      else
        FStopAtNextLine := FCallStackState = FCallStack.Count + 1;  //stop if return from other unit with StepOver
  end;
end;

{-------------------------------}

function TDSProjectRun.GetStackState: integer;
begin
  Result := FCallStack.Count;
end;

{-------------------------------}

procedure TDSProjectRun.SetStackState(ANewState: integer);
var
  _D, i: integer;
begin
  _D := FCallStack.Count - ANewState;
  if _D > 0 then
  begin
    FCallStackState := ANewState;
    for i := 0 to _D -1 do
    begin
      try
        TDSStackItem(FCallStack.Objects[ANewState]).Free;
      finally
        FCallStack.Delete (ANewState)
      end;
    end;
  end;
end;

{-------------------------------}

procedure TDSProjectRun.SetPrevParams(AUnit: TDSUnit; ALine: integer);
begin
  FPrevUnit := AUnit;
  FPrevLine := ALine;
end;

{-------------------------------}

function TDSProjectRun.CheckDebuggerInSystem(
  var APath: TFileName): boolean;
var
  Reg: TRegistry;
begin
  Result := false;
  Reg := TRegistry.Create;
  try
    with Reg do
    begin
      if OpenKey(DreamDebuggerKey,false) then
      begin
        APath := ReadString(DreamDebuggerPath);
        Result := true;
      end;
    end;
  finally
    Reg.Free;
  end;
end;

{-------------------------------}

procedure TDSProjectRun.RunDebugger;
var
  DebuggerPath: TFileName;

  Function RunProgram(const CmdLine):Boolean;
  Var
    ProcessInfo:TProcessInformation;
    StartupInfo:TStartupInfo;
  Begin
    FillChar(StartupInfo,SizeOf(StartupInfo),0);
    StartupInfo.cb:=SizeOf(StartupInfo);
    If Not CreateProcess(Nil,PChar(CmdLine),Nil,Nil,True,0,
                             Nil,nil,StartupInfo,ProcessInfo) Then
    Begin
      Result:=False;
      Exit;
    End;
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(ProcessInfo.hProcess);
    Result:=true;
  End;

begin
  if CheckDebuggerInSystem(DebuggerPath) then
    if RunProgram(DebuggerPath) then
    begin
      //connect, addproject, etc., must be here
    end;
end;

{-------------------------------}

{ TDSUnit }

constructor TDSUnit.Create(ARunner: TScriptRunner);
begin
  inherited Create;
  FRunner := ARunner;
  FLocalPrj := TDSProjectRun.Create;
end;

destructor TDSUnit.Destroy;
begin
  FLocalPrj.Free;
  inherited;
end;

procedure TDSUnit.DoDebuggerConnect;
begin
  if Assigned(FOnDebuggerConnect) then
    FOnDebuggerConnect(self);
end;

procedure TDSUnit.DoDebuggerDisconnect;
begin
  if Assigned(FOnDebuggerDisconnect) then
    FOnDebuggerDisconnect(self);
end;

function TDSUnit._Evaluate(const AExpression: string): OleVariant;
begin
  Result:= Frunner.EvaluateExpression(AExpression)
end;

function TDSUnit.Evaluate(const AExpression: string): string;
var
  Expr : string;
  Specif : TEvaluateSpecifier;
  Cnt : integer;
begin
  Expr := AExpression;
  Specif := ExpressionToSpecifier(Expr, Cnt);
  Result := ConvertVarToStrEx(_Evaluate(Expr), Specif, Cnt, kscDelphiScript, true);
end;

function TDSUnit.GetName: string;
begin
  Result := Frunner.ScriptName;
  if Result = '' then
  begin
    Result := Frunner.Scripter.ScriptFile;
    if Result = '' then
      Result := SEmptyScriptName;
  end;
end;

function TDSUnit.GetText: string;
begin
  Result := FScriptText;
end;

function TDSUnit.GetDebugDCScripter: TDebugDCScripter;
begin
  Result := TDebugDCScripter(FRunner.Scripter);
  if (Result <> nil) and (Result.Project <> 0) then
    Result := TDebugDCScripter(Result.Project);
end;

procedure TDSUnit.Init(const AScript: string);
var
  DbgScr: TDebugDCScripter;
begin
  FScriptText := AScript;
  DbgScr := GetDebugDCScripter;

  if DbgScr = nil then
    exit;

  if DbgScr.DebugProject = 0 then
  begin
    FDSProject := FLocalPrj;
    DbgScr.DebugProject := THandle(FDSProject);
    DbgScr.OnLastUnitLoaded := FDSProject.OnLastUnitLoaded;
  end
  else
    FDSProject := TDSProjectRun(DbgScr.DebugProject);
  FDSProject.AddUnit(self);
end;

procedure TDSUnit.GetVarList(AList: TStrings);
var
  VarList: TStringList;
  i: integer;
  VarName, VarVal: string;

  function GetVarName(AStr: string): string;
  var
    P: integer;
  begin
    P := BackPosEx('.', AStr, Length(AStr));
    if P > 0 then
      Result := copy(AStr, P + 1, Length(AStr) - P)
    else
      Result := AStr;
  end;

begin
  VarList := TStringList.Create;
  try
    FRunner.GetVarList(VarList);
    with VarList do
      for i:=0 to Count -1 do
      begin
        VarName := GetVarName(Strings[i]);
        try
          VarVal := Evaluate(VarName);
        except
          Continue;
        end;
        AList.Add(VarName + '=' + Evaluate(VarName))
      end;
  finally
    VarList.Free;
  end;
end;

{ TDSStackItem }

constructor TDSStackItem.CreateDS(AUnit:TDSUnit; ALine:integer);
begin
  inherited Create(integer(AUnit), ALine);
end;

destructor TDSStackItem.Destroy;
begin
  inherited;
end;

function TDSStackItem.GetModule: TDSUnit;
begin
  Result := TDSUnit(UnitHandle);
end;

end.
