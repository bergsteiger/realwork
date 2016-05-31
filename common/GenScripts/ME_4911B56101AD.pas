unit nsDeferredTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Folders\nsDeferredTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDeferredTree" MUID: (4911B56101AD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Tree
 , FoldersDomainInterfaces
 , l3Tree_TLB
 , l3Base
;

type
 TnsDeferredTreeWaitThread = class(Tl3ThreadContainer)
  private
   f_Tree: Pointer;
    {* InsDeferredTree }
   f_Root: Il3RootNode;
  private
   procedure AssignRoot;
   function Tree: InsDeferredTree;
  protected
   procedure DoExecute; override;
    {* основная процедура нити. Для перекрытия в потомках }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTree: InsDeferredTree); reintroduce;
 end;//TnsDeferredTreeWaitThread

 TnsDeferredTree = class(Tl3Tree, InsDeferredTree)
  private
   f_isReady: Boolean;
   f_BuilderThread: TnsDeferredTreeWaitThread;
  protected
   function DoMakeRealRoot: Il3RootNode; virtual; abstract;
   function MakeFakeRoot: Il3RootNode; virtual; abstract;
   procedure DoSetBuildedRoot(const aNewRoot: Il3RootNode); virtual;
   function MakeRealRoot: Il3RootNode;
   procedure SetBuildedRoot(const aNewRoot: Il3RootNode);
   procedure WaitForReady;
   function IsReady: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Make: InsDeferredTree; reintroduce;
 end;//TnsDeferredTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

procedure TnsDeferredTreeWaitThread.AssignRoot;
//#UC START# *4911B71302B4_4911B6CC0061_var*
//#UC END# *4911B71302B4_4911B6CC0061_var*
begin
//#UC START# *4911B71302B4_4911B6CC0061_impl*
 Tree.SetBuildedRoot(f_Root);
//#UC END# *4911B71302B4_4911B6CC0061_impl*
end;//TnsDeferredTreeWaitThread.AssignRoot

function TnsDeferredTreeWaitThread.Tree: InsDeferredTree;
//#UC START# *4911B7220027_4911B6CC0061_var*
//#UC END# *4911B7220027_4911B6CC0061_var*
begin
//#UC START# *4911B7220027_4911B6CC0061_impl*
 Result := InsDeferredTree(f_Tree);
//#UC END# *4911B7220027_4911B6CC0061_impl*
end;//TnsDeferredTreeWaitThread.Tree

constructor TnsDeferredTreeWaitThread.Create(const aTree: InsDeferredTree);
//#UC START# *4911B76C0033_4911B6CC0061_var*
//#UC END# *4911B76C0033_4911B6CC0061_var*
begin
//#UC START# *4911B76C0033_4911B6CC0061_impl*
 f_Tree := Pointer(aTree);
 inherited Create(nil);
 Suspended := false;
//#UC END# *4911B76C0033_4911B6CC0061_impl*
end;//TnsDeferredTreeWaitThread.Create

procedure TnsDeferredTreeWaitThread.DoExecute;
 {* основная процедура нити. Для перекрытия в потомках }
//#UC START# *4911B69E037D_4911B6CC0061_var*
//#UC END# *4911B69E037D_4911B6CC0061_var*
begin
//#UC START# *4911B69E037D_4911B6CC0061_impl*
 if Assigned(f_Tree) then
 begin
  try
   f_Root := Tree.MakeRealRoot;
  except
   f_Root := nil;
  end;
  Synchronize(AssignRoot);
 end;
//#UC END# *4911B69E037D_4911B6CC0061_impl*
end;//TnsDeferredTreeWaitThread.DoExecute

procedure TnsDeferredTreeWaitThread.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4911B6CC0061_var*
//#UC END# *479731C50290_4911B6CC0061_var*
begin
//#UC START# *479731C50290_4911B6CC0061_impl*
 f_Tree := nil;
 f_Root := nil;
 inherited;
//#UC END# *479731C50290_4911B6CC0061_impl*
end;//TnsDeferredTreeWaitThread.Cleanup

class function TnsDeferredTree.Make: InsDeferredTree;
var
 l_Inst : TnsDeferredTree;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsDeferredTree.Make

procedure TnsDeferredTree.DoSetBuildedRoot(const aNewRoot: Il3RootNode);
//#UC START# *4911C5EC0155_4911B56101AD_var*
//#UC END# *4911C5EC0155_4911B56101AD_var*
begin
//#UC START# *4911C5EC0155_4911B56101AD_impl*
 f_isReady := True;
 RootNode := aNewRoot;
//#UC END# *4911C5EC0155_4911B56101AD_impl*
end;//TnsDeferredTree.DoSetBuildedRoot

function TnsDeferredTree.MakeRealRoot: Il3RootNode;
//#UC START# *4911B2900238_4911B56101AD_var*
//#UC END# *4911B2900238_4911B56101AD_var*
begin
//#UC START# *4911B2900238_4911B56101AD_impl*
 Result := DoMakeRealRoot;
//#UC END# *4911B2900238_4911B56101AD_impl*
end;//TnsDeferredTree.MakeRealRoot

procedure TnsDeferredTree.SetBuildedRoot(const aNewRoot: Il3RootNode);
//#UC START# *4911B29F0366_4911B56101AD_var*
//#UC END# *4911B29F0366_4911B56101AD_var*
begin
//#UC START# *4911B29F0366_4911B56101AD_impl*
 DoSetBuildedRoot(aNewRoot);
//#UC END# *4911B29F0366_4911B56101AD_impl*
end;//TnsDeferredTree.SetBuildedRoot

procedure TnsDeferredTree.WaitForReady;
//#UC START# *4911B2AA014F_4911B56101AD_var*
//#UC END# *4911B2AA014F_4911B56101AD_var*
begin
//#UC START# *4911B2AA014F_4911B56101AD_impl*
 if not f_isReady and Assigned(f_BuilderThread) then
  f_BuilderThread.WaitFor;
//#UC END# *4911B2AA014F_4911B56101AD_impl*
end;//TnsDeferredTree.WaitForReady

function TnsDeferredTree.IsReady: Boolean;
//#UC START# *4911B2B500D6_4911B56101AD_var*
//#UC END# *4911B2B500D6_4911B56101AD_var*
begin
//#UC START# *4911B2B500D6_4911B56101AD_impl*
 Result := f_isReady;
//#UC END# *4911B2B500D6_4911B56101AD_impl*
end;//TnsDeferredTree.IsReady

procedure TnsDeferredTree.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4911B56101AD_var*
//#UC END# *479731C50290_4911B56101AD_var*
begin
//#UC START# *479731C50290_4911B56101AD_impl*
 f_isReady := False;
 l3Free(f_BuilderThread);
 inherited;
//#UC END# *479731C50290_4911B56101AD_impl*
end;//TnsDeferredTree.Cleanup

procedure TnsDeferredTree.InitFields;
//#UC START# *47A042E100E2_4911B56101AD_var*
//#UC END# *47A042E100E2_4911B56101AD_var*
begin
//#UC START# *47A042E100E2_4911B56101AD_impl*
 inherited;
 RootNode := MakeFakeRoot;
 f_BuilderThread := TnsDeferredTreeWaitThread.Create(Self);
//#UC END# *47A042E100E2_4911B56101AD_impl*
end;//TnsDeferredTree.InitFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
