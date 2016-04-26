unit NewsLineKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы NewsLine }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\NewsLineKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "NewsLineKeywordsPack" MUID: (7F393F8A2EA8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscTreeViewForNewsLine
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , NewsLine_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 Tkw_Form_NewsLine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы NewsLine
----
*Пример использования*:
[code]
'aControl' форма::NewsLine TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_NewsLine

 Tkw_NewsLine_Control_DateList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола DateList
----
*Пример использования*:
[code]
контрол::DateList TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewsLine_Control_DateList

 Tkw_NewsLine_Control_DateList_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола DateList
----
*Пример использования*:
[code]
контрол::DateList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewsLine_Control_DateList_Push

 TkwEnNewsLineDateList = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenNewsLine.DateList
[panel]Контрол DateList формы TenNewsLine[panel]
*Тип результата:* TnscTreeViewForNewsLine
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewForNewsLine
 aenNewsLine .TenNewsLine.DateList >>> l_TnscTreeViewForNewsLine
[code]  }
  private
   function DateList(const aCtx: TtfwContext;
    aenNewsLine: TenNewsLine): TnscTreeViewForNewsLine;
    {* Реализация слова скрипта .TenNewsLine.DateList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnNewsLineDateList

function Tkw_Form_NewsLine.GetString: AnsiString;
begin
 Result := 'enNewsLine';
end;//Tkw_Form_NewsLine.GetString

class function Tkw_Form_NewsLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::NewsLine';
end;//Tkw_Form_NewsLine.GetWordNameForRegister

function Tkw_NewsLine_Control_DateList.GetString: AnsiString;
begin
 Result := 'DateList';
end;//Tkw_NewsLine_Control_DateList.GetString

class procedure Tkw_NewsLine_Control_DateList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewForNewsLine);
end;//Tkw_NewsLine_Control_DateList.RegisterInEngine

class function Tkw_NewsLine_Control_DateList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DateList';
end;//Tkw_NewsLine_Control_DateList.GetWordNameForRegister

procedure Tkw_NewsLine_Control_DateList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('DateList');
 inherited;
end;//Tkw_NewsLine_Control_DateList_Push.DoDoIt

class function Tkw_NewsLine_Control_DateList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DateList:push';
end;//Tkw_NewsLine_Control_DateList_Push.GetWordNameForRegister

function TkwEnNewsLineDateList.DateList(const aCtx: TtfwContext;
 aenNewsLine: TenNewsLine): TnscTreeViewForNewsLine;
 {* Реализация слова скрипта .TenNewsLine.DateList }
begin
 Result := aenNewsLine.DateList;
end;//TkwEnNewsLineDateList.DateList

procedure TkwEnNewsLineDateList.DoDoIt(const aCtx: TtfwContext);
var l_aenNewsLine: TenNewsLine;
begin
 try
  l_aenNewsLine := TenNewsLine(aCtx.rEngine.PopObjAs(TenNewsLine));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenNewsLine: TenNewsLine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DateList(aCtx, l_aenNewsLine));
end;//TkwEnNewsLineDateList.DoDoIt

procedure TkwEnNewsLineDateList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству DateList', aCtx);
end;//TkwEnNewsLineDateList.SetValuePrim

function TkwEnNewsLineDateList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewForNewsLine);
end;//TkwEnNewsLineDateList.GetResultTypeInfo

function TkwEnNewsLineDateList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnNewsLineDateList.GetAllParamsCount

function TkwEnNewsLineDateList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenNewsLine)]);
end;//TkwEnNewsLineDateList.ParamsTypes

class function TkwEnNewsLineDateList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenNewsLine.DateList';
end;//TkwEnNewsLineDateList.GetWordNameForRegister

initialization
 Tkw_Form_NewsLine.RegisterInEngine;
 {* Регистрация Tkw_Form_NewsLine }
 Tkw_NewsLine_Control_DateList.RegisterInEngine;
 {* Регистрация Tkw_NewsLine_Control_DateList }
 Tkw_NewsLine_Control_DateList_Push.RegisterInEngine;
 {* Регистрация Tkw_NewsLine_Control_DateList_Push }
 TkwEnNewsLineDateList.RegisterInEngine;
 {* Регистрация enNewsLine_DateList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenNewsLine));
 {* Регистрация типа NewsLine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewForNewsLine));
 {* Регистрация типа TnscTreeViewForNewsLine }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
