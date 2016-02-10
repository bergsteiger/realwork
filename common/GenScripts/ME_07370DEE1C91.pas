unit AACContainerKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� AACContainer }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\AACContainerKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AACPrim_Module
 , vtPanel
 , nscSimpleEditorForDialogs
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtProportionalPanel
 , vtScrollBar
 , vtSizeablePanel
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_AACContainer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� AACContainer
----
*������ �������������*:
[code]
'aControl' �����::AACContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AACContainer

 Tkw_AACContainer_Control_pnWriteToUs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnWriteToUs
----
*������ �������������*:
[code]
�������::pnWriteToUs TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnWriteToUs

 Tkw_AACContainer_Control_pnWriteToUs_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnWriteToUs
----
*������ �������������*:
[code]
�������::pnWriteToUs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnWriteToUs_Push

 Tkw_AACContainer_Control_edWriteToUs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edWriteToUs
----
*������ �������������*:
[code]
�������::edWriteToUs TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_edWriteToUs

 Tkw_AACContainer_Control_edWriteToUs_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edWriteToUs
----
*������ �������������*:
[code]
�������::edWriteToUs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_edWriteToUs_Push

 Tkw_AACContainer_Control_pnSeeAlso = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnSeeAlso
----
*������ �������������*:
[code]
�������::pnSeeAlso TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnSeeAlso

 Tkw_AACContainer_Control_pnSeeAlso_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnSeeAlso
----
*������ �������������*:
[code]
�������::pnSeeAlso:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnSeeAlso_Push

 Tkw_AACContainer_Control_lblSeeAlso = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblSeeAlso
----
*������ �������������*:
[code]
�������::lblSeeAlso TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_lblSeeAlso

 Tkw_AACContainer_Control_lblSeeAlso_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lblSeeAlso
----
*������ �������������*:
[code]
�������::lblSeeAlso:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_lblSeeAlso_Push

 Tkw_AACContainer_Control_pnLinkToContent = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLinkToContent
----
*������ �������������*:
[code]
�������::pnLinkToContent TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnLinkToContent

 Tkw_AACContainer_Control_pnLinkToContent_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLinkToContent
----
*������ �������������*:
[code]
�������::pnLinkToContent:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLinkToContent_Push

 Tkw_AACContainer_Control_pbLinkToContent = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbLinkToContent
----
*������ �������������*:
[code]
�������::pbLinkToContent TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pbLinkToContent

 Tkw_AACContainer_Control_pbLinkToContent_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbLinkToContent
----
*������ �������������*:
[code]
�������::pbLinkToContent:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pbLinkToContent_Push

 Tkw_AACContainer_Control_pnBack = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnBack
----
*������ �������������*:
[code]
�������::pnBack TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnBack

 Tkw_AACContainer_Control_pnBack_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnBack
----
*������ �������������*:
[code]
�������::pnBack:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnBack_Push

 Tkw_AACContainer_Control_pnRightEx = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRightEx
----
*������ �������������*:
[code]
�������::pnRightEx TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnRightEx

 Tkw_AACContainer_Control_pnRightEx_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnRightEx
----
*������ �������������*:
[code]
�������::pnRightEx:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRightEx_Push

 Tkw_AACContainer_Control_pnRightForScroll = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRightForScroll
----
*������ �������������*:
[code]
�������::pnRightForScroll TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnRightForScroll

 Tkw_AACContainer_Control_pnRightForScroll_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnRightForScroll
----
*������ �������������*:
[code]
�������::pnRightForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRightForScroll_Push

 Tkw_AACContainer_Control_pnRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRight
----
*������ �������������*:
[code]
�������::pnRight TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnRight

 Tkw_AACContainer_Control_pnRight_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnRight
----
*������ �������������*:
[code]
�������::pnRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRight_Push

 Tkw_AACContainer_Control_pnlRightTop = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlRightTop
----
*������ �������������*:
[code]
�������::pnlRightTop TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnlRightTop

 Tkw_AACContainer_Control_pnlRightTop_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlRightTop
----
*������ �������������*:
[code]
�������::pnlRightTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnlRightTop_Push

 Tkw_AACContainer_Control_scrRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� scrRight
----
*������ �������������*:
[code]
�������::scrRight TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_scrRight

 Tkw_AACContainer_Control_scrRight_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� scrRight
----
*������ �������������*:
[code]
�������::scrRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_scrRight_Push

 Tkw_AACContainer_Control_pnLeftEx = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeftEx
----
*������ �������������*:
[code]
�������::pnLeftEx TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnLeftEx

 Tkw_AACContainer_Control_pnLeftEx_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeftEx
----
*������ �������������*:
[code]
�������::pnLeftEx:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeftEx_Push

 Tkw_AACContainer_Control_pnLeftForScroll = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeftForScroll
----
*������ �������������*:
[code]
�������::pnLeftForScroll TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnLeftForScroll

 Tkw_AACContainer_Control_pnLeftForScroll_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeftForScroll
----
*������ �������������*:
[code]
�������::pnLeftForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeftForScroll_Push

 Tkw_AACContainer_Control_pnlLeftTop = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlLeftTop
----
*������ �������������*:
[code]
�������::pnlLeftTop TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnlLeftTop

 Tkw_AACContainer_Control_pnlLeftTop_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlLeftTop
----
*������ �������������*:
[code]
�������::pnlLeftTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnlLeftTop_Push

 Tkw_AACContainer_Control_pnLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnLeft

 Tkw_AACContainer_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeft_Push

 Tkw_AACContainer_Control_scrLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� scrLeft
----
*������ �������������*:
[code]
�������::scrLeft TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_scrLeft

 Tkw_AACContainer_Control_scrLeft_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� scrLeft
----
*������ �������������*:
[code]
�������::scrLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_scrLeft_Push

 TkwAACContainerFormPnWriteToUs = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnWriteToUs
[panel]������� pnWriteToUs ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnWriteToUs >>> l_TvtPanel
[code]  }
  private
   function pnWriteToUs(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnWriteToUs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnWriteToUs

 TkwAACContainerFormEdWriteToUs = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.edWriteToUs
[panel]������� edWriteToUs ����� TAACContainerForm[panel]
*��� ����������:* TnscSimpleEditorForDialogs
*������:*
[code]
OBJECT VAR l_TnscSimpleEditorForDialogs
 aAACContainerForm .TAACContainerForm.edWriteToUs >>> l_TnscSimpleEditorForDialogs
[code]  }
  private
   function edWriteToUs(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TnscSimpleEditorForDialogs;
    {* ���������� ����� ������� .TAACContainerForm.edWriteToUs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormEdWriteToUs

 TkwAACContainerFormPnSeeAlso = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnSeeAlso
[panel]������� pnSeeAlso ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnSeeAlso >>> l_TvtPanel
[code]  }
  private
   function pnSeeAlso(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnSeeAlso }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnSeeAlso

 TkwAACContainerFormLblSeeAlso = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.lblSeeAlso
[panel]������� lblSeeAlso ����� TAACContainerForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aAACContainerForm .TAACContainerForm.lblSeeAlso >>> l_TvtLabel
[code]  }
  private
   function lblSeeAlso(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtLabel;
    {* ���������� ����� ������� .TAACContainerForm.lblSeeAlso }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormLblSeeAlso

 TkwAACContainerFormPnLinkToContent = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnLinkToContent
[panel]������� pnLinkToContent ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnLinkToContent >>> l_TvtPanel
[code]  }
  private
   function pnLinkToContent(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnLinkToContent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnLinkToContent

 TkwAACContainerFormPbLinkToContent = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pbLinkToContent
[panel]������� pbLinkToContent ����� TAACContainerForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aAACContainerForm .TAACContainerForm.pbLinkToContent >>> l_TPaintBox
[code]  }
  private
   function pbLinkToContent(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TPaintBox;
    {* ���������� ����� ������� .TAACContainerForm.pbLinkToContent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPbLinkToContent

 TkwAACContainerFormPnBack = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnBack
[panel]������� pnBack ����� TAACContainerForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aAACContainerForm .TAACContainerForm.pnBack >>> l_TvtProportionalPanel
[code]  }
  private
   function pnBack(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnBack }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnBack

 TkwAACContainerFormPnRightEx = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnRightEx
[panel]������� pnRightEx ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnRightEx >>> l_TvtPanel
[code]  }
  private
   function pnRightEx(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnRightEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnRightEx

 TkwAACContainerFormPnRightForScroll = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnRightForScroll
[panel]������� pnRightForScroll ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnRightForScroll >>> l_TvtPanel
[code]  }
  private
   function pnRightForScroll(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnRightForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnRightForScroll

 TkwAACContainerFormPnRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnRight
[panel]������� pnRight ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnRight >>> l_TvtPanel
[code]  }
  private
   function pnRight(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnRight

 TkwAACContainerFormPnlRightTop = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnlRightTop
[panel]������� pnlRightTop ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnlRightTop >>> l_TvtPanel
[code]  }
  private
   function pnlRightTop(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnlRightTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnlRightTop

 TkwAACContainerFormScrRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.scrRight
[panel]������� scrRight ����� TAACContainerForm[panel]
*��� ����������:* TvtScrollBar
*������:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContainerForm .TAACContainerForm.scrRight >>> l_TvtScrollBar
[code]  }
  private
   function scrRight(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtScrollBar;
    {* ���������� ����� ������� .TAACContainerForm.scrRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormScrRight

 TkwAACContainerFormPnLeftEx = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnLeftEx
[panel]������� pnLeftEx ����� TAACContainerForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aAACContainerForm .TAACContainerForm.pnLeftEx >>> l_TvtSizeablePanel
[code]  }
  private
   function pnLeftEx(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TAACContainerForm.pnLeftEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnLeftEx

 TkwAACContainerFormPnLeftForScroll = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnLeftForScroll
[panel]������� pnLeftForScroll ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnLeftForScroll >>> l_TvtPanel
[code]  }
  private
   function pnLeftForScroll(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnLeftForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnLeftForScroll

 TkwAACContainerFormPnlLeftTop = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnlLeftTop
[panel]������� pnlLeftTop ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnlLeftTop >>> l_TvtPanel
[code]  }
  private
   function pnlLeftTop(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnlLeftTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnlLeftTop

 TkwAACContainerFormPnLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.pnLeft
[panel]������� pnLeft ����� TAACContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnLeft >>> l_TvtPanel
[code]  }
  private
   function pnLeft(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* ���������� ����� ������� .TAACContainerForm.pnLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnLeft

 TkwAACContainerFormScrLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TAACContainerForm.scrLeft
[panel]������� scrLeft ����� TAACContainerForm[panel]
*��� ����������:* TvtScrollBar
*������:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContainerForm .TAACContainerForm.scrLeft >>> l_TvtScrollBar
[code]  }
  private
   function scrLeft(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtScrollBar;
    {* ���������� ����� ������� .TAACContainerForm.scrLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormScrLeft

class function Tkw_Form_AACContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::AACContainer';
end;//Tkw_Form_AACContainer.GetWordNameForRegister

function Tkw_Form_AACContainer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_947DCCB8ABFB_var*
//#UC END# *4DDFD2EA0116_947DCCB8ABFB_var*
begin
//#UC START# *4DDFD2EA0116_947DCCB8ABFB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_947DCCB8ABFB_impl*
end;//Tkw_Form_AACContainer.GetString

class function Tkw_AACContainer_Control_pnWriteToUs.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnWriteToUs';
end;//Tkw_AACContainer_Control_pnWriteToUs.GetWordNameForRegister

function Tkw_AACContainer_Control_pnWriteToUs.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_405F63B1E31E_var*
//#UC END# *4DDFD2EA0116_405F63B1E31E_var*
begin
//#UC START# *4DDFD2EA0116_405F63B1E31E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_405F63B1E31E_impl*
end;//Tkw_AACContainer_Control_pnWriteToUs.GetString

class procedure Tkw_AACContainer_Control_pnWriteToUs.RegisterInEngine;
//#UC START# *52A086150180_405F63B1E31E_var*
//#UC END# *52A086150180_405F63B1E31E_var*
begin
//#UC START# *52A086150180_405F63B1E31E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_405F63B1E31E_impl*
end;//Tkw_AACContainer_Control_pnWriteToUs.RegisterInEngine

procedure Tkw_AACContainer_Control_pnWriteToUs_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7DF0B8DF2DCD_var*
//#UC END# *4DAEEDE10285_7DF0B8DF2DCD_var*
begin
//#UC START# *4DAEEDE10285_7DF0B8DF2DCD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7DF0B8DF2DCD_impl*
end;//Tkw_AACContainer_Control_pnWriteToUs_Push.DoDoIt

class function Tkw_AACContainer_Control_pnWriteToUs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnWriteToUs:push';
end;//Tkw_AACContainer_Control_pnWriteToUs_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_edWriteToUs.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edWriteToUs';
end;//Tkw_AACContainer_Control_edWriteToUs.GetWordNameForRegister

function Tkw_AACContainer_Control_edWriteToUs.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3163555BBFEE_var*
//#UC END# *4DDFD2EA0116_3163555BBFEE_var*
begin
//#UC START# *4DDFD2EA0116_3163555BBFEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3163555BBFEE_impl*
end;//Tkw_AACContainer_Control_edWriteToUs.GetString

class procedure Tkw_AACContainer_Control_edWriteToUs.RegisterInEngine;
//#UC START# *52A086150180_3163555BBFEE_var*
//#UC END# *52A086150180_3163555BBFEE_var*
begin
//#UC START# *52A086150180_3163555BBFEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3163555BBFEE_impl*
end;//Tkw_AACContainer_Control_edWriteToUs.RegisterInEngine

procedure Tkw_AACContainer_Control_edWriteToUs_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_82C4B474D56A_var*
//#UC END# *4DAEEDE10285_82C4B474D56A_var*
begin
//#UC START# *4DAEEDE10285_82C4B474D56A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_82C4B474D56A_impl*
end;//Tkw_AACContainer_Control_edWriteToUs_Push.DoDoIt

class function Tkw_AACContainer_Control_edWriteToUs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edWriteToUs:push';
end;//Tkw_AACContainer_Control_edWriteToUs_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnSeeAlso.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnSeeAlso';
end;//Tkw_AACContainer_Control_pnSeeAlso.GetWordNameForRegister

function Tkw_AACContainer_Control_pnSeeAlso.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1EF6B88BF534_var*
//#UC END# *4DDFD2EA0116_1EF6B88BF534_var*
begin
//#UC START# *4DDFD2EA0116_1EF6B88BF534_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1EF6B88BF534_impl*
end;//Tkw_AACContainer_Control_pnSeeAlso.GetString

class procedure Tkw_AACContainer_Control_pnSeeAlso.RegisterInEngine;
//#UC START# *52A086150180_1EF6B88BF534_var*
//#UC END# *52A086150180_1EF6B88BF534_var*
begin
//#UC START# *52A086150180_1EF6B88BF534_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1EF6B88BF534_impl*
end;//Tkw_AACContainer_Control_pnSeeAlso.RegisterInEngine

procedure Tkw_AACContainer_Control_pnSeeAlso_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B2A2E7C87FEA_var*
//#UC END# *4DAEEDE10285_B2A2E7C87FEA_var*
begin
//#UC START# *4DAEEDE10285_B2A2E7C87FEA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B2A2E7C87FEA_impl*
end;//Tkw_AACContainer_Control_pnSeeAlso_Push.DoDoIt

class function Tkw_AACContainer_Control_pnSeeAlso_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnSeeAlso:push';
end;//Tkw_AACContainer_Control_pnSeeAlso_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_lblSeeAlso.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblSeeAlso';
end;//Tkw_AACContainer_Control_lblSeeAlso.GetWordNameForRegister

function Tkw_AACContainer_Control_lblSeeAlso.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1D0D7051C815_var*
//#UC END# *4DDFD2EA0116_1D0D7051C815_var*
begin
//#UC START# *4DDFD2EA0116_1D0D7051C815_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1D0D7051C815_impl*
end;//Tkw_AACContainer_Control_lblSeeAlso.GetString

class procedure Tkw_AACContainer_Control_lblSeeAlso.RegisterInEngine;
//#UC START# *52A086150180_1D0D7051C815_var*
//#UC END# *52A086150180_1D0D7051C815_var*
begin
//#UC START# *52A086150180_1D0D7051C815_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1D0D7051C815_impl*
end;//Tkw_AACContainer_Control_lblSeeAlso.RegisterInEngine

procedure Tkw_AACContainer_Control_lblSeeAlso_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D9DE29A03D19_var*
//#UC END# *4DAEEDE10285_D9DE29A03D19_var*
begin
//#UC START# *4DAEEDE10285_D9DE29A03D19_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D9DE29A03D19_impl*
end;//Tkw_AACContainer_Control_lblSeeAlso_Push.DoDoIt

class function Tkw_AACContainer_Control_lblSeeAlso_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblSeeAlso:push';
end;//Tkw_AACContainer_Control_lblSeeAlso_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnLinkToContent.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLinkToContent';
end;//Tkw_AACContainer_Control_pnLinkToContent.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLinkToContent.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_70C8F7379227_var*
//#UC END# *4DDFD2EA0116_70C8F7379227_var*
begin
//#UC START# *4DDFD2EA0116_70C8F7379227_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_70C8F7379227_impl*
end;//Tkw_AACContainer_Control_pnLinkToContent.GetString

class procedure Tkw_AACContainer_Control_pnLinkToContent.RegisterInEngine;
//#UC START# *52A086150180_70C8F7379227_var*
//#UC END# *52A086150180_70C8F7379227_var*
begin
//#UC START# *52A086150180_70C8F7379227_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_70C8F7379227_impl*
end;//Tkw_AACContainer_Control_pnLinkToContent.RegisterInEngine

procedure Tkw_AACContainer_Control_pnLinkToContent_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_35DA3F1ADE99_var*
//#UC END# *4DAEEDE10285_35DA3F1ADE99_var*
begin
//#UC START# *4DAEEDE10285_35DA3F1ADE99_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_35DA3F1ADE99_impl*
end;//Tkw_AACContainer_Control_pnLinkToContent_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLinkToContent_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLinkToContent:push';
end;//Tkw_AACContainer_Control_pnLinkToContent_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pbLinkToContent.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbLinkToContent';
end;//Tkw_AACContainer_Control_pbLinkToContent.GetWordNameForRegister

function Tkw_AACContainer_Control_pbLinkToContent.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_61F97501A6B6_var*
//#UC END# *4DDFD2EA0116_61F97501A6B6_var*
begin
//#UC START# *4DDFD2EA0116_61F97501A6B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_61F97501A6B6_impl*
end;//Tkw_AACContainer_Control_pbLinkToContent.GetString

class procedure Tkw_AACContainer_Control_pbLinkToContent.RegisterInEngine;
//#UC START# *52A086150180_61F97501A6B6_var*
//#UC END# *52A086150180_61F97501A6B6_var*
begin
//#UC START# *52A086150180_61F97501A6B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_61F97501A6B6_impl*
end;//Tkw_AACContainer_Control_pbLinkToContent.RegisterInEngine

procedure Tkw_AACContainer_Control_pbLinkToContent_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_25ABF4C25D63_var*
//#UC END# *4DAEEDE10285_25ABF4C25D63_var*
begin
//#UC START# *4DAEEDE10285_25ABF4C25D63_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_25ABF4C25D63_impl*
end;//Tkw_AACContainer_Control_pbLinkToContent_Push.DoDoIt

class function Tkw_AACContainer_Control_pbLinkToContent_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbLinkToContent:push';
end;//Tkw_AACContainer_Control_pbLinkToContent_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnBack.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBack';
end;//Tkw_AACContainer_Control_pnBack.GetWordNameForRegister

function Tkw_AACContainer_Control_pnBack.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C0B7E263260B_var*
//#UC END# *4DDFD2EA0116_C0B7E263260B_var*
begin
//#UC START# *4DDFD2EA0116_C0B7E263260B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C0B7E263260B_impl*
end;//Tkw_AACContainer_Control_pnBack.GetString

class procedure Tkw_AACContainer_Control_pnBack.RegisterInEngine;
//#UC START# *52A086150180_C0B7E263260B_var*
//#UC END# *52A086150180_C0B7E263260B_var*
begin
//#UC START# *52A086150180_C0B7E263260B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C0B7E263260B_impl*
end;//Tkw_AACContainer_Control_pnBack.RegisterInEngine

procedure Tkw_AACContainer_Control_pnBack_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CC5D0A7DCE27_var*
//#UC END# *4DAEEDE10285_CC5D0A7DCE27_var*
begin
//#UC START# *4DAEEDE10285_CC5D0A7DCE27_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CC5D0A7DCE27_impl*
end;//Tkw_AACContainer_Control_pnBack_Push.DoDoIt

class function Tkw_AACContainer_Control_pnBack_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBack:push';
end;//Tkw_AACContainer_Control_pnBack_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightEx';
end;//Tkw_AACContainer_Control_pnRightEx.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRightEx.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1A0ED789E2EC_var*
//#UC END# *4DDFD2EA0116_1A0ED789E2EC_var*
begin
//#UC START# *4DDFD2EA0116_1A0ED789E2EC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1A0ED789E2EC_impl*
end;//Tkw_AACContainer_Control_pnRightEx.GetString

class procedure Tkw_AACContainer_Control_pnRightEx.RegisterInEngine;
//#UC START# *52A086150180_1A0ED789E2EC_var*
//#UC END# *52A086150180_1A0ED789E2EC_var*
begin
//#UC START# *52A086150180_1A0ED789E2EC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1A0ED789E2EC_impl*
end;//Tkw_AACContainer_Control_pnRightEx.RegisterInEngine

procedure Tkw_AACContainer_Control_pnRightEx_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5F995839F215_var*
//#UC END# *4DAEEDE10285_5F995839F215_var*
begin
//#UC START# *4DAEEDE10285_5F995839F215_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5F995839F215_impl*
end;//Tkw_AACContainer_Control_pnRightEx_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRightEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightEx:push';
end;//Tkw_AACContainer_Control_pnRightEx_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightForScroll';
end;//Tkw_AACContainer_Control_pnRightForScroll.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRightForScroll.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_05542A007C54_var*
//#UC END# *4DDFD2EA0116_05542A007C54_var*
begin
//#UC START# *4DDFD2EA0116_05542A007C54_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_05542A007C54_impl*
end;//Tkw_AACContainer_Control_pnRightForScroll.GetString

class procedure Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine;
//#UC START# *52A086150180_05542A007C54_var*
//#UC END# *52A086150180_05542A007C54_var*
begin
//#UC START# *52A086150180_05542A007C54_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_05542A007C54_impl*
end;//Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine

procedure Tkw_AACContainer_Control_pnRightForScroll_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5CAD71F4D219_var*
//#UC END# *4DAEEDE10285_5CAD71F4D219_var*
begin
//#UC START# *4DAEEDE10285_5CAD71F4D219_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5CAD71F4D219_impl*
end;//Tkw_AACContainer_Control_pnRightForScroll_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRightForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRightForScroll:push';
end;//Tkw_AACContainer_Control_pnRightForScroll_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight';
end;//Tkw_AACContainer_Control_pnRight.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRight.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DAA1424EF8E4_var*
//#UC END# *4DDFD2EA0116_DAA1424EF8E4_var*
begin
//#UC START# *4DDFD2EA0116_DAA1424EF8E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DAA1424EF8E4_impl*
end;//Tkw_AACContainer_Control_pnRight.GetString

class procedure Tkw_AACContainer_Control_pnRight.RegisterInEngine;
//#UC START# *52A086150180_DAA1424EF8E4_var*
//#UC END# *52A086150180_DAA1424EF8E4_var*
begin
//#UC START# *52A086150180_DAA1424EF8E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DAA1424EF8E4_impl*
end;//Tkw_AACContainer_Control_pnRight.RegisterInEngine

procedure Tkw_AACContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ACB773C873FF_var*
//#UC END# *4DAEEDE10285_ACB773C873FF_var*
begin
//#UC START# *4DAEEDE10285_ACB773C873FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ACB773C873FF_impl*
end;//Tkw_AACContainer_Control_pnRight_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight:push';
end;//Tkw_AACContainer_Control_pnRight_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRightTop';
end;//Tkw_AACContainer_Control_pnlRightTop.GetWordNameForRegister

function Tkw_AACContainer_Control_pnlRightTop.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AFD20A5C9FDF_var*
//#UC END# *4DDFD2EA0116_AFD20A5C9FDF_var*
begin
//#UC START# *4DDFD2EA0116_AFD20A5C9FDF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AFD20A5C9FDF_impl*
end;//Tkw_AACContainer_Control_pnlRightTop.GetString

class procedure Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine;
//#UC START# *52A086150180_AFD20A5C9FDF_var*
//#UC END# *52A086150180_AFD20A5C9FDF_var*
begin
//#UC START# *52A086150180_AFD20A5C9FDF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AFD20A5C9FDF_impl*
end;//Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine

procedure Tkw_AACContainer_Control_pnlRightTop_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_019AD248DA5D_var*
//#UC END# *4DAEEDE10285_019AD248DA5D_var*
begin
//#UC START# *4DAEEDE10285_019AD248DA5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_019AD248DA5D_impl*
end;//Tkw_AACContainer_Control_pnlRightTop_Push.DoDoIt

class function Tkw_AACContainer_Control_pnlRightTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlRightTop:push';
end;//Tkw_AACContainer_Control_pnlRightTop_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_scrRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrRight';
end;//Tkw_AACContainer_Control_scrRight.GetWordNameForRegister

function Tkw_AACContainer_Control_scrRight.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E3F59C401104_var*
//#UC END# *4DDFD2EA0116_E3F59C401104_var*
begin
//#UC START# *4DDFD2EA0116_E3F59C401104_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E3F59C401104_impl*
end;//Tkw_AACContainer_Control_scrRight.GetString

class procedure Tkw_AACContainer_Control_scrRight.RegisterInEngine;
//#UC START# *52A086150180_E3F59C401104_var*
//#UC END# *52A086150180_E3F59C401104_var*
begin
//#UC START# *52A086150180_E3F59C401104_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E3F59C401104_impl*
end;//Tkw_AACContainer_Control_scrRight.RegisterInEngine

procedure Tkw_AACContainer_Control_scrRight_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_239FD95C6900_var*
//#UC END# *4DAEEDE10285_239FD95C6900_var*
begin
//#UC START# *4DAEEDE10285_239FD95C6900_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_239FD95C6900_impl*
end;//Tkw_AACContainer_Control_scrRight_Push.DoDoIt

class function Tkw_AACContainer_Control_scrRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrRight:push';
end;//Tkw_AACContainer_Control_scrRight_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftEx';
end;//Tkw_AACContainer_Control_pnLeftEx.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeftEx.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0691ABC42DBE_var*
//#UC END# *4DDFD2EA0116_0691ABC42DBE_var*
begin
//#UC START# *4DDFD2EA0116_0691ABC42DBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0691ABC42DBE_impl*
end;//Tkw_AACContainer_Control_pnLeftEx.GetString

class procedure Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine;
//#UC START# *52A086150180_0691ABC42DBE_var*
//#UC END# *52A086150180_0691ABC42DBE_var*
begin
//#UC START# *52A086150180_0691ABC42DBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0691ABC42DBE_impl*
end;//Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine

procedure Tkw_AACContainer_Control_pnLeftEx_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_44D52AF8A329_var*
//#UC END# *4DAEEDE10285_44D52AF8A329_var*
begin
//#UC START# *4DAEEDE10285_44D52AF8A329_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_44D52AF8A329_impl*
end;//Tkw_AACContainer_Control_pnLeftEx_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeftEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftEx:push';
end;//Tkw_AACContainer_Control_pnLeftEx_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftForScroll';
end;//Tkw_AACContainer_Control_pnLeftForScroll.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeftForScroll.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9768FF4F2318_var*
//#UC END# *4DDFD2EA0116_9768FF4F2318_var*
begin
//#UC START# *4DDFD2EA0116_9768FF4F2318_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9768FF4F2318_impl*
end;//Tkw_AACContainer_Control_pnLeftForScroll.GetString

class procedure Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine;
//#UC START# *52A086150180_9768FF4F2318_var*
//#UC END# *52A086150180_9768FF4F2318_var*
begin
//#UC START# *52A086150180_9768FF4F2318_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9768FF4F2318_impl*
end;//Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine

procedure Tkw_AACContainer_Control_pnLeftForScroll_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_856ED6BCBBB5_var*
//#UC END# *4DAEEDE10285_856ED6BCBBB5_var*
begin
//#UC START# *4DAEEDE10285_856ED6BCBBB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_856ED6BCBBB5_impl*
end;//Tkw_AACContainer_Control_pnLeftForScroll_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeftForScroll:push';
end;//Tkw_AACContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeftTop';
end;//Tkw_AACContainer_Control_pnlLeftTop.GetWordNameForRegister

function Tkw_AACContainer_Control_pnlLeftTop.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_52D52DB721BA_var*
//#UC END# *4DDFD2EA0116_52D52DB721BA_var*
begin
//#UC START# *4DDFD2EA0116_52D52DB721BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_52D52DB721BA_impl*
end;//Tkw_AACContainer_Control_pnlLeftTop.GetString

class procedure Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine;
//#UC START# *52A086150180_52D52DB721BA_var*
//#UC END# *52A086150180_52D52DB721BA_var*
begin
//#UC START# *52A086150180_52D52DB721BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_52D52DB721BA_impl*
end;//Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine

procedure Tkw_AACContainer_Control_pnlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_00C66E0AF854_var*
//#UC END# *4DAEEDE10285_00C66E0AF854_var*
begin
//#UC START# *4DAEEDE10285_00C66E0AF854_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_00C66E0AF854_impl*
end;//Tkw_AACContainer_Control_pnlLeftTop_Push.DoDoIt

class function Tkw_AACContainer_Control_pnlLeftTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeftTop:push';
end;//Tkw_AACContainer_Control_pnlLeftTop_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft';
end;//Tkw_AACContainer_Control_pnLeft.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeft.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3CF356980581_var*
//#UC END# *4DDFD2EA0116_3CF356980581_var*
begin
//#UC START# *4DDFD2EA0116_3CF356980581_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3CF356980581_impl*
end;//Tkw_AACContainer_Control_pnLeft.GetString

class procedure Tkw_AACContainer_Control_pnLeft.RegisterInEngine;
//#UC START# *52A086150180_3CF356980581_var*
//#UC END# *52A086150180_3CF356980581_var*
begin
//#UC START# *52A086150180_3CF356980581_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3CF356980581_impl*
end;//Tkw_AACContainer_Control_pnLeft.RegisterInEngine

procedure Tkw_AACContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B1743336CB93_var*
//#UC END# *4DAEEDE10285_B1743336CB93_var*
begin
//#UC START# *4DAEEDE10285_B1743336CB93_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B1743336CB93_impl*
end;//Tkw_AACContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft:push';
end;//Tkw_AACContainer_Control_pnLeft_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_scrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrLeft';
end;//Tkw_AACContainer_Control_scrLeft.GetWordNameForRegister

function Tkw_AACContainer_Control_scrLeft.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E58BF0889DF7_var*
//#UC END# *4DDFD2EA0116_E58BF0889DF7_var*
begin
//#UC START# *4DDFD2EA0116_E58BF0889DF7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E58BF0889DF7_impl*
end;//Tkw_AACContainer_Control_scrLeft.GetString

class procedure Tkw_AACContainer_Control_scrLeft.RegisterInEngine;
//#UC START# *52A086150180_E58BF0889DF7_var*
//#UC END# *52A086150180_E58BF0889DF7_var*
begin
//#UC START# *52A086150180_E58BF0889DF7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E58BF0889DF7_impl*
end;//Tkw_AACContainer_Control_scrLeft.RegisterInEngine

procedure Tkw_AACContainer_Control_scrLeft_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_679A43F7D2DD_var*
//#UC END# *4DAEEDE10285_679A43F7D2DD_var*
begin
//#UC START# *4DAEEDE10285_679A43F7D2DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_679A43F7D2DD_impl*
end;//Tkw_AACContainer_Control_scrLeft_Push.DoDoIt

class function Tkw_AACContainer_Control_scrLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::scrLeft:push';
end;//Tkw_AACContainer_Control_scrLeft_Push.GetWordNameForRegister

function TkwAACContainerFormPnWriteToUs.pnWriteToUs(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnWriteToUs }
//#UC START# *5CDD1FE753BD_DB74F48A3152_var*
//#UC END# *5CDD1FE753BD_DB74F48A3152_var*
begin
//#UC START# *5CDD1FE753BD_DB74F48A3152_impl*
 !!! Needs to be implemented !!!
//#UC END# *5CDD1FE753BD_DB74F48A3152_impl*
end;//TkwAACContainerFormPnWriteToUs.pnWriteToUs

procedure TkwAACContainerFormPnWriteToUs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DB74F48A3152_var*
//#UC END# *4DAEEDE10285_DB74F48A3152_var*
begin
//#UC START# *4DAEEDE10285_DB74F48A3152_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DB74F48A3152_impl*
end;//TkwAACContainerFormPnWriteToUs.DoDoIt

class function TkwAACContainerFormPnWriteToUs.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnWriteToUs';
end;//TkwAACContainerFormPnWriteToUs.GetWordNameForRegister

procedure TkwAACContainerFormPnWriteToUs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnWriteToUs.SetValuePrim

function TkwAACContainerFormPnWriteToUs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnWriteToUs.GetResultTypeInfo

function TkwAACContainerFormPnWriteToUs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnWriteToUs.GetAllParamsCount

function TkwAACContainerFormPnWriteToUs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnWriteToUs.ParamsTypes

function TkwAACContainerFormEdWriteToUs.edWriteToUs(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TnscSimpleEditorForDialogs;
 {* ���������� ����� ������� .TAACContainerForm.edWriteToUs }
//#UC START# *8C902DD10FEF_F0722FB3B994_var*
//#UC END# *8C902DD10FEF_F0722FB3B994_var*
begin
//#UC START# *8C902DD10FEF_F0722FB3B994_impl*
 !!! Needs to be implemented !!!
//#UC END# *8C902DD10FEF_F0722FB3B994_impl*
end;//TkwAACContainerFormEdWriteToUs.edWriteToUs

procedure TkwAACContainerFormEdWriteToUs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F0722FB3B994_var*
//#UC END# *4DAEEDE10285_F0722FB3B994_var*
begin
//#UC START# *4DAEEDE10285_F0722FB3B994_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F0722FB3B994_impl*
end;//TkwAACContainerFormEdWriteToUs.DoDoIt

class function TkwAACContainerFormEdWriteToUs.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.edWriteToUs';
end;//TkwAACContainerFormEdWriteToUs.GetWordNameForRegister

procedure TkwAACContainerFormEdWriteToUs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormEdWriteToUs.SetValuePrim

function TkwAACContainerFormEdWriteToUs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscSimpleEditorForDialogs);
end;//TkwAACContainerFormEdWriteToUs.GetResultTypeInfo

function TkwAACContainerFormEdWriteToUs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormEdWriteToUs.GetAllParamsCount

function TkwAACContainerFormEdWriteToUs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormEdWriteToUs.ParamsTypes

function TkwAACContainerFormPnSeeAlso.pnSeeAlso(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnSeeAlso }
//#UC START# *AE5EE150D609_4B97B95F9F98_var*
//#UC END# *AE5EE150D609_4B97B95F9F98_var*
begin
//#UC START# *AE5EE150D609_4B97B95F9F98_impl*
 !!! Needs to be implemented !!!
//#UC END# *AE5EE150D609_4B97B95F9F98_impl*
end;//TkwAACContainerFormPnSeeAlso.pnSeeAlso

procedure TkwAACContainerFormPnSeeAlso.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4B97B95F9F98_var*
//#UC END# *4DAEEDE10285_4B97B95F9F98_var*
begin
//#UC START# *4DAEEDE10285_4B97B95F9F98_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4B97B95F9F98_impl*
end;//TkwAACContainerFormPnSeeAlso.DoDoIt

class function TkwAACContainerFormPnSeeAlso.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnSeeAlso';
end;//TkwAACContainerFormPnSeeAlso.GetWordNameForRegister

procedure TkwAACContainerFormPnSeeAlso.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnSeeAlso.SetValuePrim

function TkwAACContainerFormPnSeeAlso.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnSeeAlso.GetResultTypeInfo

function TkwAACContainerFormPnSeeAlso.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnSeeAlso.GetAllParamsCount

function TkwAACContainerFormPnSeeAlso.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnSeeAlso.ParamsTypes

function TkwAACContainerFormLblSeeAlso.lblSeeAlso(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtLabel;
 {* ���������� ����� ������� .TAACContainerForm.lblSeeAlso }
//#UC START# *9D489E198F1A_99301B7A79BD_var*
//#UC END# *9D489E198F1A_99301B7A79BD_var*
begin
//#UC START# *9D489E198F1A_99301B7A79BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *9D489E198F1A_99301B7A79BD_impl*
end;//TkwAACContainerFormLblSeeAlso.lblSeeAlso

procedure TkwAACContainerFormLblSeeAlso.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_99301B7A79BD_var*
//#UC END# *4DAEEDE10285_99301B7A79BD_var*
begin
//#UC START# *4DAEEDE10285_99301B7A79BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_99301B7A79BD_impl*
end;//TkwAACContainerFormLblSeeAlso.DoDoIt

class function TkwAACContainerFormLblSeeAlso.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.lblSeeAlso';
end;//TkwAACContainerFormLblSeeAlso.GetWordNameForRegister

procedure TkwAACContainerFormLblSeeAlso.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormLblSeeAlso.SetValuePrim

function TkwAACContainerFormLblSeeAlso.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwAACContainerFormLblSeeAlso.GetResultTypeInfo

function TkwAACContainerFormLblSeeAlso.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormLblSeeAlso.GetAllParamsCount

function TkwAACContainerFormLblSeeAlso.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormLblSeeAlso.ParamsTypes

function TkwAACContainerFormPnLinkToContent.pnLinkToContent(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnLinkToContent }
//#UC START# *251580B303FC_047B2134DDD7_var*
//#UC END# *251580B303FC_047B2134DDD7_var*
begin
//#UC START# *251580B303FC_047B2134DDD7_impl*
 !!! Needs to be implemented !!!
//#UC END# *251580B303FC_047B2134DDD7_impl*
end;//TkwAACContainerFormPnLinkToContent.pnLinkToContent

procedure TkwAACContainerFormPnLinkToContent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_047B2134DDD7_var*
//#UC END# *4DAEEDE10285_047B2134DDD7_var*
begin
//#UC START# *4DAEEDE10285_047B2134DDD7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_047B2134DDD7_impl*
end;//TkwAACContainerFormPnLinkToContent.DoDoIt

class function TkwAACContainerFormPnLinkToContent.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLinkToContent';
end;//TkwAACContainerFormPnLinkToContent.GetWordNameForRegister

procedure TkwAACContainerFormPnLinkToContent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnLinkToContent.SetValuePrim

function TkwAACContainerFormPnLinkToContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnLinkToContent.GetResultTypeInfo

function TkwAACContainerFormPnLinkToContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnLinkToContent.GetAllParamsCount

function TkwAACContainerFormPnLinkToContent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnLinkToContent.ParamsTypes

function TkwAACContainerFormPbLinkToContent.pbLinkToContent(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TPaintBox;
 {* ���������� ����� ������� .TAACContainerForm.pbLinkToContent }
//#UC START# *2A27319A6283_CF9DA2256E85_var*
//#UC END# *2A27319A6283_CF9DA2256E85_var*
begin
//#UC START# *2A27319A6283_CF9DA2256E85_impl*
 !!! Needs to be implemented !!!
//#UC END# *2A27319A6283_CF9DA2256E85_impl*
end;//TkwAACContainerFormPbLinkToContent.pbLinkToContent

procedure TkwAACContainerFormPbLinkToContent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CF9DA2256E85_var*
//#UC END# *4DAEEDE10285_CF9DA2256E85_var*
begin
//#UC START# *4DAEEDE10285_CF9DA2256E85_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CF9DA2256E85_impl*
end;//TkwAACContainerFormPbLinkToContent.DoDoIt

class function TkwAACContainerFormPbLinkToContent.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pbLinkToContent';
end;//TkwAACContainerFormPbLinkToContent.GetWordNameForRegister

procedure TkwAACContainerFormPbLinkToContent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPbLinkToContent.SetValuePrim

function TkwAACContainerFormPbLinkToContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwAACContainerFormPbLinkToContent.GetResultTypeInfo

function TkwAACContainerFormPbLinkToContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPbLinkToContent.GetAllParamsCount

function TkwAACContainerFormPbLinkToContent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPbLinkToContent.ParamsTypes

function TkwAACContainerFormPnBack.pnBack(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnBack }
//#UC START# *63BD4ABC2DF9_4F5A8396037A_var*
//#UC END# *63BD4ABC2DF9_4F5A8396037A_var*
begin
//#UC START# *63BD4ABC2DF9_4F5A8396037A_impl*
 !!! Needs to be implemented !!!
//#UC END# *63BD4ABC2DF9_4F5A8396037A_impl*
end;//TkwAACContainerFormPnBack.pnBack

procedure TkwAACContainerFormPnBack.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F5A8396037A_var*
//#UC END# *4DAEEDE10285_4F5A8396037A_var*
begin
//#UC START# *4DAEEDE10285_4F5A8396037A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4F5A8396037A_impl*
end;//TkwAACContainerFormPnBack.DoDoIt

class function TkwAACContainerFormPnBack.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnBack';
end;//TkwAACContainerFormPnBack.GetWordNameForRegister

procedure TkwAACContainerFormPnBack.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnBack.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnBack.ParamsTypes

function TkwAACContainerFormPnRightEx.pnRightEx(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnRightEx }
//#UC START# *FF3E25835A4D_95C62C6D9E8D_var*
//#UC END# *FF3E25835A4D_95C62C6D9E8D_var*
begin
//#UC START# *FF3E25835A4D_95C62C6D9E8D_impl*
 !!! Needs to be implemented !!!
//#UC END# *FF3E25835A4D_95C62C6D9E8D_impl*
end;//TkwAACContainerFormPnRightEx.pnRightEx

procedure TkwAACContainerFormPnRightEx.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_95C62C6D9E8D_var*
//#UC END# *4DAEEDE10285_95C62C6D9E8D_var*
begin
//#UC START# *4DAEEDE10285_95C62C6D9E8D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_95C62C6D9E8D_impl*
end;//TkwAACContainerFormPnRightEx.DoDoIt

class function TkwAACContainerFormPnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnRightEx';
end;//TkwAACContainerFormPnRightEx.GetWordNameForRegister

procedure TkwAACContainerFormPnRightEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnRightEx.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnRightEx.ParamsTypes

function TkwAACContainerFormPnRightForScroll.pnRightForScroll(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnRightForScroll }
//#UC START# *6E1FFE88A5FF_C01E0F7DF977_var*
//#UC END# *6E1FFE88A5FF_C01E0F7DF977_var*
begin
//#UC START# *6E1FFE88A5FF_C01E0F7DF977_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E1FFE88A5FF_C01E0F7DF977_impl*
end;//TkwAACContainerFormPnRightForScroll.pnRightForScroll

procedure TkwAACContainerFormPnRightForScroll.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C01E0F7DF977_var*
//#UC END# *4DAEEDE10285_C01E0F7DF977_var*
begin
//#UC START# *4DAEEDE10285_C01E0F7DF977_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C01E0F7DF977_impl*
end;//TkwAACContainerFormPnRightForScroll.DoDoIt

class function TkwAACContainerFormPnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnRightForScroll';
end;//TkwAACContainerFormPnRightForScroll.GetWordNameForRegister

procedure TkwAACContainerFormPnRightForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnRightForScroll.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnRightForScroll.ParamsTypes

function TkwAACContainerFormPnRight.pnRight(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnRight }
//#UC START# *A21D6B0F0809_2EE253364AD2_var*
//#UC END# *A21D6B0F0809_2EE253364AD2_var*
begin
//#UC START# *A21D6B0F0809_2EE253364AD2_impl*
 !!! Needs to be implemented !!!
//#UC END# *A21D6B0F0809_2EE253364AD2_impl*
end;//TkwAACContainerFormPnRight.pnRight

procedure TkwAACContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2EE253364AD2_var*
//#UC END# *4DAEEDE10285_2EE253364AD2_var*
begin
//#UC START# *4DAEEDE10285_2EE253364AD2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2EE253364AD2_impl*
end;//TkwAACContainerFormPnRight.DoDoIt

class function TkwAACContainerFormPnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnRight';
end;//TkwAACContainerFormPnRight.GetWordNameForRegister

procedure TkwAACContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnRight.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnRight.ParamsTypes

function TkwAACContainerFormPnlRightTop.pnlRightTop(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnlRightTop }
//#UC START# *6C05FC7C2D7B_52FA9127B0FE_var*
//#UC END# *6C05FC7C2D7B_52FA9127B0FE_var*
begin
//#UC START# *6C05FC7C2D7B_52FA9127B0FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *6C05FC7C2D7B_52FA9127B0FE_impl*
end;//TkwAACContainerFormPnlRightTop.pnlRightTop

procedure TkwAACContainerFormPnlRightTop.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52FA9127B0FE_var*
//#UC END# *4DAEEDE10285_52FA9127B0FE_var*
begin
//#UC START# *4DAEEDE10285_52FA9127B0FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_52FA9127B0FE_impl*
end;//TkwAACContainerFormPnlRightTop.DoDoIt

class function TkwAACContainerFormPnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnlRightTop';
end;//TkwAACContainerFormPnlRightTop.GetWordNameForRegister

procedure TkwAACContainerFormPnlRightTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnlRightTop.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnlRightTop.ParamsTypes

function TkwAACContainerFormScrRight.scrRight(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtScrollBar;
 {* ���������� ����� ������� .TAACContainerForm.scrRight }
//#UC START# *285CCFE170AF_B887772971CE_var*
//#UC END# *285CCFE170AF_B887772971CE_var*
begin
//#UC START# *285CCFE170AF_B887772971CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *285CCFE170AF_B887772971CE_impl*
end;//TkwAACContainerFormScrRight.scrRight

procedure TkwAACContainerFormScrRight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B887772971CE_var*
//#UC END# *4DAEEDE10285_B887772971CE_var*
begin
//#UC START# *4DAEEDE10285_B887772971CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B887772971CE_impl*
end;//TkwAACContainerFormScrRight.DoDoIt

class function TkwAACContainerFormScrRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.scrRight';
end;//TkwAACContainerFormScrRight.GetWordNameForRegister

procedure TkwAACContainerFormScrRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormScrRight.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormScrRight.ParamsTypes

function TkwAACContainerFormPnLeftEx.pnLeftEx(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TAACContainerForm.pnLeftEx }
//#UC START# *6BCD0A3A4378_2AD248E95944_var*
//#UC END# *6BCD0A3A4378_2AD248E95944_var*
begin
//#UC START# *6BCD0A3A4378_2AD248E95944_impl*
 !!! Needs to be implemented !!!
//#UC END# *6BCD0A3A4378_2AD248E95944_impl*
end;//TkwAACContainerFormPnLeftEx.pnLeftEx

procedure TkwAACContainerFormPnLeftEx.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2AD248E95944_var*
//#UC END# *4DAEEDE10285_2AD248E95944_var*
begin
//#UC START# *4DAEEDE10285_2AD248E95944_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2AD248E95944_impl*
end;//TkwAACContainerFormPnLeftEx.DoDoIt

class function TkwAACContainerFormPnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLeftEx';
end;//TkwAACContainerFormPnLeftEx.GetWordNameForRegister

procedure TkwAACContainerFormPnLeftEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnLeftEx.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnLeftEx.ParamsTypes

function TkwAACContainerFormPnLeftForScroll.pnLeftForScroll(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnLeftForScroll }
//#UC START# *51968CFF662D_283EE6228809_var*
//#UC END# *51968CFF662D_283EE6228809_var*
begin
//#UC START# *51968CFF662D_283EE6228809_impl*
 !!! Needs to be implemented !!!
//#UC END# *51968CFF662D_283EE6228809_impl*
end;//TkwAACContainerFormPnLeftForScroll.pnLeftForScroll

procedure TkwAACContainerFormPnLeftForScroll.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_283EE6228809_var*
//#UC END# *4DAEEDE10285_283EE6228809_var*
begin
//#UC START# *4DAEEDE10285_283EE6228809_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_283EE6228809_impl*
end;//TkwAACContainerFormPnLeftForScroll.DoDoIt

class function TkwAACContainerFormPnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLeftForScroll';
end;//TkwAACContainerFormPnLeftForScroll.GetWordNameForRegister

procedure TkwAACContainerFormPnLeftForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnLeftForScroll.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnLeftForScroll.ParamsTypes

function TkwAACContainerFormPnlLeftTop.pnlLeftTop(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnlLeftTop }
//#UC START# *36F72E7C74DD_EB5CC7AC0775_var*
//#UC END# *36F72E7C74DD_EB5CC7AC0775_var*
begin
//#UC START# *36F72E7C74DD_EB5CC7AC0775_impl*
 !!! Needs to be implemented !!!
//#UC END# *36F72E7C74DD_EB5CC7AC0775_impl*
end;//TkwAACContainerFormPnlLeftTop.pnlLeftTop

procedure TkwAACContainerFormPnlLeftTop.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EB5CC7AC0775_var*
//#UC END# *4DAEEDE10285_EB5CC7AC0775_var*
begin
//#UC START# *4DAEEDE10285_EB5CC7AC0775_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EB5CC7AC0775_impl*
end;//TkwAACContainerFormPnlLeftTop.DoDoIt

class function TkwAACContainerFormPnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnlLeftTop';
end;//TkwAACContainerFormPnlLeftTop.GetWordNameForRegister

procedure TkwAACContainerFormPnlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnlLeftTop.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnlLeftTop.ParamsTypes

function TkwAACContainerFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* ���������� ����� ������� .TAACContainerForm.pnLeft }
//#UC START# *1AF88C801F5F_8E65E900818E_var*
//#UC END# *1AF88C801F5F_8E65E900818E_var*
begin
//#UC START# *1AF88C801F5F_8E65E900818E_impl*
 !!! Needs to be implemented !!!
//#UC END# *1AF88C801F5F_8E65E900818E_impl*
end;//TkwAACContainerFormPnLeft.pnLeft

procedure TkwAACContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8E65E900818E_var*
//#UC END# *4DAEEDE10285_8E65E900818E_var*
begin
//#UC START# *4DAEEDE10285_8E65E900818E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8E65E900818E_impl*
end;//TkwAACContainerFormPnLeft.DoDoIt

class function TkwAACContainerFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLeft';
end;//TkwAACContainerFormPnLeft.GetWordNameForRegister

procedure TkwAACContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormPnLeft.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormPnLeft.ParamsTypes

function TkwAACContainerFormScrLeft.scrLeft(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtScrollBar;
 {* ���������� ����� ������� .TAACContainerForm.scrLeft }
//#UC START# *BD0CF5DD7632_A1184BF82643_var*
//#UC END# *BD0CF5DD7632_A1184BF82643_var*
begin
//#UC START# *BD0CF5DD7632_A1184BF82643_impl*
 !!! Needs to be implemented !!!
//#UC END# *BD0CF5DD7632_A1184BF82643_impl*
end;//TkwAACContainerFormScrLeft.scrLeft

procedure TkwAACContainerFormScrLeft.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A1184BF82643_var*
//#UC END# *4DAEEDE10285_A1184BF82643_var*
begin
//#UC START# *4DAEEDE10285_A1184BF82643_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A1184BF82643_impl*
end;//TkwAACContainerFormScrLeft.DoDoIt

class function TkwAACContainerFormScrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.scrLeft';
end;//TkwAACContainerFormScrLeft.GetWordNameForRegister

procedure TkwAACContainerFormScrLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwAACContainerFormScrLeft.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwAACContainerFormScrLeft.ParamsTypes

initialization
 Tkw_Form_AACContainer.RegisterInEngine;
 {* ����������� Tkw_Form_AACContainer }
 Tkw_AACContainer_Control_pnWriteToUs.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnWriteToUs }
 Tkw_AACContainer_Control_pnWriteToUs_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnWriteToUs_Push }
 Tkw_AACContainer_Control_edWriteToUs.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_edWriteToUs }
 Tkw_AACContainer_Control_edWriteToUs_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_edWriteToUs_Push }
 Tkw_AACContainer_Control_pnSeeAlso.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnSeeAlso }
 Tkw_AACContainer_Control_pnSeeAlso_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnSeeAlso_Push }
 Tkw_AACContainer_Control_lblSeeAlso.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_lblSeeAlso }
 Tkw_AACContainer_Control_lblSeeAlso_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_lblSeeAlso_Push }
 Tkw_AACContainer_Control_pnLinkToContent.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnLinkToContent }
 Tkw_AACContainer_Control_pnLinkToContent_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pnLinkToContent_Push }
 Tkw_AACContainer_Control_pbLinkToContent.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pbLinkToContent }
 Tkw_AACContainer_Control_pbLinkToContent_Push.RegisterInEngine;
 {* ����������� Tkw_AACContainer_Control_pbLinkToContent_Push }
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
 TkwAACContainerFormPnWriteToUs.RegisterInEngine;
 {* ����������� AACContainerForm_pnWriteToUs }
 TkwAACContainerFormEdWriteToUs.RegisterInEngine;
 {* ����������� AACContainerForm_edWriteToUs }
 TkwAACContainerFormPnSeeAlso.RegisterInEngine;
 {* ����������� AACContainerForm_pnSeeAlso }
 TkwAACContainerFormLblSeeAlso.RegisterInEngine;
 {* ����������� AACContainerForm_lblSeeAlso }
 TkwAACContainerFormPnLinkToContent.RegisterInEngine;
 {* ����������� AACContainerForm_pnLinkToContent }
 TkwAACContainerFormPbLinkToContent.RegisterInEngine;
 {* ����������� AACContainerForm_pbLinkToContent }
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAACContainerForm));
 {* ����������� ���� AACContainer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscSimpleEditorForDialogs));
 {* ����������� ���� TnscSimpleEditorForDialogs }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtScrollBar));
 {* ����������� ���� TvtScrollBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
