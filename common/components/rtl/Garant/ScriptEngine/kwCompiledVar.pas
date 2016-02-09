unit kwCompiledVar;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledVar.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWordPrim
 , tfwScriptingInterfaces
 , tfwKeyWordPrim
 , tfwTypeInfo
;

type
 _kwCompiledVar_Parent_ = TkwCompiledWordPrim;
 {$Include kwCompiledVar.imp.pas}
 TkwCompiledVar = class(_kwCompiledVar_)
  public
   constructor Create(aWordProducer: TtfwWord;
    aPrevFinder: TtfwWord;
    aTypeInfo: TtfwWordInfo;
    const aCtx: TtfwContext;
    aKey: TtfwKeyWordPrim); override;
   function GetEndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   function AcceptMedianBracket(aBracket: TtfwWord;
    var aCtx: TtfwContext): Boolean; override;
 end;//TkwCompiledVar
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwArray
 , l3Base
 , TypInfo
 , l3String
;

{$Include kwCompiledVar.imp.pas}

constructor TkwCompiledVar.Create(aWordProducer: TtfwWord;
 aPrevFinder: TtfwWord;
 aTypeInfo: TtfwWordInfo;
 const aCtx: TtfwContext;
 aKey: TtfwKeyWordPrim);
//#UC START# *4DC9723702F5_4DBB04B6014C_var*
//#UC END# *4DC9723702F5_4DBB04B6014C_var*
begin
//#UC START# *4DC9723702F5_4DBB04B6014C_impl*
 inherited;
//#UC END# *4DC9723702F5_4DBB04B6014C_impl*
end;//TkwCompiledVar.Create

function TkwCompiledVar.GetEndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *52D6B62E001B_4DBB04B6014C_var*
//#UC END# *52D6B62E001B_4DBB04B6014C_var*
begin
//#UC START# *52D6B62E001B_4DBB04B6014C_impl*
 Result := nil;
//#UC END# *52D6B62E001B_4DBB04B6014C_impl*
end;//TkwCompiledVar.GetEndBracket

function TkwCompiledVar.AcceptMedianBracket(aBracket: TtfwWord;
 var aCtx: TtfwContext): Boolean;
//#UC START# *52D7DC84019E_4DBB04B6014C_var*
//#UC END# *52D7DC84019E_4DBB04B6014C_var*
begin
//#UC START# *52D7DC84019E_4DBB04B6014C_impl*
 Result := false;
//#UC END# *52D7DC84019E_4DBB04B6014C_impl*
end;//TkwCompiledVar.AcceptMedianBracket

initialization
 TkwCompiledVar.RegisterClass;
 {* Регистрация TkwCompiledVar }
{$IfEnd} // NOT Defined(NoScripts)

end.
