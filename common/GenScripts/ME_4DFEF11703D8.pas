unit evContentsNode;

interface

uses
 l3IntfUses
 , l3VirtualNode
 , l3Tree_TLB
;

type
 TevContentsNodeState = (
  {* Состояние узла дерева оглавления. }
  ev_cntNotReady
   {* Узел только что создан и не инициализирован. }
  , ev_cntNeedUpdate
   {* Нужно пересоздать дочерние }
  , ev_cntReady
   {* Узел готов к отображению и не требует обновления. }
  , ev_cntInUpdate
   {* Полный перебор. }
  , ev_cntFirstFind
   {* Поиск первого тега для узла. }
 );//TevContentsNodeState
 
 TevContentsNode = class(Tl3VirtualFlagsNode)
  function NeedCreate: Boolean;
  function NotReady: Boolean;
  function CheckChildren: Boolean;
   {* Проверяет есть ли у задания дочерние. }
  procedure TryGetChildren;
  function NeedUpdate: Boolean;
  procedure IncThisChildrenCount;
  procedure Create;
  procedure DoTryGetChildren;
  function NeedMakeChildren: Boolean;
 end;//TevContentsNode
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , l3Types
 , l3Bits
 , l3TreeInterfaces
;

end.
