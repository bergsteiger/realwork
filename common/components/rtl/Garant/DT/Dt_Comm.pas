unit Dt_Comm;
 !Этот модуль устарел. Не использовать его!
{ Запрос-получение данных между приложениями с использованием сокетов. }

{ $Id: Dt_Comm.pas,v 1.7 2005/06/23 11:32:18 step Exp $ }
// $Log: Dt_Comm.pas,v $
// Revision 1.7  2005/06/23 11:32:18  step
// модуль устарел
//
// Revision 1.6  2005/06/03 13:56:37  step
// временно вернем модуль обратно
//
// Revision 1.5  2005/06/03 13:16:49  step
// отказ от использования dt_Comm
//
// Revision 1.4  2005/05/12 10:32:54  step
// чистка
//
// Revision 1.3  2005/05/12 10:27:11  step
// добавлен новый тип запроса - время на сервере
//
// Revision 1.2  2005/05/11 15:05:05  step
// TFilesQueryExecutor удаляет файлы с диска после их отправки
//
// Revision 1.1  2005/05/06 16:31:37  step
// Занесено в CVS
//

interface

uses
 Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
 Dialogs, StdCtrls, ScktComp,
 l3Base;

const
 c_CommServerPort = 4507;
 
type
 TCommHeader = (chNone           =   0,
                chReplyResult    =   1,
                chReplyError     =   2,

                chQueryInteger   =  50,
                chQueryFiles     = 100,
                chQueryTime      = 101);

 TCommCommand = (ccNone     = 0,
                 ccMsgBegin = 1,
                 ccMsgData  = 2,
                 ccMsgEnd   = 3);

 TCommAgent = class(Tl3Base)
 private
  f_Socket: TCustomWinSocket;
  f_SocketTimeOut: Longint;
  f_Stream: TWinSocketStream;
  function SocketStream: TWinSocketStream;
 protected
  procedure Cleanup; override;

  function WriteData(const aBuffer; aBufferSize: Integer): Integer;
  function ReadData(out aBuffer; aBufferSize: Integer): Integer;
 public
  constructor Create(aSocket: TCustomWinSocket; aTimeOut: Longint); reintroduce;

  function SendData(const aData; aDataSize: Integer): Boolean;
  function RecvData(out aData; aDataSize: Integer): Boolean;

  function SendCommand(const aCommand: TCommCommand): Boolean;
  function RecvCommand: TCommCommand;

  function SendHeader(const aHeader: TCommHeader): Boolean;
  function RecvHeader: TCommHeader;

  function SendInteger(const aInt: Integer): Boolean;
  function RecvInteger(out aInt: Integer): Boolean;

  function SendDouble(const aDbl: Double): Boolean;
  function RecvDouble(out aDbl: Double): Boolean;

  function SendString(const aStr: string): Boolean;
  function RecvString(out aStr: string): Boolean;

  function SendStream(aSrcStream: TStream): Boolean;
  function RecvStream(aDstStream: TStream): Boolean;
 end;

 TCommServer = class(Tl3Base)
 private
  f_ServerSocket: TServerSocket;

  function GetActive: Boolean;
  procedure SetActive(const aValue: Boolean);
  procedure BuildThread(aSender: TObject;
                        aClientSocket: TServerClientWinSocket;
                        var aSocketThread: TServerClientThread);
 protected
  procedure Cleanup; override;
 public
  constructor Create(aPort: Integer; aThreadCacheSize: Integer = 10); reintroduce;
  property Active: Boolean read GetActive write SetActive;
 end;

 TCommClient = class(Tl3Base)
 private
  f_ClientSocket: TClientSocket;
  f_Agent: TCommAgent;

  function GetActive: Boolean;
  procedure SetActive(const aValue: Boolean);
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aServerAddress: string; aServerPort: Integer); reintroduce;
  property Active: Boolean read GetActive write SetActive;
 end;

 TFilesCommClient = class(TCommClient)
 public
  function QueryFiles(const aServerFilesDir, aLocalDir: string): Boolean;
 end;

 // в качестве примера
 TIntegerCommClient = class(TCommClient)
 public
  function QueryInteger(out aInt: Integer): Boolean;
 end;

 TTimeCommClient = class(TCommClient)
 public
  function QueryServerTime(out aTime: TDateTime): Boolean;
 end;

implementation

uses
 l3FileUtils, l3Stream, l3Types,
 Math;

const
 c_WaitForClientTimeOut = 60000; // миллисек.
 c_WaitForServerTimeout = 60000; // миллисек.

type
 TCommTask = class(TServerClientThread)
 private
  f_Agent: TCommAgent;
  function ExecQuery(const aHeader: TCommHeader): Boolean;
 protected
  procedure ClientExecute; override;
  property Agent: TCommAgent read f_Agent;
 end;

 TQueryExecutor = class(Tl3Base)
 protected
  f_Task: TCommTask;
 public
  constructor Create(aTask: TCommTask); reintroduce;
  function Run: Boolean; virtual; abstract;
 end;

 TFilesQueryExecutor = class(TQueryExecutor)
 protected
  f_ErrorFound: Boolean;
 public
  function Run: Boolean; override;
 end;

 // в качестве примера
 TIntegerQueryExecutor = class(TQueryExecutor)
 public
  function Run: Boolean; override;
 end;

 TTimeQueryExecutor = class(TQueryExecutor)
 public
  function Run: Boolean; override;
 end;

{ TCommServer }

procedure TCommServer.BuildThread(aSender: TObject;
                                  aClientSocket: TServerClientWinSocket;
                                  var aSocketThread: TServerClientThread);
begin
 aSocketThread := TCommTask.Create(True, aClientSocket);
 aSocketThread.Data := Self;
 aSocketThread.Resume;
end;

procedure TCommServer.Cleanup;
begin
 Active := False;
 l3Free(f_ServerSocket);

 inherited;
end;

constructor TCommServer.Create(aPort: Integer; aThreadCacheSize: Integer = 10);
begin
 inherited Create;
 f_ServerSocket := TServerSocket.Create(nil);
 with f_ServerSocket do
 begin
  f_ServerSocket.ThreadCacheSize := aThreadCacheSize;
  ServerType := stThreadBlocking;
  Port := aPort;
  OnGetThread := BuildThread;
 end;
end;

function TCommServer.GetActive: Boolean;
begin
 Result := f_ServerSocket.Active;
end;

procedure TCommServer.SetActive(const aValue: Boolean);
begin
 f_ServerSocket.Active := aValue;
end;

{ TCommTask }

procedure TCommTask.ClientExecute;
begin
 if (not Terminated) and ClientSocket.Connected then
  try
   f_Agent := TCommAgent.Create(ClientSocket, c_WaitForClientTimeOut);
   try
    while (not Terminated) and ClientSocket.Connected do
    begin
     if f_Agent.RecvCommand = ccMsgBegin then
      if not ExecQuery(f_Agent.RecvHeader) then
       Break;
    end; // while
   finally
    l3Free(f_Agent);
   end;
   ClientSocket.Close;
  except
   HandleException;
  end;
end;

function TCommTask.ExecQuery(const aHeader: TCommHeader): Boolean;
var
 l_Executor: TQueryExecutor;
begin
 Result := False;

 case aHeader of
  chQueryFiles:   l_Executor := TFilesQueryExecutor.Create(Self);
  chQueryTime:    l_Executor := TTimeQueryExecutor.Create(Self);
  chQueryInteger: l_Executor := TIntegerQueryExecutor.Create(Self);
  //
  // здесь могут быть и другие команды
  //
 else
  Exit;
 end;

 try
  Result := l_Executor.Run and (f_Agent.RecvCommand = ccMsgEnd);
 finally
  l3Free(l_Executor);
 end;
end;

{ TQueryExecutor }

constructor TQueryExecutor.Create(aTask: TCommTask);
begin
 f_Task := aTask;
end;

{ TFilesQueryExecutor }

const
 c_FileLocationLength = 256;
 c_FileNameLength = 256;

 function fn_CopyFileProc(const aFileName: string;
                          aData: Pointer): Boolean;
 var
  l_Executor: TFilesQueryExecutor absolute aData;
  l_FileStream: Tl3FileStream;
  l_FileName: string;
 begin
  Result := False;
  with l_Executor.f_Task do
  begin
   // имя
   l_FileName := ExtractFileName(aFileName);
   if Agent.SendCommand(ccMsgData) and
      Agent.SendString(l_FileName) then
   begin
    // содержимое
    l_FileStream := Tl3FileStream.Create(aFileName, l3_fmRead);
    try
     Result := Agent.SendStream(l_FileStream);
    finally
     l3Free(l_FileStream);
    end;
   end; //if
  end; // with
  l_Executor.f_ErrorFound := not Result;
 end;

function TFilesQueryExecutor.Run: Boolean;
var
 l_Dir: string;

 function SendFiles: Boolean;
 begin
  Result := False;
  with f_Task.Agent do
   if not DirExists(l_Dir) then
    Result := SendHeader(chReplyError)
   else
   begin
    if SendHeader(chReplyResult) then
    begin
     l3FileUtils.ProcessFilesWithMask(l_Dir, '*.*', fn_CopyFileProc, Self); // об ошибках пишет в f_ErrorFound
     Result := not f_ErrorFound;
    end;
   end;
 end;

begin
 Result := False;
 with f_Task.Agent do
 begin
  if (RecvCommand = ccMsgData) and
     RecvString(l_Dir) and
     (RecvCommand = ccMsgEnd)
  then
   Result := SendCommand(ccMsgBegin) and
             SendFiles and
             SendCommand(ccMsgEnd);
 end; //with

 // удаление файлов после отправки
 if Result then
  l3FileUtils.DelDir(l_Dir);
end;

{ TCommClient }

procedure TCommClient.Cleanup;
begin
 Active := False;
 l3Free(f_Agent);
 l3Free(f_ClientSocket);

 inherited;
end;

constructor TCommClient.Create(const aServerAddress: string; aServerPort: Integer);
begin
 f_ClientSocket := TClientSocket.Create(nil);
 f_ClientSocket.ClientType := ctBlocking;
 f_ClientSocket.Address    := aServerAddress;
 f_ClientSocket.Port       := aServerPort;
end;

function TCommClient.GetActive: Boolean;
begin
 Result := f_ClientSocket.Active;
end;

procedure TCommClient.SetActive(const aValue: Boolean);
begin
 if f_ClientSocket.Active <> aValue then
 begin
  f_ClientSocket.Active := aValue;
  l3Free(f_Agent);
  if aValue then
   f_Agent := TCommAgent.Create(f_ClientSocket.Socket, c_WaitForServerTimeout);
 end;
end;

{ TFilesCommClient }

function TFilesCommClient.QueryFiles(const aServerFilesDir, aLocalDir: string): Boolean;

 function ReceiveFile: Boolean;
 var
  l_FileName: string;
  l_FileStream: Tl3FileStream;
 begin
  Result := False;
  // имя файла
  if f_Agent.RecvString(l_FileName) then
  begin
   l_FileStream := Tl3FileStream.Create(ConcatDirName(aLocalDir, l_FileName),
                                        l3_fmWrite);
   try
    Result := f_Agent.RecvStream(l_FileStream);
   finally
    l3Free(l_FileStream);
   end;
  end;
 end;

begin
 if not DirExists(aLocalDir) then
  MakeDir(aLocalDir);

 with f_Agent do
 begin
  // запрос
  Result := SendCommand(ccMsgBegin) and
            SendHeader(chQueryFiles) and
            SendCommand(ccMsgData) and
            SendString(aServerFilesDir) and
            SendCommand(ccMsgEnd);

  // ответ
  while Result do
   case RecvCommand of
    ccMsgBegin:
     Result := (RecvHeader = chReplyResult);
    ccMsgData:
     Result := ReceiveFile;
    ccMsgEnd:
     Break;
   else
    Result := False;
   end; //case
  // while
 end; // with
end;

{ TCommAgent }

procedure TCommAgent.Cleanup;
begin
 l3Free(f_Stream);
 inherited;
end;

constructor TCommAgent.Create(aSocket: TCustomWinSocket;
                              aTimeOut: Integer);
begin
 f_Socket := aSocket;
 f_SocketTimeOut := aTimeOut;
end;

function TCommAgent.RecvData(out aData; aDataSize: Integer): Boolean;
begin
 Result := ReadData(aData, aDataSize) = aDataSize;
end;

function TCommAgent.RecvInteger(out aInt: Integer): Boolean;
begin
 Result := RecvData(aInt, SizeOf(Integer));
end;

function TCommAgent.SendData(const aData; aDataSize: Integer): Boolean;
begin
 Result := WriteData(aData, aDataSize) = aDataSize;
end;

function TCommAgent.SendInteger(const aInt: Integer): Boolean;
begin
 Result := SendData(aInt, SizeOf(Integer));
end;

function TCommAgent.SendCommand(const aCommand: TCommCommand): Boolean;
begin
 Result := SendData(aCommand, SizeOf(TCommCommand));
end;

function TCommAgent.SendString(const aStr: string): Boolean;
var
 l_Length: Integer;
begin
 l_Length := Length(aStr);
 Result := SendData(l_Length, SizeOf(Integer))
       and SendData(aStr[1], Length(aStr));
end;

function TCommAgent.SocketStream: TWinSocketStream;
begin
 if f_Stream = nil then
  f_Stream := TWinSocketStream.Create(f_Socket, f_SocketTimeOut);

 Result := f_Stream;
end;

function TCommAgent.RecvString(out aStr: string): Boolean;
var
 l_Length: Integer;
begin
 Result := RecvData(l_Length, SizeOf(Integer));
 if Result then
 begin
  SetLength(aStr, l_Length);
  Result := RecvData(aStr[1], l_Length);
 end;
end;

function TCommAgent.RecvStream(aDstStream: TStream): Boolean;
const
 c_MaxBufferSize = $F000; // как в TStream.CopyFrom
var
 l_BufSize: Integer;
 l_StreamSize: Int64;
 l_BytesRead, l_WrittenToBuffer, l_LastWritten: Int64;
 l_Buf: PChar;
 l_Stopped: Boolean;
begin
 Result := False;

 // размер потока
 if RecvData(l_StreamSize, SizeOf(Int64)) and (l_StreamSize > 0) then
 begin
  // данные потока
  l_BufSize := Min(l_StreamSize, c_MaxBufferSize);
  l3System.GetLocalMem(l_Buf, l_BufSize);
  try
   l_Stopped := False;
   while not l_Stopped and (l_StreamSize > 0) do
   begin
    l_BytesRead := ReadData(l_Buf^, Min(l_StreamSize, l_BufSize));
    l_Stopped := l_BytesRead = 0;

    l_WrittenToBuffer := 0;
    while not l_Stopped and (l_WrittenToBuffer < l_BytesRead) do
    begin
     l_LastWritten := aDstStream.Write((l_Buf + l_WrittenToBuffer)^,
                                       l_BytesRead - l_WrittenToBuffer);
     l_Stopped := l_LastWritten = 0;
     Inc(l_WrittenToBuffer, l_LastWritten);
    end;

    Dec(l_StreamSize, l_BytesRead);
   end; // while
   Result := not l_Stopped and (l_StreamSize = 0);
  finally
   l3System.FreeLocalMem(l_Buf);
  end;
 end; // if
end;

function TCommAgent.SendStream(aSrcStream: TStream): Boolean;
const
 c_MaxBufferSize = $F000; // как в TStream.CopyFrom
var
 l_BufSize: Integer;
 l_StreamSize: Int64;
 l_BytesRead, l_WrittenToBuffer, l_LastWritten: Int64;
 l_Buf: PChar;
 l_Stopped: Boolean;
begin
 Result := False;
 // размер потока
 l_StreamSize := aSrcStream.Size;
 if (aSrcStream.Size > 0) and SendData(l_StreamSize, SizeOf(Int64)) then
 begin
  // данные потока
  l_BufSize := Min(aSrcStream.Size, c_MaxBufferSize);
  l3System.GetLocalMem(l_Buf, l_BufSize);
  try
   l_Stopped := False;
   aSrcStream.Position := 0;
   while not l_Stopped and (aSrcStream.Position < aSrcStream.Size - 1) do
   begin
    // чтение
    l_BytesRead := aSrcStream.Read(l_Buf^, l_BufSize);
    l_Stopped := l_BytesRead = 0;

    // запись
    l_WrittenToBuffer := 0;
    while not l_Stopped and (l_WrittenToBuffer < l_BytesRead) do
    begin
     l_LastWritten := WriteData((l_Buf + l_WrittenToBuffer)^,
                                l_BytesRead - l_WrittenToBuffer);
     l_Stopped := l_LastWritten = 0;
     Inc(l_WrittenToBuffer, l_LastWritten);
    end; // while
   end; // while
   Result := not l_Stopped and (aSrcStream.Position = aSrcStream.Size);
  finally
   l3System.FreeLocalMem(l_Buf);
  end;
 end; // if
end;

function TCommAgent.ReadData(out aBuffer; aBufferSize: Integer): Integer;
var
 l_ReadTimeout: Integer;
begin
 Result := 0;
 l_ReadTimeout := SocketStream.TimeOut div 10 * 9; // 90%
 if f_Socket.Connected and SocketStream.WaitForData(l_ReadTimeout) then
  Result := SocketStream.Read(aBuffer, aBufferSize)
 else
 begin
  l3Free(f_Stream);
  f_Socket.Close;
 end;
end;

function TCommAgent.WriteData(const aBuffer; aBufferSize: Integer): Integer;
begin
 Result := 0;
 if f_Socket.Connected then
  Result := SocketStream.Write(aBuffer, aBufferSize)
 else
 begin
  l3Free(f_Stream);
  f_Socket.Close;
 end;
end;

function TCommAgent.SendHeader(const aHeader: TCommHeader): Boolean;
begin
 Result := SendData(aHeader, SizeOf(TCommHeader));
end;

function TCommAgent.RecvCommand: TCommCommand;
begin
 if not RecvData(Result, SizeOf(TCommCommand)) then
  Result := ccNone;
end;

function TCommAgent.RecvHeader: TCommHeader;
begin
 if not RecvData(Result, SizeOf(TCommHeader)) then
  Result := chNone;
end;

function TCommAgent.RecvDouble(out aDbl: Double): Boolean;
begin
 Result := RecvData(aDbl, SizeOf(Double));
end;

function TCommAgent.SendDouble(const aDbl: Double): Boolean;
begin
 Result := SendData(aDbl, SizeOf(Double));
end;

{ TIntegerQueryExecutor }

function TIntegerQueryExecutor.Run: Boolean;
begin
 Result := False;
 with f_Task.Agent do
 begin
  if (RecvCommand = ccMsgEnd) then
   Result := SendCommand(ccMsgBegin) and
             SendHeader(chReplyResult) and
             SendCommand(ccMsgData) and
             SendInteger(12345) and
             SendCommand(ccMsgEnd);
 end; //with
end;

{ TIntegerCommClient }

function TIntegerCommClient.QueryInteger(out aInt: Integer): Boolean;
begin
 with f_Agent do
 begin
  // запрос
  Result := SendCommand(ccMsgBegin) and
            SendHeader(chQueryInteger) and
            SendCommand(ccMsgEnd);

  // ответ
  while Result do
   case RecvCommand of
    ccMsgBegin:
     Result := (RecvHeader = chReplyResult);
    ccMsgData:
     Result := RecvInteger(aInt);
    ccMsgEnd:
     Break;
    else
     Result := False;
   end; //case
  // while
 end; // with
end;

{ TTimeQueryExecutor }

function TTimeQueryExecutor.Run: Boolean;
begin
 Result := False;
 with f_Task.Agent do
 begin
  if (RecvCommand = ccMsgEnd) then
   Result := SendCommand(ccMsgBegin) and
             SendHeader(chReplyResult) and
             SendCommand(ccMsgData) and
             SendDouble(Now) and
             SendCommand(ccMsgEnd);
 end; //with
end;

{ TTimeCommClient }

function TTimeCommClient.QueryServerTime(out aTime: TDateTime): Boolean;
var
 l_Dbl: Double;
begin
 with f_Agent do
 begin
  // запрос
  Result := SendCommand(ccMsgBegin) and
            SendHeader(chQueryTime) and
            SendCommand(ccMsgEnd);

  // ответ
  while Result do
   case RecvCommand of
    ccMsgBegin:
     Result := (RecvHeader = chReplyResult);
    ccMsgData:
     Result := RecvDouble(l_Dbl);
    ccMsgEnd:
     Break;
    else
     Result := False;
   end; //case
  // while
 end; // with
 if Result then
  aTime := l_Dbl;
end;

end.


