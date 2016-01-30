unit kwPopQueryCardAttributeSetFocus;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetFocus.pas"
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
 TkwPopQueryCardAttributeSetFocus = {final} class(TkwQueryCardFromStackWord)
  private
   procedure DoModelImpl;
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardAttributeSetFocus
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

procedure TkwPopQueryCardAttributeSetFocus.DoModelImpl;
//#UC START# *4F69A12C0199_4F69A0DF02E0_var*
//#UC END# *4F69A12C0199_4F69A0DF02E0_var*
begin
//#UC START# *4F69A12C0199_4F69A0DF02E0_impl*
 l_Name := aCtx.rEngine.PopString;
 l_Op := aCard.StartOp;
 try
  CallIterator;
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *4F69A12C0199_4F69A0DF02E0_impl*
end;//TkwPopQueryCardAttributeSetFocus.DoModelImpl

procedure TkwPopQueryCardAttributeSetFocus.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_4F69A0DF02E0_var*
//#UC END# *4E808E8B01BB_4F69A0DF02E0_var*
begin
//#UC START# *4E808E8B01BB_4F69A0DF02E0_impl*
 DoModelImpl(aCtx, aCard);
//#UC END# *4E808E8B01BB_4F69A0DF02E0_impl*
end;//TkwPopQueryCardAttributeSetFocus.DoCard

class function TkwPopQueryCardAttributeSetFocus.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:Attribute:SetFocus';
end;//TkwPopQueryCardAttributeSetFocus.GetWordNameForRegister

initialization
 TkwPopQueryCardAttributeSetFocus.RegisterInEngine;
 {* Регистрация pop_QueryCard_Attribute_SetFocus }
{$IfEnd} // NOT Defined(NoScripts)

end.
