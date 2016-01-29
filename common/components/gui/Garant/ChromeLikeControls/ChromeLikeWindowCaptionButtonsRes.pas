unit ChromeLikeWindowCaptionButtonsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ChromeLikeControls"
// ������: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeWindowCaptionButtonsRes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeWindowCaptionButtons::ChromeLikeWindowCaptionButtonsRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3StringIDEx
  ;

var
  { ������������ ������ WindowCaptionButtonsHints }
 str_Close : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Close'; rValue : '�������');
  { '�������' }
 str_Minimize : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Minimize'; rValue : '��������');
  { '��������' }
 str_Restore : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Restore'; rValue : '�������� � ����');
  { '�������� � ����' }
 str_Maximize : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'Maximize'; rValue : '����������');
  { '����������' }
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3MessageID
  ;

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_Close
 str_Close.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_Minimize
 str_Minimize.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_Restore
 str_Restore.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// ������������� str_Maximize
 str_Maximize.Init;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.