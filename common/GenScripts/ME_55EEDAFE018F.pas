unit kwCompiledWordPrimPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordPrimPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwCompiledWordPrimPrim" MUID: (55EEDAFE018F)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSourcePointWord
 , tfwScriptingInterfaces
 , tfwKeyWordPrim
;

type
 TkwCompiledWordPrimPrim = class(TkwSourcePointWord)
  private
   f_WordProducer: TtfwWord;
    {* Слово, которое породило данное при компиляции }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function pm_GetWordProducer: TtfwWord; override;
   procedure pm_SetWordProducer(aValue: TtfwWord); override;
  public
   constructor Create(aWordProducer: TtfwWord;
    const aCtx: TtfwContext;
    aKey: TtfwKeyWordPrim); reintroduce;
   function GetEndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   function AcceptMedianBracket(aBracket: TtfwWord;
    var aCtx: TtfwContext): Boolean; override;
 end;//TkwCompiledWordPrimPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

constructor TkwCompiledWordPrimPrim.Create(aWordProducer: TtfwWord;
 const aCtx: TtfwContext;
 aKey: TtfwKeyWordPrim);
//#UC START# *55EEDB4E00B3_55EEDAFE018F_var*
//#UC END# *55EEDB4E00B3_55EEDAFE018F_var*
begin
//#UC START# *55EEDB4E00B3_55EEDAFE018F_impl*
 Self.Key := aKey;
 inherited Create(aCtx);
 WordProducer := aWordProducer;
//#UC END# *55EEDB4E00B3_55EEDAFE018F_impl*
end;//TkwCompiledWordPrimPrim.Create

procedure TkwCompiledWordPrimPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55EEDAFE018F_var*
//#UC END# *479731C50290_55EEDAFE018F_var*
begin
//#UC START# *479731C50290_55EEDAFE018F_impl*
 f_WordProducer := nil;
 inherited;
//#UC END# *479731C50290_55EEDAFE018F_impl*
end;//TkwCompiledWordPrimPrim.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TkwCompiledWordPrimPrim.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_55EEDAFE018F_var*
//#UC END# *47A6FEE600FC_55EEDAFE018F_var*
begin
//#UC START# *47A6FEE600FC_55EEDAFE018F_impl*
 Result := true;
//#UC END# *47A6FEE600FC_55EEDAFE018F_impl*
end;//TkwCompiledWordPrimPrim.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TkwCompiledWordPrimPrim.pm_GetWordProducer: TtfwWord;
//#UC START# *4F43C9A10139_55EEDAFE018Fget_var*
//#UC END# *4F43C9A10139_55EEDAFE018Fget_var*
begin
//#UC START# *4F43C9A10139_55EEDAFE018Fget_impl*
 Result := f_WordProducer;
//#UC END# *4F43C9A10139_55EEDAFE018Fget_impl*
end;//TkwCompiledWordPrimPrim.pm_GetWordProducer

procedure TkwCompiledWordPrimPrim.pm_SetWordProducer(aValue: TtfwWord);
//#UC START# *4F43C9A10139_55EEDAFE018Fset_var*
//#UC END# *4F43C9A10139_55EEDAFE018Fset_var*
begin
//#UC START# *4F43C9A10139_55EEDAFE018Fset_impl*
 Assert(aValue <> Self);
 f_WordProducer := aValue;
//#UC END# *4F43C9A10139_55EEDAFE018Fset_impl*
end;//TkwCompiledWordPrimPrim.pm_SetWordProducer

function TkwCompiledWordPrimPrim.GetEndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *52D6B62E001B_55EEDAFE018F_var*
//#UC END# *52D6B62E001B_55EEDAFE018F_var*
begin
//#UC START# *52D6B62E001B_55EEDAFE018F_impl*
 Result := Self.WordProducer.GetEndBracket(aContext, aSilent);
//#UC END# *52D6B62E001B_55EEDAFE018F_impl*
end;//TkwCompiledWordPrimPrim.GetEndBracket

function TkwCompiledWordPrimPrim.AcceptMedianBracket(aBracket: TtfwWord;
 var aCtx: TtfwContext): Boolean;
//#UC START# *52D7DC84019E_55EEDAFE018F_var*
//#UC END# *52D7DC84019E_55EEDAFE018F_var*
begin
//#UC START# *52D7DC84019E_55EEDAFE018F_impl*
 Result := Self.WordProducer.AcceptMedianBracket(aBracket, aCtx);
//#UC END# *52D7DC84019E_55EEDAFE018F_impl*
end;//TkwCompiledWordPrimPrim.AcceptMedianBracket

initialization
 TkwCompiledWordPrimPrim.RegisterClass;
 {* Регистрация TkwCompiledWordPrimPrim }
{$IfEnd} // NOT Defined(NoScripts)

end.
