unit TreeAttributeFirstLevelKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/TreeAttributeFirstLevelKeywordsPack.pas"
// Начат: 08.09.2009 15:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Search::View::Search::Search::TreeAttributeFirstLevelKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы TreeAttributeFirstLevel
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
  TreeAttributeFirstLevel_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewWithAdapterDragDrop,
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
  Tkw_Form_TreeAttributeFirstLevel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы TreeAttributeFirstLevel
----
*Пример использования*:
[code]
'aControl' форма::TreeAttributeFirstLevel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_TreeAttributeFirstLevel

// start class Tkw_Form_TreeAttributeFirstLevel

class function Tkw_Form_TreeAttributeFirstLevel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::TreeAttributeFirstLevel';
end;//Tkw_Form_TreeAttributeFirstLevel.GetWordNameForRegister

function Tkw_Form_TreeAttributeFirstLevel.GetString: AnsiString;
 {-}
begin
 Result := 'efTreeAttributeFirstLevel';
end;//Tkw_Form_TreeAttributeFirstLevel.GetString

type
  Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FirstLevelContent
----
*Пример использования*:
[code]
контрол::FirstLevelContent TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent

// start class Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent

class function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FirstLevelContent';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetWordNameForRegister

function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetString: AnsiString;
 {-}
begin
 Result := 'FirstLevelContent';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetString

class procedure Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine

type
  Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FirstLevelContent
----
*Пример использования*:
[code]
контрол::FirstLevelContent:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push

// start class Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push

procedure Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FirstLevelContent');
 inherited;
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.DoDoIt

class function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FirstLevelContent:push';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.GetWordNameForRegister

type
  TkwEfTreeAttributeFirstLevelFirstLevelContent = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefTreeAttributeFirstLevel.FirstLevelContent
[panel]Контрол FirstLevelContent формы TefTreeAttributeFirstLevel[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aefTreeAttributeFirstLevel .TefTreeAttributeFirstLevel.FirstLevelContent >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function FirstLevelContent(const aCtx: TtfwContext;
     aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .TefTreeAttributeFirstLevel.FirstLevelContent }
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
  end;//TkwEfTreeAttributeFirstLevelFirstLevelContent

// start class TkwEfTreeAttributeFirstLevelFirstLevelContent

function TkwEfTreeAttributeFirstLevelFirstLevelContent.FirstLevelContent(const aCtx: TtfwContext;
  aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aefTreeAttributeFirstLevel.FirstLevelContent;
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.FirstLevelContent

procedure TkwEfTreeAttributeFirstLevelFirstLevelContent.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefTreeAttributeFirstLevel : TefTreeAttributeFirstLevel;
begin
 try
  l_aefTreeAttributeFirstLevel := TefTreeAttributeFirstLevel(aCtx.rEngine.PopObjAs(TefTreeAttributeFirstLevel));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FirstLevelContent(aCtx, l_aefTreeAttributeFirstLevel)));
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.DoDoIt

class function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefTreeAttributeFirstLevel.FirstLevelContent';
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetWordNameForRegister

procedure TkwEfTreeAttributeFirstLevelFirstLevelContent.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FirstLevelContent', aCtx);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.SetValuePrim

function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetResultTypeInfo

function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetAllParamsCount

function TkwEfTreeAttributeFirstLevelFirstLevelContent.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeFirstLevel)]);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_TreeAttributeFirstLevel
 Tkw_Form_TreeAttributeFirstLevel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent
 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push
 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efTreeAttributeFirstLevel_FirstLevelContent
 TkwEfTreeAttributeFirstLevelFirstLevelContent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TreeAttributeFirstLevel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefTreeAttributeFirstLevel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.