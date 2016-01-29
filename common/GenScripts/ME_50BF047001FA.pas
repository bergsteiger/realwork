unit seThreadSupport;

interface

uses
 l3IntfUses
 , Classes
 , tfwScriptingInterfaces
 , l3ProtoDataContainer
;

type
 TWordThread = class(TThread)
  procedure Execute;
 end;//TWordThread
 
 TseWorkThreadList = class(_l3ObjectPtrList_)
  procedure WaitForAllThreads;
  procedure AddAndResumeThread(const aContext: TtfwContext;
   const aWord: TtfwWord);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TseWorkThreadList
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
