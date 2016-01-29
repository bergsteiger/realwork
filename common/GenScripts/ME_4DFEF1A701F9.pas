unit evContentsTagNode;

interface

uses
 l3IntfUses
 , evContentsNode
 , l3TreeInterfaces
 , l3Variant
 , evInternalInterfaces
 , l3Tree_TLB
 , l3Interfaces
 , l3IID
;

type
 TevContentsTagNode = class(TevContentsNode, Il3HandleNode)
  procedure MakeChildNode(aTag: Tl3Variant);
   {* Создает новую ноду. }
  procedure CheckTable(aTag: Tl3Variant);
   {* Проверяет таблицу на метки. }
  function GetPara: Tl3Variant;
   {* Получить параграф, на который ссылается узел. }
  function MakeAndInsertNode(const aNode: Il3Node;
   aTag: Tl3Variant;
   aSub: Tl3Variant): Il3Node;
   {* Чисто обобщающая функция вставки. }
  procedure Create(aTag: Tl3Variant;
   const aFilter: InevContentsNodeFilter);
  function Make(aTag: Tl3Variant;
   const aFilter: InevContentsNodeFilter): Il3Node;
  function GetLayerID: Integer;
  function GetHandle: Integer;
  function Handle: Integer;
   {* идентификатор узла. }
  procedure DoTryGetChildren;
 end;//TevContentsTagNode
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , l3Types
 , SysUtils
 , Block_Const
 , Table_Const
 , evdTypes
 , Document_Const
 , Sub_Const
 , LeafPara_Const
 , l3Base
 , evDocumentPart
 , evContentsNodeFactory
 , k2Tags
 , k2NullTagImpl
 , nevTools
;

end.
