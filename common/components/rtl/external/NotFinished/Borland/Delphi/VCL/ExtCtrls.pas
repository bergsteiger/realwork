unit ExtCtrls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Vcl"
// ������: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Vcl/ExtCtrls.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Vcl::Implementation::ExtCtrls
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
 TTimer = class
 end;//TTimer

 TPaintBox = class
 end;//TPaintBox

 TCustomPanel = class(TCustomControl)
 end;//TCustomPanel

 TPanel = class(TCustomPanel)
 end;//TPanel

 TRadioGroup = class
 end;//TRadioGroup

 TPanelBevel = Controls.TBevelCut;

 TImage = class
 end;//TImage

 TBevel = class
 end;//TBevel
{$IfEnd} //not NoVCL

implementation

{$If not defined(NoVCL)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  PanelProcessingPack
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  RadioGroupWordsPack
  {$IfEnd} //not NoScripts AND not NoVCL
  
  ;

{$IfEnd} //not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� TCustomPanel
 TtfwClassRef.Register(TCustomPanel);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// ����������� TPanel
 TtfwClassRef.Register(TPanel);
{$IfEnd} //not NoScripts AND not NoVCL

end.