{*******************************************************}
{                                                       }
{            RadStudio Debugger Visualizer Sample       }
{ Copyright(c) 2009-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit StdStringVisualizer;

interface

procedure Register;

implementation

uses
  Classes, Forms, SysUtils, ToolsAPI;

resourcestring
  sStdStringVisualizerName = 'std::string and std::wstring Visualizer for C++';
  sStdStringVisualizerDescription = 'Displays the actual string value for std::string and std::wstring instances';

type
  TStdStringTimeVisualizer = class(TInterfacedObject, IOTADebuggerVisualizer,
    IOTADebuggerVisualizerValueReplacer, IOTAThreadNotifier, IOTAThreadNotifier160)
  private
    FNotifierIndex: Integer;
    FCompleted: Boolean;
    FDeferredResult: string;
  public
    { IOTADebuggerVisualizer }
    function GetSupportedTypeCount: Integer;
    procedure GetSupportedType(Index: Integer; var TypeName: string;
      var AllDescendants: Boolean);
    function GetVisualizerIdentifier: string;
    function GetVisualizerName: string;
    function GetVisualizerDescription: string;
    { IOTADebuggerVisualizerValueReplacer }
    function GetReplacementValue(const Expression, TypeName, EvalResult: string): string;
    { IOTAThreadNotifier }
    procedure EvaluteComplete(const ExprStr: string; const ResultStr: string;
      CanModify: Boolean; ResultAddress: Cardinal; ResultSize: Cardinal;
      ReturnCode: Integer);
    procedure ModifyComplete(const ExprStr: string; const ResultStr: string;
      ReturnCode: Integer);
    procedure ThreadNotify(Reason: TOTANotifyReason);
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;
    { IOTAThreadNotifier160 }
    procedure EvaluateComplete(const ExprStr: string; const ResultStr: string;
      CanModify: Boolean; ResultAddress: TOTAAddress; ResultSize: LongWord;
      ReturnCode: Integer);
  end;


const
  StdStringVisualizerTypes: array[0..3] of string =
  (
    'std::basic_string<char, std::char_traits<char>, std::allocator<char> >',
    'std::basic_string<wchar_t, std::char_traits<wchar_t>, std::allocator<wchar_t> >',
    'std::string',
    'std::wstring'
  );

{ TStdStringTimeVisualizer }

procedure TStdStringTimeVisualizer.AfterSave;
begin
  // don't care about this notification
end;

procedure TStdStringTimeVisualizer.BeforeSave;
begin
  // don't care about this notification
end;

procedure TStdStringTimeVisualizer.Destroyed;
begin
  // don't care about this notification
end;

procedure TStdStringTimeVisualizer.Modified;
begin
  // don't care about this notification
end;

procedure TStdStringTimeVisualizer.ModifyComplete(const ExprStr,
  ResultStr: string; ReturnCode: Integer);
begin
  // don't care about this notification
end;

procedure TStdStringTimeVisualizer.EvaluteComplete(const ExprStr,
  ResultStr: string; CanModify: Boolean; ResultAddress, ResultSize: Cardinal;
  ReturnCode: Integer);
begin
  EvaluateComplete(ExprStr, ResultStr, CanModify, TOTAAddress(ResultAddress), 
    LongWord(ResultSize), ReturnCode);
end;

procedure TStdStringTimeVisualizer.EvaluateComplete(const ExprStr,
  ResultStr: string; CanModify: Boolean; ResultAddress: TOTAAddress; ResultSize: LongWord;
  ReturnCode: Integer);
begin
  FCompleted := True;
  if ReturnCode = 0 then
    FDeferredResult := ResultStr;
end;

procedure TStdStringTimeVisualizer.ThreadNotify(Reason: TOTANotifyReason);
begin
  // don't care about this notification
end;

function TStdStringTimeVisualizer.GetReplacementValue(
  const Expression, TypeName, EvalResult: string): string;
var
  CurProcess: IOTAProcess;
  CurThread: IOTAThread;
  ResultStr: array[0..4095] of Char;
  CanModify: Boolean;
  Done: Boolean;
  ResultAddr, ResultSize, ResultVal: LongWord;
  EvalRes: TOTAEvaluateResult;
  DebugSvcs: IOTADebuggerServices;
begin
  begin
    Result := EvalResult;
    if Supports(BorlandIDEServices, IOTADebuggerServices, DebugSvcs) then
      CurProcess := DebugSvcs.CurrentProcess;
    if CurProcess <> nil then
    begin
      CurThread := CurProcess.CurrentThread;
      if CurThread <> nil then
      begin
        repeat
        begin
          Done := True;
          EvalRes := CurThread.Evaluate(Expression+'._Myptr()', @ResultStr, Length(ResultStr),
            CanModify, eseAll, '', ResultAddr, ResultSize, ResultVal, '', 0);
          case EvalRes of
            erOK: Result := ResultStr;
            erDeferred:
              begin
                FCompleted := False;
                FDeferredResult := '';
                FNotifierIndex := CurThread.AddNotifier(Self);
                while not FCompleted do
                  DebugSvcs.ProcessDebugEvents;
                CurThread.RemoveNotifier(FNotifierIndex);
                FNotifierIndex := -1;
                if FDeferredResult <> '' then
                  Result := FDeferredResult
                else
                  Result := EvalResult;
              end;
            erBusy:
              begin
                DebugSvcs.ProcessDebugEvents;
                Done := False;
              end;
          end;
        end
        until Done = True;
      end;
    end;
  end;
end;

function TStdStringTimeVisualizer.GetSupportedTypeCount: Integer;
begin
  Result := Length(StdStringVisualizerTypes);
end;

procedure TStdStringTimeVisualizer.GetSupportedType(Index: Integer; var TypeName: string;
  var AllDescendants: Boolean);
begin
  AllDescendants := False;
  TypeName := StdStringVisualizerTypes[Index];
end;

function TStdStringTimeVisualizer.GetVisualizerDescription: string;
begin
  Result := sStdStringVisualizerDescription;
end;

function TStdStringTimeVisualizer.GetVisualizerIdentifier: string;
begin
  Result := ClassName;
end;

function TStdStringTimeVisualizer.GetVisualizerName: string;
begin
  Result := sStdStringVisualizerName;
end;

var
  StdStringVis: IOTADebuggerVisualizer;

procedure Register;
begin
  StdStringVis := TStdStringTimeVisualizer.Create;
  (BorlandIDEServices as IOTADebuggerServices).RegisterDebugVisualizer(StdStringVis);
end;

procedure RemoveVisualizer;
var
  DebuggerServices: IOTADebuggerServices;
begin
  if Supports(BorlandIDEServices, IOTADebuggerServices, DebuggerServices) then
  begin
    DebuggerServices.UnregisterDebugVisualizer(StdStringVis);
    StdStringVis := nil;
  end;
end;

initialization
finalization
  RemoveVisualizer;
end.
