{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC streaming base classes             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Stan.Storage;

interface

uses
  System.SysUtils, System.Classes, System.TypInfo, System.Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Util,
    FireDAC.Stan.Factory;

type
  TFDStorage = class;

  TFDStorage = class(TFDObject)
  private
    FActions: TFDObjList;
    FLevel: Integer;
    FOwnStream: Boolean;
    FBuff: TMemoryStream;
    FResOpts: TFDBottomResourceOptions;
    FWorkFileName: String;
    FOriginalFileExt: String;
    FFilterObjs: TDictionary<TObject, TObject>;
    FLastEnumTypeInfo: PTypeInfo;
    FLastEnumValue: Integer;
    FLastEnumName: String;
    procedure ClearDeferredActions;
    procedure PerformDeferredActions;
  protected
    FStreamVersion: Integer;
    FMode: TFDStorageMode;
    FStream: TStream;
    FEncoder: TFDEncoder;
    FFormat: Boolean;
    // introduced
    function CheckBuffer(ASize: Cardinal): TMemoryStream;
    procedure Hex2BinStream(const AHex: String; AStream: TMemoryStream);
    function GetCachedEnumName(ATypeInfo: PTypeInfo; const AValue: Integer): String;
    // IFDStanStorage
    function GetMode: TFDStorageMode;
    function GetStreamVersion: Integer;
    function GetOwnStream: Boolean;
    procedure SetOwnStream(AValue: Boolean);
    procedure Open(AResOpts: TObject; AEncoder: TObject;
      const AFileName: String; AStream: TStream; AMode: TFDStorageMode); virtual;
    procedure Close; virtual;
    function IsOpen: Boolean; virtual;
    procedure LockDeferring;
    procedure UnLockDeferring;
    procedure DeferAction(const APropName, AValue: String; AAction: TFDStorageDeferredAction);
    function IsStored(AItem: TFDStoreItem): Boolean;
    function ReadObjectBegin(const AObjectName: String; AStyle: TFDStorageObjectStyle): String; virtual; abstract;
    procedure ReadObjectEnd(const AObjectName: String; AStyle: TFDStorageObjectStyle); virtual; abstract;
    function LoadObject: TObject;
    procedure SaveObject(AObject: TObject);
    procedure AddFilterObj(AKey, AFilter: TObject);
    procedure RemoveFilterObj(AKey: TObject);
    function GetFilterObj(AKey: TObject): TObject;
    function BeginGrowthEstimation: Int64;
    procedure EndGrowthEstimation(ABase: Int64; ATimes: Cardinal);
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

uses
  FireDAC.Stan.Consts;

{-------------------------------------------------------------------------------}
{ TFDStorage                                                                    }
{-------------------------------------------------------------------------------}
constructor TFDStorage.Create;
begin
  inherited Create;
  FStreamVersion := C_FD_StorageVer;
  FActions := TFDObjList.Create;
  FFilterObjs := TDictionary<TObject, TObject>.Create;
end;

{-------------------------------------------------------------------------------}
destructor TFDStorage.Destroy;
begin
  FDHighRefCounter(FRefCount);
  Close;
  FDFreeAndNil(FActions);
  FDFreeAndNil(FBuff);
  FDFreeAndNil(FFilterObjs);
  FResOpts := nil;
  FEncoder := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDStorage.GetMode: TFDStorageMode;
begin
  Result := FMode;
end;

{-------------------------------------------------------------------------------}
function TFDStorage.GetStreamVersion: Integer;
begin
  Result := FStreamVersion;
end;

{-------------------------------------------------------------------------------}
function TFDStorage.GetOwnStream: Boolean;
begin
  Result := FOwnStream;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.SetOwnStream(AValue: Boolean);
begin
  FOwnStream := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.Open(AResOpts: TObject; AEncoder: TObject;
  const AFileName: String; AStream: TStream; AMode: TFDStorageMode);
begin
  FResOpts := AResOpts as TFDBottomResourceOptions;
  FEncoder := AEncoder as TFDEncoder;
  ASSERT((AStream <> nil) or (AFileName <> '') or
         (FResOpts <> nil) and (FResOpts.PersistentFileName <> ''));
  FMode := AMode;
  if FMode = smWrite then
    if (FResOpts = nil) or (FResOpts.StoreVersion = -1) then
      FStreamVersion := C_FD_StorageVer
    else
      FStreamVersion := FResOpts.StoreVersion
  else
    FStreamVersion := C_FD_StorageVer;
  if FResOpts <> nil then
    FFormat := FResOpts.StorePrettyPrint
  else
    FFormat := False;
  if AStream = nil then begin
    if FResOpts <> nil then
      FWorkFileName := FResOpts.ResolveFileName(AFileName)
    else
      FWorkFileName := AFileName;
    if AMode = smWrite then begin
      if (FResOpts <> nil) and FResOpts.Backup then begin
        FOriginalFileExt := ExtractFileExt(FWorkFileName);
        FWorkFileName := ChangeFileExt(FWorkFileName, '.~~~');
      end;
      FStream := TBufferedFileStream.Create(FWorkFileName, fmCreate or fmShareExclusive);
    end
    else
      FStream := TBufferedFileStream.Create(FWorkFileName, fmOpenRead or fmShareDenyWrite);
    FOwnStream := True;
  end
  else begin
    FWorkFileName := '';
    FStream := AStream;
    FOwnStream := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.Close;
var
  sTargetFileName: String;
  sBackupFileName: String;
  lStreamed: Boolean;
begin
  ClearDeferredActions;
  lStreamed := FStream <> nil;
  if FOwnStream then
    FDFreeAndNil(FStream)
  else
    FStream := nil;
  if lStreamed and (FResOpts <> nil) and FResOpts.Backup and
     (FMode = smWrite) and (FWorkFileName <> '') then begin
    sTargetFileName := ChangeFileExt(FWorkFileName, FOriginalFileExt);
    if FileExists(sTargetFileName) then begin
      sBackupFileName := FWorkFileName;
      if FResOpts.BackupFolder <> '' then
        sBackupFileName := FDNormPath(FDExpandStr(FResOpts.BackupFolder)) +
          ExtractFileName(sBackupFileName);
      if FResOpts.BackupExt <> '' then
        sBackupFileName := ChangeFileExt(sBackupFileName, FResOpts.BackupExt)
      else
        sBackupFileName := ChangeFileExt(sBackupFileName, '.bak');
      if (sBackupFileName <> '') and
         (AnsiCompareText(ExpandFileName(sTargetFileName), ExpandFileName(sBackupFileName)) <> 0) then
        FDFileMove(sTargetFileName, sBackupFileName);
    end;
    if FileExists(FWorkFileName) then
      FDFileMove(FWorkFileName, sTargetFileName);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDStorage.IsOpen: Boolean;
begin
  Result := FStream <> nil;
end;

{-------------------------------------------------------------------------------}
function TFDStorage.LoadObject: TObject;
begin
  Result := FDStorageManager().LoadObject(Self as IFDStanStorage);
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.SaveObject(AObject: TObject);
begin
  FDStorageManager().SaveObject(AObject, Self as IFDStanStorage);
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.AddFilterObj(AKey, AFilter: TObject);
begin
  FFilterObjs.Add(AKey, AFilter);
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.RemoveFilterObj(AKey: TObject);
begin
  FFilterObjs.Remove(AKey);
end;

{-------------------------------------------------------------------------------}
function TFDStorage.GetFilterObj(AKey: TObject): TObject;
begin
  FFilterObjs.TryGetValue(AKey, Result);
end;

{-------------------------------------------------------------------------------}
type
  TDeferredAction = class(TObject)
  private
    FPropName: String;
    FValue: String;
    FAction: TFDStorageDeferredAction;
  end;

procedure TFDStorage.DeferAction(const APropName, AValue: String;
  AAction: TFDStorageDeferredAction);
var
  oAct: TDeferredAction;
begin
  if (APropName = '') or (AValue = '') or not Assigned(AAction) then
    Exit;
  oAct := TDeferredAction.Create;
  oAct.FPropName := APropName;
  oAct.FValue := AValue;
  oAct.FAction := AAction;
  FActions.Add(oAct);
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.PerformDeferredActions;
var
  i: Integer;
  oAct: TDeferredAction;
begin
  try
    for i := 0 to FActions.Count - 1 do begin
      oAct := TDeferredAction(FActions.Items[i]);
      oAct.FAction(oAct.FPropName, oAct.FValue);
    end;
  finally
    ClearDeferredActions;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.ClearDeferredActions;
var
  i: Integer;
begin
  for i := 0 to FActions.Count - 1 do
    FDFree(TDeferredAction(FActions.Items[i]));
  FActions.Clear;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.LockDeferring;
begin
  Inc(FLevel);
  if FLevel = 1 then
    ClearDeferredActions;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.UnLockDeferring;
begin
  Dec(FLevel);
  if FLevel = 0 then
    PerformDeferredActions;
end;

{-------------------------------------------------------------------------------}
function TFDStorage.CheckBuffer(ASize: Cardinal): TMemoryStream;
begin
  if FBuff = nil then
    FBuff := TMemoryStream.Create;
  if Cardinal(FBuff.Size) < ASize then
    FBuff.Size := ASize;
  Result := FBuff;
end;

{-------------------------------------------------------------------------------}
procedure TFDStorage.Hex2BinStream(const AHex: String; AStream: TMemoryStream);
{$IFDEF NEXTGEN}
var
  aBuff: TBytes;
{$ENDIF}
begin
{$IFDEF NEXTGEN}
  SetLength(aBuff, Length(AHex) div 2);
  HexToBin(BytesOf(AHex), 0, aBuff, 0, Length(aBuff));
  AStream.Size := 0;
  AStream.Write(aBuff, Length(aBuff));
{$ELSE}
  AStream.Size := Length(AHex) div 2;
  AStream.Position := 0;
  HexToBin(PChar(AHex), PAnsiChar(AStream.Memory), AStream.Size);
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDStorage.GetCachedEnumName(ATypeInfo: PTypeInfo;
  const AValue: Integer): String;
begin
  if (FLastEnumTypeInfo <> ATypeInfo) or (FLastEnumValue <> AValue) then begin
    FLastEnumTypeInfo := ATypeInfo;
    FLastEnumValue := AValue;
    FLastEnumName := GetEnumName(ATypeInfo, AValue);
  end;
  Result := FLastEnumName;
end;

{-------------------------------------------------------------------------------}
function TFDStorage.IsStored(AItem: TFDStoreItem): Boolean;
begin
  Result := (FResOpts = nil) or (AItem in FResOpts.StoreItems);
end;

{-------------------------------------------------------------------------------}
function TFDStorage.BeginGrowthEstimation: Int64;
begin
  Result := FStream.Size;
end;

{-------------------------------------------------------------------------------}
type
  __TMemoryStream = class(TMemoryStream);

procedure TFDStorage.EndGrowthEstimation(ABase: Int64; ATimes: Cardinal);
begin
  if (FStream is TMemoryStream) and ((FStream.Size - ABase) * ATimes > $2000 * 5) then
    __TMemoryStream(FStream).Capacity := ABase + (FStream.Size - ABase) * ATimes;
end;

end.
