unit UnderControlInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\UnderControl\UnderControlInterfaces.pas"
// Стереотип: "ControllerInterfaces"
// Элемент модели: "UnderControlInterfaces" MUID: (4B9A1E7F0036)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , UnderControlUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 UnderControlBehaviour = interface
  function Get_HasControlStatus: Boolean;
  function Get_Controllable: IControllable;
  function Get_ControlStatus: Longword;
  procedure ClearControlStatus;
  property HasControlStatus: Boolean
   read Get_HasControlStatus;
  property Controllable: IControllable
   read Get_Controllable;
  property ControlStatus: Longword
   read Get_ControlStatus;
 end;//UnderControlBehaviour
 *)

type
 IucpUnderControl = interface(IvcmViewAreaController)
  ['{08B2C1E6-9E0D-46ED-BFD9-C422A17A34E5}']
  function Get_HasControlStatus: Boolean;
  function Get_Controllable: IControllable;
  function Get_ControlStatus: Longword;
  procedure ClearControlStatus;
  property HasControlStatus: Boolean
   read Get_HasControlStatus;
  property Controllable: IControllable
   read Get_Controllable;
  property ControlStatus: Longword
   read Get_ControlStatus;
 end;//IucpUnderControl

 TnsDropControlStatus = (
  dcsAfterReview
   {* после просмотра }
  , dcsExitFromSystem
   {* при выходе из системы }
 );//TnsDropControlStatus

 TnsDropControlStatusSet = set of TnsDropControlStatus;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
