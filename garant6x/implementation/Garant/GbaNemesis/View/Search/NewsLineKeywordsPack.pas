unit NewsLineKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/NewsLineKeywordsPack.pas"
// Начат: 21.08.2009 20:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Пользовательские сервисы::Autoreferat::View::Search::PrimMonitorings::NewsLineKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы NewsLine
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  NewsLine_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewForNewsLine,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_NewsLine = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы NewsLine
----
*Пример использования*:
[code]
'aControl' форма::NewsLine TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_NewsLine

// start class Tkw_Form_NewsLine

class function Tkw_Form_NewsLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::NewsLine';
end;//Tkw_Form_NewsLine.GetWordNameForRegister

function Tkw_Form_NewsLine.GetString: AnsiString;
 {-}
begin
 Result := 'enNewsLine';
end;//Tkw_Form_NewsLine.GetString

type
  Tkw_NewsLine_Control_DateList = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола DateList
----
*Пример использования*:
[code]
контрол::DateList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_NewsLine_Control_DateList

// start class Tkw_NewsLine_Control_DateList

class function Tkw_NewsLine_Control_DateList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::DateList';
end;//Tkw_NewsLine_Control_DateList.GetWordNameForRegister

function Tkw_NewsLine_Control_DateList.GetString: AnsiString;
 {-}
begin
 Result := 'DateList';
end;//Tkw_NewsLine_Control_DateList.GetString

class procedure Tkw_NewsLine_Control_DateList.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewForNewsLine);
end;//Tkw_NewsLine_Control_DateList.RegisterInEngine

type
  Tkw_NewsLine_Control_DateList_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола DateList
----
*Пример использования*:
[code]
контрол::DateList:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_NewsLine_Control_DateList_Push

// start class Tkw_NewsLine_Control_DateList_Push

procedure Tkw_NewsLine_Control_DateList_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('DateList');
 inherited;
end;//Tkw_NewsLine_Control_DateList_Push.DoDoIt

class function Tkw_NewsLine_Control_DateList_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::DateList:push';
end;//Tkw_NewsLine_Control_DateList_Push.GetWordNameForRegister

type
  TkwEnNewsLineDateList = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenNewsLine.DateList
[panel]Контрол DateList формы TenNewsLine[panel]
*Тип результата:* TnscTreeViewForNewsLine
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewForNewsLine
 aenNewsLine .TenNewsLine.DateList >>> l_TnscTreeViewForNewsLine
[code]  }
  private
  // private methods
   function DateList(const aCtx: TtfwContext;
     aenNewsLine: TenNewsLine): TnscTreeViewForNewsLine;
     {* Реализация слова скрипта .TenNewsLine.DateList }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEnNewsLineDateList

// start class TkwEnNewsLineDateList

function TkwEnNewsLineDateList.DateList(const aCtx: TtfwContext;
  aenNewsLine: TenNewsLine): TnscTreeViewForNewsLine;
 {-}
begin
 Result := aenNewsLine.DateList;
end;//TkwEnNewsLineDateList.DateList

procedure TkwEnNewsLineDateList.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenNewsLine : TenNewsLine;
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
 aCtx.rEngine.PushObj((DateList(aCtx, l_aenNewsLine)));
end;//TkwEnNewsLineDateList.DoDoIt

class function TkwEnNewsLineDateList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenNewsLine.DateList';
end;//TkwEnNewsLineDateList.GetWordNameForRegister

procedure TkwEnNewsLineDateList.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству DateList', aCtx);
end;//TkwEnNewsLineDateList.SetValuePrim

function TkwEnNewsLineDateList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewForNewsLine);
end;//TkwEnNewsLineDateList.GetResultTypeInfo

function TkwEnNewsLineDateList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnNewsLineDateList.GetAllParamsCount

function TkwEnNewsLineDateList.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenNewsLine)]);
end;//TkwEnNewsLineDateList.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_NewsLine
 Tkw_Form_NewsLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_NewsLine_Control_DateList
 Tkw_NewsLine_Control_DateList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_NewsLine_Control_DateList_Push
 Tkw_NewsLine_Control_DateList_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enNewsLine_DateList
 TkwEnNewsLineDateList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа NewsLine
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenNewsLine));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewForNewsLine
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewForNewsLine));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.