unit SaveLoadKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы SaveLoad }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\SaveLoadKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "SaveLoadKeywordsPack" MUID: (CEA950D49586)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SaveLoad_Form
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
 Tkw_Form_SaveLoad = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы SaveLoad
----
*Пример использования*:
[code]
'aControl' форма::SaveLoad TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_SaveLoad

 Tkw_SaveLoad_Control_pnHeader = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnHeader
----
*Пример использования*:
[code]
контрол::pnHeader TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_pnHeader

 Tkw_SaveLoad_Control_pnHeader_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pnHeader
----
*Пример использования*:
[code]
контрол::pnHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_pnHeader_Push

 Tkw_SaveLoad_Control_lbHeader = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbHeader
----
*Пример использования*:
[code]
контрол::lbHeader TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_lbHeader

 Tkw_SaveLoad_Control_lbHeader_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола lbHeader
----
*Пример использования*:
[code]
контрол::lbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_lbHeader_Push

 Tkw_SaveLoad_Control_pbHeader = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbHeader
----
*Пример использования*:
[code]
контрол::pbHeader TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_pbHeader

 Tkw_SaveLoad_Control_pbHeader_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pbHeader
----
*Пример использования*:
[code]
контрол::pbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_pbHeader_Push

 Tkw_SaveLoad_Control_ParentZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_ParentZone

 Tkw_SaveLoad_Control_ParentZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SaveLoad_Control_ParentZone_Push

 TkwCfSaveLoadPnHeader = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfSaveLoad.pnHeader
[panel]Контрол pnHeader формы TcfSaveLoad[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfSaveLoad .TcfSaveLoad.pnHeader >>> l_TvtPanel
[code]  }
  private
   function pnHeader(const aCtx: TtfwContext;
    acfSaveLoad: TcfSaveLoad): TvtPanel;
    {* Реализация слова скрипта .TcfSaveLoad.pnHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfSaveLoadPnHeader

 TkwCfSaveLoadLbHeader = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfSaveLoad.lbHeader
[panel]Контрол lbHeader формы TcfSaveLoad[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 acfSaveLoad .TcfSaveLoad.lbHeader >>> l_TvtLabel
[code]  }
  private
   function lbHeader(const aCtx: TtfwContext;
    acfSaveLoad: TcfSaveLoad): TvtLabel;
    {* Реализация слова скрипта .TcfSaveLoad.lbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfSaveLoadLbHeader

 TkwCfSaveLoadPbHeader = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfSaveLoad.pbHeader
[panel]Контрол pbHeader формы TcfSaveLoad[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 acfSaveLoad .TcfSaveLoad.pbHeader >>> l_TPaintBox
[code]  }
  private
   function pbHeader(const aCtx: TtfwContext;
    acfSaveLoad: TcfSaveLoad): TPaintBox;
    {* Реализация слова скрипта .TcfSaveLoad.pbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfSaveLoadPbHeader

 TkwCfSaveLoadParentZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfSaveLoad.ParentZone
[panel]Контрол ParentZone формы TcfSaveLoad[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfSaveLoad .TcfSaveLoad.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    acfSaveLoad: TcfSaveLoad): TvtPanel;
    {* Реализация слова скрипта .TcfSaveLoad.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfSaveLoadParentZone

function Tkw_Form_SaveLoad.GetString: AnsiString;
begin
 Result := 'cfSaveLoad';
end;//Tkw_Form_SaveLoad.GetString

class function Tkw_Form_SaveLoad.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::SaveLoad';
end;//Tkw_Form_SaveLoad.GetWordNameForRegister

function Tkw_SaveLoad_Control_pnHeader.GetString: AnsiString;
begin
 Result := 'pnHeader';
end;//Tkw_SaveLoad_Control_pnHeader.GetString

class procedure Tkw_SaveLoad_Control_pnHeader.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SaveLoad_Control_pnHeader.RegisterInEngine

class function Tkw_SaveLoad_Control_pnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnHeader';
end;//Tkw_SaveLoad_Control_pnHeader.GetWordNameForRegister

procedure Tkw_SaveLoad_Control_pnHeader_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnHeader');
 inherited;
end;//Tkw_SaveLoad_Control_pnHeader_Push.DoDoIt

class function Tkw_SaveLoad_Control_pnHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnHeader:push';
end;//Tkw_SaveLoad_Control_pnHeader_Push.GetWordNameForRegister

function Tkw_SaveLoad_Control_lbHeader.GetString: AnsiString;
begin
 Result := 'lbHeader';
end;//Tkw_SaveLoad_Control_lbHeader.GetString

class procedure Tkw_SaveLoad_Control_lbHeader.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_SaveLoad_Control_lbHeader.RegisterInEngine

class function Tkw_SaveLoad_Control_lbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbHeader';
end;//Tkw_SaveLoad_Control_lbHeader.GetWordNameForRegister

procedure Tkw_SaveLoad_Control_lbHeader_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbHeader');
 inherited;
end;//Tkw_SaveLoad_Control_lbHeader_Push.DoDoIt

class function Tkw_SaveLoad_Control_lbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbHeader:push';
end;//Tkw_SaveLoad_Control_lbHeader_Push.GetWordNameForRegister

function Tkw_SaveLoad_Control_pbHeader.GetString: AnsiString;
begin
 Result := 'pbHeader';
end;//Tkw_SaveLoad_Control_pbHeader.GetString

class procedure Tkw_SaveLoad_Control_pbHeader.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_SaveLoad_Control_pbHeader.RegisterInEngine

class function Tkw_SaveLoad_Control_pbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbHeader';
end;//Tkw_SaveLoad_Control_pbHeader.GetWordNameForRegister

procedure Tkw_SaveLoad_Control_pbHeader_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbHeader');
 inherited;
end;//Tkw_SaveLoad_Control_pbHeader_Push.DoDoIt

class function Tkw_SaveLoad_Control_pbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbHeader:push';
end;//Tkw_SaveLoad_Control_pbHeader_Push.GetWordNameForRegister

function Tkw_SaveLoad_Control_ParentZone.GetString: AnsiString;
begin
 Result := 'ParentZone';
end;//Tkw_SaveLoad_Control_ParentZone.GetString

class procedure Tkw_SaveLoad_Control_ParentZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SaveLoad_Control_ParentZone.RegisterInEngine

class function Tkw_SaveLoad_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone';
end;//Tkw_SaveLoad_Control_ParentZone.GetWordNameForRegister

procedure Tkw_SaveLoad_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_SaveLoad_Control_ParentZone_Push.DoDoIt

class function Tkw_SaveLoad_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_SaveLoad_Control_ParentZone_Push.GetWordNameForRegister

function TkwCfSaveLoadPnHeader.pnHeader(const aCtx: TtfwContext;
 acfSaveLoad: TcfSaveLoad): TvtPanel;
 {* Реализация слова скрипта .TcfSaveLoad.pnHeader }
begin
 Result := acfSaveLoad.pnHeader;
end;//TkwCfSaveLoadPnHeader.pnHeader

procedure TkwCfSaveLoadPnHeader.DoDoIt(const aCtx: TtfwContext);
var l_acfSaveLoad: TcfSaveLoad;
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
 aCtx.rEngine.PushObj(pnHeader(aCtx, l_acfSaveLoad));
end;//TkwCfSaveLoadPnHeader.DoDoIt

procedure TkwCfSaveLoadPnHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnHeader', aCtx);
end;//TkwCfSaveLoadPnHeader.SetValuePrim

function TkwCfSaveLoadPnHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfSaveLoadPnHeader.GetResultTypeInfo

function TkwCfSaveLoadPnHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfSaveLoadPnHeader.GetAllParamsCount

function TkwCfSaveLoadPnHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfSaveLoad)]);
end;//TkwCfSaveLoadPnHeader.ParamsTypes

class function TkwCfSaveLoadPnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfSaveLoad.pnHeader';
end;//TkwCfSaveLoadPnHeader.GetWordNameForRegister

function TkwCfSaveLoadLbHeader.lbHeader(const aCtx: TtfwContext;
 acfSaveLoad: TcfSaveLoad): TvtLabel;
 {* Реализация слова скрипта .TcfSaveLoad.lbHeader }
begin
 Result := acfSaveLoad.lbHeader;
end;//TkwCfSaveLoadLbHeader.lbHeader

procedure TkwCfSaveLoadLbHeader.DoDoIt(const aCtx: TtfwContext);
var l_acfSaveLoad: TcfSaveLoad;
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
 aCtx.rEngine.PushObj(lbHeader(aCtx, l_acfSaveLoad));
end;//TkwCfSaveLoadLbHeader.DoDoIt

procedure TkwCfSaveLoadLbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbHeader', aCtx);
end;//TkwCfSaveLoadLbHeader.SetValuePrim

function TkwCfSaveLoadLbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCfSaveLoadLbHeader.GetResultTypeInfo

function TkwCfSaveLoadLbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfSaveLoadLbHeader.GetAllParamsCount

function TkwCfSaveLoadLbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfSaveLoad)]);
end;//TkwCfSaveLoadLbHeader.ParamsTypes

class function TkwCfSaveLoadLbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfSaveLoad.lbHeader';
end;//TkwCfSaveLoadLbHeader.GetWordNameForRegister

function TkwCfSaveLoadPbHeader.pbHeader(const aCtx: TtfwContext;
 acfSaveLoad: TcfSaveLoad): TPaintBox;
 {* Реализация слова скрипта .TcfSaveLoad.pbHeader }
begin
 Result := acfSaveLoad.pbHeader;
end;//TkwCfSaveLoadPbHeader.pbHeader

procedure TkwCfSaveLoadPbHeader.DoDoIt(const aCtx: TtfwContext);
var l_acfSaveLoad: TcfSaveLoad;
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
 aCtx.rEngine.PushObj(pbHeader(aCtx, l_acfSaveLoad));
end;//TkwCfSaveLoadPbHeader.DoDoIt

procedure TkwCfSaveLoadPbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbHeader', aCtx);
end;//TkwCfSaveLoadPbHeader.SetValuePrim

function TkwCfSaveLoadPbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwCfSaveLoadPbHeader.GetResultTypeInfo

function TkwCfSaveLoadPbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfSaveLoadPbHeader.GetAllParamsCount

function TkwCfSaveLoadPbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfSaveLoad)]);
end;//TkwCfSaveLoadPbHeader.ParamsTypes

class function TkwCfSaveLoadPbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfSaveLoad.pbHeader';
end;//TkwCfSaveLoadPbHeader.GetWordNameForRegister

function TkwCfSaveLoadParentZone.ParentZone(const aCtx: TtfwContext;
 acfSaveLoad: TcfSaveLoad): TvtPanel;
 {* Реализация слова скрипта .TcfSaveLoad.ParentZone }
begin
 Result := acfSaveLoad.ParentZone;
end;//TkwCfSaveLoadParentZone.ParentZone

procedure TkwCfSaveLoadParentZone.DoDoIt(const aCtx: TtfwContext);
var l_acfSaveLoad: TcfSaveLoad;
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
 aCtx.rEngine.PushObj(ParentZone(aCtx, l_acfSaveLoad));
end;//TkwCfSaveLoadParentZone.DoDoIt

procedure TkwCfSaveLoadParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZone', aCtx);
end;//TkwCfSaveLoadParentZone.SetValuePrim

function TkwCfSaveLoadParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfSaveLoadParentZone.GetResultTypeInfo

function TkwCfSaveLoadParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfSaveLoadParentZone.GetAllParamsCount

function TkwCfSaveLoadParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfSaveLoad)]);
end;//TkwCfSaveLoadParentZone.ParamsTypes

class function TkwCfSaveLoadParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfSaveLoad.ParentZone';
end;//TkwCfSaveLoadParentZone.GetWordNameForRegister

initialization
 Tkw_Form_SaveLoad.RegisterInEngine;
 {* Регистрация Tkw_Form_SaveLoad }
 Tkw_SaveLoad_Control_pnHeader.RegisterInEngine;
 {* Регистрация Tkw_SaveLoad_Control_pnHeader }
 Tkw_SaveLoad_Control_pnHeader_Push.RegisterInEngine;
 {* Регистрация Tkw_SaveLoad_Control_pnHeader_Push }
 Tkw_SaveLoad_Control_lbHeader.RegisterInEngine;
 {* Регистрация Tkw_SaveLoad_Control_lbHeader }
 Tkw_SaveLoad_Control_lbHeader_Push.RegisterInEngine;
 {* Регистрация Tkw_SaveLoad_Control_lbHeader_Push }
 Tkw_SaveLoad_Control_pbHeader.RegisterInEngine;
 {* Регистрация Tkw_SaveLoad_Control_pbHeader }
 Tkw_SaveLoad_Control_pbHeader_Push.RegisterInEngine;
 {* Регистрация Tkw_SaveLoad_Control_pbHeader_Push }
 Tkw_SaveLoad_Control_ParentZone.RegisterInEngine;
 {* Регистрация Tkw_SaveLoad_Control_ParentZone }
 Tkw_SaveLoad_Control_ParentZone_Push.RegisterInEngine;
 {* Регистрация Tkw_SaveLoad_Control_ParentZone_Push }
 TkwCfSaveLoadPnHeader.RegisterInEngine;
 {* Регистрация cfSaveLoad_pnHeader }
 TkwCfSaveLoadLbHeader.RegisterInEngine;
 {* Регистрация cfSaveLoad_lbHeader }
 TkwCfSaveLoadPbHeader.RegisterInEngine;
 {* Регистрация cfSaveLoad_pbHeader }
 TkwCfSaveLoadParentZone.RegisterInEngine;
 {* Регистрация cfSaveLoad_ParentZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfSaveLoad));
 {* Регистрация типа SaveLoad }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
