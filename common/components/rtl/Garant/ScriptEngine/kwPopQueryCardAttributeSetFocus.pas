unit kwPopQueryCardAttributeSetFocus;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetFocus.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_QueryCard_Attribute_SetFocus" MUID: (4F69A0DF02E0)
// Имя типа: "TkwPopQueryCardAttributeSetFocus"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
   procedure DoModelImpl(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor);
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
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4F69A0DF02E0impl_uses*
 //#UC END# *4F69A0DF02E0impl_uses*
;

procedure TkwPopQueryCardAttributeSetFocus.DoModelImpl(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
var l_Name: Il3CString;
var l_Op: InevOp;

 procedure CallIterator;

  function DoIt(const anItem: IevReq): Boolean;
   {* Подитеративная функция для вызова DoReq из CallIterator }
  //#UC START# *68801C8A78FF__var*
  var
   l_F : IevEditorControlField;
  //#UC END# *68801C8A78FF__var*
  begin
  //#UC START# *68801C8A78FF__impl*
   if l3Same(l_Name, anItem.ReqName) then
   begin
    Result := false;
    l_F := anItem.FirstField;
    l_F.SetFocus(true);
    Exit;
   end//l3Same(l_Name, anItem.ReqName)
   else
    Result := true;
  //#UC END# *68801C8A78FF__impl*
  end;//DoIt

 //#UC START# *4F69A17402A1__var*
 //#UC END# *4F69A17402A1__var*
 begin
  //#UC START# *4F69A17402A1iter*
  TevReqIterator.Make(aCard).
  //#UC END# *4F69A17402A1iter*
  DoReqF(L2IevReqIteratorDoReqAction(@DoIt));
 end;//CallIterator

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
