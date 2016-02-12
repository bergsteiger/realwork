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
   procedure DoModelImpl(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor);
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
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

procedure TkwPopQueryCardAttributeIsLogicOperationEnabled.DoModelImpl(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
var l_Name: Il3CString;
var l_IsEnabled: Boolean;
var l_Op: InevOp;

 procedure CallIterator;

  function DoIt(const anItem: IevReq): Boolean;
   {* Подитеративная функция для вызова L2IevReqIteratorDoReqAction из CallIterator }
  //#UC START# *1E86D84EDB95__var*
  var
   l_F : IevEditorControlField;
  //#UC END# *1E86D84EDB95__var*
  begin
  //#UC START# *1E86D84EDB95__impl*
   if l3Same(l_Name, anItem.ReqName) then
   begin
    Result := false;
    l_F := anItem.FirstField;
    l_IsEnabled := (l_F As IevEditorFieldWithTree).IsLogicalStateButtonEnabled; 
    Exit;
   end else
    Result := true;
  //#UC END# *1E86D84EDB95__impl*
  end;//DoIt

 //#UC START# *50F01237000C__var*
 //#UC END# *50F01237000C__var*
 begin
  //#UC START# *50F01237000Citer*
  TevReqIterator.Make(aCard).
  //#UC END# *50F01237000Citer*
  DoReqF(L2IevReqIteratorDoReqAction(@DoIt));
 end;//CallIterator

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
