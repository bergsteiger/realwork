unit nscTasksPanelActionLink;

interface

uses
 l3IntfUses
 , ActnList
 , Controls
 , nscTaskPanelInterfaces
 , Classes
 , vcmExternalInterfaces
;

type
 // c_ComboOperations
 
 TnscTasksPanelActionLink = class(TActionLink)
  procedure Create(const aAction: TBasicAction;
   aTree: TControl;
   const aOp: InscOperationNode);
  procedure ValidateCaption(const aValue: AnsiString);
 end;//TnscTasksPanelActionLink
 
implementation

uses
 l3ImplUses
 , vcmTaskPanelInterfaces
 , vcmUserControls
 , SysUtils
 , l3Tree_TLB
 , l3String
 , nscTasksPanelView
;

end.
