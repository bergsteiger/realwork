unit a2bMain;
// реализация бизнес-объекта главной формы
{ $Id: a2bMain.pas,v 1.11 2016/05/18 06:02:39 lukyanets Exp $ }

// $Log: a2bMain.pas,v $
// Revision 1.11  2016/05/18 06:02:39  lukyanets
// Выключаем удаленную отладку
//
// Revision 1.10  2016/05/16 12:54:13  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.9  2016/04/20 11:57:00  lukyanets
// Пересаживаем UserManager на новые рельсы
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.8  2015/09/01 12:31:12  lukyanets
// Заготовки к Postgress
//
// Revision 1.7  2015/05/29 12:54:36  fireton
// - "служебный" 255 регион: исключаем из интерфейса и экспорта пользователей
//
// Revision 1.6  2015/04/07 07:35:52  lukyanets
// Изолируем HT
//
// Revision 1.5  2015/03/31 14:08:40  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.4  2014/09/09 05:28:35  lukyanets
// Не собиралось. Переименовали CurUserID в UserID
//
// Revision 1.3  2012/02/27 10:26:45  fireton
// - не собиралось
//
// Revision 1.2  2010/10/27 10:40:06  fireton
// - статистика импорта пользователей
//
// Revision 1.1  2010/10/26 08:54:19  fireton
// - переносим часть операций на главную форму
//

interface
uses
 l3ProtoObject,
 l3IniFile,
 
 a2Interfaces;

type
 Ta2bMain = class(Tl3ProtoObject, Ia2MainForm)
 private
  f_ConfiguredThroughServer: Boolean;
  procedure ChangeSupervisorPassword(aNewPassword: string);
  procedure ExportUsers(const aFileName: string; const aRegion: Integer);
  procedure ImportUsers(const aFileName: string; const aRegion: Integer; out theAddedCount, theChangedCount: Integer);
  function pm_GetIsConfiguredThroughServer: Boolean;
  function pm_GetIsSupervisor: Boolean;
  function SortUsersProc(I,J: Longint): LongInt;
 public
  constructor Create;
 end;

implementation
uses
 SysUtils,

 l3Base,
 l3Types,
 l3String,
 l3DatLst,
 l3Stream,
 l3Parser,
 l3LongintList,

 daDataProvider,
 daUtils,
 daTypes,
 daInterfaces,

 DT_Types,
 DT_UserConst,
 DT_User
 , l3LongintListPrim;

resourcestring
 seGeneralCSVError = 'Ошибка в файле CSV (строка %d)';
 seIDError = 'Ошибка в ID (строка %d)'; 

constructor Ta2bMain.Create;
begin
 inherited;
 StationConfig.Section:='ServerConfig';
 f_ConfiguredThroughServer := StationConfig.ReadParamStrDef('ServerConfigINI', '') <> '';
end;

procedure Ta2bMain.ChangeSupervisorPassword(aNewPassword: string);
begin
 UserManager.AdminChangePassWord(usSupervisor, aNewPassword);
end;

procedure Ta2bMain.ExportUsers(const aFileName: string; const aRegion: Integer);
var
 lActive: string;
 lFlag: Byte;
 I,J: Integer;
 lID: TdaUserID;
 lName,l_Login: String;
 lGroups: string;
 lGList: Tl3StringDataList;
 F: TextFile;
 lOldCompareProc: Tl3OnCompareItems;
 l_Region : Integer;
begin
 AssignFile(F, aFileName);
 Rewrite(F);
 try
  lOldCompareProc := GlobalDataProvider.UserManager.AllUsers.OnCompareItems;
  GlobalDataProvider.UserManager.AllUsers.OnCompareItems := SortUsersProc;
  GlobalDataProvider.UserManager.AllUsers.Sort;
  try
   for I := 0 to Pred(GlobalDataProvider.UserManager.AllUsers.Count) do
   begin
    lID  := TdaUserID(GlobalDataProvider.UserManager.AllUsers.DataInt[I]);
    l_Region := lID shr 24;
    if ((aRegion = regAllRegions) and (l_Region < 255)) or (l_Region = aRegion) then // исключаем "служебный" 255 регион
    begin
     GlobalDataProvider.UserManager.GetUserInfo(lID, lName, l_Login, lFlag);
     lGList := Tl3StringDataList.Create;
     try
      UserManager.GetUserGroupList(lID, lGList);
      lGroups := '';
      for J := 0 to Pred(lGList.Count) do
       if lGList.Select[J] then
       begin
        if lGroups <> '' then
         lGroups := lGroups+',';
        lGroups := lGroups+lGlist.Strings[J];
       end;
     finally
      FreeAndNil(lGList);
     end; {try..finally}
     if lGroups <> '' then
      lGroups := ';'+lGroups;
     if (lFlag and $01) > 0 then // active flag
      lActive := '1'
     else
      lActive := '0';
     if (lFlag and $02) > 0 then // "admin" flag
      lActive := lActive + ';1'
     else
      lActive := lActive + ';0';
     Writeln(F,lID,';',l_Login,';*;',lName,';',lActive,lGroups);
    end;
   end;
  finally
   GlobalDataProvider.UserManager.AllUsers.OnCompareItems := lOldCompareProc;
  end; {try..finally}
 finally
  CloseFile(F);
 end; {try..finally}
end;

procedure Ta2bMain.ImportUsers(const aFileName: string; const aRegion: Integer; out theAddedCount, theChangedCount: Integer);
var
 lOldFlag: Byte;
 lOldLogin: String;
 lOldUserName: String;
 lExactUserID: Integer;
 l_Idx: Integer;
 lGrStr: Tl3String;
 lIsActive, lIsAdmin: Byte;
 l_Flags : Byte;
 EM: TUsEditMask;
 l_UserID: TUserID;
 LineNum: Integer;
 FieldNum: Integer;
 lStream: Tl3FileStream;
 lParser, lGrParser: Tl3Parser;
 l_Login, l_Password, lName: ShortString;
 lGroups: string;
 l_Region: TdaRegionID;
 l_IsNewUser: Boolean;
 l_IsLocalUser: Boolean;
 l_TmpStr: string;
 l_Edited: Boolean;
 l_UGList: Tl3LongintList;
 l_GroupID: TUserGrID;
begin
 lStream := Tl3FileStream.Create(aFileName, l3_fmRead);
 try
  lParser := Tl3Parser.Make(lStream, [], [' '..#255]-[';'], l3_DefaultParserWhiteSpace-[#10,#13]);
  try
   FieldNum := 0;
   l_Login := '';
   l_Password := '';
   lName := '';
   lGroups := '';
   LineNum := 1;
   lIsActive := 0;
   lIsAdmin  := 0;
   lExactUserID := -1;
   l_UGList := Tl3LongintList.Make;
   theAddedCount := 0;
   theChangedCount := 0;
   try
    repeat
     lParser.NextTokenSp;
     case lParser.TokenType of
      l3_ttSymbol:
       case FieldNum of
        0:
         begin
          l_TmpStr := Trim(lParser.TokenString);
          try
           lExactUserID := StrToInt(l_TmpStr);
          except
           raise EAdminError.CreateFmt(seIDError, [LineNum]);
          end;
         end;
        1: l_Login := Trim(lParser.TokenString);
        2: l_Password := Trim(lParser.TokenString);
        3: lName := Trim(lParser.TokenString);
        4:
         try
          lIsActive := StrToInt(lParser.TokenString);
         except
          raise EAdminError.CreateFmt(seGeneralCSVError, [LineNum]);
         end;
        5:
         try
          lIsAdmin := StrToInt(lParser.TokenString);
         except
          raise EAdminError.CreateFmt(seGeneralCSVError, [LineNum]);
         end;
        6: lGroups := lParser.TokenString;
       end;
      l3_ttSingleChar:
       if lParser.TokenChar = ';' then
        Inc(FieldNum);
      l3_ttEOL, l3_ttEOF:
       begin
        if FieldNum > 2 then
        begin
         if lExactUserID > 0 then
          l_UserID := lExactUserID
         else
          l_UserID := 0; // новый пользователь


         l_Region := l_UserID shr 24;
         l_IsLocalUser := (l_UserID = 0) or (l_Region = GlobalDataProvider.RegionID);
         l_IsNewUser := not GlobalDataProvider.UserManager.IsUserExists(l_UserID);
         if (l_UserID = 0) or (aRegion = regAllRegions) or (aRegion = l_Region) then
         begin
          if not l_IsNewUser then
          begin
           try
            GlobalDataProvider.UserManager.GetUserInfo(l_UserID, lOldUserName, lOldLogin, lOldFlag);
           except
            l_TmpStr := Format('Невозможно получить данные пользователя (строка %d)', [LineNum]);
            l3System.Stack2Log(l_TmpStr);
            raise EAdminError.Create(l_TmpStr);
           end;
           EM.LoginName := l_IsLocalUser and (AnsiUpperCase(l_Login) <> AnsiUpperCase(lOldLogin));
           EM.Name := (FieldNum > 3) and (lName <> lOldUserName);
           l_Flags := lOldFlag;
           if FieldNum > 4 then
            l_Flags := (l_Flags and not $01) or lIsActive;
           if FieldNum > 5 then
            l_Flags := (l_Flags and not $02) or (lIsAdmin shl 1);
           EM.ActivFlag := lOldFlag <> l_Flags;
           l_Edited := False;
           if EM.LoginName or EM.Name or EM.ActivFlag then
           begin
            try
             UserManager.EditUser(l_UserID, lName, l_Login, l_Flags, EM);
             l_Edited := True;
            except
             l_TmpStr := Format('Невозможно отредактировать пользователя (строка %d)', [LineNum]);
             l3System.Stack2Log(l_TmpStr);
             raise EAdminError.Create(l_TmpStr);
            end;
           end;
           if l_IsLocalUser and (l_Password <> '*') then
           begin
            UserManager.AdminChangePassWord(l_UserID, l_Password);
            l_Edited := True;
           end;
           UserManager.GetUserGroupList(l_UserID, l_UGList);
           UserManager.RemoveUserFromAllGroups(l_UserID);
          end
          else//if not l_IsNewUser
          begin
           // создаем пользователя с нужным ID
           try
            if l_IsLocalUser then
            begin
             l_Flags := lIsActive or lIsAdmin;
             if l_Password = '*' then
              l_Password := '';
            end
            else
            begin
             l_Flags := lIsAdmin; // "не нашим" пользователям (из других регионов) по умолчанию вырубаем активность
             l_Login := ''; // и логина при импорте им тоже не полагается
             l_Password := '';
            end;
            UserManager.AddUserID(l_UserID, lName, l_Login, l_Password, l_Flags);
           except
            l_TmpStr := Format('Невозможно создать пользователя c ID %d (строка %d)', [l_UserID, LineNum]);
            l3System.Stack2Log(l_TmpStr);
            raise EAdminError.Create(l_TmpStr);
           end;
          end;//if not l_IsNewUser

          if (lGroups <> '') and not (l_IsNewUser and not l_IsLocalUser) then
          begin
           lGrStr := Tl3String.Make(l3PCharLen(lGroups));
           try
            lGrParser := Tl3Parser.Make(lGrStr, [], [#32..#255] - [','], []);
            try
             with lGrParser do
             repeat
              NextTokenSp;
              if TokenType = l3_ttSymbol then
              begin
               l_TmpStr := Trim(TokenString);
               if l_TmpStr <> '' then
               begin
                l_Idx := 0;
                if GlobalDataProvider.UserManager.AllGroups.FindStr(PAnsiChar(l_TmpStr), l_Idx) then
                begin
                 l_GroupID := GlobalDataProvider.UserManager.AllGroups.DataInt[l_Idx];
                 UserManager.SetUserGroup(l_UserID, l_GroupID, True);
                 if (not l_IsNewUser) and (not l_Edited) then
                 begin
                  l_Idx := l_UGList.IndexOf(l_GroupID);
                  if l_Idx = -1 then
                   l_Edited := True
                  else
                   l_UGList.Delete(l_Idx);
                 end;
                end
                else
                begin
                 Str2Log('Импорт пользователей из CSV: несуществующая группа - '+l_TmpStr);
                 {lShStrTmp := StrPas(PAnsiChar(l_TmpStr));
                 l_Idx := UserManager.AddUserGroup(lShStrTmp);
                 UserManager.SetUserGroup(l_UserID, l_Idx, True);}
                end;
               end;
              end;
             until TokenType = l3_ttEOF;
             if (not l_IsNewUser) and (not l_Edited) and (l_UGList.Count > 0) then
              l_Edited := True;
            finally
             FreeAndNil(lGrParser);
            end;
           finally
            FreeAndNil(lGrStr);
           end;
          end;

          if l_IsNewUser then
           Inc(theAddedCount)
          else
           if l_Edited then
            Inc(theChangedCount);
             
         end;// if (l_UserID = 0) or (aRegion = regAllRegions) or (aRegion = l_Region) then
        end
        else
         if FieldNum > 1 then // пустые строки просто пропускаем
          raise EAdminError.CreateFmt('Ошибка в файле CSV (строка %d)', [LineNum]);
        FieldNum := 0;
        l_Login := '';
        l_Password := '';
        lName := '';
        lGroups := '';
        lIsActive := 0;
        lIsAdmin := 0;
        lExactUserID := -1;
        Inc(LineNum);
        //Application.MainForm.Update;
       end;
     end;
    until lParser.TokenType = l3_ttEOF;
   finally
    FreeAndNil(l_UGList);
   end;
  finally
   FreeAndNil(lParser);
  end;
 finally
  FreeAndNil(lStream);
 end;
end;

function Ta2bMain.pm_GetIsConfiguredThroughServer: Boolean;
begin
 Result := f_ConfiguredThroughServer;
end;

function Ta2bMain.pm_GetIsSupervisor: Boolean;
begin
 Result := GlobalDataProvider.UserID = usSupervisor;
end;

function Ta2bMain.SortUsersProc(I,J: Longint): LongInt;
begin
 with GlobalDataProvider.UserManager.AllUsers do
 begin
  if TdaUserID(DataInt[I]) > TdaUserID(DataInt[J]) then
   Result := 1
  else
   if TdaUserID(DataInt[I]) < TdaUserID(DataInt[J]) then
    Result := -1
   else
    Result := 0;
 end; {with..}
end;

end.