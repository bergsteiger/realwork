unit csTaskListening;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/csTaskListening.pas"
// Начат: 15:00 28.05.2014
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EVD::TasksTuning::csTaskListening
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  l3ProtoDataContainer,
  evdTaskTypes,
  ddTaskItemPrim,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 IcsTaskListener = interface(IUnknown)
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
 // public methods
   procedure AddListener(const aListener: IcsTaskListener);
   procedure RemoveListener(const aListener: IcsTaskListener);
   class function Exists: Boolean;
   procedure TaskChanged(aTask: TddTaskItemPrim;
     aStatus: TcsTaskStatus);
 public
 // singleton factory method
   class function Instance: TcsTaskListeners;
    {- возвращает экземпляр синглетона. }
 end;//TcsTaskListeners

implementation

uses
  l3Base {a},
  l3MinMax,
  RTLConsts,
  SysUtils
  ;


// start class TcsTaskListeners

var g_TcsTaskListeners : TcsTaskListeners = nil;

procedure TcsTaskListenersFree;
begin
 l3Free(g_TcsTaskListeners);
end;

class function TcsTaskListeners.Instance: TcsTaskListeners;
begin
 if (g_TcsTaskListeners = nil) then
 begin
  l3System.AddExitProc(TcsTaskListenersFree);
  g_TcsTaskListeners := Create;
 end;
 Result := g_TcsTaskListeners;
end;


type _Instance_R_ = TcsTaskListeners;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

// start class TcsTaskListeners

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

end.