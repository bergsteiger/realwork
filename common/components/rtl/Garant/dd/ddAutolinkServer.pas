unit ddAutolinkServer;

{ $Id: ddAutolinkServer.pas,v 1.11 2015/06/09 11:51:37 fireton Exp $ }

// $Log: ddAutolinkServer.pas,v $
// Revision 1.11  2015/06/09 11:51:37  fireton
// - погорячился с CleanupAutolinkServer
//
// Revision 1.10  2015/06/09 11:28:58  fireton
// - делаем AutoLinkServer правильным синглетоном
//
// Revision 1.9  2013/04/11 16:46:27  lulin
// - отлаживаем под XE3.
//
// Revision 1.8  2012/11/01 09:43:24  lulin
// - забыл точку с запятой.
//
// Revision 1.7  2012/11/01 07:45:49  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.6  2012/08/20 09:17:47  fireton
// - улучшенная диагностика ошибок (K 385484738)
//
// Revision 1.5  2012/08/14 11:37:21  fireton
// - отдельное поле номера дела в кэше автопростановщика
//
// Revision 1.4  2011/11/14 12:45:50  fireton
// - функция автопростановки ссылок с удалением старых, на выборке
//
// Revision 1.3  2011/06/03 11:13:48  fireton
// - процедура удаления сервера автолинковки
//
// Revision 1.2  2011/06/02 12:33:44  fireton
// - забыл вернуть значение
//
// Revision 1.1  2011/06/02 12:13:20  fireton
// - держим таблицы автопростановки ссылок постоянно открытыми
//

interface
uses
 l3ProtoObject,
 l3Except,

 DT_Types,
 dtIntf,

 ddAutolinkCache;

const
 sEnableAutolinkParam = 'EnableAL';

type
 TddAutolinkServer = class(Tl3ProtoObject)
 private
  f_Family: TFamilyID;
  f_MainTbl: array [TddAutolinkCacheType] of ITblInfo;
  f_VerTbl : array [TddAutolinkCacheType] of ITblInfo;
  procedure pm_SetFamily(const Value: TFamilyID);
 public
  procedure DropTables;
  function GetAutolinkCacheMainTableInfo(aType: TddAutolinkCacheType): ITblInfo;
  function GetAutolinkCacheVersionsTableInfo(aType: TddAutolinkCacheType): ITblInfo;
  property Family: TFamilyID read f_Family write pm_SetFamily;
 end;

 EAutolinkError = class (El3Error);
 EAutoLinkBadCache = class(EAutolinkError);

function AutolinkServer(const aFamily: TFamilyID): TddAutolinkServer;
procedure CleanupAutolinkServer;

implementation
uses
 SysUtils,

 HT_CONST,

 l3Base,

 DT_Table,
 DT_Serv,
 DT_Utils;

const
 g_AutolinkServer       : TddAutolinkServer = nil;
 g_MainStructChecked    : array [TddAutolinkCacheType] of Boolean = (False, False);
 g_VersionStructChecked : array [TddAutolinkCacheType] of Boolean = (False, False);

const
 c_BadStructMsg = 'Структура таблицы %s неверна. Перестройте кэш автопростановщика!';

procedure CleanupAutolinkServer;
begin
 FreeAndNil(g_AutolinkServer);
end;

function AutolinkServer(const aFamily: TFamilyID): TddAutolinkServer;
begin
 if g_AutolinkServer = nil then
 begin
  g_AutolinkServer := TddAutolinkServer.Create;
  l3System.AddExitProc(CleanupAutolinkServer);
 end;
 g_AutolinkServer.Family := aFamily;
 Result := g_AutolinkServer;
end;

procedure TddAutolinkServer.DropTables;
var
 l_CT: TddAutolinkCacheType;
begin
 for l_CT := dsLocal to dsRemote do
 begin
  f_MainTbl[l_CT] := nil;
  f_VerTbl[l_CT] := nil;
 end;
end;

procedure TddAutolinkServer.pm_SetFamily(const Value: TFamilyID);
begin
 if f_Family <> Value then
 begin
  DropTables;
  f_Family := Value;
 end;
end;

function TddAutolinkServer.GetAutolinkCacheMainTableInfo(aType: TddAutolinkCacheType): ITblInfo;
var
 l_Tbl: TdtTable;
 l_TableName: AnsiString;
begin
 if f_MainTbl[aType] = nil then
 begin
  l_TableName := GetALCacheMainTblPath(aType);
  l_Tbl := TdtTable.Create(GlobalHTServer.Family[f_Family].Path, '', l_TableName, TAB_SHARE);
  try
   l_Tbl.OpenTbl;
   if not g_MainStructChecked[aType] then
    if CheckTableStruct(l_Tbl.Handle, cALCacheMainTblStruct) then
     g_MainStructChecked[aType] := True
    else
     raise EAutoLinkBadCache.CreateFmt(c_BadStructMsg, [l_TableName]);
   f_MainTbl[aType] := l_Tbl;
  finally
   FreeAndNil(l_Tbl);
  end;
 end;
 Result := f_MainTbl[aType];
end;

function TddAutolinkServer.GetAutolinkCacheVersionsTableInfo(aType: TddAutolinkCacheType): ITblInfo;
var
 l_TableName: AnsiString;
 l_Tbl: TdtTable;
begin
 if f_VerTbl[aType] = nil then
 begin
  l_TableName := GetALCacheVerTblPath(aType);
  l_Tbl := TdtTable.Create(GlobalHTServer.Family[f_Family].Path, '', l_TableName, TAB_SHARE);
  try
   l_Tbl.OpenTbl;
   if not g_VersionStructChecked[aType] then
    if CheckTableStruct(l_Tbl.Handle, cALCacheVerTblStruct) then
     g_VersionStructChecked[aType] := True
    else
     raise EAutoLinkBadCache.CreateFmt(c_BadStructMsg, [l_TableName]);
   f_VerTbl[aType] := l_Tbl;
  finally
   FreeAndNil(l_Tbl);
  end;
 end;
 Result := f_VerTbl[aType];
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddAutolinkServer.pas initialization enter'); {$EndIf}
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddAutolinkServer.pas initialization leave'); {$EndIf}
finalization

end.
