unit FoldersKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Folders }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\FoldersKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "FoldersKeywordsPack" MUID: (4A97D83003AE_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Folders_Form
 , tfwPropertyLike
 , vtProportionalPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtPanel
 , vtSizeablePanel
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4A97D83003AE_Packimpl_uses*
 //#UC END# *4A97D83003AE_Packimpl_uses*
;

type
 TkwCfFoldersBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfFolders.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    acfFolders: TcfFolders): TvtProportionalPanel;
    {* Реализация слова скрипта .TcfFolders.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfFoldersBackgroundPanel

 TkwCfFoldersParentZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfFolders.ParentZone }
  private
   function ParentZone(const aCtx: TtfwContext;
    acfFolders: TcfFolders): TvtPanel;
    {* Реализация слова скрипта .TcfFolders.ParentZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfFoldersParentZone

 TkwCfFoldersChildZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfFolders.ChildZone }
  private
   function ChildZone(const aCtx: TtfwContext;
    acfFolders: TcfFolders): TvtSizeablePanel;
    {* Реализация слова скрипта .TcfFolders.ChildZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfFoldersChildZone

 Tkw_Form_Folders = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Folders
----
*Пример использования*:
[code]форма::Folders TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Folders

 Tkw_Folders_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_BackgroundPanel

 Tkw_Folders_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_BackgroundPanel_Push

 Tkw_Folders_Control_ParentZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]контрол::ParentZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_ParentZone

 Tkw_Folders_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]контрол::ParentZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_ParentZone_Push

 Tkw_Folders_Control_ChildZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZone
----
*Пример использования*:
[code]контрол::ChildZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_ChildZone

 Tkw_Folders_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]контрол::ChildZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_ChildZone_Push

function TkwCfFoldersBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 acfFolders: TcfFolders): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfFolders.BackgroundPanel }
begin
 Result := acfFolders.BackgroundPanel;
end;//TkwCfFoldersBackgroundPanel.BackgroundPanel

class function TkwCfFoldersBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFolders.BackgroundPanel';
end;//TkwCfFoldersBackgroundPanel.GetWordNameForRegister

function TkwCfFoldersBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfFoldersBackgroundPanel.GetResultTypeInfo

function TkwCfFoldersBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfFoldersBackgroundPanel.GetAllParamsCount

function TkwCfFoldersBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFolders)]);
end;//TkwCfFoldersBackgroundPanel.ParamsTypes

procedure TkwCfFoldersBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwCfFoldersBackgroundPanel.SetValuePrim

procedure TkwCfFoldersBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_acfFolders: TcfFolders;
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
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_acfFolders));
end;//TkwCfFoldersBackgroundPanel.DoDoIt

function TkwCfFoldersParentZone.ParentZone(const aCtx: TtfwContext;
 acfFolders: TcfFolders): TvtPanel;
 {* Реализация слова скрипта .TcfFolders.ParentZone }
begin
 Result := acfFolders.ParentZone;
end;//TkwCfFoldersParentZone.ParentZone

class function TkwCfFoldersParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFolders.ParentZone';
end;//TkwCfFoldersParentZone.GetWordNameForRegister

function TkwCfFoldersParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfFoldersParentZone.GetResultTypeInfo

function TkwCfFoldersParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfFoldersParentZone.GetAllParamsCount

function TkwCfFoldersParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFolders)]);
end;//TkwCfFoldersParentZone.ParamsTypes

procedure TkwCfFoldersParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZone', aCtx);
end;//TkwCfFoldersParentZone.SetValuePrim

procedure TkwCfFoldersParentZone.DoDoIt(const aCtx: TtfwContext);
var l_acfFolders: TcfFolders;
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
 aCtx.rEngine.PushObj(ParentZone(aCtx, l_acfFolders));
end;//TkwCfFoldersParentZone.DoDoIt

function TkwCfFoldersChildZone.ChildZone(const aCtx: TtfwContext;
 acfFolders: TcfFolders): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfFolders.ChildZone }
begin
 Result := acfFolders.ChildZone;
end;//TkwCfFoldersChildZone.ChildZone

class function TkwCfFoldersChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFolders.ChildZone';
end;//TkwCfFoldersChildZone.GetWordNameForRegister

function TkwCfFoldersChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfFoldersChildZone.GetResultTypeInfo

function TkwCfFoldersChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfFoldersChildZone.GetAllParamsCount

function TkwCfFoldersChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFolders)]);
end;//TkwCfFoldersChildZone.ParamsTypes

procedure TkwCfFoldersChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZone', aCtx);
end;//TkwCfFoldersChildZone.SetValuePrim

procedure TkwCfFoldersChildZone.DoDoIt(const aCtx: TtfwContext);
var l_acfFolders: TcfFolders;
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
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_acfFolders));
end;//TkwCfFoldersChildZone.DoDoIt

function Tkw_Form_Folders.GetString: AnsiString;
begin
 Result := 'cfFolders';
end;//Tkw_Form_Folders.GetString

class procedure Tkw_Form_Folders.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TcfFolders);
end;//Tkw_Form_Folders.RegisterInEngine

class function Tkw_Form_Folders.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Folders';
end;//Tkw_Form_Folders.GetWordNameForRegister

function Tkw_Folders_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_Folders_Control_BackgroundPanel.GetString

class procedure Tkw_Folders_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_Folders_Control_BackgroundPanel.RegisterInEngine

class function Tkw_Folders_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Folders_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_Folders_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Folders_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Folders_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Folders_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_Folders_Control_ParentZone.GetString: AnsiString;
begin
 Result := 'ParentZone';
end;//Tkw_Folders_Control_ParentZone.GetString

class procedure Tkw_Folders_Control_ParentZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Folders_Control_ParentZone.RegisterInEngine

class function Tkw_Folders_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone';
end;//Tkw_Folders_Control_ParentZone.GetWordNameForRegister

procedure Tkw_Folders_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_Folders_Control_ParentZone_Push.DoDoIt

class function Tkw_Folders_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_Folders_Control_ParentZone_Push.GetWordNameForRegister

function Tkw_Folders_Control_ChildZone.GetString: AnsiString;
begin
 Result := 'ChildZone';
end;//Tkw_Folders_Control_ChildZone.GetString

class procedure Tkw_Folders_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_Folders_Control_ChildZone.RegisterInEngine

class function Tkw_Folders_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone';
end;//Tkw_Folders_Control_ChildZone.GetWordNameForRegister

procedure Tkw_Folders_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_Folders_Control_ChildZone_Push.DoDoIt

class function Tkw_Folders_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_Folders_Control_ChildZone_Push.GetWordNameForRegister

initialization
 TkwCfFoldersBackgroundPanel.RegisterInEngine;
 {* Регистрация cfFolders_BackgroundPanel }
 TkwCfFoldersParentZone.RegisterInEngine;
 {* Регистрация cfFolders_ParentZone }
 TkwCfFoldersChildZone.RegisterInEngine;
 {* Регистрация cfFolders_ChildZone }
 Tkw_Form_Folders.RegisterInEngine;
 {* Регистрация Tkw_Form_Folders }
 Tkw_Folders_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_Folders_Control_BackgroundPanel }
 Tkw_Folders_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_Folders_Control_BackgroundPanel_Push }
 Tkw_Folders_Control_ParentZone.RegisterInEngine;
 {* Регистрация Tkw_Folders_Control_ParentZone }
 Tkw_Folders_Control_ParentZone_Push.RegisterInEngine;
 {* Регистрация Tkw_Folders_Control_ParentZone_Push }
 Tkw_Folders_Control_ChildZone.RegisterInEngine;
 {* Регистрация Tkw_Folders_Control_ChildZone }
 Tkw_Folders_Control_ChildZone_Push.RegisterInEngine;
 {* Регистрация Tkw_Folders_Control_ChildZone_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfFolders));
 {* Регистрация типа TcfFolders }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
