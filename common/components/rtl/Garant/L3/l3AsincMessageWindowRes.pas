unit l3AsincMessageWindowRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3AsincMessageWindowRes.pas"
// �����: 18.10.2010
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3AsincMessageWindowRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3StringIDEx
  ;

var
  { ������������ ������ Local }
 str_l3mmLongOperation : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmLongOperation'; rValue : '����������� ���������� ��������...');
  { '����������� ���������� ��������...' }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_l3mmLongOperation
 str_l3mmLongOperation.Init;

end.