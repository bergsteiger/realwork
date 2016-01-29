unit UpgradeTo113;
// 1. ���������� � ������� GUDT ����� ����� Pr_Import � Pr_Export.
// 2. �������� �������������� ������� DICTSOUR.

{ $Id: UpgradeTo113.pas,v 1.3 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo113.pas,v $
// Revision 1.3  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.2  2007/12/03 14:00:54  fireton
// - ���������� updater �� ���� ������ dt_const � �������� ������������ �������� ���������������
//
// Revision 1.1  2005/09/09 16:58:11  step
// ���������� � ������� GUDT ����� �����.
// ����� �������� DICTSOUR.
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo113 = class(TAdminBaseUpgrade)
 protected
  procedure ModifyBd; override;
  procedure InitRestorableTableList; override;
 public
  class function PrevVersion: Integer; override; // 112
  class function Version: Integer; override;     // 113
 end;

implementation

uses
 Ht_Dll, Ht_Const,
 SysUtils,
 DT_DbReformer,
 l3FileUtils;

{$INCLUDE nodt_const.inc} 

const
 TABLE_GUDT     = 'GUDT';
 NEW_TABLE_GUDT = 'GUDT_NEW';
 TABLE_DICTSOUR = 'DICTSOUR';
 DEF_PRIORITY: Smallint   = 0;

class function TUpgradeTo113.PrevVersion: Integer;
begin
 Result := 108;
end;

procedure fn_AddFieldsToGudt(var aStruct: TElemArray; aData: Pointer = nil);
const
 c_FieldName1 = 'Pr_Import';
 c_FieldName2 = 'Pr_Export';
begin
 SetLength(aStruct, Length(aStruct) + 2);

 // ���������� �����
 FillChar(aStruct[3], SizeOf(aStruct[3]), #0);
 with aStruct[3] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_INTR;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName1;
 end;

 FillChar(aStruct[4], SizeOf(aStruct[4]), #0);
 with aStruct[4] do
 begin
  wLength := 0;
  wOffset := 0;
  cClass  := EC_FIELD;
  cType   := ET_INTR;
  cKey    := EK_NOTKEY;
  mName   := c_FieldName2;
 end;

end;

procedure TUpgradeTo113.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('�������� ����� ������ ������� GUDT � ������ ������ Pr_Import � Pr_Export.');
  CopyTableStruct(MainTable(TABLE_GUDT),
                  MainTable(NEW_TABLE_GUDT),
                  fn_AddFieldsToGudt);

  Log('����������� ������ �� ������ ������� � �����.');
  CopyData(MainTable(TABLE_GUDT),
           MainTable(NEW_TABLE_GUDT));

  Log('���������� ����� ����� ��������� ����������.');
  SetFieldValue(MainTable(NEW_TABLE_GUDT), 4, DEF_PRIORITY);
  SetFieldValue(MainTable(NEW_TABLE_GUDT), 5, DEF_PRIORITY);

  Log('�������� ������ �������.');
  htDropTable(PChar(MainTable(TABLE_GUDT)), nil, nil);

  Log('�������������� ����� �������.');
  htTableRename(PChar(MainTable(NEW_TABLE_GUDT)),
                nil,
                nil,
                PChar(MainTable(TABLE_GUDT)));


  Log('�������� �������������� ������� DICTSOUR.');
  htDropTable(PChar(MainTable(TABLE_DICTSOUR)), nil, nil);

 end; // with
end;

class function TUpgradeTo113.Version: Integer;
begin
 Result := 113;
end;

procedure TUpgradeTo113.InitRestorableTableList;
begin
 inherited;

 with f_DbReformer do
  AddToRestorableList(MainTable(TABLE_GUDT));
end;

end.

