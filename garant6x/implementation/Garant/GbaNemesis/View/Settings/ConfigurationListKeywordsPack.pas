unit ConfigurationListKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/ConfigurationListKeywordsPack.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::ConfigurationListKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы ConfigurationList
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
  ConfigurationList_Form,
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
  Tkw_Form_ConfigurationList = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы ConfigurationList
----
*Пример использования*:
[code]
'aControl' форма::ConfigurationList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ConfigurationList

// start class Tkw_Form_ConfigurationList

class function Tkw_Form_ConfigurationList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::ConfigurationList';
end;//Tkw_Form_ConfigurationList.GetWordNameForRegister

function Tkw_Form_ConfigurationList.GetString: AnsiString;
 {-}
begin
 Result := 'en_ConfigurationList';
end;//Tkw_Form_ConfigurationList.GetString

type
  Tkw_ConfigurationList_Control_tvConfs = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола tvConfs
----
*Пример использования*:
[code]
контрол::tvConfs TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConfigurationList_Control_tvConfs

// start class Tkw_ConfigurationList_Control_tvConfs

class function Tkw_ConfigurationList_Control_tvConfs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvConfs';
end;//Tkw_ConfigurationList_Control_tvConfs.GetWordNameForRegister

function Tkw_ConfigurationList_Control_tvConfs.GetString: AnsiString;
 {-}
begin
 Result := 'tvConfs';
end;//Tkw_ConfigurationList_Control_tvConfs.GetString

class procedure Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine

type
  Tkw_ConfigurationList_Control_tvConfs_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола tvConfs
----
*Пример использования*:
[code]
контрол::tvConfs:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConfigurationList_Control_tvConfs_Push

// start class Tkw_ConfigurationList_Control_tvConfs_Push

procedure Tkw_ConfigurationList_Control_tvConfs_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvConfs');
 inherited;
end;//Tkw_ConfigurationList_Control_tvConfs_Push.DoDoIt

class function Tkw_ConfigurationList_Control_tvConfs_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvConfs:push';
end;//Tkw_ConfigurationList_Control_tvConfs_Push.GetWordNameForRegister

type
  TkwEnConfigurationListTvConfs = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConfigurationList.tvConfs
[panel]Контрол tvConfs формы Ten_ConfigurationList[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_ConfigurationList .Ten_ConfigurationList.tvConfs >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function TvConfs(const aCtx: TtfwContext;
     aen_ConfigurationList: Ten_ConfigurationList): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .Ten_ConfigurationList.tvConfs }
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
  end;//TkwEnConfigurationListTvConfs

// start class TkwEnConfigurationListTvConfs

function TkwEnConfigurationListTvConfs.TvConfs(const aCtx: TtfwContext;
  aen_ConfigurationList: Ten_ConfigurationList): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aen_ConfigurationList.tvConfs;
end;//TkwEnConfigurationListTvConfs.TvConfs

procedure TkwEnConfigurationListTvConfs.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConfigurationList : Ten_ConfigurationList;
begin
 try
  l_aen_ConfigurationList := Ten_ConfigurationList(aCtx.rEngine.PopObjAs(Ten_ConfigurationList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConfigurationList: Ten_ConfigurationList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvConfs(aCtx, l_aen_ConfigurationList)));
end;//TkwEnConfigurationListTvConfs.DoDoIt

class function TkwEnConfigurationListTvConfs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConfigurationList.tvConfs';
end;//TkwEnConfigurationListTvConfs.GetWordNameForRegister

procedure TkwEnConfigurationListTvConfs.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvConfs', aCtx);
end;//TkwEnConfigurationListTvConfs.SetValuePrim

function TkwEnConfigurationListTvConfs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnConfigurationListTvConfs.GetResultTypeInfo

function TkwEnConfigurationListTvConfs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConfigurationListTvConfs.GetAllParamsCount

function TkwEnConfigurationListTvConfs.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConfigurationList)]);
end;//TkwEnConfigurationListTvConfs.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_ConfigurationList
 Tkw_Form_ConfigurationList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConfigurationList_Control_tvConfs
 Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConfigurationList_Control_tvConfs_Push
 Tkw_ConfigurationList_Control_tvConfs_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConfigurationList_tvConfs
 TkwEnConfigurationListTvConfs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа ConfigurationList
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_ConfigurationList));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.