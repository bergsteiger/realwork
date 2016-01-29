{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcscriptdebug;

interface
{$I dc.inc}

uses windows, classes, sysutils,
     dcdreamlib, dcsystem, dcscript, dcdslib;

type
  TDebugObject = class;

  TCollectionUpdateEvent = procedure(Sender : TObject; Item : TCollectionItem) of object;

  TExtCollection = class(TCollection)
  private
    fOnUpdate: TCollectionUpdateEvent;
  protected
    procedure Update(Item: TCollectionItem); override;
  public
    property OnUpdate : TCollectionUpdateEvent read fOnUpdate write fOnUpdate;
  end;

  TBreakPointItem = class(TCollectionItem)
  private
    FEnabled: boolean;
    FLine: integer;
    FPassCount: integer;
    FCondition: string;
    fScriptName : string;
  public
    procedure Assign(Source : TPersistent); override;

    property Condition : string read FCondition write FCondition;
    property Enabled : boolean read FEnabled write FEnabled;
    property Line : integer read FLine write FLine;
    property PassCount : integer read FPassCount write FPassCount;
    property ScriptName : string read fScriptName write fScriptName;
  end;

  TBreakPointChangesHandler = procedure(Sender : TObject; Item : TBreakPointItem) of object;
  
  TBreakPointList = class(TCollection)
  private
    fHandlersList : TMethodList;

    function GetItem(index : integer) : TBreakPointItem;
  public
    constructor Create;
    function AddBreakPoint(const AScriptName : string; ALine : integer) : TBreakPointItem;
    procedure RemoveBreakPoint(const AScriptName : string; ALine : integer);
    function  GetBreakPoint(const AScriptName : string; ALine : integer) : TBreakPointItem;

    procedure AddChangeNotification(Handler : TBreakPointChangesHandler);
    procedure RemoveChangeNotification(Handler : TBreakPointChangesHandler);

    property Items[index : integer] : TBreakPointItem read GetItem; default;
  end;

  TWatchItem = class(TCollectionItem)
  private
    fEnabled : boolean;
    fExpression : string;
    fValue : string;

    procedure SetEnabled(const Value: boolean);
    procedure SetExpression(const Value: string);
  public
    procedure Recalc;
    procedure Assign(Source : TPersistent); override;
    property Value : string read fValue;
    property Enabled : boolean read fEnabled write SetEnabled;
    property Expression : string read fExpression write SetExpression;
  end;

  TWatchItems = class(TExtCollection)
  private
    fDebugObject : TDebugObject;

    function GetItem(index : integer) : TWatchItem;
  protected
  public
    constructor Create(ADebugObject : TDebugObject);
    procedure Recalc;
    procedure SetEnableForAll(Enable : boolean);

    property DebugObject : TDebugObject read fDebugObject;
    property Items[index : integer] : TWatchItem read GetItem; default;
  end;

  TDebugObject = class
  private
    fHandlers : TList;
    fMainScripter : TDCScripter;
    fWatchItems : TWatchItems;
    fBreakPoints : TBreakPointList;
    fCurrentScripter : TDCScripter;

    fPaused : boolean;
    fAnimate : boolean;

  protected
    procedure InitScript;
    procedure Update; virtual;
  public
    constructor Create;
    destructor Destroy; override;

    procedure TraceInto;
    procedure StepOver;
    procedure Reset;
    procedure Go;
    procedure Pause;
    function  Evaluate(const Expression : string) : OleVariant;
    function  GetCurrentLine : integer;
    function  GetCurrentScripter : TDCScripter;
    function  GetCurrentScriptName : string;

    procedure LoadMainScript(Scripter : TDCScripter); virtual;

    function  AddBreakPoint(const AScriptName : string; ALine : integer) : TBreakPointItem;
    procedure RemoveBreakPoint(const AScriptName : string; ALine : integer);
    function  GetBreakPoint(const AScriptName : string; ALine : integer) : TBreakPointItem;
    function  IsBreakPoint(Scripter : TDCScripter; ALine : integer) : boolean;

    procedure SetCurrentScripter(Scripter : TDCScripter);

    property MainScripter : TDCScripter read fMainScripter;
    property Paused : boolean read fPaused;
    property Animate : boolean read fAnimate write fAnimate;
    property WatchItems : TWatchItems read fWatchItems;
    property BreakPoints : TBreakPointList read fBreakPoints;
  end;

implementation

{******************************************************************}
{ TBreakPointItem }
procedure TBreakPointItem.Assign(Source : TPersistent);
begin
  if Source is TBreakPointItem then
    with TBreakPointItem(Source) do
      begin
        self.Condition := Condition;
        self.Enabled := Enabled;
        self.Line := Line;
        self.PassCount := PassCount;
        self.ScriptName := ScriptName;
        self.Changed(false);
      end
  else
    inherited;
end;

{******************************************************************}

{ TBreakPointList }

constructor TBreakPointList.Create;
begin
  inherited Create(TBreakPointItem);
end;

{------------------------------------------------------------------}

function TBreakPointList.GetItem(index : integer) : TBreakPointItem;
begin
  result := TBreakPointItem(inherited Items[index]);
end;

{------------------------------------------------------------------}

function TBreakPointList.AddBreakPoint(const AScriptName : string; ALine : integer) : TBreakPointItem;
begin
  result := GetBreakPoint(AScriptName, ALine);
  if result <> nil then
    exit;

  result := TBreakPointItem(Add);
  with result do
    begin
      ScriptName := AScriptName;
      Line := ALine;
      Enabled := True;
    end;
end;

{------------------------------------------------------------------}

function TBreakPointList.GetBreakPoint(const AScriptName: string;
  ALine: integer): TBreakPointItem;
var
  i : integer;
begin
  for i := 0 to count - 1 do
    begin
      result := Items[i];
      if (result.Line = ALine) and (CompareText(result.ScriptName, AScriptName) = 0) then
        exit;
    end;

  result := nil;
end;

{------------------------------------------------------------------}

procedure TBreakPointList.RemoveBreakPoint(const AScriptName: string; ALine: integer);
begin
  GetBreakPoint(AScriptName, ALine).Free;
end;

{------------------------------------------------------------------}

procedure TBreakPointList.AddChangeNotification(
  Handler: TBreakPointChangesHandler);
begin
  fHandlersList.Add(TMethod(Handler));
end;

{------------------------------------------------------------------}

procedure TBreakPointList.RemoveChangeNotification(
  Handler: TBreakPointChangesHandler);
begin
  fHandlersList.Remove(TMethod(Handler));
end;

{******************************************************************}
{ TDebugObject }

function TDebugObject.AddBreakPoint(const AScriptName: string;
  ALine: integer): TBreakPointItem;
begin
  result := fBreakPoints.AddBreakPoint(AScriptName, ALine);
end;

{------------------------------------------------------------------}

constructor TDebugObject.Create;
begin
  fHandlers := TList.Create;
  fBreakPoints := TBreakPointList.Create;
  fMainScripter := TDCScripter.Create(nil);
  fWatchItems := TWatchItems.Create(self);
  inherited;
end;

{------------------------------------------------------------------}

destructor TDebugObject.Destroy;
begin
  fMainScripter.Free;
  fHandlers.Free;
  fBreakPoints.Free;
  fWatchItems.Free;
  inherited;
end;

{------------------------------------------------------------------}

function TDebugObject.Evaluate(const Expression: string): OleVariant;
var
  scripter : TDCScripter;
begin
  scripter := GetCurrentScripter;
  if (scripter <> nil) and (scripter.scriptrun <> nil) then
    result := scripter.scriptrun.EvaluateExpression(Expression);
end;

{------------------------------------------------------------------}

function TDebugObject.GetBreakPoint(const AScriptName: string;
  ALine: integer): TBreakPointItem;
begin
  result := fBreakPoints.GetBreakPoint(AScriptName, ALine);
end;

{------------------------------------------------------------------}

function TDebugObject.IsBreakPoint(Scripter: TDCScripter;
  ALine: integer): boolean;
var
  breakitem : TBreakPointItem;
begin
  breakitem := GetBreakPoint(Scripter.ScriptName, ALine);
  result := (breakitem <> nil) and breakitem.Enabled;
end;

{------------------------------------------------------------------}

function TDebugObject.GetCurrentLine: integer;
var
  scripter : TDCScripter;
begin
  result := -1;
  scripter := GetCurrentScripter;
  if scripter <> nil then
    result := scripter.CurrentExecutionLine;
end;

{------------------------------------------------------------------}

procedure TDebugObject.SetCurrentScripter(Scripter : TDCScripter);
begin
  fCurrentScripter := Scripter;
end;

{------------------------------------------------------------------}

function TDebugObject.GetCurrentScripter : TDCScripter;
begin
  result := fCurrentScripter;
  if result = nil then
    result := fMainScripter;
end;

{------------------------------------------------------------------}

function TDebugObject.GetCurrentScriptName: string;
var
  scripter : TDCScripter;
begin
  scripter := GetCurrentScripter;
  if scripter <> nil then
    result := scripter.ScriptName;
end;

{------------------------------------------------------------------}

procedure TDebugObject.Go;
begin
  InitScript;
  MainScripter.Run;
  Update;
end;

{------------------------------------------------------------------}

procedure TDebugObject.InitScript;
begin
  if (MainScripter.ScriptRun = nil) or (GetCurrentLine < 0) then
    LoadMainScript(fMainScripter);
end;

{------------------------------------------------------------------}

procedure TDebugObject.LoadMainScript(Scripter: TDCScripter);
begin

end;

{------------------------------------------------------------------}

procedure TDebugObject.Pause;
begin
  fPaused := true;
end;

{------------------------------------------------------------------}

procedure TDebugObject.RemoveBreakPoint(const AScriptName: string;
  ALine: integer);
begin
  fBreakPoints.RemoveBreakPoint(AScriptName, ALine);
end;

{------------------------------------------------------------------}

procedure TDebugObject.Reset;
begin
  MainScripter.Stop;
  Update;
end;

{------------------------------------------------------------------}

procedure TDebugObject.StepOver;
begin
  InitScript;
  GetCurrentScripter.StepOver;
  Update;
end;

{------------------------------------------------------------------}

procedure TDebugObject.TraceInto;
begin
  InitScript;
  GetCurrentScripter.TraceInto;
  Update;
end;

{------------------------------------------------------------------}

procedure TDebugObject.Update;
begin

end;

{******************************************************************}

{ TWatchItem }

procedure TWatchItem.Assign(Source: TPersistent);
begin
  if Source is TWatchItem then
    begin
      Enabled := False;
      Expression := TWatchItem(Source).Expression;
      Enabled := TWatchItem(Source).Enabled;

      Changed(false);      
    end
  else
    inherited;
end;

{------------------------------------------------------------------}

procedure TWatchItem.Recalc;
var
  _value : OleVariant;
  Expr  : string;
  Specifier : TEvaluateSpecifier;
  Cnt : integer;
  dobject : TDebugObject;
begin
  if Enabled and (Collection <> nil) then
    try
      Expr := Expression;
      Specifier := ExpressionToSpecifier(Expr, Cnt);
      dobject := TWatchItems(Collection).DebugObject;
      if dobject.GetCurrentLine < 0 then
        fValue := 'Script is not running'
      else
        begin
          _value := dobject.Evaluate(Expr);
          fValue := ConvertVarToStr(_Value, Specifier, Cnt, kscDelphiScript, true, dobject.MainScripter.ScriptRun);
        end;  
    except
      on E : Exception do
        fValue := E.Message;
    end
  else
    fValue := '<disabled>';
  Changed(false);
end;

{------------------------------------------------------------------}

procedure TWatchItem.SetEnabled(const Value: boolean);
begin
  fEnabled := Value;
  Recalc;
end;

{------------------------------------------------------------------}

procedure TWatchItem.SetExpression(const Value: string);
begin
  fExpression := Value;
  Recalc;
end;

{******************************************************************}
{ TWatchItems }

constructor TWatchItems.Create(ADebugObject: TDebugObject);
begin
  inherited Create(TWatchItem);
  fDebugObject := ADebugObject;
end;

{------------------------------------------------------------------}

function TWatchItems.GetItem(index : integer) : TWatchItem;
begin
  result := TWatchItem(inherited Items[index]);
end;

{------------------------------------------------------------------}

procedure TWatchItems.Recalc;
var
  i : integer;
begin
  BeginUpdate;
  try
    for i := 0 to Count - 1 do
      Items[i].Recalc;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TWatchItems.SetEnableForAll(Enable: boolean);
var
  i : integer;
begin
  BeginUpdate;
  try
    for i := 0 to Count - 1 do
      Items[i].Enabled := Enable;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

{ TExtCollection }

procedure TExtCollection.Update(Item: TCollectionItem);
begin
  inherited;
  if Assigned(OnUpdate) then
    OnUpdate(self, TWatchItem(Item));
end;

initialization

finalization

end.
