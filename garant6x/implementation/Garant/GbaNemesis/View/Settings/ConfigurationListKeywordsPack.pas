unit ConfigurationListKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ConfigurationList }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\ConfigurationListKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ConfigurationListKeywordsPack" MUID: (785A17B4ECDE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscTreeViewWithAdapterDragDrop
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ConfigurationList_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 Tkw_Form_ConfigurationList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ConfigurationList
----
*������ �������������*:
[code]
'aControl' �����::ConfigurationList TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ConfigurationList

 Tkw_ConfigurationList_Control_tvConfs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvConfs
----
*������ �������������*:
[code]
�������::tvConfs TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConfigurationList_Control_tvConfs

 Tkw_ConfigurationList_Control_tvConfs_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� tvConfs
----
*������ �������������*:
[code]
�������::tvConfs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConfigurationList_Control_tvConfs_Push

 TkwEnConfigurationListTvConfs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_ConfigurationList.tvConfs
[panel]������� tvConfs ����� Ten_ConfigurationList[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_ConfigurationList .Ten_ConfigurationList.tvConfs >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvConfs(const aCtx: TtfwContext;
    aen_ConfigurationList: Ten_ConfigurationList): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .Ten_ConfigurationList.tvConfs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConfigurationListTvConfs

function Tkw_Form_ConfigurationList.GetString: AnsiString;
begin
 Result := 'en_ConfigurationList';
end;//Tkw_Form_ConfigurationList.GetString

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

function TkwEnConfigurationListTvConfs.tvConfs(const aCtx: TtfwContext;
 aen_ConfigurationList: Ten_ConfigurationList): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .Ten_ConfigurationList.tvConfs }
begin
 Result := aen_ConfigurationList.tvConfs;
end;//TkwEnConfigurationListTvConfs.tvConfs

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

procedure TkwEnConfigurationListTvConfs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvConfs', aCtx);
end;//TkwEnConfigurationListTvConfs.SetValuePrim

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

class function TkwEnConfigurationListTvConfs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConfigurationList.tvConfs';
end;//TkwEnConfigurationListTvConfs.GetWordNameForRegister

initialization
 Tkw_Form_ConfigurationList.RegisterInEngine;
 {* ����������� Tkw_Form_ConfigurationList }
 Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine;
 {* ����������� Tkw_ConfigurationList_Control_tvConfs }
 Tkw_ConfigurationList_Control_tvConfs_Push.RegisterInEngine;
 {* ����������� Tkw_ConfigurationList_Control_tvConfs_Push }
 TkwEnConfigurationListTvConfs.RegisterInEngine;
 {* ����������� en_ConfigurationList_tvConfs }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_ConfigurationList));
 {* ����������� ���� ConfigurationList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
