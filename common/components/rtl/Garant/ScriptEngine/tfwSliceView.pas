unit tfwSliceView;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwSliceView.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwArrayView
 , tfwScriptingInterfaces
 , kwCompiledWordWorker
 , tfwValueList
;

type
 TtfwSliceLambda = class(TkwCompiledWordWorker)
  private
   f_Count: Integer;
   f_Values: TtfwValueList;
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(aCount: Integer;
    aWord: TtfwWord;
    const aCtx: TtfwContext); reintroduce;
 end;//TtfwSliceLambda

 TtfwSliceView = class(TtfwArrayView)
  private
   f_Count: Integer;
  protected
   function GetItemsCountInSlice: Integer; override;
  public
   constructor Create(const anOther: ItfwValueList;
    aCount: Integer); reintroduce;
   class function Make(const anOther: ItfwValueList;
    aCount: Integer): ItfwValueList; reintroduce;
   procedure DoForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); override;
   procedure DoForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); override;
 end;//TtfwSliceView
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TtfwSliceLambda.Create(aCount: Integer;
 aWord: TtfwWord;
 const aCtx: TtfwContext);
//#UC START# *55E591790250_55E59111027A_var*
//#UC END# *55E591790250_55E59111027A_var*
begin
//#UC START# *55E591790250_55E59111027A_impl*
 inherited Create(aWord, nil, aCtx);
 f_Count := aCount;
//#UC END# *55E591790250_55E59111027A_impl*
end;//TtfwSliceLambda.Create

procedure TtfwSliceLambda.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55E59111027A_var*
var
 l_Index : Integer; 
//#UC END# *4DAEEDE10285_55E59111027A_var*
begin
//#UC START# *4DAEEDE10285_55E59111027A_impl*
 if (f_Values = nil) OR (f_Values.Count < f_Count) then
 begin
  if (f_Values = nil) then
   f_Values := TtfwValueList.Create;
  f_Values.Add(aCtx.rEngine.Pop); 
 end;//(f_Values = nil) OR (f_Values.Count < f_Count)
 if (f_Values.Count = f_Count) then
 begin
  //for l_Index := Pred(f_Values.Count) downto 0 do
  for l_Index := 0 to Pred(f_Values.Count) do
  begin
   aCtx.rEngine.Push(f_Values.Items[l_Index]);
  end;//for l_Index
  WordToWork.DoIt(aCtx);
  f_Values.Clear;
 end;//f_Values.Count = f_Count
//#UC END# *4DAEEDE10285_55E59111027A_impl*
end;//TtfwSliceLambda.DoDoIt

procedure TtfwSliceLambda.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55E59111027A_var*
//#UC END# *479731C50290_55E59111027A_var*
begin
//#UC START# *479731C50290_55E59111027A_impl*
 FreeAndNil(f_Values);
 inherited;
//#UC END# *479731C50290_55E59111027A_impl*
end;//TtfwSliceLambda.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TtfwSliceLambda.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_55E59111027A_var*
//#UC END# *47A6FEE600FC_55E59111027A_var*
begin
//#UC START# *47A6FEE600FC_55E59111027A_impl*
 Result := true;
//#UC END# *47A6FEE600FC_55E59111027A_impl*
end;//TtfwSliceLambda.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

constructor TtfwSliceView.Create(const anOther: ItfwValueList;
 aCount: Integer);
//#UC START# *55E590D1008A_55E5904F02A5_var*
//#UC END# *55E590D1008A_55E5904F02A5_var*
begin
//#UC START# *55E590D1008A_55E5904F02A5_impl*
 inherited Create(anOther);
 f_Count := aCount;
//#UC END# *55E590D1008A_55E5904F02A5_impl*
end;//TtfwSliceView.Create

class function TtfwSliceView.Make(const anOther: ItfwValueList;
 aCount: Integer): ItfwValueList;
var
 l_Inst : TtfwSliceView;
begin
 l_Inst := Create(anOther, aCount);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwSliceView.Make

procedure TtfwSliceView.DoForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666E80335_55E5904F02A5_var*
var
 l_Lambda : TtfwSliceLambda;
//#UC END# *52E666E80335_55E5904F02A5_var*
begin
//#UC START# *52E666E80335_55E5904F02A5_impl*
 l_Lambda := TtfwSliceLambda.Create(f_Count, TtfwWord(aLambda), aCtx);
 try
  inherited DoForEach(l_Lambda, aCtx);
 finally
  FreeAndNil(l_Lambda);
 end;//try..finally
//#UC END# *52E666E80335_55E5904F02A5_impl*
end;//TtfwSliceView.DoForEach

procedure TtfwSliceView.DoForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666F6036E_55E5904F02A5_var*
var
 l_Lambda : TtfwSliceLambda;
//#UC END# *52E666F6036E_55E5904F02A5_var*
begin
//#UC START# *52E666F6036E_55E5904F02A5_impl*
 l_Lambda := TtfwSliceLambda.Create(f_Count, TtfwWord(aLambda), aCtx);
 try
  inherited DoForEachBack(l_Lambda, aCtx);
 finally
  FreeAndNil(l_Lambda);
 end;//try..finally
//#UC END# *52E666F6036E_55E5904F02A5_impl*
end;//TtfwSliceView.DoForEachBack

function TtfwSliceView.GetItemsCountInSlice: Integer;
//#UC START# *55E84F5F00ED_55E5904F02A5_var*
//#UC END# *55E84F5F00ED_55E5904F02A5_var*
begin
//#UC START# *55E84F5F00ED_55E5904F02A5_impl*
 Result := f_Count;
//#UC END# *55E84F5F00ED_55E5904F02A5_impl*
end;//TtfwSliceView.GetItemsCountInSlice

initialization
 TtfwSliceLambda.RegisterClass;
 {* Регистрация TtfwSliceLambda }
{$IfEnd} // NOT Defined(NoScripts)

end.
