{*******************************************************}
{                                                       }
{            RadStudio Debugger Visualizer Sample       }
{ Copyright(c) 2009-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DateTimeVisualizer;

interface

procedure Register;

implementation

uses
  Classes, Forms, SysUtils, ToolsAPI;

resourcestring
  sDateTimeVisualizerName = 'TDateTime/TDate/TTime Visualizer for Delphi and C++';
  sDateTimeVisualizerDescription = 'Displays TDateTime, TDate and TTime instances in a human-readable date and time format rather than as a floating-point value';

type
  TDebuggerDateTimeVisualizer = class(TInterfacedObject, IOTADebuggerVisualizer,
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

  TTypeLang = (tlDelphi, tlCpp);
  TDateTimeType = (dttDateTime, dttDate, dttTime);

  TDateTimeVisualizerType = record
    TypeName: string;
    TypeLang: TTypeLang;
    DateTimeType: TDateTimeType;
  end;

const
  DateTimeVisualizerTypes: array[0..12] of TDateTimeVisualizerType =
  (
    (TypeName: 'TDateTime'; TypeLang: tlDelphi; DateTimeType: dttDateTime;),
    (TypeName: 'TDate'; TypeLang: tlDelphi; DateTimeType: dttDate;),
    (TypeName: 'TTime'; TypeLang: tlDelphi; DateTimeType: dttTime;),
    (TypeName: 'function: TDateTime'; TypeLang: tlDelphi; DateTimeType: dttDateTime;),
    (TypeName: 'function: TDate'; TypeLang: tlDelphi; DateTimeType: dttDate;),
    (TypeName: 'function: TTime'; TypeLang: tlDelphi; DateTimeType: dttTime;),
    (TypeName: 'System::TDateTime'; TypeLang: tlCpp; DateTimeType: dttDateTime;),
    (TypeName: 'System::TDateTime &'; TypeLang: tlCpp; DateTimeType: dttDateTime;),
    (TypeName: 'TDateTime &'; TypeLang: tlCpp; DateTimeType: dttDateTime;),
    (TypeName: 'System::TDate'; TypeLang: tlCpp; DateTimeType: dttDate;),
    (TypeName: 'TDate &'; TypeLang: tlCpp; DateTimeType: dttDate;),
    (TypeName: 'System::TTime'; TypeLang: tlCpp; DateTimeType: dttTime;),
    (TypeName: 'TTime &'; TypeLang: tlCpp; DateTimeType: dttTime;)
  );

{ TDebuggerDateTimeVisualizer }

procedure TDebuggerDateTimeVisualizer.AfterSave;
begin
  // don't care about this notification
end;

procedure TDebuggerDateTimeVisualizer.BeforeSave;
begin
  // don't care about this notification
end;

procedure TDebuggerDateTimeVisualizer.Destroyed;
begin
  // don't care about this notification
end;

procedure TDebuggerDateTimeVisualizer.Modified;
begin
  // don't care about this notification
end;

procedure TDebuggerDateTimeVisualizer.ModifyComplete(const ExprStr,
  ResultStr: string; ReturnCode: Integer);
begin
  // don't care about this notification
end;

procedure TDebuggerDateTimeVisualizer.EvaluteComplete(const ExprStr,
  ResultStr: string; CanModify: Boolean; ResultAddress, ResultSize: Cardinal;
  ReturnCode: Integer);
begin
  EvaluateComplete(ExprStr, ResultStr, CanModify, TOTAAddress(ResultAddress), 
    LongWord(ResultSize), ReturnCode);
end;

procedure TDebuggerDateTimeVisualizer.EvaluateComplete(const ExprStr,
  ResultStr: string; CanModify: Boolean; ResultAddress: TOTAAddress; ResultSize: LongWord;
  ReturnCode: Integer);
begin
  FCompleted := True;
  if ReturnCode = 0 then
    FDeferredResult := ResultStr;
end;

procedure TDebuggerDateTimeVisualizer.ThreadNotify(Reason: TOTANotifyReason);
begin
  // don't care about this notification
end;

function TDebuggerDateTimeVisualizer.GetReplacementValue(
  const Expression, TypeName, EvalResult: string): string;
var
  Lang: TTypeLang;
  DateTimeType: TDateTimeType;
  I: Integer;
  CurProcess: IOTAProcess;
  CurThread: IOTAThread;
  ResultStr: array[0..255] of Char;
  CanModify: Boolean;
  ResultAddr, ResultSize, ResultVal: LongWord;
  EvalRes: TOTAEvaluateResult;
  DebugSvcs: IOTADebuggerServices;

  function FormatResult(const LEvalResult: string; DTType: TDateTimeType; out ResStr: string): Boolean;
  var
    Dbl: Double;
  begin
    Result := True;
    try
      if not TryStrToFloat(LEvalResult, Dbl) then
        Result := False
      else
        case DTType of
          dttDateTime: ResStr := DateTimeToStr(TDateTime(Dbl));
          dttDate: ResStr := DateToStr(TDate(Dbl));
          dttTime: ResStr := TimeToStr(TTime(Dbl));
        end;
    except
      Result := False;
    end;
  end;

begin
  Lang := TTypeLang(-1);
  DateTimeType := TDateTimeType(-1);
  for I := Low(DateTimeVisualizerTypes) to High(DateTimeVisualizerTypes) do
  begin
    if TypeName = DateTimeVisualizerTypes[I].TypeName then
    begin
      Lang := DateTimeVisualizerTypes[I].TypeLang;
      DateTimeType := DateTimeVisualizerTypes[I].DateTimeType;
      Break;
    end;
  end;

  if Lang = tlDelphi then
  begin
    if not FormatResult(EvalResult, DateTimeType, Result) then
      Result := EvalResult;
  end else if Lang = tlCpp then
  begin
    Result := EvalResult;
    if Supports(BorlandIDEServices, IOTADebuggerServices, DebugSvcs) then
      CurProcess := DebugSvcs.CurrentProcess;
    if CurProcess <> nil then
    begin
      CurThread := CurProcess.CurrentThread;
      if CurThread <> nil then
      begin
        EvalRes := CurThread.Evaluate(Expression+'.Val', @ResultStr, Length(ResultStr),
          CanModify, eseAll, '', ResultAddr, ResultSize, ResultVal, '', 0);
        if EvalRes = erOK then
        begin
          if FormatSettings.DecimalSeparator <> '.' then
          begin
            for I := 0 to Length(ResultStr) - 1 do
            begin
              if ResultStr[I] = '.' then
              begin
                ResultStr[I] := FormatSettings.DecimalSeparator;
                break;
              end;
            end;
          end;
          if not FormatResult(ResultStr, DateTimeType, Result) then
            Result := EvalResult;
        end else if EvalRes = erDeferred then
        begin
          FCompleted := False;
          FDeferredResult := '';
          FNotifierIndex := CurThread.AddNotifier(Self);
          while not FCompleted do
            DebugSvcs.ProcessDebugEvents;
          CurThread.RemoveNotifier(FNotifierIndex);
          FNotifierIndex := -1;
          if (FDeferredResult = '') or not FormatResult(FDeferredResult, DateTimeType, Result) then
            Result := EvalResult;
        end;
      end;
    end;
  end;
end;

function TDebuggerDateTimeVisualizer.GetSupportedTypeCount: Integer;
begin
  Result := Length(DateTimeVisualizerTypes);
end;

procedure TDebuggerDateTimeVisualizer.GetSupportedType(Index: Integer; var TypeName: string;
  var AllDescendants: Boolean);
begin
  AllDescendants := False;
  TypeName := DateTimeVisualizerTypes[Index].TypeName;
end;

function TDebuggerDateTimeVisualizer.GetVisualizerDescription: string;
begin
  Result := sDateTimeVisualizerDescription;
end;

function TDebuggerDateTimeVisualizer.GetVisualizerIdentifier: string;
begin
  Result := ClassName;
end;

function TDebuggerDateTimeVisualizer.GetVisualizerName: string;
begin
  Result := sDateTimeVisualizerName;
end;

var
  DateTimeVis: IOTADebuggerVisualizer;

procedure Register;
begin
  DateTimeVis := TDebuggerDateTimeVisualizer.Create;
  (BorlandIDEServices as IOTADebuggerServices).RegisterDebugVisualizer(DateTimeVis);
end;

procedure RemoveVisualizer;
var
  DebuggerServices: IOTADebuggerServices;
begin
  if Supports(BorlandIDEServices, IOTADebuggerServices, DebuggerServices) then
  begin
    DebuggerServices.UnregisterDebugVisualizer(DateTimeVis);
    DateTimeVis := nil;
  end;
end;

initialization
finalization
  RemoveVisualizer;
end.
