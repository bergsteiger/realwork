unit NOT_FINISHED_vtRadioButton;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// ������: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtRadioButton.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::Buttons::TvtRadioButton
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  
  ;

type
 _vtUnicodeButtonControl_Parent_ = TRadioButton;
 {$Include ..\VT\vtUnicodeButtonControl.imp.pas}
 TvtRadioButton = class(_vtUnicodeButtonControl_)
 end;//TvtRadioButton

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

{$Include ..\VT\vtUnicodeButtonControl.imp.pas}


initialization
{$If not defined(NoScripts)}
// ����������� TvtRadioButton
 TtfwClassRef.Register(TvtRadioButton);
{$IfEnd} //not NoScripts

end.