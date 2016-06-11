{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Platform.SaveState.iOS;

interface

{$SCOPEDENUMS ON}

uses
  System.Classes, FMX.Platform;

type

  /// <summary>Implements <c>IFMXSaveStateService</c></summary>
  TCocoaTouchSaveStateService = class(TInterfacedObject, IFMXSaveStateService)
  private
    FSaveStateStoragePath: string;
  protected
    procedure RegisterService; virtual;
    procedure UnregisterService; virtual;
  public
    constructor Create;
    destructor Destroy; override;
    { IFMXSaveStateService }
    function GetSaveStateFileName(const ABlockName: string): string;
    function GetBlock(const ABlockName: string; const ABlockData: TStream): Boolean;
    function SetBlock(const ABlockName: string; const ABlockData: TStream): Boolean;
    function GetStoragePath: string;
    procedure SetStoragePath(const ANewPath: string);
    function GetNotifications: Boolean;
  end;

implementation

uses
  System.SysUtils, System.IOUtils;

function TCocoaTouchSaveStateService.GetSaveStateFileName(const ABlockName: string): string;
const
  Separator = '_';
var
  S: TStringBuilder;
  FilePath: string;
begin
  if FSaveStateStoragePath.IsEmpty then
    FilePath := IncludeTrailingPathDelimiter(TPath.GetTempPath)
  else
    FilePath := FSaveStateStoragePath;
  S := TStringBuilder.Create(FilePath.Length + Length(Separator) + ABlockName.Length);
  try
    S.Append(FilePath);
    S.Append(ChangeFileExt(ExtractFileName(ParamStr(0)), ''));
    S.Append(Separator);
    S.Append(ABlockName);
    Result := S.ToString;
  finally
    S.Free;
  end;
end;

constructor TCocoaTouchSaveStateService.Create;
begin
  inherited;
  RegisterService;
end;

destructor TCocoaTouchSaveStateService.Destroy;
begin
  UnregisterService;
  inherited;
end;

function TCocoaTouchSaveStateService.GetBlock(const ABlockName: string; const ABlockData: TStream): Boolean;

  procedure ReadPersistent(const AFileName: string);
  var
    S: TFileStream;
  begin
    S := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
    try
      ABlockData.CopyFrom(S, S.Size);
    finally
      S.Free;
    end;
  end;

var
  LFileName: string;
begin
  if ABlockName.IsEmpty or (ABlockData = nil) then
    Exit(False);
  LFileName := GetSaveStateFileName(ABlockName);
  if not TFile.Exists(LFileName) then
    Exit(False);
  try
    ReadPersistent(LFileName);
  except
    Exit(False);
  end;
  Result := True;
end;

function TCocoaTouchSaveStateService.SetBlock(const ABlockName: string; const ABlockData: TStream): Boolean;

  procedure WritePersistent(const AFileName: string);
  var
    S: TFileStream;
  begin
    S := TFileStream.Create(AFileName, fmCreate or fmShareExclusive);
    try
      ABlockData.Seek(0, TSeekOrigin.soBeginning);
      S.CopyFrom(ABlockData, ABlockData.Size);
    finally
      S.Free;
    end;
  end;

var
  LFileName: string;
begin
  if ABlockName.IsEmpty then
    Exit(False);
  LFileName := GetSaveStateFileName(ABlockName);
  if (ABlockData = nil) or (ABlockData.Size < 1) then
  begin
    if TFile.Exists(LFileName) then
      TFile.Delete(LFileName);
  end
  else
    try
      WritePersistent(LFileName);
    except
      Exit(False);
    end;
  Result := True;
end;

function TCocoaTouchSaveStateService.GetStoragePath: string;
begin
  Result := FSaveStateStoragePath;
end;

procedure TCocoaTouchSaveStateService.RegisterService;
begin
  if not TPlatformServices.Current.SupportsPlatformService(IFMXSaveStateService) then
    TPlatformServices.Current.AddPlatformService(IFMXSaveStateService, Self);
end;

procedure TCocoaTouchSaveStateService.SetStoragePath(const ANewPath: string);
begin
  if not ANewPath.IsEmpty then
    FSaveStateStoragePath := IncludeTrailingPathDelimiter(ANewPath)
  else
    FSaveStateStoragePath := '';
end;

procedure TCocoaTouchSaveStateService.UnregisterService;
begin
  TPlatformServices.Current.RemovePlatformService(IFMXSaveStateService);
end;

function TCocoaTouchSaveStateService.GetNotifications: Boolean;
begin
  Result := True;
end;

end.
