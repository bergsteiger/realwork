unit atLogger;

// Модуль: "w:\quality\test\garant6x\AdapterTest\CoreObjects\atLogger.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "atLogger" MUID: (4808B6A20344)

interface

uses
 l3IntfUses
 , atInterfaces
 , Windows
 , SyncObjs
 , SysUtils
;

type
 PFormatSettings = ^TFormatSettings;

 TatLogMessageType = (
  lmtNone
  , lmtInfo
  , lmtWarning
  , lmtError
  , lmtException
 );//TatLogMessageType

 TatLogger = class(TInterfacedObject, IatLogger)
  private
   f_TlsIndex: DWORD;
   f_CS: TCriticalSection;
  private
   function GetFormatSettings: PFormatSettings; virtual;
  protected
   procedure WriteMessage(const formattedMsg: AnsiString); virtual; abstract;
   procedure AddMessage(msgType: TatLogMessageType;
    const msg: AnsiString);
   function Info(const msg: AnsiString): AnsiString; overload;
   function Warning(const msg: AnsiString): AnsiString; overload;
   function Error(const msg: AnsiString): AnsiString; overload;
   procedure Exception(ex: Exception;
    const prefix: AnsiString = '');
   function Info(const aFormat: AnsiString;
    const anArgs: array of const): AnsiString; overload;
   function Warning(const aFormat: AnsiString;
    const anArgs: array of const): AnsiString; overload;
   function Error(const aFormat: AnsiString;
    const anArgs: array of const): AnsiString; overload;
  public
   constructor Create; reintroduce;
   destructor Destroy; override;
 end;//TatLogger

 TatLoggerStub = class(TInterfacedObject, IatLogger)
  protected
   function Info(const msg: AnsiString): AnsiString; overload;
   function Warning(const msg: AnsiString): AnsiString; overload;
   function Error(const msg: AnsiString): AnsiString; overload;
   procedure Exception(ex: Exception;
    const prefix: AnsiString = '');
   function Info(const aFormat: AnsiString;
    const anArgs: array of const): AnsiString; overload;
   function Warning(const aFormat: AnsiString;
    const anArgs: array of const): AnsiString; overload;
   function Error(const aFormat: AnsiString;
    const anArgs: array of const): AnsiString; overload;
 end;//TatLoggerStub

 TatConsoleLogger = class(TatLogger)
  protected
   procedure WriteMessage(const formattedMsg: AnsiString); override;
 end;//TatConsoleLogger

 TatFileLogger = class(TatLogger)
  private
   f_File: Text;
  protected
   procedure WriteMessage(const formattedMsg: AnsiString); override;
  public
   constructor Create(const fileName: AnsiString); reintroduce;
   destructor Destroy; override;
 end;//TatFileLogger

var Logger: IatLogger;
var DbgLogger: IatLogger;

implementation

uses
 l3ImplUses
;

procedure TatLogger.AddMessage(msgType: TatLogMessageType;
 const msg: AnsiString);
//#UC START# *4808B7CF01A2_4808A17901C6_var*
  type
    TatLogMessageHeaders = array[TatLogMessageType] of string;
  const
    LogMessageHeaders : TatLogMessageHeaders = ('', 'INFO', 'WARNING', 'ERROR', 'EXCEPTION');
  var
    strToAdd : String;
    dateTime : String;
//#UC END# *4808B7CF01A2_4808A17901C6_var*
begin
//#UC START# *4808B7CF01A2_4808A17901C6_impl*
  case msgType of
    lmtInfo, lmtWarning, lmtError, lmtException :
      begin
        // создаем строку для записи
        DateTimeToString(dateTime, 'dd-mm-yyyy hh:nn:ss.zzz', Now, GetFormatSettings^);
        strToAdd := dateTime + ' | ' + IntToStr(GetCurrentThreadId) + ' | ' + LogMessageHeaders[msgType] + ': ' + msg;
      end;
    lmtNone : Exit; // нет сообщения
  end;
  // пишем
  f_CS.Acquire;
  try
    WriteMessage(strToAdd);
  finally
    f_CS.Leave;
  end;  
//#UC END# *4808B7CF01A2_4808A17901C6_impl*
end;//TatLogger.AddMessage

constructor TatLogger.Create;
//#UC START# *4808B8250055_4808A17901C6_var*
//#UC END# *4808B8250055_4808A17901C6_var*
begin
//#UC START# *4808B8250055_4808A17901C6_impl*
  inherited;
  //
  f_TlsIndex := TlsAlloc;
  if f_TlsIndex = $FFFFFFFF then
    Raise SysUtils.Exception.Create('Can not allocate tls index!');
  f_CS := TCriticalSection.Create;
//#UC END# *4808B8250055_4808A17901C6_impl*
end;//TatLogger.Create

function TatLogger.GetFormatSettings: PFormatSettings;
//#UC START# *5076D63901B2_4808A17901C6_var*
//#UC END# *5076D63901B2_4808A17901C6_var*
begin
//#UC START# *5076D63901B2_4808A17901C6_impl*
  Result := TlsGetValue(f_TlsIndex);
  if Result = nil then
    if GetLastError = NO_ERROR then
    begin
      New(Result); // это вызовется для каждого вошедшего сюда потока, а освобождать негде, поэтому будет утечка
      GetLocaleFormatSettings(SysLocale.DefaultLCID, Result^);
      TlsSetValue(f_TlsIndex, Result);
    end
    else
      Raise SysUtils.Exception.Create('Can not get valid tls value!');
//#UC END# *5076D63901B2_4808A17901C6_impl*
end;//TatLogger.GetFormatSettings

function TatLogger.Info(const msg: AnsiString): AnsiString;
//#UC START# *4808B42B0093_4808A17901C6_var*
//#UC END# *4808B42B0093_4808A17901C6_var*
begin
//#UC START# *4808B42B0093_4808A17901C6_impl*
  AddMessage(lmtInfo, msg);
  Result := msg;
//#UC END# *4808B42B0093_4808A17901C6_impl*
end;//TatLogger.Info

function TatLogger.Warning(const msg: AnsiString): AnsiString;
//#UC START# *4808B44F022E_4808A17901C6_var*
//#UC END# *4808B44F022E_4808A17901C6_var*
begin
//#UC START# *4808B44F022E_4808A17901C6_impl*
  AddMessage(lmtWarning, msg);
  Result := msg;
//#UC END# *4808B44F022E_4808A17901C6_impl*
end;//TatLogger.Warning

function TatLogger.Error(const msg: AnsiString): AnsiString;
//#UC START# *4808B45F00DA_4808A17901C6_var*
//#UC END# *4808B45F00DA_4808A17901C6_var*
begin
//#UC START# *4808B45F00DA_4808A17901C6_impl*
  AddMessage(lmtError, msg);
  Result := msg;
//#UC END# *4808B45F00DA_4808A17901C6_impl*
end;//TatLogger.Error

procedure TatLogger.Exception(ex: Exception;
 const prefix: AnsiString = '');
//#UC START# *4808B46D01DF_4808A17901C6_var*
  var
   l_P : String;
//#UC END# *4808B46D01DF_4808A17901C6_var*
begin
//#UC START# *4808B46D01DF_4808A17901C6_impl*
  l_P := prefix;
  if Length(l_P) > 0 then l_P := l_P + ' ';
  AddMessage(
    lmtException,
    l_P + 'Class: "' + ex.ClassName + '"; Message: "' + ex.Message + '"'
  );
//#UC END# *4808B46D01DF_4808A17901C6_impl*
end;//TatLogger.Exception

function TatLogger.Info(const aFormat: AnsiString;
 const anArgs: array of const): AnsiString;
//#UC START# *484A74A700FD_4808A17901C6_var*
//#UC END# *484A74A700FD_4808A17901C6_var*
begin
//#UC START# *484A74A700FD_4808A17901C6_impl*
  Result := Info( Format(aFormat, anArgs, GetFormatSettings^) );
//#UC END# *484A74A700FD_4808A17901C6_impl*
end;//TatLogger.Info

function TatLogger.Warning(const aFormat: AnsiString;
 const anArgs: array of const): AnsiString;
//#UC START# *484A76C6037D_4808A17901C6_var*
//#UC END# *484A76C6037D_4808A17901C6_var*
begin
//#UC START# *484A76C6037D_4808A17901C6_impl*
  Result := Warning( Format(aFormat, anArgs, GetFormatSettings^) );
//#UC END# *484A76C6037D_4808A17901C6_impl*
end;//TatLogger.Warning

function TatLogger.Error(const aFormat: AnsiString;
 const anArgs: array of const): AnsiString;
//#UC START# *484A76ED00FD_4808A17901C6_var*
//#UC END# *484A76ED00FD_4808A17901C6_var*
begin
//#UC START# *484A76ED00FD_4808A17901C6_impl*
  Result := Error( Format(aFormat, anArgs, GetFormatSettings^) );
//#UC END# *484A76ED00FD_4808A17901C6_impl*
end;//TatLogger.Error

destructor TatLogger.Destroy;
//#UC START# *48077504027E_4808A17901C6_var*
//#UC END# *48077504027E_4808A17901C6_var*
begin
//#UC START# *48077504027E_4808A17901C6_impl*
  TlsFree(f_TlsIndex);
  FreeAndNil(f_CS);
  //
  inherited;
//#UC END# *48077504027E_4808A17901C6_impl*
end;//TatLogger.Destroy

function TatLoggerStub.Info(const msg: AnsiString): AnsiString;
//#UC START# *4808B42B0093_4808BAD201EB_var*
//#UC END# *4808B42B0093_4808BAD201EB_var*
begin
//#UC START# *4808B42B0093_4808BAD201EB_impl*
 // это заглушка
//#UC END# *4808B42B0093_4808BAD201EB_impl*
end;//TatLoggerStub.Info

function TatLoggerStub.Warning(const msg: AnsiString): AnsiString;
//#UC START# *4808B44F022E_4808BAD201EB_var*
//#UC END# *4808B44F022E_4808BAD201EB_var*
begin
//#UC START# *4808B44F022E_4808BAD201EB_impl*
 // это заглушка
//#UC END# *4808B44F022E_4808BAD201EB_impl*
end;//TatLoggerStub.Warning

function TatLoggerStub.Error(const msg: AnsiString): AnsiString;
//#UC START# *4808B45F00DA_4808BAD201EB_var*
//#UC END# *4808B45F00DA_4808BAD201EB_var*
begin
//#UC START# *4808B45F00DA_4808BAD201EB_impl*
 // это заглушка
//#UC END# *4808B45F00DA_4808BAD201EB_impl*
end;//TatLoggerStub.Error

procedure TatLoggerStub.Exception(ex: Exception;
 const prefix: AnsiString = '');
//#UC START# *4808B46D01DF_4808BAD201EB_var*
//#UC END# *4808B46D01DF_4808BAD201EB_var*
begin
//#UC START# *4808B46D01DF_4808BAD201EB_impl*
 // это заглушка
//#UC END# *4808B46D01DF_4808BAD201EB_impl*
end;//TatLoggerStub.Exception

function TatLoggerStub.Info(const aFormat: AnsiString;
 const anArgs: array of const): AnsiString;
//#UC START# *484A74A700FD_4808BAD201EB_var*
//#UC END# *484A74A700FD_4808BAD201EB_var*
begin
//#UC START# *484A74A700FD_4808BAD201EB_impl*
 // это заглушка
//#UC END# *484A74A700FD_4808BAD201EB_impl*
end;//TatLoggerStub.Info

function TatLoggerStub.Warning(const aFormat: AnsiString;
 const anArgs: array of const): AnsiString;
//#UC START# *484A76C6037D_4808BAD201EB_var*
//#UC END# *484A76C6037D_4808BAD201EB_var*
begin
//#UC START# *484A76C6037D_4808BAD201EB_impl*
 // это заглушка
//#UC END# *484A76C6037D_4808BAD201EB_impl*
end;//TatLoggerStub.Warning

function TatLoggerStub.Error(const aFormat: AnsiString;
 const anArgs: array of const): AnsiString;
//#UC START# *484A76ED00FD_4808BAD201EB_var*
//#UC END# *484A76ED00FD_4808BAD201EB_var*
begin
//#UC START# *484A76ED00FD_4808BAD201EB_impl*
 // это заглушка
//#UC END# *484A76ED00FD_4808BAD201EB_impl*
end;//TatLoggerStub.Error

procedure TatConsoleLogger.WriteMessage(const formattedMsg: AnsiString);
//#UC START# *4808B7840086_4808BB4F028A_var*
  var
    tmpStr : String;
//#UC END# *4808B7840086_4808BB4F028A_var*
begin
//#UC START# *4808B7840086_4808BB4F028A_impl*
  SetLength(tmpStr, Length(formattedMsg) + 1);
  UniqueString(tmpStr);
  CharToOem(PAnsiChar(formattedMsg), PAnsiChar(tmpStr));
  WriteLn(tmpStr);
//#UC END# *4808B7840086_4808BB4F028A_impl*
end;//TatConsoleLogger.WriteMessage

constructor TatFileLogger.Create(const fileName: AnsiString);
//#UC START# *4808BC73011C_4808BC490355_var*
//#UC END# *4808BC73011C_4808BC490355_var*
begin
//#UC START# *4808BC73011C_4808BC490355_impl*
  inherited Create;
  //
  AssignFile(f_File, fileName);
  if FileExists(fileName) then
    Append(f_File)
  else
    Rewrite(f_File);
  WriteLn(f_File, '');
//#UC END# *4808BC73011C_4808BC490355_impl*
end;//TatFileLogger.Create

procedure TatFileLogger.WriteMessage(const formattedMsg: AnsiString);
//#UC START# *4808B7840086_4808BC490355_var*
//#UC END# *4808B7840086_4808BC490355_var*
begin
//#UC START# *4808B7840086_4808BC490355_impl*
  WriteLn(f_File, formattedMsg);
  Flush(f_File);
//#UC END# *4808B7840086_4808BC490355_impl*
end;//TatFileLogger.WriteMessage

destructor TatFileLogger.Destroy;
//#UC START# *48077504027E_4808BC490355_var*
//#UC END# *48077504027E_4808BC490355_var*
begin
//#UC START# *48077504027E_4808BC490355_impl*
  CloseFile(f_File);
  //
  inherited;
//#UC END# *48077504027E_4808BC490355_impl*
end;//TatFileLogger.Destroy

initialization
//#UC START# *4808BA9401C5*
  Logger := TatConsoleLogger.Create;
  DbgLogger := TatLoggerStub.Create;
//#UC END# *4808BA9401C5*

finalization
//#UC START# *4808BAA1027F*
  Logger := nil;
  DbgLogger := nil;
//#UC END# *4808BAA1027F*

end.
