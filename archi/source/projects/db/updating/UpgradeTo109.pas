unit UpgradeTo109;

// ��������� ������ ��������� ����� NameR � NameE � ������� DT#5 �� 90 ��������.

{ $Id: UpgradeTo109.pas,v 1.4 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo109.pas,v $
// Revision 1.4  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.3  2007/12/03 14:00:54  fireton
// - ���������� updater �� ���� ������ dt_const � �������� ������������ �������� ���������������
//
// Revision 1.2  2004/12/03 18:19:12  step
// �������� �������� � ������� ����TStructChangeProc
//
// Revision 1.1  2004/10/20 15:51:36  step
// ��������� ��������� ������� garant.DT#5 (ver. 109)
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo109 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 108
  class function Version: Integer; override;     // 109
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 DT_DbReformer,
 l3FileUtils,
 Dt_Const;

{$INCLUDE nodt_const.inc} 

const
 TABLE_DT5      = 'DT#5001';
 TEMP_TABLE_DT5 = 'DT#5_NEW';
 NEW_FIELD_WIDTH = 90;

class function TUpgradeTo109.PrevVersion: Integer;
begin
 Result := 107; // !!! ���������� ������ ����� GARANT ������ 107, � �� 108.
                // ������, ��� 108-� ���������� �������� ����� MAIN.
end;

procedure fn_ChangeTableStructure(var aStruct: TElemArray; aData: Pointer = nil);
begin
 aStruct[1].wLength := NEW_FIELD_WIDTH; // ��������� ������� ����
 aStruct[2].wLength := NEW_FIELD_WIDTH; // ��������� �������� ����
end;

procedure TUpgradeTo109.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('�������� ����� ������ ������� DT#5 � ������������ ������.');
  CopyTableStruct(FamilyTable(TABLE_DT5),
                  FamilyTable(TEMP_TABLE_DT5),
                  fn_ChangeTableStructure);

  Log('����������� ������ �� ������ ������� DT#5 � �����.');
  CopyData(FamilyTable(TABLE_DT5),
           FamilyTable(TEMP_TABLE_DT5));

  Log('�������� ������ ������� DT#5.');
  htDropTable(PChar(FamilyTable(TABLE_DT5)), nil, nil);

  Log('�������������� ����� ������� � DT#5.');
  htTableRename(PChar(FamilyTable(TEMP_TABLE_DT5)),
                nil,
                nil,
                PChar(FamilyTable(TABLE_DT5)));
 end; // with
end;

class function TUpgradeTo109.Version: Integer;
begin
 Result := 109;
end;

procedure TUpgradeTo109.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
  AddToRestorableList(FamilyTable(TABLE_DT5));
end;

end.

