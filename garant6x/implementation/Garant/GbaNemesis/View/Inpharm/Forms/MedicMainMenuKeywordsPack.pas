unit MedicMainMenuKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� MedicMainMenu }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicMainMenuKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "MedicMainMenuKeywordsPack" MUID: (4AB9E67A00A7_Pack)

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
 , MedicMainMenu_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnMedicMainMenuPnlMain = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MedicMainMenu.pnlMain }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
    {* ���������� ����� ������� .Ten_MedicMainMenu.pnlMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuPnlMain

 TkwEnMedicMainMenuHfLastOpenDocs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MedicMainMenu.hfLastOpenDocs }
  private
   function hfLastOpenDocs(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* ���������� ����� ������� .Ten_MedicMainMenu.hfLastOpenDocs }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuHfLastOpenDocs

 TkwEnMedicMainMenuTvLastOpenDocs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MedicMainMenu.tvLastOpenDocs }
  private
   function tvLastOpenDocs(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .Ten_MedicMainMenu.tvLastOpenDocs }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuTvLastOpenDocs

 Tkw_Form_MedicMainMenu = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� MedicMainMenu
----
*������ �������������*:
[code]�����::MedicMainMenu TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MedicMainMenu

 Tkw_MedicMainMenu_Control_pnlMain = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]�������::pnlMain TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_pnlMain

 Tkw_MedicMainMenu_Control_pnlMain_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]�������::pnlMain:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_pnlMain_Push

 Tkw_MedicMainMenu_Control_hfLastOpenDocs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfLastOpenDocs
----
*������ �������������*:
[code]�������::hfLastOpenDocs TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs

 Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� hfLastOpenDocs
----
*������ �������������*:
[code]�������::hfLastOpenDocs:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push

 Tkw_MedicMainMenu_Control_tvLastOpenDocs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvLastOpenDocs
----
*������ �������������*:
[code]�������::tvLastOpenDocs TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs

 Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvLastOpenDocs
----
*������ �������������*:
[code]�������::tvLastOpenDocs:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push

function TkwEnMedicMainMenuPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
 {* ���������� ����� ������� .Ten_MedicMainMenu.pnlMain }
begin
 Result := aen_MedicMainMenu.pnlMain;
end;//TkwEnMedicMainMenuPnlMain.pnlMain

class function TkwEnMedicMainMenuPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.pnlMain';
end;//TkwEnMedicMainMenuPnlMain.GetWordNameForRegister

function TkwEnMedicMainMenuPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicMainMenuPnlMain.GetResultTypeInfo

function TkwEnMedicMainMenuPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuPnlMain.GetAllParamsCount

function TkwEnMedicMainMenuPnlMain.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuPnlMain.ParamsTypes

procedure TkwEnMedicMainMenuPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
end;//TkwEnMedicMainMenuPnlMain.SetValuePrim

procedure TkwEnMedicMainMenuPnlMain.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuPnlMain.DoDoIt

function TkwEnMedicMainMenuHfLastOpenDocs.hfLastOpenDocs(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* ���������� ����� ������� .Ten_MedicMainMenu.hfLastOpenDocs }
begin
 Result := aen_MedicMainMenu.hfLastOpenDocs;
end;//TkwEnMedicMainMenuHfLastOpenDocs.hfLastOpenDocs

class function TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfLastOpenDocs';
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister

function TkwEnMedicMainMenuHfLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetResultTypeInfo

function TkwEnMedicMainMenuHfLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetAllParamsCount

function TkwEnMedicMainMenuHfLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfLastOpenDocs.ParamsTypes

procedure TkwEnMedicMainMenuHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfLastOpenDocs', aCtx);
end;//TkwEnMedicMainMenuHfLastOpenDocs.SetValuePrim

procedure TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLastOpenDocs(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt

function TkwEnMedicMainMenuTvLastOpenDocs.tvLastOpenDocs(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .Ten_MedicMainMenu.tvLastOpenDocs }
begin
 Result := aen_MedicMainMenu.tvLastOpenDocs;
end;//TkwEnMedicMainMenuTvLastOpenDocs.tvLastOpenDocs

class function TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvLastOpenDocs';
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister

function TkwEnMedicMainMenuTvLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetResultTypeInfo

function TkwEnMedicMainMenuTvLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetAllParamsCount

function TkwEnMedicMainMenuTvLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvLastOpenDocs.ParamsTypes

procedure TkwEnMedicMainMenuTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvLastOpenDocs', aCtx);
end;//TkwEnMedicMainMenuTvLastOpenDocs.SetValuePrim

procedure TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLastOpenDocs(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt

function Tkw_Form_MedicMainMenu.GetString: AnsiString;
begin
 Result := 'en_MedicMainMenu';
end;//Tkw_Form_MedicMainMenu.GetString

class procedure Tkw_Form_MedicMainMenu.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_MedicMainMenu);
end;//Tkw_Form_MedicMainMenu.RegisterInEngine

class function Tkw_Form_MedicMainMenu.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MedicMainMenu';
end;//Tkw_Form_MedicMainMenu.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_pnlMain.GetString: AnsiString;
begin
 Result := 'pnlMain';
end;//Tkw_MedicMainMenu_Control_pnlMain.GetString

class procedure Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine

class function Tkw_MedicMainMenu_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain';
end;//Tkw_MedicMainMenu_Control_pnlMain.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain:push';
end;//Tkw_MedicMainMenu_Control_pnlMain_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetString: AnsiString;
begin
 Result := 'hfLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetString

class procedure Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine

class function Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLastOpenDocs');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfLastOpenDocs:push';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetString: AnsiString;
begin
 Result := 'tvLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetString

class procedure Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine

class function Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLastOpenDocs');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvLastOpenDocs:push';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister

initialization
 TkwEnMedicMainMenuPnlMain.RegisterInEngine;
 {* ����������� en_MedicMainMenu_pnlMain }
 TkwEnMedicMainMenuHfLastOpenDocs.RegisterInEngine;
 {* ����������� en_MedicMainMenu_hfLastOpenDocs }
 TkwEnMedicMainMenuTvLastOpenDocs.RegisterInEngine;
 {* ����������� en_MedicMainMenu_tvLastOpenDocs }
 Tkw_Form_MedicMainMenu.RegisterInEngine;
 {* ����������� Tkw_Form_MedicMainMenu }
 Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_pnlMain }
 Tkw_MedicMainMenu_Control_pnlMain_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_pnlMain_Push }
 Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfLastOpenDocs }
 Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push }
 Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvLastOpenDocs }
 Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicMainMenu));
 {* ����������� ���� Ten_MedicMainMenu }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
 {* ����������� ���� TnscHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* ����������� ���� TnscTreeViewHotTruck }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
