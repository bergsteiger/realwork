Unit Dt_Mail;

{ $Id: Dt_Mail.pas,v 1.59 2016/04/22 11:39:39 lukyanets Exp $ }

// $Log: Dt_Mail.pas,v $
// Revision 1.59  2016/04/22 11:39:39  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.58  2016/03/25 12:41:40  lukyanets
// cleanup
//
// Revision 1.57  2015/12/29 11:36:44  lukyanets
// Пишем ID письма на котором упали
//
// Revision 1.56  2015/11/25 14:01:48  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.55  2015/05/26 10:52:08  voba
// - k:600314823
//
// Revision 1.54  2015/04/07 09:08:35  lukyanets
// Изолируем домашний каталог
//
// Revision 1.53  2015/03/31 14:09:11  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.52  2015/03/04 13:42:55  lukyanets
// Убираем отмершие ошметки
//
// Revision 1.51  2014/11/11 13:56:42  lukyanets
// Не падаем на пустом списке документов
//
// Revision 1.50  2014/09/05 11:51:48  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.49  2014/09/04 13:19:36  voba
// - Рефакторинг процедуры ввода пароля
//
// Revision 1.48  2014/07/25 09:46:00  lukyanets
// {Requestlink:557844282}. Подружили dt_mail с ассистентом
//
// Revision 1.47  2014/07/21 09:26:54  lulin
// - спрямляем модель.
//
// Revision 1.46  2014/06/09 17:27:13  lulin
// - подготавливаем "рыбу" для регистрации Action'ов.
//
// Revision 1.45  2014/06/03 15:34:49  lulin
// - работы над возможностью посылки сообщения сервером самому себе.
//
// Revision 1.44  2014/02/13 12:18:20  lulin
// - рефакторим безликие списки.
//
// Revision 1.43  2013/04/19 13:07:39  lulin
// - портируем.
//
// Revision 1.42  2010/09/28 13:06:08  fireton
// - Распределяем память для PAnsiChar своими средствами
//
// Revision 1.41  2010/02/02 14:06:33  voba
// - enh. поменял списки хранения на Tl3StrRecList (наследник Tl3FieldSortRecList)
//
// Revision 1.40  2009/10/14 11:06:00  voba
// - избавляемся от библиотеки mg
//
// Revision 1.39  2009/04/13 07:10:58  narry
// - разделение определения типов и реализации
//
// Revision 1.38  2009/01/26 08:06:17  fireton
// - слияние с веткой b_archi_NewSrch2 (поиск по-новому)
//
// Revision 1.37.8.1  2008/12/26 15:22:05  fireton
// - полностью избавляемся от ссылок на DT_Srch
//
// Revision 1.37  2008/02/01 16:41:34  lulin
// - используем кошерные потоки.
//
// Revision 1.36  2007/08/14 20:25:14  lulin
// - bug fix: не собиралася Архивариус.
//
// Revision 1.35  2007/08/14 14:30:08  lulin
// - оптимизируем перемещение блоков памяти.
//
// Revision 1.34  2007/07/24 12:32:33  narry
// - рефакторинг системы сообщений
//
// Revision 1.33  2006/11/16 10:48:31  fireton
// - подготовка к большому UserID
//
// Revision 1.32  2006/08/28 12:55:02  narry
// - от сервера не приходили письма о результатах импорта
//
// Revision 1.31  2006/03/21 07:15:59  narry
// - исправление: отправка писем с сервера
//
// Revision 1.30  2006/03/16 15:50:19  narry
// - еще один шажок в сторону клиент-сервера
//
// Revision 1.29  2005/12/23 10:34:34  step
// переименование Host --> Station
//
// Revision 1.28  2005/10/31 09:40:38  step
// исправлены PutMessage/GetMessage: для корректной обработки длинных (>64k) сообщений
//
// Revision 1.27  2005/08/09 15:18:32  voba
// - improve : боролся с NeedAllocStr := False
//
// Revision 1.26  2005/06/23 08:35:54  step
// переименование SendMessage --> SendNetMessage (во избежание путаницы)
//
// Revision 1.25  2004/12/23 11:42:13  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.24  2004/09/14 15:58:14  lulin
// - удален модуль Str_Man - используйте вместо него - l3String.
//
// Revision 1.23  2004/08/03 08:52:50  step
// замена dt_def.pas на DtDefine.inc
//
// Revision 1.22  2004/05/18 09:51:46  step
// change: GlobalHTServer.MaxFamilyID --> GlobalHTServer.FamilyTbl.MaxFamilyID;
//
// Revision 1.21  2004/05/14 07:35:03  voba
// - replace NewSrch to ResetSearchStatus
//
// Revision 1.20  2004/03/29 09:32:44  voba
// no message
//
// Revision 1.19  2004/03/05 16:54:44  step
// чистка кода
//
// Revision 1.18  2002/11/21 17:14:54  law
// - bug fix: неправильно обрабатывалась директива MonoUser.
//
// Revision 1.17  2002/01/10 14:14:38  voba
// -lib sincro: replace l3GetStrLen to l3StrLen
//
// Revision 1.16  2001/09/04 13:59:09  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.15  2001/08/08 09:33:36  voba
// - new behavior: new notify procedure type
//
// Revision 1.14  2001/02/22 09:43:36  demon
// - fix grammatic errors in messages
//
// Revision 1.13  2000/12/15 15:36:17  law
// - вставлены директивы Log.
//

{$I DtDefine.inc}

interface

uses
  SysUtils, Classes,
  l3Types, l3IniFile, l3Date,
  l3_String, {l3DatLst,} l3StrRecList,
  l3InternalInterfaces,
  Dt_Types,
  CsClient, csNotification, csMessageManager
  ;

const
  MailFileName = 'MailBox.ini';
  mlWasRead = $80;

Type
 TMailType = (mlNone,mlSrch,mlDoc,mlDocList);
 TMailArrivedEvent = procedure(Sender: TObject; aMailID : LongInt) of object;


 PMailRec = ^TMailRec;
 TMailRec = record
              rName     : Tl3_String;
              rID       : LongInt;
              rMType    : Byte;
              rFromUser : TUserID;
              rDateTime : TStDateTimeRec;
             end;

 TMailServer = Class(Tl3StrRecList, Il3HandledStringList)
  private
   f_CSClient: TcsClient;
   {$IfDef AppServerSide}
   f_MessageManager: TcsMessageManager;
   {$EndIf AppServerSide}
   {$IfDef ServerAssistantSide}
   f_UseProxySender: Boolean;
   f_ProxySender: TUserID;
   {$EndIf ServerAssistantSide}
   procedure pm_SetCSClient(const Value: TcsClient);
   {$IfDef AppServerSide}
   procedure pm_SetMessageManager(const Value: TcsMessageManager);
   {$EndIf AppServerSide}
   function GetSenderID: TUserID;
  protected
   fLastDateTime  : TStDateTimeRec;
   fOnMailArrived : TMailArrivedEvent;

   Function   GetMessage(DataName : TFileName) : PAnsiChar;
   Procedure  PutMessage(DataName : TFileName;aMessage : PAnsiChar);
   Function   AddMailToList(aMailFile : TCfgList;aMailID : LongInt) : TStDateTimeRec;

   function   pm_GetHandle(anIndex: Integer): Integer;
   procedure  pm_SetHandle(anIndex: Integer; aValue: Integer);
   function   pm_GetItems(anIndex: Integer): Tl3PCharLen;
   procedure  pm_SetItems(anIndex: Integer; const aValue: Tl3PCharLen);
   function   pm_GetCount: Integer;

  public
   Constructor Create; virtual;
   function   CSNotifyProc(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: AnsiString): Boolean;

   Function   LoadMailList : TStDateTimeRec;

   procedure  ReciveMessage(aMessageNumber : Integer);

   Procedure  LoadMail(aMailIndex : LongInt;Var aMessage : PAnsiChar;Var aData : Pointer);

   Procedure  Delete(aMailIndex : LongInt); //override;

   function   SendMail(MailType : TMailType; UserID : TUserID;aName : ShortString;aMessage : PAnsiChar; aData : Pointer): Boolean;

   procedure  MarkRead(aMailIndex : Longint);
   function   IndexbyID(aID : Integer) : Integer;

   property  CSClient: TcsClient read f_CSClient write pm_SetCSClient;
   {$IfDef AppServerSide}
   property  MessageManager: TcsMessageManager read f_MessageManager write pm_SetMessageManager;
   {$EndIf AppServerSide}
   Property  LastDateTime : TStDateTimeRec read fLastDateTime;
   Property  OnMailArrived : TMailArrivedEvent read fOnMailArrived write fOnMailArrived;
   {$IfDef ServerAssistantSide}
   property UseProxySender: Boolean read f_UseProxySender write f_UseProxySender;
   property ProxySender: TUserID read f_ProxySender write f_ProxySender;
   {$EndIf ServerAssistantSide}
 end;

Const
 MailServer : TMailServer = Nil;

Implementation

uses
  WinTypes,

  l3Base,
  l3String,
  l3Stream,
  l3FileUtils,
  l3InterfacedString,

  daDataProvider,
  daSchemeConsts,
  
  Dt_Const, Dt_Serv, Dt_Err, Dt_User,
  Dt_Doc,

  csDataPipe, csQueryTypes
  ,
  l3ProtoObject
  ;

type
 TSendMailQuery = class(Tl3ProtoObject)
 public
  MailNumber: Integer;
  Recepient: Integer;
  procedure Write2Pipe(aPipe: TcsDataPipe);
 end;//TSendMailQuery

(************************* TMailList ***************************)

Constructor TMailServer.Create;
Begin
 Inherited Create(SizeOf(TMailRec), [SizeOf(PMailRec(nil).rName),
                                     SizeOf(PMailRec(nil).rID),
                                     SizeOf(PMailRec(nil).rMType),
                                     SizeOf(PMailRec(nil).rFromUser),
                                     SizeOf(PMailRec(nil).rDateTime.D),
                                     SizeOf(PMailRec(nil).rDateTime.T)],
                                     [-5, -6]);
end;

Function TMailServer.GetMessage(DataName : TFileName) : PAnsiChar;
Var
 DtFile   : Tl3FileStream;
 TmpSize  : Longint;
Begin
 Result:=Nil;
 DtFile:=Tl3FileStream.Create(DataName,l3_fmRead);
 Try
  DtFile.ReadBuffer(TmpSize,SizeOf(TmpSize));
  Result := l3StrAlloc(TmpSize+1);
  DtFile.ReadBuffer(Result^,TmpSize);
  Result[TmpSize]:=#0;
 finally
  l3Free(DtFile);
 end;
end;

Procedure TMailServer.PutMessage(DataName : TFileName;aMessage : PAnsiChar);
Var
 DtFile   : Tl3FileStream;
 TmpSize  : Longint;
Begin
 DtFile:=Tl3FileStream.Create(DataName,l3_fmWrite);
 Try
  TmpSize:=l3StrLen(aMessage);
  DtFile.WriteBuffer(TmpSize,SizeOf(TmpSize));
  DtFile.WriteBuffer(aMessage^,TmpSize);
 finally
  l3Free(DtFile);
 end;
end;

Function TMailServer.AddMailToList(aMailFile : TCfgList; aMailID : LongInt) : TStDateTimeRec;
Var
 lStr       : ShortString;
 TmpPChar   : PAnsiChar;
 TmpIndex   : LongInt;
 lRec       : TMailRec;
Begin
 Changing;
 l3FillChar(lRec, SizeOf(lRec));
 Result.D := 0;
 Result.T := 0;
 lRec.rID := aMailID;

 aMailFile.Section := 'MAIL' + IntToStr(aMailID);
 if aMailFile.ReadParamStr('Name', lStr) then
 begin
  lRec.rName := Tl3InterfacedString.Make(l3PCharLen(lStr));

  if aMailFile.ReadParamStr('Type', lStr) then
   lRec.rMType := StrToInt(lStr);

  if aMailFile.ReadParamStr('FromUser', lStr) then
   lRec.rFromUser := TDictID(StrToInt64(lStr));

  aMailFile.ReadParamRec('DateTime', 'DD', Result);
  lRec.rDateTime := Result;
  Add(lRec);
 end;
 Changed;
end;

function TMailServer.CSNotifyProc(aNotificationType: TCsNotificationType; aNumber: Integer; const aText: AnsiString):
    Boolean;
begin
 if aNotificationType = ntMailArrived then
 begin
  Result := True;
  ReciveMessage(aNumber);
 end
 else
  Result := False;
end;

Function TMailServer.LoadMailList : TStDateTimeRec;
Var
 MailFile : TCfgList;
 J,MaxJ   : LongInt;
 TmpDate  : TStDateTimeRec;
Begin
 Changing;
 try
  fLastDateTime.D:=0;
  fLastDateTime.T:=0;
  if (Not l3FileUtils.FileExists(GlobalDataProvider.CurHomePath+MailFileName)) then
   exit;

  MailFile := TCfgList.Create(GlobalDataProvider.CurHomePath+MailFileName);
  try
   MailFile.Section:='MAIN';
   MailFile.ReadParamInt('MaxMail',MaxJ);
   for J := 1 to Pred(MaxJ) do
   begin
    TmpDate := AddMailToList(MailFile, J);
    if fLastDateTime.D < TmpDate.D then
     fLastDateTime:=TmpDate
    else
     if (fLastDateTime.D = TmpDate.D) and
          (fLastDateTime.T < TmpDate.T) then
      fLastDateTime := TmpDate;
   end;
   Sorted := True;
   Result := fLastDateTime;
  finally
   l3Free(MailFile);
  end;
 finally
  Changed;
 end;
end;

Procedure TMailServer.LoadMail(aMailIndex : LongInt;Var aMessage : PAnsiChar;Var aData : Pointer);
Var
 MailID    : LongInt;
 MailFile  : TCfgList;
 DataName  : TPathStr;

 lStr    : ShortString;
 TmpType   : Byte;
Begin
 MailID:=PMailRec(ItemSlot(aMailIndex))^.rID;

 If Not l3FileUtils.FileExists(GlobalDataProvider.CurHomePath+MailFileName)
  then
   raise Exception.Create('INI файл почтового ящика не найден!'#13+
                          'Загрузка невозможна.');
 MailFile:=TCfgList.Create(GlobalDataProvider.CurHomePath+MailFileName);
 Try
  MailFile.Section:='MAIL'+IntToStr(MailID);
  If Not MailFile.ReadParamStr('Type',lStr)
   then
    raise Exception.Create('INI файл почтового ящика испорчен!'#13+
                           'Загрузка невозможна.'#13+
                           Format('Письмо № %d', [aMailIndex]));
  TmpType:=StrToInt(lStr) and Not mlWasRead;
  If Not MailFile.ReadParamString('File',DataName)
   then
    raise Exception.Create('INI файл почтового ящика испорчен!'#13+
                           'Загрузка невозможна.'#13+
                           Format('Письмо № %d', [aMailIndex]));
  If Not l3FileUtils.FileExists(GlobalDataProvider.CurHomePath+DataName)
   then
    raise Exception.Create('Потерян файл данных почтового ящика!'#13+
                           'Загрузка невозможна.'#13+
                           Format('Письмо № %d', [aMailIndex]));

  Case TMailType(TmpType) of
   mlNone :
    Begin
     aData:=Nil;
     aMessage:=GetMessage(GlobalDataProvider.CurHomePath+DataName);
    end;
   mlSrch :
    Assert(False, 'TMailServer.LoadMail - mlSrch: вырезано за ненадобностью');
    {
    Begin
     If TSrchServer(aData)=Nil
      then
       aData:=TSrchServer.Create;

     If Not MailFile.ReadParamStr('Family',TmpStr)
      then
       raise Exception.Create('INI файл почтового ящика испорчен!'#13+
                              'Загрузка невозможна.');
     TSrchServer(aData).Family:=StrToInt(TmpStr);
     TSrchServer(aData).ResetSearchStatus;
     If (TSrchServer(aData).Family>GlobalHtServer.FamilyTbl.MaxFamilyID) or
        (TSrchServer(aData).Family=MainTblsFamily)
      then
       raise Exception.Create('Недопустимый номер семейства!'#13+
                              'Загрузка невозможна.');

     TSrchServer(aData).LoadAsk(srchDocs,GlobalDataProvider.CurHomePath+DataName,aMessage,False);
    end;
    }
   mlDoc  :
    Begin
     aMessage:=GetMessage(GlobalDataProvider.CurHomePath+DataName);
     If Not MailFile.ReadParamStr('DocID',lStr)
      then
       raise Exception.Create('INI файл почтового ящика испорчен!'#13+
                              'Загрузка невозможна.');
     aData:=Pointer(StrToInt(lStr));
    end;
   mlDocList  :
    Begin
     If TDocumentSabList(aData)=Nil
      then
       aData:=TDocumentSabList.Create;

     If Not MailFile.ReadParamStr('Family',lStr)
      then
       raise Exception.Create('INI файл почтового ящика испорчен!'#13+
                              'Загрузка невозможна.');
     TDocumentSabList(aData).Family:=StrToInt(lStr);
     If (TDocumentSabList(aData).Family>GlobalHtServer.FamilyTbl.MaxFamilyID) or
        (TDocumentSabList(aData).Family=MainTblsFamily)
      then
       raise Exception.Create('Недопустимый номер семейства!'#13+
                              'Загрузка невозможна.');

     TDocumentSabList(aData).LoadList(GlobalDataProvider.CurHomePath+DataName,aMessage);
    end;
  end;
 finally
  l3Free(MailFile);
 end;
end;

Procedure TMailServer.Delete(aMailIndex : LongInt);
Var
 MailID   : LongInt;
 MailFile : TCfgList;
 DataName : TPathStr;
 lStr   : ShortString;
Begin
 MailID:=PMailRec(ItemSlot(aMailIndex))^.rID;
 If l3FileUtils.FileExists(GlobalDataProvider.CurHomePath + MailFileName)
  then
   Begin
    MailFile:=TCfgList.Create(GlobalDataProvider.CurHomePath + MailFileName);
    Try
     lStr:=IntToStr(MailID);
     MailFile.Section:='MAIL' + lStr;
     MailFile.ReadParamString('File', DataName);
     MailFile.DeleteSection('MAIL'+lStr);
     SysUtils.DeleteFile(GlobalDataProvider.CurHomePath+DataName);
    finally
     l3Free(MailFile);
    end;
   end;
 Inherited Delete(aMailIndex);
end;

function TMailServer.SendMail(MailType : TMailType; UserID : TUserID; aName : ShortString;aMessage : PAnsiChar; aData :
    Pointer): Boolean;
Var
 MailFile    : TCfgList;
 J,MaxJ,
 CurSection  : LongInt;
 DataName    : TFileName;
 lStr      : ShortString;

 SUserPath   : TPathStr;

 TmpRecPos,
 TmpMessage  : PAnsiChar;
 TmpLen      : Word;
 FlH         : Integer;

 CurDateTime : TStDateTimeRec;
 l_Query : TSendMailQuery;
Begin
 Result := False;
 If (MailType = mlSrch) {and
    ((TSrchServer(aData)=Nil) or (TSrchServer(aData).SrchType = srchNone))}
  then raise EHtErrors.CreateInt(ecSrchEmpty);

 If (MailType = mlDoc) and (LongInt(aData) = 0)
  then raise EHtErrors.CreateInt(ecEmpty);

 If (MailType = mlDocList) and (TDocumentSabList(aData) = Nil)
  then raise EHtErrors.CreateInt(ecEmpty);

 SUserPath:=GlobalDataProvider.GetHomePath(UserID);

 If Not l3FileUtils.FileExists(SUserPath+MailFileName)
  then
   Begin
    FlH:=FileCreate(SUserPath+MailFileName);
    FileClose(FlH);
    MailFile:=TCfgList.Create(SUserPath+MailFileName);
    MailFile.Section:='MAIN';
    MailFile.WriteParamInt('MaxMail',1);
   end
  else
   MailFile:=TCfgList.Create(SUserPath+MailFileName);
 Try
  MailFile.Section:='MAIN';
  MailFile.ReadParamInt('MaxMail',MaxJ);
  For J:=1 to MaxJ do
   Begin
    MailFile.Section:='MAIL'+IntToStr(J);
    If Not MailFile.ReadParamStr('Name',lStr)
     then
      Begin
       If J = MaxJ
        then
         Begin
          MailFile.Section:='MAIN';
          MailFile.WriteParamInt('MaxMail',MaxJ+1);
         end;
       CurSection:=J;
       MailFile.Section:='MAIL'+IntToStr(J);
       break;
      end;
   end;

  If aName=''
   then
    aName:='...от '+GlobalDataProvider.UserManager.GetUserName(GetSenderID);
  MailFile.WriteParamStr('Name',aName);
  DataName:=GetUniqFileName(SUserPath,'Mail','.dat',False);

  if (MailType = mlDocList) and (TDocumentSabList(aData).Count = 0) then
  begin
    MailType := mlNone;
  end;

  MailFile.WriteParamStr('Type',IntToStr(Byte(MailType)));
  MailFile.WriteParamStr('File',DataName);
  MailFile.WriteParamStr('FromUser',IntToStr(Int64(GetSenderID)));
  With CurDateTime do
   Begin
    D:=CurrentDate;
    T:=CurrentTime;
   end;
  MailFile.WriteParamRec ('DateTime','DD',CurDateTime);

  Case MailType of
   mlNone : PutMessage(SUserPath+DataName,aMessage);
   mlSrch :
     Assert(False, 'TMailServer.LoadMail - mlSrch: вырезано за ненадобностью');
     {
     Begin
      MailFile.WriteParamStr('Family',IntToStr(TSrchServer(aData).Family));
      TSrchServer(aData).SaveAsk(srchDocs,SUserPath+DataName,aMessage);
     end;
     }
   mlDoc :
     Begin
      MailFile.WriteParamStr('DocID',IntToStr(LongInt(aData)));
      PutMessage(SUserPath+DataName,aMessage);
     end;
   mlDocList :
     Begin
      MailFile.WriteParamStr('Family',IntToStr(TDocumentSabList(aData).Family));
      TDocumentSabList(aData).SaveList(SUserPath+DataName,aMessage);
     end;
  end;
 finally
  l3Free(MailFile);
 end;
 {$IFNDEF MonoUser}
 {$IfNDef AppServerSide}
 if (CSClient <> nil) then
 begin
  l_Query := TSendMailQuery.Create{(nil)};
  try
   l_Query.Recepient := UserID;
   l_Query.MailNumber := CurSection;
   Result := CSClient.Exec(qtSendMail, l_Query.Write2Pipe);
  finally
   l3Free(l_Query);
  end;
 end
 {$Else AppServerSide}
 if (MessageManager <> nil) then
  MessageManager.SendNotify(UserID, ntMailArrived, CurSection, '');
 {$EndIf AppServerSide}
 {$ENDIF}
end;

Procedure TMailServer.MarkRead(aMailIndex : LongInt);
Var
 MailID   : LongInt;
 MailFile : TCfgList;
 lStr   : ShortString;
 lRec  : PMailRec;
Begin
 lRec := PMailRec(ItemSlot(aMailIndex));

 MailID := lRec^.rID;
 lRec^.rMType := lRec^.rMType or mlWasRead;
 If l3FileUtils.FileExists(GlobalDataProvider.CurHomePath + MailFileName)
  then
   Begin
    MailFile := TCfgList.Create(GlobalDataProvider.CurHomePath + MailFileName);
    Try
     lStr := IntToStr(MailID);
     MailFile.Section := 'MAIL' + lStr;
     MailFile.ReadParamStr('Type', lStr);
     MailFile.WriteParamStr('Type', IntToStr(Byte(StrToInt(lStr)) or mlWasRead));
    finally
     l3Free(MailFile);
    end;
   end;
end;

function TMailServer.IndexbyID(aID : Integer) : Integer;
var
 I : Integer;
begin
 Result := -1;
 for I := 0 to pred(Count) do
  if PMailRec(ItemSlot(I)).RID = aID then
  begin
   Result := I;
   Exit;
  end;
end;

procedure TMailServer.pm_SetCSClient(const Value: TcsClient);
begin
 if f_CSClient <> Value then
 begin
  f_CSClient := Value;
  f_CSClient.AddNotifyProc(CSNotifyProc);
 end;
end;

{$IfDef AppServerSide}
procedure TMailServer.pm_SetMessageManager(const Value: TcsMessageManager);
begin
 if f_MessageManager <> Value then
 begin
  f_MessageManager := Value;
 end;
end;
{$EndIf AppServerSide}

procedure TMailServer.ReciveMessage(aMessageNumber : Integer);
Var
 MailFile : TCfgList;
 TmpDate  : TStDateTimeRec;
Begin
 If (Not l3FileUtils.FileExists(GlobalDataProvider.CurHomePath+MailFileName)) then
   exit;

 MailFile:=TCfgList.Create(GlobalDataProvider.CurHomePath+MailFileName);
 Try
  TmpDate:= AddMailToList(MailFile, aMessageNumber);
  If Assigned(OnMailArrived) then OnMailArrived(Self, aMessageNumber);
  If fLastDateTime.D<TmpDate.D then
    fLastDateTime:=TmpDate
   else
    If (fLastDateTime.D=TmpDate.D) and
       (fLastDateTime.T<TmpDate.T) then
      fLastDateTime:=TmpDate;
 finally
  l3Free(MailFile);
 end;
end;

function  TMailServer.pm_GetHandle(anIndex: Integer): Integer;
begin
 Result := PMailRec(ItemSlot(anIndex)).RID;
end;

procedure TMailServer.pm_SetHandle(anIndex: Integer; aValue: Integer);
begin
 Assert(False);
end;

function  TMailServer.pm_GetItems(anIndex: Integer): Tl3PCharLen;
begin
 Result := Tl3PCharLen(PMailRec(MailServer.ItemSlot(anIndex)).rName.AsWStr);
end;

procedure TMailServer.pm_SetItems(anIndex: Integer; const aValue: Tl3PCharLen);
begin
 Assert(False);
end;

function  TMailServer.pm_GetCount: Integer;
begin
 Result := Count;
end;

procedure TSendMailQuery.Write2Pipe(aPipe: TcsDataPipe);
begin
 aPipe.WriteInteger(Recepient);
 aPipe.WriteInteger(MailNumber);
end;

function TMailServer.GetSenderID: TUserID;
begin
 Result := GlobalDataProvider.UserID;
 {$IfDef ServerAssistantSide}
 if UseProxySender then
   Result := ProxySender;
 {$EndIf ServerAssistantSide}
end;

end.
