unit ddAppConfigRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd$AppConfig"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/dd/ddAppConfigRes.pas"
// �����: 11.03.2010 18:41
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd$AppConfig::AppConfig::ddAppConfigRes
//
// ������� ��� ddAppConfig
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
 str_ddmmSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmSettingsCaption'; rValue : '��������� ������������');
  { '��������� ������������' }
 str_ddmmErrorCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmErrorCaption'; rValue : '������');
  { '������' }

var
  { ������������ ������ Errors }
 str_DifferentType : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DifferentType'; rValue : '��� �������� "%s" ���������� �� ������������');
  { '��� �������� "%s" ���������� �� ������������' }
 str_PropertyAbsent : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PropertyAbsent'; rValue : '�������� "%s" �����������');
  { '�������� "%s" �����������' }
 str_PropertyExists : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PropertyExists'; rValue : '�������� � ������ "%s" ��� ����������');
  { '�������� � ������ "%s" ��� ����������' }
 str_ListEmpty : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ListEmpty'; rValue : '������������ �����');
  { '������������ �����' }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_ddmmSettingsCaption
 str_ddmmSettingsCaption.Init;
// ������������� str_ddmmErrorCaption
 str_ddmmErrorCaption.Init;
// ������������� str_DifferentType
 str_DifferentType.Init;
// ������������� str_PropertyAbsent
 str_PropertyAbsent.Init;
// ������������� str_PropertyExists
 str_PropertyExists.Init;
// ������������� str_ListEmpty
 str_ListEmpty.Init;

end.