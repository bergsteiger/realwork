unit ddAppConfigStringsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd$AppConfig"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/dd/ddAppConfigStringsRes.pas"
// �����: 15.03.2010 19:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd$AppConfig::AppConfig::ddAppConfigStringsRes
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
 str_ddcmCheckButton : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmCheckButton'; rValue : '��������');
  { '��������' }
 str_ddcmSoundFiles : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddcmSoundFiles'; rValue : '�������� ����� (*.wav)|*.wav');
  { '�������� ����� (*.wav)|*.wav' }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_ddcmCheckButton
 str_ddcmCheckButton.Init;
// ������������� str_ddcmSoundFiles
 str_ddcmSoundFiles.Init;

end.