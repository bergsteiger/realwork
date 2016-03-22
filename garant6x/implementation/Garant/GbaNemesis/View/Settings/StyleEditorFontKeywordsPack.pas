unit StyleEditorFontKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� StyleEditorFont }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\StyleEditorFontKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "StyleEditorFontKeywordsPack" MUID: (65D9C15E254B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , ElPopBtn
 , vtCheckBox
 , vtComboBoxQS
 , vtColorBox
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , StyleEditorFont_Form
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
 Tkw_Form_StyleEditorFont = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� StyleEditorFont
----
*������ �������������*:
[code]
'aControl' �����::StyleEditorFont TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_StyleEditorFont

 Tkw_StyleEditorFont_Control_FontScrollBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontScrollBox
----
*������ �������������*:
[code]
�������::FontScrollBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScrollBox

 Tkw_StyleEditorFont_Control_FontScrollBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontScrollBox
----
*������ �������������*:
[code]
�������::FontScrollBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push

 Tkw_StyleEditorFont_Control_FontUnderlineLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontUnderlineLabel
----
*������ �������������*:
[code]
�������::FontUnderlineLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel

 Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontUnderlineLabel
----
*������ �������������*:
[code]
�������::FontUnderlineLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push

 Tkw_StyleEditorFont_Control_FontStrikeoutLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontStrikeoutLabel
----
*������ �������������*:
[code]
�������::FontStrikeoutLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel

 Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontStrikeoutLabel
----
*������ �������������*:
[code]
�������::FontStrikeoutLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push

 Tkw_StyleEditorFont_Control_FontSizeLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontSizeLabel
----
*������ �������������*:
[code]
�������::FontSizeLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeLabel

 Tkw_StyleEditorFont_Control_FontSizeLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontSizeLabel
----
*������ �������������*:
[code]
�������::FontSizeLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push

 Tkw_StyleEditorFont_Control_FontNameLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontNameLabel
----
*������ �������������*:
[code]
�������::FontNameLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameLabel

 Tkw_StyleEditorFont_Control_FontNameLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontNameLabel
----
*������ �������������*:
[code]
�������::FontNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push

 Tkw_StyleEditorFont_Control_FontItalicLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontItalicLabel
----
*������ �������������*:
[code]
�������::FontItalicLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicLabel

 Tkw_StyleEditorFont_Control_FontItalicLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontItalicLabel
----
*������ �������������*:
[code]
�������::FontItalicLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push

 Tkw_StyleEditorFont_Control_FontForeColorLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontForeColorLabel
----
*������ �������������*:
[code]
�������::FontForeColorLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorLabel

 Tkw_StyleEditorFont_Control_FontForeColorLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontForeColorLabel
----
*������ �������������*:
[code]
�������::FontForeColorLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push

 Tkw_StyleEditorFont_Control_FontBoldLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontBoldLabel
----
*������ �������������*:
[code]
�������::FontBoldLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldLabel

 Tkw_StyleEditorFont_Control_FontBoldLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontBoldLabel
----
*������ �������������*:
[code]
�������::FontBoldLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push

 Tkw_StyleEditorFont_Control_FontBackColorLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontBackColorLabel
----
*������ �������������*:
[code]
�������::FontBackColorLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorLabel

 Tkw_StyleEditorFont_Control_FontBackColorLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontBackColorLabel
----
*������ �������������*:
[code]
�������::FontBackColorLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push

 Tkw_StyleEditorFont_Control_FontScalableLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontScalableLabel
----
*������ �������������*:
[code]
�������::FontScalableLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableLabel

 Tkw_StyleEditorFont_Control_FontScalableLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontScalableLabel
----
*������ �������������*:
[code]
�������::FontScalableLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push

 Tkw_StyleEditorFont_Control_FontScalableBevel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontScalableBevel
----
*������ �������������*:
[code]
�������::FontScalableBevel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableBevel

 Tkw_StyleEditorFont_Control_FontScalableBevel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontScalableBevel
----
*������ �������������*:
[code]
�������::FontScalableBevel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push

 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontStrikeoutInheritanceButton
----
*������ �������������*:
[code]
�������::FontStrikeoutInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton

 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontStrikeoutInheritanceButton
----
*������ �������������*:
[code]
�������::FontStrikeoutInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontSizeInheritanceButton
----
*������ �������������*:
[code]
�������::FontSizeInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton

 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontSizeInheritanceButton
----
*������ �������������*:
[code]
�������::FontSizeInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontNameInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontNameInheritanceButton
----
*������ �������������*:
[code]
�������::FontNameInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton

 Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontNameInheritanceButton
----
*������ �������������*:
[code]
�������::FontNameInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontItalicInheritanceButton
----
*������ �������������*:
[code]
�������::FontItalicInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton

 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontItalicInheritanceButton
----
*������ �������������*:
[code]
�������::FontItalicInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontForeColorInheritanceButton
----
*������ �������������*:
[code]
�������::FontForeColorInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton

 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontForeColorInheritanceButton
----
*������ �������������*:
[code]
�������::FontForeColorInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontBoldInheritanceButton
----
*������ �������������*:
[code]
�������::FontBoldInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton

 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontBoldInheritanceButton
----
*������ �������������*:
[code]
�������::FontBoldInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontBackColorInheritanceButton
----
*������ �������������*:
[code]
�������::FontBackColorInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton

 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontBackColorInheritanceButton
----
*������ �������������*:
[code]
�������::FontBackColorInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontUnderlineInheritanceButton
----
*������ �������������*:
[code]
�������::FontUnderlineInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton

 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontUnderlineInheritanceButton
----
*������ �������������*:
[code]
�������::FontUnderlineInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontUnderlineCheckBox
----
*������ �������������*:
[code]
�������::FontUnderlineCheckBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox

 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontUnderlineCheckBox
----
*������ �������������*:
[code]
�������::FontUnderlineCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push

 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontStrikeoutCheckBox
----
*������ �������������*:
[code]
�������::FontStrikeoutCheckBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox

 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontStrikeoutCheckBox
----
*������ �������������*:
[code]
�������::FontStrikeoutCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push

 Tkw_StyleEditorFont_Control_FontSizeComboBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontSizeComboBox
----
*������ �������������*:
[code]
�������::FontSizeComboBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeComboBox

 Tkw_StyleEditorFont_Control_FontSizeComboBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontSizeComboBox
----
*������ �������������*:
[code]
�������::FontSizeComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push

 Tkw_StyleEditorFont_Control_FontNameComboBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontNameComboBox
----
*������ �������������*:
[code]
�������::FontNameComboBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameComboBox

 Tkw_StyleEditorFont_Control_FontNameComboBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontNameComboBox
----
*������ �������������*:
[code]
�������::FontNameComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push

 Tkw_StyleEditorFont_Control_FontItalicCheckBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontItalicCheckBox
----
*������ �������������*:
[code]
�������::FontItalicCheckBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox

 Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontItalicCheckBox
----
*������ �������������*:
[code]
�������::FontItalicCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push

 Tkw_StyleEditorFont_Control_FontForeColorBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontForeColorBox
----
*������ �������������*:
[code]
�������::FontForeColorBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorBox

 Tkw_StyleEditorFont_Control_FontForeColorBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontForeColorBox
----
*������ �������������*:
[code]
�������::FontForeColorBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push

 Tkw_StyleEditorFont_Control_FontBoldCheckBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontBoldCheckBox
----
*������ �������������*:
[code]
�������::FontBoldCheckBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox

 Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontBoldCheckBox
----
*������ �������������*:
[code]
�������::FontBoldCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push

 Tkw_StyleEditorFont_Control_FontBackColorBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontBackColorBox
----
*������ �������������*:
[code]
�������::FontBackColorBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorBox

 Tkw_StyleEditorFont_Control_FontBackColorBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontBackColorBox
----
*������ �������������*:
[code]
�������::FontBackColorBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push

 Tkw_StyleEditorFont_Control_FontScalableCheckBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FontScalableCheckBox
----
*������ �������������*:
[code]
�������::FontScalableCheckBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox

 Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FontScalableCheckBox
----
*������ �������������*:
[code]
�������::FontScalableCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push

 Tkw_StyleEditorFont_Control_LeftIndentLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LeftIndentLabel
----
*������ �������������*:
[code]
�������::LeftIndentLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentLabel

 Tkw_StyleEditorFont_Control_LeftIndentLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftIndentLabel
----
*������ �������������*:
[code]
�������::LeftIndentLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push

 Tkw_StyleEditorFont_Control_LeftIndentComboBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LeftIndentComboBox
----
*������ �������������*:
[code]
�������::LeftIndentComboBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox

 Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftIndentComboBox
----
*������ �������������*:
[code]
�������::LeftIndentComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push

 Tkw_StyleEditorFont_Control_RightIndentLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RightIndentLabel
----
*������ �������������*:
[code]
�������::RightIndentLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentLabel

 Tkw_StyleEditorFont_Control_RightIndentLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightIndentLabel
----
*������ �������������*:
[code]
�������::RightIndentLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push

 Tkw_StyleEditorFont_Control_RightIndentComboBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RightIndentComboBox
----
*������ �������������*:
[code]
�������::RightIndentComboBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentComboBox

 Tkw_StyleEditorFont_Control_RightIndentComboBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightIndentComboBox
----
*������ �������������*:
[code]
�������::RightIndentComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push

 Tkw_StyleEditorFont_Control_FirstIndentLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FirstIndentLabel
----
*������ �������������*:
[code]
�������::FirstIndentLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentLabel

 Tkw_StyleEditorFont_Control_FirstIndentLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FirstIndentLabel
----
*������ �������������*:
[code]
�������::FirstIndentLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push

 Tkw_StyleEditorFont_Control_FirstIndentComboBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FirstIndentComboBox
----
*������ �������������*:
[code]
�������::FirstIndentComboBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox

 Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FirstIndentComboBox
----
*������ �������������*:
[code]
�������::FirstIndentComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push

 Tkw_StyleEditorFont_Control_SpaceBeforeLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SpaceBeforeLabel
----
*������ �������������*:
[code]
�������::SpaceBeforeLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel

 Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� SpaceBeforeLabel
----
*������ �������������*:
[code]
�������::SpaceBeforeLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push

 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SpaceBeforeComboBox
----
*������ �������������*:
[code]
�������::SpaceBeforeComboBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox

 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� SpaceBeforeComboBox
----
*������ �������������*:
[code]
�������::SpaceBeforeComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push

 Tkw_StyleEditorFont_Control_SpaceAfterLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SpaceAfterLabel
----
*������ �������������*:
[code]
�������::SpaceAfterLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel

 Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� SpaceAfterLabel
----
*������ �������������*:
[code]
�������::SpaceAfterLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push

 Tkw_StyleEditorFont_Control_SpaceAfterComboBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SpaceAfterComboBox
----
*������ �������������*:
[code]
�������::SpaceAfterComboBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox

 Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� SpaceAfterComboBox
----
*������ �������������*:
[code]
�������::SpaceAfterComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push

 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LeftIndentInheritanceButton
----
*������ �������������*:
[code]
�������::LeftIndentInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton

 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftIndentInheritanceButton
----
*������ �������������*:
[code]
�������::LeftIndentInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push

 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RightIndentInheritanceButton
----
*������ �������������*:
[code]
�������::RightIndentInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton

 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightIndentInheritanceButton
----
*������ �������������*:
[code]
�������::RightIndentInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FirstIndentInheritanceButton
----
*������ �������������*:
[code]
�������::FirstIndentInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton

 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FirstIndentInheritanceButton
----
*������ �������������*:
[code]
�������::FirstIndentInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push

 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SpaceBeforeInheritanceButton
----
*������ �������������*:
[code]
�������::SpaceBeforeInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton

 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� SpaceBeforeInheritanceButton
----
*������ �������������*:
[code]
�������::SpaceBeforeInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push

 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SpaceAfterInheritanceButton
----
*������ �������������*:
[code]
�������::SpaceAfterInheritanceButton TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton

 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� SpaceAfterInheritanceButton
----
*������ �������������*:
[code]
�������::SpaceAfterInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push

 Tkw_StyleEditorFont_Control_StyleCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� StyleCaptionLabel
----
*������ �������������*:
[code]
�������::StyleCaptionLabel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel

 Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StyleCaptionLabel
----
*������ �������������*:
[code]
�������::StyleCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push

 Tkw_StyleEditorFont_Control_StyleCaptionComboBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� StyleCaptionComboBox
----
*������ �������������*:
[code]
�������::StyleCaptionComboBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox

 Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� StyleCaptionComboBox
----
*������ �������������*:
[code]
�������::StyleCaptionComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push

 TkwStyleEditorFontFormFontScrollBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontScrollBox
[panel]������� FontScrollBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TScrollBox
*������:*
[code]
OBJECT VAR l_TScrollBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontScrollBox >>> l_TScrollBox
[code]  }
  private
   function FontScrollBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TScrollBox;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontScrollBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontScrollBox

 TkwStyleEditorFontFormFontUnderlineLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontUnderlineLabel
[panel]������� FontUnderlineLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontUnderlineLabel >>> l_TvtLabel
[code]  }
  private
   function FontUnderlineLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontUnderlineLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontUnderlineLabel

 TkwStyleEditorFontFormFontStrikeoutLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontStrikeoutLabel
[panel]������� FontStrikeoutLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontStrikeoutLabel >>> l_TvtLabel
[code]  }
  private
   function FontStrikeoutLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontStrikeoutLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontStrikeoutLabel

 TkwStyleEditorFontFormFontSizeLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontSizeLabel
[panel]������� FontSizeLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontSizeLabel >>> l_TvtLabel
[code]  }
  private
   function FontSizeLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontSizeLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontSizeLabel

 TkwStyleEditorFontFormFontNameLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontNameLabel
[panel]������� FontNameLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontNameLabel >>> l_TvtLabel
[code]  }
  private
   function FontNameLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontNameLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontNameLabel

 TkwStyleEditorFontFormFontItalicLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontItalicLabel
[panel]������� FontItalicLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontItalicLabel >>> l_TvtLabel
[code]  }
  private
   function FontItalicLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontItalicLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontItalicLabel

 TkwStyleEditorFontFormFontForeColorLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontForeColorLabel
[panel]������� FontForeColorLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontForeColorLabel >>> l_TvtLabel
[code]  }
  private
   function FontForeColorLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontForeColorLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontForeColorLabel

 TkwStyleEditorFontFormFontBoldLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontBoldLabel
[panel]������� FontBoldLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontBoldLabel >>> l_TvtLabel
[code]  }
  private
   function FontBoldLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontBoldLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontBoldLabel

 TkwStyleEditorFontFormFontBackColorLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontBackColorLabel
[panel]������� FontBackColorLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontBackColorLabel >>> l_TvtLabel
[code]  }
  private
   function FontBackColorLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontBackColorLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontBackColorLabel

 TkwStyleEditorFontFormFontScalableLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontScalableLabel
[panel]������� FontScalableLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontScalableLabel >>> l_TvtLabel
[code]  }
  private
   function FontScalableLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontScalableLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontScalableLabel

 TkwStyleEditorFontFormFontScalableBevel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontScalableBevel
[panel]������� FontScalableBevel ����� TStyleEditorFontForm[panel]
*��� ����������:* TBevel
*������:*
[code]
OBJECT VAR l_TBevel
 aStyleEditorFontForm .TStyleEditorFontForm.FontScalableBevel >>> l_TBevel
[code]  }
  private
   function FontScalableBevel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TBevel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontScalableBevel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontScalableBevel

 TkwStyleEditorFontFormFontStrikeoutInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontStrikeoutInheritanceButton
[panel]������� FontStrikeoutInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontStrikeoutInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontStrikeoutInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontStrikeoutInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton

 TkwStyleEditorFontFormFontSizeInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontSizeInheritanceButton
[panel]������� FontSizeInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontSizeInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontSizeInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontSizeInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontSizeInheritanceButton

 TkwStyleEditorFontFormFontNameInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontNameInheritanceButton
[panel]������� FontNameInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontNameInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontNameInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontNameInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontNameInheritanceButton

 TkwStyleEditorFontFormFontItalicInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontItalicInheritanceButton
[panel]������� FontItalicInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontItalicInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontItalicInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontItalicInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontItalicInheritanceButton

 TkwStyleEditorFontFormFontForeColorInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontForeColorInheritanceButton
[panel]������� FontForeColorInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontForeColorInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontForeColorInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontForeColorInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontForeColorInheritanceButton

 TkwStyleEditorFontFormFontBoldInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontBoldInheritanceButton
[panel]������� FontBoldInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontBoldInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontBoldInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontBoldInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontBoldInheritanceButton

 TkwStyleEditorFontFormFontBackColorInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontBackColorInheritanceButton
[panel]������� FontBackColorInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontBackColorInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontBackColorInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontBackColorInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontBackColorInheritanceButton

 TkwStyleEditorFontFormFontUnderlineInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontUnderlineInheritanceButton
[panel]������� FontUnderlineInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontUnderlineInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontUnderlineInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontUnderlineInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton

 TkwStyleEditorFontFormFontUnderlineCheckBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontUnderlineCheckBox
[panel]������� FontUnderlineCheckBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontUnderlineCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontUnderlineCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontUnderlineCheckBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontUnderlineCheckBox

 TkwStyleEditorFontFormFontStrikeoutCheckBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontStrikeoutCheckBox
[panel]������� FontStrikeoutCheckBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontStrikeoutCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontStrikeoutCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontStrikeoutCheckBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontStrikeoutCheckBox

 TkwStyleEditorFontFormFontSizeComboBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontSizeComboBox
[panel]������� FontSizeComboBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.FontSizeComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function FontSizeComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontSizeComboBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontSizeComboBox

 TkwStyleEditorFontFormFontNameComboBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontNameComboBox
[panel]������� FontNameComboBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.FontNameComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function FontNameComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontNameComboBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontNameComboBox

 TkwStyleEditorFontFormFontItalicCheckBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontItalicCheckBox
[panel]������� FontItalicCheckBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontItalicCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontItalicCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontItalicCheckBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontItalicCheckBox

 TkwStyleEditorFontFormFontForeColorBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontForeColorBox
[panel]������� FontForeColorBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtColorBox
*������:*
[code]
OBJECT VAR l_TvtColorBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontForeColorBox >>> l_TvtColorBox
[code]  }
  private
   function FontForeColorBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontForeColorBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontForeColorBox

 TkwStyleEditorFontFormFontBoldCheckBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontBoldCheckBox
[panel]������� FontBoldCheckBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontBoldCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontBoldCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontBoldCheckBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontBoldCheckBox

 TkwStyleEditorFontFormFontBackColorBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontBackColorBox
[panel]������� FontBackColorBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtColorBox
*������:*
[code]
OBJECT VAR l_TvtColorBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontBackColorBox >>> l_TvtColorBox
[code]  }
  private
   function FontBackColorBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontBackColorBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontBackColorBox

 TkwStyleEditorFontFormFontScalableCheckBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FontScalableCheckBox
[panel]������� FontScalableCheckBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontScalableCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontScalableCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* ���������� ����� ������� .TStyleEditorFontForm.FontScalableCheckBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFontScalableCheckBox

 TkwStyleEditorFontFormLeftIndentLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.LeftIndentLabel
[panel]������� LeftIndentLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.LeftIndentLabel >>> l_TvtLabel
[code]  }
  private
   function LeftIndentLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.LeftIndentLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormLeftIndentLabel

 TkwStyleEditorFontFormLeftIndentComboBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.LeftIndentComboBox
[panel]������� LeftIndentComboBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.LeftIndentComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function LeftIndentComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* ���������� ����� ������� .TStyleEditorFontForm.LeftIndentComboBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormLeftIndentComboBox

 TkwStyleEditorFontFormRightIndentLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.RightIndentLabel
[panel]������� RightIndentLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.RightIndentLabel >>> l_TvtLabel
[code]  }
  private
   function RightIndentLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.RightIndentLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormRightIndentLabel

 TkwStyleEditorFontFormRightIndentComboBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.RightIndentComboBox
[panel]������� RightIndentComboBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.RightIndentComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function RightIndentComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* ���������� ����� ������� .TStyleEditorFontForm.RightIndentComboBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormRightIndentComboBox

 TkwStyleEditorFontFormFirstIndentLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FirstIndentLabel
[panel]������� FirstIndentLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FirstIndentLabel >>> l_TvtLabel
[code]  }
  private
   function FirstIndentLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.FirstIndentLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFirstIndentLabel

 TkwStyleEditorFontFormFirstIndentComboBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FirstIndentComboBox
[panel]������� FirstIndentComboBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.FirstIndentComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function FirstIndentComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* ���������� ����� ������� .TStyleEditorFontForm.FirstIndentComboBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFirstIndentComboBox

 TkwStyleEditorFontFormSpaceBeforeLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.SpaceBeforeLabel
[panel]������� SpaceBeforeLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceBeforeLabel >>> l_TvtLabel
[code]  }
  private
   function SpaceBeforeLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.SpaceBeforeLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormSpaceBeforeLabel

 TkwStyleEditorFontFormSpaceBeforeComboBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.SpaceBeforeComboBox
[panel]������� SpaceBeforeComboBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceBeforeComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function SpaceBeforeComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* ���������� ����� ������� .TStyleEditorFontForm.SpaceBeforeComboBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormSpaceBeforeComboBox

 TkwStyleEditorFontFormSpaceAfterLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.SpaceAfterLabel
[panel]������� SpaceAfterLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceAfterLabel >>> l_TvtLabel
[code]  }
  private
   function SpaceAfterLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.SpaceAfterLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormSpaceAfterLabel

 TkwStyleEditorFontFormSpaceAfterComboBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.SpaceAfterComboBox
[panel]������� SpaceAfterComboBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceAfterComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function SpaceAfterComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* ���������� ����� ������� .TStyleEditorFontForm.SpaceAfterComboBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormSpaceAfterComboBox

 TkwStyleEditorFontFormLeftIndentInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.LeftIndentInheritanceButton
[panel]������� LeftIndentInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.LeftIndentInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function LeftIndentInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.LeftIndentInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormLeftIndentInheritanceButton

 TkwStyleEditorFontFormRightIndentInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.RightIndentInheritanceButton
[panel]������� RightIndentInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.RightIndentInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function RightIndentInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.RightIndentInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormRightIndentInheritanceButton

 TkwStyleEditorFontFormFirstIndentInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.FirstIndentInheritanceButton
[panel]������� FirstIndentInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FirstIndentInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FirstIndentInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.FirstIndentInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormFirstIndentInheritanceButton

 TkwStyleEditorFontFormSpaceBeforeInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.SpaceBeforeInheritanceButton
[panel]������� SpaceBeforeInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceBeforeInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function SpaceBeforeInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.SpaceBeforeInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton

 TkwStyleEditorFontFormSpaceAfterInheritanceButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.SpaceAfterInheritanceButton
[panel]������� SpaceAfterInheritanceButton ����� TStyleEditorFontForm[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceAfterInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function SpaceAfterInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* ���������� ����� ������� .TStyleEditorFontForm.SpaceAfterInheritanceButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton

 TkwStyleEditorFontFormStyleCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.StyleCaptionLabel
[panel]������� StyleCaptionLabel ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.StyleCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function StyleCaptionLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* ���������� ����� ������� .TStyleEditorFontForm.StyleCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormStyleCaptionLabel

 TkwStyleEditorFontFormStyleCaptionComboBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TStyleEditorFontForm.StyleCaptionComboBox
[panel]������� StyleCaptionComboBox ����� TStyleEditorFontForm[panel]
*��� ����������:* TvtComboBoxQS
*������:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.StyleCaptionComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function StyleCaptionComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* ���������� ����� ������� .TStyleEditorFontForm.StyleCaptionComboBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStyleEditorFontFormStyleCaptionComboBox

function Tkw_Form_StyleEditorFont.GetString: AnsiString;
begin
 Result := 'StyleEditorFontForm';
end;//Tkw_Form_StyleEditorFont.GetString

class function Tkw_Form_StyleEditorFont.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::StyleEditorFont';
end;//Tkw_Form_StyleEditorFont.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScrollBox.GetString: AnsiString;
begin
 Result := 'FontScrollBox';
end;//Tkw_StyleEditorFont_Control_FontScrollBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontScrollBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TScrollBox);
end;//Tkw_StyleEditorFont_Control_FontScrollBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontScrollBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontScrollBox';
end;//Tkw_StyleEditorFont_Control_FontScrollBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontScrollBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontScrollBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScrollBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontScrollBox:push';
end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetString: AnsiString;
begin
 Result := 'FontUnderlineLabel';
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontUnderlineLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontUnderlineLabel';
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontUnderlineLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontUnderlineLabel:push';
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetString: AnsiString;
begin
 Result := 'FontStrikeoutLabel';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontStrikeoutLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontStrikeoutLabel';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontStrikeoutLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontStrikeoutLabel:push';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontSizeLabel.GetString: AnsiString;
begin
 Result := 'FontSizeLabel';
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontSizeLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontSizeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontSizeLabel';
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontSizeLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontSizeLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontSizeLabel:push';
end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontNameLabel.GetString: AnsiString;
begin
 Result := 'FontNameLabel';
end;//Tkw_StyleEditorFont_Control_FontNameLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontNameLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontNameLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontNameLabel';
end;//Tkw_StyleEditorFont_Control_FontNameLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontNameLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontNameLabel:push';
end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontItalicLabel.GetString: AnsiString;
begin
 Result := 'FontItalicLabel';
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontItalicLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontItalicLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontItalicLabel';
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontItalicLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontItalicLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontItalicLabel:push';
end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontForeColorLabel.GetString: AnsiString;
begin
 Result := 'FontForeColorLabel';
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontForeColorLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontForeColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontForeColorLabel';
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontForeColorLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontForeColorLabel:push';
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBoldLabel.GetString: AnsiString;
begin
 Result := 'FontBoldLabel';
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontBoldLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontBoldLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBoldLabel';
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBoldLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBoldLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBoldLabel:push';
end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBackColorLabel.GetString: AnsiString;
begin
 Result := 'FontBackColorLabel';
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontBackColorLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontBackColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBackColorLabel';
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBackColorLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBackColorLabel:push';
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScalableLabel.GetString: AnsiString;
begin
 Result := 'FontScalableLabel';
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontScalableLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontScalableLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontScalableLabel';
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontScalableLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontScalableLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontScalableLabel:push';
end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScalableBevel.GetString: AnsiString;
begin
 Result := 'FontScalableBevel';
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.GetString

class procedure Tkw_StyleEditorFont_Control_FontScalableBevel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBevel);
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontScalableBevel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontScalableBevel';
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontScalableBevel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontScalableBevel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableBevel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontScalableBevel:push';
end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetString: AnsiString;
begin
 Result := 'FontStrikeoutInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontStrikeoutInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontStrikeoutInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontStrikeoutInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetString: AnsiString;
begin
 Result := 'FontSizeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontSizeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontSizeInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontSizeInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetString: AnsiString;
begin
 Result := 'FontNameInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontNameInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontNameInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontNameInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontNameInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetString: AnsiString;
begin
 Result := 'FontItalicInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontItalicInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontItalicInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontItalicInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetString: AnsiString;
begin
 Result := 'FontForeColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontForeColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontForeColorInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontForeColorInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetString: AnsiString;
begin
 Result := 'FontBoldInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBoldInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBoldInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBoldInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetString: AnsiString;
begin
 Result := 'FontBackColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBackColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBackColorInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBackColorInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetString: AnsiString;
begin
 Result := 'FontUnderlineInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontUnderlineInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontUnderlineInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontUnderlineInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetString: AnsiString;
begin
 Result := 'FontUnderlineCheckBox';
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontUnderlineCheckBox';
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontUnderlineCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontUnderlineCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetString: AnsiString;
begin
 Result := 'FontStrikeoutCheckBox';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontStrikeoutCheckBox';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontStrikeoutCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontStrikeoutCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontSizeComboBox.GetString: AnsiString;
begin
 Result := 'FontSizeComboBox';
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontSizeComboBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontSizeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontSizeComboBox';
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontSizeComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontSizeComboBox:push';
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontNameComboBox.GetString: AnsiString;
begin
 Result := 'FontNameComboBox';
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontNameComboBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontNameComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontNameComboBox';
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontNameComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontNameComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontNameComboBox:push';
end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetString: AnsiString;
begin
 Result := 'FontItalicCheckBox';
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontItalicCheckBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontItalicCheckBox';
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontItalicCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontItalicCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontForeColorBox.GetString: AnsiString;
begin
 Result := 'FontForeColorBox';
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontForeColorBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtColorBox);
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontForeColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontForeColorBox';
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontForeColorBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontForeColorBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontForeColorBox:push';
end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetString: AnsiString;
begin
 Result := 'FontBoldCheckBox';
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontBoldCheckBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBoldCheckBox';
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBoldCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBoldCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBackColorBox.GetString: AnsiString;
begin
 Result := 'FontBackColorBox';
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontBackColorBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtColorBox);
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontBackColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBackColorBox';
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBackColorBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBackColorBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontBackColorBox:push';
end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetString: AnsiString;
begin
 Result := 'FontScalableCheckBox';
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontScalableCheckBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontScalableCheckBox';
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontScalableCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FontScalableCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_LeftIndentLabel.GetString: AnsiString;
begin
 Result := 'LeftIndentLabel';
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.GetString

class procedure Tkw_StyleEditorFont_Control_LeftIndentLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_LeftIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftIndentLabel';
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftIndentLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftIndentLabel:push';
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetString: AnsiString;
begin
 Result := 'LeftIndentComboBox';
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_LeftIndentComboBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftIndentComboBox';
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftIndentComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftIndentComboBox:push';
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_RightIndentLabel.GetString: AnsiString;
begin
 Result := 'RightIndentLabel';
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.GetString

class procedure Tkw_StyleEditorFont_Control_RightIndentLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_RightIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightIndentLabel';
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_RightIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightIndentLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightIndentLabel:push';
end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_RightIndentComboBox.GetString: AnsiString;
begin
 Result := 'RightIndentComboBox';
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_RightIndentComboBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_RightIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightIndentComboBox';
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightIndentComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightIndentComboBox:push';
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FirstIndentLabel.GetString: AnsiString;
begin
 Result := 'FirstIndentLabel';
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FirstIndentLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FirstIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstIndentLabel';
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FirstIndentLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstIndentLabel:push';
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetString: AnsiString;
begin
 Result := 'FirstIndentComboBox';
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_FirstIndentComboBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstIndentComboBox';
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FirstIndentComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstIndentComboBox:push';
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetString: AnsiString;
begin
 Result := 'SpaceBeforeLabel';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceBeforeLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceBeforeLabel';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceBeforeLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceBeforeLabel:push';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetString: AnsiString;
begin
 Result := 'SpaceBeforeComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceBeforeComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceBeforeComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceBeforeComboBox:push';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetString: AnsiString;
begin
 Result := 'SpaceAfterLabel';
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceAfterLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceAfterLabel';
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceAfterLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceAfterLabel:push';
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetString: AnsiString;
begin
 Result := 'SpaceAfterComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceAfterComboBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceAfterComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceAfterComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceAfterComboBox:push';
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetString: AnsiString;
begin
 Result := 'LeftIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftIndentInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftIndentInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetString: AnsiString;
begin
 Result := 'RightIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightIndentInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightIndentInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetString: AnsiString;
begin
 Result := 'FirstIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FirstIndentInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FirstIndentInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetString: AnsiString;
begin
 Result := 'SpaceBeforeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceBeforeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceBeforeInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceBeforeInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetString: AnsiString;
begin
 Result := 'SpaceAfterInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.RegisterInEngine

class function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceAfterInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceAfterInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SpaceAfterInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetString: AnsiString;
begin
 Result := 'StyleCaptionLabel';
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetString

class procedure Tkw_StyleEditorFont_Control_StyleCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.RegisterInEngine

class function Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StyleCaptionLabel';
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StyleCaptionLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StyleCaptionLabel:push';
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetString: AnsiString;
begin
 Result := 'StyleCaptionComboBox';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_StyleCaptionComboBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.RegisterInEngine

class function Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StyleCaptionComboBox';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StyleCaptionComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::StyleCaptionComboBox:push';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.GetWordNameForRegister

function TkwStyleEditorFontFormFontScrollBox.FontScrollBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TScrollBox;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontScrollBox }
begin
 Result := aStyleEditorFontForm.FontScrollBox;
end;//TkwStyleEditorFontFormFontScrollBox.FontScrollBox

procedure TkwStyleEditorFontFormFontScrollBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontScrollBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontScrollBox.DoDoIt

procedure TkwStyleEditorFontFormFontScrollBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontScrollBox', aCtx);
end;//TkwStyleEditorFontFormFontScrollBox.SetValuePrim

function TkwStyleEditorFontFormFontScrollBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TScrollBox);
end;//TkwStyleEditorFontFormFontScrollBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontScrollBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontScrollBox.GetAllParamsCount

function TkwStyleEditorFontFormFontScrollBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontScrollBox.ParamsTypes

class function TkwStyleEditorFontFormFontScrollBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScrollBox';
end;//TkwStyleEditorFontFormFontScrollBox.GetWordNameForRegister

function TkwStyleEditorFontFormFontUnderlineLabel.FontUnderlineLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontUnderlineLabel }
begin
 Result := aStyleEditorFontForm.FontUnderlineLabel;
end;//TkwStyleEditorFontFormFontUnderlineLabel.FontUnderlineLabel

procedure TkwStyleEditorFontFormFontUnderlineLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontUnderlineLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontUnderlineLabel.DoDoIt

procedure TkwStyleEditorFontFormFontUnderlineLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontUnderlineLabel', aCtx);
end;//TkwStyleEditorFontFormFontUnderlineLabel.SetValuePrim

function TkwStyleEditorFontFormFontUnderlineLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontUnderlineLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontUnderlineLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontUnderlineLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontUnderlineLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontUnderlineLabel.ParamsTypes

class function TkwStyleEditorFontFormFontUnderlineLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontUnderlineLabel';
end;//TkwStyleEditorFontFormFontUnderlineLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFontStrikeoutLabel.FontStrikeoutLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontStrikeoutLabel }
begin
 Result := aStyleEditorFontForm.FontStrikeoutLabel;
end;//TkwStyleEditorFontFormFontStrikeoutLabel.FontStrikeoutLabel

procedure TkwStyleEditorFontFormFontStrikeoutLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontStrikeoutLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontStrikeoutLabel.DoDoIt

procedure TkwStyleEditorFontFormFontStrikeoutLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontStrikeoutLabel', aCtx);
end;//TkwStyleEditorFontFormFontStrikeoutLabel.SetValuePrim

function TkwStyleEditorFontFormFontStrikeoutLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontStrikeoutLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontStrikeoutLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontStrikeoutLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontStrikeoutLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontStrikeoutLabel.ParamsTypes

class function TkwStyleEditorFontFormFontStrikeoutLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutLabel';
end;//TkwStyleEditorFontFormFontStrikeoutLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFontSizeLabel.FontSizeLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontSizeLabel }
begin
 Result := aStyleEditorFontForm.FontSizeLabel;
end;//TkwStyleEditorFontFormFontSizeLabel.FontSizeLabel

procedure TkwStyleEditorFontFormFontSizeLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontSizeLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontSizeLabel.DoDoIt

procedure TkwStyleEditorFontFormFontSizeLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontSizeLabel', aCtx);
end;//TkwStyleEditorFontFormFontSizeLabel.SetValuePrim

function TkwStyleEditorFontFormFontSizeLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontSizeLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontSizeLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontSizeLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontSizeLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontSizeLabel.ParamsTypes

class function TkwStyleEditorFontFormFontSizeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontSizeLabel';
end;//TkwStyleEditorFontFormFontSizeLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFontNameLabel.FontNameLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontNameLabel }
begin
 Result := aStyleEditorFontForm.FontNameLabel;
end;//TkwStyleEditorFontFormFontNameLabel.FontNameLabel

procedure TkwStyleEditorFontFormFontNameLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontNameLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontNameLabel.DoDoIt

procedure TkwStyleEditorFontFormFontNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontNameLabel', aCtx);
end;//TkwStyleEditorFontFormFontNameLabel.SetValuePrim

function TkwStyleEditorFontFormFontNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontNameLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontNameLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontNameLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontNameLabel.ParamsTypes

class function TkwStyleEditorFontFormFontNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontNameLabel';
end;//TkwStyleEditorFontFormFontNameLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFontItalicLabel.FontItalicLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontItalicLabel }
begin
 Result := aStyleEditorFontForm.FontItalicLabel;
end;//TkwStyleEditorFontFormFontItalicLabel.FontItalicLabel

procedure TkwStyleEditorFontFormFontItalicLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontItalicLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontItalicLabel.DoDoIt

procedure TkwStyleEditorFontFormFontItalicLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontItalicLabel', aCtx);
end;//TkwStyleEditorFontFormFontItalicLabel.SetValuePrim

function TkwStyleEditorFontFormFontItalicLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontItalicLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontItalicLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontItalicLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontItalicLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontItalicLabel.ParamsTypes

class function TkwStyleEditorFontFormFontItalicLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontItalicLabel';
end;//TkwStyleEditorFontFormFontItalicLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFontForeColorLabel.FontForeColorLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontForeColorLabel }
begin
 Result := aStyleEditorFontForm.FontForeColorLabel;
end;//TkwStyleEditorFontFormFontForeColorLabel.FontForeColorLabel

procedure TkwStyleEditorFontFormFontForeColorLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontForeColorLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontForeColorLabel.DoDoIt

procedure TkwStyleEditorFontFormFontForeColorLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontForeColorLabel', aCtx);
end;//TkwStyleEditorFontFormFontForeColorLabel.SetValuePrim

function TkwStyleEditorFontFormFontForeColorLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontForeColorLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontForeColorLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontForeColorLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontForeColorLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontForeColorLabel.ParamsTypes

class function TkwStyleEditorFontFormFontForeColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontForeColorLabel';
end;//TkwStyleEditorFontFormFontForeColorLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFontBoldLabel.FontBoldLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontBoldLabel }
begin
 Result := aStyleEditorFontForm.FontBoldLabel;
end;//TkwStyleEditorFontFormFontBoldLabel.FontBoldLabel

procedure TkwStyleEditorFontFormFontBoldLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBoldLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBoldLabel.DoDoIt

procedure TkwStyleEditorFontFormFontBoldLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontBoldLabel', aCtx);
end;//TkwStyleEditorFontFormFontBoldLabel.SetValuePrim

function TkwStyleEditorFontFormFontBoldLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontBoldLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontBoldLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontBoldLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontBoldLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBoldLabel.ParamsTypes

class function TkwStyleEditorFontFormFontBoldLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBoldLabel';
end;//TkwStyleEditorFontFormFontBoldLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFontBackColorLabel.FontBackColorLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontBackColorLabel }
begin
 Result := aStyleEditorFontForm.FontBackColorLabel;
end;//TkwStyleEditorFontFormFontBackColorLabel.FontBackColorLabel

procedure TkwStyleEditorFontFormFontBackColorLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBackColorLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBackColorLabel.DoDoIt

procedure TkwStyleEditorFontFormFontBackColorLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontBackColorLabel', aCtx);
end;//TkwStyleEditorFontFormFontBackColorLabel.SetValuePrim

function TkwStyleEditorFontFormFontBackColorLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontBackColorLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontBackColorLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontBackColorLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontBackColorLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBackColorLabel.ParamsTypes

class function TkwStyleEditorFontFormFontBackColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBackColorLabel';
end;//TkwStyleEditorFontFormFontBackColorLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFontScalableLabel.FontScalableLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontScalableLabel }
begin
 Result := aStyleEditorFontForm.FontScalableLabel;
end;//TkwStyleEditorFontFormFontScalableLabel.FontScalableLabel

procedure TkwStyleEditorFontFormFontScalableLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontScalableLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontScalableLabel.DoDoIt

procedure TkwStyleEditorFontFormFontScalableLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontScalableLabel', aCtx);
end;//TkwStyleEditorFontFormFontScalableLabel.SetValuePrim

function TkwStyleEditorFontFormFontScalableLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontScalableLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontScalableLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontScalableLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontScalableLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontScalableLabel.ParamsTypes

class function TkwStyleEditorFontFormFontScalableLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScalableLabel';
end;//TkwStyleEditorFontFormFontScalableLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFontScalableBevel.FontScalableBevel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TBevel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontScalableBevel }
begin
 Result := aStyleEditorFontForm.FontScalableBevel;
end;//TkwStyleEditorFontFormFontScalableBevel.FontScalableBevel

procedure TkwStyleEditorFontFormFontScalableBevel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontScalableBevel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontScalableBevel.DoDoIt

procedure TkwStyleEditorFontFormFontScalableBevel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontScalableBevel', aCtx);
end;//TkwStyleEditorFontFormFontScalableBevel.SetValuePrim

function TkwStyleEditorFontFormFontScalableBevel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBevel);
end;//TkwStyleEditorFontFormFontScalableBevel.GetResultTypeInfo

function TkwStyleEditorFontFormFontScalableBevel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontScalableBevel.GetAllParamsCount

function TkwStyleEditorFontFormFontScalableBevel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontScalableBevel.ParamsTypes

class function TkwStyleEditorFontFormFontScalableBevel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScalableBevel';
end;//TkwStyleEditorFontFormFontScalableBevel.GetWordNameForRegister

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.FontStrikeoutInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontStrikeoutInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontStrikeoutInheritanceButton;
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.FontStrikeoutInheritanceButton

procedure TkwStyleEditorFontFormFontStrikeoutInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontStrikeoutInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormFontStrikeoutInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontStrikeoutInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutInheritanceButton';
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormFontSizeInheritanceButton.FontSizeInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontSizeInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontSizeInheritanceButton;
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.FontSizeInheritanceButton

procedure TkwStyleEditorFontFormFontSizeInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontSizeInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormFontSizeInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontSizeInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontSizeInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontSizeInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontSizeInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormFontSizeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontSizeInheritanceButton';
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormFontNameInheritanceButton.FontNameInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontNameInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontNameInheritanceButton;
end;//TkwStyleEditorFontFormFontNameInheritanceButton.FontNameInheritanceButton

procedure TkwStyleEditorFontFormFontNameInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontNameInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontNameInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormFontNameInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontNameInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontNameInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontNameInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontNameInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontNameInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontNameInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontNameInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontNameInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormFontNameInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontNameInheritanceButton';
end;//TkwStyleEditorFontFormFontNameInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormFontItalicInheritanceButton.FontItalicInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontItalicInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontItalicInheritanceButton;
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.FontItalicInheritanceButton

procedure TkwStyleEditorFontFormFontItalicInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontItalicInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormFontItalicInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontItalicInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontItalicInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontItalicInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontItalicInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormFontItalicInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontItalicInheritanceButton';
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormFontForeColorInheritanceButton.FontForeColorInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontForeColorInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontForeColorInheritanceButton;
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.FontForeColorInheritanceButton

procedure TkwStyleEditorFontFormFontForeColorInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontForeColorInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormFontForeColorInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontForeColorInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontForeColorInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontForeColorInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontForeColorInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormFontForeColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontForeColorInheritanceButton';
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormFontBoldInheritanceButton.FontBoldInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontBoldInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontBoldInheritanceButton;
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.FontBoldInheritanceButton

procedure TkwStyleEditorFontFormFontBoldInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBoldInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormFontBoldInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontBoldInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontBoldInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontBoldInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontBoldInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormFontBoldInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBoldInheritanceButton';
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormFontBackColorInheritanceButton.FontBackColorInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontBackColorInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontBackColorInheritanceButton;
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.FontBackColorInheritanceButton

procedure TkwStyleEditorFontFormFontBackColorInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBackColorInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormFontBackColorInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontBackColorInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontBackColorInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontBackColorInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontBackColorInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormFontBackColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBackColorInheritanceButton';
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.FontUnderlineInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontUnderlineInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontUnderlineInheritanceButton;
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.FontUnderlineInheritanceButton

procedure TkwStyleEditorFontFormFontUnderlineInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontUnderlineInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormFontUnderlineInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontUnderlineInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontUnderlineInheritanceButton';
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormFontUnderlineCheckBox.FontUnderlineCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontUnderlineCheckBox }
begin
 Result := aStyleEditorFontForm.FontUnderlineCheckBox;
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.FontUnderlineCheckBox

procedure TkwStyleEditorFontFormFontUnderlineCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontUnderlineCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.DoDoIt

procedure TkwStyleEditorFontFormFontUnderlineCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontUnderlineCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontUnderlineCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontUnderlineCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontUnderlineCheckBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.ParamsTypes

class function TkwStyleEditorFontFormFontUnderlineCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontUnderlineCheckBox';
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.GetWordNameForRegister

function TkwStyleEditorFontFormFontStrikeoutCheckBox.FontStrikeoutCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontStrikeoutCheckBox }
begin
 Result := aStyleEditorFontForm.FontStrikeoutCheckBox;
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.FontStrikeoutCheckBox

procedure TkwStyleEditorFontFormFontStrikeoutCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontStrikeoutCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.DoDoIt

procedure TkwStyleEditorFontFormFontStrikeoutCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontStrikeoutCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontStrikeoutCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontStrikeoutCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontStrikeoutCheckBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.ParamsTypes

class function TkwStyleEditorFontFormFontStrikeoutCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutCheckBox';
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.GetWordNameForRegister

function TkwStyleEditorFontFormFontSizeComboBox.FontSizeComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontSizeComboBox }
begin
 Result := aStyleEditorFontForm.FontSizeComboBox;
end;//TkwStyleEditorFontFormFontSizeComboBox.FontSizeComboBox

procedure TkwStyleEditorFontFormFontSizeComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontSizeComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontSizeComboBox.DoDoIt

procedure TkwStyleEditorFontFormFontSizeComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontSizeComboBox', aCtx);
end;//TkwStyleEditorFontFormFontSizeComboBox.SetValuePrim

function TkwStyleEditorFontFormFontSizeComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormFontSizeComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontSizeComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontSizeComboBox.GetAllParamsCount

function TkwStyleEditorFontFormFontSizeComboBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontSizeComboBox.ParamsTypes

class function TkwStyleEditorFontFormFontSizeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontSizeComboBox';
end;//TkwStyleEditorFontFormFontSizeComboBox.GetWordNameForRegister

function TkwStyleEditorFontFormFontNameComboBox.FontNameComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontNameComboBox }
begin
 Result := aStyleEditorFontForm.FontNameComboBox;
end;//TkwStyleEditorFontFormFontNameComboBox.FontNameComboBox

procedure TkwStyleEditorFontFormFontNameComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontNameComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontNameComboBox.DoDoIt

procedure TkwStyleEditorFontFormFontNameComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontNameComboBox', aCtx);
end;//TkwStyleEditorFontFormFontNameComboBox.SetValuePrim

function TkwStyleEditorFontFormFontNameComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormFontNameComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontNameComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontNameComboBox.GetAllParamsCount

function TkwStyleEditorFontFormFontNameComboBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontNameComboBox.ParamsTypes

class function TkwStyleEditorFontFormFontNameComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontNameComboBox';
end;//TkwStyleEditorFontFormFontNameComboBox.GetWordNameForRegister

function TkwStyleEditorFontFormFontItalicCheckBox.FontItalicCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontItalicCheckBox }
begin
 Result := aStyleEditorFontForm.FontItalicCheckBox;
end;//TkwStyleEditorFontFormFontItalicCheckBox.FontItalicCheckBox

procedure TkwStyleEditorFontFormFontItalicCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontItalicCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontItalicCheckBox.DoDoIt

procedure TkwStyleEditorFontFormFontItalicCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontItalicCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontItalicCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontItalicCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontItalicCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontItalicCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontItalicCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontItalicCheckBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontItalicCheckBox.ParamsTypes

class function TkwStyleEditorFontFormFontItalicCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontItalicCheckBox';
end;//TkwStyleEditorFontFormFontItalicCheckBox.GetWordNameForRegister

function TkwStyleEditorFontFormFontForeColorBox.FontForeColorBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontForeColorBox }
begin
 Result := aStyleEditorFontForm.FontForeColorBox;
end;//TkwStyleEditorFontFormFontForeColorBox.FontForeColorBox

procedure TkwStyleEditorFontFormFontForeColorBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontForeColorBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontForeColorBox.DoDoIt

procedure TkwStyleEditorFontFormFontForeColorBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontForeColorBox', aCtx);
end;//TkwStyleEditorFontFormFontForeColorBox.SetValuePrim

function TkwStyleEditorFontFormFontForeColorBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtColorBox);
end;//TkwStyleEditorFontFormFontForeColorBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontForeColorBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontForeColorBox.GetAllParamsCount

function TkwStyleEditorFontFormFontForeColorBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontForeColorBox.ParamsTypes

class function TkwStyleEditorFontFormFontForeColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontForeColorBox';
end;//TkwStyleEditorFontFormFontForeColorBox.GetWordNameForRegister

function TkwStyleEditorFontFormFontBoldCheckBox.FontBoldCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontBoldCheckBox }
begin
 Result := aStyleEditorFontForm.FontBoldCheckBox;
end;//TkwStyleEditorFontFormFontBoldCheckBox.FontBoldCheckBox

procedure TkwStyleEditorFontFormFontBoldCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBoldCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBoldCheckBox.DoDoIt

procedure TkwStyleEditorFontFormFontBoldCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontBoldCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontBoldCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontBoldCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontBoldCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontBoldCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontBoldCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontBoldCheckBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBoldCheckBox.ParamsTypes

class function TkwStyleEditorFontFormFontBoldCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBoldCheckBox';
end;//TkwStyleEditorFontFormFontBoldCheckBox.GetWordNameForRegister

function TkwStyleEditorFontFormFontBackColorBox.FontBackColorBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontBackColorBox }
begin
 Result := aStyleEditorFontForm.FontBackColorBox;
end;//TkwStyleEditorFontFormFontBackColorBox.FontBackColorBox

procedure TkwStyleEditorFontFormFontBackColorBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBackColorBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBackColorBox.DoDoIt

procedure TkwStyleEditorFontFormFontBackColorBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontBackColorBox', aCtx);
end;//TkwStyleEditorFontFormFontBackColorBox.SetValuePrim

function TkwStyleEditorFontFormFontBackColorBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtColorBox);
end;//TkwStyleEditorFontFormFontBackColorBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontBackColorBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontBackColorBox.GetAllParamsCount

function TkwStyleEditorFontFormFontBackColorBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBackColorBox.ParamsTypes

class function TkwStyleEditorFontFormFontBackColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBackColorBox';
end;//TkwStyleEditorFontFormFontBackColorBox.GetWordNameForRegister

function TkwStyleEditorFontFormFontScalableCheckBox.FontScalableCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* ���������� ����� ������� .TStyleEditorFontForm.FontScalableCheckBox }
begin
 Result := aStyleEditorFontForm.FontScalableCheckBox;
end;//TkwStyleEditorFontFormFontScalableCheckBox.FontScalableCheckBox

procedure TkwStyleEditorFontFormFontScalableCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontScalableCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontScalableCheckBox.DoDoIt

procedure TkwStyleEditorFontFormFontScalableCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FontScalableCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontScalableCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontScalableCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontScalableCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontScalableCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFontScalableCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontScalableCheckBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontScalableCheckBox.ParamsTypes

class function TkwStyleEditorFontFormFontScalableCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScalableCheckBox';
end;//TkwStyleEditorFontFormFontScalableCheckBox.GetWordNameForRegister

function TkwStyleEditorFontFormLeftIndentLabel.LeftIndentLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.LeftIndentLabel }
begin
 Result := aStyleEditorFontForm.LeftIndentLabel;
end;//TkwStyleEditorFontFormLeftIndentLabel.LeftIndentLabel

procedure TkwStyleEditorFontFormLeftIndentLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftIndentLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormLeftIndentLabel.DoDoIt

procedure TkwStyleEditorFontFormLeftIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LeftIndentLabel', aCtx);
end;//TkwStyleEditorFontFormLeftIndentLabel.SetValuePrim

function TkwStyleEditorFontFormLeftIndentLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormLeftIndentLabel.GetResultTypeInfo

function TkwStyleEditorFontFormLeftIndentLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormLeftIndentLabel.GetAllParamsCount

function TkwStyleEditorFontFormLeftIndentLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormLeftIndentLabel.ParamsTypes

class function TkwStyleEditorFontFormLeftIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.LeftIndentLabel';
end;//TkwStyleEditorFontFormLeftIndentLabel.GetWordNameForRegister

function TkwStyleEditorFontFormLeftIndentComboBox.LeftIndentComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* ���������� ����� ������� .TStyleEditorFontForm.LeftIndentComboBox }
begin
 Result := aStyleEditorFontForm.LeftIndentComboBox;
end;//TkwStyleEditorFontFormLeftIndentComboBox.LeftIndentComboBox

procedure TkwStyleEditorFontFormLeftIndentComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftIndentComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormLeftIndentComboBox.DoDoIt

procedure TkwStyleEditorFontFormLeftIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LeftIndentComboBox', aCtx);
end;//TkwStyleEditorFontFormLeftIndentComboBox.SetValuePrim

function TkwStyleEditorFontFormLeftIndentComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormLeftIndentComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormLeftIndentComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormLeftIndentComboBox.GetAllParamsCount

function TkwStyleEditorFontFormLeftIndentComboBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormLeftIndentComboBox.ParamsTypes

class function TkwStyleEditorFontFormLeftIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.LeftIndentComboBox';
end;//TkwStyleEditorFontFormLeftIndentComboBox.GetWordNameForRegister

function TkwStyleEditorFontFormRightIndentLabel.RightIndentLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.RightIndentLabel }
begin
 Result := aStyleEditorFontForm.RightIndentLabel;
end;//TkwStyleEditorFontFormRightIndentLabel.RightIndentLabel

procedure TkwStyleEditorFontFormRightIndentLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightIndentLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormRightIndentLabel.DoDoIt

procedure TkwStyleEditorFontFormRightIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RightIndentLabel', aCtx);
end;//TkwStyleEditorFontFormRightIndentLabel.SetValuePrim

function TkwStyleEditorFontFormRightIndentLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormRightIndentLabel.GetResultTypeInfo

function TkwStyleEditorFontFormRightIndentLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormRightIndentLabel.GetAllParamsCount

function TkwStyleEditorFontFormRightIndentLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormRightIndentLabel.ParamsTypes

class function TkwStyleEditorFontFormRightIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.RightIndentLabel';
end;//TkwStyleEditorFontFormRightIndentLabel.GetWordNameForRegister

function TkwStyleEditorFontFormRightIndentComboBox.RightIndentComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* ���������� ����� ������� .TStyleEditorFontForm.RightIndentComboBox }
begin
 Result := aStyleEditorFontForm.RightIndentComboBox;
end;//TkwStyleEditorFontFormRightIndentComboBox.RightIndentComboBox

procedure TkwStyleEditorFontFormRightIndentComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightIndentComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormRightIndentComboBox.DoDoIt

procedure TkwStyleEditorFontFormRightIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RightIndentComboBox', aCtx);
end;//TkwStyleEditorFontFormRightIndentComboBox.SetValuePrim

function TkwStyleEditorFontFormRightIndentComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormRightIndentComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormRightIndentComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormRightIndentComboBox.GetAllParamsCount

function TkwStyleEditorFontFormRightIndentComboBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormRightIndentComboBox.ParamsTypes

class function TkwStyleEditorFontFormRightIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.RightIndentComboBox';
end;//TkwStyleEditorFontFormRightIndentComboBox.GetWordNameForRegister

function TkwStyleEditorFontFormFirstIndentLabel.FirstIndentLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.FirstIndentLabel }
begin
 Result := aStyleEditorFontForm.FirstIndentLabel;
end;//TkwStyleEditorFontFormFirstIndentLabel.FirstIndentLabel

procedure TkwStyleEditorFontFormFirstIndentLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FirstIndentLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFirstIndentLabel.DoDoIt

procedure TkwStyleEditorFontFormFirstIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FirstIndentLabel', aCtx);
end;//TkwStyleEditorFontFormFirstIndentLabel.SetValuePrim

function TkwStyleEditorFontFormFirstIndentLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFirstIndentLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFirstIndentLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFirstIndentLabel.GetAllParamsCount

function TkwStyleEditorFontFormFirstIndentLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFirstIndentLabel.ParamsTypes

class function TkwStyleEditorFontFormFirstIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FirstIndentLabel';
end;//TkwStyleEditorFontFormFirstIndentLabel.GetWordNameForRegister

function TkwStyleEditorFontFormFirstIndentComboBox.FirstIndentComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* ���������� ����� ������� .TStyleEditorFontForm.FirstIndentComboBox }
begin
 Result := aStyleEditorFontForm.FirstIndentComboBox;
end;//TkwStyleEditorFontFormFirstIndentComboBox.FirstIndentComboBox

procedure TkwStyleEditorFontFormFirstIndentComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FirstIndentComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFirstIndentComboBox.DoDoIt

procedure TkwStyleEditorFontFormFirstIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FirstIndentComboBox', aCtx);
end;//TkwStyleEditorFontFormFirstIndentComboBox.SetValuePrim

function TkwStyleEditorFontFormFirstIndentComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormFirstIndentComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormFirstIndentComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFirstIndentComboBox.GetAllParamsCount

function TkwStyleEditorFontFormFirstIndentComboBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFirstIndentComboBox.ParamsTypes

class function TkwStyleEditorFontFormFirstIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FirstIndentComboBox';
end;//TkwStyleEditorFontFormFirstIndentComboBox.GetWordNameForRegister

function TkwStyleEditorFontFormSpaceBeforeLabel.SpaceBeforeLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.SpaceBeforeLabel }
begin
 Result := aStyleEditorFontForm.SpaceBeforeLabel;
end;//TkwStyleEditorFontFormSpaceBeforeLabel.SpaceBeforeLabel

procedure TkwStyleEditorFontFormSpaceBeforeLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceBeforeLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceBeforeLabel.DoDoIt

procedure TkwStyleEditorFontFormSpaceBeforeLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SpaceBeforeLabel', aCtx);
end;//TkwStyleEditorFontFormSpaceBeforeLabel.SetValuePrim

function TkwStyleEditorFontFormSpaceBeforeLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormSpaceBeforeLabel.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceBeforeLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormSpaceBeforeLabel.GetAllParamsCount

function TkwStyleEditorFontFormSpaceBeforeLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceBeforeLabel.ParamsTypes

class function TkwStyleEditorFontFormSpaceBeforeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeLabel';
end;//TkwStyleEditorFontFormSpaceBeforeLabel.GetWordNameForRegister

function TkwStyleEditorFontFormSpaceBeforeComboBox.SpaceBeforeComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* ���������� ����� ������� .TStyleEditorFontForm.SpaceBeforeComboBox }
begin
 Result := aStyleEditorFontForm.SpaceBeforeComboBox;
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.SpaceBeforeComboBox

procedure TkwStyleEditorFontFormSpaceBeforeComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceBeforeComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.DoDoIt

procedure TkwStyleEditorFontFormSpaceBeforeComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SpaceBeforeComboBox', aCtx);
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.SetValuePrim

function TkwStyleEditorFontFormSpaceBeforeComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceBeforeComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.GetAllParamsCount

function TkwStyleEditorFontFormSpaceBeforeComboBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.ParamsTypes

class function TkwStyleEditorFontFormSpaceBeforeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeComboBox';
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.GetWordNameForRegister

function TkwStyleEditorFontFormSpaceAfterLabel.SpaceAfterLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.SpaceAfterLabel }
begin
 Result := aStyleEditorFontForm.SpaceAfterLabel;
end;//TkwStyleEditorFontFormSpaceAfterLabel.SpaceAfterLabel

procedure TkwStyleEditorFontFormSpaceAfterLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceAfterLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceAfterLabel.DoDoIt

procedure TkwStyleEditorFontFormSpaceAfterLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SpaceAfterLabel', aCtx);
end;//TkwStyleEditorFontFormSpaceAfterLabel.SetValuePrim

function TkwStyleEditorFontFormSpaceAfterLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormSpaceAfterLabel.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceAfterLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormSpaceAfterLabel.GetAllParamsCount

function TkwStyleEditorFontFormSpaceAfterLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceAfterLabel.ParamsTypes

class function TkwStyleEditorFontFormSpaceAfterLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceAfterLabel';
end;//TkwStyleEditorFontFormSpaceAfterLabel.GetWordNameForRegister

function TkwStyleEditorFontFormSpaceAfterComboBox.SpaceAfterComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* ���������� ����� ������� .TStyleEditorFontForm.SpaceAfterComboBox }
begin
 Result := aStyleEditorFontForm.SpaceAfterComboBox;
end;//TkwStyleEditorFontFormSpaceAfterComboBox.SpaceAfterComboBox

procedure TkwStyleEditorFontFormSpaceAfterComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceAfterComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceAfterComboBox.DoDoIt

procedure TkwStyleEditorFontFormSpaceAfterComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SpaceAfterComboBox', aCtx);
end;//TkwStyleEditorFontFormSpaceAfterComboBox.SetValuePrim

function TkwStyleEditorFontFormSpaceAfterComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormSpaceAfterComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceAfterComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormSpaceAfterComboBox.GetAllParamsCount

function TkwStyleEditorFontFormSpaceAfterComboBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceAfterComboBox.ParamsTypes

class function TkwStyleEditorFontFormSpaceAfterComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceAfterComboBox';
end;//TkwStyleEditorFontFormSpaceAfterComboBox.GetWordNameForRegister

function TkwStyleEditorFontFormLeftIndentInheritanceButton.LeftIndentInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.LeftIndentInheritanceButton }
begin
 Result := aStyleEditorFontForm.LeftIndentInheritanceButton;
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.LeftIndentInheritanceButton

procedure TkwStyleEditorFontFormLeftIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftIndentInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormLeftIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LeftIndentInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormLeftIndentInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormLeftIndentInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormLeftIndentInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormLeftIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.LeftIndentInheritanceButton';
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormRightIndentInheritanceButton.RightIndentInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.RightIndentInheritanceButton }
begin
 Result := aStyleEditorFontForm.RightIndentInheritanceButton;
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.RightIndentInheritanceButton

procedure TkwStyleEditorFontFormRightIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightIndentInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormRightIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RightIndentInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormRightIndentInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormRightIndentInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormRightIndentInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormRightIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.RightIndentInheritanceButton';
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormFirstIndentInheritanceButton.FirstIndentInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.FirstIndentInheritanceButton }
begin
 Result := aStyleEditorFontForm.FirstIndentInheritanceButton;
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.FirstIndentInheritanceButton

procedure TkwStyleEditorFontFormFirstIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FirstIndentInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormFirstIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FirstIndentInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFirstIndentInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFirstIndentInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFirstIndentInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormFirstIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FirstIndentInheritanceButton';
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SpaceBeforeInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.SpaceBeforeInheritanceButton }
begin
 Result := aStyleEditorFontForm.SpaceBeforeInheritanceButton;
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SpaceBeforeInheritanceButton

procedure TkwStyleEditorFontFormSpaceBeforeInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceBeforeInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SpaceBeforeInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeInheritanceButton';
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.SpaceAfterInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* ���������� ����� ������� .TStyleEditorFontForm.SpaceAfterInheritanceButton }
begin
 Result := aStyleEditorFontForm.SpaceAfterInheritanceButton;
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.SpaceAfterInheritanceButton

procedure TkwStyleEditorFontFormSpaceAfterInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceAfterInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.DoDoIt

procedure TkwStyleEditorFontFormSpaceAfterInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SpaceAfterInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.ParamsTypes

class function TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceAfterInheritanceButton';
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetWordNameForRegister

function TkwStyleEditorFontFormStyleCaptionLabel.StyleCaptionLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* ���������� ����� ������� .TStyleEditorFontForm.StyleCaptionLabel }
begin
 Result := aStyleEditorFontForm.StyleCaptionLabel;
end;//TkwStyleEditorFontFormStyleCaptionLabel.StyleCaptionLabel

procedure TkwStyleEditorFontFormStyleCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StyleCaptionLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormStyleCaptionLabel.DoDoIt

procedure TkwStyleEditorFontFormStyleCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� StyleCaptionLabel', aCtx);
end;//TkwStyleEditorFontFormStyleCaptionLabel.SetValuePrim

function TkwStyleEditorFontFormStyleCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormStyleCaptionLabel.GetResultTypeInfo

function TkwStyleEditorFontFormStyleCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormStyleCaptionLabel.GetAllParamsCount

function TkwStyleEditorFontFormStyleCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormStyleCaptionLabel.ParamsTypes

class function TkwStyleEditorFontFormStyleCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.StyleCaptionLabel';
end;//TkwStyleEditorFontFormStyleCaptionLabel.GetWordNameForRegister

function TkwStyleEditorFontFormStyleCaptionComboBox.StyleCaptionComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* ���������� ����� ������� .TStyleEditorFontForm.StyleCaptionComboBox }
begin
 Result := aStyleEditorFontForm.StyleCaptionComboBox;
end;//TkwStyleEditorFontFormStyleCaptionComboBox.StyleCaptionComboBox

procedure TkwStyleEditorFontFormStyleCaptionComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StyleCaptionComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormStyleCaptionComboBox.DoDoIt

procedure TkwStyleEditorFontFormStyleCaptionComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� StyleCaptionComboBox', aCtx);
end;//TkwStyleEditorFontFormStyleCaptionComboBox.SetValuePrim

function TkwStyleEditorFontFormStyleCaptionComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormStyleCaptionComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormStyleCaptionComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStyleEditorFontFormStyleCaptionComboBox.GetAllParamsCount

function TkwStyleEditorFontFormStyleCaptionComboBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormStyleCaptionComboBox.ParamsTypes

class function TkwStyleEditorFontFormStyleCaptionComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.StyleCaptionComboBox';
end;//TkwStyleEditorFontFormStyleCaptionComboBox.GetWordNameForRegister

initialization
 Tkw_Form_StyleEditorFont.RegisterInEngine;
 {* ����������� Tkw_Form_StyleEditorFont }
 Tkw_StyleEditorFont_Control_FontScrollBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontScrollBox }
 Tkw_StyleEditorFont_Control_FontScrollBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontScrollBox_Push }
 Tkw_StyleEditorFont_Control_FontUnderlineLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontUnderlineLabel }
 Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push }
 Tkw_StyleEditorFont_Control_FontStrikeoutLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontStrikeoutLabel }
 Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push }
 Tkw_StyleEditorFont_Control_FontSizeLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontSizeLabel }
 Tkw_StyleEditorFont_Control_FontSizeLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontSizeLabel_Push }
 Tkw_StyleEditorFont_Control_FontNameLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontNameLabel }
 Tkw_StyleEditorFont_Control_FontNameLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontNameLabel_Push }
 Tkw_StyleEditorFont_Control_FontItalicLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontItalicLabel }
 Tkw_StyleEditorFont_Control_FontItalicLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontItalicLabel_Push }
 Tkw_StyleEditorFont_Control_FontForeColorLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontForeColorLabel }
 Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontForeColorLabel_Push }
 Tkw_StyleEditorFont_Control_FontBoldLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBoldLabel }
 Tkw_StyleEditorFont_Control_FontBoldLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBoldLabel_Push }
 Tkw_StyleEditorFont_Control_FontBackColorLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBackColorLabel }
 Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBackColorLabel_Push }
 Tkw_StyleEditorFont_Control_FontScalableLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontScalableLabel }
 Tkw_StyleEditorFont_Control_FontScalableLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontScalableLabel_Push }
 Tkw_StyleEditorFont_Control_FontScalableBevel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontScalableBevel }
 Tkw_StyleEditorFont_Control_FontScalableBevel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontScalableBevel_Push }
 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton }
 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontSizeInheritanceButton }
 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontNameInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontNameInheritanceButton }
 Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontItalicInheritanceButton }
 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton }
 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBoldInheritanceButton }
 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton }
 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton }
 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontUnderlineCheckBox }
 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push }
 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox }
 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push }
 Tkw_StyleEditorFont_Control_FontSizeComboBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontSizeComboBox }
 Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontSizeComboBox_Push }
 Tkw_StyleEditorFont_Control_FontNameComboBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontNameComboBox }
 Tkw_StyleEditorFont_Control_FontNameComboBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontNameComboBox_Push }
 Tkw_StyleEditorFont_Control_FontItalicCheckBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontItalicCheckBox }
 Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push }
 Tkw_StyleEditorFont_Control_FontForeColorBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontForeColorBox }
 Tkw_StyleEditorFont_Control_FontForeColorBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontForeColorBox_Push }
 Tkw_StyleEditorFont_Control_FontBoldCheckBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBoldCheckBox }
 Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push }
 Tkw_StyleEditorFont_Control_FontBackColorBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBackColorBox }
 Tkw_StyleEditorFont_Control_FontBackColorBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontBackColorBox_Push }
 Tkw_StyleEditorFont_Control_FontScalableCheckBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontScalableCheckBox }
 Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push }
 Tkw_StyleEditorFont_Control_LeftIndentLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_LeftIndentLabel }
 Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_LeftIndentLabel_Push }
 Tkw_StyleEditorFont_Control_LeftIndentComboBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_LeftIndentComboBox }
 Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push }
 Tkw_StyleEditorFont_Control_RightIndentLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_RightIndentLabel }
 Tkw_StyleEditorFont_Control_RightIndentLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_RightIndentLabel_Push }
 Tkw_StyleEditorFont_Control_RightIndentComboBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_RightIndentComboBox }
 Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_RightIndentComboBox_Push }
 Tkw_StyleEditorFont_Control_FirstIndentLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FirstIndentLabel }
 Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FirstIndentLabel_Push }
 Tkw_StyleEditorFont_Control_FirstIndentComboBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FirstIndentComboBox }
 Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push }
 Tkw_StyleEditorFont_Control_SpaceBeforeLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceBeforeLabel }
 Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push }
 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceBeforeComboBox }
 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push }
 Tkw_StyleEditorFont_Control_SpaceAfterLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceAfterLabel }
 Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push }
 Tkw_StyleEditorFont_Control_SpaceAfterComboBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceAfterComboBox }
 Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push }
 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton }
 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_RightIndentInheritanceButton }
 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton }
 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton }
 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton }
 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_StyleCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_StyleCaptionLabel }
 Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push }
 Tkw_StyleEditorFont_Control_StyleCaptionComboBox.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_StyleCaptionComboBox }
 Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.RegisterInEngine;
 {* ����������� Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push }
 TkwStyleEditorFontFormFontScrollBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontScrollBox }
 TkwStyleEditorFontFormFontUnderlineLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontUnderlineLabel }
 TkwStyleEditorFontFormFontStrikeoutLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontStrikeoutLabel }
 TkwStyleEditorFontFormFontSizeLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontSizeLabel }
 TkwStyleEditorFontFormFontNameLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontNameLabel }
 TkwStyleEditorFontFormFontItalicLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontItalicLabel }
 TkwStyleEditorFontFormFontForeColorLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontForeColorLabel }
 TkwStyleEditorFontFormFontBoldLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontBoldLabel }
 TkwStyleEditorFontFormFontBackColorLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontBackColorLabel }
 TkwStyleEditorFontFormFontScalableLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontScalableLabel }
 TkwStyleEditorFontFormFontScalableBevel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontScalableBevel }
 TkwStyleEditorFontFormFontStrikeoutInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontStrikeoutInheritanceButton }
 TkwStyleEditorFontFormFontSizeInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontSizeInheritanceButton }
 TkwStyleEditorFontFormFontNameInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontNameInheritanceButton }
 TkwStyleEditorFontFormFontItalicInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontItalicInheritanceButton }
 TkwStyleEditorFontFormFontForeColorInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontForeColorInheritanceButton }
 TkwStyleEditorFontFormFontBoldInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontBoldInheritanceButton }
 TkwStyleEditorFontFormFontBackColorInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontBackColorInheritanceButton }
 TkwStyleEditorFontFormFontUnderlineInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontUnderlineInheritanceButton }
 TkwStyleEditorFontFormFontUnderlineCheckBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontUnderlineCheckBox }
 TkwStyleEditorFontFormFontStrikeoutCheckBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontStrikeoutCheckBox }
 TkwStyleEditorFontFormFontSizeComboBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontSizeComboBox }
 TkwStyleEditorFontFormFontNameComboBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontNameComboBox }
 TkwStyleEditorFontFormFontItalicCheckBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontItalicCheckBox }
 TkwStyleEditorFontFormFontForeColorBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontForeColorBox }
 TkwStyleEditorFontFormFontBoldCheckBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontBoldCheckBox }
 TkwStyleEditorFontFormFontBackColorBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontBackColorBox }
 TkwStyleEditorFontFormFontScalableCheckBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FontScalableCheckBox }
 TkwStyleEditorFontFormLeftIndentLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_LeftIndentLabel }
 TkwStyleEditorFontFormLeftIndentComboBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_LeftIndentComboBox }
 TkwStyleEditorFontFormRightIndentLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_RightIndentLabel }
 TkwStyleEditorFontFormRightIndentComboBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_RightIndentComboBox }
 TkwStyleEditorFontFormFirstIndentLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FirstIndentLabel }
 TkwStyleEditorFontFormFirstIndentComboBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FirstIndentComboBox }
 TkwStyleEditorFontFormSpaceBeforeLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_SpaceBeforeLabel }
 TkwStyleEditorFontFormSpaceBeforeComboBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_SpaceBeforeComboBox }
 TkwStyleEditorFontFormSpaceAfterLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_SpaceAfterLabel }
 TkwStyleEditorFontFormSpaceAfterComboBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_SpaceAfterComboBox }
 TkwStyleEditorFontFormLeftIndentInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_LeftIndentInheritanceButton }
 TkwStyleEditorFontFormRightIndentInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_RightIndentInheritanceButton }
 TkwStyleEditorFontFormFirstIndentInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_FirstIndentInheritanceButton }
 TkwStyleEditorFontFormSpaceBeforeInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_SpaceBeforeInheritanceButton }
 TkwStyleEditorFontFormSpaceAfterInheritanceButton.RegisterInEngine;
 {* ����������� StyleEditorFontForm_SpaceAfterInheritanceButton }
 TkwStyleEditorFontFormStyleCaptionLabel.RegisterInEngine;
 {* ����������� StyleEditorFontForm_StyleCaptionLabel }
 TkwStyleEditorFontFormStyleCaptionComboBox.RegisterInEngine;
 {* ����������� StyleEditorFontForm_StyleCaptionComboBox }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorFontForm));
 {* ����������� ���� StyleEditorFont }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TScrollBox));
 {* ����������� ���� TScrollBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBevel));
 {* ����������� ���� TBevel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* ����������� ���� TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* ����������� ���� TvtCheckBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBoxQS));
 {* ����������� ���� TvtComboBoxQS }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtColorBox));
 {* ����������� ���� TvtColorBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
