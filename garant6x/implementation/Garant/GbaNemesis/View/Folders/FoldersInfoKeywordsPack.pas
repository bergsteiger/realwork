unit FoldersInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы FoldersInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , FoldersInfo_Form
 , vtPanel
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
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
begin
 Result := 'cfFoldersInfo';
end;//Tkw_Form_FoldersInfo.GetString

class function Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone';
end;//Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister

function Tkw_FoldersInfo_Control_ChildZone.GetString: AnsiString;
begin
 Result := 'ChildZone';
end;//Tkw_FoldersInfo_Control_ChildZone.GetString

class procedure Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine

procedure Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt

class function Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister

function TkwCfFoldersInfoChildZone.ChildZone(const aCtx: TtfwContext;
 acfFoldersInfo: TcfFoldersInfo): TvtPanel;
 {* Реализация слова скрипта .TcfFoldersInfo.ChildZone }
begin
 Result := acfFoldersInfo.ChildZone;
end;//TkwCfFoldersInfoChildZone.ChildZone

procedure TkwCfFoldersInfoChildZone.DoDoIt(const aCtx: TtfwContext);
var l_acfFoldersInfo: TcfFoldersInfo;
begin
 try
  l_acfFoldersInfo := TcfFoldersInfo(aCtx.rEngine.PopObjAs(TcfFoldersInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfFoldersInfo: TcfFoldersInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_acfFoldersInfo));
end;//TkwCfFoldersInfoChildZone.DoDoIt

class function TkwCfFoldersInfoChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFoldersInfo.ChildZone';
end;//TkwCfFoldersInfoChildZone.GetWordNameForRegister

procedure TkwCfFoldersInfoChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZone', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TcfFoldersInfo)]);
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
