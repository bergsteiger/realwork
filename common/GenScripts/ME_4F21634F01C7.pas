unit CodeFlowWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CodeFlowWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwWordWorkerEx
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
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
 TkwMODAL = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта MODAL
*Пример:*
[code]
 aBeforeModal MODAL aWord
[code]  }
  private
   procedure MODAL(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aBeforeModal: TtfwWord);
    {* Реализация слова скрипта MODAL }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMODAL

 TkwTHREAD = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта THREAD
*Пример:*
[code]
 THREAD aWord
[code]  }
  private
   procedure THREAD(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта THREAD }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTHREAD

procedure TkwMODAL.MODAL(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aBeforeModal: TtfwWord);
 {* Реализация слова скрипта MODAL }
//#UC START# *D14B34278240_05ABA7975E25_var*
var
 l_Count : Integer;
//#UC END# *D14B34278240_05ABA7975E25_var*
begin
//#UC START# *D14B34278240_05ABA7975E25_impl*
 l_Count := seAddModalWorker(aWord, aCtx);
 try
  try
   aBeforeModal.DoIt(aCtx);
  except
(*   {$If defined(nsTest)}
   on El3TryEnterModalState do
    Exit;
   {$Else}*)
   // - закомментировал, т.к. непонятно - зачем в тестах это исключение давить
   raise;
(*   {$IfEnd} //nsTest*)
  end;//try..except
 finally
  RunnerAssert(seIsValidModalWorkersCount(l_Count), 'Видимо не выполнился код модального окна', aCtx);
 end;//try..finally
//#UC END# *D14B34278240_05ABA7975E25_impl*
end;//TkwMODAL.MODAL

class function TkwMODAL.GetWordNameForRegister: AnsiString;
begin
 Result := 'MODAL';
end;//TkwMODAL.GetWordNameForRegister

function TkwMODAL.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMODAL.RightParamsCount

procedure TkwMODAL.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_05ABA7975E25_var*
//#UC END# *5512949D0048_05ABA7975E25_var*
begin
//#UC START# *5512949D0048_05ABA7975E25_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_05ABA7975E25_impl*
end;//TkwMODAL.DoRun

function TkwMODAL.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_05ABA7975E25_var*
//#UC END# *551544E2001A_05ABA7975E25_var*
begin
//#UC START# *551544E2001A_05ABA7975E25_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_05ABA7975E25_impl*
end;//TkwMODAL.GetResultTypeInfo

function TkwMODAL.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_05ABA7975E25_var*
//#UC END# *559687E6025A_05ABA7975E25_var*
begin
//#UC START# *559687E6025A_05ABA7975E25_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_05ABA7975E25_impl*
end;//TkwMODAL.GetAllParamsCount

function TkwMODAL.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_05ABA7975E25_var*
//#UC END# *5617F4D00243_05ABA7975E25_var*
begin
//#UC START# *5617F4D00243_05ABA7975E25_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_05ABA7975E25_impl*
end;//TkwMODAL.ParamsTypes

procedure TkwTHREAD.THREAD(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта THREAD }
//#UC START# *A56425D1C72F_44C318D8896A_var*
//#UC END# *A56425D1C72F_44C318D8896A_var*
begin
//#UC START# *A56425D1C72F_44C318D8896A_impl*
 TseWorkThreadList.Instance.AddAndResumeThread(aCtx, aWord);
//#UC END# *A56425D1C72F_44C318D8896A_impl*
end;//TkwTHREAD.THREAD

class function TkwTHREAD.GetWordNameForRegister: AnsiString;
begin
 Result := 'THREAD';
end;//TkwTHREAD.GetWordNameForRegister

function TkwTHREAD.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTHREAD.RightParamsCount

procedure TkwTHREAD.DoRun(const aCtx: TtfwContext);
//#UC START# *5512949D0048_44C318D8896A_var*
//#UC END# *5512949D0048_44C318D8896A_var*
begin
//#UC START# *5512949D0048_44C318D8896A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5512949D0048_44C318D8896A_impl*
end;//TkwTHREAD.DoRun

function TkwTHREAD.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_44C318D8896A_var*
//#UC END# *551544E2001A_44C318D8896A_var*
begin
//#UC START# *551544E2001A_44C318D8896A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_44C318D8896A_impl*
end;//TkwTHREAD.GetResultTypeInfo

function TkwTHREAD.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_44C318D8896A_var*
//#UC END# *559687E6025A_44C318D8896A_var*
begin
//#UC START# *559687E6025A_44C318D8896A_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_44C318D8896A_impl*
end;//TkwTHREAD.GetAllParamsCount

function TkwTHREAD.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_44C318D8896A_var*
//#UC END# *5617F4D00243_44C318D8896A_var*
begin
//#UC START# *5617F4D00243_44C318D8896A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_44C318D8896A_impl*
end;//TkwTHREAD.ParamsTypes

initialization
 TkwMODAL.RegisterInEngine;
 {* Регистрация MODAL }
 TkwTHREAD.RegisterInEngine;
 {* Регистрация THREAD }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
