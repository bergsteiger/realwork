unit StartupTipsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� StartupTips }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\StartupTipsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DayTips_Module
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtFocusLabel
 , vtCheckBox
 , ElPopBtn
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
 Tkw_Form_StartupTips = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� StartupTips
----
*������ �������������*:
[code]
'aControl' �����::StartupTips TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_StartupTips

 Tkw_StartupTips_Control_TopPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TopPanel
----
*������ �������������*:
[code]
�������::TopPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_TopPanel

 Tkw_StartupTips_Control_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TopPanel
----
*������ �������������*:
[code]
�������::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_TopPanel_Push

 Tkw_StartupTips_Control_TitlePaintBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TitlePaintBox
----
*������ �������������*:
[code]
�������::TitlePaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_TitlePaintBox

 Tkw_StartupTips_Control_TitlePaintBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TitlePaintBox
----
*������ �������������*:
[code]
�������::TitlePaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_TitlePaintBox_Push

 Tkw_StartupTips_Control_TitleLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TitleLabel
----
*������ �������������*:
[code]
�������::TitleLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_TitleLabel

 Tkw_StartupTips_Control_TitleLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TitleLabel
----
*������ �������������*:
[code]
�������::TitleLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_TitleLabel_Push

 Tkw_StartupTips_Control_BottomPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BottomPanel
----
*������ �������������*:
[code]
�������::BottomPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_BottomPanel

 Tkw_StartupTips_Control_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BottomPanel
----
*������ �������������*:
[code]
�������::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_BottomPanel_Push

 Tkw_StartupTips_Control_HintPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� HintPanel
----
*������ �������������*:
[code]
�������::HintPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_HintPanel

 Tkw_StartupTips_Control_HintPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HintPanel
----
*������ �������������*:
[code]
�������::HintPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_HintPanel_Push

 Tkw_StartupTips_Control_TipLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TipLabel
----
*������ �������������*:
[code]
�������::TipLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_TipLabel

 Tkw_StartupTips_Control_TipLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TipLabel
----
*������ �������������*:
[code]
�������::TipLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_TipLabel_Push

 Tkw_StartupTips_Control_DetailLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� DetailLabel
----
*������ �������������*:
[code]
�������::DetailLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_DetailLabel

 Tkw_StartupTips_Control_DetailLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� DetailLabel
----
*������ �������������*:
[code]
�������::DetailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_DetailLabel_Push

 Tkw_StartupTips_Control_ShowCheckBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ShowCheckBox
----
*������ �������������*:
[code]
�������::ShowCheckBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_ShowCheckBox

 Tkw_StartupTips_Control_ShowCheckBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ShowCheckBox
----
*������ �������������*:
[code]
�������::ShowCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_ShowCheckBox_Push

 Tkw_StartupTips_Control_wwwPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� wwwPanel
----
*������ �������������*:
[code]
�������::wwwPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_wwwPanel

 Tkw_StartupTips_Control_wwwPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� wwwPanel
----
*������ �������������*:
[code]
�������::wwwPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_wwwPanel_Push

 Tkw_StartupTips_Control_wwwPaintBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� wwwPaintBox
----
*������ �������������*:
[code]
�������::wwwPaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_wwwPaintBox

 Tkw_StartupTips_Control_wwwPaintBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� wwwPaintBox
----
*������ �������������*:
[code]
�������::wwwPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_wwwPaintBox_Push

 Tkw_StartupTips_Control_wwwLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� wwwLabel
----
*������ �������������*:
[code]
�������::wwwLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_wwwLabel

 Tkw_StartupTips_Control_wwwLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� wwwLabel
----
*������ �������������*:
[code]
�������::wwwLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_wwwLabel_Push

 Tkw_StartupTips_Control_NextButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NextButton
----
*������ �������������*:
[code]
�������::NextButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_NextButton

 Tkw_StartupTips_Control_NextButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NextButton
----
*������ �������������*:
[code]
�������::NextButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_NextButton_Push

 Tkw_StartupTips_Control_PrevButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� PrevButton
----
*������ �������������*:
[code]
�������::PrevButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_PrevButton

 Tkw_StartupTips_Control_PrevButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� PrevButton
----
*������ �������������*:
[code]
�������::PrevButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_PrevButton_Push

 Tkw_StartupTips_Control_CloseButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� CloseButton
----
*������ �������������*:
[code]
�������::CloseButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_CloseButton

 Tkw_StartupTips_Control_CloseButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� CloseButton
----
*������ �������������*:
[code]
�������::CloseButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_CloseButton_Push

 TkwEfStartupTipsTopPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.TopPanel
[panel]������� TopPanel ����� TefStartupTips[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.TopPanel >>> l_TvtPanel
[code]  }
  private
   function TopPanel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtPanel;
    {* ���������� ����� ������� .TefStartupTips.TopPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsTopPanel

 TkwEfStartupTipsTitlePaintBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.TitlePaintBox
[panel]������� TitlePaintBox ����� TefStartupTips[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aefStartupTips .TefStartupTips.TitlePaintBox >>> l_TPaintBox
[code]  }
  private
   function TitlePaintBox(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TPaintBox;
    {* ���������� ����� ������� .TefStartupTips.TitlePaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsTitlePaintBox

 TkwEfStartupTipsTitleLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.TitleLabel
[panel]������� TitleLabel ����� TefStartupTips[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefStartupTips .TefStartupTips.TitleLabel >>> l_TvtLabel
[code]  }
  private
   function TitleLabel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtLabel;
    {* ���������� ����� ������� .TefStartupTips.TitleLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsTitleLabel

 TkwEfStartupTipsBottomPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.BottomPanel
[panel]������� BottomPanel ����� TefStartupTips[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.BottomPanel >>> l_TvtPanel
[code]  }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtPanel;
    {* ���������� ����� ������� .TefStartupTips.BottomPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsBottomPanel

 TkwEfStartupTipsHintPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.HintPanel
[panel]������� HintPanel ����� TefStartupTips[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.HintPanel >>> l_TvtPanel
[code]  }
  private
   function HintPanel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtPanel;
    {* ���������� ����� ������� .TefStartupTips.HintPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsHintPanel

 TkwEfStartupTipsTipLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.TipLabel
[panel]������� TipLabel ����� TefStartupTips[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefStartupTips .TefStartupTips.TipLabel >>> l_TvtLabel
[code]  }
  private
   function TipLabel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtLabel;
    {* ���������� ����� ������� .TefStartupTips.TipLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsTipLabel

 TkwEfStartupTipsDetailLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.DetailLabel
[panel]������� DetailLabel ����� TefStartupTips[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aefStartupTips .TefStartupTips.DetailLabel >>> l_TvtFocusLabel
[code]  }
  private
   function DetailLabel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtFocusLabel;
    {* ���������� ����� ������� .TefStartupTips.DetailLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsDetailLabel

 TkwEfStartupTipsShowCheckBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.ShowCheckBox
[panel]������� ShowCheckBox ����� TefStartupTips[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aefStartupTips .TefStartupTips.ShowCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function ShowCheckBox(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtCheckBox;
    {* ���������� ����� ������� .TefStartupTips.ShowCheckBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsShowCheckBox

 TkwEfStartupTipsWwwPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.wwwPanel
[panel]������� wwwPanel ����� TefStartupTips[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.wwwPanel >>> l_TvtPanel
[code]  }
  private
   function wwwPanel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtPanel;
    {* ���������� ����� ������� .TefStartupTips.wwwPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsWwwPanel

 TkwEfStartupTipsWwwPaintBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.wwwPaintBox
[panel]������� wwwPaintBox ����� TefStartupTips[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aefStartupTips .TefStartupTips.wwwPaintBox >>> l_TPaintBox
[code]  }
  private
   function wwwPaintBox(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TPaintBox;
    {* ���������� ����� ������� .TefStartupTips.wwwPaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsWwwPaintBox

 TkwEfStartupTipsWwwLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.wwwLabel
[panel]������� wwwLabel ����� TefStartupTips[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aefStartupTips .TefStartupTips.wwwLabel >>> l_TvtFocusLabel
[code]  }
  private
   function wwwLabel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtFocusLabel;
    {* ���������� ����� ������� .TefStartupTips.wwwLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsWwwLabel

 TkwEfStartupTipsNextButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.NextButton
[panel]������� NextButton ����� TefStartupTips[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aefStartupTips .TefStartupTips.NextButton >>> l_TElPopupButton
[code]  }
  private
   function NextButton(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TElPopupButton;
    {* ���������� ����� ������� .TefStartupTips.NextButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsNextButton

 TkwEfStartupTipsPrevButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.PrevButton
[panel]������� PrevButton ����� TefStartupTips[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aefStartupTips .TefStartupTips.PrevButton >>> l_TElPopupButton
[code]  }
  private
   function PrevButton(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TElPopupButton;
    {* ���������� ����� ������� .TefStartupTips.PrevButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsPrevButton

 TkwEfStartupTipsCloseButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefStartupTips.CloseButton
[panel]������� CloseButton ����� TefStartupTips[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aefStartupTips .TefStartupTips.CloseButton >>> l_TElPopupButton
[code]  }
  private
   function CloseButton(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TElPopupButton;
    {* ���������� ����� ������� .TefStartupTips.CloseButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsCloseButton

class function Tkw_Form_StartupTips.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::StartupTips';
end;//Tkw_Form_StartupTips.GetWordNameForRegister

function Tkw_Form_StartupTips.GetString: AnsiString;
begin
 Result := 'efStartupTips';
end;//Tkw_Form_StartupTips.GetString

class function Tkw_StartupTips_Control_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TopPanel';
end;//Tkw_StartupTips_Control_TopPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_TopPanel.GetString: AnsiString;
begin
 Result := 'TopPanel';
end;//Tkw_StartupTips_Control_TopPanel.GetString

class procedure Tkw_StartupTips_Control_TopPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_TopPanel.RegisterInEngine

procedure Tkw_StartupTips_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7DF813516E20_var*
//#UC END# *4DAEEDE10285_7DF813516E20_var*
begin
//#UC START# *4DAEEDE10285_7DF813516E20_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7DF813516E20_impl*
end;//Tkw_StartupTips_Control_TopPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TopPanel:push';
end;//Tkw_StartupTips_Control_TopPanel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_TitlePaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TitlePaintBox';
end;//Tkw_StartupTips_Control_TitlePaintBox.GetWordNameForRegister

function Tkw_StartupTips_Control_TitlePaintBox.GetString: AnsiString;
begin
 Result := 'TitlePaintBox';
end;//Tkw_StartupTips_Control_TitlePaintBox.GetString

class procedure Tkw_StartupTips_Control_TitlePaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_StartupTips_Control_TitlePaintBox.RegisterInEngine

procedure Tkw_StartupTips_Control_TitlePaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_81D3F58DE336_var*
//#UC END# *4DAEEDE10285_81D3F58DE336_var*
begin
//#UC START# *4DAEEDE10285_81D3F58DE336_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_81D3F58DE336_impl*
end;//Tkw_StartupTips_Control_TitlePaintBox_Push.DoDoIt

class function Tkw_StartupTips_Control_TitlePaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TitlePaintBox:push';
end;//Tkw_StartupTips_Control_TitlePaintBox_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_TitleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TitleLabel';
end;//Tkw_StartupTips_Control_TitleLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_TitleLabel.GetString: AnsiString;
begin
 Result := 'TitleLabel';
end;//Tkw_StartupTips_Control_TitleLabel.GetString

class procedure Tkw_StartupTips_Control_TitleLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StartupTips_Control_TitleLabel.RegisterInEngine

procedure Tkw_StartupTips_Control_TitleLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A30B38772CD6_var*
//#UC END# *4DAEEDE10285_A30B38772CD6_var*
begin
//#UC START# *4DAEEDE10285_A30B38772CD6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A30B38772CD6_impl*
end;//Tkw_StartupTips_Control_TitleLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_TitleLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TitleLabel:push';
end;//Tkw_StartupTips_Control_TitleLabel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomPanel';
end;//Tkw_StartupTips_Control_BottomPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_BottomPanel.GetString: AnsiString;
begin
 Result := 'BottomPanel';
end;//Tkw_StartupTips_Control_BottomPanel.GetString

class procedure Tkw_StartupTips_Control_BottomPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_BottomPanel.RegisterInEngine

procedure Tkw_StartupTips_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B4899D4E9041_var*
//#UC END# *4DAEEDE10285_B4899D4E9041_var*
begin
//#UC START# *4DAEEDE10285_B4899D4E9041_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B4899D4E9041_impl*
end;//Tkw_StartupTips_Control_BottomPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomPanel:push';
end;//Tkw_StartupTips_Control_BottomPanel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_HintPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HintPanel';
end;//Tkw_StartupTips_Control_HintPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_HintPanel.GetString: AnsiString;
begin
 Result := 'HintPanel';
end;//Tkw_StartupTips_Control_HintPanel.GetString

class procedure Tkw_StartupTips_Control_HintPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_HintPanel.RegisterInEngine

procedure Tkw_StartupTips_Control_HintPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2E0686E9199C_var*
//#UC END# *4DAEEDE10285_2E0686E9199C_var*
begin
//#UC START# *4DAEEDE10285_2E0686E9199C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2E0686E9199C_impl*
end;//Tkw_StartupTips_Control_HintPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_HintPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HintPanel:push';
end;//Tkw_StartupTips_Control_HintPanel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_TipLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TipLabel';
end;//Tkw_StartupTips_Control_TipLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_TipLabel.GetString: AnsiString;
begin
 Result := 'TipLabel';
end;//Tkw_StartupTips_Control_TipLabel.GetString

class procedure Tkw_StartupTips_Control_TipLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StartupTips_Control_TipLabel.RegisterInEngine

procedure Tkw_StartupTips_Control_TipLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7E0783AFF535_var*
//#UC END# *4DAEEDE10285_7E0783AFF535_var*
begin
//#UC START# *4DAEEDE10285_7E0783AFF535_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7E0783AFF535_impl*
end;//Tkw_StartupTips_Control_TipLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_TipLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TipLabel:push';
end;//Tkw_StartupTips_Control_TipLabel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_DetailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DetailLabel';
end;//Tkw_StartupTips_Control_DetailLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_DetailLabel.GetString: AnsiString;
begin
 Result := 'DetailLabel';
end;//Tkw_StartupTips_Control_DetailLabel.GetString

class procedure Tkw_StartupTips_Control_DetailLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_StartupTips_Control_DetailLabel.RegisterInEngine

procedure Tkw_StartupTips_Control_DetailLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_864277A10C77_var*
//#UC END# *4DAEEDE10285_864277A10C77_var*
begin
//#UC START# *4DAEEDE10285_864277A10C77_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_864277A10C77_impl*
end;//Tkw_StartupTips_Control_DetailLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_DetailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DetailLabel:push';
end;//Tkw_StartupTips_Control_DetailLabel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_ShowCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShowCheckBox';
end;//Tkw_StartupTips_Control_ShowCheckBox.GetWordNameForRegister

function Tkw_StartupTips_Control_ShowCheckBox.GetString: AnsiString;
begin
 Result := 'ShowCheckBox';
end;//Tkw_StartupTips_Control_ShowCheckBox.GetString

class procedure Tkw_StartupTips_Control_ShowCheckBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StartupTips_Control_ShowCheckBox.RegisterInEngine

procedure Tkw_StartupTips_Control_ShowCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7B1198AAB31C_var*
//#UC END# *4DAEEDE10285_7B1198AAB31C_var*
begin
//#UC START# *4DAEEDE10285_7B1198AAB31C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7B1198AAB31C_impl*
end;//Tkw_StartupTips_Control_ShowCheckBox_Push.DoDoIt

class function Tkw_StartupTips_Control_ShowCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShowCheckBox:push';
end;//Tkw_StartupTips_Control_ShowCheckBox_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_wwwPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::wwwPanel';
end;//Tkw_StartupTips_Control_wwwPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_wwwPanel.GetString: AnsiString;
begin
 Result := 'wwwPanel';
end;//Tkw_StartupTips_Control_wwwPanel.GetString

class procedure Tkw_StartupTips_Control_wwwPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_wwwPanel.RegisterInEngine

procedure Tkw_StartupTips_Control_wwwPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D7692CEA3106_var*
//#UC END# *4DAEEDE10285_D7692CEA3106_var*
begin
//#UC START# *4DAEEDE10285_D7692CEA3106_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D7692CEA3106_impl*
end;//Tkw_StartupTips_Control_wwwPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_wwwPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::wwwPanel:push';
end;//Tkw_StartupTips_Control_wwwPanel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_wwwPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::wwwPaintBox';
end;//Tkw_StartupTips_Control_wwwPaintBox.GetWordNameForRegister

function Tkw_StartupTips_Control_wwwPaintBox.GetString: AnsiString;
begin
 Result := 'wwwPaintBox';
end;//Tkw_StartupTips_Control_wwwPaintBox.GetString

class procedure Tkw_StartupTips_Control_wwwPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_StartupTips_Control_wwwPaintBox.RegisterInEngine

procedure Tkw_StartupTips_Control_wwwPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_73CE45570DC2_var*
//#UC END# *4DAEEDE10285_73CE45570DC2_var*
begin
//#UC START# *4DAEEDE10285_73CE45570DC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_73CE45570DC2_impl*
end;//Tkw_StartupTips_Control_wwwPaintBox_Push.DoDoIt

class function Tkw_StartupTips_Control_wwwPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::wwwPaintBox:push';
end;//Tkw_StartupTips_Control_wwwPaintBox_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_wwwLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::wwwLabel';
end;//Tkw_StartupTips_Control_wwwLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_wwwLabel.GetString: AnsiString;
begin
 Result := 'wwwLabel';
end;//Tkw_StartupTips_Control_wwwLabel.GetString

class procedure Tkw_StartupTips_Control_wwwLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_StartupTips_Control_wwwLabel.RegisterInEngine

procedure Tkw_StartupTips_Control_wwwLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7C38C3E1D4C5_var*
//#UC END# *4DAEEDE10285_7C38C3E1D4C5_var*
begin
//#UC START# *4DAEEDE10285_7C38C3E1D4C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7C38C3E1D4C5_impl*
end;//Tkw_StartupTips_Control_wwwLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_wwwLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::wwwLabel:push';
end;//Tkw_StartupTips_Control_wwwLabel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_NextButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NextButton';
end;//Tkw_StartupTips_Control_NextButton.GetWordNameForRegister

function Tkw_StartupTips_Control_NextButton.GetString: AnsiString;
begin
 Result := 'NextButton';
end;//Tkw_StartupTips_Control_NextButton.GetString

class procedure Tkw_StartupTips_Control_NextButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StartupTips_Control_NextButton.RegisterInEngine

procedure Tkw_StartupTips_Control_NextButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_11F85FE0D364_var*
//#UC END# *4DAEEDE10285_11F85FE0D364_var*
begin
//#UC START# *4DAEEDE10285_11F85FE0D364_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_11F85FE0D364_impl*
end;//Tkw_StartupTips_Control_NextButton_Push.DoDoIt

class function Tkw_StartupTips_Control_NextButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NextButton:push';
end;//Tkw_StartupTips_Control_NextButton_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_PrevButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PrevButton';
end;//Tkw_StartupTips_Control_PrevButton.GetWordNameForRegister

function Tkw_StartupTips_Control_PrevButton.GetString: AnsiString;
begin
 Result := 'PrevButton';
end;//Tkw_StartupTips_Control_PrevButton.GetString

class procedure Tkw_StartupTips_Control_PrevButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StartupTips_Control_PrevButton.RegisterInEngine

procedure Tkw_StartupTips_Control_PrevButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_98BA2132D85E_var*
//#UC END# *4DAEEDE10285_98BA2132D85E_var*
begin
//#UC START# *4DAEEDE10285_98BA2132D85E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_98BA2132D85E_impl*
end;//Tkw_StartupTips_Control_PrevButton_Push.DoDoIt

class function Tkw_StartupTips_Control_PrevButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PrevButton:push';
end;//Tkw_StartupTips_Control_PrevButton_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_CloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CloseButton';
end;//Tkw_StartupTips_Control_CloseButton.GetWordNameForRegister

function Tkw_StartupTips_Control_CloseButton.GetString: AnsiString;
begin
 Result := 'CloseButton';
end;//Tkw_StartupTips_Control_CloseButton.GetString

class procedure Tkw_StartupTips_Control_CloseButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StartupTips_Control_CloseButton.RegisterInEngine

procedure Tkw_StartupTips_Control_CloseButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DE5B5144BBDC_var*
//#UC END# *4DAEEDE10285_DE5B5144BBDC_var*
begin
//#UC START# *4DAEEDE10285_DE5B5144BBDC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DE5B5144BBDC_impl*
end;//Tkw_StartupTips_Control_CloseButton_Push.DoDoIt

class function Tkw_StartupTips_Control_CloseButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CloseButton:push';
end;//Tkw_StartupTips_Control_CloseButton_Push.GetWordNameForRegister

function TkwEfStartupTipsTopPanel.TopPanel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtPanel;
 {* ���������� ����� ������� .TefStartupTips.TopPanel }
begin
 Result := aefStartupTips.TopPanel;
end;//TkwEfStartupTipsTopPanel.TopPanel

procedure TkwEfStartupTipsTopPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TopPanel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsTopPanel.DoDoIt

class function TkwEfStartupTipsTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.TopPanel';
end;//TkwEfStartupTipsTopPanel.GetWordNameForRegister

procedure TkwEfStartupTipsTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TopPanel', aCtx);
end;//TkwEfStartupTipsTopPanel.SetValuePrim

function TkwEfStartupTipsTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsTopPanel.GetResultTypeInfo

function TkwEfStartupTipsTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsTopPanel.GetAllParamsCount

function TkwEfStartupTipsTopPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTopPanel.ParamsTypes

function TkwEfStartupTipsTitlePaintBox.TitlePaintBox(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TPaintBox;
 {* ���������� ����� ������� .TefStartupTips.TitlePaintBox }
begin
 Result := aefStartupTips.TitlePaintBox;
end;//TkwEfStartupTipsTitlePaintBox.TitlePaintBox

procedure TkwEfStartupTipsTitlePaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TitlePaintBox(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsTitlePaintBox.DoDoIt

class function TkwEfStartupTipsTitlePaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.TitlePaintBox';
end;//TkwEfStartupTipsTitlePaintBox.GetWordNameForRegister

procedure TkwEfStartupTipsTitlePaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TitlePaintBox', aCtx);
end;//TkwEfStartupTipsTitlePaintBox.SetValuePrim

function TkwEfStartupTipsTitlePaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfStartupTipsTitlePaintBox.GetResultTypeInfo

function TkwEfStartupTipsTitlePaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsTitlePaintBox.GetAllParamsCount

function TkwEfStartupTipsTitlePaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTitlePaintBox.ParamsTypes

function TkwEfStartupTipsTitleLabel.TitleLabel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtLabel;
 {* ���������� ����� ������� .TefStartupTips.TitleLabel }
begin
 Result := aefStartupTips.TitleLabel;
end;//TkwEfStartupTipsTitleLabel.TitleLabel

procedure TkwEfStartupTipsTitleLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TitleLabel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsTitleLabel.DoDoIt

class function TkwEfStartupTipsTitleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.TitleLabel';
end;//TkwEfStartupTipsTitleLabel.GetWordNameForRegister

procedure TkwEfStartupTipsTitleLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TitleLabel', aCtx);
end;//TkwEfStartupTipsTitleLabel.SetValuePrim

function TkwEfStartupTipsTitleLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfStartupTipsTitleLabel.GetResultTypeInfo

function TkwEfStartupTipsTitleLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsTitleLabel.GetAllParamsCount

function TkwEfStartupTipsTitleLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTitleLabel.ParamsTypes

function TkwEfStartupTipsBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtPanel;
 {* ���������� ����� ������� .TefStartupTips.BottomPanel }
begin
 Result := aefStartupTips.BottomPanel;
end;//TkwEfStartupTipsBottomPanel.BottomPanel

procedure TkwEfStartupTipsBottomPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BottomPanel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsBottomPanel.DoDoIt

class function TkwEfStartupTipsBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.BottomPanel';
end;//TkwEfStartupTipsBottomPanel.GetWordNameForRegister

procedure TkwEfStartupTipsBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BottomPanel', aCtx);
end;//TkwEfStartupTipsBottomPanel.SetValuePrim

function TkwEfStartupTipsBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsBottomPanel.GetResultTypeInfo

function TkwEfStartupTipsBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsBottomPanel.GetAllParamsCount

function TkwEfStartupTipsBottomPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsBottomPanel.ParamsTypes

function TkwEfStartupTipsHintPanel.HintPanel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtPanel;
 {* ���������� ����� ������� .TefStartupTips.HintPanel }
begin
 Result := aefStartupTips.HintPanel;
end;//TkwEfStartupTipsHintPanel.HintPanel

procedure TkwEfStartupTipsHintPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HintPanel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsHintPanel.DoDoIt

class function TkwEfStartupTipsHintPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.HintPanel';
end;//TkwEfStartupTipsHintPanel.GetWordNameForRegister

procedure TkwEfStartupTipsHintPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HintPanel', aCtx);
end;//TkwEfStartupTipsHintPanel.SetValuePrim

function TkwEfStartupTipsHintPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsHintPanel.GetResultTypeInfo

function TkwEfStartupTipsHintPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsHintPanel.GetAllParamsCount

function TkwEfStartupTipsHintPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsHintPanel.ParamsTypes

function TkwEfStartupTipsTipLabel.TipLabel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtLabel;
 {* ���������� ����� ������� .TefStartupTips.TipLabel }
begin
 Result := aefStartupTips.TipLabel;
end;//TkwEfStartupTipsTipLabel.TipLabel

procedure TkwEfStartupTipsTipLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TipLabel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsTipLabel.DoDoIt

class function TkwEfStartupTipsTipLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.TipLabel';
end;//TkwEfStartupTipsTipLabel.GetWordNameForRegister

procedure TkwEfStartupTipsTipLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TipLabel', aCtx);
end;//TkwEfStartupTipsTipLabel.SetValuePrim

function TkwEfStartupTipsTipLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfStartupTipsTipLabel.GetResultTypeInfo

function TkwEfStartupTipsTipLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsTipLabel.GetAllParamsCount

function TkwEfStartupTipsTipLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTipLabel.ParamsTypes

function TkwEfStartupTipsDetailLabel.DetailLabel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtFocusLabel;
 {* ���������� ����� ������� .TefStartupTips.DetailLabel }
begin
 Result := aefStartupTips.DetailLabel;
end;//TkwEfStartupTipsDetailLabel.DetailLabel

procedure TkwEfStartupTipsDetailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DetailLabel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsDetailLabel.DoDoIt

class function TkwEfStartupTipsDetailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.DetailLabel';
end;//TkwEfStartupTipsDetailLabel.GetWordNameForRegister

procedure TkwEfStartupTipsDetailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� DetailLabel', aCtx);
end;//TkwEfStartupTipsDetailLabel.SetValuePrim

function TkwEfStartupTipsDetailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwEfStartupTipsDetailLabel.GetResultTypeInfo

function TkwEfStartupTipsDetailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsDetailLabel.GetAllParamsCount

function TkwEfStartupTipsDetailLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsDetailLabel.ParamsTypes

function TkwEfStartupTipsShowCheckBox.ShowCheckBox(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtCheckBox;
 {* ���������� ����� ������� .TefStartupTips.ShowCheckBox }
begin
 Result := aefStartupTips.ShowCheckBox;
end;//TkwEfStartupTipsShowCheckBox.ShowCheckBox

procedure TkwEfStartupTipsShowCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ShowCheckBox(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsShowCheckBox.DoDoIt

class function TkwEfStartupTipsShowCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.ShowCheckBox';
end;//TkwEfStartupTipsShowCheckBox.GetWordNameForRegister

procedure TkwEfStartupTipsShowCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ShowCheckBox', aCtx);
end;//TkwEfStartupTipsShowCheckBox.SetValuePrim

function TkwEfStartupTipsShowCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfStartupTipsShowCheckBox.GetResultTypeInfo

function TkwEfStartupTipsShowCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsShowCheckBox.GetAllParamsCount

function TkwEfStartupTipsShowCheckBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsShowCheckBox.ParamsTypes

function TkwEfStartupTipsWwwPanel.wwwPanel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtPanel;
 {* ���������� ����� ������� .TefStartupTips.wwwPanel }
begin
 Result := aefStartupTips.wwwPanel;
end;//TkwEfStartupTipsWwwPanel.wwwPanel

procedure TkwEfStartupTipsWwwPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(wwwPanel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsWwwPanel.DoDoIt

class function TkwEfStartupTipsWwwPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.wwwPanel';
end;//TkwEfStartupTipsWwwPanel.GetWordNameForRegister

procedure TkwEfStartupTipsWwwPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� wwwPanel', aCtx);
end;//TkwEfStartupTipsWwwPanel.SetValuePrim

function TkwEfStartupTipsWwwPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsWwwPanel.GetResultTypeInfo

function TkwEfStartupTipsWwwPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsWwwPanel.GetAllParamsCount

function TkwEfStartupTipsWwwPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsWwwPanel.ParamsTypes

function TkwEfStartupTipsWwwPaintBox.wwwPaintBox(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TPaintBox;
 {* ���������� ����� ������� .TefStartupTips.wwwPaintBox }
begin
 Result := aefStartupTips.wwwPaintBox;
end;//TkwEfStartupTipsWwwPaintBox.wwwPaintBox

procedure TkwEfStartupTipsWwwPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(wwwPaintBox(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsWwwPaintBox.DoDoIt

class function TkwEfStartupTipsWwwPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.wwwPaintBox';
end;//TkwEfStartupTipsWwwPaintBox.GetWordNameForRegister

procedure TkwEfStartupTipsWwwPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� wwwPaintBox', aCtx);
end;//TkwEfStartupTipsWwwPaintBox.SetValuePrim

function TkwEfStartupTipsWwwPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfStartupTipsWwwPaintBox.GetResultTypeInfo

function TkwEfStartupTipsWwwPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsWwwPaintBox.GetAllParamsCount

function TkwEfStartupTipsWwwPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsWwwPaintBox.ParamsTypes

function TkwEfStartupTipsWwwLabel.wwwLabel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtFocusLabel;
 {* ���������� ����� ������� .TefStartupTips.wwwLabel }
begin
 Result := aefStartupTips.wwwLabel;
end;//TkwEfStartupTipsWwwLabel.wwwLabel

procedure TkwEfStartupTipsWwwLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(wwwLabel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsWwwLabel.DoDoIt

class function TkwEfStartupTipsWwwLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.wwwLabel';
end;//TkwEfStartupTipsWwwLabel.GetWordNameForRegister

procedure TkwEfStartupTipsWwwLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� wwwLabel', aCtx);
end;//TkwEfStartupTipsWwwLabel.SetValuePrim

function TkwEfStartupTipsWwwLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwEfStartupTipsWwwLabel.GetResultTypeInfo

function TkwEfStartupTipsWwwLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsWwwLabel.GetAllParamsCount

function TkwEfStartupTipsWwwLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsWwwLabel.ParamsTypes

function TkwEfStartupTipsNextButton.NextButton(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TElPopupButton;
 {* ���������� ����� ������� .TefStartupTips.NextButton }
begin
 Result := aefStartupTips.NextButton;
end;//TkwEfStartupTipsNextButton.NextButton

procedure TkwEfStartupTipsNextButton.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NextButton(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsNextButton.DoDoIt

class function TkwEfStartupTipsNextButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.NextButton';
end;//TkwEfStartupTipsNextButton.GetWordNameForRegister

procedure TkwEfStartupTipsNextButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NextButton', aCtx);
end;//TkwEfStartupTipsNextButton.SetValuePrim

function TkwEfStartupTipsNextButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwEfStartupTipsNextButton.GetResultTypeInfo

function TkwEfStartupTipsNextButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsNextButton.GetAllParamsCount

function TkwEfStartupTipsNextButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsNextButton.ParamsTypes

function TkwEfStartupTipsPrevButton.PrevButton(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TElPopupButton;
 {* ���������� ����� ������� .TefStartupTips.PrevButton }
begin
 Result := aefStartupTips.PrevButton;
end;//TkwEfStartupTipsPrevButton.PrevButton

procedure TkwEfStartupTipsPrevButton.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PrevButton(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsPrevButton.DoDoIt

class function TkwEfStartupTipsPrevButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.PrevButton';
end;//TkwEfStartupTipsPrevButton.GetWordNameForRegister

procedure TkwEfStartupTipsPrevButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� PrevButton', aCtx);
end;//TkwEfStartupTipsPrevButton.SetValuePrim

function TkwEfStartupTipsPrevButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwEfStartupTipsPrevButton.GetResultTypeInfo

function TkwEfStartupTipsPrevButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsPrevButton.GetAllParamsCount

function TkwEfStartupTipsPrevButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsPrevButton.ParamsTypes

function TkwEfStartupTipsCloseButton.CloseButton(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TElPopupButton;
 {* ���������� ����� ������� .TefStartupTips.CloseButton }
begin
 Result := aefStartupTips.CloseButton;
end;//TkwEfStartupTipsCloseButton.CloseButton

procedure TkwEfStartupTipsCloseButton.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CloseButton(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsCloseButton.DoDoIt

class function TkwEfStartupTipsCloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.CloseButton';
end;//TkwEfStartupTipsCloseButton.GetWordNameForRegister

procedure TkwEfStartupTipsCloseButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� CloseButton', aCtx);
end;//TkwEfStartupTipsCloseButton.SetValuePrim

function TkwEfStartupTipsCloseButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwEfStartupTipsCloseButton.GetResultTypeInfo

function TkwEfStartupTipsCloseButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsCloseButton.GetAllParamsCount

function TkwEfStartupTipsCloseButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsCloseButton.ParamsTypes

initialization
 Tkw_Form_StartupTips.RegisterInEngine;
 {* ����������� Tkw_Form_StartupTips }
 Tkw_StartupTips_Control_TopPanel.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_TopPanel }
 Tkw_StartupTips_Control_TopPanel_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_TopPanel_Push }
 Tkw_StartupTips_Control_TitlePaintBox.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_TitlePaintBox }
 Tkw_StartupTips_Control_TitlePaintBox_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_TitlePaintBox_Push }
 Tkw_StartupTips_Control_TitleLabel.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_TitleLabel }
 Tkw_StartupTips_Control_TitleLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_TitleLabel_Push }
 Tkw_StartupTips_Control_BottomPanel.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_BottomPanel }
 Tkw_StartupTips_Control_BottomPanel_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_BottomPanel_Push }
 Tkw_StartupTips_Control_HintPanel.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_HintPanel }
 Tkw_StartupTips_Control_HintPanel_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_HintPanel_Push }
 Tkw_StartupTips_Control_TipLabel.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_TipLabel }
 Tkw_StartupTips_Control_TipLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_TipLabel_Push }
 Tkw_StartupTips_Control_DetailLabel.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_DetailLabel }
 Tkw_StartupTips_Control_DetailLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_DetailLabel_Push }
 Tkw_StartupTips_Control_ShowCheckBox.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_ShowCheckBox }
 Tkw_StartupTips_Control_ShowCheckBox_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_ShowCheckBox_Push }
 Tkw_StartupTips_Control_wwwPanel.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_wwwPanel }
 Tkw_StartupTips_Control_wwwPanel_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_wwwPanel_Push }
 Tkw_StartupTips_Control_wwwPaintBox.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_wwwPaintBox }
 Tkw_StartupTips_Control_wwwPaintBox_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_wwwPaintBox_Push }
 Tkw_StartupTips_Control_wwwLabel.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_wwwLabel }
 Tkw_StartupTips_Control_wwwLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_wwwLabel_Push }
 Tkw_StartupTips_Control_NextButton.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_NextButton }
 Tkw_StartupTips_Control_NextButton_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_NextButton_Push }
 Tkw_StartupTips_Control_PrevButton.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_PrevButton }
 Tkw_StartupTips_Control_PrevButton_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_PrevButton_Push }
 Tkw_StartupTips_Control_CloseButton.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_CloseButton }
 Tkw_StartupTips_Control_CloseButton_Push.RegisterInEngine;
 {* ����������� Tkw_StartupTips_Control_CloseButton_Push }
 TkwEfStartupTipsTopPanel.RegisterInEngine;
 {* ����������� efStartupTips_TopPanel }
 TkwEfStartupTipsTitlePaintBox.RegisterInEngine;
 {* ����������� efStartupTips_TitlePaintBox }
 TkwEfStartupTipsTitleLabel.RegisterInEngine;
 {* ����������� efStartupTips_TitleLabel }
 TkwEfStartupTipsBottomPanel.RegisterInEngine;
 {* ����������� efStartupTips_BottomPanel }
 TkwEfStartupTipsHintPanel.RegisterInEngine;
 {* ����������� efStartupTips_HintPanel }
 TkwEfStartupTipsTipLabel.RegisterInEngine;
 {* ����������� efStartupTips_TipLabel }
 TkwEfStartupTipsDetailLabel.RegisterInEngine;
 {* ����������� efStartupTips_DetailLabel }
 TkwEfStartupTipsShowCheckBox.RegisterInEngine;
 {* ����������� efStartupTips_ShowCheckBox }
 TkwEfStartupTipsWwwPanel.RegisterInEngine;
 {* ����������� efStartupTips_wwwPanel }
 TkwEfStartupTipsWwwPaintBox.RegisterInEngine;
 {* ����������� efStartupTips_wwwPaintBox }
 TkwEfStartupTipsWwwLabel.RegisterInEngine;
 {* ����������� efStartupTips_wwwLabel }
 TkwEfStartupTipsNextButton.RegisterInEngine;
 {* ����������� efStartupTips_NextButton }
 TkwEfStartupTipsPrevButton.RegisterInEngine;
 {* ����������� efStartupTips_PrevButton }
 TkwEfStartupTipsCloseButton.RegisterInEngine;
 {* ����������� efStartupTips_CloseButton }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefStartupTips));
 {* ����������� ���� StartupTips }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* ����������� ���� TvtFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* ����������� ���� TvtCheckBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* ����������� ���� TElPopupButton }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
