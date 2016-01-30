unit kwPopQueryCardAttributeIsLogicOperationEnabled;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeIsLogicOperationEnabled.pas"
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
 TkwPopQueryCardAttributeIsLogicOperationEnabled = {final} class(TkwQueryCardFromStackWord)
  private
   procedure DoModelImpl;
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardAttributeIsLogicOperationEnabled
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

procedure TkwPopQueryCardAttributeIsLogicOperationEnabled.DoModelImpl;
//#UC START# *50F011CD0374_50EFDD9B0123_var*
//#UC END# *50F011CD0374_50EFDD9B0123_var*
begin
//#UC START# *50F011CD0374_50EFDD9B0123_impl*
 l_Name := aCtx.rEngine.PopString;
 l_Op := aCard.StartOp;
 try
  CallIterator;
 finally
  l_Op := nil;
 end;//try..finally
 aCtx.rEngine.PushBool(l_IsEnabled);
//#UC END# *50F011CD0374_50EFDD9B0123_impl*
end;//TkwPopQueryCardAttributeIsLogicOperationEnabled.DoModelImpl

procedure TkwPopQueryCardAttributeIsLogicOperationEnabled.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_50EFDD9B0123_var*
//#UC END# *4E808E8B01BB_50EFDD9B0123_var*
begin
//#UC START# *4E808E8B01BB_50EFDD9B0123_impl*
 DoModelImpl(aCtx, aCard);
//#UC END# *4E808E8B01BB_50EFDD9B0123_impl*
end;//TkwPopQueryCardAttributeIsLogicOperationEnabled.DoCard

class function TkwPopQueryCardAttributeIsLogicOperationEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:Attribute:IsLogicOperationEnabled';
end;//TkwPopQueryCardAttributeIsLogicOperationEnabled.GetWordNameForRegister

initialization
 TkwPopQueryCardAttributeIsLogicOperationEnabled.RegisterInEngine;
 {* Регистрация pop_QueryCard_Attribute_IsLogicOperationEnabled }
{$IfEnd} // NOT Defined(NoScripts)

end.
