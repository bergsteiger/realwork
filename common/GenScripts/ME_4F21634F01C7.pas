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
  {* ����� ������� MODAL
*������:*
[code]
 aBeforeModal MODAL aWord
[code]  }
  procedure MODAL(const aCtx: TtfwContext;
   aWord: TtfwWord;
   aBeforeModal: TtfwWord);
   {* ���������� ����� ������� MODAL }
 end;//TkwMODAL
 
 TkwTHREAD = class(TtfwWordWorkerEx)
  {* ����� ������� THREAD
*������:*
[code]
 THREAD aWord
[code]  }
  procedure THREAD(const aCtx: TtfwContext;
   aWord: TtfwWord);
   {* ���������� ����� ������� THREAD }
 end;//TkwTHREAD
 
end.
