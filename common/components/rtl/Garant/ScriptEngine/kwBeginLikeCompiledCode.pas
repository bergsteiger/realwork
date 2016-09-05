unit kwBeginLikeCompiledCode;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwBeginLikeCompiledCode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwBeginLikeCompiledCode" MUID: (52DFF03B0030)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWord
 , tfwScriptingInterfaces
;

type
 TkwBeginLikeCompiledCode = class(TkwCompiledWord)
  protected
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   function GetAsCaller(const aCtx: TtfwContext): TtfwWord; override;
   function MakeRefForCompile(const aCtx: TtfwContext;
    aSNI: TtfwSuppressNextImmediate): TtfwWord; override;
 end;//TkwBeginLikeCompiledCode
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *52DFF03B0030impl_uses*
 //#UC END# *52DFF03B0030impl_uses*
;

function TkwBeginLikeCompiledCode.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_52DFF03B0030get_var*
//#UC END# *52CFC11603C8_52DFF03B0030get_var*
begin
//#UC START# *52CFC11603C8_52DFF03B0030get_impl*
 if (Code <> nil) then
  if (Code.Count = 1) then
  begin
   Result := Code.Items[0].ResultTypeInfo[aCtx];
   Exit;
  end;//Code.Count = 1
 Result := inherited pm_GetResultTypeInfo(aCtx); 
//#UC END# *52CFC11603C8_52DFF03B0030get_impl*
end;//TkwBeginLikeCompiledCode.pm_GetResultTypeInfo

function TkwBeginLikeCompiledCode.GetAsCaller(const aCtx: TtfwContext): TtfwWord;
//#UC START# *52DFE48500BB_52DFF03B0030_var*
//#UC END# *52DFE48500BB_52DFF03B0030_var*
begin
//#UC START# *52DFE48500BB_52DFF03B0030_impl*
 Result := Self;
//#UC END# *52DFE48500BB_52DFF03B0030_impl*
end;//TkwBeginLikeCompiledCode.GetAsCaller

function TkwBeginLikeCompiledCode.MakeRefForCompile(const aCtx: TtfwContext;
 aSNI: TtfwSuppressNextImmediate): TtfwWord;
//#UC START# *55CB5B8C004E_52DFF03B0030_var*
//#UC END# *55CB5B8C004E_52DFF03B0030_var*
begin
//#UC START# *55CB5B8C004E_52DFF03B0030_impl*
(* if (Code <> nil) then
  if (Code.Count = 1) then
   if (LocalDictionary = nil) OR LocalDictionary.Empty then
   begin
    Result := Code.Items[0].Use;
    Exit;
   end;//LocalDictionary = nil*)
 Result := inherited MakeRefForCompile(aCtx, aSNI);
//#UC END# *55CB5B8C004E_52DFF03B0030_impl*
end;//TkwBeginLikeCompiledCode.MakeRefForCompile

initialization
 TkwBeginLikeCompiledCode.RegisterClass;
 {* Регистрация TkwBeginLikeCompiledCode }
{$IfEnd} // NOT Defined(NoScripts)

end.
