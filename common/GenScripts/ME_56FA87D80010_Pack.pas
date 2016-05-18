unit MainMenuWithProfNewsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� MainMenuWithProfNews }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\MainMenuWithProfNewsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "MainMenuWithProfNewsKeywordsPack" MUID: (56FA87D80010_Pack)

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
 , MainMenuWithProfNews_Form
 , tfwPropertyLike
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtPanel
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
 TkwEnMainMenuWithProfNewsIeIO = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.ieIO }
  private
   function ieIO(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnIO;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.ieIO }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsIeIO

 TkwEnMainMenuWithProfNewsPnlMain = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlMain }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlMain

 TkwEnMainMenuWithProfNewsHfLastOpenDocs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.hfLastOpenDocs }
  private
   function hfLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.hfLastOpenDocs }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs

 TkwEnMainMenuWithProfNewsTvLastOpenDocs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.tvLastOpenDocs }
  private
   function tvLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvLastOpenDocs }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs

 Tkw_Form_MainMenuWithProfNews = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� MainMenuWithProfNews
----
*������ �������������*:
[code]�����::MainMenuWithProfNews TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MainMenuWithProfNews

 Tkw_MainMenuWithProfNews_Component_ieIO = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ieIO
----
*������ �������������*:
[code]���������::ieIO TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Component_ieIO

 Tkw_MainMenuWithProfNews_Control_pnlMain = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]�������::pnlMain TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlMain

 Tkw_MainMenuWithProfNews_Control_pnlMain_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]�������::pnlMain:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlMain_Push

 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfLastOpenDocs
----
*������ �������������*:
[code]�������::hfLastOpenDocs TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs

 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� hfLastOpenDocs
----
*������ �������������*:
[code]�������::hfLastOpenDocs:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push

 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvLastOpenDocs
----
*������ �������������*:
[code]�������::tvLastOpenDocs TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs

 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvLastOpenDocs
----
*������ �������������*:
[code]�������::tvLastOpenDocs:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push

function TkwEnMainMenuWithProfNewsIeIO.ieIO(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnIO;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.ieIO }
begin
 Result := aen_MainMenuWithProfNews.ieIO;
end;//TkwEnMainMenuWithProfNewsIeIO.ieIO

class function TkwEnMainMenuWithProfNewsIeIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.ieIO';
end;//TkwEnMainMenuWithProfNewsIeIO.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsIeIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImageEnIO);
end;//TkwEnMainMenuWithProfNewsIeIO.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsIeIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsIeIO.GetAllParamsCount

function TkwEnMainMenuWithProfNewsIeIO.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsIeIO.ParamsTypes

procedure TkwEnMainMenuWithProfNewsIeIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ieIO', aCtx);
end;//TkwEnMainMenuWithProfNewsIeIO.SetValuePrim

procedure TkwEnMainMenuWithProfNewsIeIO.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieIO(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsIeIO.DoDoIt

function TkwEnMainMenuWithProfNewsPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlMain }
begin
 Result := aen_MainMenuWithProfNews.pnlMain;
end;//TkwEnMainMenuWithProfNewsPnlMain.pnlMain

class function TkwEnMainMenuWithProfNewsPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlMain';
end;//TkwEnMainMenuWithProfNewsPnlMain.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlMain.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlMain.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlMain.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlMain.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlMain.SetValuePrim

procedure TkwEnMainMenuWithProfNewsPnlMain.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlMain.DoDoIt

function TkwEnMainMenuWithProfNewsHfLastOpenDocs.hfLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.hfLastOpenDocs }
begin
 Result := aen_MainMenuWithProfNews.hfLastOpenDocs;
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.hfLastOpenDocs

class function TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.hfLastOpenDocs';
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuWithProfNewsHfLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.ParamsTypes

procedure TkwEnMainMenuWithProfNewsHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfLastOpenDocs', aCtx);
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.SetValuePrim

procedure TkwEnMainMenuWithProfNewsHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLastOpenDocs(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.DoDoIt

function TkwEnMainMenuWithProfNewsTvLastOpenDocs.tvLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvLastOpenDocs }
begin
 Result := aen_MainMenuWithProfNews.tvLastOpenDocs;
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.tvLastOpenDocs

class function TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvLastOpenDocs';
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuWithProfNewsTvLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.ParamsTypes

procedure TkwEnMainMenuWithProfNewsTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvLastOpenDocs', aCtx);
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.SetValuePrim

procedure TkwEnMainMenuWithProfNewsTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLastOpenDocs(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.DoDoIt

function Tkw_Form_MainMenuWithProfNews.GetString: AnsiString;
begin
 Result := 'en_MainMenuWithProfNews';
end;//Tkw_Form_MainMenuWithProfNews.GetString

class procedure Tkw_Form_MainMenuWithProfNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_MainMenuWithProfNews);
end;//Tkw_Form_MainMenuWithProfNews.RegisterInEngine

class function Tkw_Form_MainMenuWithProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MainMenuWithProfNews';
end;//Tkw_Form_MainMenuWithProfNews.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Component_ieIO.GetString: AnsiString;
begin
 Result := 'ieIO';
end;//Tkw_MainMenuWithProfNews_Component_ieIO.GetString

class procedure Tkw_MainMenuWithProfNews_Component_ieIO.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImageEnIO);
end;//Tkw_MainMenuWithProfNews_Component_ieIO.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Component_ieIO.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::ieIO';
end;//Tkw_MainMenuWithProfNews_Component_ieIO.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlMain.GetString: AnsiString;
begin
 Result := 'pnlMain';
end;//Tkw_MainMenuWithProfNews_Control_pnlMain.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlMain.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain';
end;//Tkw_MainMenuWithProfNews_Control_pnlMain.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlMain_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlMain_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.GetString: AnsiString;
begin
 Result := 'hfLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.GetString

class procedure Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLastOpenDocs');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfLastOpenDocs:push';
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.GetString: AnsiString;
begin
 Result := 'tvLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.GetString

class procedure Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLastOpenDocs');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvLastOpenDocs:push';
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.GetWordNameForRegister

initialization
 TkwEnMainMenuWithProfNewsIeIO.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_ieIO }
 TkwEnMainMenuWithProfNewsPnlMain.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlMain }
 TkwEnMainMenuWithProfNewsHfLastOpenDocs.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_hfLastOpenDocs }
 TkwEnMainMenuWithProfNewsTvLastOpenDocs.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_tvLastOpenDocs }
 Tkw_Form_MainMenuWithProfNews.RegisterInEngine;
 {* ����������� Tkw_Form_MainMenuWithProfNews }
 Tkw_MainMenuWithProfNews_Component_ieIO.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Component_ieIO }
 Tkw_MainMenuWithProfNews_Control_pnlMain.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlMain }
 Tkw_MainMenuWithProfNews_Control_pnlMain_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlMain_Push }
 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs }
 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push }
 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs }
 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MainMenuWithProfNews));
 {* ����������� ���� Ten_MainMenuWithProfNews }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnIO));
 {* ����������� ���� TImageEnIO }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
 {* ����������� ���� TnscHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* ����������� ���� TnscTreeViewHotTruck }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
