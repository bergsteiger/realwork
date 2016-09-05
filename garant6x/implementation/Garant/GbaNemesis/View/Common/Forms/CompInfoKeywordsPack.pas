unit CompInfoKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы CompInfo }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CompInfoKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "CompInfoKeywordsPack" MUID: (4ABB769903BF_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , CompInfo_Form
 , tfwPropertyLike
 , nscTreeViewWithAdapterDragDrop
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtPanel
 , vtLabel
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4ABB769903BF_Packimpl_uses*
 //#UC END# *4ABB769903BF_Packimpl_uses*
;

type
 TkwEnCompInfoTvComplectInfo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.tvComplectInfo }
  private
   function tvComplectInfo(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TenCompInfo.tvComplectInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnCompInfoTvComplectInfo

 TkwEnCompInfoPnBottom = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.pnBottom }
  private
   function pnBottom(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtPanel;
    {* Реализация слова скрипта .TenCompInfo.pnBottom }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnCompInfoPnBottom

 TkwEnCompInfoPnVisualRepresentationData = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.pnVisualRepresentationData }
  private
   function pnVisualRepresentationData(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtPanel;
    {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationData }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnCompInfoPnVisualRepresentationData

 TkwEnCompInfoPnVisualRepresentationDataCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.pnVisualRepresentationDataCaption }
  private
   function pnVisualRepresentationDataCaption(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtPanel;
    {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationDataCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnCompInfoPnVisualRepresentationDataCaption

 TkwEnCompInfoLblVisualRepresentationData = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenCompInfo.lblVisualRepresentationData }
  private
   function lblVisualRepresentationData(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtLabel;
    {* Реализация слова скрипта .TenCompInfo.lblVisualRepresentationData }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnCompInfoLblVisualRepresentationData

 Tkw_Form_CompInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы CompInfo
----
*Пример использования*:
[code]форма::CompInfo TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_CompInfo

 Tkw_CompInfo_Control_tvComplectInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvComplectInfo
----
*Пример использования*:
[code]контрол::tvComplectInfo TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_tvComplectInfo

 Tkw_CompInfo_Control_tvComplectInfo_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvComplectInfo
----
*Пример использования*:
[code]контрол::tvComplectInfo:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_tvComplectInfo_Push

 Tkw_CompInfo_Control_pnBottom = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnBottom
----
*Пример использования*:
[code]контрол::pnBottom TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnBottom

 Tkw_CompInfo_Control_pnBottom_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnBottom
----
*Пример использования*:
[code]контрол::pnBottom:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnBottom_Push

 Tkw_CompInfo_Control_pnVisualRepresentationData = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnVisualRepresentationData
----
*Пример использования*:
[code]контрол::pnVisualRepresentationData TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationData

 Tkw_CompInfo_Control_pnVisualRepresentationData_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnVisualRepresentationData
----
*Пример использования*:
[code]контрол::pnVisualRepresentationData:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push

 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnVisualRepresentationDataCaption
----
*Пример использования*:
[code]контрол::pnVisualRepresentationDataCaption TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption

 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnVisualRepresentationDataCaption
----
*Пример использования*:
[code]контрол::pnVisualRepresentationDataCaption:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push

 Tkw_CompInfo_Control_lblVisualRepresentationData = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblVisualRepresentationData
----
*Пример использования*:
[code]контрол::lblVisualRepresentationData TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_lblVisualRepresentationData

 Tkw_CompInfo_Control_lblVisualRepresentationData_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblVisualRepresentationData
----
*Пример использования*:
[code]контрол::lblVisualRepresentationData:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push

function TkwEnCompInfoTvComplectInfo.tvComplectInfo(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TenCompInfo.tvComplectInfo }
begin
 Result := aenCompInfo.tvComplectInfo;
end;//TkwEnCompInfoTvComplectInfo.tvComplectInfo

class function TkwEnCompInfoTvComplectInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.tvComplectInfo';
end;//TkwEnCompInfoTvComplectInfo.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoTvComplectInfo.ParamsTypes

procedure TkwEnCompInfoTvComplectInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvComplectInfo', aCtx);
end;//TkwEnCompInfoTvComplectInfo.SetValuePrim

procedure TkwEnCompInfoTvComplectInfo.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
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
 aCtx.rEngine.PushObj(tvComplectInfo(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoTvComplectInfo.DoDoIt

function TkwEnCompInfoPnBottom.pnBottom(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtPanel;
 {* Реализация слова скрипта .TenCompInfo.pnBottom }
begin
 Result := aenCompInfo.pnBottom;
end;//TkwEnCompInfoPnBottom.pnBottom

class function TkwEnCompInfoPnBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.pnBottom';
end;//TkwEnCompInfoPnBottom.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoPnBottom.ParamsTypes

procedure TkwEnCompInfoPnBottom.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnBottom', aCtx);
end;//TkwEnCompInfoPnBottom.SetValuePrim

procedure TkwEnCompInfoPnBottom.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
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
 aCtx.rEngine.PushObj(pnBottom(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoPnBottom.DoDoIt

function TkwEnCompInfoPnVisualRepresentationData.pnVisualRepresentationData(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtPanel;
 {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationData }
begin
 Result := aenCompInfo.pnVisualRepresentationData;
end;//TkwEnCompInfoPnVisualRepresentationData.pnVisualRepresentationData

class function TkwEnCompInfoPnVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.pnVisualRepresentationData';
end;//TkwEnCompInfoPnVisualRepresentationData.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoPnVisualRepresentationData.ParamsTypes

procedure TkwEnCompInfoPnVisualRepresentationData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnVisualRepresentationData', aCtx);
end;//TkwEnCompInfoPnVisualRepresentationData.SetValuePrim

procedure TkwEnCompInfoPnVisualRepresentationData.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
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
 aCtx.rEngine.PushObj(pnVisualRepresentationData(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoPnVisualRepresentationData.DoDoIt

function TkwEnCompInfoPnVisualRepresentationDataCaption.pnVisualRepresentationDataCaption(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtPanel;
 {* Реализация слова скрипта .TenCompInfo.pnVisualRepresentationDataCaption }
begin
 Result := aenCompInfo.pnVisualRepresentationDataCaption;
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.pnVisualRepresentationDataCaption

class function TkwEnCompInfoPnVisualRepresentationDataCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.pnVisualRepresentationDataCaption';
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.ParamsTypes

procedure TkwEnCompInfoPnVisualRepresentationDataCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnVisualRepresentationDataCaption', aCtx);
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.SetValuePrim

procedure TkwEnCompInfoPnVisualRepresentationDataCaption.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
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
 aCtx.rEngine.PushObj(pnVisualRepresentationDataCaption(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.DoDoIt

function TkwEnCompInfoLblVisualRepresentationData.lblVisualRepresentationData(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtLabel;
 {* Реализация слова скрипта .TenCompInfo.lblVisualRepresentationData }
begin
 Result := aenCompInfo.lblVisualRepresentationData;
end;//TkwEnCompInfoLblVisualRepresentationData.lblVisualRepresentationData

class function TkwEnCompInfoLblVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.lblVisualRepresentationData';
end;//TkwEnCompInfoLblVisualRepresentationData.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoLblVisualRepresentationData.ParamsTypes

procedure TkwEnCompInfoLblVisualRepresentationData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblVisualRepresentationData', aCtx);
end;//TkwEnCompInfoLblVisualRepresentationData.SetValuePrim

procedure TkwEnCompInfoLblVisualRepresentationData.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
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
 aCtx.rEngine.PushObj(lblVisualRepresentationData(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoLblVisualRepresentationData.DoDoIt

function Tkw_Form_CompInfo.GetString: AnsiString;
begin
 Result := 'enCompInfo';
end;//Tkw_Form_CompInfo.GetString

class procedure Tkw_Form_CompInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TenCompInfo);
end;//Tkw_Form_CompInfo.RegisterInEngine

class function Tkw_Form_CompInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::CompInfo';
end;//Tkw_Form_CompInfo.GetWordNameForRegister

function Tkw_CompInfo_Control_tvComplectInfo.GetString: AnsiString;
begin
 Result := 'tvComplectInfo';
end;//Tkw_CompInfo_Control_tvComplectInfo.GetString

class procedure Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine

class function Tkw_CompInfo_Control_tvComplectInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvComplectInfo';
end;//Tkw_CompInfo_Control_tvComplectInfo.GetWordNameForRegister

procedure Tkw_CompInfo_Control_tvComplectInfo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvComplectInfo');
 inherited;
end;//Tkw_CompInfo_Control_tvComplectInfo_Push.DoDoIt

class function Tkw_CompInfo_Control_tvComplectInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvComplectInfo:push';
end;//Tkw_CompInfo_Control_tvComplectInfo_Push.GetWordNameForRegister

function Tkw_CompInfo_Control_pnBottom.GetString: AnsiString;
begin
 Result := 'pnBottom';
end;//Tkw_CompInfo_Control_pnBottom.GetString

class procedure Tkw_CompInfo_Control_pnBottom.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CompInfo_Control_pnBottom.RegisterInEngine

class function Tkw_CompInfo_Control_pnBottom.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBottom';
end;//Tkw_CompInfo_Control_pnBottom.GetWordNameForRegister

procedure Tkw_CompInfo_Control_pnBottom_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnBottom');
 inherited;
end;//Tkw_CompInfo_Control_pnBottom_Push.DoDoIt

class function Tkw_CompInfo_Control_pnBottom_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBottom:push';
end;//Tkw_CompInfo_Control_pnBottom_Push.GetWordNameForRegister

function Tkw_CompInfo_Control_pnVisualRepresentationData.GetString: AnsiString;
begin
 Result := 'pnVisualRepresentationData';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.GetString

class procedure Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine

class function Tkw_CompInfo_Control_pnVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnVisualRepresentationData';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.GetWordNameForRegister

procedure Tkw_CompInfo_Control_pnVisualRepresentationData_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnVisualRepresentationData');
 inherited;
end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push.DoDoIt

class function Tkw_CompInfo_Control_pnVisualRepresentationData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnVisualRepresentationData:push';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push.GetWordNameForRegister

function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetString: AnsiString;
begin
 Result := 'pnVisualRepresentationDataCaption';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetString

class procedure Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine

class function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnVisualRepresentationDataCaption';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetWordNameForRegister

procedure Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnVisualRepresentationDataCaption');
 inherited;
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.DoDoIt

class function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnVisualRepresentationDataCaption:push';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.GetWordNameForRegister

function Tkw_CompInfo_Control_lblVisualRepresentationData.GetString: AnsiString;
begin
 Result := 'lblVisualRepresentationData';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.GetString

class procedure Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine

class function Tkw_CompInfo_Control_lblVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblVisualRepresentationData';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.GetWordNameForRegister

procedure Tkw_CompInfo_Control_lblVisualRepresentationData_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblVisualRepresentationData');
 inherited;
end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push.DoDoIt

class function Tkw_CompInfo_Control_lblVisualRepresentationData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblVisualRepresentationData:push';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push.GetWordNameForRegister

initialization
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenCompInfo));
 {* Регистрация типа TenCompInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
