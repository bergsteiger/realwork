unit csTaskListening;

// Модуль: "w:\common\components\rtl\Garant\EVD\csTaskListening.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "csTaskListening" MUID: (5385C1C902F5)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , ddTaskItemPrim
 , evdTaskTypes
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 IcsTaskListener = interface
  ['{5C9E51A0-4037-4900-A940-DAE56637982D}']
  procedure TaskChanged(aTask: TddTaskItemPrim;
   aStatus: TcsTaskStatus);
 end;//IcsTaskListener

 _ItemType_ = IcsTaskListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TcsTaskListeners = class(_l3InterfacePtrList_)
  public
   procedure AddListener(const aListener: IcsTaskListener);
   procedure RemoveListener(const aListener: IcsTaskListener);
   class function Exists: Boolean;
   procedure TaskChanged(aTask: TddTaskItemPrim;
    aStatus: TcsTaskStatus);
   class function Instance: TcsTaskListeners;
    {* Метод получения экземпляра синглетона TcsTaskListeners }
 end;//TcsTaskListeners

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

var g_TcsTaskListeners: TcsTaskListeners = nil;
 {* Экземпляр синглетона TcsTaskListeners }

procedure TcsTaskListenersFree;
 {* Метод освобождения экземпляра синглетона TcsTaskListeners }
begin
 l3Free(g_TcsTaskListeners);
end;//TcsTaskListenersFree

type _Instance_R_ = TcsTaskListeners;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

procedure TcsTaskListeners.AddListener(const aListener: IcsTaskListener);
//#UC START# *5385C33700DA_5385C2D801D9_var*
//#UC END# *5385C33700DA_5385C2D801D9_var*
begin
//#UC START# *5385C33700DA_5385C2D801D9_impl*
 Assert(aListener <> nil);
 if (IndexOf(aLIstener) < 0) then
  Add(aListener);
//#UC END# *5385C33700DA_5385C2D801D9_impl*
end;//TcsTaskListeners.AddListener

procedure TcsTaskListeners.RemoveListener(const aListener: IcsTaskListener);
//#UC START# *5385C35701F6_5385C2D801D9_var*
//#UC END# *5385C35701F6_5385C2D801D9_var*
begin
//#UC START# *5385C35701F6_5385C2D801D9_impl*
 Assert(aListener <> nil);
 Remove(aListener);
//#UC END# *5385C35701F6_5385C2D801D9_impl*
end;//TcsTaskListeners.RemoveListener

class function TcsTaskListeners.Exists: Boolean;
//#UC START# *5385C372027A_5385C2D801D9_var*
//#UC END# *5385C372027A_5385C2D801D9_var*
begin
//#UC START# *5385C372027A_5385C2D801D9_impl*
 Result := (g_TcsTaskListeners <> nil);
//#UC END# *5385C372027A_5385C2D801D9_impl*
end;//TcsTaskListeners.Exists

procedure TcsTaskListeners.TaskChanged(aTask: TddTaskItemPrim;
 aStatus: TcsTaskStatus);
//#UC START# *5385C3A60146_5385C2D801D9_var*
var
 l_Index : Integer;
//#UC END# *5385C3A60146_5385C2D801D9_var*
begin
//#UC START# *5385C3A60146_5385C2D801D9_impl*
 for l_Index := 0 to Pred(Count) do
  Items[l_Index].TaskChanged(aTask, aStatus);
//#UC END# *5385C3A60146_5385C2D801D9_impl*
end;//TcsTaskListeners.TaskChanged

class function TcsTaskListeners.Instance: TcsTaskListeners;
 {* Метод получения экземпляра синглетона TcsTaskListeners }
begin
 if (g_TcsTaskListeners = nil) then
 begin
  l3System.AddExitProc(TcsTaskListenersFree);
  g_TcsTaskListeners := Create;
 end;
 Result := g_TcsTaskListeners;
end;//TcsTaskListeners.Instance

end.
