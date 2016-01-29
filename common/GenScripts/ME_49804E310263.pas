unit PresentationInterfaces;

interface

uses
 l3IntfUses
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
  procedure OnDate(aDate: RtlDateTime);
   {* �������� �� ���� }
  procedure OnCurrentRedaction;
   {* �������� � ������ �������� ������� �������� }
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
  procedure GotoActualRedaction;
   {* ��������� � ������� � ���������� �������� }
  procedure StayInCurrentRedaction;
   {* ��������� � �������� � ������� �������� }
  procedure ChangeDate(aDate: RtlDateTime);
   {* �������� }
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
  procedure CorrectHeight(var aHeight: Integer);
   {* ������������ ��� ������������� ������ �������� ���� }
 end;//InsMainFormChildZoneManager
 
implementation

uses
 l3ImplUses
;

end.
