unit ComboBoxStrings;

interface

uses
 l3IntfUses
 , l3VCLStrings
 , l3TreeInterfaces
 , l3Interfaces
;

type
 TComboBoxStrings = class(Tl3Strings, Il3SimpleNode, Il3SimpleRootNode)
  function DoMakeChild: Il3SimpleNode;
   {* —оздать первого ребенка }
  function IsFirst: Boolean;
   {* это первый узел внутри родител€? }
  function IsLast: Boolean;
   {* это последний узел внутри родител€? }
  function HasChild: Boolean;
   {* есть ли дочерние узлы? }
  function MaybeChild: Boolean;
   {* может ли иметь дочерние узлы? }
  function GetLevel: Integer;
  function GetLevelFor(const aNode: Il3SimpleNode): Integer;
  function IsSame(const aNode: Il3SimpleNode): Boolean;
   {* сравнивает ноды. }
  function IsDisappeared: Boolean;
   {* True если интерфейс на удаленную ноду,
             примен€етс€ в виртуальных нодах - указател€х на данные. }
  procedure BeginMove(var aUserParam: Pointer);
   {* начать перемещение узла. }
  procedure EndMove(aUserParam: Pointer);
   {* закончить перемещение узла. }
  procedure Delete;
   {* удалить узел из дерева, а его данные с посто€нного носител€ (например из Ѕƒ) или св€занные объекты. }
  function Text: Tl3PCharLenPrim;
   {* текст узла. }
  function Parent: Il3SimpleNode;
   {* родительский узел. }
  function Child: Il3SimpleNode;
   {* первый дочерний элемент. }
  function Next: Il3SimpleNode;
   {* —ледующий сосед. }
  function Flag: Boolean;
  function Flags: Integer;
  function ThisChildrenCount: Integer;
   {* число дочерних элементов, Ѕ≈« детей всех вложенные. }
  function IndexInParent: Integer;
   {* индекс узла в родительском. }
  function CanExpandCollapseAll: Boolean;
  procedure ExpandCollapseAll(anExpand: Boolean);
  function CanAcceptData(const aData: Tl3TreeData): Boolean;
   {* может ли узел прин€ть данные }
  function DropData(const aData: Tl3TreeData): Boolean;
   {* прин€ть данные }
  function CanMove: Boolean;
   {* определ€ет возможность перемещени€ узла }
  function Prev: Il3SimpleNode;
   {* ѕредыдущий сосед. }
 end;//TComboBoxStrings
 
implementation

uses
 l3ImplUses
 , l3String
 , ctComboBoxStringsItemNode
 , l3InterfacesMisc
 , l3Bits
;

end.
