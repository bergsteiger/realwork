unit nsNewCachableNodeThatNeedKeepRoot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsNewCachableNodeThatNeedKeepRoot.pas"
// �����: 16.09.2011 20:53
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::OldTree::TnsNewCachableNodeThatNeedKeepRoot
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(const aNode: INodeBase;
     const aRootToKeep: INodeBase); reintroduce;
   class function Make(const aNode: INodeBase;
     const aRootToKeep: INodeBase): Il3Node; reintroduce;
     {* ��������� ������� TnsNewCachableNodeThatNeedKeepRoot.Make }
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