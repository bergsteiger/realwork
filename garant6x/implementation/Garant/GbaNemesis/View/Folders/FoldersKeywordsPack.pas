unit FoldersKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/FoldersKeywordsPack.pas"
// Начат: 27.08.2009 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFolders$UC::FoldersKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы Folders
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
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  Folders_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
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
  Tkw_Form_Folders = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы Folders
----
*Пример использования*:
[code]
'aControl' форма::Folders TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Folders

// start class Tkw_Form_Folders

class function Tkw_Form_Folders.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::Folders';
end;//Tkw_Form_Folders.GetWordNameForRegister

function Tkw_Form_Folders.GetString: AnsiString;
 {-}
begin
 Result := 'cfFolders';
end;//Tkw_Form_Folders.GetString

type
  Tkw_Folders_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Folders_Control_BackgroundPanel

// start class Tkw_Folders_Control_BackgroundPanel

class function Tkw_Folders_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Folders_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Folders_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_Folders_Control_BackgroundPanel.GetString

class procedure Tkw_Folders_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_Folders_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_Folders_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Folders_Control_BackgroundPanel_Push

// start class Tkw_Folders_Control_BackgroundPanel_Push

procedure Tkw_Folders_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Folders_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Folders_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Folders_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_Folders_Control_ParentZone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Folders_Control_ParentZone

// start class Tkw_Folders_Control_ParentZone

class function Tkw_Folders_Control_ParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone';
end;//Tkw_Folders_Control_ParentZone.GetWordNameForRegister

function Tkw_Folders_Control_ParentZone.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZone';
end;//Tkw_Folders_Control_ParentZone.GetString

class procedure Tkw_Folders_Control_ParentZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Folders_Control_ParentZone.RegisterInEngine

type
  Tkw_Folders_Control_ParentZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Folders_Control_ParentZone_Push

// start class Tkw_Folders_Control_ParentZone_Push

procedure Tkw_Folders_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_Folders_Control_ParentZone_Push.DoDoIt

class function Tkw_Folders_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_Folders_Control_ParentZone_Push.GetWordNameForRegister

type
  Tkw_Folders_Control_ChildZone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Folders_Control_ChildZone

// start class Tkw_Folders_Control_ChildZone

class function Tkw_Folders_Control_ChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone';
end;//Tkw_Folders_Control_ChildZone.GetWordNameForRegister

function Tkw_Folders_Control_ChildZone.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZone';
end;//Tkw_Folders_Control_ChildZone.GetString

class procedure Tkw_Folders_Control_ChildZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_Folders_Control_ChildZone.RegisterInEngine

type
  Tkw_Folders_Control_ChildZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Folders_Control_ChildZone_Push

// start class Tkw_Folders_Control_ChildZone_Push

procedure Tkw_Folders_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_Folders_Control_ChildZone_Push.DoDoIt

class function Tkw_Folders_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_Folders_Control_ChildZone_Push.GetWordNameForRegister

type
  TkwCfFoldersBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfFolders.BackgroundPanel
[panel]Контрол BackgroundPanel формы TcfFolders[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfFolders .TcfFolders.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     acfFolders: TcfFolders): TvtProportionalPanel;
     {* Реализация слова скрипта .TcfFolders.BackgroundPanel }
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
  end;//TkwCfFoldersBackgroundPanel

// start class TkwCfFoldersBackgroundPanel

function TkwCfFoldersBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  acfFolders: TcfFolders): TvtProportionalPanel;
 {-}
begin
 Result := acfFolders.BackgroundPanel;
end;//TkwCfFoldersBackgroundPanel.BackgroundPanel

procedure TkwCfFoldersBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfFolders : TcfFolders;
begin
 try
  l_acfFolders := TcfFolders(aCtx.rEngine.PopObjAs(TcfFolders));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfFolders: TcfFolders : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_acfFolders)));
end;//TkwCfFoldersBackgroundPanel.DoDoIt

class function TkwCfFoldersBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfFolders.BackgroundPanel';
end;//TkwCfFoldersBackgroundPanel.GetWordNameForRegister

procedure TkwCfFoldersBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwCfFoldersBackgroundPanel.SetValuePrim

function TkwCfFoldersBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfFoldersBackgroundPanel.GetResultTypeInfo

function TkwCfFoldersBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfFoldersBackgroundPanel.GetAllParamsCount

function TkwCfFoldersBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFolders)]);
end;//TkwCfFoldersBackgroundPanel.ParamsTypes

type
  TkwCfFoldersParentZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfFolders.ParentZone
[panel]Контрол ParentZone формы TcfFolders[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfFolders .TcfFolders.ParentZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ParentZone(const aCtx: TtfwContext;
     acfFolders: TcfFolders): TvtPanel;
     {* Реализация слова скрипта .TcfFolders.ParentZone }
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
  end;//TkwCfFoldersParentZone

// start class TkwCfFoldersParentZone

function TkwCfFoldersParentZone.ParentZone(const aCtx: TtfwContext;
  acfFolders: TcfFolders): TvtPanel;
 {-}
begin
 Result := acfFolders.ParentZone;
end;//TkwCfFoldersParentZone.ParentZone

procedure TkwCfFoldersParentZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfFolders : TcfFolders;
begin
 try
  l_acfFolders := TcfFolders(aCtx.rEngine.PopObjAs(TcfFolders));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfFolders: TcfFolders : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZone(aCtx, l_acfFolders)));
end;//TkwCfFoldersParentZone.DoDoIt

class function TkwCfFoldersParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfFolders.ParentZone';
end;//TkwCfFoldersParentZone.GetWordNameForRegister

procedure TkwCfFoldersParentZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZone', aCtx);
end;//TkwCfFoldersParentZone.SetValuePrim

function TkwCfFoldersParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfFoldersParentZone.GetResultTypeInfo

function TkwCfFoldersParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfFoldersParentZone.GetAllParamsCount

function TkwCfFoldersParentZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFolders)]);
end;//TkwCfFoldersParentZone.ParamsTypes

type
  TkwCfFoldersChildZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfFolders.ChildZone
[panel]Контрол ChildZone формы TcfFolders[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfFolders .TcfFolders.ChildZone >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function ChildZone(const aCtx: TtfwContext;
     acfFolders: TcfFolders): TvtSizeablePanel;
     {* Реализация слова скрипта .TcfFolders.ChildZone }
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
  end;//TkwCfFoldersChildZone

// start class TkwCfFoldersChildZone

function TkwCfFoldersChildZone.ChildZone(const aCtx: TtfwContext;
  acfFolders: TcfFolders): TvtSizeablePanel;
 {-}
begin
 Result := acfFolders.ChildZone;
end;//TkwCfFoldersChildZone.ChildZone

procedure TkwCfFoldersChildZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfFolders : TcfFolders;
begin
 try
  l_acfFolders := TcfFolders(aCtx.rEngine.PopObjAs(TcfFolders));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfFolders: TcfFolders : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ChildZone(aCtx, l_acfFolders)));
end;//TkwCfFoldersChildZone.DoDoIt

class function TkwCfFoldersChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfFolders.ChildZone';
end;//TkwCfFoldersChildZone.GetWordNameForRegister

procedure TkwCfFoldersChildZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZone', aCtx);
end;//TkwCfFoldersChildZone.SetValuePrim

function TkwCfFoldersChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfFoldersChildZone.GetResultTypeInfo

function TkwCfFoldersChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfFoldersChildZone.GetAllParamsCount

function TkwCfFoldersChildZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFolders)]);
end;//TkwCfFoldersChildZone.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_Folders
 Tkw_Form_Folders.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Folders_Control_BackgroundPanel
 Tkw_Folders_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Folders_Control_BackgroundPanel_Push
 Tkw_Folders_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Folders_Control_ParentZone
 Tkw_Folders_Control_ParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Folders_Control_ParentZone_Push
 Tkw_Folders_Control_ParentZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Folders_Control_ChildZone
 Tkw_Folders_Control_ChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Folders_Control_ChildZone_Push
 Tkw_Folders_Control_ChildZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация cfFolders_BackgroundPanel
 TkwCfFoldersBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация cfFolders_ParentZone
 TkwCfFoldersParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация cfFolders_ChildZone
 TkwCfFoldersChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа Folders
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfFolders));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.