unit tfwIteratorFromFunctor;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwIteratorFromFunctor.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwIteratableParent
 , tfwScriptingInterfaces
 , tfwArray
;

type
 TtfwArrayCollector = class(TtfwWord)
  private
   f_Array: TtfwArray;
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(anArray: TtfwArray); reintroduce;
 end;//TtfwArrayCollector

 TtfwIteratorFromFunctor = class(TtfwIteratableParent, ItfwValueList)
  private
   f_Functor: TtfwWord;
  protected
   procedure SetItem(anIndex: Integer;
    const aValue: TtfwStackValue);
   function ItemsCountInSlice: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFunctor: TtfwWord); reintroduce;
   class function Make(aFunctor: TtfwWord): ItfwValueList; reintroduce;
   procedure ForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
 end;//TtfwIteratorFromFunctor
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TtfwArrayCollector.Create(anArray: TtfwArray);
//#UC START# *52EB8CDA0033_52EB8C930076_var*
//#UC END# *52EB8CDA0033_52EB8C930076_var*
begin
//#UC START# *52EB8CDA0033_52EB8C930076_impl*
 inherited Create;
 anArray.SetRefTo(f_Array);
//#UC END# *52EB8CDA0033_52EB8C930076_impl*
end;//TtfwArrayCollector.Create

procedure TtfwArrayCollector.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52EB8C930076_var*
//#UC END# *4DAEEDE10285_52EB8C930076_var*
begin
//#UC START# *4DAEEDE10285_52EB8C930076_impl*
 f_Array.Add(aCtx.rEngine.Pop);
//#UC END# *4DAEEDE10285_52EB8C930076_impl*
end;//TtfwArrayCollector.DoDoIt

procedure TtfwArrayCollector.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52EB8C930076_var*
//#UC END# *479731C50290_52EB8C930076_var*
begin
//#UC START# *479731C50290_52EB8C930076_impl*
 FreeAndNil(f_Array);
 inherited;
//#UC END# *479731C50290_52EB8C930076_impl*
end;//TtfwArrayCollector.Cleanup

constructor TtfwIteratorFromFunctor.Create(aFunctor: TtfwWord);
//#UC START# *52EB870B01E6_52EB863801C3_var*
//#UC END# *52EB870B01E6_52EB863801C3_var*
begin
//#UC START# *52EB870B01E6_52EB863801C3_impl*
 inherited Create;
 aFunctor.SetRefTo(f_Functor);
//#UC END# *52EB870B01E6_52EB863801C3_impl*
end;//TtfwIteratorFromFunctor.Create

class function TtfwIteratorFromFunctor.Make(aFunctor: TtfwWord): ItfwValueList;
var
 l_Inst : TtfwIteratorFromFunctor;
begin
 l_Inst := Create(aFunctor);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwIteratorFromFunctor.Make

procedure TtfwIteratorFromFunctor.ForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_52EB863801C3_var*
//#UC END# *52E23B7A00EC_52EB863801C3_var*
begin
//#UC START# *52E23B7A00EC_52EB863801C3_impl*
 aCtx.rEngine.PushObj(aLambda);
 f_Functor.DoIt(aCtx);
//#UC END# *52E23B7A00EC_52EB863801C3_impl*
end;//TtfwIteratorFromFunctor.ForEach

procedure TtfwIteratorFromFunctor.ForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_52EB863801C3_var*
var
 l_Array : TtfwArray;
 l_Collector : TtfwArrayCollector;
//#UC END# *52E23BB102FA_52EB863801C3_var*
begin
//#UC START# *52E23BB102FA_52EB863801C3_impl*
 l_Array := TtfwArray.Create;
 try
  l_Collector := TtfwArrayCollector.Create(l_Array);
  try
   Self.ForEach(l_Collector, aCtx);
   l_Array.ForEachBack(aLambda, aCtx);
  finally
   FreeAndNil(l_Collector);
  end;//try..finally
 finally
  FreeAndNil(l_Array);
 end;//try..finally
//#UC END# *52E23BB102FA_52EB863801C3_impl*
end;//TtfwIteratorFromFunctor.ForEachBack

procedure TtfwIteratorFromFunctor.SetItem(anIndex: Integer;
 const aValue: TtfwStackValue);
//#UC START# *55CDF40C03D4_52EB863801C3_var*
//#UC END# *55CDF40C03D4_52EB863801C3_var*
begin
//#UC START# *55CDF40C03D4_52EB863801C3_impl*
 EtfwCheck.Fail('Массив неизменяемый');
//#UC END# *55CDF40C03D4_52EB863801C3_impl*
end;//TtfwIteratorFromFunctor.SetItem

function TtfwIteratorFromFunctor.ItemsCountInSlice: Integer;
//#UC START# *55E849210175_52EB863801C3_var*
//#UC END# *55E849210175_52EB863801C3_var*
begin
//#UC START# *55E849210175_52EB863801C3_impl*
 Result := 1;
//#UC END# *55E849210175_52EB863801C3_impl*
end;//TtfwIteratorFromFunctor.ItemsCountInSlice

procedure TtfwIteratorFromFunctor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52EB863801C3_var*
//#UC END# *479731C50290_52EB863801C3_var*
begin
//#UC START# *479731C50290_52EB863801C3_impl*
 FreeAndNil(f_Functor);
 inherited;
//#UC END# *479731C50290_52EB863801C3_impl*
end;//TtfwIteratorFromFunctor.Cleanup

initialization
 TtfwArrayCollector.RegisterClass;
 {* Регистрация TtfwArrayCollector }
{$IfEnd} // NOT Defined(NoScripts)

end.
