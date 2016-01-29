unit evContentsNodeFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evContentsNodeFactory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ContentsTree::TevContentsNodeFactory
//
// Фабрика для создания нод.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3TreeInterfaces,
  l3Tree_TLB,
  evInternalInterfaces,
  l3Variant
  ;

type
 TevContentsNodeFactory = class
  {* Фабрика для создания нод. }
 public
 // public methods
   class function CreateContentsNode(aTag: Tl3Variant;
     aSub: Tl3Variant;
     const aFilter: InevContentsNodeFilter): Il3Node;
     {* Создает узел ноды для документа, блока, саба. }
   class function CreateRoot: Il3SimpleRootNode;
     {* Создает рутовый узел. }
 end;//TevContentsNodeFactory

implementation

uses
  evDocumentNode,
  evContentsTagNode,
  evContentsSubNode,
  Document_Const,
  evRootContentsNode,
  l3Nodes
  ;

// start class TevContentsNodeFactory

class function TevContentsNodeFactory.CreateContentsNode(aTag: Tl3Variant;
  aSub: Tl3Variant;
  const aFilter: InevContentsNodeFilter): Il3Node;
//#UC START# *4E26CFD1000A_4E26CCF0021F_var*
//#UC END# *4E26CFD1000A_4E26CCF0021F_var*
begin
//#UC START# *4E26CFD1000A_4E26CCF0021F_impl*
 if (aTag = nil) then
  Result := l3Nodes.MakeNode('<Приехал пустой узел>')
 else
 if aTag.IsKindOf(k2_typDocument) then
  Result := TevDocumentNode.Make(aTag, aFilter)
 else
 if aSub = nil then
  Result := TevContentsTagNode.Make(aTag, aFilter)
 else
  Result := TevContentsSubNode.Make(aTag, aSub, aFilter);
//#UC END# *4E26CFD1000A_4E26CCF0021F_impl*
end;//TevContentsNodeFactory.CreateContentsNode

class function TevContentsNodeFactory.CreateRoot: Il3SimpleRootNode;
//#UC START# *4E26D05D00FA_4E26CCF0021F_var*
//#UC END# *4E26D05D00FA_4E26CCF0021F_var*
begin
//#UC START# *4E26D05D00FA_4E26CCF0021F_impl*
 Result := TevRootContentsNode.Make;
//#UC END# *4E26D05D00FA_4E26CCF0021F_impl*
end;//TevContentsNodeFactory.CreateRoot

end.