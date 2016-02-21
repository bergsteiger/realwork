unit tfwLambdedArrayView;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwLambdedArrayView.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwArrayView
 , tfwScriptingInterfaces
 , kwCompiledWordWorker
;

type
 RtfwTwoLambdas = class of TtfwTwoLambdas;

 TtfwTwoLambdas = {abstract} class(TkwCompiledWordWorker)
  private
   f_ItemsCountInSlice: Integer;
    {* Поле для свойства ItemsCountInSlice }
  protected
   f_Lambda: TtfwWord;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(aLambda: TtfwWord;
    aItemsCountInSlice: Integer;
    aWord: TtfwWord;
    const aCtx: TtfwContext); reintroduce;
  protected
   property ItemsCountInSlice: Integer
    read f_ItemsCountInSlice;
 end;//TtfwTwoLambdas

 TtfwLambdedArrayView = class(TtfwArrayView)
  protected
   f_Lambda: TtfwWord;
  protected
   function TwoLabdasClass: RtfwTwoLambdas; virtual; abstract;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const anOther: ItfwValueList;
    aLambda: TtfwWord); reintroduce;
   class function Make(const anOther: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList; reintroduce;
   procedure DoForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); override;
   procedure DoForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext); override;
 end;//TtfwLambdedArrayView
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
;

constructor TtfwTwoLambdas.Create(aLambda: TtfwWord;
 aItemsCountInSlice: Integer;
 aWord: TtfwWord;
 const aCtx: TtfwContext);
//#UC START# *52EA8B2403DD_52EA8AD102B0_var*
//#UC END# *52EA8B2403DD_52EA8AD102B0_var*
begin
//#UC START# *52EA8B2403DD_52EA8AD102B0_impl*
 inherited Create(aWord, nil, aCtx);
 aLambda.SetRefTo(f_Lambda);
 f_ItemsCountInSlice := aItemsCountInSlice;
//#UC END# *52EA8B2403DD_52EA8AD102B0_impl*
end;//TtfwTwoLambdas.Create

procedure TtfwTwoLambdas.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52EA8AD102B0_var*
//#UC END# *479731C50290_52EA8AD102B0_var*
begin
//#UC START# *479731C50290_52EA8AD102B0_impl*
 FreeAndNil(f_Lambda);
 inherited;
//#UC END# *479731C50290_52EA8AD102B0_impl*
end;//TtfwTwoLambdas.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TtfwTwoLambdas.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_52EA8AD102B0_var*
//#UC END# *47A6FEE600FC_52EA8AD102B0_var*
begin
//#UC START# *47A6FEE600FC_52EA8AD102B0_impl*
 Result := true;
//#UC END# *47A6FEE600FC_52EA8AD102B0_impl*
end;//TtfwTwoLambdas.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

constructor TtfwLambdedArrayView.Create(const anOther: ItfwValueList;
 aLambda: TtfwWord);
//#UC START# *52E6671B033F_52E666BC0270_var*
//#UC END# *52E6671B033F_52E666BC0270_var*
begin
//#UC START# *52E6671B033F_52E666BC0270_impl*
 inherited Create(anOther);
 aLambda.SetRefTo(f_Lambda);
//#UC END# *52E6671B033F_52E666BC0270_impl*
end;//TtfwLambdedArrayView.Create

class function TtfwLambdedArrayView.Make(const anOther: ItfwValueList;
 aLambda: TtfwWord): ItfwValueList;
var
 l_Inst : TtfwLambdedArrayView;
begin
 l_Inst := Create(anOther, aLambda);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwLambdedArrayView.Make

procedure TtfwLambdedArrayView.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52E666BC0270_var*
//#UC END# *479731C50290_52E666BC0270_var*
begin
//#UC START# *479731C50290_52E666BC0270_impl*
 FreeAndNil(f_Lambda);
 inherited;
//#UC END# *479731C50290_52E666BC0270_impl*
end;//TtfwLambdedArrayView.Cleanup

procedure TtfwLambdedArrayView.DoForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666E80335_52E666BC0270_var*
var
 l_Lambda : TtfwWord;
//#UC END# *52E666E80335_52E666BC0270_var*
begin
//#UC START# *52E666E80335_52E666BC0270_impl*
 l_Lambda := TwoLabdasClass.Create(f_Lambda, f_Other.ItemsCountInSlice, TtfwWord(aLambda), aCtx);
 try
  inherited DoForEach(l_Lambda, aCtx);
 finally
  FreeAndNil(l_Lambda);
 end;//try..finally
//#UC END# *52E666E80335_52E666BC0270_impl*
end;//TtfwLambdedArrayView.DoForEach

procedure TtfwLambdedArrayView.DoForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E666F6036E_52E666BC0270_var*
var
 l_Lambda : TtfwWord;
//#UC END# *52E666F6036E_52E666BC0270_var*
begin
//#UC START# *52E666F6036E_52E666BC0270_impl*
 l_Lambda := TwoLabdasClass.Create(f_Lambda, f_Other.ItemsCountInSlice, TtfwWord(aLambda), aCtx);
 try
  inherited DoForEachBack(l_Lambda, aCtx);
 finally
  FreeAndNil(l_Lambda);
 end;//try..finally
//#UC END# *52E666F6036E_52E666BC0270_impl*
end;//TtfwLambdedArrayView.DoForEachBack

initialization
 TtfwTwoLambdas.RegisterClass;
 {* Регистрация TtfwTwoLambdas }
{$IfEnd} // NOT Defined(NoScripts)

end.
