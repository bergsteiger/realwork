unit TreeAttributeFirstLevelKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� TreeAttributeFirstLevel }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\TreeAttributeFirstLevelKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "TreeAttributeFirstLevelKeywordsPack" MUID: (22753380676D)

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
 , TreeAttributeFirstLevel_Form
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
 Tkw_Form_TreeAttributeFirstLevel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� TreeAttributeFirstLevel
----
*������ �������������*:
[code]
'aControl' �����::TreeAttributeFirstLevel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_TreeAttributeFirstLevel

 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FirstLevelContent
----
*������ �������������*:
[code]
�������::FirstLevelContent TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent

 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� FirstLevelContent
----
*������ �������������*:
[code]
�������::FirstLevelContent:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push

 TkwEfTreeAttributeFirstLevelFirstLevelContent = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefTreeAttributeFirstLevel.FirstLevelContent
[panel]������� FirstLevelContent ����� TefTreeAttributeFirstLevel[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aefTreeAttributeFirstLevel .TefTreeAttributeFirstLevel.FirstLevelContent >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function FirstLevelContent(const aCtx: TtfwContext;
    aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TefTreeAttributeFirstLevel.FirstLevelContent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfTreeAttributeFirstLevelFirstLevelContent

function Tkw_Form_TreeAttributeFirstLevel.GetString: AnsiString;
begin
 Result := 'efTreeAttributeFirstLevel';
end;//Tkw_Form_TreeAttributeFirstLevel.GetString

class function Tkw_Form_TreeAttributeFirstLevel.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::TreeAttributeFirstLevel';
end;//Tkw_Form_TreeAttributeFirstLevel.GetWordNameForRegister

function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetString: AnsiString;
begin
 Result := 'FirstLevelContent';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetString

class procedure Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine

class function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstLevelContent';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.GetWordNameForRegister

procedure Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FirstLevelContent');
 inherited;
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.DoDoIt

class function Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstLevelContent:push';
end;//Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.GetWordNameForRegister

function TkwEfTreeAttributeFirstLevelFirstLevelContent.FirstLevelContent(const aCtx: TtfwContext;
 aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TefTreeAttributeFirstLevel.FirstLevelContent }
begin
 Result := aefTreeAttributeFirstLevel.FirstLevelContent;
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.FirstLevelContent

procedure TkwEfTreeAttributeFirstLevelFirstLevelContent.DoDoIt(const aCtx: TtfwContext);
var l_aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel;
begin
 try
  l_aefTreeAttributeFirstLevel := TefTreeAttributeFirstLevel(aCtx.rEngine.PopObjAs(TefTreeAttributeFirstLevel));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefTreeAttributeFirstLevel: TefTreeAttributeFirstLevel : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FirstLevelContent(aCtx, l_aefTreeAttributeFirstLevel));
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.DoDoIt

procedure TkwEfTreeAttributeFirstLevelFirstLevelContent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FirstLevelContent', aCtx);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.SetValuePrim

function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetResultTypeInfo

function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetAllParamsCount

function TkwEfTreeAttributeFirstLevelFirstLevelContent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeFirstLevel)]);
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.ParamsTypes

class function TkwEfTreeAttributeFirstLevelFirstLevelContent.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeFirstLevel.FirstLevelContent';
end;//TkwEfTreeAttributeFirstLevelFirstLevelContent.GetWordNameForRegister

initialization
 Tkw_Form_TreeAttributeFirstLevel.RegisterInEngine;
 {* ����������� Tkw_Form_TreeAttributeFirstLevel }
 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent }
 Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push.RegisterInEngine;
 {* ����������� Tkw_TreeAttributeFirstLevel_Control_FirstLevelContent_Push }
 TkwEfTreeAttributeFirstLevelFirstLevelContent.RegisterInEngine;
 {* ����������� efTreeAttributeFirstLevel_FirstLevelContent }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefTreeAttributeFirstLevel));
 {* ����������� ���� TreeAttributeFirstLevel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
