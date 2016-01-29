unit ctComboBoxStringsItemNode;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , ComboBoxStrings
 , l3Interfaces
;

type
 TctComboBoxStringsItemNode = class(Tl3CacheableBase, Il3SimpleNode, IctNodeWrap)
  procedure Create(aStrings: TComboBoxStrings;
   anIndex: Integer);
  procedure Make(aStrings: TComboBoxStrings;
   anIndex: Integer);
  function IsFirst: Boolean;
   {* это первый узел внутри родителя? }
  function IsLast: Boolean;
   {* это последний узел внутри родителя? }
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
             применяется в виртуальных нодах - указателях на данные. }
  procedure BeginMove(var aUserParam: Pointer);
   {* начать перемещение узла. }
  procedure EndMove(aUserParam: Pointer);
   {* закончить перемещение узла. }
  procedure Delete;
   {* удалить узел из дерева, а его данные с постоянного носителя (например из БД) или связанные объекты. }
  function Text: Tl3PCharLenPrim;
   {* текст узла. }
  function Parent: Il3SimpleNode;
   {* родительский узел. }
  function Child: Il3SimpleNode;
   {* первый дочерний элемент. }
  function Next: Il3SimpleNode;
   {* Следующий сосед. }
  function Flag: Boolean;
  function Flags: Integer;
  function ThisChildrenCount: Integer;
   {* число дочерних элементов, БЕЗ детей всех вложенные. }
  function IndexInParent: Integer;
   {* индекс узла в родительском. }
  function CanAcceptData(const aData: Tl3TreeData): Boolean;
   {* может ли узел принять данные }
  function DropData(const aData: Tl3TreeData): Boolean;
   {* принять данные }
  function CanMove: Boolean;
   {* определяет возможность перемещения узла }
  function Prev: Il3SimpleNode;
   {* Предыдущий сосед. }
  function GetSelf: TctComboBoxStringsItemNode;
 end;//TctComboBoxStringsItemNode
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
 , l3InterfacesMisc
 , l3Bits
;

type
 IctNodeWrap = interface
  {* Обёртка над нодой, позволяющая получить реализацию. }
  function GetSelf: TctComboBoxStringsItemNode;
 end;//IctNodeWrap
 
end.
