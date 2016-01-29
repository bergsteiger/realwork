unit CompInfoKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/CompInfoKeywordsPack.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Core::Common::View::Common::PrimF1Common::CompInfoKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы CompInfo
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
  CompInfo_Form,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscTreeViewWithAdapterDragDrop,
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
  Tkw_Form_CompInfo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы CompInfo
----
*Пример использования*:
[code]
'aControl' форма::CompInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_CompInfo

// start class Tkw_Form_CompInfo

class function Tkw_Form_CompInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::CompInfo';
end;//Tkw_Form_CompInfo.GetWordNameForRegister

function Tkw_Form_CompInfo.GetString: AnsiString;
 {-}
begin
 Result := 'enCompInfo';
end;//Tkw_Form_CompInfo.GetString

type
  Tkw_CompInfo_Control_tvComplectInfo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола tvComplectInfo
----
*Пример использования*:
[code]
контрол::tvComplectInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CompInfo_Control_tvComplectInfo

// start class Tkw_CompInfo_Control_tvComplectInfo

class function Tkw_CompInfo_Control_tvComplectInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvComplectInfo';
end;//Tkw_CompInfo_Control_tvComplectInfo.GetWordNameForRegister

function Tkw_CompInfo_Control_tvComplectInfo.GetString: AnsiString;
 {-}
begin
 Result := 'tvComplectInfo';
end;//Tkw_CompInfo_Control_tvComplectInfo.GetString

class procedure Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine

type
  Tkw_CompInfo_Control_tvComplectInfo_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола tvComplectInfo
----
*Пример использования*:
[code]
контрол::tvComplectInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CompInfo_Control_tvComplectInfo_Push

// start class Tkw_CompInfo_Control_tvComplectInfo_Push

procedure Tkw_CompInfo_Control_tvComplectInfo_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvComplectInfo');
 inherited;
end;//Tkw_CompInfo_Control_tvComplectInfo_Push.DoDoIt

class function Tkw_CompInfo_Control_tvComplectInfo_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::tvComplectInfo:push';
end;//Tkw_CompInfo_Control_tvComplectInfo_Push.GetWordNameForRegister

type
  Tkw_CompInfo_Control_pnBottom = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnBottom
----
*Пример использования*:
[code]
контрол::pnBottom TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CompInfo_Control_pnBottom

// start class Tkw_CompInfo_Control_pnBottom

class function Tkw_CompInfo_Control_pnBottom.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnBottom';
end;//Tkw_CompInfo_Control_pnBottom.GetWordNameForRegister

function Tkw_CompInfo_Control_pnBottom.GetString: AnsiString;
 {-}
begin
 Result := 'pnBottom';
end;//Tkw_CompInfo_Control_pnBottom.GetString

class procedure Tkw_CompInfo_Control_pnBottom.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CompInfo_Control_pnBottom.RegisterInEngine

type
  Tkw_CompInfo_Control_pnBottom_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnBottom
----
*Пример использования*:
[code]
контрол::pnBottom:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CompInfo_Control_pnBottom_Push

// start class Tkw_CompInfo_Control_pnBottom_Push

procedure Tkw_CompInfo_Control_pnBottom_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnBottom');
 inherited;
end;//Tkw_CompInfo_Control_pnBottom_Push.DoDoIt

class function Tkw_CompInfo_Control_pnBottom_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnBottom:push';
end;//Tkw_CompInfo_Control_pnBottom_Push.GetWordNameForRegister

type
  Tkw_CompInfo_Control_pnVisualRepresentationData = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnVisualRepresentationData
----
*Пример использования*:
[code]
контрол::pnVisualRepresentationData TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CompInfo_Control_pnVisualRepresentationData

// start class Tkw_CompInfo_Control_pnVisualRepresentationData

class function Tkw_CompInfo_Control_pnVisualRepresentationData.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnVisualRepresentationData';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.GetWordNameForRegister

function Tkw_CompInfo_Control_pnVisualRepresentationData.GetString: AnsiString;
 {-}
begin
 Result := 'pnVisualRepresentationData';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.GetString

class procedure Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine

type
  Tkw_CompInfo_Control_pnVisualRepresentationData_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnVisualRepresentationData
----
*Пример использования*:
[code]
контрол::pnVisualRepresentationData:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push

// start class Tkw_CompInfo_Control_pnVisualRepresentationData_Push

procedure Tkw_CompInfo_Control_pnVisualRepresentationData_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnVisualRepresentationData');
 inherited;
end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push.DoDoIt

class function Tkw_CompInfo_Control_pnVisualRepresentationData_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnVisualRepresentationData:push';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push.GetWordNameForRegister

type
  Tkw_CompInfo_Control_pnVisualRepresentationDataCaption = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnVisualRepresentationDataCaption
----
*Пример использования*:
[code]
контрол::pnVisualRepresentationDataCaption TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption

// start class Tkw_CompInfo_Control_pnVisualRepresentationDataCaption

class function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnVisualRepresentationDataCaption';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetWordNameForRegister

function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetString: AnsiString;
 {-}
begin
 Result := 'pnVisualRepresentationDataCaption';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetString

class procedure Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine

type
  Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnVisualRepresentationDataCaption
----
*Пример использования*:
[code]
контрол::pnVisualRepresentationDataCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push

// start class Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push

procedure Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnVisualRepresentationDataCaption');
 inherited;
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.DoDoIt

class function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnVisualRepresentationDataCaption:push';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.GetWordNameForRegister

type
  Tkw_CompInfo_Control_lblVisualRepresentationData = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblVisualRepresentationData
----
*Пример использования*:
[code]
контрол::lblVisualRepresentationData TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_CompInfo_Control_lblVisualRepresentationData

// start class Tkw_CompInfo_Control_lblVisualRepresentationData

class function Tkw_CompInfo_Control_lblVisualRepresentationData.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblVisualRepresentationData';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.GetWordNameForRegister

function Tkw_CompInfo_Control_lblVisualRepresentationData.GetString: AnsiString;
 {-}
begin
 Result := 'lblVisualRepresentationData';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.GetString

class procedure Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine

type
  Tkw_CompInfo_Control_lblVisualRepresentationData_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblVisualRepresentationData
----
*Пример использования*:
[code]
контрол::lblVisualRepresentationData:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push

// start class Tkw_CompInfo_Control_lblVisualRepresentationData_Push

procedure Tkw_CompInfo_Control_lblVisualRepresentationData_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblVisualRepresentationData');
 inherited;
end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push.DoDoIt

class function Tkw_CompInfo_Control_lblVisualRepresentationData_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblVisualRepresentationData:push';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push.GetWordNameForRegister

type
  TkwEnCompInfoTvComplectInfo = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenCompInfo.tvComplectInfo
[panel]Контрол tvComplectInfo формы TenCompInfo[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenCompInfo .TenCompInfo.tvComplectInfo >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
  // private methods
   function TvComplectInfo(const aCtx: TtfwContext;
     aenCompInfo: TenCompInfo): TnscTreeViewWithAdapterDragDrop;
     {* Реализация слова скрипта .TenCompInfo.tvComplectInfo }
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
  end;//TkwEnCompInfoTvComplectInfo

// start class TkwEnCompInfoTvComplectInfo

function TkwEnCompInfoTvComplectInfo.TvComplectInfo(const aCtx: TtfwContext;
  aenCompInfo: TenCompInfo): TnscTreeViewWithAdapterDragDrop;
 {-}
begin
 Result := aenCompInfo.tvComplectInfo;
end;//TkwEnCompInfoTvComplectInfo.TvComplectInfo

procedure TkwEnCompInfoTvComplectInfo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenCompInfo : TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvComplectInfo(aCtx, l_aenCompInfo)));
end;//TkwEnCompInfoTvComplectInfo.DoDoIt

class function TkwEnCompInfoTvComplectInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenCompInfo.tvComplectInfo';
end;//TkwEnCompInfoTvComplectInfo.GetWordNameForRegister

procedure TkwEnCompInfoTvComplectInfo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvComplectInfo', aCtx);
end;//TkwEnCompInfoTvComplectInfo.SetValuePrim

function TkwEnCompInfoTvComplectInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnCompInfoTvComplectInfo.GetResultTypeInfo

function TkwEnCompInfoTvComplectInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnCompInfoTvComplectInfo.GetAllParamsCount

function TkwEnCompInfoTvComplectInfo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoTvComplectInfo.ParamsTypes

type
  TkwEnCompInfoPnBottom = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenCompInfo.pnBottom
[panel]Контрол pnBottom формы TenCompInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenCompInfo .TenCompInfo.pnBottom >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnBottom(const aCtx: TtfwContext;
     aenCompInfo: TenCompInfo): TvtPanel;
     {* Реализация слова скрипта .TenCompInfo.pnBottom }
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
  end;//TkwEnCompInfoPnBottom

// start class TkwEnCompInfoPnBottom

function TkwEnCompInfoPnBottom.PnBottom(const aCtx: TtfwContext;
  aenCompInfo: TenCompInfo): TvtPanel;
 {-}
begin
 Result := aenCompInfo.pnBottom;
end;//TkwEnCompInfoPnBottom.PnBottom

procedure TkwEnCompInfoPnBottom.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenCompInfo : TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnBottom(aCtx, l_aenCompInfo)));
end;//TkwEnCompInfoPnBottom.DoDoIt

class function TkwEnCompInfoPnBottom.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenCompInfo.pnBottom';
end;//TkwEnCompInfoPnBottom.GetWordNameForRegister

procedure TkwEnCompInfoPnBottom.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnBottom', aCtx);
end;//TkwEnCompInfoPnBottom.SetValuePrim

function TkwEnCompInfoPnBottom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnCompInfoPnBottom.GetResultTypeInfo

function TkwEnCompInfoPnBottom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnCompInfoPnBottom.GetAllParamsCount

function TkwEnCompInfoPnBottom.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoPnBottom.ParamsTypes

type
  TkwEnCompInfoPnVisualRepresentationData = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenCompInfo.pnVisualRepresentationData
[panel]Контрол pnVisualRepresentationData формы TenCompInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenCompInfo .TenCompInfo.pnVisualRepresentationData >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnVisualRepresentationData(const aCtx: TtfwContext;
     aenCompInfo: TenCompInfo): TvtPanel;
     {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationData }
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
  end;//TkwEnCompInfoPnVisualRepresentationData

// start class TkwEnCompInfoPnVisualRepresentationData

function TkwEnCompInfoPnVisualRepresentationData.PnVisualRepresentationData(const aCtx: TtfwContext;
  aenCompInfo: TenCompInfo): TvtPanel;
 {-}
begin
 Result := aenCompInfo.pnVisualRepresentationData;
end;//TkwEnCompInfoPnVisualRepresentationData.PnVisualRepresentationData

procedure TkwEnCompInfoPnVisualRepresentationData.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenCompInfo : TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnVisualRepresentationData(aCtx, l_aenCompInfo)));
end;//TkwEnCompInfoPnVisualRepresentationData.DoDoIt

class function TkwEnCompInfoPnVisualRepresentationData.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenCompInfo.pnVisualRepresentationData';
end;//TkwEnCompInfoPnVisualRepresentationData.GetWordNameForRegister

procedure TkwEnCompInfoPnVisualRepresentationData.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnVisualRepresentationData', aCtx);
end;//TkwEnCompInfoPnVisualRepresentationData.SetValuePrim

function TkwEnCompInfoPnVisualRepresentationData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnCompInfoPnVisualRepresentationData.GetResultTypeInfo

function TkwEnCompInfoPnVisualRepresentationData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnCompInfoPnVisualRepresentationData.GetAllParamsCount

function TkwEnCompInfoPnVisualRepresentationData.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoPnVisualRepresentationData.ParamsTypes

type
  TkwEnCompInfoPnVisualRepresentationDataCaption = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenCompInfo.pnVisualRepresentationDataCaption
[panel]Контрол pnVisualRepresentationDataCaption формы TenCompInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenCompInfo .TenCompInfo.pnVisualRepresentationDataCaption >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnVisualRepresentationDataCaption(const aCtx: TtfwContext;
     aenCompInfo: TenCompInfo): TvtPanel;
     {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationDataCaption }
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
  end;//TkwEnCompInfoPnVisualRepresentationDataCaption

// start class TkwEnCompInfoPnVisualRepresentationDataCaption

function TkwEnCompInfoPnVisualRepresentationDataCaption.PnVisualRepresentationDataCaption(const aCtx: TtfwContext;
  aenCompInfo: TenCompInfo): TvtPanel;
 {-}
begin
 Result := aenCompInfo.pnVisualRepresentationDataCaption;
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.PnVisualRepresentationDataCaption

procedure TkwEnCompInfoPnVisualRepresentationDataCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenCompInfo : TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnVisualRepresentationDataCaption(aCtx, l_aenCompInfo)));
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.DoDoIt

class function TkwEnCompInfoPnVisualRepresentationDataCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenCompInfo.pnVisualRepresentationDataCaption';
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.GetWordNameForRegister

procedure TkwEnCompInfoPnVisualRepresentationDataCaption.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnVisualRepresentationDataCaption', aCtx);
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.SetValuePrim

function TkwEnCompInfoPnVisualRepresentationDataCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.GetResultTypeInfo

function TkwEnCompInfoPnVisualRepresentationDataCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.GetAllParamsCount

function TkwEnCompInfoPnVisualRepresentationDataCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.ParamsTypes

type
  TkwEnCompInfoLblVisualRepresentationData = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenCompInfo.lblVisualRepresentationData
[panel]Контрол lblVisualRepresentationData формы TenCompInfo[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aenCompInfo .TenCompInfo.lblVisualRepresentationData >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblVisualRepresentationData(const aCtx: TtfwContext;
     aenCompInfo: TenCompInfo): TvtLabel;
     {* Реализация слова скрипта .TenCompInfo.lblVisualRepresentationData }
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
  end;//TkwEnCompInfoLblVisualRepresentationData

// start class TkwEnCompInfoLblVisualRepresentationData

function TkwEnCompInfoLblVisualRepresentationData.LblVisualRepresentationData(const aCtx: TtfwContext;
  aenCompInfo: TenCompInfo): TvtLabel;
 {-}
begin
 Result := aenCompInfo.lblVisualRepresentationData;
end;//TkwEnCompInfoLblVisualRepresentationData.LblVisualRepresentationData

procedure TkwEnCompInfoLblVisualRepresentationData.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenCompInfo : TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblVisualRepresentationData(aCtx, l_aenCompInfo)));
end;//TkwEnCompInfoLblVisualRepresentationData.DoDoIt

class function TkwEnCompInfoLblVisualRepresentationData.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenCompInfo.lblVisualRepresentationData';
end;//TkwEnCompInfoLblVisualRepresentationData.GetWordNameForRegister

procedure TkwEnCompInfoLblVisualRepresentationData.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblVisualRepresentationData', aCtx);
end;//TkwEnCompInfoLblVisualRepresentationData.SetValuePrim

function TkwEnCompInfoLblVisualRepresentationData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnCompInfoLblVisualRepresentationData.GetResultTypeInfo

function TkwEnCompInfoLblVisualRepresentationData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnCompInfoLblVisualRepresentationData.GetAllParamsCount

function TkwEnCompInfoLblVisualRepresentationData.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoLblVisualRepresentationData.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_CompInfo
 Tkw_Form_CompInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_tvComplectInfo
 Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_tvComplectInfo_Push
 Tkw_CompInfo_Control_tvComplectInfo_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_pnBottom
 Tkw_CompInfo_Control_pnBottom.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_pnBottom_Push
 Tkw_CompInfo_Control_pnBottom_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_pnVisualRepresentationData
 Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_pnVisualRepresentationData_Push
 Tkw_CompInfo_Control_pnVisualRepresentationData_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_pnVisualRepresentationDataCaption
 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push
 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_lblVisualRepresentationData
 Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_CompInfo_Control_lblVisualRepresentationData_Push
 Tkw_CompInfo_Control_lblVisualRepresentationData_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enCompInfo_tvComplectInfo
 TkwEnCompInfoTvComplectInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enCompInfo_pnBottom
 TkwEnCompInfoPnBottom.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enCompInfo_pnVisualRepresentationData
 TkwEnCompInfoPnVisualRepresentationData.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enCompInfo_pnVisualRepresentationDataCaption
 TkwEnCompInfoPnVisualRepresentationDataCaption.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enCompInfo_lblVisualRepresentationData
 TkwEnCompInfoLblVisualRepresentationData.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа CompInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenCompInfo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscTreeViewWithAdapterDragDrop
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.