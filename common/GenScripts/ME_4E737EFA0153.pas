unit nsNewCachableNodeThatNeedKeepRoot;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsNewCachableNodeThatNeedKeepRoot.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsNewCachableNode
 , DynamicTreeUnit
 , l3Tree_TLB
;

type
 TnsNewCachableNodeThatNeedKeepRoot = class(TnsNewCachableNode)
  private
   f_RootToKeep: INodeBase;
  protected
   procedure ClearFields; override;
  public
   constructor Create(const aNode: INodeBase;
    const aRootToKeep: INodeBase); reintroduce;
   class function Make(const aNode: INodeBase;
    const aRootToKeep: INodeBase): Il3Node; reintroduce;
 end;//TnsNewCachableNodeThatNeedKeepRoot

implementation

uses
 l3ImplUses
;

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
end;//TnsNewCachableNodeThatNeedKeepRoot.Make

procedure TnsNewCachableNodeThatNeedKeepRoot.ClearFields;
begin
 f_RootToKeep := nil;
 inherited;
end;//TnsNewCachableNodeThatNeedKeepRoot.ClearFields

end.
