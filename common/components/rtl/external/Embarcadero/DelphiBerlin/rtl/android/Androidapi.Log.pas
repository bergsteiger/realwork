{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Androidapi.Log;

interface

(*$HPPEMIT '#include <android/log.h>' *)

{$I Androidapi.inc}

type
  android_LogPriority = (
    ANDROID_LOG_UNKNOWN,
    ANDROID_LOG_DEFAULT,
    ANDROID_LOG_VERBOSE,
    ANDROID_LOG_DEBUG,
    ANDROID_LOG_INFO,
    ANDROID_LOG_WARN,
    ANDROID_LOG_ERROR,
    ANDROID_LOG_FATAL,
    ANDROID_LOG_SILENT
 );
 {$EXTERNALSYM android_LogPriority}


function __android_log_write(Priority: android_LogPriority; const Tag, Text: MarshaledAString): Integer; cdecl;
  external AndroidLogLib name '__android_log_write';
 {$EXTERNALSYM android_LogPriority}

{ Helper functions }
function LOGI(Text: MarshaledAString): Integer;
function LOGW(Text: MarshaledAString): Integer;
function LOGE(Text: MarshaledAString): Integer;
function LOGF(Text: MarshaledAString): Integer;

implementation

function LOGI(Text: MarshaledAString): Integer;
begin
  Result := __android_log_write(android_LogPriority.ANDROID_LOG_INFO, 'info', Text);
end;

function LOGW(Text: MarshaledAString): Integer;
begin
  Result := __android_log_write(android_LogPriority.ANDROID_LOG_WARN, 'warning', Text);
end;

function LOGE(Text: MarshaledAString): Integer;
begin
  Result := __android_log_write(android_LogPriority.ANDROID_LOG_ERROR, 'error', Text);
end;

function LOGF(Text: MarshaledAString): Integer;
begin
  Result := __android_log_write(android_LogPriority.ANDROID_LOG_FATAL, 'fatal', Text);
end;

end.
