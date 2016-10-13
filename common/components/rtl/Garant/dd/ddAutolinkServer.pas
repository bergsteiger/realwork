unit ddAutolinkServer;

{ $Id: ddAutolinkServer.pas,v 1.13 2016/10/13 09:46:58 fireton Exp $ }

// $Log: ddAutolinkServer.pas,v $
// Revision 1.13  2016/10/13 09:46:58  fireton
// - ��������� ������������ � ������� ������� �� ����������� �� GlobalHtServer
//
// Revision 1.12  2016/06/16 05:40:04  lukyanets
// ������������ UserManager �� ����� ������
//
// Revision 1.11  2015/06/09 11:51:37  fireton
// - ����������� � CleanupAutolinkServer
//
// Revision 1.10  2015/06/09 11:28:58  fireton
// - ������ AutoLinkServer ���������� �����������
//
// Revision 1.9  2013/04/11 16:46:27  lulin
// - ���������� ��� XE3.
//
// Revision 1.8  2012/11/01 09:43:24  lulin
// - ����� ����� � �������.
//
// Revision 1.7  2012/11/01 07:45:49  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.6  2012/08/20 09:17:47  fireton
// - ���������� ����������� ������ (K 385484738)
//
// Revision 1.5  2012/08/14 11:37:21  fireton
// - ��������� ���� ������ ���� � ���� �����������������
//
// Revision 1.4  2011/11/14 12:45:50  fireton
// - ������� ��������������� ������ � ��������� ������, �� �������
//
// Revision 1.3  2011/06/03 11:13:48  fireton
// - ��������� �������� ������� ������������
//
// Revision 1.2  2011/06/02 12:33:44  fireton
// - ����� ������� ��������
//
// Revision 1.1  2011/06/02 12:13:20  fireton
// - ������ ������� ��������������� ������ ��������� ���������
//

interface
uses
 l3Interfaces,
 l3ProtoObject,
 l3Except,

 daTypes,
 dtIntf,

 ddAutolinkCache;

const
 sEnableAutolinkParam = 'EnableAL';

type
 TddAutolinkServer = class(Tl3ProtoObject, Il3ItemNotifyRecipient)
 private
  f_Family: TdaFamilyID;
  f_MainTbl: array [TddAutolinkCacheType] of ITblInfo;
  f_VerTbl : array [TddAutolinkCacheType] of ITblInfo;
  procedure pm_SetFamily(const Value: TdaFamilyID);
 protected
  procedure Cleanup; override;
  procedure Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
 public
  constructor Create;
  procedure DropTables;
  function GetAutolinkCacheMainTableInfo(aType: TddAutolinkCacheType): ITblInfo;
  function GetAutolinkCacheVersionsTableInfo(aType: TddAutolinkCacheType): ITblInfo;
  property Family: TdaFamilyID read f_Family write pm_SetFamily;
 end;

 EAutolinkError = class (El3Error);
 EAutoLinkBadCache = class(EAutolinkError);

function AutolinkServer(const aFamily: TdaFamilyID): TddAutolinkServer;
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
 c_BadStructMsg = '��������� ������� %s �������. ����������� ��� �����������������!';

procedure CleanupAutolinkServer;
begin
 FreeAndNil(g_AutolinkServer);
end;

function AutolinkServer(const aFamily: TdaFamilyID): TddAutolinkServer;
begin
 if g_AutolinkServer = nil then
 begin
  g_AutolinkServer := TddAutolinkServer.Create;
  l3System.AddExitProc(CleanupAutolinkServer);
 end;
 g_AutolinkServer.Family := aFamily;
 Result := g_AutolinkServer;
end;

constructor TddAutolinkServer.Create;
begin
 inherited Create;
 Il3ChangeNotifier(GlobalHtServer).Subscribe(Il3ItemNotifyRecipient(Self));
end;

procedure TddAutolinkServer.Cleanup;
begin
 DropTables;
 inherited;
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

procedure TddAutolinkServer.pm_SetFamily(const Value: TdaFamilyID);
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

procedure TddAutolinkServer.Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
begin
 if aOperation = sni_Destroy then
  DropTables;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddAutolinkServer.pas initialization enter'); {$EndIf}
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddAutolinkServer.pas initialization leave'); {$EndIf}
finalization

end.
