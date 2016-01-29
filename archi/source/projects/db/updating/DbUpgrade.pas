unit DbUpgrade;
{///////////////////////////////////////////////////////////////////////////////
 ��������� ��������� � ��������� ������ ��.
 ����� ������� ����������� ����� ������ ������ �� �������.
 ��������,
  ���������������.������ = 103
  ���������������������.������ = 106
  ���� ������� �� �� ������ 109. �����, ��� �����, ��������, �����:
                                                                   Prev.   Ver.
  Upgrade���������������To104;            // ���������������       103 --> 104
  Upgrade���������������������To105;      // ��������������������� 101 --> 105
  Upgrade���������������To106;            // ���������������       104 --> 106
  Upgrade���������������������To107;      // ��������������������� 105 --> 107
  Upgrade���������������To108;            // ���������������       106 --> 108
  Upgrade���������������To109;            // ���������������       108 --> 109

  � ���������� -
   ���������������.������ = 109
   ���������������������.������ = 107
  ��� �� ���� ������� � ������� ��������� ������������ �� � ��������.
///////////////////////////////////////////////////////////////////////////////}

{ $Id: DbUpgrade.pas,v 1.14 2011/12/12 14:02:52 fireton Exp $ }
// $Log: DbUpgrade.pas,v $
// Revision 1.14  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.13  2007/03/12 11:18:40  fireton
// - ��������� *.bak ������ �� ����� ����� ������
//
// Revision 1.12  2007/02/22 15:00:58  fireton
// - ������� �� 64 ���� � HyTech
//
// Revision 1.11  2005/12/09 14:13:52  step
// ��������� ������. �������� � �������
//
// Revision 1.10  2004/05/26 09:59:44  step
// �������� CanExecute
//
// Revision 1.9  2004/05/26 08:59:48  step
// ���������� �������� ������� ������
//
// Revision 1.8  2004/05/25 15:41:49  step
// new: classes TDocBaseUpgrade, TAdminBaseUpgrade
//
// Revision 1.7  2004/05/07 17:37:47  step
// ���� ������ �����������
//
// Revision 1.6  2004/03/10 14:33:09  step
// ������� �������� "����������-��������������"
//
// Revision 1.5  2004/03/09 18:40:03  step
// �������� update � 104 (��������� ����� ����. FILE)
//
// Revision 1.4  2004/03/05 09:08:50  step
// ������ �����������
//
// Revision 1.3  2004/03/04 18:03:10  step
// ��������� �������� ����������-��������������
//
// Revision 1.2  2004/03/02 15:47:00  step
// ���� ������ ���������
//
// Revision 1.1  2004/03/01 19:04:54  step
// ������� � CVS
//

interface

uses
 DT_DbReformer;

type
 TTableNamesArray = array of string;

 TUpgrade = class(TObject)
 private
  f_RestorableTables: TTableNamesArray;
 protected
  f_DbReformer: TDbReformer;

  function SaveBackup: Boolean; virtual;
   // ������� ��������� �����
  procedure DeleteBackup; virtual;
   // ������� ��������� �����
  function Undo: Boolean; virtual;
   // ��������������� ������ �� ��������� �����

  procedure AddToRestorableList(const aFullTableName: string);
   // ���������� ����� ������� � ������ (������������ ��������� ����������-��������������)

  function DoJob: Boolean; virtual;
  function CanExecute: Boolean;
  class function CurVersion: Integer; virtual; abstract;
 protected
  // ��� ��������������� � ��������
  procedure ModifyBd; virtual; abstract;           // ���������� ����������� ��
  class function NameEx: string; virtual; abstract;
  procedure AdvanceVersionNumber; virtual; abstract;
  procedure InitRestorableTableList; virtual;      // ������������ ������ �������������� ������ ��

  procedure AfterSaveBackup; virtual;      // �������������� �������� ��� ���������� ��������� �����
  procedure AfterUndo; virtual;      // �������������� �������� ��� �������������� �� ��������� �����
  procedure AfterDeleteBackup; virtual;   // �������������� �������� ��� �������� ��������� �����
 public
  constructor Create(aDbReformer: TDbReformer);
  destructor Free;
  class procedure Execute; virtual;

 public
  // ��� ��������������� � ��������
  class function PrevVersion: Integer; virtual; abstract; // �����. ����� ������. ������ (���, �� ������� � ������������� update)
  class function Version: Integer; virtual; abstract;     // �����. ����� ������, ������� ����� ����� ��������� update'�
 end;

 TUpgradeClass = class of TUpgrade;

 TDocBaseUpgrade = class(TUpgrade)
 protected
  class function NameEx: string; override;
  class function CurVersion: Integer; override;
  procedure AdvanceVersionNumber; override;
  procedure AfterDeleteBackup; override;
 end;

TAdminBaseUpgrade = class(TUpgrade)
 protected
  class function NameEx: string; override;
  class function CurVersion: Integer; override;
  procedure AdvanceVersionNumber; override;
  procedure AfterDeleteBackup; override;
 end;


implementation

uses
 SysUtils,
 l3FileUtils,
 UpdateManager;

resourcestring
 c_BackupFileMask = '*.bak';

{ TUpgrade }

procedure TUpgrade.AddToRestorableList(const aFullTableName: string);
begin
 if f_RestorableTables = nil then
  SetLength(f_RestorableTables, 1)
 else
  SetLength(f_RestorableTables, Length(f_RestorableTables) + 1);

 f_RestorableTables[Length(f_RestorableTables) - 1] := aFullTableName;
end;

procedure TUpgrade.AfterDeleteBackup;
begin
end;

procedure TUpgrade.AfterSaveBackup;
begin
end;

procedure TUpgrade.AfterUndo;
begin
end;

function TUpgrade.CanExecute: Boolean;
begin
 Result := CurVersion = PrevVersion;
end;

constructor TUpgrade.Create(aDbReformer: TDbReformer);
begin
 f_DbReformer := aDbReformer;
end;

procedure TUpgrade.DeleteBackup;
begin
 with f_DbReformer do
 try
  if DirectoryExists(DirBackup) then
   DelDir(DirBackup);
  AfterDeleteBackup; 
  Log('��������� ����� ������ ���������� ������ ' + NameEx + ' �������.');
 except
  on E: Exception do
  begin
   Log(E.Message);
   Log('�� ������� ������� ���������� ������ ���������� ������.');
  end;
 end;
end;

function TUpgrade.DoJob: Boolean;
begin
 Result := False;
 if CanExecute then
  with f_DbReformer do
  begin
   Log('=== ���������� ' + NameEx + ' �� ������ ' + IntToStr(Version) + ' ===');
   InitRestorableTableList;
   if SaveBackup then
   begin
    try
     ModifyBd; // ����� ���� ����� ��������� ����������

     // ������ ����� ������
     AdvanceVersionNumber;
     Log('���������� ' + NameEx + ' �� ������ ' + IntToStr(Version) + ' ��������� �������.');

     DeleteBackup;
    except
     on E: Exception do
     begin
      Error(E.Message);
      Log('������ ��� ���������� ' + NameEx + ' �� ������ ' + IntToStr(Version) + '.');

      if Undo then
       DeleteBackup
      else
       Log('�� ������� ��c��������� ' + NameEx + '.');
     end;
    end; // try-except
   end;
  end;
end;

class procedure TUpgrade.Execute;
begin
 if CurVersion = PrevVersion then
  with Create(TUpdateManager.DbReformer) do
  try
   DoJob;
  finally
   Free;
  end;
end;

destructor TUpgrade.Free;
begin
 f_RestorableTables := nil;
end;

procedure TUpgrade.InitRestorableTableList;
begin
 f_RestorableTables := nil;
end;

function TUpgrade.SaveBackup: Boolean;
var
 I: Integer;
begin
 with f_DbReformer do
 try
  Log('���������� ��������� ����� ������ ���������� ������ ' + NameEx + '.');
  // �������� ����� BACKUP
  if not DirectoryExists(DirBackup) then
   ForceDirectories(DirBackup);

  for I := 0 to Length(f_RestorableTables) - 1 do
   SaveTable(f_RestorableTables[I]);

  AfterSaveBackup;
   
  Result := True;
 except
  on E: Exception do
  begin
   Log(E.Message);
   Log('�� ������� ��������� ���������� ��������� ����� ������ ���������� ������.');
   Result := False;
  end;
 end;
end;

function TUpgrade.Undo: Boolean;
var
 I: Integer;
begin
 with f_DbReformer do
 try
  for I := 0 to Length(f_RestorableTables) - 1 do
   RestoreTable(f_RestorableTables[I]);

  AfterUndo;

  Result := True;
  Log('������������� ��������� ' + NameEx + ' ������ ' + IntToStr(PrevVersion));
 except
  on E: Exception do
  begin
   Log(E.Message);
   Log('�� ������� ������������ ��������� ' + NameEx + ' ������ ' + IntToStr(PrevVersion));
   Result := False;
  end;
 end;
end;

{ TDocBaseUpgrade }

procedure TDocBaseUpgrade.AdvanceVersionNumber;
begin
 f_DbReformer.CurFamilyVersion := Version;
end;

procedure TDocBaseUpgrade.AfterDeleteBackup;
begin
 inherited;
 DeleteFilesByMask(f_DbReformer.FamilyFolder, c_BackupFileMask);
end;

class function TDocBaseUpgrade.CurVersion: Integer;
begin
 Result := TUpdateManager.DbReformer.CurFamilyVersion;
end;

class function TDocBaseUpgrade.NameEx: string;
begin
 Result := '���� ����������';
end;

{ TAdminBaseUpgrade }

procedure TAdminBaseUpgrade.AdvanceVersionNumber;
begin
 f_DbReformer.MainFolderVersion := Version;
end;

procedure TAdminBaseUpgrade.AfterDeleteBackup;
begin
 inherited;
 DeleteFilesByMask(f_DbReformer.MainFolder, c_BackupFileMask);
end;

class function TAdminBaseUpgrade.CurVersion: Integer;
begin
 Result := TUpdateManager.DbReformer.MainFolderVersion;
end;

class function TAdminBaseUpgrade.NameEx: string;
begin
 Result := ' ���������������� ����';
end;

end.
