unit DictionContainerKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/DictionContainerKeywordsPack.pas"
// Начат: 01.09.2009 13:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Встроенные продукты::Diction::View::Diction::Diction$FP::DictionContainerKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы DictionContainer
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
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  vtLabel,
  DictionContainer_Form,
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
  Tkw_Form_DictionContainer = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы DictionContainer
----
*Пример использования*:
[code]
'aControl' форма::DictionContainer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_DictionContainer

// start class Tkw_Form_DictionContainer

class function Tkw_Form_DictionContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::DictionContainer';
end;//Tkw_Form_DictionContainer.GetWordNameForRegister

function Tkw_Form_DictionContainer.GetString: AnsiString;
 {-}
begin
 Result := 'DictionContainerForm';
end;//Tkw_Form_DictionContainer.GetString

type
  Tkw_DictionContainer_Control_pnBackground = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnBackground
----
*Пример использования*:
[code]
контрол::pnBackground TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DictionContainer_Control_pnBackground

// start class Tkw_DictionContainer_Control_pnBackground

class function Tkw_DictionContainer_Control_pnBackground.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnBackground';
end;//Tkw_DictionContainer_Control_pnBackground.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnBackground.GetString: AnsiString;
 {-}
begin
 Result := 'pnBackground';
end;//Tkw_DictionContainer_Control_pnBackground.GetString

class procedure Tkw_DictionContainer_Control_pnBackground.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_DictionContainer_Control_pnBackground.RegisterInEngine

type
  Tkw_DictionContainer_Control_pnBackground_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnBackground
----
*Пример использования*:
[code]
контрол::pnBackground:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DictionContainer_Control_pnBackground_Push

// start class Tkw_DictionContainer_Control_pnBackground_Push

procedure Tkw_DictionContainer_Control_pnBackground_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnBackground');
 inherited;
end;//Tkw_DictionContainer_Control_pnBackground_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnBackground_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnBackground:push';
end;//Tkw_DictionContainer_Control_pnBackground_Push.GetWordNameForRegister

type
  Tkw_DictionContainer_Control_NavigatorZone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола NavigatorZone
----
*Пример использования*:
[code]
контрол::NavigatorZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DictionContainer_Control_NavigatorZone

// start class Tkw_DictionContainer_Control_NavigatorZone

class function Tkw_DictionContainer_Control_NavigatorZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NavigatorZone';
end;//Tkw_DictionContainer_Control_NavigatorZone.GetWordNameForRegister

function Tkw_DictionContainer_Control_NavigatorZone.GetString: AnsiString;
 {-}
begin
 Result := 'NavigatorZone';
end;//Tkw_DictionContainer_Control_NavigatorZone.GetString

class procedure Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine

type
  Tkw_DictionContainer_Control_NavigatorZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола NavigatorZone
----
*Пример использования*:
[code]
контрол::NavigatorZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DictionContainer_Control_NavigatorZone_Push

// start class Tkw_DictionContainer_Control_NavigatorZone_Push

procedure Tkw_DictionContainer_Control_NavigatorZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NavigatorZone');
 inherited;
end;//Tkw_DictionContainer_Control_NavigatorZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_NavigatorZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NavigatorZone:push';
end;//Tkw_DictionContainer_Control_NavigatorZone_Push.GetWordNameForRegister

type
  Tkw_DictionContainer_Control_pnWorkArea = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnWorkArea
----
*Пример использования*:
[code]
контрол::pnWorkArea TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_DictionContainer_Control_pnWorkArea

// start class Tkw_DictionContainer_Control_pnWorkArea

class function Tkw_DictionContainer_Control_pnWorkArea.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnWorkArea';
end;//Tkw_DictionContainer_Control_pnWorkArea.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnWorkArea.GetString: AnsiString;
 {-}
begin
 Result := 'pnWorkArea';
end;//Tkw_DictionContainer_Control_pnWorkArea.GetString

class procedure Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine

type
  Tkw_DictionContainer_Control_pnWorkArea_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnWorkArea
----
*Пример использования*:
[code]
контрол::pnWorkArea:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_DictionContainer_Control_pnWorkArea_Push

// start class Tkw_DictionContainer_Control_pnWorkArea_Push

procedure Tkw_DictionContainer_Control_pnWorkArea_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnWorkArea');
 inherited;
end;//Tkw_DictionContainer_Control_pnWorkArea_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnWorkArea_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnWorkArea:push';
end;//Tkw_DictionContainer_Control_pnWorkArea_Push.GetWordNameForRegister

type
  Tkw_DictionContainer_Control_ChildZone = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_DictionContainer_Control_ChildZone

// start class Tkw_DictionContainer_Control_ChildZone

class function Tkw_DictionContainer_Control_ChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone';
end;//Tkw_DictionContainer_Control_ChildZone.GetWordNameForRegister

function Tkw_DictionContainer_Control_ChildZone.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZone';
end;//Tkw_DictionContainer_Control_ChildZone.GetString

class procedure Tkw_DictionContainer_Control_ChildZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_DictionContainer_Control_ChildZone.RegisterInEngine

type
  Tkw_DictionContainer_Control_ChildZone_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_DictionContainer_Control_ChildZone_Push

// start class Tkw_DictionContainer_Control_ChildZone_Push

procedure Tkw_DictionContainer_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_DictionContainer_Control_ChildZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_DictionContainer_Control_ChildZone_Push.GetWordNameForRegister

type
  Tkw_DictionContainer_Control_pnHeader = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_DictionContainer_Control_pnHeader

// start class Tkw_DictionContainer_Control_pnHeader

class function Tkw_DictionContainer_Control_pnHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnHeader';
end;//Tkw_DictionContainer_Control_pnHeader.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnHeader.GetString: AnsiString;
 {-}
begin
 Result := 'pnHeader';
end;//Tkw_DictionContainer_Control_pnHeader.GetString

class procedure Tkw_DictionContainer_Control_pnHeader.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_DictionContainer_Control_pnHeader.RegisterInEngine

type
  Tkw_DictionContainer_Control_pnHeader_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_DictionContainer_Control_pnHeader_Push

// start class Tkw_DictionContainer_Control_pnHeader_Push

procedure Tkw_DictionContainer_Control_pnHeader_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnHeader');
 inherited;
end;//Tkw_DictionContainer_Control_pnHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnHeader_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnHeader:push';
end;//Tkw_DictionContainer_Control_pnHeader_Push.GetWordNameForRegister

type
  Tkw_DictionContainer_Control_lbHeader = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_DictionContainer_Control_lbHeader

// start class Tkw_DictionContainer_Control_lbHeader

class function Tkw_DictionContainer_Control_lbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbHeader';
end;//Tkw_DictionContainer_Control_lbHeader.GetWordNameForRegister

function Tkw_DictionContainer_Control_lbHeader.GetString: AnsiString;
 {-}
begin
 Result := 'lbHeader';
end;//Tkw_DictionContainer_Control_lbHeader.GetString

class procedure Tkw_DictionContainer_Control_lbHeader.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DictionContainer_Control_lbHeader.RegisterInEngine

type
  Tkw_DictionContainer_Control_lbHeader_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_DictionContainer_Control_lbHeader_Push

// start class Tkw_DictionContainer_Control_lbHeader_Push

procedure Tkw_DictionContainer_Control_lbHeader_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbHeader');
 inherited;
end;//Tkw_DictionContainer_Control_lbHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_lbHeader_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbHeader:push';
end;//Tkw_DictionContainer_Control_lbHeader_Push.GetWordNameForRegister

type
  Tkw_DictionContainer_Control_pbHeader = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_DictionContainer_Control_pbHeader

// start class Tkw_DictionContainer_Control_pbHeader

class function Tkw_DictionContainer_Control_pbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbHeader';
end;//Tkw_DictionContainer_Control_pbHeader.GetWordNameForRegister

function Tkw_DictionContainer_Control_pbHeader.GetString: AnsiString;
 {-}
begin
 Result := 'pbHeader';
end;//Tkw_DictionContainer_Control_pbHeader.GetString

class procedure Tkw_DictionContainer_Control_pbHeader.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_DictionContainer_Control_pbHeader.RegisterInEngine

type
  Tkw_DictionContainer_Control_pbHeader_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_DictionContainer_Control_pbHeader_Push

// start class Tkw_DictionContainer_Control_pbHeader_Push

procedure Tkw_DictionContainer_Control_pbHeader_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbHeader');
 inherited;
end;//Tkw_DictionContainer_Control_pbHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_pbHeader_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbHeader:push';
end;//Tkw_DictionContainer_Control_pbHeader_Push.GetWordNameForRegister

type
  Tkw_DictionContainer_Control_ParentZone = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_DictionContainer_Control_ParentZone

// start class Tkw_DictionContainer_Control_ParentZone

class function Tkw_DictionContainer_Control_ParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone';
end;//Tkw_DictionContainer_Control_ParentZone.GetWordNameForRegister

function Tkw_DictionContainer_Control_ParentZone.GetString: AnsiString;
 {-}
begin
 Result := 'ParentZone';
end;//Tkw_DictionContainer_Control_ParentZone.GetString

class procedure Tkw_DictionContainer_Control_ParentZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_DictionContainer_Control_ParentZone.RegisterInEngine

type
  Tkw_DictionContainer_Control_ParentZone_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_DictionContainer_Control_ParentZone_Push

// start class Tkw_DictionContainer_Control_ParentZone_Push

procedure Tkw_DictionContainer_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_DictionContainer_Control_ParentZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_DictionContainer_Control_ParentZone_Push.GetWordNameForRegister

type
  TkwDictionContainerFormPnBackground = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDictionContainerForm.pnBackground
[panel]Контрол pnBackground формы TDictionContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aDictionContainerForm .TDictionContainerForm.pnBackground >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function PnBackground(const aCtx: TtfwContext;
     aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TDictionContainerForm.pnBackground }
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
  end;//TkwDictionContainerFormPnBackground

// start class TkwDictionContainerFormPnBackground

function TkwDictionContainerFormPnBackground.PnBackground(const aCtx: TtfwContext;
  aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
 {-}
begin
 Result := aDictionContainerForm.pnBackground;
end;//TkwDictionContainerFormPnBackground.PnBackground

procedure TkwDictionContainerFormPnBackground.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionContainerForm : TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnBackground(aCtx, l_aDictionContainerForm)));
end;//TkwDictionContainerFormPnBackground.DoDoIt

class function TkwDictionContainerFormPnBackground.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDictionContainerForm.pnBackground';
end;//TkwDictionContainerFormPnBackground.GetWordNameForRegister

procedure TkwDictionContainerFormPnBackground.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnBackground', aCtx);
end;//TkwDictionContainerFormPnBackground.SetValuePrim

function TkwDictionContainerFormPnBackground.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwDictionContainerFormPnBackground.GetResultTypeInfo

function TkwDictionContainerFormPnBackground.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDictionContainerFormPnBackground.GetAllParamsCount

function TkwDictionContainerFormPnBackground.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPnBackground.ParamsTypes

type
  TkwDictionContainerFormNavigatorZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDictionContainerForm.NavigatorZone
[panel]Контрол NavigatorZone формы TDictionContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aDictionContainerForm .TDictionContainerForm.NavigatorZone >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function NavigatorZone(const aCtx: TtfwContext;
     aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TDictionContainerForm.NavigatorZone }
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
  end;//TkwDictionContainerFormNavigatorZone

// start class TkwDictionContainerFormNavigatorZone

function TkwDictionContainerFormNavigatorZone.NavigatorZone(const aCtx: TtfwContext;
  aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
 {-}
begin
 Result := aDictionContainerForm.NavigatorZone;
end;//TkwDictionContainerFormNavigatorZone.NavigatorZone

procedure TkwDictionContainerFormNavigatorZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionContainerForm : TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NavigatorZone(aCtx, l_aDictionContainerForm)));
end;//TkwDictionContainerFormNavigatorZone.DoDoIt

class function TkwDictionContainerFormNavigatorZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDictionContainerForm.NavigatorZone';
end;//TkwDictionContainerFormNavigatorZone.GetWordNameForRegister

procedure TkwDictionContainerFormNavigatorZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству NavigatorZone', aCtx);
end;//TkwDictionContainerFormNavigatorZone.SetValuePrim

function TkwDictionContainerFormNavigatorZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwDictionContainerFormNavigatorZone.GetResultTypeInfo

function TkwDictionContainerFormNavigatorZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDictionContainerFormNavigatorZone.GetAllParamsCount

function TkwDictionContainerFormNavigatorZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormNavigatorZone.ParamsTypes

type
  TkwDictionContainerFormPnWorkArea = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDictionContainerForm.pnWorkArea
[panel]Контрол pnWorkArea формы TDictionContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aDictionContainerForm .TDictionContainerForm.pnWorkArea >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function PnWorkArea(const aCtx: TtfwContext;
     aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TDictionContainerForm.pnWorkArea }
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
  end;//TkwDictionContainerFormPnWorkArea

// start class TkwDictionContainerFormPnWorkArea

function TkwDictionContainerFormPnWorkArea.PnWorkArea(const aCtx: TtfwContext;
  aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
 {-}
begin
 Result := aDictionContainerForm.pnWorkArea;
end;//TkwDictionContainerFormPnWorkArea.PnWorkArea

procedure TkwDictionContainerFormPnWorkArea.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionContainerForm : TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnWorkArea(aCtx, l_aDictionContainerForm)));
end;//TkwDictionContainerFormPnWorkArea.DoDoIt

class function TkwDictionContainerFormPnWorkArea.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDictionContainerForm.pnWorkArea';
end;//TkwDictionContainerFormPnWorkArea.GetWordNameForRegister

procedure TkwDictionContainerFormPnWorkArea.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnWorkArea', aCtx);
end;//TkwDictionContainerFormPnWorkArea.SetValuePrim

function TkwDictionContainerFormPnWorkArea.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwDictionContainerFormPnWorkArea.GetResultTypeInfo

function TkwDictionContainerFormPnWorkArea.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDictionContainerFormPnWorkArea.GetAllParamsCount

function TkwDictionContainerFormPnWorkArea.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPnWorkArea.ParamsTypes

type
  TkwDictionContainerFormChildZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDictionContainerForm.ChildZone
[panel]Контрол ChildZone формы TDictionContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aDictionContainerForm .TDictionContainerForm.ChildZone >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function ChildZone(const aCtx: TtfwContext;
     aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TDictionContainerForm.ChildZone }
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
  end;//TkwDictionContainerFormChildZone

// start class TkwDictionContainerFormChildZone

function TkwDictionContainerFormChildZone.ChildZone(const aCtx: TtfwContext;
  aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
 {-}
begin
 Result := aDictionContainerForm.ChildZone;
end;//TkwDictionContainerFormChildZone.ChildZone

procedure TkwDictionContainerFormChildZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionContainerForm : TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ChildZone(aCtx, l_aDictionContainerForm)));
end;//TkwDictionContainerFormChildZone.DoDoIt

class function TkwDictionContainerFormChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDictionContainerForm.ChildZone';
end;//TkwDictionContainerFormChildZone.GetWordNameForRegister

procedure TkwDictionContainerFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZone', aCtx);
end;//TkwDictionContainerFormChildZone.SetValuePrim

function TkwDictionContainerFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwDictionContainerFormChildZone.GetResultTypeInfo

function TkwDictionContainerFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDictionContainerFormChildZone.GetAllParamsCount

function TkwDictionContainerFormChildZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormChildZone.ParamsTypes

type
  TkwDictionContainerFormPnHeader = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDictionContainerForm.pnHeader
[panel]Контрол pnHeader формы TDictionContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aDictionContainerForm .TDictionContainerForm.pnHeader >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnHeader(const aCtx: TtfwContext;
     aDictionContainerForm: TDictionContainerForm): TvtPanel;
     {* Реализация слова скрипта .TDictionContainerForm.pnHeader }
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
  end;//TkwDictionContainerFormPnHeader

// start class TkwDictionContainerFormPnHeader

function TkwDictionContainerFormPnHeader.PnHeader(const aCtx: TtfwContext;
  aDictionContainerForm: TDictionContainerForm): TvtPanel;
 {-}
begin
 Result := aDictionContainerForm.pnHeader;
end;//TkwDictionContainerFormPnHeader.PnHeader

procedure TkwDictionContainerFormPnHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionContainerForm : TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnHeader(aCtx, l_aDictionContainerForm)));
end;//TkwDictionContainerFormPnHeader.DoDoIt

class function TkwDictionContainerFormPnHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDictionContainerForm.pnHeader';
end;//TkwDictionContainerFormPnHeader.GetWordNameForRegister

procedure TkwDictionContainerFormPnHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnHeader', aCtx);
end;//TkwDictionContainerFormPnHeader.SetValuePrim

function TkwDictionContainerFormPnHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwDictionContainerFormPnHeader.GetResultTypeInfo

function TkwDictionContainerFormPnHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDictionContainerFormPnHeader.GetAllParamsCount

function TkwDictionContainerFormPnHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPnHeader.ParamsTypes

type
  TkwDictionContainerFormLbHeader = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDictionContainerForm.lbHeader
[panel]Контрол lbHeader формы TDictionContainerForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aDictionContainerForm .TDictionContainerForm.lbHeader >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LbHeader(const aCtx: TtfwContext;
     aDictionContainerForm: TDictionContainerForm): TvtLabel;
     {* Реализация слова скрипта .TDictionContainerForm.lbHeader }
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
  end;//TkwDictionContainerFormLbHeader

// start class TkwDictionContainerFormLbHeader

function TkwDictionContainerFormLbHeader.LbHeader(const aCtx: TtfwContext;
  aDictionContainerForm: TDictionContainerForm): TvtLabel;
 {-}
begin
 Result := aDictionContainerForm.lbHeader;
end;//TkwDictionContainerFormLbHeader.LbHeader

procedure TkwDictionContainerFormLbHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionContainerForm : TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbHeader(aCtx, l_aDictionContainerForm)));
end;//TkwDictionContainerFormLbHeader.DoDoIt

class function TkwDictionContainerFormLbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDictionContainerForm.lbHeader';
end;//TkwDictionContainerFormLbHeader.GetWordNameForRegister

procedure TkwDictionContainerFormLbHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbHeader', aCtx);
end;//TkwDictionContainerFormLbHeader.SetValuePrim

function TkwDictionContainerFormLbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwDictionContainerFormLbHeader.GetResultTypeInfo

function TkwDictionContainerFormLbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDictionContainerFormLbHeader.GetAllParamsCount

function TkwDictionContainerFormLbHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormLbHeader.ParamsTypes

type
  TkwDictionContainerFormPbHeader = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDictionContainerForm.pbHeader
[panel]Контрол pbHeader формы TDictionContainerForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aDictionContainerForm .TDictionContainerForm.pbHeader >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbHeader(const aCtx: TtfwContext;
     aDictionContainerForm: TDictionContainerForm): TPaintBox;
     {* Реализация слова скрипта .TDictionContainerForm.pbHeader }
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
  end;//TkwDictionContainerFormPbHeader

// start class TkwDictionContainerFormPbHeader

function TkwDictionContainerFormPbHeader.PbHeader(const aCtx: TtfwContext;
  aDictionContainerForm: TDictionContainerForm): TPaintBox;
 {-}
begin
 Result := aDictionContainerForm.pbHeader;
end;//TkwDictionContainerFormPbHeader.PbHeader

procedure TkwDictionContainerFormPbHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionContainerForm : TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbHeader(aCtx, l_aDictionContainerForm)));
end;//TkwDictionContainerFormPbHeader.DoDoIt

class function TkwDictionContainerFormPbHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDictionContainerForm.pbHeader';
end;//TkwDictionContainerFormPbHeader.GetWordNameForRegister

procedure TkwDictionContainerFormPbHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbHeader', aCtx);
end;//TkwDictionContainerFormPbHeader.SetValuePrim

function TkwDictionContainerFormPbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwDictionContainerFormPbHeader.GetResultTypeInfo

function TkwDictionContainerFormPbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDictionContainerFormPbHeader.GetAllParamsCount

function TkwDictionContainerFormPbHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPbHeader.ParamsTypes

type
  TkwDictionContainerFormParentZone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TDictionContainerForm.ParentZone
[panel]Контрол ParentZone формы TDictionContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aDictionContainerForm .TDictionContainerForm.ParentZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ParentZone(const aCtx: TtfwContext;
     aDictionContainerForm: TDictionContainerForm): TvtPanel;
     {* Реализация слова скрипта .TDictionContainerForm.ParentZone }
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
  end;//TkwDictionContainerFormParentZone

// start class TkwDictionContainerFormParentZone

function TkwDictionContainerFormParentZone.ParentZone(const aCtx: TtfwContext;
  aDictionContainerForm: TDictionContainerForm): TvtPanel;
 {-}
begin
 Result := aDictionContainerForm.ParentZone;
end;//TkwDictionContainerFormParentZone.ParentZone

procedure TkwDictionContainerFormParentZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aDictionContainerForm : TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentZone(aCtx, l_aDictionContainerForm)));
end;//TkwDictionContainerFormParentZone.DoDoIt

class function TkwDictionContainerFormParentZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TDictionContainerForm.ParentZone';
end;//TkwDictionContainerFormParentZone.GetWordNameForRegister

procedure TkwDictionContainerFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ParentZone', aCtx);
end;//TkwDictionContainerFormParentZone.SetValuePrim

function TkwDictionContainerFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwDictionContainerFormParentZone.GetResultTypeInfo

function TkwDictionContainerFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwDictionContainerFormParentZone.GetAllParamsCount

function TkwDictionContainerFormParentZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormParentZone.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_DictionContainer
 Tkw_Form_DictionContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_pnBackground
 Tkw_DictionContainer_Control_pnBackground.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_pnBackground_Push
 Tkw_DictionContainer_Control_pnBackground_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_NavigatorZone
 Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_NavigatorZone_Push
 Tkw_DictionContainer_Control_NavigatorZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_pnWorkArea
 Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_pnWorkArea_Push
 Tkw_DictionContainer_Control_pnWorkArea_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_ChildZone
 Tkw_DictionContainer_Control_ChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_ChildZone_Push
 Tkw_DictionContainer_Control_ChildZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_pnHeader
 Tkw_DictionContainer_Control_pnHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_pnHeader_Push
 Tkw_DictionContainer_Control_pnHeader_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_lbHeader
 Tkw_DictionContainer_Control_lbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_lbHeader_Push
 Tkw_DictionContainer_Control_lbHeader_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_pbHeader
 Tkw_DictionContainer_Control_pbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_pbHeader_Push
 Tkw_DictionContainer_Control_pbHeader_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_ParentZone
 Tkw_DictionContainer_Control_ParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_DictionContainer_Control_ParentZone_Push
 Tkw_DictionContainer_Control_ParentZone_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DictionContainerForm_pnBackground
 TkwDictionContainerFormPnBackground.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DictionContainerForm_NavigatorZone
 TkwDictionContainerFormNavigatorZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DictionContainerForm_pnWorkArea
 TkwDictionContainerFormPnWorkArea.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DictionContainerForm_ChildZone
 TkwDictionContainerFormChildZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DictionContainerForm_pnHeader
 TkwDictionContainerFormPnHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DictionContainerForm_lbHeader
 TkwDictionContainerFormLbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DictionContainerForm_pbHeader
 TkwDictionContainerFormPbHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация DictionContainerForm_ParentZone
 TkwDictionContainerFormParentZone.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа DictionContainer
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDictionContainerForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
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