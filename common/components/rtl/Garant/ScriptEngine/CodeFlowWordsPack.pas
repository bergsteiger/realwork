unit CodeFlowWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CodeFlowWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "CodeFlowWordsPack" MUID: (4F21634F01C7)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwWordWorkerEx
 , tfwScriptingInterfaces
 , TypInfo
 , seModalSupport
 , l3AFWExceptions
 , seThreadSupport
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4F21634F01C7impl_uses*
 //#UC END# *4F21634F01C7impl_uses*
;

type
 TkwMODAL = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта MODAL }
  private
   procedure MODAL(const aCtx: TtfwContext;
    aWord: TtfwWord;
    aBeforeModal: TtfwWord);
    {* Реализация слова скрипта MODAL }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwMODAL

 TkwTHREAD = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта THREAD }
  private
   procedure THREAD(const aCtx: TtfwContext;
    aWord: TtfwWord);
    {* Реализация слова скрипта THREAD }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure DoRun(const aCtx: TtfwContext); override;
 end;//TkwTHREAD

procedure TkwMODAL.MODAL(const aCtx: TtfwContext;
 aWord: TtfwWord;
 aBeforeModal: TtfwWord);
 {* Реализация слова скрипта MODAL }
//#UC START# *553F9F73034D_553F9F73034D_Word_var*
var
 l_Count : Integer;
//#UC END# *553F9F73034D_553F9F73034D_Word_var*
begin
//#UC START# *553F9F73034D_553F9F73034D_Word_impl*
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
//#UC END# *553F9F73034D_553F9F73034D_Word_impl*
end;//TkwMODAL.MODAL

class function TkwMODAL.GetWordNameForRegister: AnsiString;
begin
 Result := 'MODAL';
end;//TkwMODAL.GetWordNameForRegister

function TkwMODAL.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMODAL.GetResultTypeInfo

function TkwMODAL.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMODAL.GetAllParamsCount

function TkwMODAL.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMODAL.RightParamsCount

function TkwMODAL.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwMODAL.ParamsTypes

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

procedure TkwTHREAD.THREAD(const aCtx: TtfwContext;
 aWord: TtfwWord);
 {* Реализация слова скрипта THREAD }
//#UC START# *553FAAB10161_553FAAB10161_Word_var*
//#UC END# *553FAAB10161_553FAAB10161_Word_var*
begin
//#UC START# *553FAAB10161_553FAAB10161_Word_impl*
 TseWorkThreadList.Instance.AddAndResumeThread(aCtx, aWord);
//#UC END# *553FAAB10161_553FAAB10161_Word_impl*
end;//TkwTHREAD.THREAD

class function TkwTHREAD.GetWordNameForRegister: AnsiString;
begin
 Result := 'THREAD';
end;//TkwTHREAD.GetWordNameForRegister

function TkwTHREAD.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTHREAD.GetResultTypeInfo

function TkwTHREAD.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTHREAD.GetAllParamsCount

function TkwTHREAD.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwTHREAD.RightParamsCount

function TkwTHREAD.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwTHREAD.ParamsTypes

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

initialization
 TkwMODAL.RegisterInEngine;
 {* Регистрация MODAL }
 TkwTHREAD.RegisterInEngine;
 {* Регистрация THREAD }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
