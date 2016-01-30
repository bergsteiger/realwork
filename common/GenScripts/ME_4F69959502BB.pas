unit kwPopQueryCardAttributeSetCollapsed;
 {* Управляет свойством Collapsed той ГРУППЫ к которой принадлежит данный атрибут

Пример:
[code]
'AT_TEXT_NAME' true Search:SetAttributeCollapsed
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetCollapsed.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , nevBase
 , l3Interfaces
 , tfwScriptingInterfaces
 , evQueryCardEditor
 , evQueryCardInt
;

type
 TkwPopQueryCardAttributeSetCollapsed = {final} class(TkwQueryCardFromStackWord)
  {* Управляет свойством Collapsed той ГРУППЫ к которой принадлежит данный атрибут

Пример:
[code]
'AT_TEXT_NAME' true Search:SetAttributeCollapsed
[code] }
  private
   procedure DoModelImpl;
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardAttributeSetCollapsed
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , l3Base
 , evReqIterator
;

procedure TkwPopQueryCardAttributeSetCollapsed.DoModelImpl;
//#UC START# *4F6995F7028A_4F69959502BB_var*
//#UC END# *4F6995F7028A_4F69959502BB_var*
begin
//#UC START# *4F6995F7028A_4F69959502BB_impl*
 l_Value := aCtx.rEngine.PopBool;
 l_Name := aCtx.rEngine.PopString;
 l_Op := aCard.StartOp;
 try
  CallIterator;
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *4F6995F7028A_4F69959502BB_impl*
end;//TkwPopQueryCardAttributeSetCollapsed.DoModelImpl

procedure TkwPopQueryCardAttributeSetCollapsed.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_4F69959502BB_var*
//#UC END# *4E808E8B01BB_4F69959502BB_var*
begin
//#UC START# *4E808E8B01BB_4F69959502BB_impl*
 DoModelImpl(aCtx, aCard);
//#UC END# *4E808E8B01BB_4F69959502BB_impl*
end;//TkwPopQueryCardAttributeSetCollapsed.DoCard

class function TkwPopQueryCardAttributeSetCollapsed.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:Attribute:SetCollapsed';
end;//TkwPopQueryCardAttributeSetCollapsed.GetWordNameForRegister

initialization
 TkwPopQueryCardAttributeSetCollapsed.RegisterInEngine;
 {* Регистрация pop_QueryCard_Attribute_SetCollapsed }
{$IfEnd} // NOT Defined(NoScripts)

end.
