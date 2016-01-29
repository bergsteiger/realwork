{ ********************************************************************* }
{                                                                       }
{                          Gnostice Logger                              }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit gtLogger;

{$I ..\Utils\gtCompilerDefines.inc}

interface

uses
  Classes ,SysUtils;

type

  TgtLogger = class(TObject)
  private
   { private declarations }
    {$IFDEF DEBUG}
    FFileStream: TFileStream;
    {$ENDIF}
    FFileName: Ansistring;
    procedure SetFileName(AFileName: AnsiString);
  public
   { public declarations }
    constructor Create;
    destructor Destroy; override;
    procedure LogInfo(AInfo: AnsiString); overload;
    procedure LogInfo(AInfo: AnsiString; Args: array of const); overload;
    procedure LogError(AError: AnsiString); overload;
    procedure LogError(AError: AnsiString; Args: array of const); overload;
    procedure Log(AInfo: AnsiString); overload;
    procedure Log(AInfo: AnsiString; Args: array of const); overload;

    property FileName: AnsiString read FFileName write SetFileName;
  end;

var
  Logger: TgtLogger;

implementation

{ TgtLogger }

constructor TgtLogger.Create;
begin

end;

destructor TgtLogger.Destroy;
begin
{$IFDEF DEBUG}
  if Assigned(FFileStream) then FFileStream.Free;
{$ENDIF}
  inherited;
end;

procedure TgtLogger.Log(AInfo: AnsiString);
begin
{$IFDEF DEBUG}
  if not Assigned(FFileStream) then
    SetFileName('Gnostice.log');

  AInfo := #13#10 + AInfo;
  FFileStream.Write(AInfo[1], Length(AInfo));
{$ENDIF}
end;

procedure TgtLogger.LogError(AError: AnsiString);
begin
{$IFDEF DEBUG}
  if not Assigned(FFileStream) then
    SetFileName('Gnostice.log');

  AError := #13#10 + 'ERROR: ' + AError;
  FFileStream.Write(AError[1], Length(AError));
{$ENDIF}
end;

procedure TgtLogger.Log(AInfo: AnsiString; Args: array of const);
{$IFDEF DEBUG}
var
  LLogInfo: AnsiString;
{$ENDIF}
begin
{$IFDEF DEBUG}
  LLogInfo := Format(AInfo, Args);
  FFileStream.Write(LLogInfo[1], Length(LLogInfo));
{$ENDIF}
end;

procedure TgtLogger.LogError(AError: AnsiString; Args: array of const);
{$IFDEF DEBUG}
var
  LLogInfo: AnsiString;
{$ENDIF}
begin
{$IFDEF DEBUG}
  if not Assigned(FFileStream) then
    SetFileName('Gnostice.log');

  LLogInfo := '';
  AError := #13#10 + 'ERROR: ' + AError;
  LLogInfo := Format(AError, Args);
  FFileStream.Write(LLogInfo[1], Length(LLogInfo));
{$ENDIF}
end;

procedure TgtLogger.LogInfo(AInfo: AnsiString; Args: array of const);
{$IFDEF DEBUG}
var
  LLogInfo: AnsiString;
{$ENDIF}
begin
{$IFDEF DEBUG}
  if not Assigned(FFileStream) then
    SetFileName('Gnostice.log');

  AInfo := #13#10 + 'INFO: ' + AInfo;
  LLogInfo := Format(AInfo, Args);
  FFileStream.Write(LLogInfo[1], Length(LLogInfo));
{$ENDIF}
end;

procedure TgtLogger.LogInfo(AInfo: AnsiString);
begin
{$IFDEF DEBUG}
  if not Assigned(FFileStream) then
    SetFileName('Gnostice.log');

  AInfo := #13#10 + 'INFO: ' + AInfo;
  FFileStream.Write(AInfo[1], Length(AInfo));
{$ENDIF}
end;

procedure TgtLogger.SetFileName(AFileName: AnsiString);
{$IFDEF DEBUG}
var
  LDateTime: TDateTime;
  LLogInfo, LDate, LTime: AnsiString;
{$ENDIF}
begin
{$IFDEF DEBUG}
  LLogInfo := '';
  FFileName := AFileName;

  if FileExists(AFileName) then
  begin
    FFileStream := TFileStream.Create(AFileName, fmOpenWrite + fmShareExclusive);
    FFileStream.Position := FFileStream.Size;
  end
  else
  begin
    FFileStream := TFileStream.Create(AFileName, fmCreate);
    FFileStream.Position := 0;
  end;

  LDateTime := Now;
  LDate := DateToStr(LDateTime);
  LTime := TimeToStr(LDateTime);
  Log(#13#10 + '********************');
  Log(#13#10 + 'Log file create...' + #13#10 + 'Date: %s', [LDate]);
  Log(#13#10 + 'Time: %s', [LTime]);
  Log('********************');
  Log(LLogInfo);
{$ENDIF}
end;

initialization
{$IFDEF DEBUG}
  begin
    Logger := TgtLogger.Create;
  end;
{$ENDIF}

finalization
{$IFDEF DEBUG}
  begin
    if Assigned(Logger) then
      Logger.Free;
  end;
{$ENDIF}
end.
