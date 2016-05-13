unit CheckListBoxWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CheckListBoxWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "CheckListBoxWordsPack" MUID: (552D23C300F1)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , CheckLst
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopCheckListBoxGetChecked = {final} class(TtfwClassLike)
  {* Слово скрипта pop:CheckListBox:GetChecked }
  private
   function GetChecked(const aCtx: TtfwContext;
    aCheckListBox: TCheckListBox;
    anIndex: Integer): Boolean;
    {* Реализация слова скрипта pop:CheckListBox:GetChecked }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCheckListBoxGetChecked

 TkwPopCheckListBoxSetChecked = {final} class(TtfwClassLike)
  {* Слово скрипта pop:CheckListBox:SetChecked }
  private
   procedure SetChecked(const aCtx: TtfwContext;
    aCheckListBox: TCheckListBox;
    anIndex: Integer;
    aValue: Boolean);
    {* Реализация слова скрипта pop:CheckListBox:SetChecked }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCheckListBoxSetChecked

 TkwPopCheckListBoxUncheckAll = {final} class(TtfwClassLike)
  {* Слово скрипта pop:CheckListBox:UncheckAll }
  private
   procedure UncheckAll(const aCtx: TtfwContext;
    aCheckListBox: TCheckListBox);
    {* Реализация слова скрипта pop:CheckListBox:UncheckAll }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCheckListBoxUncheckAll

function TkwPopCheckListBoxGetChecked.GetChecked(const aCtx: TtfwContext;
 aCheckListBox: TCheckListBox;
 anIndex: Integer): Boolean;
 {* Реализация слова скрипта pop:CheckListBox:GetChecked }
//#UC START# *552D24400252_552D24400252_51F24E890269_Word_var*
//#UC END# *552D24400252_552D24400252_51F24E890269_Word_var*
begin
//#UC START# *552D24400252_552D24400252_51F24E890269_Word_impl*
 Result := aCheckListBox.Checked[anIndex];
//#UC END# *552D24400252_552D24400252_51F24E890269_Word_impl*
end;//TkwPopCheckListBoxGetChecked.GetChecked

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

procedure TkwPopCheckListBoxSetChecked.SetChecked(const aCtx: TtfwContext;
 aCheckListBox: TCheckListBox;
 anIndex: Integer;
 aValue: Boolean);
 {* Реализация слова скрипта pop:CheckListBox:SetChecked }
//#UC START# *552D24650138_552D24650138_51F24E890269_Word_var*
//#UC END# *552D24650138_552D24650138_51F24E890269_Word_var*
begin
//#UC START# *552D24650138_552D24650138_51F24E890269_Word_impl*
 aCheckListBox.Checked[anIndex] := aValue;
//#UC END# *552D24650138_552D24650138_51F24E890269_Word_impl*
end;//TkwPopCheckListBoxSetChecked.SetChecked

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

procedure TkwPopCheckListBoxUncheckAll.UncheckAll(const aCtx: TtfwContext;
 aCheckListBox: TCheckListBox);
 {* Реализация слова скрипта pop:CheckListBox:UncheckAll }
//#UC START# *552D24A702F3_552D24A702F3_51F24E890269_Word_var*
var
 i: Integer;
//#UC END# *552D24A702F3_552D24A702F3_51F24E890269_Word_var*
begin
//#UC START# *552D24A702F3_552D24A702F3_51F24E890269_Word_impl*
 for i := 0 to aCheckListBox.Count - 1 do
  aCheckListBox.Checked[i] := False;
//#UC END# *552D24A702F3_552D24A702F3_51F24E890269_Word_impl*
end;//TkwPopCheckListBoxUncheckAll.UncheckAll

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

initialization
 TkwPopCheckListBoxGetChecked.RegisterInEngine;
 {* Регистрация pop_CheckListBox_GetChecked }
 TkwPopCheckListBoxSetChecked.RegisterInEngine;
 {* Регистрация pop_CheckListBox_SetChecked }
 TkwPopCheckListBoxUncheckAll.RegisterInEngine;
 {* Регистрация pop_CheckListBox_UncheckAll }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCheckListBox));
 {* Регистрация типа TCheckListBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
