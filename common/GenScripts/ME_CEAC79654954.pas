unit FoldersKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Folders }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimFolders_Module
 , vtProportionalPanel
 , vtPanel
 , vtSizeablePanel
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Folders = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Folders
----
*Пример использования*:
[code]
'aControl' форма::Folders TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Folders

 Tkw_Folders_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Folders_Control_BackgroundPanel

 Tkw_Folders_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_BackgroundPanel_Push

 Tkw_Folders_Control_ParentZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Folders_Control_ParentZone

 Tkw_Folders_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_ParentZone_Push

 Tkw_Folders_Control_ChildZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Folders_Control_ChildZone

 Tkw_Folders_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_ChildZone_Push

 TkwCfFoldersBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfFolders.BackgroundPanel
[panel]Контрол BackgroundPanel формы TcfFolders[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfFolders .TcfFolders.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    acfFolders: TcfFolders): TvtProportionalPanel;
    {* Реализация слова скрипта .TcfFolders.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfFoldersBackgroundPanel

 TkwCfFoldersParentZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfFolders.ParentZone
[panel]Контрол ParentZone формы TcfFolders[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfFolders .TcfFolders.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    acfFolders: TcfFolders): TvtPanel;
    {* Реализация слова скрипта .TcfFolders.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfFoldersParentZone

 TkwCfFoldersChildZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfFolders.ChildZone
[panel]Контрол ChildZone формы TcfFolders[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfFolders .TcfFolders.ChildZone >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    acfFolders: TcfFolders): TvtSizeablePanel;
    {* Реализация слова скрипта .TcfFolders.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfFoldersChildZone

class function Tkw_Form_Folders.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Folders';
end;//Tkw_Form_Folders.GetWordNameForRegister

function Tkw_Form_Folders.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_64DF2498465B_var*
//#UC END# *4DDFD2EA0116_64DF2498465B_var*
begin
//#UC START# *4DDFD2EA0116_64DF2498465B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_64DF2498465B_impl*
end;//Tkw_Form_Folders.GetString

class function Tkw_Folders_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Folders_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Folders_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9008088480A5_var*
//#UC END# *4DDFD2EA0116_9008088480A5_var*
begin
//#UC START# *4DDFD2EA0116_9008088480A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9008088480A5_impl*
end;//Tkw_Folders_Control_BackgroundPanel.GetString

class procedure Tkw_Folders_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_9008088480A5_var*
//#UC END# *52A086150180_9008088480A5_var*
begin
//#UC START# *52A086150180_9008088480A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9008088480A5_impl*
end;//Tkw_Folders_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_Folders_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D50BB6D30706_var*
//#UC END# *4DAEEDE10285_D50BB6D30706_var*
begin
//#UC START# *4DAEEDE10285_D50BB6D30706_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D50BB6D30706_impl*
end;//Tkw_Folders_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Folders_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Folders_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_Folders_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone';
end;//Tkw_Folders_Control_ParentZone.GetWordNameForRegister

function Tkw_Folders_Control_ParentZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5C6E9AFBE6B4_var*
//#UC END# *4DDFD2EA0116_5C6E9AFBE6B4_var*
begin
//#UC START# *4DDFD2EA0116_5C6E9AFBE6B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5C6E9AFBE6B4_impl*
end;//Tkw_Folders_Control_ParentZone.GetString

class procedure Tkw_Folders_Control_ParentZone.RegisterInEngine;
//#UC START# *52A086150180_5C6E9AFBE6B4_var*
//#UC END# *52A086150180_5C6E9AFBE6B4_var*
begin
//#UC START# *52A086150180_5C6E9AFBE6B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5C6E9AFBE6B4_impl*
end;//Tkw_Folders_Control_ParentZone.RegisterInEngine

procedure Tkw_Folders_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A985D73A233D_var*
//#UC END# *4DAEEDE10285_A985D73A233D_var*
begin
//#UC START# *4DAEEDE10285_A985D73A233D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A985D73A233D_impl*
end;//Tkw_Folders_Control_ParentZone_Push.DoDoIt

class function Tkw_Folders_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_Folders_Control_ParentZone_Push.GetWordNameForRegister

class function Tkw_Folders_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone';
end;//Tkw_Folders_Control_ChildZone.GetWordNameForRegister

function Tkw_Folders_Control_ChildZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_ECE6DC4E86F3_var*
//#UC END# *4DDFD2EA0116_ECE6DC4E86F3_var*
begin
//#UC START# *4DDFD2EA0116_ECE6DC4E86F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_ECE6DC4E86F3_impl*
end;//Tkw_Folders_Control_ChildZone.GetString

class procedure Tkw_Folders_Control_ChildZone.RegisterInEngine;
//#UC START# *52A086150180_ECE6DC4E86F3_var*
//#UC END# *52A086150180_ECE6DC4E86F3_var*
begin
//#UC START# *52A086150180_ECE6DC4E86F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_ECE6DC4E86F3_impl*
end;//Tkw_Folders_Control_ChildZone.RegisterInEngine

procedure Tkw_Folders_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F111B358F604_var*
//#UC END# *4DAEEDE10285_F111B358F604_var*
begin
//#UC START# *4DAEEDE10285_F111B358F604_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F111B358F604_impl*
end;//Tkw_Folders_Control_ChildZone_Push.DoDoIt

class function Tkw_Folders_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_Folders_Control_ChildZone_Push.GetWordNameForRegister

function TkwCfFoldersBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 acfFolders: TcfFolders): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfFolders.BackgroundPanel }
//#UC START# *FCFB8C9049EC_5C9B2EC425D0_var*
//#UC END# *FCFB8C9049EC_5C9B2EC425D0_var*
begin
//#UC START# *FCFB8C9049EC_5C9B2EC425D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *FCFB8C9049EC_5C9B2EC425D0_impl*
end;//TkwCfFoldersBackgroundPanel.BackgroundPanel

procedure TkwCfFoldersBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5C9B2EC425D0_var*
//#UC END# *4DAEEDE10285_5C9B2EC425D0_var*
begin
//#UC START# *4DAEEDE10285_5C9B2EC425D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5C9B2EC425D0_impl*
end;//TkwCfFoldersBackgroundPanel.DoDoIt

class function TkwCfFoldersBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFolders.BackgroundPanel';
end;//TkwCfFoldersBackgroundPanel.GetWordNameForRegister

procedure TkwCfFoldersBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5C9B2EC425D0_var*
//#UC END# *52D00B00031A_5C9B2EC425D0_var*
begin
//#UC START# *52D00B00031A_5C9B2EC425D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5C9B2EC425D0_impl*
end;//TkwCfFoldersBackgroundPanel.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwCfFoldersBackgroundPanel.ParamsTypes

function TkwCfFoldersParentZone.ParentZone(const aCtx: TtfwContext;
 acfFolders: TcfFolders): TvtPanel;
 {* Реализация слова скрипта .TcfFolders.ParentZone }
//#UC START# *EBD9DA827D34_5C121167A7CC_var*
//#UC END# *EBD9DA827D34_5C121167A7CC_var*
begin
//#UC START# *EBD9DA827D34_5C121167A7CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *EBD9DA827D34_5C121167A7CC_impl*
end;//TkwCfFoldersParentZone.ParentZone

procedure TkwCfFoldersParentZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5C121167A7CC_var*
//#UC END# *4DAEEDE10285_5C121167A7CC_var*
begin
//#UC START# *4DAEEDE10285_5C121167A7CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5C121167A7CC_impl*
end;//TkwCfFoldersParentZone.DoDoIt

class function TkwCfFoldersParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFolders.ParentZone';
end;//TkwCfFoldersParentZone.GetWordNameForRegister

procedure TkwCfFoldersParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5C121167A7CC_var*
//#UC END# *52D00B00031A_5C121167A7CC_var*
begin
//#UC START# *52D00B00031A_5C121167A7CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5C121167A7CC_impl*
end;//TkwCfFoldersParentZone.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwCfFoldersParentZone.ParamsTypes

function TkwCfFoldersChildZone.ChildZone(const aCtx: TtfwContext;
 acfFolders: TcfFolders): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfFolders.ChildZone }
//#UC START# *794F35185E56_D0B699F2B747_var*
//#UC END# *794F35185E56_D0B699F2B747_var*
begin
//#UC START# *794F35185E56_D0B699F2B747_impl*
 !!! Needs to be implemented !!!
//#UC END# *794F35185E56_D0B699F2B747_impl*
end;//TkwCfFoldersChildZone.ChildZone

procedure TkwCfFoldersChildZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D0B699F2B747_var*
//#UC END# *4DAEEDE10285_D0B699F2B747_var*
begin
//#UC START# *4DAEEDE10285_D0B699F2B747_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D0B699F2B747_impl*
end;//TkwCfFoldersChildZone.DoDoIt

class function TkwCfFoldersChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFolders.ChildZone';
end;//TkwCfFoldersChildZone.GetWordNameForRegister

procedure TkwCfFoldersChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D0B699F2B747_var*
//#UC END# *52D00B00031A_D0B699F2B747_var*
begin
//#UC START# *52D00B00031A_D0B699F2B747_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D0B699F2B747_impl*
end;//TkwCfFoldersChildZone.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwCfFoldersChildZone.ParamsTypes

initialization
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
 TkwCfFoldersBackgroundPanel.RegisterInEngine;
 {* Регистрация cfFolders_BackgroundPanel }
 TkwCfFoldersParentZone.RegisterInEngine;
 {* Регистрация cfFolders_ParentZone }
 TkwCfFoldersChildZone.RegisterInEngine;
 {* Регистрация cfFolders_ChildZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfFolders));
 {* Регистрация типа Folders }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
