{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{          FireDAC SQL Server Call Interface            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.MSSQLCli;

interface

{$IFDEF MSWINDOWS}
uses
  Winapi.Windows;
{$ENDIF}

const
  SQL_FILESTREAM_READ        = 0;
  SQL_FILESTREAM_WRITE       = 1;
  SQL_FILESTREAM_READWRITE   = 2;

  SQL_FILESTREAM_OPEN_NONE                  = $00000000;
  SQL_FILESTREAM_OPEN_FLAG_ASYNC            = $00000001;
  SQL_FILESTREAM_OPEN_FLAG_NO_BUFFERING     = $00000002;
  SQL_FILESTREAM_OPEN_FLAG_NO_WRITE_THROUGH = $00000004;
  SQL_FILESTREAM_OPEN_FLAG_SEQUENTIAL_SCAN  = $00000008;
  SQL_FILESTREAM_OPEN_FLAG_RANDOM_ACCESS    = $00000010;

{$IFDEF MSWINDOWS}
  FSCTL_SQL_FILESTREAM_FETCH_OLD_CONTENT =
    (FILE_DEVICE_FILE_SYSTEM shl 16) or (FILE_ANY_ACCESS shl 14) or (2392 shl 2) or (METHOD_BUFFERED);
{$ENDIF}

type
  TMSSQLOpenSqlFilestream = function (
    FilestreamPath: PWideChar;
    DesiredAccess: LongWord;
    OpenOptions: LongWord;
    FilestreamTransactionContext: PByte;
    FilestreamTransactionContextLength: {$IFDEF FireDAC_64} UInt64 {$ELSE} LongWord {$ENDIF};
    AllocationSize: PInt64): THandle; stdcall;

implementation

end.
