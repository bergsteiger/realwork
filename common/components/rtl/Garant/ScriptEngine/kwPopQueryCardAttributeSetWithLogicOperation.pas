unit kwPopQueryCardAttributeSetWithLogicOperation;
 {* Добавляет атрибут с логическим значением к текущей карточке запроса.

*Пример:*
[code]
 моп::Поиск_Поиск_лекарственного_средства
 'AT_PHARM_NAME' 'Аргинин' Search:SetAttribute
 'AT_PHARM_ATC' 'A. Пищеварительный тракт и обмен веществ' Search:SetAttribute
 1 'AT_PHARM_ATC' 'B. Препараты влияющие на кроветворение и кровь' Search:SetAttributeWithLogicOperation
 Ok
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardAttributeSetWithLogicOperation.pas"
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
 TkwPopQueryCardAttributeSetWithLogicOperation = class(TkwQueryCardFromStackWord)
  {* Добавляет атрибут с логическим значением к текущей карточке запроса.

*Пример:*
[code]
 моп::Поиск_Поиск_лекарственного_средства
 'AT_PHARM_NAME' 'Аргинин' Search:SetAttribute
 'AT_PHARM_ATC' 'A. Пищеварительный тракт и обмен веществ' Search:SetAttribute
 1 'AT_PHARM_ATC' 'B. Препараты влияющие на кроветворение и кровь' Search:SetAttributeWithLogicOperation
 Ok
[code] }
  private
   procedure DoModelImpl(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor);
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardAttributeSetWithLogicOperation
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

procedure TkwPopQueryCardAttributeSetWithLogicOperation.DoModelImpl(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
var l_Name: Il3CString;
var l_Value: Il3CString;
var l_Op: InevOp;
var l_LogicOp: Integer;

 procedure CallIterator;

  function DoIt(const anItem: IevReq): Boolean;
   {* Подитеративная функция для вызова L2IevReqIteratorDoReqAction из CallIterator }
  //#UC START# *64362B31BF0F__var*
  var
   l_F : IevEditorControlField;
  //#UC END# *64362B31BF0F__var*
  begin
  //#UC START# *64362B31BF0F__impl*
   if l3Same(l_Name, anItem.ReqName) then
   begin
    Result := false;
    l_F := anItem.FirstField;
    if not l3IsNil(anItem.FirstField.Text) then
     l_F := anItem.AddField(aCard.View, true);
    l_F.Text := l_Value;
    l_F.SynchronizeSelectedValueWithText{TextChange(aCard.View, l_F.Para, l_Op)};
    (l_F As IevEditorFieldWithTree).LogicalState := l_LogicOp; 
    Exit;
   end//l3Same(l_Name, anItem.ReqName)
   else
    Result := true;
  //#UC END# *64362B31BF0F__impl*
  end;//DoIt

 //#UC START# *4E82D5F601E2__var*
 //#UC END# *4E82D5F601E2__var*
 begin
  //#UC START# *4E82D5F601E2iter*
  TevReqIterator.Make(aCard).
  //#UC END# *4E82D5F601E2iter*
  DoReqF(L2IevReqIteratorDoReqAction(@DoIt));
 end;//CallIterator

//#UC START# *4E82D58E02D1_4E82D4F60180_var*
//#UC END# *4E82D58E02D1_4E82D4F60180_var*
begin
//#UC START# *4E82D58E02D1_4E82D4F60180_impl*
 l_Value := aCtx.rEngine.PopString;
 l_Name := aCtx.rEngine.PopString;
 l_LogicOp := aCtx.rEngine.PopInt;
 l_Op := aCard.StartOp;
 try
  CallIterator;
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *4E82D58E02D1_4E82D4F60180_impl*
end;//TkwPopQueryCardAttributeSetWithLogicOperation.DoModelImpl

procedure TkwPopQueryCardAttributeSetWithLogicOperation.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_4E82D4F60180_var*
//#UC END# *4E808E8B01BB_4E82D4F60180_var*
begin
//#UC START# *4E808E8B01BB_4E82D4F60180_impl*
 DoModelImpl(aCtx, aCard);
//#UC END# *4E808E8B01BB_4E82D4F60180_impl*
end;//TkwPopQueryCardAttributeSetWithLogicOperation.DoCard

class function TkwPopQueryCardAttributeSetWithLogicOperation.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:Attribute:SetWithLogicOperation';
end;//TkwPopQueryCardAttributeSetWithLogicOperation.GetWordNameForRegister

initialization
 TkwPopQueryCardAttributeSetWithLogicOperation.RegisterInEngine;
 {* Регистрация pop_QueryCard_Attribute_SetWithLogicOperation }
{$IfEnd} // NOT Defined(NoScripts)

end.
