unit alcuAsyncTaskFinishedNotifierList;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tasks\alcuAsyncTaskFinishedNotifierList.pas"
// Стереотип: "SimpleClass"

{$Include alcuDefine.inc}

interface

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , alcuServerAsyncExecutionInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IalcuAsyncTaskFinishedNotifier;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3InterfacePtrList.imp.pas}
 TalcuAsyncTaskFinishedNotifierList = class(_l3InterfacePtrList_)
 end;//TalcuAsyncTaskFinishedNotifierList
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

implementation

{$If Defined(ServerTasks) AND Defined(AppServerSide)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TalcuAsyncTaskFinishedNotifierList;

{$Include l3InterfacePtrList.imp.pas}
{$IfEnd} // Defined(ServerTasks) AND Defined(AppServerSide)

end.
