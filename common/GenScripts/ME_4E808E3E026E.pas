unit kwPopQueryCardSetAttribute;
 {* Добавляет атрибут к текущей карточке запроса.

*Пример:*
[code]
 моп::Поиск_Поиск_лекарственного_средства
 'AT_PHARM_NAME' 'Аргинин' Search:SetAttribute
 'AT_PHARM_ATC' 'A. Пищеварительный тракт и обмен веществ' Search:SetAttribute
 'AT_PHARM_ATC' 'B. Препараты влияющие на кроветворение и кровь' Search:SetAttribute
 Ok
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopQueryCardSetAttribute.pas"
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
 TkwPopQueryCardSetAttribute = class(TkwQueryCardFromStackWord)
  {* Добавляет атрибут к текущей карточке запроса.

*Пример:*
[code]
 моп::Поиск_Поиск_лекарственного_средства
 'AT_PHARM_NAME' 'Аргинин' Search:SetAttribute
 'AT_PHARM_ATC' 'A. Пищеварительный тракт и обмен веществ' Search:SetAttribute
 'AT_PHARM_ATC' 'B. Препараты влияющие на кроветворение и кровь' Search:SetAttribute
 Ok
[code] }
  private
   procedure DoModelImpl;
  protected
   procedure DoCard(const aCtx: TtfwContext;
    aCard: TevQueryCardEditor); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopQueryCardSetAttribute
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

procedure TkwPopQueryCardSetAttribute.DoModelImpl;
var l_Name: Il3CString;
var l_Value: Il3CString;
var l_Op: InevOp;

 procedure CallIterator;

  function DoIt(const anItem: IevReq): Boolean;
   {* Подитеративная функция для вызова L2IevReqIteratorDoReqAction из CallIterator }
  //#UC START# *6E7B54AC5B25__var*
  var
   l_F : IevEditorControlField;
  //#UC END# *6E7B54AC5B25__var*
  begin
  //#UC START# *6E7B54AC5B25__impl*
   if l3Same(l_Name, anItem.ReqName) then
   begin
    Result := false;
    l_F := anItem.FirstField;
    if not l3IsNil(anItem.FirstField.Text) then
     l_F := anItem.AddField(aCard.View, true);
    if (l_F = nil) then
    // - поле не добавилось, видимо есть ограничение на количество полей,
    //   заполняем по-новой, то что уже заполнено
     l_F := anItem.FirstField;
    l_F.Text := l_Value;
    l_F.SynchronizeSelectedValueWithText{TextChange(aCard.View, l_F.Para, l_Op)};
    Exit;
   end//l3Same(l_Name, anItem.ReqName)
   else
   if l3Starts(l3Str(anItem.ReqName)+'#', l3PCharLen(l_Name)) then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=290953660
   // - костыль для заполнения "второго" поля. Вообще говоря надо это сделать
   //   как-то аккуратнее
   begin
    Result := false;
    l_F := anItem.LastField;
    {if not l3IsNil(anItem.LastField.Text) then
    begin
     l_F := nil;
     //l_F := anItem.AddField(aCard.View, true);
    end;//not l3IsNil(anItem.LastField.Text)
    if (l_F = nil) then
    // - поле не добавилось, видимо есть ограничение на количество полей,
    //   заполняем по-новой, то что уже заполнено
     l_F := anItem.LastField;}
    l_F.Text := l_Value;
    l_F.SynchronizeSelectedValueWithText{TextChange(aCard.View, l_F.Para, l_Op)};
    Exit;
   end//l3Same(l_Name, anItem.ReqName)
   else
    Result := true;
  //#UC END# *6E7B54AC5B25__impl*
  end;//DoIt

 //#UC START# *4E81ADFF02AC__var*
 //#UC END# *4E81ADFF02AC__var*
 begin
  //#UC START# *4E81ADFF02ACiter*
  TevReqIterator.Make(aCard).
  //#UC END# *4E81ADFF02ACiter*
  DoReqF(L2IevReqIteratorDoReqAction(@DoIt));
 end;//CallIterator

//#UC START# *4E81A3090197_4E808E3E026E_var*
//#UC END# *4E81A3090197_4E808E3E026E_var*
begin
//#UC START# *4E81A3090197_4E808E3E026E_impl*
 l_Value := aCtx.rEngine.PopString;
 l_Name := aCtx.rEngine.PopString;
 l_Op := aCard.StartOp;
 try
  CallIterator;
 finally
  l_Op := nil;
 end;//try..finally
//#UC END# *4E81A3090197_4E808E3E026E_impl*
end;//TkwPopQueryCardSetAttribute.DoModelImpl

procedure TkwPopQueryCardSetAttribute.DoCard(const aCtx: TtfwContext;
 aCard: TevQueryCardEditor);
//#UC START# *4E808E8B01BB_4E808E3E026E_var*
//#UC END# *4E808E8B01BB_4E808E3E026E_var*
begin
//#UC START# *4E808E8B01BB_4E808E3E026E_impl*
 DoModelImpl(aCtx, aCard);
//#UC END# *4E808E8B01BB_4E808E3E026E_impl*
end;//TkwPopQueryCardSetAttribute.DoCard

class function TkwPopQueryCardSetAttribute.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:QueryCard:SetAttribute';
end;//TkwPopQueryCardSetAttribute.GetWordNameForRegister

initialization
 TkwPopQueryCardSetAttribute.RegisterInEngine;
 {* Регистрация pop_QueryCard_SetAttribute }
{$IfEnd} // NOT Defined(NoScripts)

end.
