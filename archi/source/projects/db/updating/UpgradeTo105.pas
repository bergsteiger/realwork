unit UpgradeTo105;
// 1. ���������� � ������� DT#A ������ ���� Private.

{ $Id: UpgradeTo105.pas,v 1.6 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo105.pas,v $
// Revision 1.6  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.5  2007/12/03 14:00:54  fireton
// - ���������� updater �� ���� ������ dt_const � �������� ������������ �������� ���������������
//
// Revision 1.4  2004/12/03 18:19:12  step
// �������� �������� � ������� ����TStructChangeProc
//
// Revision 1.3  2004/05/25 15:41:49  step
// new: classes TDocBaseUpgrade, TAdminBaseUpgrade
//
// Revision 1.2  2004/05/07 17:37:48  step
// ���� ������ �����������
//
// Revision 1.1  2004/03/17 13:00:10  step
// ��������� update (���������� ���� PRIVATE � ����. DT#A)
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo105 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 104
  class function Version: Integer; override;     // 105
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 DT_DbReformer,
 l3FileUtils;

{$INCLUDE nodt_const.inc} 

const
 DT_A        = 'DT#A001';
 TEMP_DT_A   = 'DT#A_NEW';

class function TUpgradeTo105.PrevVersion: Integer;
begin
 Result := 104;
end;

procedure fn_AddFieldToDtA(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_FieldName = 'Private';
begin
 SetLength(aStruct, Length(aStruct) + 1);

 // ���������� ����
 FillChar(aStruct[4], SizeOf(aStruct[4]), #0);
 with aStruct[4] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_BYTE;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName;
 end;
end;

procedure TUpgradeTo105.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('�������� ����� ������ ������� DT#A � ����� Private');
  CopyTableStruct(FamilyTable(DT_A),
                  FamilyTable(TEMP_DT_A),
                  fn_AddFieldToDtA);

  Log('����������� ������ �� ������ ������� � �����');
  CopyData(FamilyTable(DT_A),
           FamilyTable(TEMP_DT_A));

  Log('�������� ������ �������');
  htDropTable(PChar(FamilyTable(DT_A)), nil, nil);

  Log('�������������� ����� �������');
  htTableRename(PChar(FamilyTable(TEMP_DT_A)),
                nil,
                nil,
                PChar(FamilyTable(DT_A)));
 end; // with
end;

class function TUpgradeTo105.Version: Integer;
begin
 Result := 105;
end;

procedure TUpgradeTo105.InitRestorableTableList;
begin
 inherited;

 with f_DbReformer do
  AddToRestorableList(FamilyTable(DT_A));
end;

end.

