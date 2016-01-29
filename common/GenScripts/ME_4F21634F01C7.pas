unit CodeFlowWordsPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwWordWorkerEx
 , TypInfo
;

implementation

uses
 l3ImplUses
 , seModalSupport
 , l3AFWExceptions
 , seThreadSupport
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwMODAL = class(TtfwWordWorkerEx)
  {* Слово скрипта MODAL
*Пример:*
[code]
 aBeforeModal MODAL aWord
[code]  }
  procedure MODAL(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aBeforeModal: TtfwWord);
   {* Реализация слова скрипта MODAL }
 end;//TkwMODAL
 
 TkwTHREAD = class(TtfwWordWorkerEx)
  {* Слово скрипта THREAD
*Пример:*
[code]
 THREAD aWord
[code]  }
  procedure THREAD(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* Реализация слова скрипта THREAD }
 end;//TkwTHREAD
 
end.
