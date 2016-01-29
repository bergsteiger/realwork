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
   {* позици€ группы }
  function AddOperation(const aRepOp: IvcmCustOpsRepOperation;
   aForAllUseCases: Boolean;
   aPosition: Integer;
   const aCaption: IvcmCString): IvcmCustOpsGroupOperation;
   {* добавить операцию в панель задач }
  function Operations: IvcmCustOpsGroupOperationsIterator;
  function RepGroup: IvcmCustOpsRepGroup;
  function Caption: IvcmCString;
   {* название группы }
  function Id: Integer;
   {* идентификатор группы }
  function IsLinkToExistingControl: Boolean;
   {* явл€етс€ ли группа ссылкой на существующий контрол }
  function Control: TWinControl;
 end;//TnscTasksPanelGroup
 
implementation

uses
 l3ImplUses
;

end.
