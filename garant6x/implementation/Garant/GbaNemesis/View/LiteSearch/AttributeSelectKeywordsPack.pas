unit AttributeSelectKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы AttributeSelect }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\AttributeSelectKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "AttributeSelectKeywordsPack" MUID: (D0D36137E819)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , AttributeSelect_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_AttributeSelect = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы AttributeSelect
----
*Пример использования*:
[code]
'aControl' форма::AttributeSelect TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_AttributeSelect

 Tkw_AttributeSelect_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AttributeSelect_Control_BackgroundPanel

 Tkw_AttributeSelect_Control_BackgroundPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AttributeSelect_Control_BackgroundPanel_Push

 Tkw_AttributeSelect_Control_SelectedZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SelectedZone
----
*Пример использования*:
[code]
контрол::SelectedZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AttributeSelect_Control_SelectedZone

 Tkw_AttributeSelect_Control_SelectedZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола SelectedZone
----
*Пример использования*:
[code]
контрол::SelectedZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AttributeSelect_Control_SelectedZone_Push

 Tkw_AttributeSelect_Control_ValuesZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ValuesZone
----
*Пример использования*:
[code]
контрол::ValuesZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AttributeSelect_Control_ValuesZone

 Tkw_AttributeSelect_Control_ValuesZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ValuesZone
----
*Пример использования*:
[code]
контрол::ValuesZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AttributeSelect_Control_ValuesZone_Push

 TkwCfAttributeSelectBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAttributeSelect.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    acfAttributeSelect: TcfAttributeSelect): TvtProportionalPanel;
    {* Реализация слова скрипта .TcfAttributeSelect.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfAttributeSelectBackgroundPanel

 TkwCfAttributeSelectSelectedZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAttributeSelect.SelectedZone }
  private
   function SelectedZone(const aCtx: TtfwContext;
    acfAttributeSelect: TcfAttributeSelect): TvtSizeablePanel;
    {* Реализация слова скрипта .TcfAttributeSelect.SelectedZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfAttributeSelectSelectedZone

 TkwCfAttributeSelectValuesZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAttributeSelect.ValuesZone }
  private
   function ValuesZone(const aCtx: TtfwContext;
    acfAttributeSelect: TcfAttributeSelect): TvtPanel;
    {* Реализация слова скрипта .TcfAttributeSelect.ValuesZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfAttributeSelectValuesZone

function Tkw_Form_AttributeSelect.GetString: AnsiString;
begin
 Result := 'cfAttributeSelect';
end;//Tkw_Form_AttributeSelect.GetString

class function Tkw_Form_AttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::AttributeSelect';
end;//Tkw_Form_AttributeSelect.GetWordNameForRegister

function Tkw_AttributeSelect_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_AttributeSelect_Control_BackgroundPanel.GetString

class procedure Tkw_AttributeSelect_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AttributeSelect_Control_BackgroundPanel.RegisterInEngine

class function Tkw_AttributeSelect_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_AttributeSelect_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_AttributeSelect_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_AttributeSelect_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_AttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_AttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_AttributeSelect_Control_SelectedZone.GetString: AnsiString;
begin
 Result := 'SelectedZone';
end;//Tkw_AttributeSelect_Control_SelectedZone.GetString

class procedure Tkw_AttributeSelect_Control_SelectedZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AttributeSelect_Control_SelectedZone.RegisterInEngine

class function Tkw_AttributeSelect_Control_SelectedZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SelectedZone';
end;//Tkw_AttributeSelect_Control_SelectedZone.GetWordNameForRegister

procedure Tkw_AttributeSelect_Control_SelectedZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SelectedZone');
 inherited;
end;//Tkw_AttributeSelect_Control_SelectedZone_Push.DoDoIt

class function Tkw_AttributeSelect_Control_SelectedZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SelectedZone:push';
end;//Tkw_AttributeSelect_Control_SelectedZone_Push.GetWordNameForRegister

function Tkw_AttributeSelect_Control_ValuesZone.GetString: AnsiString;
begin
 Result := 'ValuesZone';
end;//Tkw_AttributeSelect_Control_ValuesZone.GetString

class procedure Tkw_AttributeSelect_Control_ValuesZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AttributeSelect_Control_ValuesZone.RegisterInEngine

class function Tkw_AttributeSelect_Control_ValuesZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ValuesZone';
end;//Tkw_AttributeSelect_Control_ValuesZone.GetWordNameForRegister

procedure Tkw_AttributeSelect_Control_ValuesZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ValuesZone');
 inherited;
end;//Tkw_AttributeSelect_Control_ValuesZone_Push.DoDoIt

class function Tkw_AttributeSelect_Control_ValuesZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ValuesZone:push';
end;//Tkw_AttributeSelect_Control_ValuesZone_Push.GetWordNameForRegister

function TkwCfAttributeSelectBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 acfAttributeSelect: TcfAttributeSelect): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfAttributeSelect.BackgroundPanel }
begin
 Result := acfAttributeSelect.BackgroundPanel;
end;//TkwCfAttributeSelectBackgroundPanel.BackgroundPanel

class function TkwCfAttributeSelectBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAttributeSelect.BackgroundPanel';
end;//TkwCfAttributeSelectBackgroundPanel.GetWordNameForRegister

function TkwCfAttributeSelectBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfAttributeSelectBackgroundPanel.GetResultTypeInfo

function TkwCfAttributeSelectBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAttributeSelectBackgroundPanel.GetAllParamsCount

function TkwCfAttributeSelectBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAttributeSelect)]);
end;//TkwCfAttributeSelectBackgroundPanel.ParamsTypes

procedure TkwCfAttributeSelectBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwCfAttributeSelectBackgroundPanel.SetValuePrim

procedure TkwCfAttributeSelectBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_acfAttributeSelect: TcfAttributeSelect;
begin
 try
  l_acfAttributeSelect := TcfAttributeSelect(aCtx.rEngine.PopObjAs(TcfAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfAttributeSelect: TcfAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_acfAttributeSelect));
end;//TkwCfAttributeSelectBackgroundPanel.DoDoIt

function TkwCfAttributeSelectSelectedZone.SelectedZone(const aCtx: TtfwContext;
 acfAttributeSelect: TcfAttributeSelect): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfAttributeSelect.SelectedZone }
begin
 Result := acfAttributeSelect.SelectedZone;
end;//TkwCfAttributeSelectSelectedZone.SelectedZone

class function TkwCfAttributeSelectSelectedZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAttributeSelect.SelectedZone';
end;//TkwCfAttributeSelectSelectedZone.GetWordNameForRegister

function TkwCfAttributeSelectSelectedZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfAttributeSelectSelectedZone.GetResultTypeInfo

function TkwCfAttributeSelectSelectedZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAttributeSelectSelectedZone.GetAllParamsCount

function TkwCfAttributeSelectSelectedZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAttributeSelect)]);
end;//TkwCfAttributeSelectSelectedZone.ParamsTypes

procedure TkwCfAttributeSelectSelectedZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SelectedZone', aCtx);
end;//TkwCfAttributeSelectSelectedZone.SetValuePrim

procedure TkwCfAttributeSelectSelectedZone.DoDoIt(const aCtx: TtfwContext);
var l_acfAttributeSelect: TcfAttributeSelect;
begin
 try
  l_acfAttributeSelect := TcfAttributeSelect(aCtx.rEngine.PopObjAs(TcfAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfAttributeSelect: TcfAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SelectedZone(aCtx, l_acfAttributeSelect));
end;//TkwCfAttributeSelectSelectedZone.DoDoIt

function TkwCfAttributeSelectValuesZone.ValuesZone(const aCtx: TtfwContext;
 acfAttributeSelect: TcfAttributeSelect): TvtPanel;
 {* Реализация слова скрипта .TcfAttributeSelect.ValuesZone }
begin
 Result := acfAttributeSelect.ValuesZone;
end;//TkwCfAttributeSelectValuesZone.ValuesZone

class function TkwCfAttributeSelectValuesZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAttributeSelect.ValuesZone';
end;//TkwCfAttributeSelectValuesZone.GetWordNameForRegister

function TkwCfAttributeSelectValuesZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfAttributeSelectValuesZone.GetResultTypeInfo

function TkwCfAttributeSelectValuesZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAttributeSelectValuesZone.GetAllParamsCount

function TkwCfAttributeSelectValuesZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAttributeSelect)]);
end;//TkwCfAttributeSelectValuesZone.ParamsTypes

procedure TkwCfAttributeSelectValuesZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ValuesZone', aCtx);
end;//TkwCfAttributeSelectValuesZone.SetValuePrim

procedure TkwCfAttributeSelectValuesZone.DoDoIt(const aCtx: TtfwContext);
var l_acfAttributeSelect: TcfAttributeSelect;
begin
 try
  l_acfAttributeSelect := TcfAttributeSelect(aCtx.rEngine.PopObjAs(TcfAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfAttributeSelect: TcfAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ValuesZone(aCtx, l_acfAttributeSelect));
end;//TkwCfAttributeSelectValuesZone.DoDoIt

initialization
 Tkw_Form_AttributeSelect.RegisterInEngine;
 {* Регистрация Tkw_Form_AttributeSelect }
 Tkw_AttributeSelect_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_AttributeSelect_Control_BackgroundPanel }
 Tkw_AttributeSelect_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_AttributeSelect_Control_BackgroundPanel_Push }
 Tkw_AttributeSelect_Control_SelectedZone.RegisterInEngine;
 {* Регистрация Tkw_AttributeSelect_Control_SelectedZone }
 Tkw_AttributeSelect_Control_SelectedZone_Push.RegisterInEngine;
 {* Регистрация Tkw_AttributeSelect_Control_SelectedZone_Push }
 Tkw_AttributeSelect_Control_ValuesZone.RegisterInEngine;
 {* Регистрация Tkw_AttributeSelect_Control_ValuesZone }
 Tkw_AttributeSelect_Control_ValuesZone_Push.RegisterInEngine;
 {* Регистрация Tkw_AttributeSelect_Control_ValuesZone_Push }
 TkwCfAttributeSelectBackgroundPanel.RegisterInEngine;
 {* Регистрация cfAttributeSelect_BackgroundPanel }
 TkwCfAttributeSelectSelectedZone.RegisterInEngine;
 {* Регистрация cfAttributeSelect_SelectedZone }
 TkwCfAttributeSelectValuesZone.RegisterInEngine;
 {* Регистрация cfAttributeSelect_ValuesZone }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfAttributeSelect));
 {* Регистрация типа TcfAttributeSelect }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
