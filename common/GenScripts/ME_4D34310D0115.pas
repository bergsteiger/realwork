unit nscTasksPanelGroup;

interface

uses
 l3IntfUses
 , vcmTasksPanel
 , vcmTaskPanelInterfaces
 , nscTasksPanelGroupDescList
 , vcmExternalInterfaces
 , Controls
;

type
 TnscTasksPanelGroup = class(TvcmCustOpsNotifier, IvcmCustOpsGroup, IvcmCustOpsRepGroup)
  procedure Create(anID: Integer;
   const aDesc: TnscTasksPanelGroupDesc);
  function Make(anID: Integer;
   const aDesc: TnscTasksPanelGroupDesc): IvcmCustOpsGroup;
  function Position: Integer;
   {* ������� ������ }
  function AddOperation(const aRepOp: IvcmCustOpsRepOperation;
   aForAllUseCases: Boolean;
   aPosition: Integer;
   const aCaption: IvcmCString): IvcmCustOpsGroupOperation;
   {* �������� �������� � ������ ����� }
  function Operations: IvcmCustOpsGroupOperationsIterator;
  function RepGroup: IvcmCustOpsRepGroup;
  function Caption: IvcmCString;
   {* �������� ������ }
  function Id: Integer;
   {* ������������� ������ }
  function IsLinkToExistingControl: Boolean;
   {* �������� �� ������ ������� �� ������������ ������� }
  function Control: TWinControl;
 end;//TnscTasksPanelGroup
 
implementation

uses
 l3ImplUses
;

end.
