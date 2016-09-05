unit msmModelLoadingThread;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelLoadingThread.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelLoadingThread" MUID: (57C3E95F0252)

{$Include w:\common\components\msm.inc}

interface

{$If Defined(seThreadSafe)}
uses
 l3IntfUses
 , msmModelLoadingThreadPrim
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57C3E95F0252intf_uses*
 //#UC END# *57C3E95F0252intf_uses*
;

type
 //#UC START# *57C3E95F0252ci*
 //#UC END# *57C3E95F0252ci*
 //#UC START# *57C3E95F0252cit*
 //#UC END# *57C3E95F0252cit*
 TmsmModelLoadingThread = class(TmsmModelLoadingThreadPrim)
  private
   f_MethodName: AnsiString;
  protected
   procedure DoExecute; override;
    {* основная процедура нити. Для перекрытия в потомках }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ThreadTerminated; override;
   procedure ClearFields; override;
  public
   constructor Create(aWordToLoad: TtfwWord;
    const aMethodName: AnsiString); reintroduce;
   class procedure CreateManaged(aWordToLoad: TtfwWord;
    const aMethodName: AnsiString);
   procedure Terminate; override;
 //#UC START# *57C3E95F0252publ*
 //#UC END# *57C3E95F0252publ*
 end;//TmsmModelLoadingThread
{$IfEnd} // Defined(seThreadSafe)

implementation

{$If Defined(seThreadSafe)}
uses
 l3ImplUses
 , msmModelElementMethodCaller
 , msmModelLoadingThreads
 //#UC START# *57C3E95F0252impl_uses*
 , SysUtils
 //#UC END# *57C3E95F0252impl_uses*
;

constructor TmsmModelLoadingThread.Create(aWordToLoad: TtfwWord;
 const aMethodName: AnsiString);
//#UC START# *57C7DFA7017B_57C3E95F0252_var*
//#UC END# *57C7DFA7017B_57C3E95F0252_var*
begin
//#UC START# *57C7DFA7017B_57C3E95F0252_impl*
 f_MethodName := aMethodName;
 inherited Create(aWordToLoad);
//#UC END# *57C7DFA7017B_57C3E95F0252_impl*
end;//TmsmModelLoadingThread.Create

class procedure TmsmModelLoadingThread.CreateManaged(aWordToLoad: TtfwWord;
 const aMethodName: AnsiString);
//#UC START# *57C6887501FC_57C3E95F0252_var*
var
 l_Index : Integer;
 l_T : TmsmModelLoadingThread;
//#UC END# *57C6887501FC_57C3E95F0252_var*
begin
//#UC START# *57C6887501FC_57C3E95F0252_impl*
 //Exit;
 with TmsmModelLoadingThreads.Instance do
 begin
  Lock;
  try
   if (Count > 5) then
    Exit;
   if not FindData(aWordToLoad, l_Index) then
   begin
    l_T := TmsmModelLoadingThread.Create(aWordToLoad, aMethodName);
    try
     Add(l_T);
     l_T.Suspended := false;
    finally
     FreeAndNil(l_T);
    end;//try..finally
   end;//not FindData(aWordToLoad, l_Index)
  finally
   Unlock;
  end;//try..finally
 end;//with TmsmModelLoadingThreads.Instance
//#UC END# *57C6887501FC_57C3E95F0252_impl*
end;//TmsmModelLoadingThread.CreateManaged

procedure TmsmModelLoadingThread.DoExecute;
 {* основная процедура нити. Для перекрытия в потомках }
//#UC START# *4911B69E037D_57C3E95F0252_var*
//#UC END# *4911B69E037D_57C3E95F0252_var*
begin
//#UC START# *4911B69E037D_57C3E95F0252_impl*
 TmsmModelElementMethodCaller.RawCall(WordToLoad, f_MethodName);
//#UC END# *4911B69E037D_57C3E95F0252_impl*
end;//TmsmModelLoadingThread.DoExecute

procedure TmsmModelLoadingThread.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57C3E95F0252_var*
//#UC END# *479731C50290_57C3E95F0252_var*
begin
//#UC START# *479731C50290_57C3E95F0252_impl*
 inherited;
//#UC END# *479731C50290_57C3E95F0252_impl*
end;//TmsmModelLoadingThread.Cleanup

procedure TmsmModelLoadingThread.Terminate;
//#UC START# *57C43912010E_57C3E95F0252_var*
//#UC END# *57C43912010E_57C3E95F0252_var*
begin
//#UC START# *57C43912010E_57C3E95F0252_impl*
 TmsmModelElementMethodCaller.CallProc('TerminateLoadInner');
 inherited;
//#UC END# *57C43912010E_57C3E95F0252_impl*
end;//TmsmModelLoadingThread.Terminate

procedure TmsmModelLoadingThread.ThreadTerminated;
//#UC START# *57C69B910319_57C3E95F0252_var*
//#UC END# *57C69B910319_57C3E95F0252_var*
begin
//#UC START# *57C69B910319_57C3E95F0252_impl*
 inherited;
 if TmsmModelLoadingThreads.Exists then
  TmsmModelLoadingThreads.Instance.Remove(Self);
//#UC END# *57C69B910319_57C3E95F0252_impl*
end;//TmsmModelLoadingThread.ThreadTerminated

procedure TmsmModelLoadingThread.ClearFields;
begin
 f_MethodName := '';
 inherited;
end;//TmsmModelLoadingThread.ClearFields

//#UC START# *57C3E95F0252impl*
//#UC END# *57C3E95F0252impl*
{$IfEnd} // Defined(seThreadSafe)

end.
