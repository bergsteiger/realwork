unit NOT_FINISHED_nscNavigator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// ������: "w:/common/components/gui/Garant/Nemesis/NOT_FINISHED_nscNavigator.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::Navigator::TnscNavigator
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscNavigatorPageControl = class
 end;//TnscNavigatorPageControl

 TnscNavigator = class( {$If not defined(NoVCM)}, IvcmMainFormDependent{$IfEnd} //not NoVCM
 )
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure MainFormChanged(aForm: TControl);
     {* ���������� ��� ������� ������� ����� }
   {$IfEnd} //not NoVCM
 end;//TnscNavigator
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}

// start class TnscNavigator

{$If not defined(NoVCM)}
procedure TnscNavigator.MainFormChanged(aForm: TControl);
//#UC START# *53CF7DD00066_499ABF3D031B_var*
//#UC END# *53CF7DD00066_499ABF3D031B_var*
begin
//#UC START# *53CF7DD00066_499ABF3D031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CF7DD00066_499ABF3D031B_impl*
end;//TnscNavigator.MainFormChanged
{$IfEnd} //not NoVCM

{$IfEnd} //Nemesis

end.