unit vcmMainFormRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM$Visual"
// ������: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMainFormRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual::vcmMainFormRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3StringIDEx,
  l3MessageID
  ;

var
  { ������������ ������ Local }
 str_TooManyWindowsOpened : Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened'; rValue : '������� ������������ ���������� ���� ������� ������. �������� �������� ���� ��� ����������� ������ � ������� ����');
  { '������� ������������ ���������� ���� ������� ������. �������� �������� ���� ��� ����������� ������ � ������� ����' }
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Dialogs
  {$IfEnd} //not NoVCL
  
  ;

var
  { �������� ������ ��� ������� TooManyWindowsOpened }
 str_TooManyWindowsOpened_Choice_First : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_First'; rValue : '������� � ������� ����');
  { '������� � ������� ����' }
 str_TooManyWindowsOpened_Choice_Second : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'TooManyWindowsOpened_Choice_Second'; rValue : '������');
  { '������' }

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoVCM)}
// ������������� str_TooManyWindowsOpened_Choice_First
 str_TooManyWindowsOpened_Choice_First.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_TooManyWindowsOpened_Choice_Second
 str_TooManyWindowsOpened_Choice_Second.Init;
{$IfEnd} //not NoVCM
{$If not defined(NoVCM)}
// ������������� str_TooManyWindowsOpened
 str_TooManyWindowsOpened.Init;
 str_TooManyWindowsOpened.AddChoice(str_TooManyWindowsOpened_Choice_First);
 str_TooManyWindowsOpened.AddChoice(str_TooManyWindowsOpened_Choice_Second);
 str_TooManyWindowsOpened.AddCustomChoice(str_TooManyWindowsOpened_Choice_Second);
 str_TooManyWindowsOpened.AddDefaultChoice(str_TooManyWindowsOpened_Choice_First);
 str_TooManyWindowsOpened.SetDlgType(mtConfirmation);
{$IfEnd} //not NoVCM

end.