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
var l_aWord: TtfwWord;
var l_aBeforeModal: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aBeforeModal := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aBeforeModal: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MODAL(aCtx, l_aWord, l_aBeforeModal);
end;//TkwMODAL.DoRun

function TkwMODAL.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMODAL.GetResultTypeInfo

function TkwMODAL.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMODAL.GetAllParamsCount

function TkwMODAL.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
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
var l_aWord: TtfwWord;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 THREAD(aCtx, l_aWord);
end;//TkwTHREAD.DoRun

function TkwTHREAD.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTHREAD.GetResultTypeInfo

function TkwTHREAD.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTHREAD.GetAllParamsCount

function TkwTHREAD.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
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
