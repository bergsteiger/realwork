unit AACContentsContainerKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� AACContentsContainer }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\AACContentsContainerKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "AACContentsContainerKeywordsPack" MUID: (5C766280436C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtProportionalPanel
 , vtPanel
 , vtScrollBar
 , vtSizeablePanel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , AACContentsContainer_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_AACContentsContainer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� AACContentsContainer
----
*������ �������������*:
[code]
'aControl' �����::AACContentsContainer TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_AACContentsContainer

 Tkw_AACContentsContainer_Control_pnBack = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnBack
----
*������ �������������*:
[code]
�������::pnBack TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnBack

 Tkw_AACContentsContainer_Control_pnBack_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnBack
----
*������ �������������*:
[code]
�������::pnBack:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnBack_Push

 Tkw_AACContentsContainer_Control_pnRightEx = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRightEx
----
*������ �������������*:
[code]
�������::pnRightEx TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRightEx

 Tkw_AACContentsContainer_Control_pnRightEx_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnRightEx
----
*������ �������������*:
[code]
�������::pnRightEx:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRightEx_Push

 Tkw_AACContentsContainer_Control_pnRightForScroll = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRightForScroll
----
*������ �������������*:
[code]
�������::pnRightForScroll TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRightForScroll

 Tkw_AACContentsContainer_Control_pnRightForScroll_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnRightForScroll
----
*������ �������������*:
[code]
�������::pnRightForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push

 Tkw_AACContentsContainer_Control_pnRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRight
----
*������ �������������*:
[code]
�������::pnRight TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRight

 Tkw_AACContentsContainer_Control_pnRight_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnRight
----
*������ �������������*:
[code]
�������::pnRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRight_Push

 Tkw_AACContentsContainer_Control_pnlRightTop = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlRightTop
----
*������ �������������*:
[code]
�������::pnlRightTop TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnlRightTop

 Tkw_AACContentsContainer_Control_pnlRightTop_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlRightTop
----
*������ �������������*:
[code]
�������::pnlRightTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push

 Tkw_AACContentsContainer_Control_scrRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� scrRight
----
*������ �������������*:
[code]
�������::scrRight TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_scrRight

 Tkw_AACContentsContainer_Control_scrRight_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� scrRight
----
*������ �������������*:
[code]
�������::scrRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_scrRight_Push

 Tkw_AACContentsContainer_Control_pnLeftEx = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeftEx
----
*������ �������������*:
[code]
�������::pnLeftEx TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftEx

 Tkw_AACContentsContainer_Control_pnLeftEx_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnLeftEx
----
*������ �������������*:
[code]
�������::pnLeftEx:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push

 Tkw_AACContentsContainer_Control_pnLeftForScroll = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeftForScroll
----
*������ �������������*:
[code]
�������::pnLeftForScroll TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftForScroll

 Tkw_AACContentsContainer_Control_pnLeftForScroll_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnLeftForScroll
----
*������ �������������*:
[code]
�������::pnLeftForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push

 Tkw_AACContentsContainer_Control_pnlLeftTop = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlLeftTop
----
*������ �������������*:
[code]
�������::pnlLeftTop TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnlLeftTop

 Tkw_AACContentsContainer_Control_pnlLeftTop_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlLeftTop
----
*������ �������������*:
[code]
�������::pnlLeftTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push

 Tkw_AACContentsContainer_Control_pnLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeft

 Tkw_AACContentsContainer_Control_pnLeft_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeft_Push

 Tkw_AACContentsContainer_Control_scrLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� scrLeft
----
*������ �������������*:
[code]
�������::scrLeft TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_scrLeft

 Tkw_AACContentsContainer_Control_scrLeft_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� scrLeft
----
*������ �������������*:
[code]
�������::scrLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_scrLeft_Push

 TkwAACContentsContainerFormPnBack = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.pnBack }
  private
   function pnBack(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TAACContentsContainerForm.pnBack }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnBack

 TkwAACContentsContainerFormPnRightEx = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.pnRightEx }
  private
   function pnRightEx(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContentsContainerForm.pnRightEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnRightEx

 TkwAACContentsContainerFormPnRightForScroll = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.pnRightForScroll }
  private
   function pnRightForScroll(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContentsContainerForm.pnRightForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnRightForScroll

 TkwAACContentsContainerFormPnRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.pnRight }
  private
   function pnRight(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContentsContainerForm.pnRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnRight

 TkwAACContentsContainerFormPnlRightTop = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.pnlRightTop }
  private
   function pnlRightTop(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContentsContainerForm.pnlRightTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnlRightTop

 TkwAACContentsContainerFormScrRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.scrRight }
  private
   function scrRight(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
    {* ���������� ����� ������� .TAACContentsContainerForm.scrRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormScrRight

 TkwAACContentsContainerFormPnLeftEx = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.pnLeftEx }
  private
   function pnLeftEx(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TAACContentsContainerForm.pnLeftEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnLeftEx

 TkwAACContentsContainerFormPnLeftForScroll = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.pnLeftForScroll }
  private
   function pnLeftForScroll(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContentsContainerForm.pnLeftForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnLeftForScroll

 TkwAACContentsContainerFormPnlLeftTop = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.pnlLeftTop }
  private
   function pnlLeftTop(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContentsContainerForm.pnlLeftTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnlLeftTop

 TkwAACContentsContainerFormPnLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.pnLeft }
  private
   function pnLeft(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContentsContainerForm.pnLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnLeft

 TkwAACContentsContainerFormScrLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContentsContainerForm.scrLeft }
  private
   function scrLeft(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
    {* ���������� ����� ������� .TAACContentsContainerForm.scrLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormScrLeft

function Tkw_Form_AACContentsContainer.GetString: AnsiString;
begin
 Result := 'AACContentsContainerForm';
end;//Tkw_Form_AACContentsContainer.GetString

class function Tkw_Form_AACContentsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::AACContentsContainer';
end;//Tkw_Form_AACContentsContainer.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnBack.GetString: AnsiString;
begin
 Result := 'pnBack';
end;//Tkw_AACContentsContainer_Control_pnBack.GetString

class procedure Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnBack.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBack';
end;//Tkw_AACContentsContainer_Control_pnBack.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnBack_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnBack');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnBack_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnBack_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBack:push';
end;//Tkw_AACContentsContainer_Control_pnBack_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRightEx.GetString: AnsiString;
begin
 Result := 'pnRightEx';
end;//Tkw_AACContentsContainer_Control_pnRightEx.GetString

class procedure Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightEx';
end;//Tkw_AACContentsContainer_Control_pnRightEx.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnRightEx_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRightEx');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnRightEx_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRightEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightEx:push';
end;//Tkw_AACContentsContainer_Control_pnRightEx_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRightForScroll.GetString: AnsiString;
begin
 Result := 'pnRightForScroll';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.GetString

class procedure Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightForScroll';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnRightForScroll_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRightForScroll');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRightForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightForScroll:push';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRight.GetString: AnsiString;
begin
 Result := 'pnRight';
end;//Tkw_AACContentsContainer_Control_pnRight.GetString

class procedure Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight';
end;//Tkw_AACContentsContainer_Control_pnRight.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRight');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnRight_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight:push';
end;//Tkw_AACContentsContainer_Control_pnRight_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnlRightTop.GetString: AnsiString;
begin
 Result := 'pnlRightTop';
end;//Tkw_AACContentsContainer_Control_pnlRightTop.GetString

class procedure Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRightTop';
end;//Tkw_AACContentsContainer_Control_pnlRightTop.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnlRightTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlRightTop');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnlRightTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRightTop:push';
end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_scrRight.GetString: AnsiString;
begin
 Result := 'scrRight';
end;//Tkw_AACContentsContainer_Control_scrRight.GetString

class procedure Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine

class function Tkw_AACContentsContainer_Control_scrRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrRight';
end;//Tkw_AACContentsContainer_Control_scrRight.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_scrRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('scrRight');
 inherited;
end;//Tkw_AACContentsContainer_Control_scrRight_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_scrRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrRight:push';
end;//Tkw_AACContentsContainer_Control_scrRight_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeftEx.GetString: AnsiString;
begin
 Result := 'pnLeftEx';
end;//Tkw_AACContentsContainer_Control_pnLeftEx.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftEx';
end;//Tkw_AACContentsContainer_Control_pnLeftEx.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnLeftEx_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeftEx');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeftEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftEx:push';
end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeftForScroll.GetString: AnsiString;
begin
 Result := 'pnLeftForScroll';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftForScroll';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeftForScroll');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftForScroll:push';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnlLeftTop.GetString: AnsiString;
begin
 Result := 'pnlLeftTop';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.GetString

class procedure Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeftTop';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLeftTop');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnlLeftTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeftTop:push';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeft.GetString: AnsiString;
begin
 Result := 'pnLeft';
end;//Tkw_AACContentsContainer_Control_pnLeft.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft';
end;//Tkw_AACContentsContainer_Control_pnLeft.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft:push';
end;//Tkw_AACContentsContainer_Control_pnLeft_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_scrLeft.GetString: AnsiString;
begin
 Result := 'scrLeft';
end;//Tkw_AACContentsContainer_Control_scrLeft.GetString

class procedure Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine

class function Tkw_AACContentsContainer_Control_scrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrLeft';
end;//Tkw_AACContentsContainer_Control_scrLeft.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_scrLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('scrLeft');
 inherited;
end;//Tkw_AACContentsContainer_Control_scrLeft_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_scrLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrLeft:push';
end;//Tkw_AACContentsContainer_Control_scrLeft_Push.GetWordNameForRegister

function TkwAACContentsContainerFormPnBack.pnBack(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TAACContentsContainerForm.pnBack }
begin
 Result := aAACContentsContainerForm.pnBack;
end;//TkwAACContentsContainerFormPnBack.pnBack

procedure TkwAACContentsContainerFormPnBack.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnBack(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnBack.DoDoIt

class function TkwAACContentsContainerFormPnBack.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnBack';
end;//TkwAACContentsContainerFormPnBack.GetWordNameForRegister

function TkwAACContentsContainerFormPnBack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwAACContentsContainerFormPnBack.GetResultTypeInfo

function TkwAACContentsContainerFormPnBack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnBack.GetAllParamsCount

function TkwAACContentsContainerFormPnBack.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnBack.ParamsTypes

procedure TkwAACContentsContainerFormPnBack.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnBack', aCtx);
end;//TkwAACContentsContainerFormPnBack.SetValuePrim

function TkwAACContentsContainerFormPnRightEx.pnRightEx(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContentsContainerForm.pnRightEx }
begin
 Result := aAACContentsContainerForm.pnRightEx;
end;//TkwAACContentsContainerFormPnRightEx.pnRightEx

procedure TkwAACContentsContainerFormPnRightEx.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRightEx(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnRightEx.DoDoIt

class function TkwAACContentsContainerFormPnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnRightEx';
end;//TkwAACContentsContainerFormPnRightEx.GetWordNameForRegister

function TkwAACContentsContainerFormPnRightEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnRightEx.GetResultTypeInfo

function TkwAACContentsContainerFormPnRightEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnRightEx.GetAllParamsCount

function TkwAACContentsContainerFormPnRightEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnRightEx.ParamsTypes

procedure TkwAACContentsContainerFormPnRightEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnRightEx', aCtx);
end;//TkwAACContentsContainerFormPnRightEx.SetValuePrim

function TkwAACContentsContainerFormPnRightForScroll.pnRightForScroll(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContentsContainerForm.pnRightForScroll }
begin
 Result := aAACContentsContainerForm.pnRightForScroll;
end;//TkwAACContentsContainerFormPnRightForScroll.pnRightForScroll

procedure TkwAACContentsContainerFormPnRightForScroll.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRightForScroll(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnRightForScroll.DoDoIt

class function TkwAACContentsContainerFormPnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnRightForScroll';
end;//TkwAACContentsContainerFormPnRightForScroll.GetWordNameForRegister

function TkwAACContentsContainerFormPnRightForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnRightForScroll.GetResultTypeInfo

function TkwAACContentsContainerFormPnRightForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnRightForScroll.GetAllParamsCount

function TkwAACContentsContainerFormPnRightForScroll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnRightForScroll.ParamsTypes

procedure TkwAACContentsContainerFormPnRightForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnRightForScroll', aCtx);
end;//TkwAACContentsContainerFormPnRightForScroll.SetValuePrim

function TkwAACContentsContainerFormPnRight.pnRight(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContentsContainerForm.pnRight }
begin
 Result := aAACContentsContainerForm.pnRight;
end;//TkwAACContentsContainerFormPnRight.pnRight

procedure TkwAACContentsContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRight(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnRight.DoDoIt

class function TkwAACContentsContainerFormPnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnRight';
end;//TkwAACContentsContainerFormPnRight.GetWordNameForRegister

function TkwAACContentsContainerFormPnRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnRight.GetResultTypeInfo

function TkwAACContentsContainerFormPnRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnRight.GetAllParamsCount

function TkwAACContentsContainerFormPnRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnRight.ParamsTypes

procedure TkwAACContentsContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnRight', aCtx);
end;//TkwAACContentsContainerFormPnRight.SetValuePrim

function TkwAACContentsContainerFormPnlRightTop.pnlRightTop(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContentsContainerForm.pnlRightTop }
begin
 Result := aAACContentsContainerForm.pnlRightTop;
end;//TkwAACContentsContainerFormPnlRightTop.pnlRightTop

procedure TkwAACContentsContainerFormPnlRightTop.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlRightTop(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnlRightTop.DoDoIt

class function TkwAACContentsContainerFormPnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnlRightTop';
end;//TkwAACContentsContainerFormPnlRightTop.GetWordNameForRegister

function TkwAACContentsContainerFormPnlRightTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnlRightTop.GetResultTypeInfo

function TkwAACContentsContainerFormPnlRightTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnlRightTop.GetAllParamsCount

function TkwAACContentsContainerFormPnlRightTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnlRightTop.ParamsTypes

procedure TkwAACContentsContainerFormPnlRightTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlRightTop', aCtx);
end;//TkwAACContentsContainerFormPnlRightTop.SetValuePrim

function TkwAACContentsContainerFormScrRight.scrRight(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
 {* ���������� ����� ������� .TAACContentsContainerForm.scrRight }
begin
 Result := aAACContentsContainerForm.scrRight;
end;//TkwAACContentsContainerFormScrRight.scrRight

procedure TkwAACContentsContainerFormScrRight.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(scrRight(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormScrRight.DoDoIt

class function TkwAACContentsContainerFormScrRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.scrRight';
end;//TkwAACContentsContainerFormScrRight.GetWordNameForRegister

function TkwAACContentsContainerFormScrRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContentsContainerFormScrRight.GetResultTypeInfo

function TkwAACContentsContainerFormScrRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormScrRight.GetAllParamsCount

function TkwAACContentsContainerFormScrRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormScrRight.ParamsTypes

procedure TkwAACContentsContainerFormScrRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� scrRight', aCtx);
end;//TkwAACContentsContainerFormScrRight.SetValuePrim

function TkwAACContentsContainerFormPnLeftEx.pnLeftEx(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TAACContentsContainerForm.pnLeftEx }
begin
 Result := aAACContentsContainerForm.pnLeftEx;
end;//TkwAACContentsContainerFormPnLeftEx.pnLeftEx

procedure TkwAACContentsContainerFormPnLeftEx.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeftEx(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnLeftEx.DoDoIt

class function TkwAACContentsContainerFormPnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnLeftEx';
end;//TkwAACContentsContainerFormPnLeftEx.GetWordNameForRegister

function TkwAACContentsContainerFormPnLeftEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwAACContentsContainerFormPnLeftEx.GetResultTypeInfo

function TkwAACContentsContainerFormPnLeftEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnLeftEx.GetAllParamsCount

function TkwAACContentsContainerFormPnLeftEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnLeftEx.ParamsTypes

procedure TkwAACContentsContainerFormPnLeftEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeftEx', aCtx);
end;//TkwAACContentsContainerFormPnLeftEx.SetValuePrim

function TkwAACContentsContainerFormPnLeftForScroll.pnLeftForScroll(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContentsContainerForm.pnLeftForScroll }
begin
 Result := aAACContentsContainerForm.pnLeftForScroll;
end;//TkwAACContentsContainerFormPnLeftForScroll.pnLeftForScroll

procedure TkwAACContentsContainerFormPnLeftForScroll.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeftForScroll(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnLeftForScroll.DoDoIt

class function TkwAACContentsContainerFormPnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnLeftForScroll';
end;//TkwAACContentsContainerFormPnLeftForScroll.GetWordNameForRegister

function TkwAACContentsContainerFormPnLeftForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnLeftForScroll.GetResultTypeInfo

function TkwAACContentsContainerFormPnLeftForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnLeftForScroll.GetAllParamsCount

function TkwAACContentsContainerFormPnLeftForScroll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnLeftForScroll.ParamsTypes

procedure TkwAACContentsContainerFormPnLeftForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeftForScroll', aCtx);
end;//TkwAACContentsContainerFormPnLeftForScroll.SetValuePrim

function TkwAACContentsContainerFormPnlLeftTop.pnlLeftTop(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContentsContainerForm.pnlLeftTop }
begin
 Result := aAACContentsContainerForm.pnlLeftTop;
end;//TkwAACContentsContainerFormPnlLeftTop.pnlLeftTop

procedure TkwAACContentsContainerFormPnlLeftTop.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLeftTop(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnlLeftTop.DoDoIt

class function TkwAACContentsContainerFormPnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnlLeftTop';
end;//TkwAACContentsContainerFormPnlLeftTop.GetWordNameForRegister

function TkwAACContentsContainerFormPnlLeftTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnlLeftTop.GetResultTypeInfo

function TkwAACContentsContainerFormPnlLeftTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnlLeftTop.GetAllParamsCount

function TkwAACContentsContainerFormPnlLeftTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnlLeftTop.ParamsTypes

procedure TkwAACContentsContainerFormPnlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlLeftTop', aCtx);
end;//TkwAACContentsContainerFormPnlLeftTop.SetValuePrim

function TkwAACContentsContainerFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContentsContainerForm.pnLeft }
begin
 Result := aAACContentsContainerForm.pnLeft;
end;//TkwAACContentsContainerFormPnLeft.pnLeft

procedure TkwAACContentsContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeft(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnLeft.DoDoIt

class function TkwAACContentsContainerFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnLeft';
end;//TkwAACContentsContainerFormPnLeft.GetWordNameForRegister

function TkwAACContentsContainerFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnLeft.GetResultTypeInfo

function TkwAACContentsContainerFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnLeft.GetAllParamsCount

function TkwAACContentsContainerFormPnLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnLeft.ParamsTypes

procedure TkwAACContentsContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeft', aCtx);
end;//TkwAACContentsContainerFormPnLeft.SetValuePrim

function TkwAACContentsContainerFormScrLeft.scrLeft(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
 {* ���������� ����� ������� .TAACContentsContainerForm.scrLeft }
begin
 Result := aAACContentsContainerForm.scrLeft;
end;//TkwAACContentsContainerFormScrLeft.scrLeft

procedure TkwAACContentsContainerFormScrLeft.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(scrLeft(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormScrLeft.DoDoIt

class function TkwAACContentsContainerFormScrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.scrLeft';
end;//TkwAACContentsContainerFormScrLeft.GetWordNameForRegister

function TkwAACContentsContainerFormScrLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContentsContainerFormScrLeft.GetResultTypeInfo

function TkwAACContentsContainerFormScrLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormScrLeft.GetAllParamsCount

function TkwAACContentsContainerFormScrLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormScrLeft.ParamsTypes

procedure TkwAACContentsContainerFormScrLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� scrLeft', aCtx);
end;//TkwAACContentsContainerFormScrLeft.SetValuePrim

initialization
 Tkw_Form_AACContentsContainer.RegisterInEngine;
 {* ����������� Tkw_Form_AACContentsContainer }
 Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnBack }
 Tkw_AACContentsContainer_Control_pnBack_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnBack_Push }
 Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnRightEx }
 Tkw_AACContentsContainer_Control_pnRightEx_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnRightEx_Push }
 Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnRightForScroll }
 Tkw_AACContentsContainer_Control_pnRightForScroll_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnRightForScroll_Push }
 Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnRight }
 Tkw_AACContentsContainer_Control_pnRight_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnRight_Push }
 Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnlRightTop }
 Tkw_AACContentsContainer_Control_pnlRightTop_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnlRightTop_Push }
 Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_scrRight }
 Tkw_AACContentsContainer_Control_scrRight_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_scrRight_Push }
 Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnLeftEx }
 Tkw_AACContentsContainer_Control_pnLeftEx_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnLeftEx_Push }
 Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnLeftForScroll }
 Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnLeftForScroll_Push }
 Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnlLeftTop }
 Tkw_AACContentsContainer_Control_pnlLeftTop_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnlLeftTop_Push }
 Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnLeft }
 Tkw_AACContentsContainer_Control_pnLeft_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_pnLeft_Push }
 Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_scrLeft }
 Tkw_AACContentsContainer_Control_scrLeft_Push.RegisterInEngine;
 {* ����������� Tkw_AACContentsContainer_Control_scrLeft_Push }
 TkwAACContentsContainerFormPnBack.RegisterInEngine;
 {* ����������� AACContentsContainerForm_pnBack }
 TkwAACContentsContainerFormPnRightEx.RegisterInEngine;
 {* ����������� AACContentsContainerForm_pnRightEx }
 TkwAACContentsContainerFormPnRightForScroll.RegisterInEngine;
 {* ����������� AACContentsContainerForm_pnRightForScroll }
 TkwAACContentsContainerFormPnRight.RegisterInEngine;
 {* ����������� AACContentsContainerForm_pnRight }
 TkwAACContentsContainerFormPnlRightTop.RegisterInEngine;
 {* ����������� AACContentsContainerForm_pnlRightTop }
 TkwAACContentsContainerFormScrRight.RegisterInEngine;
 {* ����������� AACContentsContainerForm_scrRight }
 TkwAACContentsContainerFormPnLeftEx.RegisterInEngine;
 {* ����������� AACContentsContainerForm_pnLeftEx }
 TkwAACContentsContainerFormPnLeftForScroll.RegisterInEngine;
 {* ����������� AACContentsContainerForm_pnLeftForScroll }
 TkwAACContentsContainerFormPnlLeftTop.RegisterInEngine;
 {* ����������� AACContentsContainerForm_pnlLeftTop }
 TkwAACContentsContainerFormPnLeft.RegisterInEngine;
 {* ����������� AACContentsContainerForm_pnLeft }
 TkwAACContentsContainerFormScrLeft.RegisterInEngine;
 {* ����������� AACContentsContainerForm_scrLeft }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAACContentsContainerForm));
 {* ����������� ���� TAACContentsContainerForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtScrollBar));
 {* ����������� ���� TvtScrollBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
