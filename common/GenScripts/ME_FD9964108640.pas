unit CompInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы CompInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\CompInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimF1Common_Module
 , nscTreeViewWithAdapterDragDrop
 , vtPanel
 , vtLabel
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
 Tkw_Form_CompInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы CompInfo
----
*Пример использования*:
[code]
'aControl' форма::CompInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_CompInfo

 Tkw_CompInfo_Control_tvComplectInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvComplectInfo
----
*Пример использования*:
[code]
контрол::tvComplectInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_tvComplectInfo

 Tkw_CompInfo_Control_tvComplectInfo_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvComplectInfo
----
*Пример использования*:
[code]
контрол::tvComplectInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_tvComplectInfo_Push

 Tkw_CompInfo_Control_pnBottom = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnBottom
----
*Пример использования*:
[code]
контрол::pnBottom TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_pnBottom

 Tkw_CompInfo_Control_pnBottom_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnBottom
----
*Пример использования*:
[code]
контрол::pnBottom:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnBottom_Push

 Tkw_CompInfo_Control_pnVisualRepresentationData = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnVisualRepresentationData
----
*Пример использования*:
[code]
контрол::pnVisualRepresentationData TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationData

 Tkw_CompInfo_Control_pnVisualRepresentationData_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnVisualRepresentationData
----
*Пример использования*:
[code]
контрол::pnVisualRepresentationData:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push

 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnVisualRepresentationDataCaption
----
*Пример использования*:
[code]
контрол::pnVisualRepresentationDataCaption TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption

 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnVisualRepresentationDataCaption
----
*Пример использования*:
[code]
контрол::pnVisualRepresentationDataCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push

 Tkw_CompInfo_Control_lblVisualRepresentationData = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblVisualRepresentationData
----
*Пример использования*:
[code]
контрол::lblVisualRepresentationData TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_lblVisualRepresentationData

 Tkw_CompInfo_Control_lblVisualRepresentationData_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblVisualRepresentationData
----
*Пример использования*:
[code]
контрол::lblVisualRepresentationData:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push

 TkwEnCompInfoTvComplectInfo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.tvComplectInfo
[panel]Контрол tvComplectInfo формы TenCompInfo[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenCompInfo .TenCompInfo.tvComplectInfo >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvComplectInfo(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TenCompInfo.tvComplectInfo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnCompInfoTvComplectInfo

 TkwEnCompInfoPnBottom = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.pnBottom
[panel]Контрол pnBottom формы TenCompInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenCompInfo .TenCompInfo.pnBottom >>> l_TvtPanel
[code]  }
  private
   function pnBottom(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtPanel;
    {* Реализация слова скрипта .TenCompInfo.pnBottom }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnCompInfoPnBottom

 TkwEnCompInfoPnVisualRepresentationData = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.pnVisualRepresentationData
[panel]Контрол pnVisualRepresentationData формы TenCompInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenCompInfo .TenCompInfo.pnVisualRepresentationData >>> l_TvtPanel
[code]  }
  private
   function pnVisualRepresentationData(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtPanel;
    {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationData }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnCompInfoPnVisualRepresentationData

 TkwEnCompInfoPnVisualRepresentationDataCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.pnVisualRepresentationDataCaption
[panel]Контрол pnVisualRepresentationDataCaption формы TenCompInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenCompInfo .TenCompInfo.pnVisualRepresentationDataCaption >>> l_TvtPanel
[code]  }
  private
   function pnVisualRepresentationDataCaption(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtPanel;
    {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationDataCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnCompInfoPnVisualRepresentationDataCaption

 TkwEnCompInfoLblVisualRepresentationData = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.lblVisualRepresentationData
[panel]Контрол lblVisualRepresentationData формы TenCompInfo[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aenCompInfo .TenCompInfo.lblVisualRepresentationData >>> l_TvtLabel
[code]  }
  private
   function lblVisualRepresentationData(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtLabel;
    {* Реализация слова скрипта .TenCompInfo.lblVisualRepresentationData }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnCompInfoLblVisualRepresentationData

class function Tkw_Form_CompInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::CompInfo';
end;//Tkw_Form_CompInfo.GetWordNameForRegister

function Tkw_Form_CompInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A3C9AF40C7D0_var*
//#UC END# *4DDFD2EA0116_A3C9AF40C7D0_var*
begin
//#UC START# *4DDFD2EA0116_A3C9AF40C7D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A3C9AF40C7D0_impl*
end;//Tkw_Form_CompInfo.GetString

class function Tkw_CompInfo_Control_tvComplectInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvComplectInfo';
end;//Tkw_CompInfo_Control_tvComplectInfo.GetWordNameForRegister

function Tkw_CompInfo_Control_tvComplectInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_93A68894CE91_var*
//#UC END# *4DDFD2EA0116_93A68894CE91_var*
begin
//#UC START# *4DDFD2EA0116_93A68894CE91_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_93A68894CE91_impl*
end;//Tkw_CompInfo_Control_tvComplectInfo.GetString

class procedure Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine;
//#UC START# *52A086150180_93A68894CE91_var*
//#UC END# *52A086150180_93A68894CE91_var*
begin
//#UC START# *52A086150180_93A68894CE91_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_93A68894CE91_impl*
end;//Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine

procedure Tkw_CompInfo_Control_tvComplectInfo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_582A15A18474_var*
//#UC END# *4DAEEDE10285_582A15A18474_var*
begin
//#UC START# *4DAEEDE10285_582A15A18474_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_582A15A18474_impl*
end;//Tkw_CompInfo_Control_tvComplectInfo_Push.DoDoIt

class function Tkw_CompInfo_Control_tvComplectInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvComplectInfo:push';
end;//Tkw_CompInfo_Control_tvComplectInfo_Push.GetWordNameForRegister

class function Tkw_CompInfo_Control_pnBottom.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBottom';
end;//Tkw_CompInfo_Control_pnBottom.GetWordNameForRegister

function Tkw_CompInfo_Control_pnBottom.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1124F46A0E54_var*
//#UC END# *4DDFD2EA0116_1124F46A0E54_var*
begin
//#UC START# *4DDFD2EA0116_1124F46A0E54_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1124F46A0E54_impl*
end;//Tkw_CompInfo_Control_pnBottom.GetString

class procedure Tkw_CompInfo_Control_pnBottom.RegisterInEngine;
//#UC START# *52A086150180_1124F46A0E54_var*
//#UC END# *52A086150180_1124F46A0E54_var*
begin
//#UC START# *52A086150180_1124F46A0E54_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1124F46A0E54_impl*
end;//Tkw_CompInfo_Control_pnBottom.RegisterInEngine

procedure Tkw_CompInfo_Control_pnBottom_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F89106EDBEB0_var*
//#UC END# *4DAEEDE10285_F89106EDBEB0_var*
begin
//#UC START# *4DAEEDE10285_F89106EDBEB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F89106EDBEB0_impl*
end;//Tkw_CompInfo_Control_pnBottom_Push.DoDoIt

class function Tkw_CompInfo_Control_pnBottom_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBottom:push';
end;//Tkw_CompInfo_Control_pnBottom_Push.GetWordNameForRegister

class function Tkw_CompInfo_Control_pnVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnVisualRepresentationData';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.GetWordNameForRegister

function Tkw_CompInfo_Control_pnVisualRepresentationData.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_94FF3D7D6FEE_var*
//#UC END# *4DDFD2EA0116_94FF3D7D6FEE_var*
begin
//#UC START# *4DDFD2EA0116_94FF3D7D6FEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_94FF3D7D6FEE_impl*
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.GetString

class procedure Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine;
//#UC START# *52A086150180_94FF3D7D6FEE_var*
//#UC END# *52A086150180_94FF3D7D6FEE_var*
begin
//#UC START# *52A086150180_94FF3D7D6FEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_94FF3D7D6FEE_impl*
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine

procedure Tkw_CompInfo_Control_pnVisualRepresentationData_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_605CF8C2A63A_var*
//#UC END# *4DAEEDE10285_605CF8C2A63A_var*
begin
//#UC START# *4DAEEDE10285_605CF8C2A63A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_605CF8C2A63A_impl*
end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push.DoDoIt

class function Tkw_CompInfo_Control_pnVisualRepresentationData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnVisualRepresentationData:push';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push.GetWordNameForRegister

class function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnVisualRepresentationDataCaption';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetWordNameForRegister

function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4669E9FC848B_var*
//#UC END# *4DDFD2EA0116_4669E9FC848B_var*
begin
//#UC START# *4DDFD2EA0116_4669E9FC848B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4669E9FC848B_impl*
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetString

class procedure Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine;
//#UC START# *52A086150180_4669E9FC848B_var*
//#UC END# *52A086150180_4669E9FC848B_var*
begin
//#UC START# *52A086150180_4669E9FC848B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4669E9FC848B_impl*
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine

procedure Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4D3738B14DF7_var*
//#UC END# *4DAEEDE10285_4D3738B14DF7_var*
begin
//#UC START# *4DAEEDE10285_4D3738B14DF7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4D3738B14DF7_impl*
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.DoDoIt

class function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnVisualRepresentationDataCaption:push';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.GetWordNameForRegister

class function Tkw_CompInfo_Control_lblVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblVisualRepresentationData';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.GetWordNameForRegister

function Tkw_CompInfo_Control_lblVisualRepresentationData.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_05C07A6F62A5_var*
//#UC END# *4DDFD2EA0116_05C07A6F62A5_var*
begin
//#UC START# *4DDFD2EA0116_05C07A6F62A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_05C07A6F62A5_impl*
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.GetString

class procedure Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine;
//#UC START# *52A086150180_05C07A6F62A5_var*
//#UC END# *52A086150180_05C07A6F62A5_var*
begin
//#UC START# *52A086150180_05C07A6F62A5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_05C07A6F62A5_impl*
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine

procedure Tkw_CompInfo_Control_lblVisualRepresentationData_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BEA5480BA2FA_var*
//#UC END# *4DAEEDE10285_BEA5480BA2FA_var*
begin
//#UC START# *4DAEEDE10285_BEA5480BA2FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BEA5480BA2FA_impl*
end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push.DoDoIt

class function Tkw_CompInfo_Control_lblVisualRepresentationData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblVisualRepresentationData:push';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push.GetWordNameForRegister

function TkwEnCompInfoTvComplectInfo.tvComplectInfo(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TenCompInfo.tvComplectInfo }
//#UC START# *92A9610CDDDC_CA0E729726DA_var*
//#UC END# *92A9610CDDDC_CA0E729726DA_var*
begin
//#UC START# *92A9610CDDDC_CA0E729726DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *92A9610CDDDC_CA0E729726DA_impl*
end;//TkwEnCompInfoTvComplectInfo.tvComplectInfo

procedure TkwEnCompInfoTvComplectInfo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CA0E729726DA_var*
//#UC END# *4DAEEDE10285_CA0E729726DA_var*
begin
//#UC START# *4DAEEDE10285_CA0E729726DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CA0E729726DA_impl*
end;//TkwEnCompInfoTvComplectInfo.DoDoIt

class function TkwEnCompInfoTvComplectInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.tvComplectInfo';
end;//TkwEnCompInfoTvComplectInfo.GetWordNameForRegister

procedure TkwEnCompInfoTvComplectInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_CA0E729726DA_var*
//#UC END# *52D00B00031A_CA0E729726DA_var*
begin
//#UC START# *52D00B00031A_CA0E729726DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_CA0E729726DA_impl*
end;//TkwEnCompInfoTvComplectInfo.SetValuePrim

function TkwEnCompInfoTvComplectInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnCompInfoTvComplectInfo.GetResultTypeInfo

function TkwEnCompInfoTvComplectInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCompInfoTvComplectInfo.GetAllParamsCount

function TkwEnCompInfoTvComplectInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnCompInfoTvComplectInfo.ParamsTypes

function TkwEnCompInfoPnBottom.pnBottom(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtPanel;
 {* Реализация слова скрипта .TenCompInfo.pnBottom }
//#UC START# *C3B5CC3A15F6_BB03EE607F17_var*
//#UC END# *C3B5CC3A15F6_BB03EE607F17_var*
begin
//#UC START# *C3B5CC3A15F6_BB03EE607F17_impl*
 !!! Needs to be implemented !!!
//#UC END# *C3B5CC3A15F6_BB03EE607F17_impl*
end;//TkwEnCompInfoPnBottom.pnBottom

procedure TkwEnCompInfoPnBottom.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BB03EE607F17_var*
//#UC END# *4DAEEDE10285_BB03EE607F17_var*
begin
//#UC START# *4DAEEDE10285_BB03EE607F17_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BB03EE607F17_impl*
end;//TkwEnCompInfoPnBottom.DoDoIt

class function TkwEnCompInfoPnBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.pnBottom';
end;//TkwEnCompInfoPnBottom.GetWordNameForRegister

procedure TkwEnCompInfoPnBottom.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BB03EE607F17_var*
//#UC END# *52D00B00031A_BB03EE607F17_var*
begin
//#UC START# *52D00B00031A_BB03EE607F17_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BB03EE607F17_impl*
end;//TkwEnCompInfoPnBottom.SetValuePrim

function TkwEnCompInfoPnBottom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnCompInfoPnBottom.GetResultTypeInfo

function TkwEnCompInfoPnBottom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCompInfoPnBottom.GetAllParamsCount

function TkwEnCompInfoPnBottom.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnCompInfoPnBottom.ParamsTypes

function TkwEnCompInfoPnVisualRepresentationData.pnVisualRepresentationData(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtPanel;
 {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationData }
//#UC START# *B1D60ABCDB69_ED2685ED0E01_var*
//#UC END# *B1D60ABCDB69_ED2685ED0E01_var*
begin
//#UC START# *B1D60ABCDB69_ED2685ED0E01_impl*
 !!! Needs to be implemented !!!
//#UC END# *B1D60ABCDB69_ED2685ED0E01_impl*
end;//TkwEnCompInfoPnVisualRepresentationData.pnVisualRepresentationData

procedure TkwEnCompInfoPnVisualRepresentationData.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ED2685ED0E01_var*
//#UC END# *4DAEEDE10285_ED2685ED0E01_var*
begin
//#UC START# *4DAEEDE10285_ED2685ED0E01_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ED2685ED0E01_impl*
end;//TkwEnCompInfoPnVisualRepresentationData.DoDoIt

class function TkwEnCompInfoPnVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.pnVisualRepresentationData';
end;//TkwEnCompInfoPnVisualRepresentationData.GetWordNameForRegister

procedure TkwEnCompInfoPnVisualRepresentationData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_ED2685ED0E01_var*
//#UC END# *52D00B00031A_ED2685ED0E01_var*
begin
//#UC START# *52D00B00031A_ED2685ED0E01_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_ED2685ED0E01_impl*
end;//TkwEnCompInfoPnVisualRepresentationData.SetValuePrim

function TkwEnCompInfoPnVisualRepresentationData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnCompInfoPnVisualRepresentationData.GetResultTypeInfo

function TkwEnCompInfoPnVisualRepresentationData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCompInfoPnVisualRepresentationData.GetAllParamsCount

function TkwEnCompInfoPnVisualRepresentationData.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnCompInfoPnVisualRepresentationData.ParamsTypes

function TkwEnCompInfoPnVisualRepresentationDataCaption.pnVisualRepresentationDataCaption(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtPanel;
 {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationDataCaption }
//#UC START# *645717FD5779_12AEC3D1A33C_var*
//#UC END# *645717FD5779_12AEC3D1A33C_var*
begin
//#UC START# *645717FD5779_12AEC3D1A33C_impl*
 !!! Needs to be implemented !!!
//#UC END# *645717FD5779_12AEC3D1A33C_impl*
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.pnVisualRepresentationDataCaption

procedure TkwEnCompInfoPnVisualRepresentationDataCaption.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_12AEC3D1A33C_var*
//#UC END# *4DAEEDE10285_12AEC3D1A33C_var*
begin
//#UC START# *4DAEEDE10285_12AEC3D1A33C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_12AEC3D1A33C_impl*
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.DoDoIt

class function TkwEnCompInfoPnVisualRepresentationDataCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.pnVisualRepresentationDataCaption';
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.GetWordNameForRegister

procedure TkwEnCompInfoPnVisualRepresentationDataCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_12AEC3D1A33C_var*
//#UC END# *52D00B00031A_12AEC3D1A33C_var*
begin
//#UC START# *52D00B00031A_12AEC3D1A33C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_12AEC3D1A33C_impl*
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.SetValuePrim

function TkwEnCompInfoPnVisualRepresentationDataCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.GetResultTypeInfo

function TkwEnCompInfoPnVisualRepresentationDataCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.GetAllParamsCount

function TkwEnCompInfoPnVisualRepresentationDataCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.ParamsTypes

function TkwEnCompInfoLblVisualRepresentationData.lblVisualRepresentationData(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtLabel;
 {* Реализация слова скрипта .TenCompInfo.lblVisualRepresentationData }
//#UC START# *13FC19350BCA_317E9A769DAB_var*
//#UC END# *13FC19350BCA_317E9A769DAB_var*
begin
//#UC START# *13FC19350BCA_317E9A769DAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *13FC19350BCA_317E9A769DAB_impl*
end;//TkwEnCompInfoLblVisualRepresentationData.lblVisualRepresentationData

procedure TkwEnCompInfoLblVisualRepresentationData.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_317E9A769DAB_var*
//#UC END# *4DAEEDE10285_317E9A769DAB_var*
begin
//#UC START# *4DAEEDE10285_317E9A769DAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_317E9A769DAB_impl*
end;//TkwEnCompInfoLblVisualRepresentationData.DoDoIt

class function TkwEnCompInfoLblVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.lblVisualRepresentationData';
end;//TkwEnCompInfoLblVisualRepresentationData.GetWordNameForRegister

procedure TkwEnCompInfoLblVisualRepresentationData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_317E9A769DAB_var*
//#UC END# *52D00B00031A_317E9A769DAB_var*
begin
//#UC START# *52D00B00031A_317E9A769DAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_317E9A769DAB_impl*
end;//TkwEnCompInfoLblVisualRepresentationData.SetValuePrim

function TkwEnCompInfoLblVisualRepresentationData.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnCompInfoLblVisualRepresentationData.GetResultTypeInfo

function TkwEnCompInfoLblVisualRepresentationData.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCompInfoLblVisualRepresentationData.GetAllParamsCount

function TkwEnCompInfoLblVisualRepresentationData.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnCompInfoLblVisualRepresentationData.ParamsTypes

initialization
 Tkw_Form_CompInfo.RegisterInEngine;
 {* Регистрация Tkw_Form_CompInfo }
 Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_tvComplectInfo }
 Tkw_CompInfo_Control_tvComplectInfo_Push.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_tvComplectInfo_Push }
 Tkw_CompInfo_Control_pnBottom.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_pnBottom }
 Tkw_CompInfo_Control_pnBottom_Push.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_pnBottom_Push }
 Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_pnVisualRepresentationData }
 Tkw_CompInfo_Control_pnVisualRepresentationData_Push.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_pnVisualRepresentationData_Push }
 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_pnVisualRepresentationDataCaption }
 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push }
 Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_lblVisualRepresentationData }
 Tkw_CompInfo_Control_lblVisualRepresentationData_Push.RegisterInEngine;
 {* Регистрация Tkw_CompInfo_Control_lblVisualRepresentationData_Push }
 TkwEnCompInfoTvComplectInfo.RegisterInEngine;
 {* Регистрация enCompInfo_tvComplectInfo }
 TkwEnCompInfoPnBottom.RegisterInEngine;
 {* Регистрация enCompInfo_pnBottom }
 TkwEnCompInfoPnVisualRepresentationData.RegisterInEngine;
 {* Регистрация enCompInfo_pnVisualRepresentationData }
 TkwEnCompInfoPnVisualRepresentationDataCaption.RegisterInEngine;
 {* Регистрация enCompInfo_pnVisualRepresentationDataCaption }
 TkwEnCompInfoLblVisualRepresentationData.RegisterInEngine;
 {* Регистрация enCompInfo_lblVisualRepresentationData }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenCompInfo));
 {* Регистрация типа CompInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
