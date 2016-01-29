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
   {* Вызывается при измении главной формы }
 end;//TnscNavigator
 
implementation

uses
 l3ImplUses
;

end.
