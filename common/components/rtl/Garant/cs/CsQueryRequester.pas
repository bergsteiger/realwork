unit CsQueryRequester;

{ $Id: CsQueryRequester.pas,v 1.34 2015/06/16 12:31:59 lukyanets Exp $ }

// $Log: CsQueryRequester.pas,v $
// Revision 1.34  2015/06/16 12:31:59  lukyanets
// Новый Indy 10
//
// Revision 1.33  2015/03/02 08:03:56  lukyanets
// Убираем отладочную печать.
//
// Revision 1.32  2015/01/20 11:17:58  lukyanets
// Отладочная печать
//
// Revision 1.31  2015/01/19 15:30:04  lukyanets
// Отладочная печать
//
// Revision 1.30  2014/11/26 13:14:35  lukyanets
// Не было адреса сервера
//
// Revision 1.29  2014/06/20 10:35:49  lulin
// - защищаем коннекцию.
//
// Revision 1.28  2014/06/03 15:34:50  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.27  2014/05/21 14:31:06  lulin
// - добавляем диагностику.
//
// Revision 1.26  2014/05/21 13:57:35  lulin
// - чистим код.
//
// Revision 1.25  2013/04/24 09:35:37  lulin
// - портируем.
//
// Revision 1.24  2013/04/19 13:09:32  lulin
// - портируем.
//
// Revision 1.23  2011/12/08 12:32:12  narry
// Отображается не вся очередь заданий (304874341)
//
// Revision 1.22  2011/04/22 11:48:38  narry
// Большая кнопка (262636461)
//
// Revision 1.21  2010/02/24 10:30:50  narry
// - удаление зависимости проектов от парня
//
// Revision 1.20  2009/07/22 08:20:23  narry
// - новая процедура _KeepAlive
// - cleanup
//
// Revision 1.19  2008/11/25 12:59:34  narry
// - обновление
//
// Revision 1.18  2008/04/04 14:49:21  narry
// - не собиралось
//
// Revision 1.17  2007/10/04 07:53:59  narry
// - расширение процедуры регистрации клиента
//
// Revision 1.16  2007/08/30 08:34:37  narry
// - Промежуточное сохранение
//
// Revision 1.15  2006/11/30 15:36:18  fireton
// - новый таск: изменения пользователя
//
// Revision 1.14  2006/09/21 09:59:51  narry
// no message
//
// Revision 1.13  2006/09/01 13:55:01  narry
// - при подключении клиента к серверу проверяются версии клиента и сервера
//
// Revision 1.12  2006/08/24 08:48:30  narry
// - исправление: отключение получения номера версии
//
// Revision 1.11  2006/08/03 13:22:01  narry
// - увеличение версии протокола и реакция на ее не совпадение
//
// Revision 1.10  2006/08/02 12:18:46  narry
// - ловушка для сообщений с сервера
//
// Revision 1.9  2006/03/16 15:50:16  narry
// - еще один шажок в сторону клиент-сервера
//
// Revision 1.8  2006/03/10 09:29:12  voba
// - enh. убрал CsFree etc.
//
// Revision 1.7  2006/02/08 17:24:29  step
// выполнение запросов перенесено из классов-потомков в процедуры объектов
//

{$I CsDefine.inc}

interface

uses
 IdTcpClient, IdGlobal, IdIOHandler, idIOHandlerStream, IdComponent,
 l3Stream, l3Types, SyncObjs,
 CsCommon, CsObject, CsListener, CsDataPipe, CsQueryTypes;

const
 c_ClientConnectTimeout = 10 * 1000; // миллисек.

 {$IFDEF CsDebug}
 c_ClientReadTimeout = 1000 * 1000; // миллисек.
 {$ELSE}
 c_ClientReadTimeout = 10 * 1000; // миллисек.
 {$ENDIF}

type
 TCsQueryProc = procedure (aPipe: TCsDataPipe) of object;

 TcsWorkCount = Int64;

 TCsQueryRequester = class(TCsObject)
 private
  f_IsStarted: Boolean;
  f_ClientId: TCsClientId;
  f_OnProgressProc: Tl3ProgressProc;
  f_TcpClient: TIdTcpClient;
  f_ServerIp: TCsIp;
  f_Write2Log: Boolean;
  f_CS : TCriticalSection;
  function DoConnect: Boolean;
  procedure DoDisconnect;
  procedure Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: TcsWorkCount);
  procedure WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: TcsWorkCount);
  procedure WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  function pm_GetServerPort: TcsPort;
(*  procedure WriteDataToFile(aStr: String);*)
 protected
  function CheckProtocolVersion: Boolean;
  procedure Cleanup; override;
  procedure _ReadVersion(aPipe: TCsDataPipe);
 public
  constructor Create;
  procedure Start(const aServerName: string; aPort: TCsPort);
  procedure Stop;
  function Exec(aQueryId: TCsQueryId; aQueryProc: TCsQueryProc): TcsError;
  property ClientId: TCsClientId read f_ClientId write f_ClientId;
  property OnProgressProc: Tl3ProgressProc read f_OnProgressProc write f_OnProgressProc;
  property ServerIp: TCsIp read f_ServerIp;
  property ServerPort: TcsPort read pm_GetServerPort;
  property Write2Log: Boolean read f_Write2Log write f_Write2Log;
 end;

implementation

uses
 Forms, SysUtils, StrUtils,
 l3Base, l3FileUtils,
 IdStack, IdStackConsts, IdExceptionCore, IdException,
 CsConst, csErrors, l3Interfaces, TypInfo,

 csQueryRequesterTool
 ;

{ TCsQueryRequester }

procedure TCsQueryRequester.Cleanup;
begin
 FreeAndNil(f_TcpClient);
 inherited;
 FreeAndNil(f_CS);
end;

procedure TCsQueryRequester.Start(const aServerName: string;
                                  aPort: TCsPort);
begin
 if f_IsStarted then
  Exit;

 f_ServerIp := GStack.ResolveHost(aServerName);
 f_TcpClient.Host := f_ServerIp;
 f_TcpClient.Port := aPort;

 f_IsStarted := True;
 if not CheckProtocolVersion then
  Stop;
end;

constructor TCsQueryRequester.Create;
begin
 f_CS := TCriticalSection.Create;
 inherited Create;

 f_ClientId := c_WrongClientId; // пока не залогинились

 f_TcpClient := TIdTcpClient.Create(nil);
 f_TcpClient.ConnectTimeout := c_ClientConnectTimeout;
 f_TcpClient.ReadTimeout := c_ClientReadTimeout;
 f_tcpClient.OnWork:= Work;
 f_tcpClient.OnWorkBegin:= WorkBegin;
 f_tcpClient.OnWorkEnd:= WorkEnd;
 Write2Log:= False;
end;

function TCsQueryRequester.CheckProtocolVersion: Boolean;
begin
 Result := Exec(qtGetProtocolVersion, _ReadVersion) = cs_errOk;
end;

procedure TCsQueryRequester.Stop;
begin
 if not f_IsStarted then
  Exit;

 f_IsStarted := False;
end;

function TCsQueryRequester.DoConnect: Boolean;
begin
 Result := False;
 //if f_TcpClient.Host = '' then
 // Exit;
 try
  f_TcpClient.Connect;
  f_TcpClient.IOHandler.WriteBufferOpen;
  Result := True;
 except
  on E: EidException do
   l3System.Exception2Log(E);
 end;
end;

procedure TCsQueryRequester.DoDisconnect;
begin
// if f_TcpClient.Connected then
 begin
  f_TcpClient.IOHandler.WriteBufferClose;
  f_TcpClient.Disconnect(False);
 end;
end;

function TCsQueryRequester.Exec(aQueryId: TCsQueryId; aQueryProc: TCsQueryProc): TcsError;
var
 l_Pipe: TCsDataPipe;
 l_ServerVersion : Integer;
begin
 f_CS.Enter;
 try
  Result := cs_errError;
  try
   if f_IsStarted and DoConnect then
    try
     f_tcpClient.IOHandler.OnWork:= Work;
     f_tcpClient.IOHandler.OnWorkBegin:= WorkBegin;
     f_tcpClient.IOHandler.OnWorkEnd:= WorkEnd;
     l_Pipe := TCsDataPipe.Create(f_TcpClient.IOHandler);
     try
      if TCsQueryRequesterTool.ExecuteQuery(aQueryId, f_ClientId, l_Pipe, aQueryProc, Write2Log) then
       Result := cs_errOk;
     finally
      FreeAndNil(l_Pipe);
     end;//try..finally
    finally
     DoDisconnect;
    end;//try..finally
  except
   on EIdConnClosedGracefully do
   begin
    l3System.Msg2Log('Запрос: %s, соединение закрыто', [GetEnumName(TypeInfo(TcsQueryID), ord(aQueryID))]);
    Result := cs_errConnClosedGracefully;
   end;//on EIdConnClosedGracefully
   on EIdConnectTimeout do
   begin
    l3System.Msg2Log('Запрос: %s, истек интервал ожидания', [GetEnumName(TypeInfo(TcsQueryID), ord(aQueryID))]);
    Result := cs_errConnectTimeout;
   end;//on EIdConnectTimeout
   on E: EIdSocketError do
   begin
    if (E.LastError = Id_WSAECONNABORTED) then
    begin
     l3System.Msg2Log('Запрос: %s, соединение прервано', [GetEnumName(TypeInfo(TcsQueryID), ord(aQueryID))]);
     Result := cs_errConnAborted;
    end
    else if (E.LastError = Id_WSAECONNREFUSED) then
    begin
     l3System.Msg2Log('Запрос: %s, в подключении отказано', [GetEnumName(TypeInfo(TcsQueryID), ord(aQueryID))]);
     Result := cs_errConnRefused;
    end
    else
    begin
     l3System.Msg2Log('Странная ошибка %s с кодом %d', [E.ClassName, E.LastError]);
     raise;
    end;//else
   end;//on E: EIdSocketError
  end;//try..except
 finally
  f_CS.Leave;
 end;//try..finally
end;

procedure TCsQueryRequester.Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: TcsWorkCount);
begin
 if Assigned(f_OnProgressProc) then
  f_OnProgressProc(piCurrent, aWorkCount, IfThen(aWorkMode = wmRead, 'Получение', 'Отправка'));
end;

procedure TCsQueryRequester.WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: TcsWorkCount);
begin
 if Assigned(f_OnProgressProc) then
  f_OnProgressProc(piStart, aWorkCountMax, IfThen(aWorkMode = wmRead, 'Получение', 'Отправка'));
end;

procedure TCsQueryRequester.WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
 if Assigned(f_OnProgressProc) then
  f_OnProgressProc(piEnd, 0, IfThen(aWorkMode = wmRead, 'Получение', 'Отправка'));
end;

(*procedure TCsQueryRequester.WriteDataToFile(aStr: String);
var
 l_Str: String;
begin
 with Tl3FileStream.Create(ConcatDirName(ExtractFilePath(Application.ExeName), 'RequesterStream.dat'), l3_fmAppend) do
 try
  Write(aStr[1], Length(aStr));
 finally
  Free;
 end;
end;*)

procedure TCsQueryRequester._ReadVersion(aPipe: TCsDataPipe);
var
 l_ServerVersion: Integer;
begin
 l_ServerVersion := aPipe.ReadInteger;
 if l_ServerVersion <> c_CSVersion then
 begin
  l3System.Msg2Log('Версия протокола клиента (%d) отличается от версии сервера (%d)', [c_csVersion, l_ServerVersion]);
  raise ECsWrongVersionError.CreateFmt('Версия протокола клиента (%d) отличается от версии сервера (%d)', [c_csVersion, l_ServerVersion]);
 end;
end;

function TCsQueryRequester.pm_GetServerPort: TcsPort;
begin
 Result := f_TcpClient.Port;
end;

end.

