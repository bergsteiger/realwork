unit alcuAsyncTaskFinishedNotifierList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tasks/alcuAsyncTaskFinishedNotifierList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi$AutoPipeServer$Garant::Tasks::ServerAsyncExecution::TalcuAsyncTaskFinishedNotifierList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  l3ProtoDataContainer,
  alcuServerAsyncExecutionInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}
type
 _ItemType_ = IalcuAsyncTaskFinishedNotifier;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TalcuAsyncTaskFinishedNotifierList = class(_l3InterfacePtrList_)
 end;//TalcuAsyncTaskFinishedNotifierList
{$IfEnd} //AppServerSide AND ServerTasks

implementation

{$If defined(AppServerSide) AND defined(ServerTasks)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //AppServerSide AND ServerTasks

{$If defined(AppServerSide) AND defined(ServerTasks)}

type _Instance_R_ = TalcuAsyncTaskFinishedNotifierList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}


{$IfEnd} //AppServerSide AND ServerTasks
end.