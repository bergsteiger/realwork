unit PresentationInterfaces;
 {* ���������� ��� ��������� ������������� }

// ������: "w:\common\components\gui\Garant\VCM\View\PresentationInterfaces.pas"
// ���������: "Interfaces"
// ������� ������: "PresentationInterfaces" MUID: (49804E310263)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Core
;

type
 TnsTurnOnTimeMachineOperation = (
  {* �������� ������������ ��� ��������� ������ ������� }
  ns_ontmDateOp
  , ns_ontmCurrentRedactionOp
 );//TnsTurnOnTimeMachineOperation

 TnsTurnOnTimeMachineOperations = set of TnsTurnOnTimeMachineOperation;

 InsTurnOnTimeMachine = interface
  {* �������� ������ ������� }
  ['{B8501E97-66C4-44E4-9B97-17CE6FD2F1CB}']
  function Get_DisableOps: TnsTurnOnTimeMachineOperations;
  procedure OnDate(aDate: RtlDateTime);
   {* �������� �� ���� }
  procedure OnCurrentRedaction;
   {* �������� � ������ �������� ������� �������� }
  property DisableOps: TnsTurnOnTimeMachineOperations
   read Get_DisableOps;
   {* ����������� �������� ��� ������ � �������� }
 end;//InsTurnOnTimeMachine

 TnsTurnOffTimeMachineOperation = (
  {* �������� ������������ ��� ���������� ������ ������� }
  ns_offtmGotoActualRedaction
  , ns_offtmStayInCurrentRedaction
  , ns_offtmChangeDate
 );//TnsTurnOffTimeMachineOperation

 TnsTurnOffTimeMachineOperations = set of TnsTurnOffTimeMachineOperation;

 InsTurnOffTimeMachine = interface
  {* ��������� ������ ������� }
  ['{FEA19D46-7FA6-4BCD-B6DC-84118A36EDC4}']
  function Get_DisableOps: TnsTurnOffTimeMachineOperations;
  procedure GotoActualRedaction;
   {* ��������� � ������� � ���������� �������� }
  procedure StayInCurrentRedaction;
   {* ��������� � �������� � ������� �������� }
  procedure ChangeDate(aDate: RtlDateTime);
   {* �������� }
  property DisableOps: TnsTurnOffTimeMachineOperations
   read Get_DisableOps;
   {* �������� ����������� ��� ������ � ������� ������� }
 end;//InsTurnOffTimeMachine

 TnsSaveDialogKind = (
  {* ���� �������� ���������� }
  ns_sdkSimple
   {* ������� ������ }
  , ns_sdkDocument
   {* ��� ��������� (�������������� ������� "��������� ���������" }
  , ns_sdkList
   {* ��� ������ - ����������� ��� ��������� (��������, ������) � ��. �� ��25445 }
  , ns_sdkListInternal
   {* ��� ������ - ����������� ��� ��������� (��������, ������, ������ �������) � ��. �� ��25445 }
 );//TnsSaveDialogKind

 TnsSaveDialogListTarget = (
  {* ��� ��������� ��� ������ }
  ns_sdlkTitles
   {* �������� ���������� }
  , ns_sdlkContents
   {* ������ ���������� }
  , ns_sdlkIdentifiers
   {* ������ ������� }
 );//TnsSaveDialogListTarget

 InsMainFormChildZoneManager = interface
  {* ��� ���������� �������� ����� ������� ������ }
  ['{1B9C4E1F-5E93-4CFB-9E0C-034E51A2F1CE}']
  procedure CorrectHeight(var aHeight: Integer);
   {* ������������ ��� ������������� ������ �������� ���� }
 end;//InsMainFormChildZoneManager

implementation

uses
 l3ImplUses
;

end.
