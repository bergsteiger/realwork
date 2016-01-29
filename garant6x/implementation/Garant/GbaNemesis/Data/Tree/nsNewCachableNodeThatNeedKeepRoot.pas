unit nsNewCachableNodeThatNeedKeepRoot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsNewCachableNodeThatNeedKeepRoot.pas"
// Начат: 16.09.2011 20:53
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::OldTree::TnsNewCachableNodeThatNeedKeepRoot
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  DynamicTreeUnit,
  l3Tree_TLB,
  nsNewCachableNode,
  l3Interfaces,
  l3TreeInterfaces
  ;

type
 TnsNewCachableNodeThatNeedKeepRoot = class(TnsNewCachableNode)
 private
 // private fields
   f_RootToKeep : INodeBase;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: INodeBase;
     const aRootToKeep: INodeBase); reintroduce;
   class function Make(const aNode: INodeBase;
     const aRootToKeep: INodeBase): Il3Node; reintroduce;
     {* Сигнатура фабрики TnsNewCachableNodeThatNeedKeepRoot.Make }
 end;//TnsNewCachableNodeThatNeedKeepRoot

implementation

// start class TnsNewCachableNodeThatNeedKeepRoot

constructor TnsNewCachableNodeThatNeedKeepRoot.Create(const aNode: INodeBase;
  const aRootToKeep: INodeBase);
//#UC START# *4E737F9900B3_4E737EFA0153_var*
//#UC END# *4E737F9900B3_4E737EFA0153_var*
begin
//#UC START# *4E737F9900B3_4E737EFA0153_impl*
 inherited Create(aNode);
 f_RootToKeep := aRootToKeep;
//#UC END# *4E737F9900B3_4E737EFA0153_impl*
end;//TnsNewCachableNodeThatNeedKeepRoot.Create

class function TnsNewCachableNodeThatNeedKeepRoot.Make(const aNode: INodeBase;
  const aRootToKeep: INodeBase): Il3Node;
var
 l_Inst : TnsNewCachableNodeThatNeedKeepRoot;
begin
 l_Inst := Create(aNode, aRootToKeep);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsNewCachableNodeThatNeedKeepRoot.ClearFields;
 {-}
begin
 f_RootToKeep := nil;
 inherited;
end;//TnsNewCachableNodeThatNeedKeepRoot.ClearFields

end.