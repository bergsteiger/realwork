unit ddAppConfigListsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd$AppConfig"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/dd/ddAppConfigListsRes.pas"
// �����: 15.10.201. 19:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd$AppConfig::AppConfig::ddAppConfigListsRes
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
  { ������������ ������ ConfigMessages }
 str_ddcmAddConfigValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmAddConfigValue'; rValue : '��������');
  { '��������' }
 str_ddcmChangeConfigValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmChangeConfigValue'; rValue : '���������');
  { '���������' }
 str_ddcmDeleteConfigValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmDeleteConfigValue'; rValue : '�������');
  { '�������' }
 str_ddcmConfirmDeleteConfigValue : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmConfirmDeleteConfigValue'; rValue : '�� ������������� ������ ������� ������� "%s"?');
  { '�� ������������� ������ ������� ������� "%s"?' }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_ddcmAddConfigValue
 str_ddcmAddConfigValue.Init;
// ������������� str_ddcmChangeConfigValue
 str_ddcmChangeConfigValue.Init;
// ������������� str_ddcmDeleteConfigValue
 str_ddcmDeleteConfigValue.Init;
// ������������� str_ddcmConfirmDeleteConfigValue
 str_ddcmConfirmDeleteConfigValue.Init;

end.