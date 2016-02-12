unit ListerWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ListerWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtLister
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TvtCustomListerFriend = {abstract} class(TvtCustomLister)
  {* Друг для TvtCustomLister }
 end;//TvtCustomListerFriend

 TkwPopListerSelectWithShift = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Lister:SelectWithShift
[panel]*Формат:* 
[code]
aFinishID aLister pop:Lister:SelectWithShift
[code] 
*Описание:* Выделяет несколько элементов от текущего до aFinishID у контролов TvtCustomListner и их потомков (TvtOutliner и т.п.). Полный аналог выделения с пощью Shift мышью.[panel]
*Пример:*
[code]
 aFinish aLister pop:Lister:SelectWithShift
[code]  }
  private
   procedure SelectWithShift(const aCtx: TtfwContext;
    aLister: TvtCustomLister;
    aFinish: Integer);
    {* Реализация слова скрипта pop:Lister:SelectWithShift }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopListerSelectWithShift

 TkwPopListerGetSelected = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Lister:GetSelected
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anIndex aLister pop:Lister:GetSelected >>> l_Boolean
[code]  }
  private
   function GetSelected(const aCtx: TtfwContext;
    aLister: TvtCustomLister;
    anIndex: Integer): Boolean;
    {* Реализация слова скрипта pop:Lister:GetSelected }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopListerGetSelected

 TkwPopListerFooterCaption = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Lister:FooterCaption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aLister pop:Lister:FooterCaption >>> l_String
[code]  }
  private
   function FooterCaption(const aCtx: TtfwContext;
    aLister: TvtCustomLister): AnsiString;
    {* Реализация слова скрипта pop:Lister:FooterCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopListerFooterCaption

 TkwPopListerCurrent = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Lister:Current
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aLister pop:Lister:Current >>> l_Integer
[code]  }
  private
   function Current(const aCtx: TtfwContext;
    aLister: TvtCustomLister): Integer;
    {* Реализация слова скрипта pop:Lister:Current }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopListerCurrent

procedure TkwPopListerSelectWithShift.SelectWithShift(const aCtx: TtfwContext;
 aLister: TvtCustomLister;
 aFinish: Integer);
 {* Реализация слова скрипта pop:Lister:SelectWithShift }
//#UC START# *EFDA6E4429D8_3601E7023043_var*
//#UC END# *EFDA6E4429D8_3601E7023043_var*
begin
//#UC START# *EFDA6E4429D8_3601E7023043_impl*
 aLister.SelectItems(aFinish);
//#UC END# *EFDA6E4429D8_3601E7023043_impl*
end;//TkwPopListerSelectWithShift.SelectWithShift

procedure TkwPopListerSelectWithShift.DoDoIt(const aCtx: TtfwContext);
var l_aLister: TvtCustomLister;
var l_aFinish: Integer;
begin
 try
  l_aLister := TvtCustomLister(aCtx.rEngine.PopObjAs(TvtCustomLister));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLister: TvtCustomLister : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFinish := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFinish: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SelectWithShift(aCtx, l_aLister, l_aFinish);
end;//TkwPopListerSelectWithShift.DoDoIt

class function TkwPopListerSelectWithShift.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Lister:SelectWithShift';
end;//TkwPopListerSelectWithShift.GetWordNameForRegister

function TkwPopListerSelectWithShift.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopListerSelectWithShift.GetResultTypeInfo

function TkwPopListerSelectWithShift.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopListerSelectWithShift.GetAllParamsCount

function TkwPopListerSelectWithShift.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomLister), TypeInfo(Integer)]);
end;//TkwPopListerSelectWithShift.ParamsTypes

function TkwPopListerGetSelected.GetSelected(const aCtx: TtfwContext;
 aLister: TvtCustomLister;
 anIndex: Integer): Boolean;
 {* Реализация слова скрипта pop:Lister:GetSelected }
//#UC START# *542EE0AE8385_94BB02952F38_var*
//#UC END# *542EE0AE8385_94BB02952F38_var*
begin
//#UC START# *542EE0AE8385_94BB02952F38_impl*
 Result := aLister.Selected[anIndex];
//#UC END# *542EE0AE8385_94BB02952F38_impl*
end;//TkwPopListerGetSelected.GetSelected

procedure TkwPopListerGetSelected.DoDoIt(const aCtx: TtfwContext);
var l_aLister: TvtCustomLister;
var l_anIndex: Integer;
begin
 try
  l_aLister := TvtCustomLister(aCtx.rEngine.PopObjAs(TvtCustomLister));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLister: TvtCustomLister : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushBool(GetSelected(aCtx, l_aLister, l_anIndex));
end;//TkwPopListerGetSelected.DoDoIt

class function TkwPopListerGetSelected.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Lister:GetSelected';
end;//TkwPopListerGetSelected.GetWordNameForRegister

function TkwPopListerGetSelected.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopListerGetSelected.GetResultTypeInfo

function TkwPopListerGetSelected.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopListerGetSelected.GetAllParamsCount

function TkwPopListerGetSelected.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomLister), TypeInfo(Integer)]);
end;//TkwPopListerGetSelected.ParamsTypes

function TkwPopListerFooterCaption.FooterCaption(const aCtx: TtfwContext;
 aLister: TvtCustomLister): AnsiString;
 {* Реализация слова скрипта pop:Lister:FooterCaption }
//#UC START# *D04F3C7D1449_0BB474851F7E_var*
//#UC END# *D04F3C7D1449_0BB474851F7E_var*
begin
//#UC START# *D04F3C7D1449_0BB474851F7E_impl*
 Result := TvtCustomListerFriend(aLister).FooterCaption;
//#UC END# *D04F3C7D1449_0BB474851F7E_impl*
end;//TkwPopListerFooterCaption.FooterCaption

procedure TkwPopListerFooterCaption.DoDoIt(const aCtx: TtfwContext);
var l_aLister: TvtCustomLister;
begin
 try
  l_aLister := TvtCustomLister(aCtx.rEngine.PopObjAs(TvtCustomLister));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLister: TvtCustomLister : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(FooterCaption(aCtx, l_aLister));
end;//TkwPopListerFooterCaption.DoDoIt

class function TkwPopListerFooterCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Lister:FooterCaption';
end;//TkwPopListerFooterCaption.GetWordNameForRegister

function TkwPopListerFooterCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopListerFooterCaption.GetResultTypeInfo

function TkwPopListerFooterCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopListerFooterCaption.GetAllParamsCount

function TkwPopListerFooterCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomLister)]);
end;//TkwPopListerFooterCaption.ParamsTypes

function TkwPopListerCurrent.Current(const aCtx: TtfwContext;
 aLister: TvtCustomLister): Integer;
 {* Реализация слова скрипта pop:Lister:Current }
begin
 Result := aLister.Current;
end;//TkwPopListerCurrent.Current

procedure TkwPopListerCurrent.DoDoIt(const aCtx: TtfwContext);
var l_aLister: TvtCustomLister;
begin
 try
  l_aLister := TvtCustomLister(aCtx.rEngine.PopObjAs(TvtCustomLister));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLister: TvtCustomLister : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Current(aCtx, l_aLister));
end;//TkwPopListerCurrent.DoDoIt

class function TkwPopListerCurrent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Lister:Current';
end;//TkwPopListerCurrent.GetWordNameForRegister

procedure TkwPopListerCurrent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Current', aCtx);
end;//TkwPopListerCurrent.SetValuePrim

function TkwPopListerCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopListerCurrent.GetResultTypeInfo

function TkwPopListerCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopListerCurrent.GetAllParamsCount

function TkwPopListerCurrent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomLister)]);
end;//TkwPopListerCurrent.ParamsTypes

initialization
 TkwPopListerSelectWithShift.RegisterInEngine;
 {* Регистрация pop_Lister_SelectWithShift }
 TkwPopListerGetSelected.RegisterInEngine;
 {* Регистрация pop_Lister_GetSelected }
 TkwPopListerFooterCaption.RegisterInEngine;
 {* Регистрация pop_Lister_FooterCaption }
 TkwPopListerCurrent.RegisterInEngine;
 {* Регистрация pop_Lister_Current }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCustomLister));
 {* Регистрация типа TvtCustomLister }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
{$IfEnd} // NOT Defined(NoScripts)

end.
