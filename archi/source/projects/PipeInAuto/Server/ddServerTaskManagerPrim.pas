unit ddServerTaskManagerPrim;

// Модуль: "w:\archi\source\projects\PipeInAuto\Server\ddServerTaskManagerPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddServerTaskManagerPrim" MUID: (5385C5B200E6)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , csTaskListening
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 , ddTaskItemPrim
 , evdTaskTypes
;

type
 TddServerTaskManagerPrim = class(Tl3ProtoObject, IcsTaskListener)
  protected
   procedure DoTaskChanged(aTask: TddTaskItem;
    aStatus: TcsTaskStatus); virtual; abstract;
   procedure TaskChanged(aTask: TddTaskItemPrim;
    aStatus: TcsTaskStatus);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//TddServerTaskManagerPrim
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
;

procedure TddServerTaskManagerPrim.TaskChanged(aTask: TddTaskItemPrim;
 aStatus: TcsTaskStatus);
//#UC START# *5385C23A0106_5385C5B200E6_var*
//#UC END# *5385C23A0106_5385C5B200E6_var*
begin
//#UC START# *5385C23A0106_5385C5B200E6_impl*
 if (aTask Is TddTaskItem) then
  DoTaskChanged(TddTaskItem(aTask), aStatus);
//#UC END# *5385C23A0106_5385C5B200E6_impl*
end;//TddServerTaskManagerPrim.TaskChanged

procedure TddServerTaskManagerPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5385C5B200E6_var*
//#UC END# *479731C50290_5385C5B200E6_var*
begin
//#UC START# *479731C50290_5385C5B200E6_impl*
 if TcsTaskListeners.Exists then
  TcsTaskListeners.Instance.RemoveListener(Self);
 inherited;
//#UC END# *479731C50290_5385C5B200E6_impl*
end;//TddServerTaskManagerPrim.Cleanup

procedure TddServerTaskManagerPrim.InitFields;
//#UC START# *47A042E100E2_5385C5B200E6_var*
//#UC END# *47A042E100E2_5385C5B200E6_var*
begin
//#UC START# *47A042E100E2_5385C5B200E6_impl*
 inherited;
 TcsTaskListeners.Instance.AddListener(Self);
//#UC END# *47A042E100E2_5385C5B200E6_impl*
end;//TddServerTaskManagerPrim.InitFields
{$IfEnd} // Defined(AppServerSide)

end.
