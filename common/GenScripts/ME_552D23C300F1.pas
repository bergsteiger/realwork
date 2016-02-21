unit CheckListBoxWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CheckListBoxWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , CheckLst
 {$IfEnd} // NOT Defined(NoVCL)
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopCheckListBoxGetChecked = {final} class(TtfwClassLike)
  {* Слово скрипта pop:CheckListBox:GetChecked
[panel]anIndex aCheckBoxList pop:CheckListBox:GetChecked
anIndex - индекс CheckBox'а
aCheckBoxList  - контрол
Возвращает True, если элемент помечен и False - если нет.[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anIndex aCheckListBox pop:CheckListBox:GetChecked >>> l_Boolean
[code]  }
  private
   function GetChecked(const aCtx: TtfwContext;
    aCheckListBox: TCheckListBox;
    anIndex: Integer): Boolean;
    {* Реализация слова скрипта pop:CheckListBox:GetChecked }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCheckListBoxGetChecked

 TkwPopCheckListBoxSetChecked = {final} class(TtfwClassLike)
  {* Слово скрипта pop:CheckListBox:SetChecked
[panel]aValue anIndex aCheckBoxList pop:CheckListBox:SetChecked
anIndex - индекс CheckBox'а
aCheckBoxList  - контрол
Помечает элемент, если aValue = True и сбрасывает пометку, если aValue = False[panel]
*Пример:*
[code]
 aValue anIndex aCheckListBox pop:CheckListBox:SetChecked
[code]  }
  private
   procedure SetChecked(const aCtx: TtfwContext;
    aCheckListBox: TCheckListBox;
    anIndex: Integer;
    aValue: Boolean);
    {* Реализация слова скрипта pop:CheckListBox:SetChecked }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCheckListBoxSetChecked

 TkwPopCheckListBoxUncheckAll = {final} class(TtfwClassLike)
  {* Слово скрипта pop:CheckListBox:UncheckAll
[panel]aCheckBoxList pop:CheckListBox:UncheckAll
Сбрасыват пометки у всех пунктов контрола.[panel]
*Пример:*
[code]
 aCheckListBox pop:CheckListBox:UncheckAll
[code]  }
  private
   procedure UncheckAll(const aCtx: TtfwContext;
    aCheckListBox: TCheckListBox);
    {* Реализация слова скрипта pop:CheckListBox:UncheckAll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCheckListBoxUncheckAll

function TkwPopCheckListBoxGetChecked.GetChecked(const aCtx: TtfwContext;
 aCheckListBox: TCheckListBox;
 anIndex: Integer): Boolean;
 {* Реализация слова скрипта pop:CheckListBox:GetChecked }
//#UC START# *5C7C4E6C6645_61EE94402745_var*
//#UC END# *5C7C4E6C6645_61EE94402745_var*
begin
//#UC START# *5C7C4E6C6645_61EE94402745_impl*
 Result := aCheckListBox.Checked[anIndex];
//#UC END# *5C7C4E6C6645_61EE94402745_impl*
end;//TkwPopCheckListBoxGetChecked.GetChecked

procedure TkwPopCheckListBoxGetChecked.DoDoIt(const aCtx: TtfwContext);
var l_aCheckListBox: TCheckListBox;
var l_anIndex: Integer;
begin
 try
  l_aCheckListBox := TCheckListBox(aCtx.rEngine.PopObjAs(TCheckListBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCheckListBox: TCheckListBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(GetChecked(aCtx, l_aCheckListBox, l_anIndex));
end;//TkwPopCheckListBoxGetChecked.DoDoIt

class function TkwPopCheckListBoxGetChecked.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:CheckListBox:GetChecked';
end;//TkwPopCheckListBoxGetChecked.GetWordNameForRegister

function TkwPopCheckListBoxGetChecked.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopCheckListBoxGetChecked.GetResultTypeInfo

function TkwPopCheckListBoxGetChecked.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopCheckListBoxGetChecked.GetAllParamsCount

function TkwPopCheckListBoxGetChecked.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCheckListBox), TypeInfo(Integer)]);
end;//TkwPopCheckListBoxGetChecked.ParamsTypes

procedure TkwPopCheckListBoxSetChecked.SetChecked(const aCtx: TtfwContext;
 aCheckListBox: TCheckListBox;
 anIndex: Integer;
 aValue: Boolean);
 {* Реализация слова скрипта pop:CheckListBox:SetChecked }
//#UC START# *AEDB5415872F_CA2863D28A34_var*
//#UC END# *AEDB5415872F_CA2863D28A34_var*
begin
//#UC START# *AEDB5415872F_CA2863D28A34_impl*
 aCheckListBox.Checked[anIndex] := aValue;
//#UC END# *AEDB5415872F_CA2863D28A34_impl*
end;//TkwPopCheckListBoxSetChecked.SetChecked

procedure TkwPopCheckListBoxSetChecked.DoDoIt(const aCtx: TtfwContext);
var l_aCheckListBox: TCheckListBox;
var l_anIndex: Integer;
var l_aValue: Boolean;
begin
 try
  l_aCheckListBox := TCheckListBox(aCtx.rEngine.PopObjAs(TCheckListBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCheckListBox: TCheckListBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetChecked(aCtx, l_aCheckListBox, l_anIndex, l_aValue);
end;//TkwPopCheckListBoxSetChecked.DoDoIt

class function TkwPopCheckListBoxSetChecked.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:CheckListBox:SetChecked';
end;//TkwPopCheckListBoxSetChecked.GetWordNameForRegister

function TkwPopCheckListBoxSetChecked.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopCheckListBoxSetChecked.GetResultTypeInfo

function TkwPopCheckListBoxSetChecked.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwPopCheckListBoxSetChecked.GetAllParamsCount

function TkwPopCheckListBoxSetChecked.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCheckListBox), TypeInfo(Integer), TypeInfo(Boolean)]);
end;//TkwPopCheckListBoxSetChecked.ParamsTypes

procedure TkwPopCheckListBoxUncheckAll.UncheckAll(const aCtx: TtfwContext;
 aCheckListBox: TCheckListBox);
 {* Реализация слова скрипта pop:CheckListBox:UncheckAll }
//#UC START# *9D7C5A3CC63F_CC902BB857AE_var*
var
 i: Integer;
//#UC END# *9D7C5A3CC63F_CC902BB857AE_var*
begin
//#UC START# *9D7C5A3CC63F_CC902BB857AE_impl*
 for i := 0 to aCheckListBox.Count - 1 do
  aCheckListBox.Checked[i] := False;
//#UC END# *9D7C5A3CC63F_CC902BB857AE_impl*
end;//TkwPopCheckListBoxUncheckAll.UncheckAll

procedure TkwPopCheckListBoxUncheckAll.DoDoIt(const aCtx: TtfwContext);
var l_aCheckListBox: TCheckListBox;
begin
 try
  l_aCheckListBox := TCheckListBox(aCtx.rEngine.PopObjAs(TCheckListBox));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCheckListBox: TCheckListBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 UncheckAll(aCtx, l_aCheckListBox);
end;//TkwPopCheckListBoxUncheckAll.DoDoIt

class function TkwPopCheckListBoxUncheckAll.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:CheckListBox:UncheckAll';
end;//TkwPopCheckListBoxUncheckAll.GetWordNameForRegister

function TkwPopCheckListBoxUncheckAll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopCheckListBoxUncheckAll.GetResultTypeInfo

function TkwPopCheckListBoxUncheckAll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopCheckListBoxUncheckAll.GetAllParamsCount

function TkwPopCheckListBoxUncheckAll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCheckListBox)]);
end;//TkwPopCheckListBoxUncheckAll.ParamsTypes

initialization
 TkwPopCheckListBoxGetChecked.RegisterInEngine;
 {* Регистрация pop_CheckListBox_GetChecked }
 TkwPopCheckListBoxSetChecked.RegisterInEngine;
 {* Регистрация pop_CheckListBox_SetChecked }
 TkwPopCheckListBoxUncheckAll.RegisterInEngine;
 {* Регистрация pop_CheckListBox_UncheckAll }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCheckListBox));
 {* Регистрация типа TCheckListBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts)

end.
