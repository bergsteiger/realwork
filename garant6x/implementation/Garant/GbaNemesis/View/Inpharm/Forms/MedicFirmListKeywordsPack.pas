unit MedicFirmListKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� MedicFirmList }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\MedicFirmListKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "MedicFirmListKeywordsPack" MUID: (4AB9E69C0243_Pack)

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
 , MedicFirmList_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AB9E69C0243_Packimpl_uses*
 //#UC END# *4AB9E69C0243_Packimpl_uses*
;

type
 TkwEnMedicFirmListBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MedicFirmList.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aen_MedicFirmList: Ten_MedicFirmList): TvtPanel;
    {* ���������� ����� ������� .Ten_MedicFirmList.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicFirmListBackgroundPanel

 TkwEnMedicFirmListContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MedicFirmList.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aen_MedicFirmList: Ten_MedicFirmList): TnscContextFilter;
    {* ���������� ����� ������� .Ten_MedicFirmList.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicFirmListContextFilter

 TkwEnMedicFirmListListTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MedicFirmList.ListTree }
  private
   function ListTree(const aCtx: TtfwContext;
    aen_MedicFirmList: Ten_MedicFirmList): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .Ten_MedicFirmList.ListTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicFirmListListTree

 Tkw_Form_MedicFirmList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� MedicFirmList
----
*������ �������������*:
[code]�����::MedicFirmList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MedicFirmList

 Tkw_MedicFirmList_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_BackgroundPanel

 Tkw_MedicFirmList_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push

 Tkw_MedicFirmList_Control_ContextFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]�������::ContextFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ContextFilter

 Tkw_MedicFirmList_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]�������::ContextFilter:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ContextFilter_Push

 Tkw_MedicFirmList_Control_ListTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ListTree
----
*������ �������������*:
[code]�������::ListTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ListTree

 Tkw_MedicFirmList_Control_ListTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ListTree
----
*������ �������������*:
[code]�������::ListTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ListTree_Push

function TkwEnMedicFirmListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aen_MedicFirmList: Ten_MedicFirmList): TvtPanel;
 {* ���������� ����� ������� .Ten_MedicFirmList.BackgroundPanel }
begin
 Result := aen_MedicFirmList.BackgroundPanel;
end;//TkwEnMedicFirmListBackgroundPanel.BackgroundPanel

class function TkwEnMedicFirmListBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicFirmList.BackgroundPanel';
end;//TkwEnMedicFirmListBackgroundPanel.GetWordNameForRegister

function TkwEnMedicFirmListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicFirmListBackgroundPanel.GetResultTypeInfo

function TkwEnMedicFirmListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicFirmListBackgroundPanel.GetAllParamsCount

function TkwEnMedicFirmListBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicFirmList)]);
end;//TkwEnMedicFirmListBackgroundPanel.ParamsTypes

procedure TkwEnMedicFirmListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwEnMedicFirmListBackgroundPanel.SetValuePrim

procedure TkwEnMedicFirmListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicFirmList: Ten_MedicFirmList;
begin
 try
  l_aen_MedicFirmList := Ten_MedicFirmList(aCtx.rEngine.PopObjAs(Ten_MedicFirmList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicFirmList: Ten_MedicFirmList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aen_MedicFirmList));
end;//TkwEnMedicFirmListBackgroundPanel.DoDoIt

function TkwEnMedicFirmListContextFilter.ContextFilter(const aCtx: TtfwContext;
 aen_MedicFirmList: Ten_MedicFirmList): TnscContextFilter;
 {* ���������� ����� ������� .Ten_MedicFirmList.ContextFilter }
begin
 Result := aen_MedicFirmList.ContextFilter;
end;//TkwEnMedicFirmListContextFilter.ContextFilter

class function TkwEnMedicFirmListContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicFirmList.ContextFilter';
end;//TkwEnMedicFirmListContextFilter.GetWordNameForRegister

function TkwEnMedicFirmListContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnMedicFirmListContextFilter.GetResultTypeInfo

function TkwEnMedicFirmListContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicFirmListContextFilter.GetAllParamsCount

function TkwEnMedicFirmListContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicFirmList)]);
end;//TkwEnMedicFirmListContextFilter.ParamsTypes

procedure TkwEnMedicFirmListContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwEnMedicFirmListContextFilter.SetValuePrim

procedure TkwEnMedicFirmListContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicFirmList: Ten_MedicFirmList;
begin
 try
  l_aen_MedicFirmList := Ten_MedicFirmList(aCtx.rEngine.PopObjAs(Ten_MedicFirmList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicFirmList: Ten_MedicFirmList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aen_MedicFirmList));
end;//TkwEnMedicFirmListContextFilter.DoDoIt

function TkwEnMedicFirmListListTree.ListTree(const aCtx: TtfwContext;
 aen_MedicFirmList: Ten_MedicFirmList): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .Ten_MedicFirmList.ListTree }
begin
 Result := aen_MedicFirmList.ListTree;
end;//TkwEnMedicFirmListListTree.ListTree

class function TkwEnMedicFirmListListTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicFirmList.ListTree';
end;//TkwEnMedicFirmListListTree.GetWordNameForRegister

function TkwEnMedicFirmListListTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicFirmListListTree.GetResultTypeInfo

function TkwEnMedicFirmListListTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicFirmListListTree.GetAllParamsCount

function TkwEnMedicFirmListListTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicFirmList)]);
end;//TkwEnMedicFirmListListTree.ParamsTypes

procedure TkwEnMedicFirmListListTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ListTree', aCtx);
end;//TkwEnMedicFirmListListTree.SetValuePrim

procedure TkwEnMedicFirmListListTree.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicFirmList: Ten_MedicFirmList;
begin
 try
  l_aen_MedicFirmList := Ten_MedicFirmList(aCtx.rEngine.PopObjAs(Ten_MedicFirmList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicFirmList: Ten_MedicFirmList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ListTree(aCtx, l_aen_MedicFirmList));
end;//TkwEnMedicFirmListListTree.DoDoIt

function Tkw_Form_MedicFirmList.GetString: AnsiString;
begin
 Result := 'en_MedicFirmList';
end;//Tkw_Form_MedicFirmList.GetString

class procedure Tkw_Form_MedicFirmList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_MedicFirmList);
end;//Tkw_Form_MedicFirmList.RegisterInEngine

class function Tkw_Form_MedicFirmList.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MedicFirmList';
end;//Tkw_Form_MedicFirmList.GetWordNameForRegister

function Tkw_MedicFirmList_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_MedicFirmList_Control_BackgroundPanel.GetString

class procedure Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine

class function Tkw_MedicFirmList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_MedicFirmList_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_MedicFirmList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_MedicFirmList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_MedicFirmList_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_MedicFirmList_Control_ContextFilter.GetString

class procedure Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine

class function Tkw_MedicFirmList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_MedicFirmList_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_MedicFirmList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_MedicFirmList_Control_ContextFilter_Push.DoDoIt

class function Tkw_MedicFirmList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_MedicFirmList_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_MedicFirmList_Control_ListTree.GetString: AnsiString;
begin
 Result := 'ListTree';
end;//Tkw_MedicFirmList_Control_ListTree.GetString

class procedure Tkw_MedicFirmList_Control_ListTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_MedicFirmList_Control_ListTree.RegisterInEngine

class function Tkw_MedicFirmList_Control_ListTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ListTree';
end;//Tkw_MedicFirmList_Control_ListTree.GetWordNameForRegister

procedure Tkw_MedicFirmList_Control_ListTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ListTree');
 inherited;
end;//Tkw_MedicFirmList_Control_ListTree_Push.DoDoIt

class function Tkw_MedicFirmList_Control_ListTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ListTree:push';
end;//Tkw_MedicFirmList_Control_ListTree_Push.GetWordNameForRegister

initialization
 TkwEnMedicFirmListBackgroundPanel.RegisterInEngine;
 {* ����������� en_MedicFirmList_BackgroundPanel }
 TkwEnMedicFirmListContextFilter.RegisterInEngine;
 {* ����������� en_MedicFirmList_ContextFilter }
 TkwEnMedicFirmListListTree.RegisterInEngine;
 {* ����������� en_MedicFirmList_ListTree }
 Tkw_Form_MedicFirmList.RegisterInEngine;
 {* ����������� Tkw_Form_MedicFirmList }
 Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_MedicFirmList_Control_BackgroundPanel }
 Tkw_MedicFirmList_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_MedicFirmList_Control_BackgroundPanel_Push }
 Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine;
 {* ����������� Tkw_MedicFirmList_Control_ContextFilter }
 Tkw_MedicFirmList_Control_ContextFilter_Push.RegisterInEngine;
 {* ����������� Tkw_MedicFirmList_Control_ContextFilter_Push }
 Tkw_MedicFirmList_Control_ListTree.RegisterInEngine;
 {* ����������� Tkw_MedicFirmList_Control_ListTree }
 Tkw_MedicFirmList_Control_ListTree_Push.RegisterInEngine;
 {* ����������� Tkw_MedicFirmList_Control_ListTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicFirmList));
 {* ����������� ���� Ten_MedicFirmList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
