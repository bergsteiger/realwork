unit UnderControlInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "UnderControl$Resetter"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/UnderControl/UnderControlInterfaces.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Core::Common::UnderControl$Resetter::UnderControlInterfaces
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  UnderControlUnit,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

(*
 UnderControlBehaviour = PureMixIn
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
  // UnderControlBehaviour
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
   dcsAfterReview // ����� ���������
 , dcsExitFromSystem // ��� ������ �� �������
 );//TnsDropControlStatus

 TnsDropControlStatusSet = set of TnsDropControlStatus;
{$IfEnd} //not Admin AND not Monitorings

implementation

end.