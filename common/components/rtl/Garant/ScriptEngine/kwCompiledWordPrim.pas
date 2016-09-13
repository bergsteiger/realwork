unit kwCompiledWordPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwCompiledWordPrim" MUID: (52D3C5F90029)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWordPrimPrim
 , tfwScriptingInterfaces
 , tfwWordRefList
 , tfwKeyWordPrim
;

type
 RkwCompiledWordPrim = class of TkwCompiledWordPrim;

 TkwCompiledWordPrim = {abstract} class(TkwCompiledWordPrimPrim)
  protected
   f_PrevFinder: TtfwWord;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function pm_GetParentWord: TtfwWord; override;
  public
   constructor Create(aWordProducer: TtfwWord;
    aPrevFinder: TtfwWord;
    aTypeInfo: TtfwWordInfo;
    const aCtx: TtfwContext;
    aKey: TtfwKeyWordPrim); reintroduce; virtual;
   function GetCode(const aCtx: TtfwContext): TtfwWordRefList; virtual;
   function GetCompiler(const aCtx: TtfwContext): TtfwWord; override;
   function GetInParam(const aCtx: TtfwContext;
    anIndex: Integer): TtfwWord; override;
   procedure SetParent(aParent: TtfwWord); override;
 end;//TkwCompiledWordPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *52D3C5F90029impl_uses*
 //#UC END# *52D3C5F90029impl_uses*
;

constructor TkwCompiledWordPrim.Create(aWordProducer: TtfwWord;
 aPrevFinder: TtfwWord;
 aTypeInfo: TtfwWordInfo;
 const aCtx: TtfwContext;
 aKey: TtfwKeyWordPrim);
//#UC START# *4DC9723702F5_52D3C5F90029_var*
//#UC END# *4DC9723702F5_52D3C5F90029_var*
begin
//#UC START# *4DC9723702F5_52D3C5F90029_impl*
 Self.Key := aKey;
 CompilerAssert(aPrevFinder <> nil, 'Не задан aPrevFinder', aCtx);
 inherited Create(aWordProducer, aCtx, aKey);
 f_PrevFinder := Pointer(aPrevFinder);
 //WordProducer := aWordProducer;
 SetResultTypeInfo(aTypeInfo, aCtx);
 CompilerAssert(f_PrevFinder <> nil, 'Не передано родительское слово', aCtx);
//#UC END# *4DC9723702F5_52D3C5F90029_impl*
end;//TkwCompiledWordPrim.Create

function TkwCompiledWordPrim.GetCode(const aCtx: TtfwContext): TtfwWordRefList;
//#UC START# *52D41C7F027B_52D3C5F90029_var*
//#UC END# *52D41C7F027B_52D3C5F90029_var*
begin
//#UC START# *52D41C7F027B_52D3C5F90029_impl*
 CompilerAssert(false, 'Слово не имеет скомпилированного кода', aCtx);
 Result := nil;
//#UC END# *52D41C7F027B_52D3C5F90029_impl*
end;//TkwCompiledWordPrim.GetCode

procedure TkwCompiledWordPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52D3C5F90029_var*
//#UC END# *479731C50290_52D3C5F90029_var*
begin
//#UC START# *479731C50290_52D3C5F90029_impl*
 f_PrevFinder := nil;
 //f_WordProducer := nil;
 inherited;
//#UC END# *479731C50290_52D3C5F90029_impl*
end;//TkwCompiledWordPrim.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TkwCompiledWordPrim.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_52D3C5F90029_var*
//#UC END# *47A6FEE600FC_52D3C5F90029_var*
begin
//#UC START# *47A6FEE600FC_52D3C5F90029_impl*
 Result := true;
//#UC END# *47A6FEE600FC_52D3C5F90029_impl*
end;//TkwCompiledWordPrim.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TkwCompiledWordPrim.pm_GetParentWord: TtfwWord;
//#UC START# *52CFCF4B02C6_52D3C5F90029get_var*
//#UC END# *52CFCF4B02C6_52D3C5F90029get_var*
begin
//#UC START# *52CFCF4B02C6_52D3C5F90029get_impl*
 if (f_PrevFinder <> nil) then
  Result := f_PrevFinder
 else
  Result := nil; 
//#UC END# *52CFCF4B02C6_52D3C5F90029get_impl*
end;//TkwCompiledWordPrim.pm_GetParentWord

function TkwCompiledWordPrim.GetCompiler(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52D523A40118_52D3C5F90029_var*
//#UC END# *52D523A40118_52D3C5F90029_var*
begin
//#UC START# *52D523A40118_52D3C5F90029_impl*
 if (f_PrevFinder = nil) then
  Result := nil
 else
  Result := f_PrevFinder;
//#UC END# *52D523A40118_52D3C5F90029_impl*
end;//TkwCompiledWordPrim.GetCompiler

function TkwCompiledWordPrim.GetInParam(const aCtx: TtfwContext;
 anIndex: Integer): TtfwWord;
//#UC START# *52D5425A037F_52D3C5F90029_var*
//#UC END# *52D5425A037F_52D3C5F90029_var*
begin
//#UC START# *52D5425A037F_52D3C5F90029_impl*
 CompilerAssert(ParentWord <> nil, 'Слово не имеет родителя', aCtx);
 Result := (ParentWord As TkwCompiledWordPrim).GetInParam(aCtx, anIndex);
//#UC END# *52D5425A037F_52D3C5F90029_impl*
end;//TkwCompiledWordPrim.GetInParam

procedure TkwCompiledWordPrim.SetParent(aParent: TtfwWord);
//#UC START# *5673E71002C8_52D3C5F90029_var*
//#UC END# *5673E71002C8_52D3C5F90029_var*
begin
//#UC START# *5673E71002C8_52D3C5F90029_impl*
 f_PrevFinder := aParent;
//#UC END# *5673E71002C8_52D3C5F90029_impl*
end;//TkwCompiledWordPrim.SetParent

initialization
 TkwCompiledWordPrim.RegisterClass;
 {* Регистрация TkwCompiledWordPrim }
 TtfwTypeRegistrator.RegisterType(@tfw_tiClassRef);
 {* Регистрация типа RkwCompiledWordPrim }
{$IfEnd} // NOT Defined(NoScripts)

end.
