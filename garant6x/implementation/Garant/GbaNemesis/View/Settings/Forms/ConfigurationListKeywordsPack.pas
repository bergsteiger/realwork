unit ConfigurationListKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ConfigurationList }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\ConfigurationListKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ConfigurationListKeywordsPack" MUID: (4ABA146F00D4_Pack)

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
 , ConfigurationList_Form
 , tfwPropertyLike
 , nscTreeViewWithAdapterDragDrop
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnConfigurationListTvConfs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConfigurationList.tvConfs }
  private
   function tvConfs(const aCtx: TtfwContext;
    aen_ConfigurationList: Ten_ConfigurationList): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .Ten_ConfigurationList.tvConfs }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnConfigurationListTvConfs

 Tkw_Form_ConfigurationList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ConfigurationList
----
*������ �������������*:
[code]�����::ConfigurationList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ConfigurationList

 Tkw_ConfigurationList_Control_tvConfs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvConfs
----
*������ �������������*:
[code]�������::tvConfs TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConfigurationList_Control_tvConfs

 Tkw_ConfigurationList_Control_tvConfs_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� tvConfs
----
*������ �������������*:
[code]�������::tvConfs:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConfigurationList_Control_tvConfs_Push

function TkwEnConfigurationListTvConfs.tvConfs(const aCtx: TtfwContext;
 aen_ConfigurationList: Ten_ConfigurationList): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .Ten_ConfigurationList.tvConfs }
begin
 Result := aen_ConfigurationList.tvConfs;
end;//TkwEnConfigurationListTvConfs.tvConfs

class function TkwEnConfigurationListTvConfs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConfigurationList.tvConfs';
end;//TkwEnConfigurationListTvConfs.GetWordNameForRegister

function TkwEnConfigurationListTvConfs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnConfigurationListTvConfs.GetResultTypeInfo

function TkwEnConfigurationListTvConfs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConfigurationListTvConfs.GetAllParamsCount

function TkwEnConfigurationListTvConfs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConfigurationList)]);
end;//TkwEnConfigurationListTvConfs.ParamsTypes

procedure TkwEnConfigurationListTvConfs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvConfs', aCtx);
end;//TkwEnConfigurationListTvConfs.SetValuePrim

procedure TkwEnConfigurationListTvConfs.DoDoIt(const aCtx: TtfwContext);
var l_aen_ConfigurationList: Ten_ConfigurationList;
begin
 try
  l_aen_ConfigurationList := Ten_ConfigurationList(aCtx.rEngine.PopObjAs(Ten_ConfigurationList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_ConfigurationList: Ten_ConfigurationList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvConfs(aCtx, l_aen_ConfigurationList));
end;//TkwEnConfigurationListTvConfs.DoDoIt

function Tkw_Form_ConfigurationList.GetString: AnsiString;
begin
 Result := 'en_ConfigurationList';
end;//Tkw_Form_ConfigurationList.GetString

class procedure Tkw_Form_ConfigurationList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_ConfigurationList);
end;//Tkw_Form_ConfigurationList.RegisterInEngine

class function Tkw_Form_ConfigurationList.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ConfigurationList';
end;//Tkw_Form_ConfigurationList.GetWordNameForRegister

function Tkw_ConfigurationList_Control_tvConfs.GetString: AnsiString;
begin
 Result := 'tvConfs';
end;//Tkw_ConfigurationList_Control_tvConfs.GetString

class procedure Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine

class function Tkw_ConfigurationList_Control_tvConfs.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvConfs';
end;//Tkw_ConfigurationList_Control_tvConfs.GetWordNameForRegister

procedure Tkw_ConfigurationList_Control_tvConfs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvConfs');
 inherited;
end;//Tkw_ConfigurationList_Control_tvConfs_Push.DoDoIt

class function Tkw_ConfigurationList_Control_tvConfs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvConfs:push';
end;//Tkw_ConfigurationList_Control_tvConfs_Push.GetWordNameForRegister

initialization
 TkwEnConfigurationListTvConfs.RegisterInEngine;
 {* ����������� en_ConfigurationList_tvConfs }
 Tkw_Form_ConfigurationList.RegisterInEngine;
 {* ����������� Tkw_Form_ConfigurationList }
 Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine;
 {* ����������� Tkw_ConfigurationList_Control_tvConfs }
 Tkw_ConfigurationList_Control_tvConfs_Push.RegisterInEngine;
 {* ����������� Tkw_ConfigurationList_Control_tvConfs_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_ConfigurationList));
 {* ����������� ���� Ten_ConfigurationList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
