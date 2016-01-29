unit ddAppConfigTypesRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd$AppConfig"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/dd/ddAppConfigTypesRes.pas"
// �����: 15.10.2010 20:02
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd$AppConfig::AppConfig::ddAppConfigTypesRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3StringIDEx
  ;

var
  { ������������ ������ Local }
 str_ddcmInvalidIntegerValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidIntegerValue'; rValue : '��������� ���� �������� ''%s'' �� �������� ������.');
  { '��������� ���� �������� ''%s'' �� �������� ������.' }
 str_ddcmErrorIntegerRange : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmErrorIntegerRange'; rValue : '��������� ���� ����� ''%d'' ��������� ��� ��������� ''%d-%d''.');
  { '��������� ���� ����� ''%d'' ��������� ��� ��������� ''%d-%d''.' }
 str_ddcmInvalidMaxValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidMaxValue'; rValue : '������������ �������� %d �� ����� ��������� %d');
  { '������������ �������� %d �� ����� ��������� %d' }
 str_ddcmInvalidMinValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidMinValue'; rValue : '����������� �������� %d �� ����� ���� ������ %d');
  { '����������� �������� %d �� ����� ���� ������ %d' }
 str_ddcmSelectButton : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmSelectButton'; rValue : '�������');
  { '�������' }
 str_ddcmFontExample : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmFontExample'; rValue : '������ ������');
  { '������ ������' }
 str_ddcmInvalidMapValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmInvalidMapValue'; rValue : '��������� �������� �� ������� � ������ ����������');
  { '��������� �������� �� ������� � ������ ����������' }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_ddcmInvalidIntegerValue
 str_ddcmInvalidIntegerValue.Init;
// ������������� str_ddcmErrorIntegerRange
 str_ddcmErrorIntegerRange.Init;
// ������������� str_ddcmInvalidMaxValue
 str_ddcmInvalidMaxValue.Init;
// ������������� str_ddcmInvalidMinValue
 str_ddcmInvalidMinValue.Init;
// ������������� str_ddcmSelectButton
 str_ddcmSelectButton.Init;
// ������������� str_ddcmFontExample
 str_ddcmFontExample.Init;
// ������������� str_ddcmInvalidMapValue
 str_ddcmInvalidMapValue.Init;

end.