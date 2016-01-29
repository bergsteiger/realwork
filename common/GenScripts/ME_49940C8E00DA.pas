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
  {* Элемент панели задач }
 end;//IvcmCustOpsItem
 
 IvcmCustOpsOperation = interface
  {* Операция панели задач }
 end;//IvcmCustOpsOperation
 
 IvcmCustOpsRepGroup = interface
 end;//IvcmCustOpsRepGroup
 
 IvcmCustOpsRepGroupOperations = interface;
 
 IvcmCustOpsRepOperation = interface(IvcmCustOpsOperation)
  {* Операция репозитария панели задач }
 end;//IvcmCustOpsRepOperation
 
 IvcmCustOpsRepOperationsIterator = interface;
 
 IvcmCustOpsRepGroupOperations = interface
  {* Доступная для выбора группа операций }
 end;//IvcmCustOpsRepGroupOperations
 
 IvcmCustOpsRepOperationsIterator = interface
  function Next: IvcmCustOpsRepOperation;
 end;//IvcmCustOpsRepOperationsIterator
 
 IvcmCustOpsGroupOperation = interface;
 
 IvcmCustOpsGroupOperationsIterator = interface
  function Next: IvcmCustOpsGroupOperation;
 end;//IvcmCustOpsGroupOperationsIterator
 
 IvcmCustOpsGroup = interface(IvcmCustOpsItem)
  {* Группа панели задач }
  function AddOperation(const aRepOp: IvcmCustOpsRepOperation;
   aForAllUseCases: Boolean;
   aPosition: Integer;
   const aCaption: IvcmCString): IvcmCustOpsGroupOperation;
   {* добавить операцию в панель задач }
 end;//IvcmCustOpsGroup
 
 IvcmCustOpsRepGroupsIterator = interface
  {* Итератор доступных для выбора групп }
  function Next: IvcmCustOpsRepGroup;
 end;//IvcmCustOpsRepGroupsIterator
 
 IvcmCustOpsGroupOperation = interface(IvcmCustOpsItem)
  {* Операции панели задач }
  procedure Delete;
   {* удалить операцию из панели задач }
 end;//IvcmCustOpsGroupOperation
 
 IvcmCustOpsGroupsIterator = interface
  function Next: IvcmCustOpsGroup;
 end;//IvcmCustOpsGroupsIterator
 
 IvcmCustOpsRepGroupsOperationsIterator = interface
  {* Итератор групп доступных операций }
  function Next: IvcmCustOpsRepGroupOperations;
 end;//IvcmCustOpsRepGroupsOperationsIterator
 
 IvcmCustOps = interface
  {* Панель задач для работы с одной сущностью }
  function AddRepGroup(const aGroup: IvcmCString): IvcmCustOpsRepGroup;
   {* добавить группу репозитория }
  procedure DeleteRepGroup(const aGroup: IvcmCustOpsRepGroup);
   {* удалить группу репозитория }
  function AddGroup(const aRepGroup: IvcmCustOpsRepGroup;
   aPosition: Integer): IvcmCustOpsGroup;
  procedure Refresh;
   {* полностью перечитать операции панели задач. Используется при
              переключении конфигурации }
 end;//IvcmCustOps
 
 IvcmCustAvailableToolbarOps = interface(IvcmCustOps)
  {* Настроить доступные для выбора операции }
 end;//IvcmCustAvailableToolbarOps
 
 IvcmMainForm = interface
  {* Основная форма }
  procedure AddFormToTasksPanel(const aEntityForm: IvcmEntityForm);
  procedure RemoveFormFromTasksPanel(const aEntityForm: IvcmEntityForm);
 end;//IvcmMainForm
 
 IvcmCustOpsRepository = interface
  {* Панель задач для публикации операций нескольких сущностей }
  procedure AddModule(const aModule: IvcmModuleDef);
   {* зарегистрировать операции модуля }
  procedure AddForm(const aForm: IvcmEntityForm);
   {* зарегистрировать форму }
  procedure RemoveForm(const aForm: IvcmEntityForm);
   {* удалить форму }
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
  {* Подписчик для получения нотификации об операции. }
  procedure TaskPanelNotify(const aNotifier: Il3ChangeNotifier;
   aOperation: TvcmTaskPanelOperation;
   const aInterface: IvcmCustOpsItem);
   {* прошла операция. }
 end;//IvcmTaskPanelNotifyRecipient
 
implementation

uses
 l3ImplUses
;

end.
