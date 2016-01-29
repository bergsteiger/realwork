unit TestStringUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1Test"
// �����: ��
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/TestStringUtils.pas"
// �����: �����
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������� ����������� ���������� �������::F1Test::TestHelpers::TestStringUtils
//
// ������ �� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(XE)}
uses
  Classes
  ;

procedure Split(Delimiter: AnsiChar;
  const Input: AnsiString;
  Strings: TStrings);
{$IfEnd} //not XE

implementation

{$If not defined(XE)}
// unit methods

procedure Split(Delimiter: AnsiChar;
  const Input: AnsiString;
  Strings: TStrings);
//#UC START# *499C3E8E03D8_499C3E6803D8_var*
//#UC END# *499C3E8E03D8_499C3E6803D8_var*
begin
//#UC START# *499C3E8E03D8_499C3E6803D8_impl*
  Assert(Assigned(Strings)) ;
  Strings.Clear;
  Strings.Delimiter := Char(Delimiter);
  Strings.DelimitedText := Input;
//#UC END# *499C3E8E03D8_499C3E6803D8_impl*
end;//Split
{$IfEnd} //not XE

end.