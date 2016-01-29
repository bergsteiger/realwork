unit BaseSearchContainerKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/BaseSearchContainerKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::BaseSearch::View::BaseSearch$Module::BaseSearch::BaseSearchContainerKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы BaseSearchContainer
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
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  vtLabel,
  BaseSearchContainer_Form,
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
  Tkw_Form_BaseSearchContainer = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы BaseSearchContainer
----
*Пример использования*:
[code]
'aControl' форма::BaseSearchContainer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_BaseSearchContainer

// start class Tkw_Form_BaseSearchContainer

class function Tkw_Form_BaseSearchContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::BaseSearchContainer';
end;//Tkw_Form_BaseSearchContainer.GetWordNameForRegister

function Tkw_Form_BaseSearchContainer.GetString: AnsiString;
 {-}
begin
 Result := 'BaseSearchContainerForm';
end;//Tkw_Form_BaseSearchContainer.GetString

type
  Tkw_BaseSearchContainer_Control_ChildZone = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_BaseSearchContainer_Control_ChildZone

// start class Tkw_BaseSearchContainer_Control_ChildZone

class function Tkw_BaseSearchContainer_Control_ChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone';
end;//Tkw_BaseSearchContainer_Control_ChildZone.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_ChildZone.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZone';
end;//Tkw_BaseSearchContainer_Control_ChildZone.GetString

class procedure Tkw_BaseSearchContainer_Control_ChildZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_BaseSearchContainer_Control_ChildZone.RegisterInEngine

type
  Tkw_BaseSearchContainer_Control_ChildZone_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_BaseSearchContainer_Control_ChildZone_Push

// start class Tkw_BaseSearchContainer_Control_ChildZone_Push

procedure Tkw_BaseSearchContainer_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_BaseSearchContainer_Control_ChildZone_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_BaseSearchContainer_Control_ChildZone_Push.GetWordNameForRegister

type
  Tkw_BaseSearchContainer_Control_pnHeader = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_BaseSearchContainer_Control_pnHeader

// start class Tkw_BaseSearchContainer_Control_pnHeader

class function Tkw_BaseSearchContainer_Control_pnHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnHeader';
end;//Tkw_BaseSearchContainer_Control_pnHeader.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_pnHeader.GetString: AnsiString;
 {-}
begin
 Result := 'pnHeader';
end;//Tkw_BaseSearchContainer_Control_pnHeader.GetString

class procedure Tkw_BaseSearchContainer_Control_pnHeader.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_BaseSearchContainer_Control_pnHeader.RegisterInEngine

type
  Tkw_BaseSearchContainer_Control_pnHeader_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_BaseSearchContainer_Control_pnHeader_Push

// start class Tkw_BaseSearchContainer_Control_pnHeader_Push

procedure Tkw_BaseSearchContainer_Control_pnHeader_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnHeader');
 inherited;
end;//Tkw_BaseSearchContainer_Control_pnHeader_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_pnHeader_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnHeader:push';
end;//Tkw_BaseSearchContainer_Control_pnHeader_Push.GetWordNameForRegister

type
  Tkw_BaseSearchContainer_Control_lbHeader = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_BaseSearchContainer_Control_lbHeader

// start class Tkw_BaseSearchContainer_Control_lbHeader

class function Tkw_BaseSearchContainer_Control_lbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbHeader';
end;//Tkw_BaseSearchContainer_Control_lbHeader.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_lbHeader.GetString: AnsiString;
 {-}
begin
 Result := 'lbHeader';
end;//Tkw_BaseSearchContainer_Control_lbHeader.GetString

class procedure Tkw_BaseSearchContainer_Control_lbHeader.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_BaseSearchContainer_Control_lbHeader.RegisterInEngine

type
  Tkw_BaseSearchContainer_Control_lbHeader_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_BaseSearchContainer_Control_lbHeader_Push

// start class Tkw_BaseSearchContainer_Control_lbHeader_Push

procedure Tkw_BaseSearchContainer_Control_lbHeader_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbHeader');
 inherited;
end;//Tkw_BaseSearchContainer_Control_lbHeader_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_lbHeader_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbHeader:push';
end;//Tkw_BaseSearchContainer_Control_lbHeader_Push.GetWordNameForRegister

type
  Tkw_BaseSearchContainer_Control_pbHeader = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_BaseSearchContainer_Control_pbHeader

// start class Tkw_BaseSearchContainer_Control_pbHeader

class function Tkw_BaseSearchContainer_Control_pbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbHeader';
end;//Tkw_BaseSearchContainer_Control_pbHeader.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_pbHeader.GetString: AnsiString;
 {-}
begin
 Result := 'pbHeader';
end;//Tkw_BaseSearchContainer_Control_pbHeader.GetString

class procedure Tkw_BaseSearchContainer_Control_pbHeader.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_BaseSearchContainer_Control_pbHeader.RegisterInEngine

type
  Tkw_BaseSearchContainer_Control_pbHeader_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_BaseSearchContainer_Control_pbHeader_Push

// start class Tkw_BaseSearchContainer_Control_pbHeader_Push

procedure Tkw_BaseSearchContainer_Control_pbHeader_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbHeader');
 inherited;
end;//Tkw_BaseSearchContainer_Control_pbHeader_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_pbHeader_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbHeader:push';
end;//Tkw_BaseSearchContainer_Control_pbHeader_Push.GetWordNameForRegister

type
  Tkw_BaseSearchContainer_Control_ParentZone = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_BaseSearchContainer_Control_ParentZone

// start class Tkw_BaseSearchContainer_Control_ParentZone

class function Tkw_BaseSearchContainer_Control_ParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone';
end;//Tkw_BaseSearchContainer_Control_ParentZone.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_ParentZone.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZone';
end;//Tkw_BaseSearchContainer_Control_ParentZone.GetString

class procedure Tkw_BaseSearchContainer_Control_ParentZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_BaseSearchContainer_Control_ParentZone.RegisterInEngine

type
  Tkw_BaseSearchContainer_Control_ParentZone_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_BaseSearchContainer_Control_ParentZone_Push

// start class Tkw_BaseSearchContainer_Control_ParentZone_Push

procedure Tkw_BaseSearchContainer_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_BaseSearchContainer_Control_ParentZone_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_BaseSearchContainer_Control_ParentZone_Push.GetWordNameForRegister

type
  TkwBaseSearchContainerFormChildZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TBaseSearchContainerForm.ChildZone
[panel]Контрол ChildZone формы TBaseSearchContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aBaseSearchContainerForm .TBaseSearchContainerForm.ChildZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ChildZone(const aCtx: TtfwContext;
     aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
     {* Реализация слова скрипта .TBaseSearchContainerForm.ChildZone }
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
  end;//TkwBaseSearchContainerFormChildZone

// start class TkwBaseSearchContainerFormChildZone

function TkwBaseSearchContainerFormChildZone.ChildZone(const aCtx: TtfwContext;
  aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
 {-}
begin
 Result := aBaseSearchContainerForm.ChildZone;
end;//TkwBaseSearchContainerFormChildZone.ChildZone

procedure TkwBaseSearchContainerFormChildZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aBaseSearchContainerForm : TBaseSearchContainerForm;
begin
 try
  l_aBaseSearchContainerForm := TBaseSearchContainerForm(aCtx.rEngine.PopObjAs(TBaseSearchContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aBaseSearchContainerForm: TBaseSearchContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ChildZone(aCtx, l_aBaseSearchContainerForm)));
end;//TkwBaseSearchContainerFormChildZone.DoDoIt

class function TkwBaseSearchContainerFormChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TBaseSearchContainerForm.ChildZone';
end;//TkwBaseSearchContainerFormChildZone.GetWordNameForRegister

procedure TkwBaseSearchContainerFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZone', aCtx);
end;//TkwBaseSearchContainerFormChildZone.SetValuePrim

function TkwBaseSearchContainerFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwBaseSearchContainerFormChildZone.GetResultTypeInfo

function TkwBaseSearchContainerFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwBaseSearchContainerFormChildZone.GetAllParamsCount

function TkwBaseSearchContainerFormChildZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TBaseSearchContainerForm)]);
end;//TkwBaseSearchContainerFormChildZone.ParamsTypes

type
  TkwBaseSearchContainerFormPnHeader = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TBaseSearchContainerForm.pnHeader
[panel]Контрол pnHeader формы TBaseSearchContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aBaseSearchContainerForm .TBaseSearchContainerForm.pnHeader >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnHeader(const aCtx: TtfwContext;
     aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
     {* Реализация слова скрипта .TBaseSearchContainerForm.pnHeader }
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
  end;//TkwBaseSearchContainerFormPnHeader

// start class TkwBaseSearchContainerFormPnHeader

function TkwBaseSearchContainerFormPnHeader.PnHeader(const aCtx: TtfwContext;
  aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
 {-}
begin
 Result := aBaseSearchContainerForm.pnHeader;
end;//TkwBaseSearchContainerFormPnHeader.PnHeader

procedure TkwBaseSearchContainerFormPnHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aBaseSearchContainerForm : TBaseSearchContainerForm;
begin
 try
  l_aBaseSearchContainerForm := TBaseSearchContainerForm(aCtx.rEngine.PopObjAs(TBaseSearchContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aBaseSearchContainerForm: TBaseSearchContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnHeader(aCtx, l_aBaseSearchContainerForm)));
end;//TkwBaseSearchContainerFormPnHeader.DoDoIt

class function TkwBaseSearchContainerFormPnHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TBaseSearchContainerForm.pnHeader';
end;//TkwBaseSearchContainerFormPnHeader.GetWordNameForRegister

procedure TkwBaseSearchContainerFormPnHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnHeader', aCtx);
end;//TkwBaseSearchContainerFormPnHeader.SetValuePrim

function TkwBaseSearchContainerFormPnHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwBaseSearchContainerFormPnHeader.GetResultTypeInfo

function TkwBaseSearchContainerFormPnHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwBaseSearchContainerFormPnHeader.GetAllParamsCount

function TkwBaseSearchContainerFormPnHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TBaseSearchContainerForm)]);
end;//TkwBaseSearchContainerFormPnHeader.ParamsTypes

type
  TkwBaseSearchContainerFormLbHeader = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TBaseSearchContainerForm.lbHeader
[panel]Контрол lbHeader формы TBaseSearchContainerForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aBaseSearchContainerForm .TBaseSearchContainerForm.lbHeader >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LbHeader(const aCtx: TtfwContext;
     aBaseSearchContainerForm: TBaseSearchContainerForm): TvtLabel;
     {* Реализация слова скрипта .TBaseSearchContainerForm.lbHeader }
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
  end;//TkwBaseSearchContainerFormLbHeader

// start class TkwBaseSearchContainerFormLbHeader

function TkwBaseSearchContainerFormLbHeader.LbHeader(const aCtx: TtfwContext;
  aBaseSearchContainerForm: TBaseSearchContainerForm): TvtLabel;
 {-}
begin
 Result := aBaseSearchContainerForm.lbHeader;
end;//TkwBaseSearchContainerFormLbHeader.LbHeader

procedure TkwBaseSearchContainerFormLbHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aBaseSearchContainerForm : TBaseSearchContainerForm;
begin
 try
  l_aBaseSearchContainerForm := TBaseSearchContainerForm(aCtx.rEngine.PopObjAs(TBaseSearchContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aBaseSearchContainerForm: TBaseSearchContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbHeader(aCtx, l_aBaseSearchContainerForm)));
end;//TkwBaseSearchContainerFormLbHeader.DoDoIt

class function TkwBaseSearchContainerFormLbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TBaseSearchContainerForm.lbHeader';
end;//TkwBaseSearchContainerFormLbHeader.GetWordNameForRegister

procedure TkwBaseSearchContainerFormLbHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbHeader', aCtx);
end;//TkwBaseSearchContainerFormLbHeader.SetValuePrim

function TkwBaseSearchContainerFormLbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwBaseSearchContainerFormLbHeader.GetResultTypeInfo

function TkwBaseSearchContainerFormLbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwBaseSearchContainerFormLbHeader.GetAllParamsCount

function TkwBaseSearchContainerFormLbHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TBaseSearchContainerForm)]);
end;//TkwBaseSearchContainerFormLbHeader.ParamsTypes

type
  TkwBaseSearchContainerFormPbHeader = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TBaseSearchContainerForm.pbHeader
[panel]Контрол pbHeader формы TBaseSearchContainerForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aBaseSearchContainerForm .TBaseSearchContainerForm.pbHeader >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbHeader(const aCtx: TtfwContext;
     aBaseSearchContainerForm: TBaseSearchContainerForm): TPaintBox;
     {* Реализация слова скрипта .TBaseSearchContainerForm.pbHeader }
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
  end;//TkwBaseSearchContainerFormPbHeader

// start class TkwBaseSearchContainerFormPbHeader

function TkwBaseSearchContainerFormPbHeader.PbHeader(const aCtx: TtfwContext;
  aBaseSearchContainerForm: TBaseSearchContainerForm): TPaintBox;
 {-}
begin
 Result := aBaseSearchContainerForm.pbHeader;
end;//TkwBaseSearchContainerFormPbHeader.PbHeader

procedure TkwBaseSearchContainerFormPbHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aBaseSearchContainerForm : TBaseSearchContainerForm;
begin
 try
  l_aBaseSearchContainerForm := TBaseSearchContainerForm(aCtx.rEngine.PopObjAs(TBaseSearchContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aBaseSearchContainerForm: TBaseSearchContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbHeader(aCtx, l_aBaseSearchContainerForm)));
end;//TkwBaseSearchContainerFormPbHeader.DoDoIt

class function TkwBaseSearchContainerFormPbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TBaseSearchContainerForm.pbHeader';
end;//TkwBaseSearchContainerFormPbHeader.GetWordNameForRegister

procedure TkwBaseSearchContainerFormPbHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbHeader', aCtx);
end;//TkwBaseSearchContainerFormPbHeader.SetValuePrim

function TkwBaseSearchContainerFormPbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwBaseSearchContainerFormPbHeader.GetResultTypeInfo

function TkwBaseSearchContainerFormPbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwBaseSearchContainerFormPbHeader.GetAllParamsCount

function TkwBaseSearchContainerFormPbHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TBaseSearchContainerForm)]);
end;//TkwBaseSearchContainerFormPbHeader.ParamsTypes

type
  TkwBaseSearchContainerFormParentZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TBaseSearchContainerForm.ParentZone
[panel]Контрол ParentZone формы TBaseSearchContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aBaseSearchContainerForm .TBaseSearchContainerForm.ParentZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ParentZone(const aCtx: TtfwContext;
     aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
     {* Реализация слова скрипта .TBaseSearchContainerForm.ParentZone }
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
  end;//TkwBaseSearchContainerFormParentZone

// start class TkwBaseSearchContainerFormParentZone

function TkwBaseSearchContainerFormParentZone.ParentZone(const aCtx: TtfwContext;
  aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
 {-}
begin
 Result := aBaseSearchContainerForm.ParentZone;
end;//TkwBaseSearchContainerFormParentZone.ParentZone

procedure TkwBaseSearchContainerFormParentZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aBaseSearchContainerForm : TBaseSearchContainerForm;
begin
 try
  l_aBaseSearchContainerForm := TBaseSearchContainerForm(aCtx.rEngine.PopObjAs(TBaseSearchContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aBaseSearchContainerForm: TBaseSearchContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZone(aCtx, l_aBaseSearchContainerForm)));
end;//TkwBaseSearchContainerFormParentZone.DoDoIt

class function TkwBaseSearchContainerFormParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TBaseSearchContainerForm.ParentZone';
end;//TkwBaseSearchContainerFormParentZone.GetWordNameForRegister

procedure TkwBaseSearchContainerFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZone', aCtx);
end;//TkwBaseSearchContainerFormParentZone.SetValuePrim

function TkwBaseSearchContainerFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwBaseSearchContainerFormParentZone.GetResultTypeInfo

function TkwBaseSearchContainerFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwBaseSearchContainerFormParentZone.GetAllParamsCount

function TkwBaseSearchContainerFormParentZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TBaseSearchContainerForm)]);
end;//TkwBaseSearchContainerFormParentZone.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_BaseSearchContainer
 Tkw_Form_BaseSearchContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_ChildZone
 Tkw_BaseSearchContainer_Control_ChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_ChildZone_Push
 Tkw_BaseSearchContainer_Control_ChildZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_pnHeader
 Tkw_BaseSearchContainer_Control_pnHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_pnHeader_Push
 Tkw_BaseSearchContainer_Control_pnHeader_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_lbHeader
 Tkw_BaseSearchContainer_Control_lbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_lbHeader_Push
 Tkw_BaseSearchContainer_Control_lbHeader_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_pbHeader
 Tkw_BaseSearchContainer_Control_pbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_pbHeader_Push
 Tkw_BaseSearchContainer_Control_pbHeader_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_ParentZone
 Tkw_BaseSearchContainer_Control_ParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_BaseSearchContainer_Control_ParentZone_Push
 Tkw_BaseSearchContainer_Control_ParentZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация BaseSearchContainerForm_ChildZone
 TkwBaseSearchContainerFormChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация BaseSearchContainerForm_pnHeader
 TkwBaseSearchContainerFormPnHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация BaseSearchContainerForm_lbHeader
 TkwBaseSearchContainerFormLbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация BaseSearchContainerForm_pbHeader
 TkwBaseSearchContainerFormPbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация BaseSearchContainerForm_ParentZone
 TkwBaseSearchContainerFormParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа BaseSearchContainer
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBaseSearchContainerForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.