unit UpgradeTo121;

// ���������� ����� ID � �.�. ���� WORD � �������� ��������� MAIN � ���� DWRD.
// � ��������� - PASS.USER_ID, USERS.ID, GULNK.*, GUDT.ID, ACCESS2.USER_GR,
// ACCESS2.DOCUM_GR, FAMILY.DOCUM_GR.

{ $Id: UpgradeTo121.pas,v 1.4 2011/12/12 14:02:52 fireton Exp $ }

// $Log: UpgradeTo121.pas,v $
// Revision 1.4  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.3  2007/12/03 14:00:54  fireton
// - ���������� updater �� ���� ������ dt_const � �������� ������������ �������� ���������������
//
// Revision 1.2  2007/03/12 11:21:17  fireton
// - ������� ID � �������� + ������� USER ID
//
// Revision 1.1  2005/02/14 13:36:09  step
// ����������� WORD->DWRD ���������� �� ����� ������� ����, ������ � �������������� 111,112 -> 120,121
//
// Revision 1.3  2005/02/01 12:07:03  step
// � ����. DICTSRC2 ���� ��������� ���� WORD
//
// Revision 1.2  2005/01/19 11:29:09  step
// �������� UpgradeTo111 � UpgradeTo121 (��� �������� ��������� ���� ����� WORD --> DWRD)
//
// Revision 1.1  2004/12/03 18:21:17  step
// ���������� ����� ID � �.�. ���� WORD � �������� ��������� MAIN � ���� DWRD. (ver. 121)
//

interface

uses
 DT_DbReformer,
 DbUpgrade;

type

 TUpgradeTo121 = class(TAdminBaseUpgrade)
 private
  procedure ModifyTable(const aTableName: string;
                        const aFieldNums: TFieldNums);
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 108
  class function Version: Integer; override;     // 121
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc} 

const
 TEMP_TABLE = 'TEMP_TBL';

class function TUpgradeTo121.PrevVersion: Integer;
begin
 //raise Exception.Create('�� ������ TUpgradeTo121.PrevVersion. ���������!');
 Result := 115;
end;

procedure fn_ChangeFieldsType(var aStruct: TElemArray; aData: Pointer = nil);
var
 I: Integer;
 l_FieldNums: PFieldNums absolute aData;
begin
 if l_FieldNums = nil then
  Exit;

 for I := 0 to Length(l_FieldNums^) - 1 do
  aStruct[l_FieldNums^[I]].cType := ET_DWRD;
end;

procedure TUpgradeTo121.ModifyBd;
var
 l_FieldNums: TFieldNums;
begin
 try
  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 2;
  ModifyTable('PASS',     l_FieldNums);

  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 0;
  ModifyTable('USERS',    l_FieldNums);

  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 0;
  ModifyTable('GUDT',     l_FieldNums);

  SetLength(l_FieldNums, 2);
  l_FieldNums[0] := 0;
  l_FieldNums[1] := 1;
  ModifyTable('GULNK',    l_FieldNums);

  SetLength(l_FieldNums, 2);
  l_FieldNums[0] := 0;
  l_FieldNums[1] := 2;
  ModifyTable('ACCESS',  l_FieldNums);

  SetLength(l_FieldNums, 1);
  l_FieldNums[0] := 2;
  ModifyTable('FAMILY',   l_FieldNums);

 finally
  l_FieldNums := nil;
 end;
end;

class function TUpgradeTo121.Version: Integer;
begin
 Result := 121;
end;

procedure TUpgradeTo121.InitRestorableTableList;
const
 UPD_TABLES_AMOUNT = 6;
 UPD_TABLES: array [0..UPD_TABLES_AMOUNT - 1] of string =
  ('PASS', 'USERS', 'GUDT', 'GULNK', 'ACCESS', 'FAMILY');
var
 I: Integer;
begin
 inherited;

 for I := 0 to UPD_TABLES_AMOUNT - 1 do
  AddToRestorableList(f_DbReformer.MainTable(UPD_TABLES[I]));
end;

procedure TUpgradeTo121.ModifyTable(const aTableName: string;
                                    const aFieldNums: TFieldNums);
begin
 with f_DbReformer do
 begin
  Log('�������� ������ ������� ' + aTableName + ' � ����� ����������.');
  CopyTableStruct(MainTable(aTableName),
                  MainTable(TEMP_TABLE),
                  fn_ChangeFieldsType,
                  @aFieldNums);

  Log('����������� ������ �� ������ ������� ' + aTableName + ' � �����.');
  CopyData(MainTable(aTableName),
           MainTable(TEMP_TABLE));

  Log('�������� ������ ������� ' + aTableName + ' .');
  htDropTable(PChar(MainTable(aTableName)),
              TablePassword(MainTable(aTableName)),
              TablePassword(MainTable(aTableName)));

  Log('�������������� ����� ������� � ' + aTableName + ' .');
  htTableRename(PChar(MainTable(TEMP_TABLE)),
                TablePassword(MainTable(TEMP_TABLE)),
                TablePassword(MainTable(TEMP_TABLE)),
                PChar(MainTable(aTableName)));
 end; // with
end;

end.

