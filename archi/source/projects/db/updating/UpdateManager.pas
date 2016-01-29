unit UpdateManager;

{ $Id: UpdateManager.pas,v 1.48 2015/02/10 08:04:16 fireton Exp $ }
// $Log: UpdateManager.pas,v $
// Revision 1.48  2015/02/10 08:04:16  fireton
// - ���������� ��������������
//
// Revision 1.47  2013/12/24 07:02:30  fireton
// - �� ������������������ ���������� ���������� (�� ������� ���� �� ����������)
//
// Revision 1.46  2013/12/20 07:58:43  fireton
// - ������ �� 135 ������ ����
//
// Revision 1.45  2013/06/26 09:33:16  fireton
// - 134 ������ ����
//
// Revision 1.44  2013/03/26 12:23:05  fireton
// - 133 ������ ����
//
// Revision 1.43  2012/03/12 07:40:03  fireton
// - ����� ��������� ����������� ����
//
// Revision 1.42  2012/03/12 07:28:18  fireton
// - ����������� ���� ����� ������� ����������
//
// Revision 1.41  2012/02/08 07:29:49  fireton
// - ����������� ���������� ������
//
// Revision 1.40  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.39  2009/04/09 08:36:36  fireton
// - ���������� �����������
//
// Revision 1.38  2009/02/09 10:54:17  fireton
// - ������ ���� 131
//
// Revision 1.37  2007/11/28 12:27:07  fireton
// - ���������� ���� �� ������ 130
//
// Revision 1.36  2007/09/06 12:26:12  fireton
// - 129 ����������
//
// Revision 1.35  2007/08/21 14:05:28  fireton
// - upd 128
//
// Revision 1.34  2007/06/19 09:47:25  fireton
// - Doc Update to 127
//
// Revision 1.33  2007/05/04 11:59:58  fireton
// - ���������� �������� �����
//
// Revision 1.32  2007/04/18 12:38:22  fireton
// - update ��������� ���� �� 126 (�������)
//
// Revision 1.31  2007/03/12 13:55:17  fireton
// - bug fix: �� ���������������� ACCESS.DOCUM_GR
//
// Revision 1.30  2007/03/12 11:21:17  fireton
// - ������� ID � �������� + ������� USER ID
//
// Revision 1.29  2007/02/22 15:00:58  fireton
// - ������� �� 64 ���� � HyTech
//
// Revision 1.28  2006/06/08 15:55:56  fireton
// - ���������� � �������� �� ������� User ID
//
// Revision 1.27.4.1  2006/06/08 09:26:58  fireton
// - ������� User ID �� Longword
//
// Revision 1.27  2005/12/12 07:24:48  step
// ����� update115 � ��� ���������� ���������� � update114
//
// Revision 1.26  2005/12/09 14:14:40  step
// �������� ��������� update
//
// Revision 1.25  2005/10/17 09:20:48  step
// ���������� 114
//
// Revision 1.24  2005/09/09 16:58:11  step
// ���������� � ������� GUDT ����� �����.
// ����� �������� DICTSOUR.
//
// Revision 1.23  2005/02/25 15:14:16  step
// ���������� ����� ������� DT#5E (ver. 112).
//
// Revision 1.22  2005/02/14 15:16:52  step
// ������������ ������ c_Upgrades
//
// Revision 1.21  2005/02/14 13:36:09  step
// ����������� WORD->DWRD ���������� �� ����� ������� ����, ������ � �������������� 111,112 -> 120,121
//
// Revision 1.20  2005/02/09 17:35:31  step
// ����� ��������� �������� � ���������� �������
//
// Revision 1.19  2005/02/08 16:47:42  step
// new: TUpdateManager.MaxVersion
//
// Revision 1.18  2005/01/19 11:29:09  step
// �������� UpgradeTo111 � UpgradeTo112 (��� �������� ��������� ���� ����� WORD --> DWRD)
//
// Revision 1.17  2004/12/03 18:17:34  step
// ���������� ����� ID � �.�. ���� WORD � �������� ��������� MAIN � ���� DWRD. (ver. 112)
//
// Revision 1.16  2004/12/02 18:04:47  step
// �� ��������� - update �� 111 ������ - ��������
//
// Revision 1.15  2004/12/02 15:55:23  step
// ���������� ����� ID � DICT_ID � �������� DT#* � LNK#* � ���� DWRD (ver. 111)
//
// Revision 1.14  2004/10/25 16:12:41  step
// ���������� ��������� (ver. 110)
//
// Revision 1.13  2004/10/20 15:50:23  step
// ��������� ��������� ������� garant.DT#5 (ver. 109)
//
// Revision 1.12  2004/07/21 12:53:54  step
// ��������-�������� ���� � HT'� ���������� ����
//
// Revision 1.11  2004/05/26 09:01:50  step
// ��������� ��������� ������� main.FREE
//
// Revision 1.10  2004/05/25 15:43:01  step
// new: global var v_DbReformer: TDbReformer
//
// Revision 1.9  2004/05/07 17:37:47  step
// ���� ������ �����������
//
// Revision 1.8  2004/05/06 14:17:01  step
// ���������� ��������� � ����. FREE
//
// Revision 1.7  2004/04/20 09:46:07  step
// ��������� ����. FREE (ver. 106)
//
// Revision 1.6  2004/04/01 08:19:40  step
// new: procedure ApplyJournalActions - ���������� �������
// new: function DeleteLinkDictDuplicates - �������� ���������� ���� LNK_DICT
// new: function DeleteBadLinkToDict - �������� "�������" ������
//
// Revision 1.5  2004/03/17 13:00:10  step
// ��������� update (���������� ���� PRIVATE � ����. DT#A)
//
// Revision 1.4  2004/03/09 18:40:03  step
// �������� update � 104 (��������� ����� ����. FILE)
//
// Revision 1.3  2004/03/04 18:02:37  step
// ��������� ���������� �103
//
// Revision 1.2  2004/03/02 15:47:00  step
// ���� ������ ���������
//
// Revision 1.1  2004/03/01 19:04:54  step
// ������� � CVS
//

interface

uses
 DT_DbInfo,
 DT_DbReformer,
 DbUpgrade
 ;

{$I ProjectDefine.inc} 

type
 TUpdateManager = class(TObject)
 public
  constructor Create(aDbInfo: TDbInfo;
                     aShowToUserProc: TShowToUserProc = nil);
  destructor Free;
  procedure Execute;
  class function DbReformer: TDbReformer;
  class function MaxGarantVersion: Integer;
  class function MaxMainVersion: Integer;
 end;

implementation

uses
 SysUtils, Math,
 HT_DLL, HT_CONST, DT_Err,
 {$IFNDEF HT_MODE64}
 UpgradeTo101,
 UpgradeTo102,
 UpgradeTo103,
 UpgradeTo104,
 UpgradeTo105,
 UpgradeTo106,
 UpgradeTo107,
 UpgradeTo108,
 UpgradeTo109,
 UpgradeTo110,
 UpgradeTo111,
 UpgradeTo112,
 UpgradeTo113,
 UpgradeTo114;
 {$ELSE}
 UpgradeTo115,
 UpgradeTo120,
 UpgradeTo125,
 UpgradeTo126,
 UpgradeTo127,
 UpgradeFamilyTo127,
 UpgradeTo128,
 UpgradeTo129,
 UpgradeTo130,
 UpgradeTo131,
 UpgradeTo132,
 UpgradeTo133,
 UpgradeTo134,
 UpgradeTo135
 ;
 {$ENDIF HT_MODE64}

const
 {$IFNDEF HT_MODE64}
 c_UpgradesAmount = 14;
 {$ELSE}
 c_UpgradesAmount = 23;
 {$ENDIF HT_MODE64}

 c_Upgrades: array[0..c_UpgradesAmount - 1] of TUpgradeClass = (
 {$IFNDEF HT_MODE64}
  TUpgradeTo101,
  TUpgradeTo102,
  TUpgradeTo103,
  TUpgradeTo104,
  TUpgradeTo105,
  TUpgradeTo106,
  TUpgradeTo107,
  TUpgradeTo108,
  TUpgradeTo109,
  TUpgradeTo110,
  TUpgradeTo111,
  TUpgradeTo112,
  TUpgradeTo113,
  TUpgradeTo114
 {$ELSE}
  TUpgradeTo115_MAIN,
  TUpgradeTo115_DOC,
  TUpgradeTo120,
  TUpgradeTo120_MAIN,
  TUpgradeTo125_MAIN,
  TUpgradeTo125_DOC,
  TUpgradeTo126,
  TUpgradeTo127,
  TUpgradeTo127_DOC,
  TUpgradeTo128_MAIN,
  TUpgradeTo128_DOC,
  TUpgradeTo129_MAIN,
  TUpgradeTo129_DOC,
  TUpgradeTo130_MAIN,
  TUpgradeTo130_DOC,
  TUpgradeTo131_MAIN,
  TUpgradeTo131_DOC,
  TUpgradeTo132_MAIN,
  TUpgradeTo132_DOC,
  TUpgradeTo133_MAIN,
  TUpgradeTo133_DOC,
  TUpgradeTo134_MAIN,
  TUpgradeTo134_DOC
  //,TUpgradeTo135_MAIN
  //,TUpgradeTo135_DOC
 {$ENDIF HT_MODE64}
 );

var
 v_DbReformer: TDbReformer;

{ TUpdateManager }

constructor TUpdateManager.Create(aDbInfo: TDbInfo;
                                  aShowToUserProc: TShowToUserProc = nil);
begin
 v_DbReformer := MakeReformer(aDbInfo, aShowToUserProc);
 v_DbReformer.InitLog;
 v_DbReformer.InitHt;
end;

class function TUpdateManager.DbReformer: TDbReformer;
begin
 if v_DbReformer <> nil then
  Result := v_DbReformer
 else
  raise Exception.Create('������ � ���������. v_DbReformer = nil');
end;

procedure TUpdateManager.Execute;
var
 I: Integer;
 l_Ctrl: THANDLE;
 l_CtrlName: string;
begin
 DbReformer.Log('================== ' + DateToStr(SysUtils.Date) + ' ==================');
 DbReformer.Log('������ ���� ������...');
 l_CtrlName := DbReformer.MainTable('CTRL');
 try
  HT(htTableOpen(PChar(l_CtrlName) ,nil, nil, TAB_PRIVATE, l_Ctrl));
 except
  DbReformer.Log('�� ������ ��������� ���� � ����������� ������');
  DbReformer.Log('====== ���������� ���������� ======');
  Exit;
 end;
 try
  DbReformer.Log('������� ������ ���� ����������: ' + IntToStr(DbReformer.CurFamilyVersion));
  DbReformer.Log('������� ������ ���������������� ����: ' + IntToStr(DbReformer.MainFolderVersion));

  for I := 0 to c_UpgradesAmount - 1 do
   c_Upgrades[I].Execute;
 finally
  DbReformer.Log('������������ ���� ������...');
  htTableClose(l_Ctrl);
 end;
 DbReformer.Log('======== ���������� ��������� ========');
end;

class function TUpdateManager.MaxGarantVersion: Integer;
var
 I: Integer;
begin
 Result := -1;
 for I := 0 to c_UpgradesAmount - 1 do
  if c_Upgrades[I].ClassParent = TDocBaseUpgrade then
   Result := Max(Result, c_Upgrades[I].Version);
end;

class function TUpdateManager.MaxMainVersion: Integer;
var
 I: Integer;
begin
 Result := -1;
 for I := 0 to c_UpgradesAmount - 1 do
  if c_Upgrades[I].ClassParent = TAdminBaseUpgrade then
   Result := Max(Result, c_Upgrades[I].Version);
end;

destructor TUpdateManager.Free;
begin
 v_DbReformer.CloseHt;
 v_DbReformer.DeleteHlkFiles;
 v_DbReformer.CloseLog;

 FreeAndNil(v_DbReformer);
end;

initialization
 v_DbReformer := nil;
end.

