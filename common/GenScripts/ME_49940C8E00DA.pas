unit vcmTaskPanelInterfaces;

interface

uses
 l3IntfUses
 , vcmInterfaces
 , ActnList
 , l3Interfaces
 , vcmExternalInterfaces
 , Controls
 , afwInterfaces
;

type
 IvcmBase = vcmInterfaces.IvcmBase;
 
 IvcmCustOpsItem = interface
  {* ������� ������ ����� }
 end;//IvcmCustOpsItem
 
 IvcmCustOpsOperation = interface
  {* �������� ������ ����� }
 end;//IvcmCustOpsOperation
 
 IvcmCustOpsRepGroup = interface
 end;//IvcmCustOpsRepGroup
 
 IvcmCustOpsRepGroupOperations = interface;
 
 IvcmCustOpsRepOperation = interface(IvcmCustOpsOperation)
  {* �������� ����������� ������ ����� }
 end;//IvcmCustOpsRepOperation
 
 IvcmCustOpsRepOperationsIterator = interface;
 
 IvcmCustOpsRepGroupOperations = interface
  {* ��������� ��� ������ ������ �������� }
 end;//IvcmCustOpsRepGroupOperations
 
 IvcmCustOpsRepOperationsIterator = interface
  function Next: IvcmCustOpsRepOperation;
 end;//IvcmCustOpsRepOperationsIterator
 
 IvcmCustOpsGroupOperation = interface;
 
 IvcmCustOpsGroupOperationsIterator = interface
  function Next: IvcmCustOpsGroupOperation;
 end;//IvcmCustOpsGroupOperationsIterator
 
 IvcmCustOpsGroup = interface(IvcmCustOpsItem)
  {* ������ ������ ����� }
  function AddOperation(const aRepOp: IvcmCustOpsRepOperation;
   aForAllUseCases: Boolean;
   aPosition: Integer;
   const aCaption: IvcmCString): IvcmCustOpsGroupOperation;
   {* �������� �������� � ������ ����� }
 end;//IvcmCustOpsGroup
 
 IvcmCustOpsRepGroupsIterator = interface
  {* �������� ��������� ��� ������ ����� }
  function Next: IvcmCustOpsRepGroup;
 end;//IvcmCustOpsRepGroupsIterator
 
 IvcmCustOpsGroupOperation = interface(IvcmCustOpsItem)
  {* �������� ������ ����� }
  procedure Delete;
   {* ������� �������� �� ������ ����� }
 end;//IvcmCustOpsGroupOperation
 
 IvcmCustOpsGroupsIterator = interface
  function Next: IvcmCustOpsGroup;
 end;//IvcmCustOpsGroupsIterator
 
 IvcmCustOpsRepGroupsOperationsIterator = interface
  {* �������� ����� ��������� �������� }
  function Next: IvcmCustOpsRepGroupOperations;
 end;//IvcmCustOpsRepGroupsOperationsIterator
 
 IvcmCustOps = interface
  {* ������ ����� ��� ������ � ����� ��������� }
  function AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
   {* �������� ������ ����������� }
  procedure DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
   {* ������� ������ ����������� }
  function AddGroup(const aRepGroup: IvcmCustOpsRepGroup;
   aPosition: Integer): IvcmCustOpsGroup;
  procedure Refresh;
   {* ��������� ���������� �������� ������ �����. ������������ ���
              ������������ ������������ }
 end;//IvcmCustOps
 
 IvcmCustAvailableToolbarOps = interface(IvcmCustOps)
  {* ��������� ��������� ��� ������ �������� }
 end;//IvcmCustAvailableToolbarOps
 
 IvcmMainForm = interface
  {* �������� ����� }
  procedure AddFormToTasksPanel(const aEntityForm: IvcmEntityForm);
  procedure RemoveFormFromTasksPanel(const aEntityForm: IvcmEntityForm);
 end;//IvcmMainForm
 
 IvcmCustOpsRepository = interface
  {* ������ ����� ��� ���������� �������� ���������� ��������� }
  procedure AddModule(const aModule: IvcmModuleDef);
   {* ���������������� �������� ������ }
  procedure AddForm(const aForm: IvcmEntityForm);
   {* ���������������� ����� }
  procedure RemoveForm(const aForm: IvcmEntityForm);
   {* ������� ����� }
 end;//IvcmCustOpsRepository
 
 TvcmTaskPanelOperation = (
  cvcm_tpOperationRemove
  , cvcm_tpOpPosChanged
  , cvcm_tpOpCaptionChanged
  , cvcm_tpGroupRemove
  , cvcm_tpOperationAdded
  , cvcm_tpGroupAdded
  , cvcm_tpGroupCaptionChanged
  , cvcm_tpGroupPosChanged
  , cvcm_tpBeforeUpdate
  , cvcm_tpAfterUpdate
 );//TvcmTaskPanelOperation
 
 IvcmTaskPanelNotifyRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������. }
  procedure TaskPanelNotify(const aNotifier: Il3ChangeNotifier;
   aOperation: TvcmTaskPanelOperation;
   const aInterface: IvcmCustOpsItem);
   {* ������ ��������. }
 end;//IvcmTaskPanelNotifyRecipient
 
implementation

uses
 l3ImplUses
;

end.
