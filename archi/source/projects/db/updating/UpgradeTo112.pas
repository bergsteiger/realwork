unit UpgradeTo112;
// ��������� ����� ������� DT#5E.

{ $Id: UpgradeTo112.pas,v 1.7 2011/12/12 14:02:52 fireton Exp $ }
// $Log: UpgradeTo112.pas,v $
// Revision 1.7  2011/12/12 14:02:52  fireton
// - DbReformer � DbInfo ��������� � DT
//
// Revision 1.6  2007/12/03 14:00:54  fireton
// - ���������� updater �� ���� ������ dt_const � �������� ������������ �������� ���������������
//
// Revision 1.5  2005/02/25 15:14:16  step
// ���������� ����� ������� DT#5E (ver. 112).
//

interface

uses
 DbUpgrade;

type

 TUpgradeTo112 = class(TDocBaseUpgrade)
 protected
  procedure ModifyBd; override;
 public
  class function PrevVersion: Integer; override; // 111
  class function Version: Integer; override;     // 112
 end;

implementation

uses
 SysUtils,
 Ht_Dll, Ht_Const,
 DT_DbReformer;

{$INCLUDE nodt_const.inc} 

class function TUpgradeTo112.PrevVersion: Integer;
begin
 Result := 111;
end;

procedure TUpgradeTo112.ModifyBd;
begin
 with f_DbReformer do
 begin
  Log('�������� ����� ������� DT#5E.');
  CopyTableStruct(FamilyTable('DT#3E001'), FamilyTable('DT#5E001'));
 end; // with
end;

class function TUpgradeTo112.Version: Integer;
begin
 Result := 112;
end;

end.




