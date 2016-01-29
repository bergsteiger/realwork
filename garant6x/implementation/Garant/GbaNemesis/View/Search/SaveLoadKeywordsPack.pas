unit SaveLoadKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/SaveLoadKeywordsPack.pas"
// Начат: 10.09.2009 21:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::SaveLoadKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы SaveLoad
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  SaveLoad_Form,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_SaveLoad = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы SaveLoad
----
*Пример использования*:
[code]
'aControl' форма::SaveLoad TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_SaveLoad

// start class Tkw_Form_SaveLoad

class function Tkw_Form_SaveLoad.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::SaveLoad';
end;//Tkw_Form_SaveLoad.GetWordNameForRegister

function Tkw_Form_SaveLoad.GetString: AnsiString;
 {-}
begin
 Result := 'cfSaveLoad';
end;//Tkw_Form_SaveLoad.GetString

type
  Tkw_SaveLoad_Control_pnHeader = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnHeader
----
*Пример использования*:
[code]
контрол::pnHeader TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SaveLoad_Control_pnHeader

// start class Tkw_SaveLoad_Control_pnHeader

class function Tkw_SaveLoad_Control_pnHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnHeader';
end;//Tkw_SaveLoad_Control_pnHeader.GetWordNameForRegister

function Tkw_SaveLoad_Control_pnHeader.GetString: AnsiString;
 {-}
begin
 Result := 'pnHeader';
end;//Tkw_SaveLoad_Control_pnHeader.GetString

class procedure Tkw_SaveLoad_Control_pnHeader.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SaveLoad_Control_pnHeader.RegisterInEngine

type
  Tkw_SaveLoad_Control_pnHeader_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnHeader
----
*Пример использования*:
[code]
контрол::pnHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SaveLoad_Control_pnHeader_Push

// start class Tkw_SaveLoad_Control_pnHeader_Push

procedure Tkw_SaveLoad_Control_pnHeader_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnHeader');
 inherited;
end;//Tkw_SaveLoad_Control_pnHeader_Push.DoDoIt

class function Tkw_SaveLoad_Control_pnHeader_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnHeader:push';
end;//Tkw_SaveLoad_Control_pnHeader_Push.GetWordNameForRegister

type
  Tkw_SaveLoad_Control_lbHeader = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lbHeader
----
*Пример использования*:
[code]
контрол::lbHeader TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SaveLoad_Control_lbHeader

// start class Tkw_SaveLoad_Control_lbHeader

class function Tkw_SaveLoad_Control_lbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbHeader';
end;//Tkw_SaveLoad_Control_lbHeader.GetWordNameForRegister

function Tkw_SaveLoad_Control_lbHeader.GetString: AnsiString;
 {-}
begin
 Result := 'lbHeader';
end;//Tkw_SaveLoad_Control_lbHeader.GetString

class procedure Tkw_SaveLoad_Control_lbHeader.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SaveLoad_Control_lbHeader.RegisterInEngine

type
  Tkw_SaveLoad_Control_lbHeader_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lbHeader
----
*Пример использования*:
[code]
контрол::lbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SaveLoad_Control_lbHeader_Push

// start class Tkw_SaveLoad_Control_lbHeader_Push

procedure Tkw_SaveLoad_Control_lbHeader_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbHeader');
 inherited;
end;//Tkw_SaveLoad_Control_lbHeader_Push.DoDoIt

class function Tkw_SaveLoad_Control_lbHeader_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbHeader:push';
end;//Tkw_SaveLoad_Control_lbHeader_Push.GetWordNameForRegister

type
  Tkw_SaveLoad_Control_pbHeader = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pbHeader
----
*Пример использования*:
[code]
контрол::pbHeader TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_SaveLoad_Control_pbHeader

// start class Tkw_SaveLoad_Control_pbHeader

class function Tkw_SaveLoad_Control_pbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbHeader';
end;//Tkw_SaveLoad_Control_pbHeader.GetWordNameForRegister

function Tkw_SaveLoad_Control_pbHeader.GetString: AnsiString;
 {-}
begin
 Result := 'pbHeader';
end;//Tkw_SaveLoad_Control_pbHeader.GetString

class procedure Tkw_SaveLoad_Control_pbHeader.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_SaveLoad_Control_pbHeader.RegisterInEngine

type
  Tkw_SaveLoad_Control_pbHeader_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pbHeader
----
*Пример использования*:
[code]
контрол::pbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_SaveLoad_Control_pbHeader_Push

// start class Tkw_SaveLoad_Control_pbHeader_Push

procedure Tkw_SaveLoad_Control_pbHeader_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbHeader');
 inherited;
end;//Tkw_SaveLoad_Control_pbHeader_Push.DoDoIt

class function Tkw_SaveLoad_Control_pbHeader_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbHeader:push';
end;//Tkw_SaveLoad_Control_pbHeader_Push.GetWordNameForRegister

type
  Tkw_SaveLoad_Control_ParentZone = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_SaveLoad_Control_ParentZone

// start class Tkw_SaveLoad_Control_ParentZone

class function Tkw_SaveLoad_Control_ParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone';
end;//Tkw_SaveLoad_Control_ParentZone.GetWordNameForRegister

function Tkw_SaveLoad_Control_ParentZone.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZone';
end;//Tkw_SaveLoad_Control_ParentZone.GetString

class procedure Tkw_SaveLoad_Control_ParentZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SaveLoad_Control_ParentZone.RegisterInEngine

type
  Tkw_SaveLoad_Control_ParentZone_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_SaveLoad_Control_ParentZone_Push

// start class Tkw_SaveLoad_Control_ParentZone_Push

procedure Tkw_SaveLoad_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_SaveLoad_Control_ParentZone_Push.DoDoIt

class function Tkw_SaveLoad_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_SaveLoad_Control_ParentZone_Push.GetWordNameForRegister

type
  TkwCfSaveLoadPnHeader = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfSaveLoad.pnHeader
[panel]Контрол pnHeader формы TcfSaveLoad[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfSaveLoad .TcfSaveLoad.pnHeader >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnHeader(const aCtx: TtfwContext;
     acfSaveLoad: TcfSaveLoad): TvtPanel;
     {* Реализация слова скрипта .TcfSaveLoad.pnHeader }
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
  end;//TkwCfSaveLoadPnHeader

// start class TkwCfSaveLoadPnHeader

function TkwCfSaveLoadPnHeader.PnHeader(const aCtx: TtfwContext;
  acfSaveLoad: TcfSaveLoad): TvtPanel;
 {-}
begin
 Result := acfSaveLoad.pnHeader;
end;//TkwCfSaveLoadPnHeader.PnHeader

procedure TkwCfSaveLoadPnHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfSaveLoad : TcfSaveLoad;
begin
 try
  l_acfSaveLoad := TcfSaveLoad(aCtx.rEngine.PopObjAs(TcfSaveLoad));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfSaveLoad: TcfSaveLoad : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnHeader(aCtx, l_acfSaveLoad)));
end;//TkwCfSaveLoadPnHeader.DoDoIt

class function TkwCfSaveLoadPnHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfSaveLoad.pnHeader';
end;//TkwCfSaveLoadPnHeader.GetWordNameForRegister

procedure TkwCfSaveLoadPnHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnHeader', aCtx);
end;//TkwCfSaveLoadPnHeader.SetValuePrim

function TkwCfSaveLoadPnHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfSaveLoadPnHeader.GetResultTypeInfo

function TkwCfSaveLoadPnHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfSaveLoadPnHeader.GetAllParamsCount

function TkwCfSaveLoadPnHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfSaveLoad)]);
end;//TkwCfSaveLoadPnHeader.ParamsTypes

type
  TkwCfSaveLoadLbHeader = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfSaveLoad.lbHeader
[panel]Контрол lbHeader формы TcfSaveLoad[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 acfSaveLoad .TcfSaveLoad.lbHeader >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LbHeader(const aCtx: TtfwContext;
     acfSaveLoad: TcfSaveLoad): TvtLabel;
     {* Реализация слова скрипта .TcfSaveLoad.lbHeader }
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
  end;//TkwCfSaveLoadLbHeader

// start class TkwCfSaveLoadLbHeader

function TkwCfSaveLoadLbHeader.LbHeader(const aCtx: TtfwContext;
  acfSaveLoad: TcfSaveLoad): TvtLabel;
 {-}
begin
 Result := acfSaveLoad.lbHeader;
end;//TkwCfSaveLoadLbHeader.LbHeader

procedure TkwCfSaveLoadLbHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfSaveLoad : TcfSaveLoad;
begin
 try
  l_acfSaveLoad := TcfSaveLoad(aCtx.rEngine.PopObjAs(TcfSaveLoad));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfSaveLoad: TcfSaveLoad : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbHeader(aCtx, l_acfSaveLoad)));
end;//TkwCfSaveLoadLbHeader.DoDoIt

class function TkwCfSaveLoadLbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfSaveLoad.lbHeader';
end;//TkwCfSaveLoadLbHeader.GetWordNameForRegister

procedure TkwCfSaveLoadLbHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbHeader', aCtx);
end;//TkwCfSaveLoadLbHeader.SetValuePrim

function TkwCfSaveLoadLbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCfSaveLoadLbHeader.GetResultTypeInfo

function TkwCfSaveLoadLbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfSaveLoadLbHeader.GetAllParamsCount

function TkwCfSaveLoadLbHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfSaveLoad)]);
end;//TkwCfSaveLoadLbHeader.ParamsTypes

type
  TkwCfSaveLoadPbHeader = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfSaveLoad.pbHeader
[panel]Контрол pbHeader формы TcfSaveLoad[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 acfSaveLoad .TcfSaveLoad.pbHeader >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbHeader(const aCtx: TtfwContext;
     acfSaveLoad: TcfSaveLoad): TPaintBox;
     {* Реализация слова скрипта .TcfSaveLoad.pbHeader }
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
  end;//TkwCfSaveLoadPbHeader

// start class TkwCfSaveLoadPbHeader

function TkwCfSaveLoadPbHeader.PbHeader(const aCtx: TtfwContext;
  acfSaveLoad: TcfSaveLoad): TPaintBox;
 {-}
begin
 Result := acfSaveLoad.pbHeader;
end;//TkwCfSaveLoadPbHeader.PbHeader

procedure TkwCfSaveLoadPbHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfSaveLoad : TcfSaveLoad;
begin
 try
  l_acfSaveLoad := TcfSaveLoad(aCtx.rEngine.PopObjAs(TcfSaveLoad));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfSaveLoad: TcfSaveLoad : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbHeader(aCtx, l_acfSaveLoad)));
end;//TkwCfSaveLoadPbHeader.DoDoIt

class function TkwCfSaveLoadPbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfSaveLoad.pbHeader';
end;//TkwCfSaveLoadPbHeader.GetWordNameForRegister

procedure TkwCfSaveLoadPbHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbHeader', aCtx);
end;//TkwCfSaveLoadPbHeader.SetValuePrim

function TkwCfSaveLoadPbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwCfSaveLoadPbHeader.GetResultTypeInfo

function TkwCfSaveLoadPbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfSaveLoadPbHeader.GetAllParamsCount

function TkwCfSaveLoadPbHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfSaveLoad)]);
end;//TkwCfSaveLoadPbHeader.ParamsTypes

type
  TkwCfSaveLoadParentZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TcfSaveLoad.ParentZone
[panel]Контрол ParentZone формы TcfSaveLoad[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfSaveLoad .TcfSaveLoad.ParentZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ParentZone(const aCtx: TtfwContext;
     acfSaveLoad: TcfSaveLoad): TvtPanel;
     {* Реализация слова скрипта .TcfSaveLoad.ParentZone }
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
  end;//TkwCfSaveLoadParentZone

// start class TkwCfSaveLoadParentZone

function TkwCfSaveLoadParentZone.ParentZone(const aCtx: TtfwContext;
  acfSaveLoad: TcfSaveLoad): TvtPanel;
 {-}
begin
 Result := acfSaveLoad.ParentZone;
end;//TkwCfSaveLoadParentZone.ParentZone

procedure TkwCfSaveLoadParentZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfSaveLoad : TcfSaveLoad;
begin
 try
  l_acfSaveLoad := TcfSaveLoad(aCtx.rEngine.PopObjAs(TcfSaveLoad));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfSaveLoad: TcfSaveLoad : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZone(aCtx, l_acfSaveLoad)));
end;//TkwCfSaveLoadParentZone.DoDoIt

class function TkwCfSaveLoadParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfSaveLoad.ParentZone';
end;//TkwCfSaveLoadParentZone.GetWordNameForRegister

procedure TkwCfSaveLoadParentZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZone', aCtx);
end;//TkwCfSaveLoadParentZone.SetValuePrim

function TkwCfSaveLoadParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfSaveLoadParentZone.GetResultTypeInfo

function TkwCfSaveLoadParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfSaveLoadParentZone.GetAllParamsCount

function TkwCfSaveLoadParentZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfSaveLoad)]);
end;//TkwCfSaveLoadParentZone.ParamsTypes
{$IfEnd} //not Admin AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_SaveLoad
 Tkw_Form_SaveLoad.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_SaveLoad_Control_pnHeader
 Tkw_SaveLoad_Control_pnHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_SaveLoad_Control_pnHeader_Push
 Tkw_SaveLoad_Control_pnHeader_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_SaveLoad_Control_lbHeader
 Tkw_SaveLoad_Control_lbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_SaveLoad_Control_lbHeader_Push
 Tkw_SaveLoad_Control_lbHeader_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_SaveLoad_Control_pbHeader
 Tkw_SaveLoad_Control_pbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_SaveLoad_Control_pbHeader_Push
 Tkw_SaveLoad_Control_pbHeader_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_SaveLoad_Control_ParentZone
 Tkw_SaveLoad_Control_ParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_SaveLoad_Control_ParentZone_Push
 Tkw_SaveLoad_Control_ParentZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация cfSaveLoad_pnHeader
 TkwCfSaveLoadPnHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация cfSaveLoad_lbHeader
 TkwCfSaveLoadLbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация cfSaveLoad_pbHeader
 TkwCfSaveLoadPbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация cfSaveLoad_ParentZone
 TkwCfSaveLoadParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа SaveLoad
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfSaveLoad));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not NoScripts

end.