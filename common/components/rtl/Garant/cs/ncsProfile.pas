unit ncsProfile;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ncsProfile.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Messages::ncsProfile
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3StopWatch
  ;

var g_SaveMessage : Tl3StopWatch;

var g_LoadMessage : Tl3StopWatch;

var g_SendMessage : Tl3StopWatch;

var g_ReveiveMessage : Tl3StopWatch;

var g_WaitFile : Tl3StopWatch;

var g_ReceivePartFile : Tl3StopWatch;

var g_SaveControl : Tl3StopWatch;

var g_WriteFile : Tl3StopWatch;
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.