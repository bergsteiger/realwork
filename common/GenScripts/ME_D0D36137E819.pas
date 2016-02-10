unit AttributeSelectKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы AttributeSelect }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\AttributeSelectKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , LiteSearch_Module
 , vtProportionalPanel
 , vtSizeablePanel
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
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AttributeSelect

 Tkw_AttributeSelect_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_AttributeSelect_Control_BackgroundPanel

 Tkw_AttributeSelect_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AttributeSelect_Control_SelectedZone

 Tkw_AttributeSelect_Control_SelectedZone_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AttributeSelect_Control_ValuesZone

 Tkw_AttributeSelect_Control_ValuesZone_Push = {final} class(TkwBynameControlPush)
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
  {* Слово скрипта .TcfAttributeSelect.BackgroundPanel
[panel]Контрол BackgroundPanel формы TcfAttributeSelect[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfAttributeSelect .TcfAttributeSelect.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    acfAttributeSelect: TcfAttributeSelect): TvtProportionalPanel;
    {* Реализация слова скрипта .TcfAttributeSelect.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfAttributeSelectBackgroundPanel

 TkwCfAttributeSelectSelectedZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAttributeSelect.SelectedZone
[panel]Контрол SelectedZone формы TcfAttributeSelect[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfAttributeSelect .TcfAttributeSelect.SelectedZone >>> l_TvtSizeablePanel
[code]  }
  private
   function SelectedZone(const aCtx: TtfwContext;
    acfAttributeSelect: TcfAttributeSelect): TvtSizeablePanel;
    {* Реализация слова скрипта .TcfAttributeSelect.SelectedZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfAttributeSelectSelectedZone

 TkwCfAttributeSelectValuesZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAttributeSelect.ValuesZone
[panel]Контрол ValuesZone формы TcfAttributeSelect[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfAttributeSelect .TcfAttributeSelect.ValuesZone >>> l_TvtPanel
[code]  }
  private
   function ValuesZone(const aCtx: TtfwContext;
    acfAttributeSelect: TcfAttributeSelect): TvtPanel;
    {* Реализация слова скрипта .TcfAttributeSelect.ValuesZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfAttributeSelectValuesZone

class function Tkw_Form_AttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::AttributeSelect';
end;//Tkw_Form_AttributeSelect.GetWordNameForRegister

function Tkw_Form_AttributeSelect.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7B04CBBC23FE_var*
//#UC END# *4DDFD2EA0116_7B04CBBC23FE_var*
begin
//#UC START# *4DDFD2EA0116_7B04CBBC23FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7B04CBBC23FE_impl*
end;//Tkw_Form_AttributeSelect.GetString

class function Tkw_AttributeSelect_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_AttributeSelect_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_AttributeSelect_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_323ED05D103E_var*
//#UC END# *4DDFD2EA0116_323ED05D103E_var*
begin
//#UC START# *4DDFD2EA0116_323ED05D103E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_323ED05D103E_impl*
end;//Tkw_AttributeSelect_Control_BackgroundPanel.GetString

class procedure Tkw_AttributeSelect_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_323ED05D103E_var*
//#UC END# *52A086150180_323ED05D103E_var*
begin
//#UC START# *52A086150180_323ED05D103E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_323ED05D103E_impl*
end;//Tkw_AttributeSelect_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_AttributeSelect_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3153A90F966C_var*
//#UC END# *4DAEEDE10285_3153A90F966C_var*
begin
//#UC START# *4DAEEDE10285_3153A90F966C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3153A90F966C_impl*
end;//Tkw_AttributeSelect_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_AttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_AttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_AttributeSelect_Control_SelectedZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SelectedZone';
end;//Tkw_AttributeSelect_Control_SelectedZone.GetWordNameForRegister

function Tkw_AttributeSelect_Control_SelectedZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_20E72858C727_var*
//#UC END# *4DDFD2EA0116_20E72858C727_var*
begin
//#UC START# *4DDFD2EA0116_20E72858C727_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_20E72858C727_impl*
end;//Tkw_AttributeSelect_Control_SelectedZone.GetString

class procedure Tkw_AttributeSelect_Control_SelectedZone.RegisterInEngine;
//#UC START# *52A086150180_20E72858C727_var*
//#UC END# *52A086150180_20E72858C727_var*
begin
//#UC START# *52A086150180_20E72858C727_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_20E72858C727_impl*
end;//Tkw_AttributeSelect_Control_SelectedZone.RegisterInEngine

procedure Tkw_AttributeSelect_Control_SelectedZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2AB8F1A7EDFE_var*
//#UC END# *4DAEEDE10285_2AB8F1A7EDFE_var*
begin
//#UC START# *4DAEEDE10285_2AB8F1A7EDFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2AB8F1A7EDFE_impl*
end;//Tkw_AttributeSelect_Control_SelectedZone_Push.DoDoIt

class function Tkw_AttributeSelect_Control_SelectedZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SelectedZone:push';
end;//Tkw_AttributeSelect_Control_SelectedZone_Push.GetWordNameForRegister

class function Tkw_AttributeSelect_Control_ValuesZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ValuesZone';
end;//Tkw_AttributeSelect_Control_ValuesZone.GetWordNameForRegister

function Tkw_AttributeSelect_Control_ValuesZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_02C59321A72A_var*
//#UC END# *4DDFD2EA0116_02C59321A72A_var*
begin
//#UC START# *4DDFD2EA0116_02C59321A72A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_02C59321A72A_impl*
end;//Tkw_AttributeSelect_Control_ValuesZone.GetString

class procedure Tkw_AttributeSelect_Control_ValuesZone.RegisterInEngine;
//#UC START# *52A086150180_02C59321A72A_var*
//#UC END# *52A086150180_02C59321A72A_var*
begin
//#UC START# *52A086150180_02C59321A72A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_02C59321A72A_impl*
end;//Tkw_AttributeSelect_Control_ValuesZone.RegisterInEngine

procedure Tkw_AttributeSelect_Control_ValuesZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_433C953F27DF_var*
//#UC END# *4DAEEDE10285_433C953F27DF_var*
begin
//#UC START# *4DAEEDE10285_433C953F27DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_433C953F27DF_impl*
end;//Tkw_AttributeSelect_Control_ValuesZone_Push.DoDoIt

class function Tkw_AttributeSelect_Control_ValuesZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ValuesZone:push';
end;//Tkw_AttributeSelect_Control_ValuesZone_Push.GetWordNameForRegister

function TkwCfAttributeSelectBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 acfAttributeSelect: TcfAttributeSelect): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfAttributeSelect.BackgroundPanel }
//#UC START# *89CABF85AB03_89575F4DA07E_var*
//#UC END# *89CABF85AB03_89575F4DA07E_var*
begin
//#UC START# *89CABF85AB03_89575F4DA07E_impl*
 !!! Needs to be implemented !!!
//#UC END# *89CABF85AB03_89575F4DA07E_impl*
end;//TkwCfAttributeSelectBackgroundPanel.BackgroundPanel

procedure TkwCfAttributeSelectBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_89575F4DA07E_var*
//#UC END# *4DAEEDE10285_89575F4DA07E_var*
begin
//#UC START# *4DAEEDE10285_89575F4DA07E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_89575F4DA07E_impl*
end;//TkwCfAttributeSelectBackgroundPanel.DoDoIt

class function TkwCfAttributeSelectBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAttributeSelect.BackgroundPanel';
end;//TkwCfAttributeSelectBackgroundPanel.GetWordNameForRegister

procedure TkwCfAttributeSelectBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_89575F4DA07E_var*
//#UC END# *52D00B00031A_89575F4DA07E_var*
begin
//#UC START# *52D00B00031A_89575F4DA07E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_89575F4DA07E_impl*
end;//TkwCfAttributeSelectBackgroundPanel.SetValuePrim

function TkwCfAttributeSelectBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfAttributeSelectBackgroundPanel.GetResultTypeInfo

function TkwCfAttributeSelectBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAttributeSelectBackgroundPanel.GetAllParamsCount

function TkwCfAttributeSelectBackgroundPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_89575F4DA07E_var*
//#UC END# *5617F4D00243_89575F4DA07E_var*
begin
//#UC START# *5617F4D00243_89575F4DA07E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_89575F4DA07E_impl*
end;//TkwCfAttributeSelectBackgroundPanel.ParamsTypes

function TkwCfAttributeSelectSelectedZone.SelectedZone(const aCtx: TtfwContext;
 acfAttributeSelect: TcfAttributeSelect): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfAttributeSelect.SelectedZone }
//#UC START# *DA3D7C206BCF_74458A23E791_var*
//#UC END# *DA3D7C206BCF_74458A23E791_var*
begin
//#UC START# *DA3D7C206BCF_74458A23E791_impl*
 !!! Needs to be implemented !!!
//#UC END# *DA3D7C206BCF_74458A23E791_impl*
end;//TkwCfAttributeSelectSelectedZone.SelectedZone

procedure TkwCfAttributeSelectSelectedZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_74458A23E791_var*
//#UC END# *4DAEEDE10285_74458A23E791_var*
begin
//#UC START# *4DAEEDE10285_74458A23E791_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_74458A23E791_impl*
end;//TkwCfAttributeSelectSelectedZone.DoDoIt

class function TkwCfAttributeSelectSelectedZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAttributeSelect.SelectedZone';
end;//TkwCfAttributeSelectSelectedZone.GetWordNameForRegister

procedure TkwCfAttributeSelectSelectedZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_74458A23E791_var*
//#UC END# *52D00B00031A_74458A23E791_var*
begin
//#UC START# *52D00B00031A_74458A23E791_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_74458A23E791_impl*
end;//TkwCfAttributeSelectSelectedZone.SetValuePrim

function TkwCfAttributeSelectSelectedZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfAttributeSelectSelectedZone.GetResultTypeInfo

function TkwCfAttributeSelectSelectedZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAttributeSelectSelectedZone.GetAllParamsCount

function TkwCfAttributeSelectSelectedZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_74458A23E791_var*
//#UC END# *5617F4D00243_74458A23E791_var*
begin
//#UC START# *5617F4D00243_74458A23E791_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_74458A23E791_impl*
end;//TkwCfAttributeSelectSelectedZone.ParamsTypes

function TkwCfAttributeSelectValuesZone.ValuesZone(const aCtx: TtfwContext;
 acfAttributeSelect: TcfAttributeSelect): TvtPanel;
 {* Реализация слова скрипта .TcfAttributeSelect.ValuesZone }
//#UC START# *A13D09205356_122E41686ED8_var*
//#UC END# *A13D09205356_122E41686ED8_var*
begin
//#UC START# *A13D09205356_122E41686ED8_impl*
 !!! Needs to be implemented !!!
//#UC END# *A13D09205356_122E41686ED8_impl*
end;//TkwCfAttributeSelectValuesZone.ValuesZone

procedure TkwCfAttributeSelectValuesZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_122E41686ED8_var*
//#UC END# *4DAEEDE10285_122E41686ED8_var*
begin
//#UC START# *4DAEEDE10285_122E41686ED8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_122E41686ED8_impl*
end;//TkwCfAttributeSelectValuesZone.DoDoIt

class function TkwCfAttributeSelectValuesZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAttributeSelect.ValuesZone';
end;//TkwCfAttributeSelectValuesZone.GetWordNameForRegister

procedure TkwCfAttributeSelectValuesZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_122E41686ED8_var*
//#UC END# *52D00B00031A_122E41686ED8_var*
begin
//#UC START# *52D00B00031A_122E41686ED8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_122E41686ED8_impl*
end;//TkwCfAttributeSelectValuesZone.SetValuePrim

function TkwCfAttributeSelectValuesZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfAttributeSelectValuesZone.GetResultTypeInfo

function TkwCfAttributeSelectValuesZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAttributeSelectValuesZone.GetAllParamsCount

function TkwCfAttributeSelectValuesZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_122E41686ED8_var*
//#UC END# *5617F4D00243_122E41686ED8_var*
begin
//#UC START# *5617F4D00243_122E41686ED8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_122E41686ED8_impl*
end;//TkwCfAttributeSelectValuesZone.ParamsTypes

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfAttributeSelect));
 {* Регистрация типа AttributeSelect }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
