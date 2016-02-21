unit kwPopQueryCardAttributeGetLogicOperation;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeGetLogicOperation.pas"
// Стереотип: "ScriptKeyword"

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
 TkwPopQueryCardAttributeGetLogicOperation = {final} class(TkwQueryCardFromStackWord)
  private
   procedure DoModelImpl(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor);
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
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopQueryCardAttributeGetLogicOperation.DoModelImpl(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
var l_Name: Il3CString;
var l_Op: InevOp;
var l_LogicOp: Integer;

 procedure CallIterator;

  function DoIt(const anItem: IevReq): Boolean;
   {* Подитеративная функция для вызова L2IevReqIteratorDoReqAction из CallIterator }
  //#UC START# *2B70B2B2422D__var*
  var
   l_F : IevEditorControlField;
  //#UC END# *2B70B2B2422D__var*
  begin
  //#UC START# *2B70B2B2422D__impl*
   if l3Same(l_Name, anItem.ReqName) then
   begin
    Result := false;
    l_F := anItem.FirstField;
    l_LogicOp := (l_F As IevEditorFieldWithTree).LogicalState; 
    Exit;
   end else
    Result := true;
  //#UC END# *2B70B2B2422D__impl*
  end;//DoIt

 //#UC START# *50EFE2330224__var*
 //#UC END# *50EFE2330224__var*
 begin
  //#UC START# *50EFE2330224iter*
  TevReqIterator.Make(aCard).
  //#UC END# *50EFE2330224iter*
  DoReqF(L2IevReqIteratorDoReqAction(@DoIt));
 end;//CallIterator

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
