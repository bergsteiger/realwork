unit OleCtrls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Vcl"
// ������: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Vcl/OleCtrls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Vcl::Implementation::OleCtrls
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

{$If not defined(NoVCL)}
uses
  Controls
  ;

type
 TOleControl = class(TWinControl)
 end;//TOleControl
{$IfEnd} //not NoVCL

implementation

{$If not defined(NoVCL)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

{$IfEnd} //not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� TOleControl
 TtfwClassRef.Register(TOleControl);
{$IfEnd} //not NoScripts AND not NoVCL

end.