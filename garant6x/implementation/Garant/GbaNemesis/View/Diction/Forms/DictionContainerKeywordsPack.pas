unit DictionContainerKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� DictionContainer }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\DictionContainerKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "DictionContainerKeywordsPack" MUID: (4D7A6A2E00F7_Pack)

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
 , DictionContainer_Form
 , tfwPropertyLike
 , vtProportionalPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtSizeablePanel
 , vtPanel
 , vtLabel
 , ExtCtrls
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwDictionContainerFormPnBackground = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.pnBackground }
  private
   function pnBackground(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TDictionContainerForm.pnBackground }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDictionContainerFormPnBackground

 TkwDictionContainerFormNavigatorZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.NavigatorZone }
  private
   function NavigatorZone(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TDictionContainerForm.NavigatorZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDictionContainerFormNavigatorZone

 TkwDictionContainerFormPnWorkArea = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.pnWorkArea }
  private
   function pnWorkArea(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TDictionContainerForm.pnWorkArea }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDictionContainerFormPnWorkArea

 TkwDictionContainerFormChildZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.ChildZone }
  private
   function ChildZone(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TDictionContainerForm.ChildZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDictionContainerFormChildZone

 TkwDictionContainerFormPnHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.pnHeader }
  private
   function pnHeader(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtPanel;
    {* ���������� ����� ������� .TDictionContainerForm.pnHeader }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDictionContainerFormPnHeader

 TkwDictionContainerFormLbHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.lbHeader }
  private
   function lbHeader(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtLabel;
    {* ���������� ����� ������� .TDictionContainerForm.lbHeader }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDictionContainerFormLbHeader

 TkwDictionContainerFormPbHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.pbHeader }
  private
   function pbHeader(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TPaintBox;
    {* ���������� ����� ������� .TDictionContainerForm.pbHeader }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDictionContainerFormPbHeader

 TkwDictionContainerFormParentZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.ParentZone }
  private
   function ParentZone(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtPanel;
    {* ���������� ����� ������� .TDictionContainerForm.ParentZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwDictionContainerFormParentZone

 Tkw_Form_DictionContainer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� DictionContainer
----
*������ �������������*:
[code]�����::DictionContainer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_DictionContainer

 Tkw_DictionContainer_Control_pnBackground = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnBackground
----
*������ �������������*:
[code]�������::pnBackground TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnBackground

 Tkw_DictionContainer_Control_pnBackground_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnBackground
----
*������ �������������*:
[code]�������::pnBackground:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnBackground_Push

 Tkw_DictionContainer_Control_NavigatorZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NavigatorZone
----
*������ �������������*:
[code]�������::NavigatorZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_NavigatorZone

 Tkw_DictionContainer_Control_NavigatorZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NavigatorZone
----
*������ �������������*:
[code]�������::NavigatorZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_NavigatorZone_Push

 Tkw_DictionContainer_Control_pnWorkArea = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnWorkArea
----
*������ �������������*:
[code]�������::pnWorkArea TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnWorkArea

 Tkw_DictionContainer_Control_pnWorkArea_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnWorkArea
----
*������ �������������*:
[code]�������::pnWorkArea:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnWorkArea_Push

 Tkw_DictionContainer_Control_ChildZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]�������::ChildZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_ChildZone

 Tkw_DictionContainer_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]�������::ChildZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_ChildZone_Push

 Tkw_DictionContainer_Control_pnHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnHeader
----
*������ �������������*:
[code]�������::pnHeader TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnHeader

 Tkw_DictionContainer_Control_pnHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnHeader
----
*������ �������������*:
[code]�������::pnHeader:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnHeader_Push

 Tkw_DictionContainer_Control_lbHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbHeader
----
*������ �������������*:
[code]�������::lbHeader TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_lbHeader

 Tkw_DictionContainer_Control_lbHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbHeader
----
*������ �������������*:
[code]�������::lbHeader:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_lbHeader_Push

 Tkw_DictionContainer_Control_pbHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbHeader
----
*������ �������������*:
[code]�������::pbHeader TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pbHeader

 Tkw_DictionContainer_Control_pbHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbHeader
----
*������ �������������*:
[code]�������::pbHeader:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pbHeader_Push

 Tkw_DictionContainer_Control_ParentZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]�������::ParentZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_ParentZone

 Tkw_DictionContainer_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]�������::ParentZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_ParentZone_Push

function TkwDictionContainerFormPnBackground.pnBackground(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TDictionContainerForm.pnBackground }
begin
 Result := aDictionContainerForm.pnBackground;
end;//TkwDictionContainerFormPnBackground.pnBackground

class function TkwDictionContainerFormPnBackground.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pnBackground';
end;//TkwDictionContainerFormPnBackground.GetWordNameForRegister

function TkwDictionContainerFormPnBackground.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwDictionContainerFormPnBackground.GetResultTypeInfo

function TkwDictionContainerFormPnBackground.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPnBackground.GetAllParamsCount

function TkwDictionContainerFormPnBackground.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPnBackground.ParamsTypes

procedure TkwDictionContainerFormPnBackground.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnBackground', aCtx);
end;//TkwDictionContainerFormPnBackground.SetValuePrim

procedure TkwDictionContainerFormPnBackground.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnBackground(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormPnBackground.DoDoIt

function TkwDictionContainerFormNavigatorZone.NavigatorZone(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TDictionContainerForm.NavigatorZone }
begin
 Result := aDictionContainerForm.NavigatorZone;
end;//TkwDictionContainerFormNavigatorZone.NavigatorZone

class function TkwDictionContainerFormNavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.NavigatorZone';
end;//TkwDictionContainerFormNavigatorZone.GetWordNameForRegister

function TkwDictionContainerFormNavigatorZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwDictionContainerFormNavigatorZone.GetResultTypeInfo

function TkwDictionContainerFormNavigatorZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormNavigatorZone.GetAllParamsCount

function TkwDictionContainerFormNavigatorZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormNavigatorZone.ParamsTypes

procedure TkwDictionContainerFormNavigatorZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NavigatorZone', aCtx);
end;//TkwDictionContainerFormNavigatorZone.SetValuePrim

procedure TkwDictionContainerFormNavigatorZone.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NavigatorZone(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormNavigatorZone.DoDoIt

function TkwDictionContainerFormPnWorkArea.pnWorkArea(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TDictionContainerForm.pnWorkArea }
begin
 Result := aDictionContainerForm.pnWorkArea;
end;//TkwDictionContainerFormPnWorkArea.pnWorkArea

class function TkwDictionContainerFormPnWorkArea.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pnWorkArea';
end;//TkwDictionContainerFormPnWorkArea.GetWordNameForRegister

function TkwDictionContainerFormPnWorkArea.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwDictionContainerFormPnWorkArea.GetResultTypeInfo

function TkwDictionContainerFormPnWorkArea.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPnWorkArea.GetAllParamsCount

function TkwDictionContainerFormPnWorkArea.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPnWorkArea.ParamsTypes

procedure TkwDictionContainerFormPnWorkArea.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnWorkArea', aCtx);
end;//TkwDictionContainerFormPnWorkArea.SetValuePrim

procedure TkwDictionContainerFormPnWorkArea.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnWorkArea(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormPnWorkArea.DoDoIt

function TkwDictionContainerFormChildZone.ChildZone(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TDictionContainerForm.ChildZone }
begin
 Result := aDictionContainerForm.ChildZone;
end;//TkwDictionContainerFormChildZone.ChildZone

class function TkwDictionContainerFormChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.ChildZone';
end;//TkwDictionContainerFormChildZone.GetWordNameForRegister

function TkwDictionContainerFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwDictionContainerFormChildZone.GetResultTypeInfo

function TkwDictionContainerFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormChildZone.GetAllParamsCount

function TkwDictionContainerFormChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormChildZone.ParamsTypes

procedure TkwDictionContainerFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZone', aCtx);
end;//TkwDictionContainerFormChildZone.SetValuePrim

procedure TkwDictionContainerFormChildZone.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormChildZone.DoDoIt

function TkwDictionContainerFormPnHeader.pnHeader(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtPanel;
 {* ���������� ����� ������� .TDictionContainerForm.pnHeader }
begin
 Result := aDictionContainerForm.pnHeader;
end;//TkwDictionContainerFormPnHeader.pnHeader

class function TkwDictionContainerFormPnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pnHeader';
end;//TkwDictionContainerFormPnHeader.GetWordNameForRegister

function TkwDictionContainerFormPnHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwDictionContainerFormPnHeader.GetResultTypeInfo

function TkwDictionContainerFormPnHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPnHeader.GetAllParamsCount

function TkwDictionContainerFormPnHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPnHeader.ParamsTypes

procedure TkwDictionContainerFormPnHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnHeader', aCtx);
end;//TkwDictionContainerFormPnHeader.SetValuePrim

procedure TkwDictionContainerFormPnHeader.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnHeader(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormPnHeader.DoDoIt

function TkwDictionContainerFormLbHeader.lbHeader(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtLabel;
 {* ���������� ����� ������� .TDictionContainerForm.lbHeader }
begin
 Result := aDictionContainerForm.lbHeader;
end;//TkwDictionContainerFormLbHeader.lbHeader

class function TkwDictionContainerFormLbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.lbHeader';
end;//TkwDictionContainerFormLbHeader.GetWordNameForRegister

function TkwDictionContainerFormLbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwDictionContainerFormLbHeader.GetResultTypeInfo

function TkwDictionContainerFormLbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormLbHeader.GetAllParamsCount

function TkwDictionContainerFormLbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormLbHeader.ParamsTypes

procedure TkwDictionContainerFormLbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lbHeader', aCtx);
end;//TkwDictionContainerFormLbHeader.SetValuePrim

procedure TkwDictionContainerFormLbHeader.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lbHeader(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormLbHeader.DoDoIt

function TkwDictionContainerFormPbHeader.pbHeader(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TPaintBox;
 {* ���������� ����� ������� .TDictionContainerForm.pbHeader }
begin
 Result := aDictionContainerForm.pbHeader;
end;//TkwDictionContainerFormPbHeader.pbHeader

class function TkwDictionContainerFormPbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pbHeader';
end;//TkwDictionContainerFormPbHeader.GetWordNameForRegister

function TkwDictionContainerFormPbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwDictionContainerFormPbHeader.GetResultTypeInfo

function TkwDictionContainerFormPbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPbHeader.GetAllParamsCount

function TkwDictionContainerFormPbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPbHeader.ParamsTypes

procedure TkwDictionContainerFormPbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbHeader', aCtx);
end;//TkwDictionContainerFormPbHeader.SetValuePrim

procedure TkwDictionContainerFormPbHeader.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbHeader(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormPbHeader.DoDoIt

function TkwDictionContainerFormParentZone.ParentZone(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtPanel;
 {* ���������� ����� ������� .TDictionContainerForm.ParentZone }
begin
 Result := aDictionContainerForm.ParentZone;
end;//TkwDictionContainerFormParentZone.ParentZone

class function TkwDictionContainerFormParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.ParentZone';
end;//TkwDictionContainerFormParentZone.GetWordNameForRegister

function TkwDictionContainerFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwDictionContainerFormParentZone.GetResultTypeInfo

function TkwDictionContainerFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormParentZone.GetAllParamsCount

function TkwDictionContainerFormParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormParentZone.ParamsTypes

procedure TkwDictionContainerFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ParentZone', aCtx);
end;//TkwDictionContainerFormParentZone.SetValuePrim

procedure TkwDictionContainerFormParentZone.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZone(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormParentZone.DoDoIt

function Tkw_Form_DictionContainer.GetString: AnsiString;
begin
 Result := 'DictionContainerForm';
end;//Tkw_Form_DictionContainer.GetString

class procedure Tkw_Form_DictionContainer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TDictionContainerForm);
end;//Tkw_Form_DictionContainer.RegisterInEngine

class function Tkw_Form_DictionContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::DictionContainer';
end;//Tkw_Form_DictionContainer.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnBackground.GetString: AnsiString;
begin
 Result := 'pnBackground';
end;//Tkw_DictionContainer_Control_pnBackground.GetString

class procedure Tkw_DictionContainer_Control_pnBackground.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_DictionContainer_Control_pnBackground.RegisterInEngine

class function Tkw_DictionContainer_Control_pnBackground.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBackground';
end;//Tkw_DictionContainer_Control_pnBackground.GetWordNameForRegister

procedure Tkw_DictionContainer_Control_pnBackground_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnBackground');
 inherited;
end;//Tkw_DictionContainer_Control_pnBackground_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnBackground_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBackground:push';
end;//Tkw_DictionContainer_Control_pnBackground_Push.GetWordNameForRegister

function Tkw_DictionContainer_Control_NavigatorZone.GetString: AnsiString;
begin
 Result := 'NavigatorZone';
end;//Tkw_DictionContainer_Control_NavigatorZone.GetString

class procedure Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine

class function Tkw_DictionContainer_Control_NavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NavigatorZone';
end;//Tkw_DictionContainer_Control_NavigatorZone.GetWordNameForRegister

procedure Tkw_DictionContainer_Control_NavigatorZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NavigatorZone');
 inherited;
end;//Tkw_DictionContainer_Control_NavigatorZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_NavigatorZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NavigatorZone:push';
end;//Tkw_DictionContainer_Control_NavigatorZone_Push.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnWorkArea.GetString: AnsiString;
begin
 Result := 'pnWorkArea';
end;//Tkw_DictionContainer_Control_pnWorkArea.GetString

class procedure Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine

class function Tkw_DictionContainer_Control_pnWorkArea.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnWorkArea';
end;//Tkw_DictionContainer_Control_pnWorkArea.GetWordNameForRegister

procedure Tkw_DictionContainer_Control_pnWorkArea_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnWorkArea');
 inherited;
end;//Tkw_DictionContainer_Control_pnWorkArea_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnWorkArea_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnWorkArea:push';
end;//Tkw_DictionContainer_Control_pnWorkArea_Push.GetWordNameForRegister

function Tkw_DictionContainer_Control_ChildZone.GetString: AnsiString;
begin
 Result := 'ChildZone';
end;//Tkw_DictionContainer_Control_ChildZone.GetString

class procedure Tkw_DictionContainer_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_DictionContainer_Control_ChildZone.RegisterInEngine

class function Tkw_DictionContainer_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone';
end;//Tkw_DictionContainer_Control_ChildZone.GetWordNameForRegister

procedure Tkw_DictionContainer_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_DictionContainer_Control_ChildZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone:push';
end;//Tkw_DictionContainer_Control_ChildZone_Push.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnHeader.GetString: AnsiString;
begin
 Result := 'pnHeader';
end;//Tkw_DictionContainer_Control_pnHeader.GetString

class procedure Tkw_DictionContainer_Control_pnHeader.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_DictionContainer_Control_pnHeader.RegisterInEngine

class function Tkw_DictionContainer_Control_pnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnHeader';
end;//Tkw_DictionContainer_Control_pnHeader.GetWordNameForRegister

procedure Tkw_DictionContainer_Control_pnHeader_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnHeader');
 inherited;
end;//Tkw_DictionContainer_Control_pnHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnHeader:push';
end;//Tkw_DictionContainer_Control_pnHeader_Push.GetWordNameForRegister

function Tkw_DictionContainer_Control_lbHeader.GetString: AnsiString;
begin
 Result := 'lbHeader';
end;//Tkw_DictionContainer_Control_lbHeader.GetString

class procedure Tkw_DictionContainer_Control_lbHeader.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DictionContainer_Control_lbHeader.RegisterInEngine

class function Tkw_DictionContainer_Control_lbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbHeader';
end;//Tkw_DictionContainer_Control_lbHeader.GetWordNameForRegister

procedure Tkw_DictionContainer_Control_lbHeader_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbHeader');
 inherited;
end;//Tkw_DictionContainer_Control_lbHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_lbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbHeader:push';
end;//Tkw_DictionContainer_Control_lbHeader_Push.GetWordNameForRegister

function Tkw_DictionContainer_Control_pbHeader.GetString: AnsiString;
begin
 Result := 'pbHeader';
end;//Tkw_DictionContainer_Control_pbHeader.GetString

class procedure Tkw_DictionContainer_Control_pbHeader.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_DictionContainer_Control_pbHeader.RegisterInEngine

class function Tkw_DictionContainer_Control_pbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbHeader';
end;//Tkw_DictionContainer_Control_pbHeader.GetWordNameForRegister

procedure Tkw_DictionContainer_Control_pbHeader_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbHeader');
 inherited;
end;//Tkw_DictionContainer_Control_pbHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_pbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbHeader:push';
end;//Tkw_DictionContainer_Control_pbHeader_Push.GetWordNameForRegister

function Tkw_DictionContainer_Control_ParentZone.GetString: AnsiString;
begin
 Result := 'ParentZone';
end;//Tkw_DictionContainer_Control_ParentZone.GetString

class procedure Tkw_DictionContainer_Control_ParentZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_DictionContainer_Control_ParentZone.RegisterInEngine

class function Tkw_DictionContainer_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone';
end;//Tkw_DictionContainer_Control_ParentZone.GetWordNameForRegister

procedure Tkw_DictionContainer_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_DictionContainer_Control_ParentZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone:push';
end;//Tkw_DictionContainer_Control_ParentZone_Push.GetWordNameForRegister

initialization
 TkwDictionContainerFormPnBackground.RegisterInEngine;
 {* ����������� DictionContainerForm_pnBackground }
 TkwDictionContainerFormNavigatorZone.RegisterInEngine;
 {* ����������� DictionContainerForm_NavigatorZone }
 TkwDictionContainerFormPnWorkArea.RegisterInEngine;
 {* ����������� DictionContainerForm_pnWorkArea }
 TkwDictionContainerFormChildZone.RegisterInEngine;
 {* ����������� DictionContainerForm_ChildZone }
 TkwDictionContainerFormPnHeader.RegisterInEngine;
 {* ����������� DictionContainerForm_pnHeader }
 TkwDictionContainerFormLbHeader.RegisterInEngine;
 {* ����������� DictionContainerForm_lbHeader }
 TkwDictionContainerFormPbHeader.RegisterInEngine;
 {* ����������� DictionContainerForm_pbHeader }
 TkwDictionContainerFormParentZone.RegisterInEngine;
 {* ����������� DictionContainerForm_ParentZone }
 Tkw_Form_DictionContainer.RegisterInEngine;
 {* ����������� Tkw_Form_DictionContainer }
 Tkw_DictionContainer_Control_pnBackground.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnBackground }
 Tkw_DictionContainer_Control_pnBackground_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnBackground_Push }
 Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_NavigatorZone }
 Tkw_DictionContainer_Control_NavigatorZone_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_NavigatorZone_Push }
 Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnWorkArea }
 Tkw_DictionContainer_Control_pnWorkArea_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnWorkArea_Push }
 Tkw_DictionContainer_Control_ChildZone.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_ChildZone }
 Tkw_DictionContainer_Control_ChildZone_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_ChildZone_Push }
 Tkw_DictionContainer_Control_pnHeader.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnHeader }
 Tkw_DictionContainer_Control_pnHeader_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnHeader_Push }
 Tkw_DictionContainer_Control_lbHeader.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_lbHeader }
 Tkw_DictionContainer_Control_lbHeader_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_lbHeader_Push }
 Tkw_DictionContainer_Control_pbHeader.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pbHeader }
 Tkw_DictionContainer_Control_pbHeader_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pbHeader_Push }
 Tkw_DictionContainer_Control_ParentZone.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_ParentZone }
 Tkw_DictionContainer_Control_ParentZone_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_ParentZone_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDictionContainerForm));
 {* ����������� ���� TDictionContainerForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
