unit UpgradeTo111;
// ���������� ����� ������ DT#I � LNK#I (�� ��������� ��������� ����������� � DT#D � LNK#D).
// ���������� ������ ���� HasAnno � ������� FILE.
// ���������� ������ � ������� FREE (DT#I, 1, 65534).


{ $Id: UpgradeTo111.pas,v 1.12 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo111.pas,v $
// Revision 1.12  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.11  2007/12/03 14:00:54  fireton
// - ���������� updater �� ���� ������ dt_const � �������� ������������ �������� ���������������
//
// Revision 1.10  2005/02/22 16:10:49  step
// ���������� ������ ���� � ����. FILE
//
// Revision 1.9  2005/02/17 11:14:55  step
// ��������� ��� � ������ � ����. FREE
//
// Revision 1.8  2005/02/14 15:18:24  step
// ��������� ����� ������� DT#I � LNK#I
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo111 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 110
  class function Version: Integer; override;     // 111
 end;

implementation

uses
 SysUtils,
 Ht_Dll, Ht_Const,
 DT_DbReformer;

{$INCLUDE nodt_const.inc} 

type
 TFreeRec = packed record
  TblName : array [0..7] of Char;
  FreeNum : Integer;
  Limit   : Integer;
 end;

const
 DT_FREE = 'FREE001';
 NEW_REC: TFreeRec = (TblName: 'DT#I'; FreeNum: 1; Limit: 65534);
 DT_FILE = 'FILE001';
 TEMP_DT_FILE = 'FILE_NEW';

class function TUpgradeTo111.PrevVersion: Integer;
begin
 Result := 110;
end;

procedure fn_AddFieldToTableFile(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_FieldName = 'HasAnno';
begin
 SetLength(aStruct, Length(aStruct) + 1);

 // ���������� ���� HasAnno
 FillChar(aStruct[14], SizeOf(aStruct[14]), #0);
 with aStruct[14] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_BYTE;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName;
 end;
end;

procedure TUpgradeTo111.ModifyBd;
var
 l_TableHandle: HT_Const.THANDLE;
begin
 with f_DbReformer do
 begin

// ���������� ����� ������ DT#I � LNK#I (�� ��������� ��������� ����������� � DT#D � LNK#D).
  Log('�������� ����� ������� DT#I.');
  CopyTableStruct(FamilyTable('DT#D001'), FamilyTable('DT#I001'));

  Log('�������� ����� ������� LNK#I.');
  CopyTableStruct(FamilyTable('LNK#D001'), FamilyTable('LNK#I001'));

// ���������� ������ ���� HasAnno � ������� FILE.
  Log('�������� ����� ������ ������� FILE � ����� HasAnno');
  CopyTableStruct(FamilyTable(DT_FILE),
                  FamilyTable(TEMP_DT_FILE),
                  fn_AddFieldToTableFile);

  Log('����������� ������ �� ������ ������� � �����');
  CopyData(FamilyTable(DT_FILE),
           FamilyTable(TEMP_DT_FILE));

  Log('�������� ������ �������');
  htDropTable(PChar(FamilyTable(DT_FILE)),
                    TablePassword(FamilyTable(DT_FILE)),
                    TablePassword(FamilyTable(DT_FILE)));

  Log('�������������� ����� �������');
  htTableRename(PChar(FamilyTable(TEMP_DT_FILE)),
                TablePassword(FamilyTable(TEMP_DT_FILE)),
                TablePassword(FamilyTable(TEMP_DT_FILE)),
                PChar(FamilyTable(DT_FILE)));

// ���������� ������ � ������� FREE (DT#I, 1, 65534).
  Log('���������� � ������� FREE ������ "DT#I, 1, 65534"');
  htTableOpen(PChar(FamilyTable(DT_FREE)),
              TablePassword(FamilyTable(DT_FREE)),
              TablePassword(FamilyTable(DT_FREE)),
              TAB_PRIVATE,
              l_TableHandle);
  try
   htRecordAdd(l_TableHandle, @NEW_REC);
  finally
   htTableClose(l_TableHandle);
  end;
  htUpdateTable(PChar(FamilyTable(DT_FREE)), nil, nil, True, True);

 end; // with
end;

class function TUpgradeTo111.Version: Integer;
begin
 Result := 111;
end;

procedure TUpgradeTo111.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
 begin
  AddToRestorableList(FamilyTable(DT_FILE));
  AddToRestorableList(FamilyTable(DT_FREE));
 end;
end;

end.




