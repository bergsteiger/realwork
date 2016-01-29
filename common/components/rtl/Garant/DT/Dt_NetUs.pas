Unit DT_NetUs; // Не используется!!

{ $Id: Dt_NetUs.pas,v 1.59 2015/05/19 13:05:54 lukyanets Exp $ }

// $Log: Dt_NetUs.pas,v $
// Revision 1.59  2015/05/19 13:05:54  lukyanets
// Разделяем изготовление параметров и запуск клиента
//
// Revision 1.58  2014/08/20 15:28:12  lulin
// - вычищаем мусор.
//
// Revision 1.57  2014/02/14 15:33:45  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.56  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.55  2013/04/09 11:08:07  lulin
// - пытаемся отладиться под XE.
//
// Revision 1.54  2010/09/28 13:06:09  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.53  2009/11/20 13:43:21  voba
// - bug fix: Tl3BuuferedFilter не корректно работает в режиме почитали, пописали, почитали. Пришлось сделать в DT_Jour собственную буфферизацию
//
// Revision 1.52  2009/10/14 10:49:15  voba
// - избавляемся от библиотеки mg
//
// Revision 1.51  2008/03/20 09:48:36  lulin
// - cleanup.
//
// Revision 1.50  2008/02/07 14:44:41  lulin
// - класс _Tl3LongintList переехал в собственный модуль.
//
// Revision 1.49  2008/02/01 16:41:34  lulin
// - используем кошерные потоки.
//
// Revision 1.48  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.47  2007/08/14 19:31:56  lulin
// - оптимизируем очистку памяти.
//
// Revision 1.46  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.45  2006/06/09 13:17:07  fireton
// - bug fix: изменена версия нетлога обратно на 5
//
// Revision 1.44  2006/06/08 15:54:46  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.43.18.1  2006/06/08 09:08:01  fireton
// - перевод User ID на Longword
//
// Revision 1.43  2005/12/23 10:38:29  step
// добавлена работа с портами
//
// Revision 1.42  2005/11/16 09:16:13  step
// изменено сравнение адресов
//
// Revision 1.41  2005/03/28 14:24:34  narry
// - bug fix: stream read error
//
// Revision 1.40  2005/03/18 16:22:31  narry
// - update: переход на TryLock без Exception
//
// Revision 1.39  2004/09/21 12:04:20  lulin
// - Release заменил на Cleanup.
//
// Revision 1.38  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.37  2004/08/03 08:52:49  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.36  2004/03/05 16:56:45  step
// чистка кода
//
// Revision 1.35  2004/02/16 10:50:49  step
// изменен алгоритм TNetUsersJournal.ClearLocks
//
// Revision 1.34  2004/02/03 15:50:41  narry
// - bug fix
//
// Revision 1.33  2004/01/29 12:25:05  narry
// - update: заполнение массива имени станции "нулями"
//
// Revision 1.32  2004/01/29 12:00:52  step
// изменена TNetUsersJournal.ClearLocks
//
// Revision 1.31  2004/01/29 11:35:01  step
// в TNetUsersJournal.ClearLocks добавлено снятие замков с документов
//
// Revision 1.30  2004/01/28 17:53:20  step
// - bug fix
//
// Revision 1.29  2004/01/28 16:09:42  narry
// - update
//
// Revision 1.28  2004/01/28 13:27:39  voba
// - bug fix: нарушение логики чтения файла залочек
//
// Revision 1.27  2004/01/28 10:09:01  narry
// - bug fix
//
// Revision 1.26  2004/01/27 15:48:46  narry
// - new: процедура формирования имени станции на основе пары IP-Port
// - new: подготовка к реализации автоматического выбора номера порта
//
// Revision 1.25  2004/01/27 12:06:13  narry
// - new: в структуру файла залочек добавлено новое поле - порт
// - new: версия файла увеличена до 5
// - update: структура TStationInfo расширена на поле Port
// - update: функция GetUserInfo
//
// Revision 1.24  2004/01/27 09:58:05  step
// TNetUsersJournal.ClearLocks не выбрасывает исключение, а возвращает Integer
//
// Revision 1.23  2004/01/26 16:01:10  narry
// - update: подгтовка к изменению структуры файла залочек
//
// Revision 1.22  2004/01/22 18:33:49  step
// Добавлен метод TNetUsersJournal.ClearLocks
//
// Revision 1.21  2003/01/27 13:31:17  demon
// - new: добавлена функция GetUserInfo для получения идентификатора
// станции и IP адреса работающего пользователя.
//
// Revision 1.20  2002/12/24 13:02:00  law
// - change: объединил Int64_Seek c основной веткой.
//
// Revision 1.19.2.1  2002/12/24 11:56:43  law
// - new behavior: используем 64-битный Seek вместо 32-битного.
//
// Revision 1.19  2002/11/21 17:14:54  law
// - bug fix: неправильно обрабатывалась директива MonoUser.
//
// Revision 1.18  2002/06/06 15:04:04  law
// - new method: TryLock.
//
// Revision 1.17  2002/05/29 13:25:52  voba
// - bug fix: защищаем изменение времени ожидания.
//
// Revision 1.16  2002/05/29 12:31:29  law
// - new behavior: пробуем защитить залочку файла из 2-х нитей.
//
// Revision 1.15  2002/05/23 07:47:09  voba
// - bug fix: обламавалась процедура автогенерации имени станции
//
// Revision 1.14  2002/02/08 17:09:56  voba
// no message
//
// Revision 1.13  2001/03/01 11:44:46  demon
// - add feature of getting User Active list through Server
//
// Revision 1.12  2000/12/15 15:36:17  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

Interface

Uses
 SysUtils,
 Classes,
 l3Base,
 l3Stream,
 l3DatLst,
 l3LongintList,
 Dt_Types;

Const
 cHeaderSize = 13;
 cHeader  : Array[1..cHeaderSize] of AnsiChar = 'Work Stations';
 cVersion : AnsiChar = #05;
 LockChar : AnsiChar = #01;
 NilUser  : TUserID = 0;
Type
 TSuffixStr = String[4];

 TNetUserRec = Record
                StName   : TStationID;
                LockChar : AnsiChar;
                HostName : THostID;
                CurUser  : TUserID;
                Port     : Word;
               end;

 TStationInfo = record
                 Station,
                 Host,
                 Port     : ShortString;
                end;

 PStationAddress = ^TStationAddress;
 TStationAddress = record
                    ClientId: TUserId;
                    Host: String[15];
                    Port: Word;
                   end;


 TNetUsException = class(Exception)
 end;

 TNetUsersJournal = Class(Tl3Base)
  private
   fPort: Word;
  protected
   fJourFl       : Tl3FileStream;
   fJourName     : TPathStr;
   fStName       : TStationID;
   fHostName     : THostID;
   fLockPos      : LongInt;
   fHeaderSize   : Word;
   function IsRecordLocked(aPos: Integer): Boolean;
   function    GetCurHost : ShortString;
   Procedure   Cleanup; override;
  public
   constructor Create(aStationName : TStationName;
                      aHostName : ShortString;
                      aJourFullName : TPathStr;
                      const aPort: Word = 32001); reintroduce;
   constructor MakeUnique(aHostname: ShortString; aFileName: AnsiString);
   { Создает файл журнал пользователя и выполняет сканирование файла на предмет
     уникальности пользователя. В случае его уникальности подбирает для него
     свободный порт и создает имя станции }
   Procedure   SetCurUser(aUser : TUserID);
   Function    GetActiveStationList(ExcludeHostName : PAnsiChar = Nil) : Tl3StringDataList;
   procedure   GetActiveStations(aList: Tl3StringDataList;
                                 aExcludeItself: Boolean = True); // калька с GetActiveStationList, но выдает поболе данных
   Function    GetActiveUsersList : Tl3LongintList;
   Procedure   SetActiveUsers(aUserActCh : TUserStatusChange);

   Function    GetHostName(aUserID : TUserID) : ShortString;
   Function    GetStationName(aUserID: TUserID): ShortString;
   Function    GetUserID(aStation : TStationID) : TUserID;
   function    GetUserInfo(aUserID : TUserID) : TStationInfo;
   function    FindAddress(const aUserName: AnsiString;
                           out aAddress: TStationAddress): Boolean;

   Function    IsCurHost(aHostName : ShortString) : Boolean;
   function    IsCurStation(const aStationName: ShortString): Boolean;
   procedure   ClearDocLocks;
    // Очистка от неснятых блокировок документов

   Property    CurHostArr : THostID read fHostName;
   Property    CurHostStr : ShortString read GetCurHost;
 end;

 Function GetAutoStationSuffix(aFileName : TPathStr) : TSuffixStr;

 function CreateStationName(aIP: AnsiString; aPort: Word): AnsiString;
 { Создает уникальное имя станции на основе ip-адреса и порта }

Implementation

uses
  m2xltlib,
  l3MinMax,
  l3String,
  Dt_User, Dt_err, DT_Jour,
  m0Const,
  //mgConst,
  ShellApi, Windows, StrUtils,
  IdGlobal,
  l3Types
  ;

const
 c_LockCharOffset = SizeOf(TStationID);

resourcestring
  rsNoUniquedUser = 'Пользователь с таким именем уже работает в сети!';
  rsOutdatedApp = 'У Вас устаревшая версия оболочки!'#13'Свяжитесь с разработчиками.';
  rsNotUniqueStationName = 'Не уникальное имя станции!'#13'Измените параметр StationName'#13'в секции [BaseDocPath] .INI файла.';
  rsStructureError = 'Разрушена структура файла залочек!'#13'Свяжитесь с разработчиками.';

constructor TNetUsersJournal.Create(aStationName: TStationName;
                                    aHostName: ShortString;
                                    aJourFullName: TPathStr;
                                    const aPort: Word = 32001);
Var
 TmpVer      : AnsiChar;
 CurStation  : TStationID;

 ReadSize    : LongInt;
Begin
 Inherited Create;
 fHeaderSize:=cHeaderSize+1;
 fLockPos:=-1;
 l3FillChar(fStName,SizeOf(fStName));
 l3Move(aStationName[1],fStName,l3MinMax.Min(Byte(aStationName[0]),SizeOf(fStName)));
 m2XLTConvertBuff(@fStName,SizeOf(fStName),Cm2XLTANSI2UPPER);
 l3FillChar(fHostName,SizeOf(fHostName));
 l3Move(aHostName[1],fHostName,l3MinMax.Min(Length(aHostName),SizeOf(fHostName)));
 m2XLTConvertBuff(@fHostName,SizeOf(fHostName),Cm2XLTANSI2UPPER);
 fJourName:=aJourFullName;
 fPort:= aPort;
 If Not FileExists(fJourName) then
 Begin
  fJourFl:=Tl3FileStream.Create(fJourName,l3_fmWrite);
  Try
   fJourFl.WriteBuffer(cVersion,1);
   fJourFl.WriteBuffer(cHeader,cHeaderSize);
  finally
   l3Free(fJourFl);
  end;
 end
 else
 Begin
  fJourFl:=Tl3FileStream.Create(fJourName,l3_fmRead);
  Try
   fJourFl.ReadBuffer(TmpVer,1);
  finally
   l3Free(fJourFl);
  end;
  If TmpVer <> cVersion then
   If TmpVer < cVersion then
   Begin
    fJourFl:=Tl3FileStream.Create(fJourName,l3_fmWrite);
    Try
     fJourFl.WriteBuffer(cVersion,1);
     fJourFl.WriteBuffer(cHeader,cHeaderSize);
    finally
     l3Free(fJourFl);
    end;
   end
   else
    raise TNetUsException.Create(rsOutdatedApp);
 end;

 fJourFl:=Tl3FileStream.Create(fJourName,l3_fmReadWrite);

 fJourFl.Seek(fHeaderSize,soBeginning);
 fJourFl.Lock(1,cHeaderSize);
 Try
  Repeat
   ReadSize:=fJourFl.Read(CurStation,SizeOf(CurStation));
   If ReadSize = SizeOf(CurStation) then
    Begin
     If fStName = CurStation then
       Try
        fLockPos := fJourFl.Position;
        if fJourFl.Lock(fLockPos, 1, 3{sec}) then
        begin
         fJourFl.Seek(1,soCurrent);
         fJourFl.WriteBuffer(fHostName,SizeOf(fHostName));
         fJourFl.WriteBuffer(NilUser, SizeOf(NilUser));
         fJourFl.WriteBuffer(fPort, SizeOf(fPort));
         exit;
        end;
       except
        fLockPos := -1;
        raise TNetUsException.Create(rsNotUniqueStationName);
       end;
     fJourFl.Seek(SizeOf(TNetUserRec) - SizeOf(TStationID), soCurrent);
    end
   else
    Begin
     If ReadSize = 0 then
      Break
     else
      raise TNetUsException.Create(rsStructureError);
    end;
  until False;

  fJourFl.Seek(0,soEnd);
  fJourFl.WriteBuffer(fStName,SizeOf(fStName));
  fLockPos:=fJourFl.Position;
  fJourFl.WriteBuffer(LockChar,1);
  fJourFl.Lock(fLockPos,1);
  fJourFl.WriteBuffer(fHostName,SizeOf(fHostName));
  fJourFl.WriteBuffer(NilUser,SizeOf(NilUser));
  fJourFl.WriteBuffer(fPort, SizeOf(fPort));
 finally
  fJourFl.UnLock(1,cHeaderSize);
 end;
end;

procedure TNetUsersJournal.Cleanup;
begin
 if fLockPos <> -1 then
  fJourFl.UnLock(fLockPos,1);
 l3Free(fJourFl);
 Inherited;
end;

Procedure TNetUsersJournal.SetCurUser(aUser : TUserID);
Var
 l_ReadSize,
 l_CurPos     : LongInt;
 l_CurStation : TStationID;
 l_CurUserID  : TUserID;
 l_Port : Word;
Begin
 fJourFl.Lock(1,cHeaderSize);
 try
  fJourFl.Seek(fHeaderSize,soBeginning);
  repeat
   l_ReadSize:=fJourFl.Read(l_CurStation, SizeOf(l_CurStation));
   If l_ReadSize = SizeOf(l_CurStation) then
   begin
    l_CurPos:= fJourFl.Position;
    if IsRecordLocked(l_CurPos) then
    begin
     fJourFl.Seek(1+SizeOf(THostID),soCurrent);
     If fStName = l_CurStation then
      fJourFl.WriteBuffer(aUser, SizeOf(aUser))
     else
     Begin
      fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));
      if l_CurUserID = aUser then
       raise TNetUsException.Create(rsNoUniquedUser);
     end;
     fJourFl.Seek(SizeOf(fPort),soCurrent);
    end
    else
     fJourFl.Seek(SizeOf(TNetUserRec)-SizeOf(TStationID),soCurrent);
   end
   (*
   Try
    l_CurPos:= fJourFl.Position;
    fJourFl.TryLock(l_CurPos,1);
    fJourFl.UnLock(l_CurPos,1);
    fJourFl.Seek(SizeOf(TNetUserRec)-SizeOf(TStationID),soCurrent);
   except
    fJourFl.Seek(1+SizeOf(THostID),soCurrent);
    If fStName = l_CurStation then
     fJourFl.WriteBuffer(aUser, SizeOf(aUser))
    else
    Begin
     fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));
     if l_CurUserID = aUser then
      raise TNetUsException.Create(rsNoUniquedUser);
    end;
    fJourFl.Seek(SizeOf(fPort),soCurrent);
   end // try..except
   *)
   else
   Begin
    If l_ReadSize = 0 then
     Break
    else
     raise TNetUsException.Create(rsStructureError);
   end;
  until False;
 finally
  fJourFl.UnLock(1,cHeaderSize);
 end;
end;

Function TNetUsersJournal.GetActiveStationList(ExcludeHostName : PAnsiChar) : Tl3StringDataList;
 function AreEqual(const aIP1, aIP2: AnsiString): Boolean;
 begin
  Result := IPv4ToDWord(aIP1) = IPv4ToDWord(aIP2);
 end;
Var
 l_LastPos,
 l_CurPos   : LongInt;
 l_CurHost  : PAnsiChar;
Begin
 Result:=Tl3StringDataList.Create;
 Result.NeedAllocStr:=True;
 Result.Sorted:=False;

 l_CurHost := l3StrAlloc(SizeOf(THostID)+1);
 try
  fJourFl.Lock(1,cHeaderSize);
  try
   l_LastPos:= fJourFl.Size;
   fJourFl.Seek(fHeaderSize+SizeOf(TStationID),soBeginning);
   repeat
     l_CurPos:=fJourFl.Position;
     If l_CurPos >= l_LastPos then
      break;
     if IsRecordLocked(l_CurPos) then
     begin
      l3FillChar(l_CurHost^, SizeOf(THostID)+1);
      fJourFl.Seek(1, soCurrent);
      fJourFl.ReadBuffer(l_CurHost^, SizeOf(THostID));
      if ExcludeHostName = nil then
      begin
       if not AreEqual(l_CurHost, CurHostStr) then
        Result.Add(l_CurHost);
      end
      else
      begin
       if not AreEqual(l_CurHost, ExcludeHostName)
        and not AreEqual(l_CurHost, CurHostStr)
       then
        Result.Add(l_CurHost);
      end;
      fJourFl.Seek(SizeOf(TUserID)+SizeOf(fPort)+SizeOf(TStationID),soCurrent);
     end
     else
      fJourFl.Seek(SizeOf(TNetUserRec), soCurrent);
     (*
     Try
      CurPos:=fJourFl.Position;
      If CurPos >= LastPos then Break;
      fJourFl.TryLock(CurPos,1);
      fJourFl.UnLock(CurPos,1);
      fJourFl.Seek(SizeOf(TNetUserRec),soCurrent);
     except
      l3FillChar(CurHost^,SizeOf(THostID)+1);
      fJourFl.Seek(1,soCurrent);
      fJourFl.ReadBuffer(CurHost^,SizeOf(THostID));
      If ExcludeHostName = Nil then
       begin
        If StrLComp(CurHost,@fHostName,SizeOf(THostID))<>0 then
         Result.Add(CurHost);
       end
      else
       begin
        If (StrLComp(CurHost,ExcludeHostName,SizeOf(THostID))<>0) and
           (StrLComp(CurHost,@fHostName,SizeOf(THostID))<>0) then
         Result.Add(CurHost);
       end;
      fJourFl.Seek(SizeOf(TDictID)+SizeOf(fPort)+SizeOf(TStationID),soCurrent);
     end
     *)
   until False;
  finally
   fJourFl.UnLock(1,cHeaderSize);
  end;
 finally
  l3StrDispose(l_CurHost);
 end;
end;

Function TNetUsersJournal.GetActiveUsersList : Tl3LongintList;
Var
 l_LastPos,
 l_CurPos    : LongInt;
 l_CurUserID : TUserID;
Begin
 Result:= Tl3LongintList.Create;

 fJourFl.Lock(1, cHeaderSize);
 Try
  l_LastPos:= fJourFl.Size;
  fJourFl.Seek(fHeaderSize+SizeOf(TStationID), soBeginning);
  Repeat
   l_CurPos:=fJourFl.Position;
   if l_CurPos >= l_LastPos then
    break;
   if IsRecordLocked(l_CurPos) then
   begin
    fJourFl.Seek(1+SizeOf(THostID), soCurrent);
    fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));
    Result.Add(l_CurUserID);
    fJourFl.Seek(SizeOf(fPort)+SizeOf(TStationID), soCurrent);
   end
   else
    fJourFl.Seek(SizeOf(TNetUserRec), soCurrent);
    (*
    Try
     l_CurPos:=fJourFl.Position;
     If l_CurPos >= l_LastPos then
      Break;
     fJourFl.TryLock(l_CurPos,1);
     fJourFl.UnLock(l_CurPos,1);
     fJourFl.Seek(SizeOf(TNetUserRec), soCurrent);
    except
     fJourFl.Seek(1+SizeOf(THostID), soCurrent);
     fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));

     Result.Add(l_CurUserID);

     fJourFl.Seek(SizeOf(fPort)+SizeOf(TStationID), soCurrent);
    end
    *)
  until False;
 finally
  fJourFl.UnLock(1,cHeaderSize);
 end;
end;

Procedure TNetUsersJournal.SetActiveUsers(aUserActCh : TUserStatusChange);
Var
 l_LastPos,
 l_CurPos    : LongInt;
 l_CurUserID : TUserID;
Begin
 fJourFl.Lock(1, cHeaderSize);
 Try
  l_LastPos:=fJourFl.Size;
  fJourFl.Seek(fHeaderSize+SizeOf(TStationID),soBeginning);
  Repeat
   l_CurPos:= fJourFl.Position;
   If l_CurPos >= l_LastPos then
    break;
    if IsRecordLocked(l_CurPos) then
    begin
     fJourFl.Seek(1+SizeOf(THostID), soCurrent);
     fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));
     aUserActCh(l_CurUserID, True);
     fJourFl.Seek(SizeOf(fPort)+SizeOf(TStationID),soCurrent);
    end
    else
     fJourFl.Seek(SizeOf(TNetUserRec), soCurrent);
   (*
   Try
    l_CurPos:= fJourFl.Position;
    If l_CurPos >= l_LastPos then
     break;
    fJourFl.TryLock(l_CurPos, 1);
    fJourFl.UnLock(l_CurPos, 1);
    fJourFl.Seek(SizeOf(TNetUserRec), soCurrent);
   except
    fJourFl.Seek(1+SizeOf(THostID), soCurrent);
    fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));

    aUserActCh(l_CurUserID, True);

    fJourFl.Seek(SizeOf(fPort)+SizeOf(TStationID),soCurrent);
   end
   *)
  until False;
 finally
  fJourFl.UnLock(1, cHeaderSize);
 end;
end;

Function TNetUsersJournal.GetHostName(aUserID : TUserID) : ShortString;
var
 l_LastPos,
 l_CurPos     : LongInt;
 l_CurHost    : THostID;
 l_CurUserID  : TUserID;
Begin
// Result := UserManager.LoginNameByUserId(aUserID);

 Result:='';
 fJourFl.Lock(1, cHeaderSize);
 Try
  l_LastPos:= fJourFl.Size;
  fJourFl.Seek(fHeaderSize+SizeOf(TStationID), soBeginning);
  Repeat
   l_CurPos:= fJourFl.Position;
   If l_CurPos >= l_LastPos then
    break;
   if IsRecordLocked(l_CurPos) then
   begin
    l3FillChar(l_CurHost, SizeOf(THostID));
    fJourFl.Seek(1, soCurrent);
    fJourFl.ReadBuffer(l_CurHost, SizeOf(THostID));
    fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));
    If l_CurUserID = aUserID then
    begin
     Result:= l3ArrayToString(l_CurHost, SizeOf(THostID));
     exit;
    end;
    fJourFl.Seek(SizeOf(fPort)+SizeOf(TStationID), soCurrent);
   end
   else
    fJourFl.Seek(SizeOf(TNetUserRec), soCurrent);
  until False;
 finally
  fJourFl.UnLock(1, cHeaderSize);
 end;

end;

Function TNetUsersJournal.GetUserID(aStation : TStationID) : TUserID;
Var
 l_LastPos,
 l_CurPos     : LongInt;
 l_CurStation : TStationID;
 l_CurUserID  : TUserID;
Begin
 Result:= 0;
 m2XLTConvertBuff(@aStation, SizeOf(aStation), Cm2XLTANSI2UPPER);
 fJourFl.Lock(1, cHeaderSize);
 Try
  l_LastPos:= fJourFl.Size;
  fJourFl.Seek(fHeaderSize, soBeginning);
  Repeat
   if fJourFl.Position >= l_LastPos then
    break;
   l3FillChar(l_CurStation, SizeOf(TStationID));
   fJourFl.ReadBuffer(l_CurStation, SizeOf(TStationID));
   l_CurPos:= fJourFl.Position;
   if IsRecordLocked(l_CurPos) then
   begin
    fJourFl.Seek(SizeOf(THostID)+1, soCurrent);
    fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));
    If l_CurStation = aStation then
    begin
     Result:= l_CurUserID;
     exit;
    end;
    fJourFl.Seek(SizeOf(fPort), soCurrent);
   end
   else
    fJourFl.Seek(SizeOf(TNetUserRec)-SizeOf(TStationID), soCurrent);
   (*
   Try
    If fJourFl.Position >= l_LastPos then
     Break;
    l3FillChar(l_CurStation, SizeOf(TStationID));
    fJourFl.ReadBuffer(l_CurStation, SizeOf(TStationID));
    l_CurPos:= fJourFl.Position;
    fJourFl.TryLock(l_CurPos, 1);
    fJourFl.UnLock(l_CurPos, 1);
    fJourFl.Seek(SizeOf(TNetUserRec)-SizeOf(TStationID), soCurrent);
    except
     fJourFl.Seek(SizeOf(THostID)+1, soCurrent);
     fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));

     If l_CurStation = aStation then
     Begin
      Result:= l_CurUserID;
      exit;
     end;
   end
   *)
  until False;
 finally
  fJourFl.UnLock(1,cHeaderSize);
 end;
end;

function TNetUsersJournal.GetUserInfo(aUserID : TUserID) : TStationInfo;
var
 l_LastPos,
 l_CurPos     : LongInt;
 l_CurHost    : THostID;
 l_CurStation : TStationID;
 l_CurUserID  : TUserID;
 l_Port       : Word;
begin
 Result.Station:='';
 Result.Host:='';
 fJourFl.Lock(1, cHeaderSize);
 try
  l_LastPos:= fJourFl.Size;
  fJourFl.Seek(fHeaderSize, soBeginning);
  repeat
   fJourFl.ReadBuffer(l_CurStation, SizeOf(l_CurStation));
   l_CurPos:= fJourFl.Position;
   If l_CurPos >= l_LastPos then
    break;
   if IsRecordLocked(l_CurPos) then
   begin
    l3FillChar(l_CurHost, SizeOf(THostID));
    l3FillChar(l_CurStation, SizeOf(TStationID));
    fJourFl.Seek(1, soCurrent);
    fJourFl.ReadBuffer(l_CurHost, SizeOf(l_CurHost));
    fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));
    fJourFl.REadBuffer(l_Port, SizeOf(fPort));
    if l_CurUserID = aUserID then
    begin
     Result.Station:= l3ArrayToString(l_CurStation, SizeOf(TStationID));
     Result.Host:= l3ArrayToString(l_CurHost, SizeOf(THostID));
     Result.Port:= IntToStr(l_Port);
     exit;
    end
    else
     l3FillChar(Result, SizeOf(Result))
   end
   else
    fJourFl.Seek(SizeOf(TNetUserRec)-SizeOf(l_CurStation), soCurrent);
  until {False} fJourFl.Position = fJourFl.Size;
 finally
  fJourFl.UnLock(1, cHeaderSize);
 end;
end;

Function TNetUsersJournal.IsCurHost(aHostName : ShortString) : Boolean;
Var
 TmpHostName : THostID;
 Len         : Integer;
Begin
 l3FillChar(TmpHostName,SizeOf(THostID));

 Len:=Length(aHostName);
 If Len > 0 then
  l3Move(aHostName[1],TmpHostName,Min(Len,SizeOf(THostID)));

 Result := StrLComp(PAnsiChar(@TmpHostName),@fHostName,SizeOf(THostID)) = 0;
end;

function TNetUsersJournal.GetCurHost : ShortString;
Begin
 Result:=l3ArrayToString(fHostName,SizeOf(THostID));
end;

procedure TNetUsersJournal.ClearDocLocks;
var
 l_Jour: TAbstractJournal;
 l_ActiveStations: Tl3StringDataList;
begin
 l_Jour := TAbstractJournal.Create(fStName, fJourName);
 try
  l_ActiveStations := GetActiveStationList;
  try
   l_Jour.ClearDeadRecs(l_ActiveStations);
  finally
   l3Free(l_ActiveStations);
  end;
 finally
  L3Free(l_Jour);
 end;
end;

const
 StationAlpha : String[32] = '1234567890ABCDEFGHIJKLMNOPQRSTUV';

procedure IP2Bytes(const IP: AnsiString; out part1, part2, part3, part4: Byte);
var
 l_Pos, l_PrevPos: Integer;
begin
 l_PrevPos:= 1;
 l_Pos:= PosEx('.', IP, l_PrevPos);
 Part1:= StrToIntDef(Copy(IP, l_PrevPos, l_Pos-l_PrevPos), 0);
 l_PrevPos:= Succ(l_Pos);
 l_Pos:= PosEx('.', IP, l_PrevPos);
 Part2:= StrToIntDef(Copy(IP, l_PrevPos, l_Pos-l_PrevPos), 0);
 l_PrevPos:= Succ(l_Pos);
 l_Pos:= PosEx('.', IP, l_PrevPos);
 Part3:= StrToIntDef(Copy(IP, l_PrevPos, l_Pos-l_PrevPos), 0);
 Part4:= StrToIntDef(Copy(IP, Succ(l_Pos), Length(IP)-l_PrevPos), 0);
end;


function CreateStationName(aIP: AnsiString; aPort: Word): AnsiString;
var
 l_Bytes: Array[0..7] of Byte;
 l_Unique: Int64 absolute l_Bytes;
 l_IP1, l_IP2, l_IP3, l_IP4: Byte;
 l_Alpha: Byte;
begin
 IP2Bytes(aIP, l_IP1, l_IP2, l_IP3, l_IP4);
 l3FillChar(l_Bytes, SizeOf(l_Bytes));
 l_Bytes[0]:= aPort-32000;
 l_Bytes[1]:= l_IP1;
 l_Bytes[2]:= l_IP2;
 l_Bytes[3]:= l_IP3;
 l_Bytes[4]:= l_IP4;
 Result:= '';
 while l_Unique <> 0 do
 begin
  l_Alpha:= Succ(l_Unique and 31);
  Result:= Result + StationAlpha[l_Alpha];
  l_Unique:= l_Unique shr 5;
 end; // while
end;

(**************************************************************************)

Function GetAutoStationSuffix(aFileName : TPathStr) : TSuffixStr;
Var
 FileH       : Tl3FileStream;
 TmpVer      : AnsiChar;
 HeaderSize  : Word;
 TmpWord     : Word;
Begin
 If Not FileExists(aFileName) then
  raise TNetUsException.Create('Файл с АВТО-ключем не найден!'#13+
                               'Свяжитесь с разработчиками.');

 FileH := Tl3FileStream.Create(aFileName,l3_fmRead);
 Try
  FileH.ReadBuffer(TmpVer,1);
  If TmpVer>cVersion
   then
    raise TNetUsException.Create('Несовпадение версий оболочки и данных!'#13+
                                 'Свяжитесь с разработчиками.');
 finally
  l3Free(FileH);
 end;

 FileH:=Tl3FileStream.Create(aFileName,l3_fmReadWrite);
 Try
  HeaderSize:=cHeaderSize+1;
  FileH.Seek(HeaderSize,soBeginning);

  FileH.Lock(0,cHeaderSize);
  Try
   FileH.ReadBuffer(TmpWord,SizeOf(TmpWord));
   Result:=IntToHex(TmpWord,4);
   Inc(TmpWord);
   FileH.Seek(HeaderSize,soBeginning);
   FileH.WriteBuffer(TmpWord,SizeOf(TmpWord));
  finally
   FileH.UnLock(0,cHeaderSize);
  end;
 finally
  l3Free(FileH);
 end;
end;



constructor TNetUsersJournal.MakeUnique(aHostname: ShortString; aFileName: 
    AnsiString);
begin
  // TODO -cMM: TNetUsersJournal.MakeUnique default body inserted
  inherited;
end;

{$IFDEF TryLock}
function TNetUsersJournal.IsRecordLocked(aPos: Integer): Boolean;
begin
 Result := not fJourFl.TryLock(aPos,1, False);
 if not Result then
  fJourFl.UnLock(aPos,1);
end;
{$ELSE}
function TNetUsersJournal.IsRecordLocked(aPos: Integer): Boolean;
begin
 if fJourFl.Lock(aPos, 1, 0) then
 begin
  fJourFl.UnLock(aPos, 1);
  Result := False;
 end
 else
  Result:= True;
end;
{$ENDIF}

function TNetUsersJournal.IsCurStation(const aStationName: ShortString): Boolean;
begin
 Result := (Length(aStationName) > 0) and
           (StrLComp(PAnsiChar(@aStationName[1]),
                     @fStName[1],
                     Min(Length(aStationName), SizeOf(TStationID))) = 0);
end;

procedure   TNetUsersJournal.GetActiveStations(aList: Tl3StringDataList;
                                               aExcludeItself: Boolean = True);
var
 l_Eof,
 l_Pos: Int64;

 l_StName   : TStationID;
 l_HostName : THostID;
 l_CurUser  : TUserID;
 l_Port     : Word;

 l_Datum: TStationAddress;
Begin
 if aList = nil then
  Exit;
 aList.NeedAllocStr := True;
 aList.Sorted := False;

 fJourFl.Lock(1, cHeaderSize);
 try
  l_Eof := fJourFl.Size;
  fJourFl.Seek(fHeaderSize, soBeginning);
  while fJourFl.Position < l_Eof do
  begin
   if IsRecordLocked(fJourFl.Position + c_LockCharOffset) then
   begin
    // StName
    fJourFl.ReadBuffer(l_StName, SizeOf(l_StName));
    if aExcludeItself and (l_StName = fStName) then
    begin
     fJourFl.Seek(SizeOf(AnsiChar) + SizeOf(THostId) + SizeOf(TUserID) + SizeOf(Word), soCurrent);
     Continue;
    end;

    // LockChar
    fJourFl.Seek(SizeOf(AnsiChar), soCurrent); // LockChar

    // HostName
    fJourFl.ReadBuffer(l_HostName, SizeOf(l_HostName));
    //fJourFl.Seek(SizeOf(l_HostName), soCurrent);

    // CurUser
    fJourFl.ReadBuffer(l_CurUser, SizeOf(l_CurUser));
    //fJourFl.Seek(SizeOf(l_CurUser), soCurrent);

    // Port
    fJourFl.ReadBuffer(l_Port, SizeOf(l_Port));
    //fJourFl.Seek(SizeOf(l_Port), soCurrent);

    l_Datum.ClientId := l_CurUser;
    l_Datum.Host := Trim(l3ArrayToString(l_HostName, SizeOf(l_HostName)));
    l_Datum.Port := l_Port;
    aList.AddStr(l3ArrayToString(l_StName, SizeOf(l_StName)),
                 PAnsiChar(@l_Datum),
                 SizeOf(l_Datum));
   end
   else
    fJourFl.Seek(SizeOf(TNetUserRec), soCurrent);
  end;
 finally
  fJourFl.UnLock(1,cHeaderSize);
 end;
end;

function TNetUsersJournal.FindAddress(const aUserName: AnsiString;
                                      out aAddress: TStationAddress): Boolean;
var
 l_TmpName: AnsiString;
 l_UserName: TStationID;
 l_Eof: Int64;

 l_StName   : TStationID;
 l_HostName : THostID;
 l_CurUser  : TUserID;
 l_Port     : Word;
Begin
 Result := False;
 l3FillChar(l_UserName, SizeOf(l_UserName));
 l_TmpName := UpperCase(Trim(aUserName));
 l3StringToArray(l_UserName, Length(l_TmpName), l_TmpName);

 fJourFl.Lock(1, cHeaderSize);
 try
  l_Eof := fJourFl.Size;
  fJourFl.Seek(fHeaderSize, soBeginning);
  while fJourFl.Position < l_Eof do
  begin
   if IsRecordLocked(fJourFl.Position + c_LockCharOffset) then
   begin
    // StName
    fJourFl.ReadBuffer(l_StName, SizeOf(l_StName));
    if (l_StName = l_UserName) then
    begin
     // LockChar
     fJourFl.Seek(SizeOf(AnsiChar), soCurrent);

     // HostName
     fJourFl.ReadBuffer(l_HostName, SizeOf(l_HostName));

     // CurUser
     fJourFl.ReadBuffer(l_CurUser, SizeOf(l_CurUser));

     // Port
     fJourFl.ReadBuffer(l_Port, SizeOf(l_Port));

     aAddress.ClientId := l_CurUser;
     aAddress.Host := Trim(l3ArrayToString(l_HostName, SizeOf(l_HostName)));
     aAddress.Port := l_Port;

     Result := True;
     Break;
    end
    else
     fJourFl.Seek(SizeOf(TNetUserRec) - SizeOf(l_StName), soCurrent);
   end
   else
    fJourFl.Seek(SizeOf(TNetUserRec), soCurrent);
  end; // while
 finally
  fJourFl.UnLock(1,cHeaderSize);
 end;
end;

function TNetUsersJournal.GetStationName(aUserID: TUserID): ShortString;
var
 l_LastPos,
 l_CurPos     : LongInt;
 l_CurStation : TStationID;
 l_CurUserID  : TUserID;
Begin
 Result:='';
 fJourFl.Lock(1, cHeaderSize);
 Try
  l_LastPos:= fJourFl.Size;
  fJourFl.Seek(fHeaderSize+SizeOf(TStationID), soBeginning);
  Repeat
   l_CurPos:= fJourFl.Position;
   If l_CurPos >= l_LastPos then
    break;
   if IsRecordLocked(l_CurPos) then
   begin
    l3FillChar(l_CurStation, SizeOf(TStationID));
    fJourFl.Seek(1, soCurrent);
    fJourFl.Seek(SizeOf(THostID), soCurrent);
    fJourFl.ReadBuffer(l_CurUserID, SizeOf(l_CurUserID));
    If l_CurUserID = aUserID then
    begin
     fJourFl.Seek( -(SizeOf(TStationID) + 1 + SizeOf(THostID) + SizeOf(l_CurUserID)), soCurrent);
     fJourFl.ReadBuffer(l_CurStation, SizeOf(TStationID));
     Result:= l3ArrayToString(l_CurStation, SizeOf(TStationID));
     exit;
    end;
    fJourFl.Seek(SizeOf(fPort)+SizeOf(TStationID), soCurrent);
   end
   else
    fJourFl.Seek(SizeOf(TNetUserRec), soCurrent);
  until False;
 finally
  fJourFl.UnLock(1, cHeaderSize);
 end;
end;

end.
