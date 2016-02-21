unit afwDockingInterfaces;

// Модуль: "w:\common\components\gui\Garant\AFW\afwDockingInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 IafwDockableControl = interface
  ['{A3986FC8-A811-4B72-BEBF-BD68FA7D6038}']
  function CanBeDockedInto(aControl: TWinControl): Boolean;
 end;//IafwDockableControl

 IafwControlDock = interface
  ['{DD464262-1D9A-41AB-B85C-A0E351F0E9F1}']
  function GetDockControl(const aDockable: IafwDockableControl): TWinControl;
 end;//IafwControlDock

implementation

uses
 l3ImplUses
;

end.
