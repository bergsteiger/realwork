unit ddServerTaskManagerPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Server"
// Модуль: "w:/archi/source/projects/PipeInAuto/Server/ddServerTaskManagerPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Server::Server::TddServerTaskManagerPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide)}
uses
  l3ProtoObject
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csTaskTypes
  {$IfEnd} //not Nemesis
  ,
  csTaskListening,
  evdTaskTypes,
  ddTaskItemPrim
  ;
{$IfEnd} //AppServerSide

{$If defined(AppServerSide)}
type
 TddServerTaskManagerPrim = class(Tl3ProtoObject, IcsTaskListener)
 protected
 // realized methods
   procedure TaskChanged(aTask: TddTaskItemPrim;
     aStatus: TcsTaskStatus);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 protected
 // protected methods
   procedure DoTaskChanged(aTask: TddTaskItem;
     aStatus: TcsTaskStatus); virtual; abstract;
 end;//TddServerTaskManagerPrim
{$IfEnd} //AppServerSide

implementation

{$If defined(AppServerSide)}

// start class TddServerTaskManagerPrim

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

{$IfEnd} //AppServerSide

end.