unit kwPopQueryCardAttributeGetCollapsed;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetCollapsed.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_QueryCard_Attribute_GetCollapsed" MUID: (4FEF23900010)
// Имя типа: "TkwPopQueryCardAttributeGetCollapsed"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwQueryCardFromStackWord
 , tfwScriptingInterfaces
 , evQueryCardEditor
;

type
 TkwPopQueryCardAttributeGetCollapsed = {final} class(TkwQueryCardFromStackWord)
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardAttributeGetCollapsed
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Interfaces
 , evQueryCardInt
 , l3String
 , evReqIterator
 , nevBase
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopQueryCardAttributeGetCollapsed.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_4FEF23900010_var*
var
 l_Op: InevOp;
 l_Name: Il3CString;
 l_Value: Boolean;
 l_Found: Boolean;

 procedure CallIterator;

  function DoIt(const anItem: IevReq): Boolean;
  begin
   if l3Same(l_Name, anItem.ReqName) then
   begin
    Result := False;
    l_Found := True;
    aCtx.rEngine.PushBool(anItem.Group.Expanded);
    Exit;
   end//l3Same(l_Name, anItem.ReqName)
   else
    Result := True;
  end;//DoIt

 begin
  TevReqIterator.Make(aCard).DoReqF(L2IevReqIteratorDoReqAction(@DoIt));
 end;//CallIterator
//#UC END# *4E808E8B01BB_4FEF23900010_var*
begin
//#UC START# *4E808E8B01BB_4FEF23900010_impl*
 l_Name := aCtx.rEngine.PopString;
 l_Found := False;
 l_Op := aCard.StartOp;
 try
  CallIterator;
 finally
  l_Op := nil;
 end;//try..finally
 RunnerAssert(l_Found, 'Поле не найдено', aCtx);
//#UC END# *4E808E8B01BB_4FEF23900010_impl*
end;//TkwPopQueryCardAttributeGetCollapsed.DoCard

class function TkwPopQueryCardAttributeGetCollapsed.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:Attribute:GetCollapsed';
end;//TkwPopQueryCardAttributeGetCollapsed.GetWordNameForRegister

initialization
 TkwPopQueryCardAttributeGetCollapsed.RegisterInEngine;
 {* Регистрация pop_QueryCard_Attribute_GetCollapsed }
{$IfEnd} // NOT Defined(NoScripts)

end.
