unit AACContainerKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� AACContainer }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\Forms\AACContainerKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "AACContainerKeywordsPack" MUID: (4FF2E95602D8_Pack)

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
 , AACContainer_Form
 , tfwPropertyLike
 , vtProportionalPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtPanel
 , vtScrollBar
 , vtSizeablePanel
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwAACContainerFormPnBack = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnBack }
  private
   function pnBack(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnBack }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormPnBack

 TkwAACContainerFormPnRightEx = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnRightEx }
  private
   function pnRightEx(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnRightEx }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormPnRightEx

 TkwAACContainerFormPnRightForScroll = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnRightForScroll }
  private
   function pnRightForScroll(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnRightForScroll }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormPnRightForScroll

 TkwAACContainerFormPnRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnRight }
  private
   function pnRight(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnRight }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormPnRight

 TkwAACContainerFormPnlRightTop = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnlRightTop }
  private
   function pnlRightTop(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnlRightTop }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormPnlRightTop

 TkwAACContainerFormScrRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.scrRight }
  private
   function scrRight(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtScrollBar;
    {* ���������� ����� ������� .TAACContainerForm.scrRight }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormScrRight

 TkwAACContainerFormPnLeftEx = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnLeftEx }
  private
   function pnLeftEx(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TAACContainerForm.pnLeftEx }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormPnLeftEx

 TkwAACContainerFormPnLeftForScroll = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnLeftForScroll }
  private
   function pnLeftForScroll(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnLeftForScroll }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormPnLeftForScroll

 TkwAACContainerFormPnlLeftTop = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnlLeftTop }
  private
   function pnlLeftTop(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnlLeftTop }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormPnlLeftTop

 TkwAACContainerFormPnLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnLeft }
  private
   function pnLeft(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormPnLeft

 TkwAACContainerFormScrLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.scrLeft }
  private
   function scrLeft(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtScrollBar;
    {* ���������� ����� ������� .TAACContainerForm.scrLeft }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContainerFormScrLeft

 Tkw_Form_AACContainer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� AACContainer
----
*������ �������������*:
[code]�����::AACContainer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_AACContainer

 Tkw_AACContainer_Control_pnBack = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnBack
----
*������ �������������*:
[code]�������::pnBack TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnBack

 Tkw_AACContainer_Control_pnBack_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnBack
----
*������ �������������*:
[code]�������::pnBack:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnBack_Push

 Tkw_AACContainer_Control_pnRightEx = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRightEx
----
*������ �������������*:
[code]�������::pnRightEx TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRightEx

 Tkw_AACContainer_Control_pnRightEx_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnRightEx
----
*������ �������������*:
[code]�������::pnRightEx:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRightEx_Push

 Tkw_AACContainer_Control_pnRightForScroll = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRightForScroll
----
*������ �������������*:
[code]�������::pnRightForScroll TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRightForScroll

 Tkw_AACContainer_Control_pnRightForScroll_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnRightForScroll
----
*������ �������������*:
[code]�������::pnRightForScroll:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRightForScroll_Push

 Tkw_AACContainer_Control_pnRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRight
----
*������ �������������*:
[code]�������::pnRight TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRight

 Tkw_AACContainer_Control_pnRight_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnRight
----
*������ �������������*:
[code]�������::pnRight:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRight_Push

 Tkw_AACContainer_Control_pnlRightTop = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlRightTop
----
*������ �������������*:
[code]�������::pnlRightTop TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnlRightTop

 Tkw_AACContainer_Control_pnlRightTop_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlRightTop
----
*������ �������������*:
[code]�������::pnlRightTop:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnlRightTop_Push

 Tkw_AACContainer_Control_scrRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� scrRight
----
*������ �������������*:
[code]�������::scrRight TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_scrRight

 Tkw_AACContainer_Control_scrRight_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� scrRight
----
*������ �������������*:
[code]�������::scrRight:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_scrRight_Push

 Tkw_AACContainer_Control_pnLeftEx = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeftEx
----
*������ �������������*:
[code]�������::pnLeftEx TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeftEx

 Tkw_AACContainer_Control_pnLeftEx_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeftEx
----
*������ �������������*:
[code]�������::pnLeftEx:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeftEx_Push

 Tkw_AACContainer_Control_pnLeftForScroll = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeftForScroll
----
*������ �������������*:
[code]�������::pnLeftForScroll TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeftForScroll

 Tkw_AACContainer_Control_pnLeftForScroll_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeftForScroll
----
*������ �������������*:
[code]�������::pnLeftForScroll:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeftForScroll_Push

 Tkw_AACContainer_Control_pnlLeftTop = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlLeftTop
----
*������ �������������*:
[code]�������::pnlLeftTop TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnlLeftTop

 Tkw_AACContainer_Control_pnlLeftTop_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlLeftTop
----
*������ �������������*:
[code]�������::pnlLeftTop:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnlLeftTop_Push

 Tkw_AACContainer_Control_pnLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeft
----
*������ �������������*:
[code]�������::pnLeft TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeft

 Tkw_AACContainer_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeft
----
*������ �������������*:
[code]�������::pnLeft:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeft_Push

 Tkw_AACContainer_Control_scrLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� scrLeft
----
*������ �������������*:
[code]�������::scrLeft TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_scrLeft

 Tkw_AACContainer_Control_scrLeft_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� scrLeft
----
*������ �������������*:
[code]�������::scrLeft:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_scrLeft_Push

function TkwAACContainerFormPnBack.pnBack(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnBack }
begin
 Result := aAACContainerForm.pnBack;
end;//TkwAACContainerFormPnBack.pnBack

class function TkwAACContainerFormPnBack.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnBack';
end;//TkwAACContainerFormPnBack.GetWordNameForRegister

function TkwAACContainerFormPnBack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwAACContainerFormPnBack.GetResultTypeInfo

function TkwAACContainerFormPnBack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnBack.GetAllParamsCount

function TkwAACContainerFormPnBack.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnBack.ParamsTypes

procedure TkwAACContainerFormPnBack.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnBack', aCtx);
end;//TkwAACContainerFormPnBack.SetValuePrim

procedure TkwAACContainerFormPnBack.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnBack(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnBack.DoDoIt

function TkwAACContainerFormPnRightEx.pnRightEx(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnRightEx }
begin
 Result := aAACContainerForm.pnRightEx;
end;//TkwAACContainerFormPnRightEx.pnRightEx

class function TkwAACContainerFormPnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnRightEx';
end;//TkwAACContainerFormPnRightEx.GetWordNameForRegister

function TkwAACContainerFormPnRightEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnRightEx.GetResultTypeInfo

function TkwAACContainerFormPnRightEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnRightEx.GetAllParamsCount

function TkwAACContainerFormPnRightEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnRightEx.ParamsTypes

procedure TkwAACContainerFormPnRightEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnRightEx', aCtx);
end;//TkwAACContainerFormPnRightEx.SetValuePrim

procedure TkwAACContainerFormPnRightEx.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRightEx(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnRightEx.DoDoIt

function TkwAACContainerFormPnRightForScroll.pnRightForScroll(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnRightForScroll }
begin
 Result := aAACContainerForm.pnRightForScroll;
end;//TkwAACContainerFormPnRightForScroll.pnRightForScroll

class function TkwAACContainerFormPnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnRightForScroll';
end;//TkwAACContainerFormPnRightForScroll.GetWordNameForRegister

function TkwAACContainerFormPnRightForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnRightForScroll.GetResultTypeInfo

function TkwAACContainerFormPnRightForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnRightForScroll.GetAllParamsCount

function TkwAACContainerFormPnRightForScroll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnRightForScroll.ParamsTypes

procedure TkwAACContainerFormPnRightForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnRightForScroll', aCtx);
end;//TkwAACContainerFormPnRightForScroll.SetValuePrim

procedure TkwAACContainerFormPnRightForScroll.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRightForScroll(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnRightForScroll.DoDoIt

function TkwAACContainerFormPnRight.pnRight(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnRight }
begin
 Result := aAACContainerForm.pnRight;
end;//TkwAACContainerFormPnRight.pnRight

class function TkwAACContainerFormPnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnRight';
end;//TkwAACContainerFormPnRight.GetWordNameForRegister

function TkwAACContainerFormPnRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnRight.GetResultTypeInfo

function TkwAACContainerFormPnRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnRight.GetAllParamsCount

function TkwAACContainerFormPnRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnRight.ParamsTypes

procedure TkwAACContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnRight', aCtx);
end;//TkwAACContainerFormPnRight.SetValuePrim

procedure TkwAACContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRight(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnRight.DoDoIt

function TkwAACContainerFormPnlRightTop.pnlRightTop(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnlRightTop }
begin
 Result := aAACContainerForm.pnlRightTop;
end;//TkwAACContainerFormPnlRightTop.pnlRightTop

class function TkwAACContainerFormPnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnlRightTop';
end;//TkwAACContainerFormPnlRightTop.GetWordNameForRegister

function TkwAACContainerFormPnlRightTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnlRightTop.GetResultTypeInfo

function TkwAACContainerFormPnlRightTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnlRightTop.GetAllParamsCount

function TkwAACContainerFormPnlRightTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnlRightTop.ParamsTypes

procedure TkwAACContainerFormPnlRightTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlRightTop', aCtx);
end;//TkwAACContainerFormPnlRightTop.SetValuePrim

procedure TkwAACContainerFormPnlRightTop.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlRightTop(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnlRightTop.DoDoIt

function TkwAACContainerFormScrRight.scrRight(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtScrollBar;
 {* ���������� ����� ������� .TAACContainerForm.scrRight }
begin
 Result := aAACContainerForm.scrRight;
end;//TkwAACContainerFormScrRight.scrRight

class function TkwAACContainerFormScrRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.scrRight';
end;//TkwAACContainerFormScrRight.GetWordNameForRegister

function TkwAACContainerFormScrRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContainerFormScrRight.GetResultTypeInfo

function TkwAACContainerFormScrRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormScrRight.GetAllParamsCount

function TkwAACContainerFormScrRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormScrRight.ParamsTypes

procedure TkwAACContainerFormScrRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� scrRight', aCtx);
end;//TkwAACContainerFormScrRight.SetValuePrim

procedure TkwAACContainerFormScrRight.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(scrRight(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormScrRight.DoDoIt

function TkwAACContainerFormPnLeftEx.pnLeftEx(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TAACContainerForm.pnLeftEx }
begin
 Result := aAACContainerForm.pnLeftEx;
end;//TkwAACContainerFormPnLeftEx.pnLeftEx

class function TkwAACContainerFormPnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLeftEx';
end;//TkwAACContainerFormPnLeftEx.GetWordNameForRegister

function TkwAACContainerFormPnLeftEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwAACContainerFormPnLeftEx.GetResultTypeInfo

function TkwAACContainerFormPnLeftEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnLeftEx.GetAllParamsCount

function TkwAACContainerFormPnLeftEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLeftEx.ParamsTypes

procedure TkwAACContainerFormPnLeftEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeftEx', aCtx);
end;//TkwAACContainerFormPnLeftEx.SetValuePrim

procedure TkwAACContainerFormPnLeftEx.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeftEx(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnLeftEx.DoDoIt

function TkwAACContainerFormPnLeftForScroll.pnLeftForScroll(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnLeftForScroll }
begin
 Result := aAACContainerForm.pnLeftForScroll;
end;//TkwAACContainerFormPnLeftForScroll.pnLeftForScroll

class function TkwAACContainerFormPnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLeftForScroll';
end;//TkwAACContainerFormPnLeftForScroll.GetWordNameForRegister

function TkwAACContainerFormPnLeftForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnLeftForScroll.GetResultTypeInfo

function TkwAACContainerFormPnLeftForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnLeftForScroll.GetAllParamsCount

function TkwAACContainerFormPnLeftForScroll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLeftForScroll.ParamsTypes

procedure TkwAACContainerFormPnLeftForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeftForScroll', aCtx);
end;//TkwAACContainerFormPnLeftForScroll.SetValuePrim

procedure TkwAACContainerFormPnLeftForScroll.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeftForScroll(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnLeftForScroll.DoDoIt

function TkwAACContainerFormPnlLeftTop.pnlLeftTop(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnlLeftTop }
begin
 Result := aAACContainerForm.pnlLeftTop;
end;//TkwAACContainerFormPnlLeftTop.pnlLeftTop

class function TkwAACContainerFormPnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnlLeftTop';
end;//TkwAACContainerFormPnlLeftTop.GetWordNameForRegister

function TkwAACContainerFormPnlLeftTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnlLeftTop.GetResultTypeInfo

function TkwAACContainerFormPnlLeftTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnlLeftTop.GetAllParamsCount

function TkwAACContainerFormPnlLeftTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnlLeftTop.ParamsTypes

procedure TkwAACContainerFormPnlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlLeftTop', aCtx);
end;//TkwAACContainerFormPnlLeftTop.SetValuePrim

procedure TkwAACContainerFormPnlLeftTop.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLeftTop(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnlLeftTop.DoDoIt

function TkwAACContainerFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnLeft }
begin
 Result := aAACContainerForm.pnLeft;
end;//TkwAACContainerFormPnLeft.pnLeft

class function TkwAACContainerFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLeft';
end;//TkwAACContainerFormPnLeft.GetWordNameForRegister

function TkwAACContainerFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnLeft.GetResultTypeInfo

function TkwAACContainerFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnLeft.GetAllParamsCount

function TkwAACContainerFormPnLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLeft.ParamsTypes

procedure TkwAACContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeft', aCtx);
end;//TkwAACContainerFormPnLeft.SetValuePrim

procedure TkwAACContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeft(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnLeft.DoDoIt

function TkwAACContainerFormScrLeft.scrLeft(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtScrollBar;
 {* ���������� ����� ������� .TAACContainerForm.scrLeft }
begin
 Result := aAACContainerForm.scrLeft;
end;//TkwAACContainerFormScrLeft.scrLeft

class function TkwAACContainerFormScrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.scrLeft';
end;//TkwAACContainerFormScrLeft.GetWordNameForRegister

function TkwAACContainerFormScrLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContainerFormScrLeft.GetResultTypeInfo

function TkwAACContainerFormScrLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormScrLeft.GetAllParamsCount

function TkwAACContainerFormScrLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormScrLeft.ParamsTypes

procedure TkwAACContainerFormScrLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� scrLeft', aCtx);
end;//TkwAACContainerFormScrLeft.SetValuePrim

procedure TkwAACContainerFormScrLeft.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(scrLeft(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormScrLeft.DoDoIt

function Tkw_Form_AACContainer.GetString: AnsiString;
begin
 Result := 'AACContainerForm';
end;//Tkw_Form_AACContainer.GetString

class procedure Tkw_Form_AACContainer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TAACContainerForm);
end;//Tkw_Form_AACContainer.RegisterInEngine

class function Tkw_Form_AACContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::AACContainer';
end;//Tkw_Form_AACContainer.GetWordNameForRegister

function Tkw_AACContainer_Control_pnBack.GetString: AnsiString;
begin
 Result := 'pnBack';
end;//Tkw_AACContainer_Control_pnBack.GetString

class procedure Tkw_AACContainer_Control_pnBack.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AACContainer_Control_pnBack.RegisterInEngine

class function Tkw_AACContainer_Control_pnBack.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBack';
end;//Tkw_AACContainer_Control_pnBack.GetWordNameForRegister

procedure Tkw_AACContainer_Control_pnBack_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnBack');
 inherited;
end;//Tkw_AACContainer_Control_pnBack_Push.DoDoIt

class function Tkw_AACContainer_Control_pnBack_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBack:push';
end;//Tkw_AACContainer_Control_pnBack_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRightEx.GetString: AnsiString;
begin
 Result := 'pnRightEx';
end;//Tkw_AACContainer_Control_pnRightEx.GetString

class procedure Tkw_AACContainer_Control_pnRightEx.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnRightEx.RegisterInEngine

class function Tkw_AACContainer_Control_pnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightEx';
end;//Tkw_AACContainer_Control_pnRightEx.GetWordNameForRegister

procedure Tkw_AACContainer_Control_pnRightEx_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRightEx');
 inherited;
end;//Tkw_AACContainer_Control_pnRightEx_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRightEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightEx:push';
end;//Tkw_AACContainer_Control_pnRightEx_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRightForScroll.GetString: AnsiString;
begin
 Result := 'pnRightForScroll';
end;//Tkw_AACContainer_Control_pnRightForScroll.GetString

class procedure Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine

class function Tkw_AACContainer_Control_pnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightForScroll';
end;//Tkw_AACContainer_Control_pnRightForScroll.GetWordNameForRegister

procedure Tkw_AACContainer_Control_pnRightForScroll_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRightForScroll');
 inherited;
end;//Tkw_AACContainer_Control_pnRightForScroll_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRightForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightForScroll:push';
end;//Tkw_AACContainer_Control_pnRightForScroll_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRight.GetString: AnsiString;
begin
 Result := 'pnRight';
end;//Tkw_AACContainer_Control_pnRight.GetString

class procedure Tkw_AACContainer_Control_pnRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnRight.RegisterInEngine

class function Tkw_AACContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight';
end;//Tkw_AACContainer_Control_pnRight.GetWordNameForRegister

procedure Tkw_AACContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRight');
 inherited;
end;//Tkw_AACContainer_Control_pnRight_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight:push';
end;//Tkw_AACContainer_Control_pnRight_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_pnlRightTop.GetString: AnsiString;
begin
 Result := 'pnlRightTop';
end;//Tkw_AACContainer_Control_pnlRightTop.GetString

class procedure Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine

class function Tkw_AACContainer_Control_pnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRightTop';
end;//Tkw_AACContainer_Control_pnlRightTop.GetWordNameForRegister

procedure Tkw_AACContainer_Control_pnlRightTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlRightTop');
 inherited;
end;//Tkw_AACContainer_Control_pnlRightTop_Push.DoDoIt

class function Tkw_AACContainer_Control_pnlRightTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRightTop:push';
end;//Tkw_AACContainer_Control_pnlRightTop_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_scrRight.GetString: AnsiString;
begin
 Result := 'scrRight';
end;//Tkw_AACContainer_Control_scrRight.GetString

class procedure Tkw_AACContainer_Control_scrRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContainer_Control_scrRight.RegisterInEngine

class function Tkw_AACContainer_Control_scrRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrRight';
end;//Tkw_AACContainer_Control_scrRight.GetWordNameForRegister

procedure Tkw_AACContainer_Control_scrRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('scrRight');
 inherited;
end;//Tkw_AACContainer_Control_scrRight_Push.DoDoIt

class function Tkw_AACContainer_Control_scrRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrRight:push';
end;//Tkw_AACContainer_Control_scrRight_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeftEx.GetString: AnsiString;
begin
 Result := 'pnLeftEx';
end;//Tkw_AACContainer_Control_pnLeftEx.GetString

class procedure Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine

class function Tkw_AACContainer_Control_pnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftEx';
end;//Tkw_AACContainer_Control_pnLeftEx.GetWordNameForRegister

procedure Tkw_AACContainer_Control_pnLeftEx_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeftEx');
 inherited;
end;//Tkw_AACContainer_Control_pnLeftEx_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeftEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftEx:push';
end;//Tkw_AACContainer_Control_pnLeftEx_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeftForScroll.GetString: AnsiString;
begin
 Result := 'pnLeftForScroll';
end;//Tkw_AACContainer_Control_pnLeftForScroll.GetString

class procedure Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine

class function Tkw_AACContainer_Control_pnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftForScroll';
end;//Tkw_AACContainer_Control_pnLeftForScroll.GetWordNameForRegister

procedure Tkw_AACContainer_Control_pnLeftForScroll_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeftForScroll');
 inherited;
end;//Tkw_AACContainer_Control_pnLeftForScroll_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftForScroll:push';
end;//Tkw_AACContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_pnlLeftTop.GetString: AnsiString;
begin
 Result := 'pnlLeftTop';
end;//Tkw_AACContainer_Control_pnlLeftTop.GetString

class procedure Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine

class function Tkw_AACContainer_Control_pnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeftTop';
end;//Tkw_AACContainer_Control_pnlLeftTop.GetWordNameForRegister

procedure Tkw_AACContainer_Control_pnlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLeftTop');
 inherited;
end;//Tkw_AACContainer_Control_pnlLeftTop_Push.DoDoIt

class function Tkw_AACContainer_Control_pnlLeftTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeftTop:push';
end;//Tkw_AACContainer_Control_pnlLeftTop_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeft.GetString: AnsiString;
begin
 Result := 'pnLeft';
end;//Tkw_AACContainer_Control_pnLeft.GetString

class procedure Tkw_AACContainer_Control_pnLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnLeft.RegisterInEngine

class function Tkw_AACContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft';
end;//Tkw_AACContainer_Control_pnLeft.GetWordNameForRegister

procedure Tkw_AACContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_AACContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft:push';
end;//Tkw_AACContainer_Control_pnLeft_Push.GetWordNameForRegister

function Tkw_AACContainer_Control_scrLeft.GetString: AnsiString;
begin
 Result := 'scrLeft';
end;//Tkw_AACContainer_Control_scrLeft.GetString

class procedure Tkw_AACContainer_Control_scrLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContainer_Control_scrLeft.RegisterInEngine

class function Tkw_AACContainer_Control_scrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrLeft';
end;//Tkw_AACContainer_Control_scrLeft.GetWordNameForRegister

procedure Tkw_AACContainer_Control_scrLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('scrLeft');
 inherited;
end;//Tkw_AACContainer_Control_scrLeft_Push.DoDoIt

class function Tkw_AACContainer_Control_scrLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrLeft:push';
end;//Tkw_AACContainer_Control_scrLeft_Push.GetWordNameForRegister

initialization
 TkwAACContainerFormPnBack.RegisterInEngine;
 {* ����������� AACContainerForm_pnBack }
 TkwAACContainerFormPnRightEx.RegisterInEngine;
 {* ����������� AACContainerForm_pnRightEx }
 TkwAACContainerFormPnRightForScroll.RegisterInEngine;
 {* ����������� AACContainerForm_pnRightForScroll }
 TkwAACContainerFormPnRight.RegisterInEngine;
 {* ����������� AACContainerForm_pnRight }
 TkwAACContainerFormPnlRightTop.RegisterInEngine;
 {* ����������� AACContainerForm_pnlRightTop }
 TkwAACContainerFormScrRight.RegisterInEngine;
 {* ����������� AACContainerForm_scrRight }
 TkwAACContainerFormPnLeftEx.RegisterInEngine;
 {* ����������� AACContainerForm_pnLeftEx }
 TkwAACContainerFormPnLeftForScroll.RegisterInEngine;
 {* ����������� AACContainerForm_pnLeftForScroll }
 TkwAACContainerFormPnlLeftTop.RegisterInEngine;
 {* ����������� AACContainerForm_pnlLeftTop }
 TkwAACContainerFormPnLeft.RegisterInEngine;
 {* ����������� AACContainerForm_pnLeft }
 TkwAACContainerFormScrLeft.RegisterInEngine;
 {* ����������� AACContainerForm_scrLeft }
 Tkw_Form_AACContainer.RegisterInEngine;
 {* ����������� Tkw_Form_AACContainer }
 Tkw_AACContainer_Control_pnBack.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnBack }
 Tkw_AACContainer_Control_pnBack_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnBack_Push }
 Tkw_AACContainer_Control_pnRightEx.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnRightEx }
 Tkw_AACContainer_Control_pnRightEx_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnRightEx_Push }
 Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnRightForScroll }
 Tkw_AACContainer_Control_pnRightForScroll_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnRightForScroll_Push }
 Tkw_AACContainer_Control_pnRight.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnRight }
 Tkw_AACContainer_Control_pnRight_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnRight_Push }
 Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnlRightTop }
 Tkw_AACContainer_Control_pnlRightTop_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnlRightTop_Push }
 Tkw_AACContainer_Control_scrRight.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_scrRight }
 Tkw_AACContainer_Control_scrRight_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_scrRight_Push }
 Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnLeftEx }
 Tkw_AACContainer_Control_pnLeftEx_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnLeftEx_Push }
 Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnLeftForScroll }
 Tkw_AACContainer_Control_pnLeftForScroll_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnLeftForScroll_Push }
 Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnlLeftTop }
 Tkw_AACContainer_Control_pnlLeftTop_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnlLeftTop_Push }
 Tkw_AACContainer_Control_pnLeft.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnLeft }
 Tkw_AACContainer_Control_pnLeft_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnLeft_Push }
 Tkw_AACContainer_Control_scrLeft.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_scrLeft }
 Tkw_AACContainer_Control_scrLeft_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_scrLeft_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAACContainerForm));
 {* ����������� ���� TAACContainerForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtScrollBar));
 {* ����������� ���� TvtScrollBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
