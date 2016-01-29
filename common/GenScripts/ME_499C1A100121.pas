unit nscTaskPanelInterfaces;

interface

uses
 l3IntfUses
 , vcmTaskPanelInterfaces
;

type
 InscOperationNode = interface
  {* Узел операции панели задач }
  procedure CaptionChanged;
   {* изменилось название операции }
 end;//InscOperationNode
 
implementation

uses
 l3ImplUses
;

end.
