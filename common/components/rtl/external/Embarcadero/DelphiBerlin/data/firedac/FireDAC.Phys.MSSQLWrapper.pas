{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{       FireDAC SQL Server API wrapping classes         }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.MSSQLWrapper;

interface

uses
  System.Classes,
  FireDAC.Stan.Error, FireDAC.Stan.Util, FireDAC.Stan.Intf,
  FireDAC.Phys.MSSQLCli;

type
  TMSSQLToolLib = class(TFDLibrary)
  protected
    procedure LoadEntries; override;
  public
    OpenSqlFilestream: TMSSQLOpenSqlFilestream;
    constructor Create(AOwningObj: TObject = nil);
    procedure Load(const AODBCDrvLib: String);
  end;

  TMSSQLFileStream = class(THandleStream)
  private
    FOwningObj: TObject;
  public
    constructor Create(ALib: TMSSQLToolLib; const ABlobPath: String;
      const AToken: TFDByteString; AMode: TFDStreamMode;
      AOptions: LongWord; AOwningObj: TObject); overload;
    destructor Destroy; override;
    property OwningObj: TObject read FOwningObj;
  end;

implementation

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
{$IFDEF POSIX}
  // Preventing from "Inline has not been expanded"
  Posix.Unistd,
{$ENDIF}
  System.SysUtils,
  FireDAC.Stan.Consts;

{-------------------------------------------------------------------------------}
{ TMSSQLToolLib                                                                 }
{-------------------------------------------------------------------------------}
constructor TMSSQLToolLib.Create(AOwningObj: TObject);
begin
  inherited Create(S_FD_MSSQLId, AOwningObj);
end;

{-------------------------------------------------------------------------------}
procedure TMSSQLToolLib.Load(const AODBCDrvLib: String);
begin
  inherited Load([AODBCDrvLib], False);
end;

{-------------------------------------------------------------------------------}
procedure TMSSQLToolLib.LoadEntries;
begin
  @OpenSqlFilestream := GetProc('OpenSqlFilestream');
end;

{-------------------------------------------------------------------------------}
{ TMSSQLFileStream                                                              }
{-------------------------------------------------------------------------------}
constructor TMSSQLFileStream.Create(ALib: TMSSQLToolLib; const ABlobPath: String;
  const AToken: TFDByteString; AMode: TFDStreamMode; AOptions: LongWord;
  AOwningObj: TObject);

  procedure Error;
  begin
    FDException(Self, [S_FD_LPhys, S_FD_MSSQLId], er_FD_MSSQLFSIOError,
      [FDLastSystemErrorMsg]);
  end;

var
  iAccess: LongWord;
{$IFDEF MSWINDOWS}
  iBytesReturned: DWORD;
{$ENDIF}
begin
  case AMode of
  smOpenRead:      iAccess := SQL_FILESTREAM_READ;
  smOpenWrite:     iAccess := SQL_FILESTREAM_WRITE;
  smOpenReadWrite: iAccess := SQL_FILESTREAM_READWRITE;
  else             iAccess := SQL_FILESTREAM_READ;
  end;
  inherited Create(ALib.OpenSqlFilestream(PWideChar(ABlobPath), iAccess,
    AOptions, PByte(AToken), Length(AToken), nil));
  FOwningObj := AOwningObj;
  if Handle = INVALID_HANDLE_VALUE then
    Error;
{$IFDEF MSWINDOWS}
  // https://msdn.microsoft.com/en-us/library/cc627407(v=sql.100).aspx
  if iAccess = SQL_FILESTREAM_READWRITE then
    if not DeviceIoControl(Handle, FSCTL_SQL_FILESTREAM_FETCH_OLD_CONTENT,
                           nil, 0, nil, 0, iBytesReturned, nil) then
      Error;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
destructor TMSSQLFileStream.Destroy;
begin
  if FHandle <> INVALID_HANDLE_VALUE then
    FileClose(FHandle);
  inherited Destroy;
end;

end.
