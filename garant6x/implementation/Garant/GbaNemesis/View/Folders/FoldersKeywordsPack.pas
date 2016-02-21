unit FoldersKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Folders }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Folders_Form
 , vtProportionalPanel
 , vtPanel
 , vtSizeablePanel
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
 Tkw_Form_Folders = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Folders
----
*������ �������������*:
[code]
'aControl' �����::Folders TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Folders

 Tkw_Folders_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Folders_Control_BackgroundPanel

 Tkw_Folders_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_BackgroundPanel_Push

 Tkw_Folders_Control_ParentZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Folders_Control_ParentZone

 Tkw_Folders_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_ParentZone_Push

 Tkw_Folders_Control_ChildZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Folders_Control_ChildZone

 Tkw_Folders_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Folders_Control_ChildZone_Push

 TkwCfFoldersBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfFolders.BackgroundPanel
[panel]������� BackgroundPanel ����� TcfFolders[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfFolders .TcfFolders.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    acfFolders: TcfFolders): TvtProportionalPanel;
    {* ���������� ����� ������� .TcfFolders.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfFoldersBackgroundPanel

 TkwCfFoldersParentZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfFolders.ParentZone
[panel]������� ParentZone ����� TcfFolders[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 acfFolders .TcfFolders.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    acfFolders: TcfFolders): TvtPanel;
    {* ���������� ����� ������� .TcfFolders.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfFoldersParentZone

 TkwCfFoldersChildZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TcfFolders.ChildZone
[panel]������� ChildZone ����� TcfFolders[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfFolders .TcfFolders.ChildZone >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    acfFolders: TcfFolders): TvtSizeablePanel;
    {* ���������� ����� ������� .TcfFolders.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfFoldersChildZone

class function Tkw_Form_Folders.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Folders';
end;//Tkw_Form_Folders.GetWordNameForRegister

function Tkw_Form_Folders.GetString: AnsiString;
begin
 Result := 'cfFolders';
end;//Tkw_Form_Folders.GetString

class function Tkw_Folders_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_Folders_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Folders_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_Folders_Control_BackgroundPanel.GetString

class procedure Tkw_Folders_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_Folders_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_Folders_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Folders_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Folders_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_Folders_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_Folders_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone';
end;//Tkw_Folders_Control_ParentZone.GetWordNameForRegister

function Tkw_Folders_Control_ParentZone.GetString: AnsiString;
begin
 Result := 'ParentZone';
end;//Tkw_Folders_Control_ParentZone.GetString

class procedure Tkw_Folders_Control_ParentZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Folders_Control_ParentZone.RegisterInEngine

procedure Tkw_Folders_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_Folders_Control_ParentZone_Push.DoDoIt

class function Tkw_Folders_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone:push';
end;//Tkw_Folders_Control_ParentZone_Push.GetWordNameForRegister

class function Tkw_Folders_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone';
end;//Tkw_Folders_Control_ChildZone.GetWordNameForRegister

function Tkw_Folders_Control_ChildZone.GetString: AnsiString;
begin
 Result := 'ChildZone';
end;//Tkw_Folders_Control_ChildZone.GetString

class procedure Tkw_Folders_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_Folders_Control_ChildZone.RegisterInEngine

procedure Tkw_Folders_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_Folders_Control_ChildZone_Push.DoDoIt

class function Tkw_Folders_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone:push';
end;//Tkw_Folders_Control_ChildZone_Push.GetWordNameForRegister

function TkwCfFoldersBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 acfFolders: TcfFolders): TvtProportionalPanel;
 {* ���������� ����� ������� .TcfFolders.BackgroundPanel }
begin
 Result := acfFolders.BackgroundPanel;
end;//TkwCfFoldersBackgroundPanel.BackgroundPanel

procedure TkwCfFoldersBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_acfFolders: TcfFolders;
begin
 try
  l_acfFolders := TcfFolders(aCtx.rEngine.PopObjAs(TcfFolders));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfFolders: TcfFolders : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_acfFolders));
end;//TkwCfFoldersBackgroundPanel.DoDoIt

class function TkwCfFoldersBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFolders.BackgroundPanel';
end;//TkwCfFoldersBackgroundPanel.GetWordNameForRegister

procedure TkwCfFoldersBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwCfFoldersBackgroundPanel.SetValuePrim

function TkwCfFoldersBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfFoldersBackgroundPanel.GetResultTypeInfo

function TkwCfFoldersBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfFoldersBackgroundPanel.GetAllParamsCount

function TkwCfFoldersBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFolders)]);
end;//TkwCfFoldersBackgroundPanel.ParamsTypes

function TkwCfFoldersParentZone.ParentZone(const aCtx: TtfwContext;
 acfFolders: TcfFolders): TvtPanel;
 {* ���������� ����� ������� .TcfFolders.ParentZone }
begin
 Result := acfFolders.ParentZone;
end;//TkwCfFoldersParentZone.ParentZone

procedure TkwCfFoldersParentZone.DoDoIt(const aCtx: TtfwContext);
var l_acfFolders: TcfFolders;
begin
 try
  l_acfFolders := TcfFolders(aCtx.rEngine.PopObjAs(TcfFolders));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfFolders: TcfFolders : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZone(aCtx, l_acfFolders));
end;//TkwCfFoldersParentZone.DoDoIt

class function TkwCfFoldersParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFolders.ParentZone';
end;//TkwCfFoldersParentZone.GetWordNameForRegister

procedure TkwCfFoldersParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ParentZone', aCtx);
end;//TkwCfFoldersParentZone.SetValuePrim

function TkwCfFoldersParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfFoldersParentZone.GetResultTypeInfo

function TkwCfFoldersParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfFoldersParentZone.GetAllParamsCount

function TkwCfFoldersParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFolders)]);
end;//TkwCfFoldersParentZone.ParamsTypes

function TkwCfFoldersChildZone.ChildZone(const aCtx: TtfwContext;
 acfFolders: TcfFolders): TvtSizeablePanel;
 {* ���������� ����� ������� .TcfFolders.ChildZone }
begin
 Result := acfFolders.ChildZone;
end;//TkwCfFoldersChildZone.ChildZone

procedure TkwCfFoldersChildZone.DoDoIt(const aCtx: TtfwContext);
var l_acfFolders: TcfFolders;
begin
 try
  l_acfFolders := TcfFolders(aCtx.rEngine.PopObjAs(TcfFolders));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfFolders: TcfFolders : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_acfFolders));
end;//TkwCfFoldersChildZone.DoDoIt

class function TkwCfFoldersChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfFolders.ChildZone';
end;//TkwCfFoldersChildZone.GetWordNameForRegister

procedure TkwCfFoldersChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZone', aCtx);
end;//TkwCfFoldersChildZone.SetValuePrim

function TkwCfFoldersChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfFoldersChildZone.GetResultTypeInfo

function TkwCfFoldersChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfFoldersChildZone.GetAllParamsCount

function TkwCfFoldersChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfFolders)]);
end;//TkwCfFoldersChildZone.ParamsTypes

initialization
 Tkw_Form_Folders.RegisterInEngine;
 {* ����������� Tkw_Form_Folders }
 Tkw_Folders_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_Folders_Control_BackgroundPanel }
 Tkw_Folders_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Folders_Control_BackgroundPanel_Push }
 Tkw_Folders_Control_ParentZone.RegisterInEngine;
 {* ����������� Tkw_Folders_Control_ParentZone }
 Tkw_Folders_Control_ParentZone_Push.RegisterInEngine;
 {* ����������� Tkw_Folders_Control_ParentZone_Push }
 Tkw_Folders_Control_ChildZone.RegisterInEngine;
 {* ����������� Tkw_Folders_Control_ChildZone }
 Tkw_Folders_Control_ChildZone_Push.RegisterInEngine;
 {* ����������� Tkw_Folders_Control_ChildZone_Push }
 TkwCfFoldersBackgroundPanel.RegisterInEngine;
 {* ����������� cfFolders_BackgroundPanel }
 TkwCfFoldersParentZone.RegisterInEngine;
 {* ����������� cfFolders_ParentZone }
 TkwCfFoldersChildZone.RegisterInEngine;
 {* ����������� cfFolders_ChildZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfFolders));
 {* ����������� ���� Folders }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
