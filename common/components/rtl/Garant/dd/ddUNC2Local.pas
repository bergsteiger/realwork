//..........................................................................................................................................................................................................................................................
unit ddUNC2Local;

{ $Id: ddUNC2Local.pas,v 1.15 2013/04/11 16:46:29 lulin Exp $}

// $Log: ddUNC2Local.pas,v $
// Revision 1.15  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.14  2011/09/19 05:27:51  narry
// - Ќе собирались проекты
//
{ Revision 1.13  2011/09/16 12:45:25  lulin
{ {RequestLink:278824896}
{
{ Revision 1.12  2007/03/26 09:34:01  fireton
{ - изменилс€ формат l3System.FreeLocalMem
{
{ Revision 1.11  2005/02/16 17:10:41  narry
{ - update: Delphi 2005
{
{ Revision 1.10  2004/09/13 14:19:41  lulin
{ - дл€ распределени€ пам€ти используем процедуры с подсчетом.
{ - избавилс€ от зависимости от RX.
{
{ Revision 1.9  2004/04/22 10:13:48  fireton
{ - add: Local2UNCPath: добавлен параметр ReturnEmptyIfLocal
{
{ Revision 1.8  2004/04/14 06:39:08  fireton
{ - change: Local2UNCPath теперь находит и подпапки у шары
{ - bug fix: Local2UNCPath теперь не реагирует на специальные системные шары (C$, ADMIN$)
{
{ Revision 1.7  2004/04/12 11:02:16  fireton
{ - change: CreateShare заменено на ShareFolder
{
{ Revision 1.6  2004/04/07 13:56:50  fireton
{ - add: новые функции Local2UNCPath и CreateShare
{
{ Revision 1.5  2004/04/03 09:29:45  fireton
{ - change: UNCName2IP - теперь возвращает пустую строку только в случае недоступности сервера
{}

{$I ddDefine.inc }

interface

function Local2UNCPath(const aPath: AnsiString; ReturnEmptyIfLocal: Boolean = True): AnsiString;

function UNCName2IP(const aUNCPath: AnsiString): AnsiString;

function UNCPath2Local(const aUNCPath: AnsiString): AnsiString;

procedure ShareFolder(aShareName, aPath: AnsiString);


implementation

Uses
 SysUtils, Windows, Classes,
 jclSysInfo,
 stNetAPI, Dialogs,

 l3Base
 ;

const
 ACCESS_FORUSER : DWORD = ACCESS_READ or ACCESS_WRITE or ACCESS_CREATE or ACCESS_EXEC or ACCESS_DELETE or ACCESS_ATRIB;

function GetServerName(const S: AnsiString): AnsiString;
var
 i: Integer;
begin
 i:= 3;
 while S[i] <> PathDelim do Inc(i);
 Result:= Copy(S, 3, i-3);
end;

function GetShareName(const S: AnsiString): AnsiString;
var
 i: Integer;
begin
 i:= Length(S);
 while S[i] <> PathDelim do Dec(i);
 Result:= Copy(S, i+1, Length(S));
end;

procedure GetUniversalName(aNetResource: PNetResource; aList: TStrings);
type
  PNetResourceArray = ^TNetResourceArray;
  TNetResourceArray = array[0..MaxInt div SizeOf(TNetResource) - 1] of TNetResource;
var
  I, BufSize, NetResult: Integer;
  Count, Size: LongWord;
  Drive: AnsiChar;
  NetHandle: THandle;
  NetResources: PNetResourceArray;
  RemoteNameInfo: array[0..1023] of Byte;
  S: AnsiString;
begin
 if WNetOpenEnum({RESOURCE_CONNECTED}RESOURCE_GLOBALNET, RESOURCETYPE_DISK, 0, aNetResource,
   NetHandle) <> NO_ERROR then Exit;
 try
   BufSize := 50 * SizeOf(TNetResource);
   l3System.GetLocalMem(NetResources, BufSize);
   try
     while True do
     begin
       Count := $FFFFFFFF;
       Size := BufSize;
       NetResult := WNetEnumResource(NetHandle, Count, NetResources, Size);
       if NetResult = ERROR_MORE_DATA then
       begin
         BufSize := Size;
         l3System.ReallocLocalMem(NetResources, BufSize);
         Continue;
       end;
       if NetResult <> NO_ERROR then Exit;
       for I := 0 to Count - 1 do
        with NetResources^[I] do
        begin
         if (lpRemoteName <> nil) then
          aList.Add(lpRemoteName);
         if NetResources^[I].dwDisplayType in [RESOURCEDISPLAYTYPE_DOMAIN,
                                               RESOURCEDISPLAYTYPE_NETWORK,
                                               RESOURCEDISPLAYTYPE_SERVER,
                                               RESOURCEDISPLAYTYPE_GROUP] then
         GetUniversalName(@NetResources^[I], aList);
        end;
     end;
   finally
     l3System.FreeLocalMem(NetResources);
   end;
 finally
   WNetCloseEnum(NetHandle);
 end;
end;

function Local2UNCPath(const aPath: AnsiString; ReturnEmptyIfLocal: Boolean = True): AnsiString;
var
 I: Integer;
 TotalEnt: Cardinal;
 EntRead: Cardinal;
 Res: NET_API_STATUS;
 X: DWORD;
 lPath, lShPath, lNetName: AnsiString;
 Buff, TmpBuff: Pointer;
begin
 Result := '';
 lPath := ExcludeTrailingPathDelimiter(ExpandUNCFileName(aPath));
 if Copy(lPath, 1, 2) = '\\' then
 begin
  Result := lPath;
  Exit;
 end;

 if not ReturnEmptyIfLocal then
  Result := lPath;

 lPath := AnsiUpperCase(lPath);
 EntRead := 0;
 try
  TmpBuff := nil;
  Res := StNetShareEnum('', 2, Buff, MAX_PREFERRED_LENGTH, EntRead, TotalEnt, nil);
  if Res <> NO_ERROR then
   Exit;
  TmpBuff := Buff;
  for I := 1 to EntRead do
  begin
   lShPath := WideString(PShare_Info_2(Buff)^.shi2_path);
   lShPath := AnsiUpperCase(ExcludeTrailingPathDelimiter(lShPath));
   lNetName := WideString(PShare_Info_2(Buff)^.shi2_netname);
   if (Pos(lShPath, lPath) = 1) and (lNetName[Length(lNetName)] <> '$') then
   begin
    Result := ExcludeTrailingPathDelimiter(lNetName+Copy(aPath, Length(lShPath)+1, MaxInt));
    Break;
   end;
   Buff := PAnsiChar(Buff) + SizeOf(TShare_Info_2);
  end;
  StNetApiBufferFree(TmpBuff);
  TmpBuff := nil;
  if Result = '' then
   Exit;
  Res := StNetServerGetInfo('', 100, Buff);
  if Res <> NO_ERROR then
   Exit;
  TmpBuff := Buff;
  Result := '\\'+WideString(PSERVER_INFO_100(Buff)^.sv100_name)+'\'+Result;
  StNetApiBufferFree(Buff);
  TmpBuff := nil;
 finally
  if TmpBuff <> nil then
   StNetApiBufferFree(TmpBuff);
 end;
end;

function UNCName2IP(const aUNCPath: AnsiString): AnsiString;
var
 lIP: AnsiString;
 lDomainName: AnsiString;
 X: Integer;
begin
 Result := aUNCPath;
 X := Pos('\\', aUNCPath);
 if X <> 1 then
  Exit;
 Result := ''; 
 X := 3;
 lDomainName := '';
 while (X <= Length(aUNCPath)) and (aUNCPath[X] <> '\') do
 begin
  lDomainName := lDomainName + aUNCPath[X];
  Inc(X);
 end;
 lIP := GetIPAddress(lDomainName);
 if lIP = '' then
  Exit;
 Result := '\\'+lIP+Copy(aUNCPath, X, MaxInt);
end;

function UNCPath2Local(const aUNCPath: AnsiString): AnsiString;
var
 l_NetResource: TNetResource;
 l_Info: Pointer;
 i: Integer;
 S, sIP: AnsiString;
 l_List: TStrings;
begin
 l_List:= TStringList.Create;
 try
  Result:= aUNCPath;
  with l_NetResource do
  begin
   dwScope:=RESOURCE_GLOBALNET;
   dwType:= RESOURCETYPE_ANY;
   dwDisplayType:= RESOURCEDISPLAYTYPE_SERVER;
   dwUsage:= 0;
   lpLocalName:= PAnsiChar(GetLocalComputerName);
   lpRemoteName:= PAnsiChar('\\'+GetIPAddress(lpLocalName));
   lpComment:= '';
   lpProvider:= '';
  end;
  GetUniversalName(@l_NetResource, l_List);
  S:= UpperCase(aUNCPath);
  sIP:= GetIPAddress(GetServerName(S));
  Delete(S, 3, Length(GetServerName(S)));
  Insert(SIP, S, 3);
  for i:= 0 to l_List.Count-1 do
  begin
   if UpperCase(l_List.Strings[i]) = ExtractFileDrive(S) then
   begin
    StNetShareGetInfo(GetServerName(l_List.Strings[i]),
                      GetShareName(l_List.Strings[i]), 2, l_Info);
    if l_Info <> nil then
    begin
     Delete(S, 1, Length(l_List.Strings[i]));
     Result:= TShare_Info_2(l_Info^).shi2_path+S;
     StNetApiBufferFree(l_Info);
     break;
    end;
   end;
  end;
 finally
  l_List.Free;
 end;
end;

procedure ShareFolder(aShareName, aPath: AnsiString);
var
 I: Integer;
 Res: NET_API_STATUS;
 PErr: Cardinal;
 ShInfo: TShare_Info_2;
 Str1, Str2: WideString;
begin
 if aShareName = '' then
 begin
  Str1 := ExcludeTrailingBackslash(aPath);
  I := Length(Str1);
  while (I > 0) and (not IsPathDelimiter(Str1, I)) do
   Dec(I);
  if I = 0 then
   raise Exception.Create('Ќеправильный путь дл€ создани€ разделенного ресурса');
  Delete(Str1, 1, I);
 end
 else
  Str1 := aShareName;
 with ShInfo do
 begin
  shi2_netname := @Str1[1];
  shi2_type := STYPE_DISKTREE;
  shi2_remark := nil;
  shi2_permissions := ACCESS_FORUSER;
  shi2_max_uses := High(DWORD);
  shi2_current_uses := 0;
  Str2 := aPath;
  shi2_path := @Str2[1];
  shi2_passwd := nil;
 end;
 Res := StNetShareAdd('', 2, @ShInfo, PErr);
 if Res <> NO_ERROR then
  raise Exception.Create('ќшибка при создании разделенного ресурса');
end;



end.

