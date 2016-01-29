unit nsDeferredTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Folders"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Folders/nsDeferredTree.pas"
// Начат: 2006/10/23 08:36:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Основные прецеденты::Folders::Folders::Folders::TnsDeferredTree
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Tree_TLB,
  l3Base,
  l3Tree,
  FoldersDomainInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsDeferredTreeWaitThread = class(Tl3ThreadContainer)
 private
 // private fields
   f_Tree : Pointer;
    {* InsDeferredTree}
   f_Root : Il3RootNode;
 private
 // private methods
   procedure AssignRoot;
   function Tree: InsDeferredTree;
 protected
 // realized methods
   procedure DoExecute; override;
     {* основная процедура нити. Для перекрытия в потомках }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTree: InsDeferredTree); reintroduce;
 end;//TnsDeferredTreeWaitThread

 TnsDeferredTree = class(Tl3Tree, InsDeferredTree)
 private
 // private fields
   f_isReady : Boolean;
   f_BuilderThread : TnsDeferredTreeWaitThread;
 protected
 // realized methods
   function MakeRealRoot: Il3RootNode;
   procedure SetBuildedRoot(const aNewRoot: Il3RootNode);
   procedure WaitForReady;
   function IsReady: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   function DoMakeRealRoot: Il3RootNode; virtual; abstract;
   function MakeFakeRoot: Il3RootNode; virtual; abstract;
   procedure DoSetBuildedRoot(const aNewRoot: Il3RootNode); virtual;
 public
 // public methods
   class function Make: InsDeferredTree; reintroduce;
 end;//TnsDeferredTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsDeferredTreeWaitThread

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
end;

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

{$IfEnd} //not Admin AND not Monitorings

end.