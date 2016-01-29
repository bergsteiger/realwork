unit kwCompiledWordWorker;

interface

uses
 l3IntfUses
 , kwSourcePointWord
 , tfwScriptingInterfaces
;

type
 RkwCompiledWordWorker = class of TkwCompiledWordWorker;
 
 TkwCompiledWordWorker = class(TkwSourcePointWord)
  {* Базовый класс для исполняемых скомпилированных слов. }
  procedure Create(aWordToPush: TtfwWord;
   aWordToRun: TtfwWord;
   const aCtx: TtfwContext);
 end;//TkwCompiledWordWorker
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
