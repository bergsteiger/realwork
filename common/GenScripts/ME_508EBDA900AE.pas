unit nscTasksPanelOperationNode;

interface

uses
 l3IntfUses
 , l3NodesModelPart
 , l3Interfaces
 , nscTaskPanelInterfaces
 , vcmTaskPanelInterfaces
 , nscTasksPanelActionLink
;

type
 TnscTasksPanelOperationNode = class(Tl3UsualNode, Il3ItemNotifyRecipient, InscOperationNode)
  procedure Create(const aOp: IvcmCustOpsGroupOperation);
  function Make(const aOp: IvcmCustOpsGroupOperation): InscOperationNode;
  procedure Notify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
   {* прошла операция. }
  procedure CaptionChanged;
   {* изменилось название операции }
  function Op: IvcmCustOpsGroupOperation;
 end;//TnscTasksPanelOperationNode
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3Tree_TLB
;

end.
