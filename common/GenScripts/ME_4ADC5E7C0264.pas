unit nsWindowNode;

interface

uses
 l3IntfUses
 , l3NodesModelPart
 , OfficeLikeAppInterfaces
 , vcmInterfaces
 , l3Tree_TLB
 , l3Interfaces
;

type
 TnsWindowNode = class(Tl3UsualNode, InsWindow)
  {* Нода используемая для построения дерева окон системы }
  procedure Create(const aForm: IvcmEntityForm;
   const aText: Tl3WString);
  function Make(const aForm: IvcmEntityForm;
   const aText: Tl3WString): Il3Node;
  function Form: IvcmEntityForm;
 end;//TnsWindowNode
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
