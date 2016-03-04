unit CompInfoKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� CompInfo }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\CompInfoKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscTreeViewWithAdapterDragDrop
 , vtPanel
 , vtLabel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , CompInfo_Form
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
 Tkw_Form_CompInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� CompInfo
----
*������ �������������*:
[code]
'aControl' �����::CompInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_CompInfo

 Tkw_CompInfo_Control_tvComplectInfo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvComplectInfo
----
*������ �������������*:
[code]
�������::tvComplectInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_tvComplectInfo

 Tkw_CompInfo_Control_tvComplectInfo_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvComplectInfo
----
*������ �������������*:
[code]
�������::tvComplectInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_tvComplectInfo_Push

 Tkw_CompInfo_Control_pnBottom = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnBottom
----
*������ �������������*:
[code]
�������::pnBottom TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_pnBottom

 Tkw_CompInfo_Control_pnBottom_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnBottom
----
*������ �������������*:
[code]
�������::pnBottom:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnBottom_Push

 Tkw_CompInfo_Control_pnVisualRepresentationData = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnVisualRepresentationData
----
*������ �������������*:
[code]
�������::pnVisualRepresentationData TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationData

 Tkw_CompInfo_Control_pnVisualRepresentationData_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnVisualRepresentationData
----
*������ �������������*:
[code]
�������::pnVisualRepresentationData:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push

 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnVisualRepresentationDataCaption
----
*������ �������������*:
[code]
�������::pnVisualRepresentationDataCaption TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption

 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnVisualRepresentationDataCaption
----
*������ �������������*:
[code]
�������::pnVisualRepresentationDataCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push

 Tkw_CompInfo_Control_lblVisualRepresentationData = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblVisualRepresentationData
----
*������ �������������*:
[code]
�������::lblVisualRepresentationData TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CompInfo_Control_lblVisualRepresentationData

 Tkw_CompInfo_Control_lblVisualRepresentationData_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblVisualRepresentationData
----
*������ �������������*:
[code]
�������::lblVisualRepresentationData:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push

 TkwEnCompInfoTvComplectInfo = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenCompInfo.tvComplectInfo
[panel]������� tvComplectInfo ����� TenCompInfo[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenCompInfo .TenCompInfo.tvComplectInfo >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvComplectInfo(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TenCompInfo.tvComplectInfo }
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
  {* ����� ������� .TenCompInfo.pnBottom
[panel]������� pnBottom ����� TenCompInfo[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aenCompInfo .TenCompInfo.pnBottom >>> l_TvtPanel
[code]  }
  private
   function pnBottom(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtPanel;
    {* ���������� ����� ������� .TenCompInfo.pnBottom }
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
  {* ����� ������� .TenCompInfo.pnVisualRepresentationData
[panel]������� pnVisualRepresentationData ����� TenCompInfo[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aenCompInfo .TenCompInfo.pnVisualRepresentationData >>> l_TvtPanel
[code]  }
  private
   function pnVisualRepresentationData(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtPanel;
    {* ���������� ����� ������� .TenCompInfo.pnVisualRepresentationData }
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
  {* ����� ������� .TenCompInfo.pnVisualRepresentationDataCaption
[panel]������� pnVisualRepresentationDataCaption ����� TenCompInfo[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aenCompInfo .TenCompInfo.pnVisualRepresentationDataCaption >>> l_TvtPanel
[code]  }
  private
   function pnVisualRepresentationDataCaption(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtPanel;
    {* ���������� ����� ������� .TenCompInfo.pnVisualRepresentationDataCaption }
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
  {* ����� ������� .TenCompInfo.lblVisualRepresentationData
[panel]������� lblVisualRepresentationData ����� TenCompInfo[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aenCompInfo .TenCompInfo.lblVisualRepresentationData >>> l_TvtLabel
[code]  }
  private
   function lblVisualRepresentationData(const aCtx: TtfwContext;
    aenCompInfo: TenCompInfo): TvtLabel;
    {* ���������� ����� ������� .TenCompInfo.lblVisualRepresentationData }
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
 Result := '�����::CompInfo';
end;//Tkw_Form_CompInfo.GetWordNameForRegister

function Tkw_Form_CompInfo.GetString: AnsiString;
begin
 Result := 'enCompInfo';
end;//Tkw_Form_CompInfo.GetString

class function Tkw_CompInfo_Control_tvComplectInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvComplectInfo';
end;//Tkw_CompInfo_Control_tvComplectInfo.GetWordNameForRegister

function Tkw_CompInfo_Control_tvComplectInfo.GetString: AnsiString;
begin
 Result := 'tvComplectInfo';
end;//Tkw_CompInfo_Control_tvComplectInfo.GetString

class procedure Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine

procedure Tkw_CompInfo_Control_tvComplectInfo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvComplectInfo');
 inherited;
end;//Tkw_CompInfo_Control_tvComplectInfo_Push.DoDoIt

class function Tkw_CompInfo_Control_tvComplectInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvComplectInfo:push';
end;//Tkw_CompInfo_Control_tvComplectInfo_Push.GetWordNameForRegister

class function Tkw_CompInfo_Control_pnBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBottom';
end;//Tkw_CompInfo_Control_pnBottom.GetWordNameForRegister

function Tkw_CompInfo_Control_pnBottom.GetString: AnsiString;
begin
 Result := 'pnBottom';
end;//Tkw_CompInfo_Control_pnBottom.GetString

class procedure Tkw_CompInfo_Control_pnBottom.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CompInfo_Control_pnBottom.RegisterInEngine

procedure Tkw_CompInfo_Control_pnBottom_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnBottom');
 inherited;
end;//Tkw_CompInfo_Control_pnBottom_Push.DoDoIt

class function Tkw_CompInfo_Control_pnBottom_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBottom:push';
end;//Tkw_CompInfo_Control_pnBottom_Push.GetWordNameForRegister

class function Tkw_CompInfo_Control_pnVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnVisualRepresentationData';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.GetWordNameForRegister

function Tkw_CompInfo_Control_pnVisualRepresentationData.GetString: AnsiString;
begin
 Result := 'pnVisualRepresentationData';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.GetString

class procedure Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine

procedure Tkw_CompInfo_Control_pnVisualRepresentationData_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnVisualRepresentationData');
 inherited;
end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push.DoDoIt

class function Tkw_CompInfo_Control_pnVisualRepresentationData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnVisualRepresentationData:push';
end;//Tkw_CompInfo_Control_pnVisualRepresentationData_Push.GetWordNameForRegister

class function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnVisualRepresentationDataCaption';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetWordNameForRegister

function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetString: AnsiString;
begin
 Result := 'pnVisualRepresentationDataCaption';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.GetString

class procedure Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine

procedure Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnVisualRepresentationDataCaption');
 inherited;
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.DoDoIt

class function Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnVisualRepresentationDataCaption:push';
end;//Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.GetWordNameForRegister

class function Tkw_CompInfo_Control_lblVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblVisualRepresentationData';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.GetWordNameForRegister

function Tkw_CompInfo_Control_lblVisualRepresentationData.GetString: AnsiString;
begin
 Result := 'lblVisualRepresentationData';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.GetString

class procedure Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine

procedure Tkw_CompInfo_Control_lblVisualRepresentationData_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblVisualRepresentationData');
 inherited;
end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push.DoDoIt

class function Tkw_CompInfo_Control_lblVisualRepresentationData_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblVisualRepresentationData:push';
end;//Tkw_CompInfo_Control_lblVisualRepresentationData_Push.GetWordNameForRegister

function TkwEnCompInfoTvComplectInfo.tvComplectInfo(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TenCompInfo.tvComplectInfo }
begin
 Result := aenCompInfo.tvComplectInfo;
end;//TkwEnCompInfoTvComplectInfo.tvComplectInfo

procedure TkwEnCompInfoTvComplectInfo.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvComplectInfo(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoTvComplectInfo.DoDoIt

class function TkwEnCompInfoTvComplectInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.tvComplectInfo';
end;//TkwEnCompInfoTvComplectInfo.GetWordNameForRegister

procedure TkwEnCompInfoTvComplectInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvComplectInfo', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoTvComplectInfo.ParamsTypes

function TkwEnCompInfoPnBottom.pnBottom(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtPanel;
 {* ���������� ����� ������� .TenCompInfo.pnBottom }
begin
 Result := aenCompInfo.pnBottom;
end;//TkwEnCompInfoPnBottom.pnBottom

procedure TkwEnCompInfoPnBottom.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnBottom(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoPnBottom.DoDoIt

class function TkwEnCompInfoPnBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.pnBottom';
end;//TkwEnCompInfoPnBottom.GetWordNameForRegister

procedure TkwEnCompInfoPnBottom.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnBottom', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoPnBottom.ParamsTypes

function TkwEnCompInfoPnVisualRepresentationData.pnVisualRepresentationData(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtPanel;
 {* ���������� ����� ������� .TenCompInfo.pnVisualRepresentationData }
begin
 Result := aenCompInfo.pnVisualRepresentationData;
end;//TkwEnCompInfoPnVisualRepresentationData.pnVisualRepresentationData

procedure TkwEnCompInfoPnVisualRepresentationData.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnVisualRepresentationData(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoPnVisualRepresentationData.DoDoIt

class function TkwEnCompInfoPnVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.pnVisualRepresentationData';
end;//TkwEnCompInfoPnVisualRepresentationData.GetWordNameForRegister

procedure TkwEnCompInfoPnVisualRepresentationData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnVisualRepresentationData', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoPnVisualRepresentationData.ParamsTypes

function TkwEnCompInfoPnVisualRepresentationDataCaption.pnVisualRepresentationDataCaption(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtPanel;
 {* ���������� ����� ������� .TenCompInfo.pnVisualRepresentationDataCaption }
begin
 Result := aenCompInfo.pnVisualRepresentationDataCaption;
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.pnVisualRepresentationDataCaption

procedure TkwEnCompInfoPnVisualRepresentationDataCaption.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnVisualRepresentationDataCaption(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.DoDoIt

class function TkwEnCompInfoPnVisualRepresentationDataCaption.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.pnVisualRepresentationDataCaption';
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.GetWordNameForRegister

procedure TkwEnCompInfoPnVisualRepresentationDataCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnVisualRepresentationDataCaption', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoPnVisualRepresentationDataCaption.ParamsTypes

function TkwEnCompInfoLblVisualRepresentationData.lblVisualRepresentationData(const aCtx: TtfwContext;
 aenCompInfo: TenCompInfo): TvtLabel;
 {* ���������� ����� ������� .TenCompInfo.lblVisualRepresentationData }
begin
 Result := aenCompInfo.lblVisualRepresentationData;
end;//TkwEnCompInfoLblVisualRepresentationData.lblVisualRepresentationData

procedure TkwEnCompInfoLblVisualRepresentationData.DoDoIt(const aCtx: TtfwContext);
var l_aenCompInfo: TenCompInfo;
begin
 try
  l_aenCompInfo := TenCompInfo(aCtx.rEngine.PopObjAs(TenCompInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aenCompInfo: TenCompInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblVisualRepresentationData(aCtx, l_aenCompInfo));
end;//TkwEnCompInfoLblVisualRepresentationData.DoDoIt

class function TkwEnCompInfoLblVisualRepresentationData.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenCompInfo.lblVisualRepresentationData';
end;//TkwEnCompInfoLblVisualRepresentationData.GetWordNameForRegister

procedure TkwEnCompInfoLblVisualRepresentationData.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblVisualRepresentationData', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TenCompInfo)]);
end;//TkwEnCompInfoLblVisualRepresentationData.ParamsTypes

initialization
 Tkw_Form_CompInfo.RegisterInEngine;
 {* ����������� Tkw_Form_CompInfo }
 Tkw_CompInfo_Control_tvComplectInfo.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_tvComplectInfo }
 Tkw_CompInfo_Control_tvComplectInfo_Push.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_tvComplectInfo_Push }
 Tkw_CompInfo_Control_pnBottom.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_pnBottom }
 Tkw_CompInfo_Control_pnBottom_Push.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_pnBottom_Push }
 Tkw_CompInfo_Control_pnVisualRepresentationData.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_pnVisualRepresentationData }
 Tkw_CompInfo_Control_pnVisualRepresentationData_Push.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_pnVisualRepresentationData_Push }
 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_pnVisualRepresentationDataCaption }
 Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_pnVisualRepresentationDataCaption_Push }
 Tkw_CompInfo_Control_lblVisualRepresentationData.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_lblVisualRepresentationData }
 Tkw_CompInfo_Control_lblVisualRepresentationData_Push.RegisterInEngine;
 {* ����������� Tkw_CompInfo_Control_lblVisualRepresentationData_Push }
 TkwEnCompInfoTvComplectInfo.RegisterInEngine;
 {* ����������� enCompInfo_tvComplectInfo }
 TkwEnCompInfoPnBottom.RegisterInEngine;
 {* ����������� enCompInfo_pnBottom }
 TkwEnCompInfoPnVisualRepresentationData.RegisterInEngine;
 {* ����������� enCompInfo_pnVisualRepresentationData }
 TkwEnCompInfoPnVisualRepresentationDataCaption.RegisterInEngine;
 {* ����������� enCompInfo_pnVisualRepresentationDataCaption }
 TkwEnCompInfoLblVisualRepresentationData.RegisterInEngine;
 {* ����������� enCompInfo_lblVisualRepresentationData }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenCompInfo));
 {* ����������� ���� CompInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
