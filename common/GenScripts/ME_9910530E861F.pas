unit FoldersInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы FoldersInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimFolders_Module
 , vtPanel
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
 Tkw_Form_FoldersInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы FoldersInfo
----
*Пример использования*:
[code]
'aControl' форма::FoldersInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_FoldersInfo

 Tkw_FoldersInfo_Control_ChildZone = {final} class(TtfwControlString)
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
 end;//Tkw_FoldersInfo_Control_ChildZone

 Tkw_FoldersInfo_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersInfo_Control_ChildZone_Push

 TkwCfFoldersInfoChildZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfFoldersInfo.ChildZone
[panel]Контрол ChildZone формы TcfFoldersInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfFoldersInfo .TcfFoldersInfo.ChildZone >>> l_TvtPanel
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    acfFoldersInfo: TcfFoldersInfo): TvtPanel;
    {* Реализация слова скрипта .TcfFoldersInfo.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfFoldersInfoChildZone

class function Tkw_Form_FoldersInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::FoldersInfo';
end;//Tkw_Form_FoldersInfo.GetWordNameForRegister

function Tkw_Form_FoldersInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FA295D6AB419_var*
//#UC END# *4DDFD2EA0116_FA295D6AB419_var*
begin
//#UC START# *4DDFD2EA0116_FA295D6AB419_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FA295D6AB419_impl*
end;//Tkw_Form_FoldersInfo.GetString

class function Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone';
end;//Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister

function Tkw_FoldersInfo_Control_ChildZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D967EB38B5DF_var*
//#UC END# *4DDFD2EA0116_D967EB38B5DF_var*
begin
//#UC START# *4DDFD2EA0116_D967EB38B5DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D967EB38B5DF_impl*
end;//Tkw_FoldersInfo_Control_ChildZone.GetString

class procedure Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine;
//#UC START# *52A086150180_D967EB38B5DF_var*
//#UC END# *52A086150180_D967EB38B5DF_var*
begin
//#UC START# *52A086150180_D967EB38B5DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D967EB38B5DF_impl*
end;//Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine

procedure Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_353880F31000_var*
//#UC END# *4DAEEDE10285_353880F31000_var*
begin
//#UC START# *4DAEEDE10285_353880F31000_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_353880F31000_impl*
end;//Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt

class function Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister

function TkwCfFoldersInfoChildZone.ChildZone(const aCtx: TtfwContext;
 acfFoldersInfo: TcfFoldersInfo): TvtPanel;
 {* Реализация слова скрипта .TcfFoldersInfo.ChildZone }
//#UC START# *FF84C76648AA_7EB92774F605_var*
//#UC END# *FF84C76648AA_7EB92774F605_var*
begin
//#UC START# *FF84C76648AA_7EB92774F605_impl*
 !!! Needs to be implemented !!!
//#UC END# *FF84C76648AA_7EB92774F605_impl*
end;//TkwCfFoldersInfoChildZone.ChildZone

procedure TkwCfFoldersInfoChildZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7EB92774F605_var*
//#UC END# *4DAEEDE10285_7EB92774F605_var*
begin
//#UC START# *4DAEEDE10285_7EB92774F605_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7EB92774F605_impl*
end;//TkwCfFoldersInfoChildZone.DoDoIt

class function TkwCfFoldersInfoChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFoldersInfo.ChildZone';
end;//TkwCfFoldersInfoChildZone.GetWordNameForRegister

procedure TkwCfFoldersInfoChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7EB92774F605_var*
//#UC END# *52D00B00031A_7EB92774F605_var*
begin
//#UC START# *52D00B00031A_7EB92774F605_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7EB92774F605_impl*
end;//TkwCfFoldersInfoChildZone.SetValuePrim

function TkwCfFoldersInfoChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfFoldersInfoChildZone.GetResultTypeInfo

function TkwCfFoldersInfoChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfFoldersInfoChildZone.GetAllParamsCount

function TkwCfFoldersInfoChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCfFoldersInfoChildZone.ParamsTypes

initialization
 Tkw_Form_FoldersInfo.RegisterInEngine;
 {* Регистрация Tkw_Form_FoldersInfo }
 Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine;
 {* Регистрация Tkw_FoldersInfo_Control_ChildZone }
 Tkw_FoldersInfo_Control_ChildZone_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersInfo_Control_ChildZone_Push }
 TkwCfFoldersInfoChildZone.RegisterInEngine;
 {* Регистрация cfFoldersInfo_ChildZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfFoldersInfo));
 {* Регистрация типа FoldersInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
