unit nscNavigator;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , Controls
;

type
 TnscNavigatorPageControl = class
 end;//TnscNavigatorPageControl
 
 TnscNavigator = class(IvcmMainFormDependent)
  procedure MainFormChanged(aForm: TControl);
   {* ���������� ��� ������� ������� ����� }
 end;//TnscNavigator
 
implementation

uses
 l3ImplUses
;

end.
