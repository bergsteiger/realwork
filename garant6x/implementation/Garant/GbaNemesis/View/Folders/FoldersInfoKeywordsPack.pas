unit FoldersInfoKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/FoldersInfoKeywordsPack.pas"
// Начат: 27.08.2009 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFolders$UC::FoldersInfoKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы FoldersInfo
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
  vtPanel,
  FoldersInfo_Form,
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
  Tkw_Form_FoldersInfo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы FoldersInfo
----
*Пример использования*:
[code]
'aControl' форма::FoldersInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_FoldersInfo

// start class Tkw_Form_FoldersInfo

class function Tkw_Form_FoldersInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::FoldersInfo';
end;//Tkw_Form_FoldersInfo.GetWordNameForRegister

function Tkw_Form_FoldersInfo.GetString: AnsiString;
 {-}
begin
 Result := 'cfFoldersInfo';
end;//Tkw_Form_FoldersInfo.GetString

type
  Tkw_FoldersInfo_Control_ChildZone = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_FoldersInfo_Control_ChildZone

// start class Tkw_FoldersInfo_Control_ChildZone

class function Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone';
end;//Tkw_FoldersInfo_Control_ChildZone.GetWordNameForRegister

function Tkw_FoldersInfo_Control_ChildZone.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZone';
end;//Tkw_FoldersInfo_Control_ChildZone.GetString

class procedure Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine

type
  Tkw_FoldersInfo_Control_ChildZone_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_FoldersInfo_Control_ChildZone_Push

// start class Tkw_FoldersInfo_Control_ChildZone_Push

procedure Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_FoldersInfo_Control_ChildZone_Push.DoDoIt

class function Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_FoldersInfo_Control_ChildZone_Push.GetWordNameForRegister

type
  TkwCfFoldersInfoChildZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfFoldersInfo.ChildZone
[panel]Контрол ChildZone формы TcfFoldersInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfFoldersInfo .TcfFoldersInfo.ChildZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ChildZone(const aCtx: TtfwContext;
     acfFoldersInfo: TcfFoldersInfo): TvtPanel;
     {* Реализация слова скрипта .TcfFoldersInfo.ChildZone }
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
  end;//TkwCfFoldersInfoChildZone

// start class TkwCfFoldersInfoChildZone

function TkwCfFoldersInfoChildZone.ChildZone(const aCtx: TtfwContext;
  acfFoldersInfo: TcfFoldersInfo): TvtPanel;
 {-}
begin
 Result := acfFoldersInfo.ChildZone;
end;//TkwCfFoldersInfoChildZone.ChildZone

procedure TkwCfFoldersInfoChildZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfFoldersInfo : TcfFoldersInfo;
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
 aCtx.rEngine.PushObj((ChildZone(aCtx, l_acfFoldersInfo)));
end;//TkwCfFoldersInfoChildZone.DoDoIt

class function TkwCfFoldersInfoChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfFoldersInfo.ChildZone';
end;//TkwCfFoldersInfoChildZone.GetWordNameForRegister

procedure TkwCfFoldersInfoChildZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZone', aCtx);
end;//TkwCfFoldersInfoChildZone.SetValuePrim

function TkwCfFoldersInfoChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfFoldersInfoChildZone.GetResultTypeInfo

function TkwCfFoldersInfoChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfFoldersInfoChildZone.GetAllParamsCount

function TkwCfFoldersInfoChildZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFoldersInfo)]);
end;//TkwCfFoldersInfoChildZone.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_FoldersInfo
 Tkw_Form_FoldersInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersInfo_Control_ChildZone
 Tkw_FoldersInfo_Control_ChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersInfo_Control_ChildZone_Push
 Tkw_FoldersInfo_Control_ChildZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация cfFoldersInfo_ChildZone
 TkwCfFoldersInfoChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа FoldersInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfFoldersInfo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.