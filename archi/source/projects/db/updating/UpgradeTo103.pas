unit UpgradeTo103;
// 1. ���������� � ������� ACTIV ������ ���� Typ.

{ $Id: UpgradeTo103.pas,v 1.8 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo103.pas,v $
// Revision 1.8  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.7  2007/12/03 14:00:54  fireton
// - ���������� updater �� ���� ������ dt_const � �������� ������������ �������� ���������������
//
// Revision 1.6  2004/12/03 18:19:12  step
// �������� �������� � ������� ����TStructChangeProc
//
// Revision 1.5  2004/05/25 15:41:49  step
// new: classes TDocBaseUpgrade, TAdminBaseUpgrade
//
// Revision 1.4  2004/05/07 17:37:47  step
// ���� ������ �����������
//
// Revision 1.3  2004/03/09 18:40:03  step
// �������� update � 104 (��������� ����� ����. FILE)
//
// Revision 1.2  2004/03/05 09:08:50  step
// ������ �����������
//
// Revision 1.1  2004/03/04 18:02:37  step
// ��������� ���������� �103
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo103 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 102
  class function Version: Integer; override;     // 103
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 DT_DbReformer,
 l3FileUtils;

{$INCLUDE nodt_const.inc}

const
 TABLE        = 'ACTIV001';
 TEMP_TABLE   = 'ACTIVNEW';

class function TUpgradeTo103.PrevVersion: Integer;
begin
 Result := 102;
end;

procedure fn_AddTypToActiv(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_FieldName = 'Typ';
begin
 SetLength(aStruct, Length(aStruct) + 1);
 // ����� �����
 aStruct[6] := aStruct[5];
 aStruct[5] := aStruct[4];
 aStruct[4] := aStruct[3];
 aStruct[3] := aStruct[2];

 // ���������� ���� Typ
 FillChar(aStruct[2], SizeOf(aStruct[2]), #0);
 with aStruct[2] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_BYTE;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName;
 end;
end;

procedure TUpgradeTo103.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('�������� ����� ������ ������� ACTIV � ����� TYP');
  CopyTableStruct(FamilyTable(TABLE),
                  FamilyTable(TEMP_TABLE),
                  fn_AddTypToActiv);

  Log('����������� ������ �� ������ ������� � �����');
  CopyData(FamilyTable(TABLE),
           FamilyTable(TEMP_TABLE));

  Log('�������� ������ �������');
  htDropTable(PChar(FamilyTable(TABLE)), nil, nil);

  Log('�������������� ����� �������');
  htTableRename(PChar(FamilyTable(TEMP_TABLE)),
                nil,
                nil,
                PChar(FamilyTable(TABLE)));
 end; // with
end;

class function TUpgradeTo103.Version: Integer;
begin
 Result := 103;
end;

procedure TUpgradeTo103.InitRestorableTableList;
begin
 inherited;
 with f_DbReformer do
  AddToRestorableList(FamilyTable(TABLE));
end;

end.

