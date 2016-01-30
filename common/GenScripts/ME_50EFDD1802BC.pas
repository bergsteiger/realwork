unit kwPopQueryCardAttributeGetLogicOperation;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetLogicOperation.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , l3Interfaces
 , nevBase
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evQueryCardInt
;

type
 TkwPopQueryCardAttributeGetLogicOperation = {final} class(TkwQueryCardFromStackWord)
  private
   procedure DoModelImpl;
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardAttributeGetLogicOperation
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

procedure TkwPopQueryCardAttributeGetLogicOperation.DoModelImpl;
//#UC START# *50EFE12701AD_50EFDD1802BC_var*
//#UC END# *50EFE12701AD_50EFDD1802BC_var*
begin
//#UC START# *50EFE12701AD_50EFDD1802BC_impl*
 l_Name := aCtx.rEngine.PopString;
 l_Op := aCard.StartOp;
 try
  CallIterator;
 finally
  l_Op := nil;
 end;//try..finally
 aCtx.rEngine.PushInt(l_LogicOp);
//#UC END# *50EFE12701AD_50EFDD1802BC_impl*
end;//TkwPopQueryCardAttributeGetLogicOperation.DoModelImpl

procedure TkwPopQueryCardAttributeGetLogicOperation.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_50EFDD1802BC_var*
//#UC END# *4E808E8B01BB_50EFDD1802BC_var*
begin
//#UC START# *4E808E8B01BB_50EFDD1802BC_impl*
 DoModelImpl(aCtx, aCard);
//#UC END# *4E808E8B01BB_50EFDD1802BC_impl*
end;//TkwPopQueryCardAttributeGetLogicOperation.DoCard

class function TkwPopQueryCardAttributeGetLogicOperation.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:Attribute:GetLogicOperation';
end;//TkwPopQueryCardAttributeGetLogicOperation.GetWordNameForRegister

initialization
 TkwPopQueryCardAttributeGetLogicOperation.RegisterInEngine;
 {* Регистрация pop_QueryCard_Attribute_GetLogicOperation }
{$IfEnd} // NOT Defined(NoScripts)

end.
