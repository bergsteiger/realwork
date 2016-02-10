unit StyleEditorFontKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы StyleEditorFont }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\StyleEditorFontKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Settings_Module
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
 Tkw_Form_StyleEditorFont = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы StyleEditorFont
----
*Пример использования*:
[code]
'aControl' форма::StyleEditorFont TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_StyleEditorFont

 Tkw_StyleEditorFont_Control_FontScrollBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontScrollBox
----
*Пример использования*:
[code]
контрол::FontScrollBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontScrollBox

 Tkw_StyleEditorFont_Control_FontScrollBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontScrollBox
----
*Пример использования*:
[code]
контрол::FontScrollBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push

 Tkw_StyleEditorFont_Control_FontUnderlineLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontUnderlineLabel
----
*Пример использования*:
[code]
контрол::FontUnderlineLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel

 Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontUnderlineLabel
----
*Пример использования*:
[code]
контрол::FontUnderlineLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push

 Tkw_StyleEditorFont_Control_FontStrikeoutLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontStrikeoutLabel
----
*Пример использования*:
[code]
контрол::FontStrikeoutLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel

 Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontStrikeoutLabel
----
*Пример использования*:
[code]
контрол::FontStrikeoutLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push

 Tkw_StyleEditorFont_Control_FontSizeLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontSizeLabel
----
*Пример использования*:
[code]
контрол::FontSizeLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeLabel

 Tkw_StyleEditorFont_Control_FontSizeLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontSizeLabel
----
*Пример использования*:
[code]
контрол::FontSizeLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push

 Tkw_StyleEditorFont_Control_FontNameLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontNameLabel
----
*Пример использования*:
[code]
контрол::FontNameLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontNameLabel

 Tkw_StyleEditorFont_Control_FontNameLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontNameLabel
----
*Пример использования*:
[code]
контрол::FontNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push

 Tkw_StyleEditorFont_Control_FontItalicLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontItalicLabel
----
*Пример использования*:
[code]
контрол::FontItalicLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicLabel

 Tkw_StyleEditorFont_Control_FontItalicLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontItalicLabel
----
*Пример использования*:
[code]
контрол::FontItalicLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push

 Tkw_StyleEditorFont_Control_FontForeColorLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontForeColorLabel
----
*Пример использования*:
[code]
контрол::FontForeColorLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorLabel

 Tkw_StyleEditorFont_Control_FontForeColorLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontForeColorLabel
----
*Пример использования*:
[code]
контрол::FontForeColorLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push

 Tkw_StyleEditorFont_Control_FontBoldLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBoldLabel
----
*Пример использования*:
[code]
контрол::FontBoldLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldLabel

 Tkw_StyleEditorFont_Control_FontBoldLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBoldLabel
----
*Пример использования*:
[code]
контрол::FontBoldLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push

 Tkw_StyleEditorFont_Control_FontBackColorLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBackColorLabel
----
*Пример использования*:
[code]
контрол::FontBackColorLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorLabel

 Tkw_StyleEditorFont_Control_FontBackColorLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBackColorLabel
----
*Пример использования*:
[code]
контрол::FontBackColorLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push

 Tkw_StyleEditorFont_Control_FontScalableLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontScalableLabel
----
*Пример использования*:
[code]
контрол::FontScalableLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableLabel

 Tkw_StyleEditorFont_Control_FontScalableLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontScalableLabel
----
*Пример использования*:
[code]
контрол::FontScalableLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push

 Tkw_StyleEditorFont_Control_FontScalableBevel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontScalableBevel
----
*Пример использования*:
[code]
контрол::FontScalableBevel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableBevel

 Tkw_StyleEditorFont_Control_FontScalableBevel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontScalableBevel
----
*Пример использования*:
[code]
контрол::FontScalableBevel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push

 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontStrikeoutInheritanceButton
----
*Пример использования*:
[code]
контрол::FontStrikeoutInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton

 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontStrikeoutInheritanceButton
----
*Пример использования*:
[code]
контрол::FontStrikeoutInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontSizeInheritanceButton
----
*Пример использования*:
[code]
контрол::FontSizeInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton

 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontSizeInheritanceButton
----
*Пример использования*:
[code]
контрол::FontSizeInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontNameInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontNameInheritanceButton
----
*Пример использования*:
[code]
контрол::FontNameInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton

 Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontNameInheritanceButton
----
*Пример использования*:
[code]
контрол::FontNameInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontItalicInheritanceButton
----
*Пример использования*:
[code]
контрол::FontItalicInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton

 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontItalicInheritanceButton
----
*Пример использования*:
[code]
контрол::FontItalicInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontForeColorInheritanceButton
----
*Пример использования*:
[code]
контрол::FontForeColorInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton

 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontForeColorInheritanceButton
----
*Пример использования*:
[code]
контрол::FontForeColorInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBoldInheritanceButton
----
*Пример использования*:
[code]
контрол::FontBoldInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton

 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBoldInheritanceButton
----
*Пример использования*:
[code]
контрол::FontBoldInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBackColorInheritanceButton
----
*Пример использования*:
[code]
контрол::FontBackColorInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton

 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBackColorInheritanceButton
----
*Пример использования*:
[code]
контрол::FontBackColorInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontUnderlineInheritanceButton
----
*Пример использования*:
[code]
контрол::FontUnderlineInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton

 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontUnderlineInheritanceButton
----
*Пример использования*:
[code]
контрол::FontUnderlineInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontUnderlineCheckBox
----
*Пример использования*:
[code]
контрол::FontUnderlineCheckBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox

 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontUnderlineCheckBox
----
*Пример использования*:
[code]
контрол::FontUnderlineCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push

 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontStrikeoutCheckBox
----
*Пример использования*:
[code]
контрол::FontStrikeoutCheckBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox

 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontStrikeoutCheckBox
----
*Пример использования*:
[code]
контрол::FontStrikeoutCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push

 Tkw_StyleEditorFont_Control_FontSizeComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontSizeComboBox
----
*Пример использования*:
[code]
контрол::FontSizeComboBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeComboBox

 Tkw_StyleEditorFont_Control_FontSizeComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontSizeComboBox
----
*Пример использования*:
[code]
контрол::FontSizeComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push

 Tkw_StyleEditorFont_Control_FontNameComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontNameComboBox
----
*Пример использования*:
[code]
контрол::FontNameComboBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontNameComboBox

 Tkw_StyleEditorFont_Control_FontNameComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontNameComboBox
----
*Пример использования*:
[code]
контрол::FontNameComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push

 Tkw_StyleEditorFont_Control_FontItalicCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontItalicCheckBox
----
*Пример использования*:
[code]
контрол::FontItalicCheckBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox

 Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontItalicCheckBox
----
*Пример использования*:
[code]
контрол::FontItalicCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push

 Tkw_StyleEditorFont_Control_FontForeColorBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontForeColorBox
----
*Пример использования*:
[code]
контрол::FontForeColorBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorBox

 Tkw_StyleEditorFont_Control_FontForeColorBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontForeColorBox
----
*Пример использования*:
[code]
контрол::FontForeColorBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push

 Tkw_StyleEditorFont_Control_FontBoldCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBoldCheckBox
----
*Пример использования*:
[code]
контрол::FontBoldCheckBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox

 Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBoldCheckBox
----
*Пример использования*:
[code]
контрол::FontBoldCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push

 Tkw_StyleEditorFont_Control_FontBackColorBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBackColorBox
----
*Пример использования*:
[code]
контрол::FontBackColorBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorBox

 Tkw_StyleEditorFont_Control_FontBackColorBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBackColorBox
----
*Пример использования*:
[code]
контрол::FontBackColorBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push

 Tkw_StyleEditorFont_Control_FontScalableCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontScalableCheckBox
----
*Пример использования*:
[code]
контрол::FontScalableCheckBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox

 Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontScalableCheckBox
----
*Пример использования*:
[code]
контрол::FontScalableCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push

 Tkw_StyleEditorFont_Control_LeftIndentLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftIndentLabel
----
*Пример использования*:
[code]
контрол::LeftIndentLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentLabel

 Tkw_StyleEditorFont_Control_LeftIndentLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftIndentLabel
----
*Пример использования*:
[code]
контрол::LeftIndentLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push

 Tkw_StyleEditorFont_Control_LeftIndentComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftIndentComboBox
----
*Пример использования*:
[code]
контрол::LeftIndentComboBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox

 Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftIndentComboBox
----
*Пример использования*:
[code]
контрол::LeftIndentComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push

 Tkw_StyleEditorFont_Control_RightIndentLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightIndentLabel
----
*Пример использования*:
[code]
контрол::RightIndentLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentLabel

 Tkw_StyleEditorFont_Control_RightIndentLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightIndentLabel
----
*Пример использования*:
[code]
контрол::RightIndentLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push

 Tkw_StyleEditorFont_Control_RightIndentComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightIndentComboBox
----
*Пример использования*:
[code]
контрол::RightIndentComboBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentComboBox

 Tkw_StyleEditorFont_Control_RightIndentComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightIndentComboBox
----
*Пример использования*:
[code]
контрол::RightIndentComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push

 Tkw_StyleEditorFont_Control_FirstIndentLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FirstIndentLabel
----
*Пример использования*:
[code]
контрол::FirstIndentLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentLabel

 Tkw_StyleEditorFont_Control_FirstIndentLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FirstIndentLabel
----
*Пример использования*:
[code]
контрол::FirstIndentLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push

 Tkw_StyleEditorFont_Control_FirstIndentComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FirstIndentComboBox
----
*Пример использования*:
[code]
контрол::FirstIndentComboBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox

 Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FirstIndentComboBox
----
*Пример использования*:
[code]
контрол::FirstIndentComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push

 Tkw_StyleEditorFont_Control_SpaceBeforeLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceBeforeLabel
----
*Пример использования*:
[code]
контрол::SpaceBeforeLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel

 Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceBeforeLabel
----
*Пример использования*:
[code]
контрол::SpaceBeforeLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push

 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceBeforeComboBox
----
*Пример использования*:
[code]
контрол::SpaceBeforeComboBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox

 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceBeforeComboBox
----
*Пример использования*:
[code]
контрол::SpaceBeforeComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push

 Tkw_StyleEditorFont_Control_SpaceAfterLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceAfterLabel
----
*Пример использования*:
[code]
контрол::SpaceAfterLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel

 Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceAfterLabel
----
*Пример использования*:
[code]
контрол::SpaceAfterLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push

 Tkw_StyleEditorFont_Control_SpaceAfterComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceAfterComboBox
----
*Пример использования*:
[code]
контрол::SpaceAfterComboBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox

 Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceAfterComboBox
----
*Пример использования*:
[code]
контрол::SpaceAfterComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push

 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::LeftIndentInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton

 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::LeftIndentInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push

 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::RightIndentInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton

 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::RightIndentInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FirstIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::FirstIndentInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton

 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FirstIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::FirstIndentInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push

 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceBeforeInheritanceButton
----
*Пример использования*:
[code]
контрол::SpaceBeforeInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton

 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceBeforeInheritanceButton
----
*Пример использования*:
[code]
контрол::SpaceBeforeInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push

 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceAfterInheritanceButton
----
*Пример использования*:
[code]
контрол::SpaceAfterInheritanceButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton

 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceAfterInheritanceButton
----
*Пример использования*:
[code]
контрол::SpaceAfterInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push

 Tkw_StyleEditorFont_Control_StyleCaptionLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StyleCaptionLabel
----
*Пример использования*:
[code]
контрол::StyleCaptionLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel

 Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола StyleCaptionLabel
----
*Пример использования*:
[code]
контрол::StyleCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push

 Tkw_StyleEditorFont_Control_StyleCaptionComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StyleCaptionComboBox
----
*Пример использования*:
[code]
контрол::StyleCaptionComboBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox

 Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола StyleCaptionComboBox
----
*Пример использования*:
[code]
контрол::StyleCaptionComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push

 TkwStyleEditorFontFormFontScrollBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontScrollBox
[panel]Контрол FontScrollBox формы TStyleEditorFontForm[panel]
*Тип результата:* TScrollBox
*Пример:*
[code]
OBJECT VAR l_TScrollBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontScrollBox >>> l_TScrollBox
[code]  }
  private
   function FontScrollBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TScrollBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontScrollBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FontUnderlineLabel
[panel]Контрол FontUnderlineLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontUnderlineLabel >>> l_TvtLabel
[code]  }
  private
   function FontUnderlineLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontStrikeoutLabel
[panel]Контрол FontStrikeoutLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontStrikeoutLabel >>> l_TvtLabel
[code]  }
  private
   function FontStrikeoutLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontSizeLabel
[panel]Контрол FontSizeLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontSizeLabel >>> l_TvtLabel
[code]  }
  private
   function FontSizeLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontNameLabel
[panel]Контрол FontNameLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontNameLabel >>> l_TvtLabel
[code]  }
  private
   function FontNameLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontNameLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontItalicLabel
[panel]Контрол FontItalicLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontItalicLabel >>> l_TvtLabel
[code]  }
  private
   function FontItalicLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontForeColorLabel
[panel]Контрол FontForeColorLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontForeColorLabel >>> l_TvtLabel
[code]  }
  private
   function FontForeColorLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontBoldLabel
[panel]Контрол FontBoldLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontBoldLabel >>> l_TvtLabel
[code]  }
  private
   function FontBoldLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontBackColorLabel
[panel]Контрол FontBackColorLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontBackColorLabel >>> l_TvtLabel
[code]  }
  private
   function FontBackColorLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontScalableLabel
[panel]Контрол FontScalableLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontScalableLabel >>> l_TvtLabel
[code]  }
  private
   function FontScalableLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontScalableBevel
[panel]Контрол FontScalableBevel формы TStyleEditorFontForm[panel]
*Тип результата:* TBevel
*Пример:*
[code]
OBJECT VAR l_TBevel
 aStyleEditorFontForm .TStyleEditorFontForm.FontScalableBevel >>> l_TBevel
[code]  }
  private
   function FontScalableBevel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TBevel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableBevel }
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
  {* Слово скрипта .TStyleEditorFontForm.FontStrikeoutInheritanceButton
[panel]Контрол FontStrikeoutInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontStrikeoutInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontStrikeoutInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.FontSizeInheritanceButton
[panel]Контрол FontSizeInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontSizeInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontSizeInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.FontNameInheritanceButton
[panel]Контрол FontNameInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontNameInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontNameInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontNameInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.FontItalicInheritanceButton
[panel]Контрол FontItalicInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontItalicInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontItalicInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.FontForeColorInheritanceButton
[panel]Контрол FontForeColorInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontForeColorInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontForeColorInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.FontBoldInheritanceButton
[panel]Контрол FontBoldInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontBoldInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontBoldInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.FontBackColorInheritanceButton
[panel]Контрол FontBackColorInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontBackColorInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontBackColorInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.FontUnderlineInheritanceButton
[panel]Контрол FontUnderlineInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontUnderlineInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FontUnderlineInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.FontUnderlineCheckBox
[panel]Контрол FontUnderlineCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontUnderlineCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontUnderlineCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineCheckBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FontStrikeoutCheckBox
[panel]Контрол FontStrikeoutCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontStrikeoutCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontStrikeoutCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutCheckBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FontSizeComboBox
[panel]Контрол FontSizeComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.FontSizeComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function FontSizeComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeComboBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FontNameComboBox
[panel]Контрол FontNameComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.FontNameComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function FontNameComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontNameComboBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FontItalicCheckBox
[panel]Контрол FontItalicCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontItalicCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontItalicCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicCheckBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FontForeColorBox
[panel]Контрол FontForeColorBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtColorBox
*Пример:*
[code]
OBJECT VAR l_TvtColorBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontForeColorBox >>> l_TvtColorBox
[code]  }
  private
   function FontForeColorBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FontBoldCheckBox
[panel]Контрол FontBoldCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontBoldCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontBoldCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldCheckBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FontBackColorBox
[panel]Контрол FontBackColorBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtColorBox
*Пример:*
[code]
OBJECT VAR l_TvtColorBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontBackColorBox >>> l_TvtColorBox
[code]  }
  private
   function FontBackColorBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FontScalableCheckBox
[panel]Контрол FontScalableCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontScalableCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function FontScalableCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableCheckBox }
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
  {* Слово скрипта .TStyleEditorFontForm.LeftIndentLabel
[panel]Контрол LeftIndentLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.LeftIndentLabel >>> l_TvtLabel
[code]  }
  private
   function LeftIndentLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.LeftIndentComboBox
[panel]Контрол LeftIndentComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.LeftIndentComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function LeftIndentComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentComboBox }
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
  {* Слово скрипта .TStyleEditorFontForm.RightIndentLabel
[panel]Контрол RightIndentLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.RightIndentLabel >>> l_TvtLabel
[code]  }
  private
   function RightIndentLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.RightIndentComboBox
[panel]Контрол RightIndentComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.RightIndentComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function RightIndentComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentComboBox }
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
  {* Слово скрипта .TStyleEditorFontForm.FirstIndentLabel
[panel]Контрол FirstIndentLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FirstIndentLabel >>> l_TvtLabel
[code]  }
  private
   function FirstIndentLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.FirstIndentComboBox
[panel]Контрол FirstIndentComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.FirstIndentComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function FirstIndentComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentComboBox }
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
  {* Слово скрипта .TStyleEditorFontForm.SpaceBeforeLabel
[panel]Контрол SpaceBeforeLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceBeforeLabel >>> l_TvtLabel
[code]  }
  private
   function SpaceBeforeLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.SpaceBeforeComboBox
[panel]Контрол SpaceBeforeComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceBeforeComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function SpaceBeforeComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeComboBox }
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
  {* Слово скрипта .TStyleEditorFontForm.SpaceAfterLabel
[panel]Контрол SpaceAfterLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceAfterLabel >>> l_TvtLabel
[code]  }
  private
   function SpaceAfterLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.SpaceAfterComboBox
[panel]Контрол SpaceAfterComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceAfterComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function SpaceAfterComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterComboBox }
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
  {* Слово скрипта .TStyleEditorFontForm.LeftIndentInheritanceButton
[panel]Контрол LeftIndentInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.LeftIndentInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function LeftIndentInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.RightIndentInheritanceButton
[panel]Контрол RightIndentInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.RightIndentInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function RightIndentInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.FirstIndentInheritanceButton
[panel]Контрол FirstIndentInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FirstIndentInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function FirstIndentInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.SpaceBeforeInheritanceButton
[panel]Контрол SpaceBeforeInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceBeforeInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function SpaceBeforeInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.SpaceAfterInheritanceButton
[panel]Контрол SpaceAfterInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceAfterInheritanceButton >>> l_TElPopupButton
[code]  }
  private
   function SpaceAfterInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterInheritanceButton }
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
  {* Слово скрипта .TStyleEditorFontForm.StyleCaptionLabel
[panel]Контрол StyleCaptionLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.StyleCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function StyleCaptionLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionLabel }
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
  {* Слово скрипта .TStyleEditorFontForm.StyleCaptionComboBox
[panel]Контрол StyleCaptionComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.StyleCaptionComboBox >>> l_TvtComboBoxQS
[code]  }
  private
   function StyleCaptionComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionComboBox }
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

class function Tkw_Form_StyleEditorFont.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::StyleEditorFont';
end;//Tkw_Form_StyleEditorFont.GetWordNameForRegister

function Tkw_Form_StyleEditorFont.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_836B40A3388B_var*
//#UC END# *4DDFD2EA0116_836B40A3388B_var*
begin
//#UC START# *4DDFD2EA0116_836B40A3388B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_836B40A3388B_impl*
end;//Tkw_Form_StyleEditorFont.GetString

class function Tkw_StyleEditorFont_Control_FontScrollBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScrollBox';
end;//Tkw_StyleEditorFont_Control_FontScrollBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScrollBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DCAC84B88E17_var*
//#UC END# *4DDFD2EA0116_DCAC84B88E17_var*
begin
//#UC START# *4DDFD2EA0116_DCAC84B88E17_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DCAC84B88E17_impl*
end;//Tkw_StyleEditorFont_Control_FontScrollBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontScrollBox.RegisterInEngine;
//#UC START# *52A086150180_DCAC84B88E17_var*
//#UC END# *52A086150180_DCAC84B88E17_var*
begin
//#UC START# *52A086150180_DCAC84B88E17_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DCAC84B88E17_impl*
end;//Tkw_StyleEditorFont_Control_FontScrollBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontScrollBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1DBD7BDD5568_var*
//#UC END# *4DAEEDE10285_1DBD7BDD5568_var*
begin
//#UC START# *4DAEEDE10285_1DBD7BDD5568_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1DBD7BDD5568_impl*
end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScrollBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScrollBox:push';
end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontUnderlineLabel';
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E502A927083E_var*
//#UC END# *4DDFD2EA0116_E502A927083E_var*
begin
//#UC START# *4DDFD2EA0116_E502A927083E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E502A927083E_impl*
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontUnderlineLabel.RegisterInEngine;
//#UC START# *52A086150180_E502A927083E_var*
//#UC END# *52A086150180_E502A927083E_var*
begin
//#UC START# *52A086150180_E502A927083E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E502A927083E_impl*
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1C99D1E380F2_var*
//#UC END# *4DAEEDE10285_1C99D1E380F2_var*
begin
//#UC START# *4DAEEDE10285_1C99D1E380F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C99D1E380F2_impl*
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontUnderlineLabel:push';
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontStrikeoutLabel';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F6E0660D952E_var*
//#UC END# *4DDFD2EA0116_F6E0660D952E_var*
begin
//#UC START# *4DDFD2EA0116_F6E0660D952E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F6E0660D952E_impl*
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontStrikeoutLabel.RegisterInEngine;
//#UC START# *52A086150180_F6E0660D952E_var*
//#UC END# *52A086150180_F6E0660D952E_var*
begin
//#UC START# *52A086150180_F6E0660D952E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F6E0660D952E_impl*
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_771F6398352A_var*
//#UC END# *4DAEEDE10285_771F6398352A_var*
begin
//#UC START# *4DAEEDE10285_771F6398352A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_771F6398352A_impl*
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontStrikeoutLabel:push';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontSizeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontSizeLabel';
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontSizeLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4C23F349EDBB_var*
//#UC END# *4DDFD2EA0116_4C23F349EDBB_var*
begin
//#UC START# *4DDFD2EA0116_4C23F349EDBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4C23F349EDBB_impl*
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontSizeLabel.RegisterInEngine;
//#UC START# *52A086150180_4C23F349EDBB_var*
//#UC END# *52A086150180_4C23F349EDBB_var*
begin
//#UC START# *52A086150180_4C23F349EDBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4C23F349EDBB_impl*
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontSizeLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C2550EAB57A1_var*
//#UC END# *4DAEEDE10285_C2550EAB57A1_var*
begin
//#UC START# *4DAEEDE10285_C2550EAB57A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C2550EAB57A1_impl*
end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontSizeLabel:push';
end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontNameLabel';
end;//Tkw_StyleEditorFont_Control_FontNameLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontNameLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1CE09F566A22_var*
//#UC END# *4DDFD2EA0116_1CE09F566A22_var*
begin
//#UC START# *4DDFD2EA0116_1CE09F566A22_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1CE09F566A22_impl*
end;//Tkw_StyleEditorFont_Control_FontNameLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontNameLabel.RegisterInEngine;
//#UC START# *52A086150180_1CE09F566A22_var*
//#UC END# *52A086150180_1CE09F566A22_var*
begin
//#UC START# *52A086150180_1CE09F566A22_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1CE09F566A22_impl*
end;//Tkw_StyleEditorFont_Control_FontNameLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ADCEECA6BC83_var*
//#UC END# *4DAEEDE10285_ADCEECA6BC83_var*
begin
//#UC START# *4DAEEDE10285_ADCEECA6BC83_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ADCEECA6BC83_impl*
end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontNameLabel:push';
end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontItalicLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontItalicLabel';
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontItalicLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6163F7E478D8_var*
//#UC END# *4DDFD2EA0116_6163F7E478D8_var*
begin
//#UC START# *4DDFD2EA0116_6163F7E478D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6163F7E478D8_impl*
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontItalicLabel.RegisterInEngine;
//#UC START# *52A086150180_6163F7E478D8_var*
//#UC END# *52A086150180_6163F7E478D8_var*
begin
//#UC START# *52A086150180_6163F7E478D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6163F7E478D8_impl*
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontItalicLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4BC413040C1C_var*
//#UC END# *4DAEEDE10285_4BC413040C1C_var*
begin
//#UC START# *4DAEEDE10285_4BC413040C1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4BC413040C1C_impl*
end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontItalicLabel:push';
end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontForeColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontForeColorLabel';
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontForeColorLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DC182DD0651E_var*
//#UC END# *4DDFD2EA0116_DC182DD0651E_var*
begin
//#UC START# *4DDFD2EA0116_DC182DD0651E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DC182DD0651E_impl*
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontForeColorLabel.RegisterInEngine;
//#UC START# *52A086150180_DC182DD0651E_var*
//#UC END# *52A086150180_DC182DD0651E_var*
begin
//#UC START# *52A086150180_DC182DD0651E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DC182DD0651E_impl*
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BACAFF564190_var*
//#UC END# *4DAEEDE10285_BACAFF564190_var*
begin
//#UC START# *4DAEEDE10285_BACAFF564190_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BACAFF564190_impl*
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontForeColorLabel:push';
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontBoldLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBoldLabel';
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBoldLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9467ACC29310_var*
//#UC END# *4DDFD2EA0116_9467ACC29310_var*
begin
//#UC START# *4DDFD2EA0116_9467ACC29310_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9467ACC29310_impl*
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontBoldLabel.RegisterInEngine;
//#UC START# *52A086150180_9467ACC29310_var*
//#UC END# *52A086150180_9467ACC29310_var*
begin
//#UC START# *52A086150180_9467ACC29310_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9467ACC29310_impl*
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontBoldLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B8D1937BF947_var*
//#UC END# *4DAEEDE10285_B8D1937BF947_var*
begin
//#UC START# *4DAEEDE10285_B8D1937BF947_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B8D1937BF947_impl*
end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBoldLabel:push';
end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontBackColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBackColorLabel';
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBackColorLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7551E81F6617_var*
//#UC END# *4DDFD2EA0116_7551E81F6617_var*
begin
//#UC START# *4DDFD2EA0116_7551E81F6617_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7551E81F6617_impl*
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontBackColorLabel.RegisterInEngine;
//#UC START# *52A086150180_7551E81F6617_var*
//#UC END# *52A086150180_7551E81F6617_var*
begin
//#UC START# *52A086150180_7551E81F6617_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7551E81F6617_impl*
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B729D8B965BD_var*
//#UC END# *4DAEEDE10285_B729D8B965BD_var*
begin
//#UC START# *4DAEEDE10285_B729D8B965BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B729D8B965BD_impl*
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBackColorLabel:push';
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontScalableLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScalableLabel';
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScalableLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6E64D54AFA44_var*
//#UC END# *4DDFD2EA0116_6E64D54AFA44_var*
begin
//#UC START# *4DDFD2EA0116_6E64D54AFA44_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6E64D54AFA44_impl*
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontScalableLabel.RegisterInEngine;
//#UC START# *52A086150180_6E64D54AFA44_var*
//#UC END# *52A086150180_6E64D54AFA44_var*
begin
//#UC START# *52A086150180_6E64D54AFA44_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6E64D54AFA44_impl*
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontScalableLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DA46B4447652_var*
//#UC END# *4DAEEDE10285_DA46B4447652_var*
begin
//#UC START# *4DAEEDE10285_DA46B4447652_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DA46B4447652_impl*
end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScalableLabel:push';
end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontScalableBevel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScalableBevel';
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScalableBevel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4C5441B5BC17_var*
//#UC END# *4DDFD2EA0116_4C5441B5BC17_var*
begin
//#UC START# *4DDFD2EA0116_4C5441B5BC17_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4C5441B5BC17_impl*
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.GetString

class procedure Tkw_StyleEditorFont_Control_FontScalableBevel.RegisterInEngine;
//#UC START# *52A086150180_4C5441B5BC17_var*
//#UC END# *52A086150180_4C5441B5BC17_var*
begin
//#UC START# *52A086150180_4C5441B5BC17_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4C5441B5BC17_impl*
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontScalableBevel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1B7B7FC28B1E_var*
//#UC END# *4DAEEDE10285_1B7B7FC28B1E_var*
begin
//#UC START# *4DAEEDE10285_1B7B7FC28B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1B7B7FC28B1E_impl*
end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableBevel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScalableBevel:push';
end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontStrikeoutInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_87BCB708A6CD_var*
//#UC END# *4DDFD2EA0116_87BCB708A6CD_var*
begin
//#UC START# *4DDFD2EA0116_87BCB708A6CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_87BCB708A6CD_impl*
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_87BCB708A6CD_var*
//#UC END# *52A086150180_87BCB708A6CD_var*
begin
//#UC START# *52A086150180_87BCB708A6CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_87BCB708A6CD_impl*
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E7AB729BF774_var*
//#UC END# *4DAEEDE10285_E7AB729BF774_var*
begin
//#UC START# *4DAEEDE10285_E7AB729BF774_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E7AB729BF774_impl*
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontStrikeoutInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontSizeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_157370617DBE_var*
//#UC END# *4DDFD2EA0116_157370617DBE_var*
begin
//#UC START# *4DDFD2EA0116_157370617DBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_157370617DBE_impl*
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_157370617DBE_var*
//#UC END# *52A086150180_157370617DBE_var*
begin
//#UC START# *52A086150180_157370617DBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_157370617DBE_impl*
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F59CE8C86100_var*
//#UC END# *4DAEEDE10285_F59CE8C86100_var*
begin
//#UC START# *4DAEEDE10285_F59CE8C86100_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F59CE8C86100_impl*
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontSizeInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontNameInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0BBD5700D495_var*
//#UC END# *4DDFD2EA0116_0BBD5700D495_var*
begin
//#UC START# *4DDFD2EA0116_0BBD5700D495_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0BBD5700D495_impl*
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontNameInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_0BBD5700D495_var*
//#UC END# *52A086150180_0BBD5700D495_var*
begin
//#UC START# *52A086150180_0BBD5700D495_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0BBD5700D495_impl*
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5ACF0BDC9B03_var*
//#UC END# *4DAEEDE10285_5ACF0BDC9B03_var*
begin
//#UC START# *4DAEEDE10285_5ACF0BDC9B03_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5ACF0BDC9B03_impl*
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontNameInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontItalicInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E4703BAD633D_var*
//#UC END# *4DDFD2EA0116_E4703BAD633D_var*
begin
//#UC START# *4DDFD2EA0116_E4703BAD633D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E4703BAD633D_impl*
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_E4703BAD633D_var*
//#UC END# *52A086150180_E4703BAD633D_var*
begin
//#UC START# *52A086150180_E4703BAD633D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E4703BAD633D_impl*
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C0628748BEE7_var*
//#UC END# *4DAEEDE10285_C0628748BEE7_var*
begin
//#UC START# *4DAEEDE10285_C0628748BEE7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C0628748BEE7_impl*
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontItalicInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontForeColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3D37D2F0F74D_var*
//#UC END# *4DDFD2EA0116_3D37D2F0F74D_var*
begin
//#UC START# *4DDFD2EA0116_3D37D2F0F74D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3D37D2F0F74D_impl*
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_3D37D2F0F74D_var*
//#UC END# *52A086150180_3D37D2F0F74D_var*
begin
//#UC START# *52A086150180_3D37D2F0F74D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3D37D2F0F74D_impl*
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B4F9F3B82638_var*
//#UC END# *4DAEEDE10285_B4F9F3B82638_var*
begin
//#UC START# *4DAEEDE10285_B4F9F3B82638_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B4F9F3B82638_impl*
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontForeColorInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBoldInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3AAB2C6EA25E_var*
//#UC END# *4DDFD2EA0116_3AAB2C6EA25E_var*
begin
//#UC START# *4DDFD2EA0116_3AAB2C6EA25E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3AAB2C6EA25E_impl*
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_3AAB2C6EA25E_var*
//#UC END# *52A086150180_3AAB2C6EA25E_var*
begin
//#UC START# *52A086150180_3AAB2C6EA25E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3AAB2C6EA25E_impl*
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C1D87729A506_var*
//#UC END# *4DAEEDE10285_C1D87729A506_var*
begin
//#UC START# *4DAEEDE10285_C1D87729A506_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C1D87729A506_impl*
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBoldInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBackColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_780AD9890AB5_var*
//#UC END# *4DDFD2EA0116_780AD9890AB5_var*
begin
//#UC START# *4DDFD2EA0116_780AD9890AB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_780AD9890AB5_impl*
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_780AD9890AB5_var*
//#UC END# *52A086150180_780AD9890AB5_var*
begin
//#UC START# *52A086150180_780AD9890AB5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_780AD9890AB5_impl*
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1791333715F9_var*
//#UC END# *4DAEEDE10285_1791333715F9_var*
begin
//#UC START# *4DAEEDE10285_1791333715F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1791333715F9_impl*
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBackColorInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontUnderlineInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8DD5C2755FBB_var*
//#UC END# *4DDFD2EA0116_8DD5C2755FBB_var*
begin
//#UC START# *4DDFD2EA0116_8DD5C2755FBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8DD5C2755FBB_impl*
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_8DD5C2755FBB_var*
//#UC END# *52A086150180_8DD5C2755FBB_var*
begin
//#UC START# *52A086150180_8DD5C2755FBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8DD5C2755FBB_impl*
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_97E134CE280B_var*
//#UC END# *4DAEEDE10285_97E134CE280B_var*
begin
//#UC START# *4DAEEDE10285_97E134CE280B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_97E134CE280B_impl*
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontUnderlineInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontUnderlineCheckBox';
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B9B73040F3B7_var*
//#UC END# *4DDFD2EA0116_B9B73040F3B7_var*
begin
//#UC START# *4DDFD2EA0116_B9B73040F3B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B9B73040F3B7_impl*
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.RegisterInEngine;
//#UC START# *52A086150180_B9B73040F3B7_var*
//#UC END# *52A086150180_B9B73040F3B7_var*
begin
//#UC START# *52A086150180_B9B73040F3B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B9B73040F3B7_impl*
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A153B48FADDB_var*
//#UC END# *4DAEEDE10285_A153B48FADDB_var*
begin
//#UC START# *4DAEEDE10285_A153B48FADDB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A153B48FADDB_impl*
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontUnderlineCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontStrikeoutCheckBox';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2A3F957BB471_var*
//#UC END# *4DDFD2EA0116_2A3F957BB471_var*
begin
//#UC START# *4DDFD2EA0116_2A3F957BB471_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2A3F957BB471_impl*
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.RegisterInEngine;
//#UC START# *52A086150180_2A3F957BB471_var*
//#UC END# *52A086150180_2A3F957BB471_var*
begin
//#UC START# *52A086150180_2A3F957BB471_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2A3F957BB471_impl*
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_281DB890EA72_var*
//#UC END# *4DAEEDE10285_281DB890EA72_var*
begin
//#UC START# *4DAEEDE10285_281DB890EA72_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_281DB890EA72_impl*
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontStrikeoutCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontSizeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontSizeComboBox';
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontSizeComboBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_230D11954194_var*
//#UC END# *4DDFD2EA0116_230D11954194_var*
begin
//#UC START# *4DDFD2EA0116_230D11954194_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_230D11954194_impl*
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontSizeComboBox.RegisterInEngine;
//#UC START# *52A086150180_230D11954194_var*
//#UC END# *52A086150180_230D11954194_var*
begin
//#UC START# *52A086150180_230D11954194_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_230D11954194_impl*
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_935D3B09FFCD_var*
//#UC END# *4DAEEDE10285_935D3B09FFCD_var*
begin
//#UC START# *4DAEEDE10285_935D3B09FFCD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_935D3B09FFCD_impl*
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontSizeComboBox:push';
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontNameComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontNameComboBox';
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontNameComboBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0074495E300D_var*
//#UC END# *4DDFD2EA0116_0074495E300D_var*
begin
//#UC START# *4DDFD2EA0116_0074495E300D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0074495E300D_impl*
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontNameComboBox.RegisterInEngine;
//#UC START# *52A086150180_0074495E300D_var*
//#UC END# *52A086150180_0074495E300D_var*
begin
//#UC START# *52A086150180_0074495E300D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0074495E300D_impl*
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontNameComboBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BAE036CA2093_var*
//#UC END# *4DAEEDE10285_BAE036CA2093_var*
begin
//#UC START# *4DAEEDE10285_BAE036CA2093_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BAE036CA2093_impl*
end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontNameComboBox:push';
end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontItalicCheckBox';
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_09EDF91734E2_var*
//#UC END# *4DDFD2EA0116_09EDF91734E2_var*
begin
//#UC START# *4DDFD2EA0116_09EDF91734E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_09EDF91734E2_impl*
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontItalicCheckBox.RegisterInEngine;
//#UC START# *52A086150180_09EDF91734E2_var*
//#UC END# *52A086150180_09EDF91734E2_var*
begin
//#UC START# *52A086150180_09EDF91734E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_09EDF91734E2_impl*
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_98E7193D983B_var*
//#UC END# *4DAEEDE10285_98E7193D983B_var*
begin
//#UC START# *4DAEEDE10285_98E7193D983B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_98E7193D983B_impl*
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontItalicCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontForeColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontForeColorBox';
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontForeColorBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F818780F8953_var*
//#UC END# *4DDFD2EA0116_F818780F8953_var*
begin
//#UC START# *4DDFD2EA0116_F818780F8953_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F818780F8953_impl*
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontForeColorBox.RegisterInEngine;
//#UC START# *52A086150180_F818780F8953_var*
//#UC END# *52A086150180_F818780F8953_var*
begin
//#UC START# *52A086150180_F818780F8953_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F818780F8953_impl*
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontForeColorBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EA4A4CFDE3FB_var*
//#UC END# *4DAEEDE10285_EA4A4CFDE3FB_var*
begin
//#UC START# *4DAEEDE10285_EA4A4CFDE3FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EA4A4CFDE3FB_impl*
end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontForeColorBox:push';
end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBoldCheckBox';
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2A3666BA712B_var*
//#UC END# *4DDFD2EA0116_2A3666BA712B_var*
begin
//#UC START# *4DDFD2EA0116_2A3666BA712B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2A3666BA712B_impl*
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontBoldCheckBox.RegisterInEngine;
//#UC START# *52A086150180_2A3666BA712B_var*
//#UC END# *52A086150180_2A3666BA712B_var*
begin
//#UC START# *52A086150180_2A3666BA712B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2A3666BA712B_impl*
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C0C59160AB9E_var*
//#UC END# *4DAEEDE10285_C0C59160AB9E_var*
begin
//#UC START# *4DAEEDE10285_C0C59160AB9E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C0C59160AB9E_impl*
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBoldCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontBackColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBackColorBox';
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBackColorBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_815F16E8084A_var*
//#UC END# *4DDFD2EA0116_815F16E8084A_var*
begin
//#UC START# *4DDFD2EA0116_815F16E8084A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_815F16E8084A_impl*
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontBackColorBox.RegisterInEngine;
//#UC START# *52A086150180_815F16E8084A_var*
//#UC END# *52A086150180_815F16E8084A_var*
begin
//#UC START# *52A086150180_815F16E8084A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_815F16E8084A_impl*
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontBackColorBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_77841F020249_var*
//#UC END# *4DAEEDE10285_77841F020249_var*
begin
//#UC START# *4DAEEDE10285_77841F020249_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_77841F020249_impl*
end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBackColorBox:push';
end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScalableCheckBox';
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2B5EB4985067_var*
//#UC END# *4DDFD2EA0116_2B5EB4985067_var*
begin
//#UC START# *4DDFD2EA0116_2B5EB4985067_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2B5EB4985067_impl*
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontScalableCheckBox.RegisterInEngine;
//#UC START# *52A086150180_2B5EB4985067_var*
//#UC END# *52A086150180_2B5EB4985067_var*
begin
//#UC START# *52A086150180_2B5EB4985067_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2B5EB4985067_impl*
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4168A3C61761_var*
//#UC END# *4DAEEDE10285_4168A3C61761_var*
begin
//#UC START# *4DAEEDE10285_4168A3C61761_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4168A3C61761_impl*
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScalableCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_LeftIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftIndentLabel';
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_LeftIndentLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E23E837C8E9E_var*
//#UC END# *4DDFD2EA0116_E23E837C8E9E_var*
begin
//#UC START# *4DDFD2EA0116_E23E837C8E9E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E23E837C8E9E_impl*
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.GetString

class procedure Tkw_StyleEditorFont_Control_LeftIndentLabel.RegisterInEngine;
//#UC START# *52A086150180_E23E837C8E9E_var*
//#UC END# *52A086150180_E23E837C8E9E_var*
begin
//#UC START# *52A086150180_E23E837C8E9E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E23E837C8E9E_impl*
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8765425650CD_var*
//#UC END# *4DAEEDE10285_8765425650CD_var*
begin
//#UC START# *4DAEEDE10285_8765425650CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8765425650CD_impl*
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftIndentLabel:push';
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftIndentComboBox';
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5C8A1E9C6095_var*
//#UC END# *4DDFD2EA0116_5C8A1E9C6095_var*
begin
//#UC START# *4DDFD2EA0116_5C8A1E9C6095_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5C8A1E9C6095_impl*
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_LeftIndentComboBox.RegisterInEngine;
//#UC START# *52A086150180_5C8A1E9C6095_var*
//#UC END# *52A086150180_5C8A1E9C6095_var*
begin
//#UC START# *52A086150180_5C8A1E9C6095_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5C8A1E9C6095_impl*
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5450EFA51FB1_var*
//#UC END# *4DAEEDE10285_5450EFA51FB1_var*
begin
//#UC START# *4DAEEDE10285_5450EFA51FB1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5450EFA51FB1_impl*
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftIndentComboBox:push';
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_RightIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightIndentLabel';
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_RightIndentLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1AA090CAC290_var*
//#UC END# *4DDFD2EA0116_1AA090CAC290_var*
begin
//#UC START# *4DDFD2EA0116_1AA090CAC290_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1AA090CAC290_impl*
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.GetString

class procedure Tkw_StyleEditorFont_Control_RightIndentLabel.RegisterInEngine;
//#UC START# *52A086150180_1AA090CAC290_var*
//#UC END# *52A086150180_1AA090CAC290_var*
begin
//#UC START# *52A086150180_1AA090CAC290_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1AA090CAC290_impl*
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_RightIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5833EAD4BC79_var*
//#UC END# *4DAEEDE10285_5833EAD4BC79_var*
begin
//#UC START# *4DAEEDE10285_5833EAD4BC79_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5833EAD4BC79_impl*
end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightIndentLabel:push';
end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_RightIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightIndentComboBox';
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_RightIndentComboBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F31921EF9610_var*
//#UC END# *4DDFD2EA0116_F31921EF9610_var*
begin
//#UC START# *4DDFD2EA0116_F31921EF9610_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F31921EF9610_impl*
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_RightIndentComboBox.RegisterInEngine;
//#UC START# *52A086150180_F31921EF9610_var*
//#UC END# *52A086150180_F31921EF9610_var*
begin
//#UC START# *52A086150180_F31921EF9610_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F31921EF9610_impl*
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52B2566FDE4F_var*
//#UC END# *4DAEEDE10285_52B2566FDE4F_var*
begin
//#UC START# *4DAEEDE10285_52B2566FDE4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_52B2566FDE4F_impl*
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightIndentComboBox:push';
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FirstIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstIndentLabel';
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FirstIndentLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D73D6456A262_var*
//#UC END# *4DDFD2EA0116_D73D6456A262_var*
begin
//#UC START# *4DDFD2EA0116_D73D6456A262_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D73D6456A262_impl*
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FirstIndentLabel.RegisterInEngine;
//#UC START# *52A086150180_D73D6456A262_var*
//#UC END# *52A086150180_D73D6456A262_var*
begin
//#UC START# *52A086150180_D73D6456A262_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D73D6456A262_impl*
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ABE01F59B4C2_var*
//#UC END# *4DAEEDE10285_ABE01F59B4C2_var*
begin
//#UC START# *4DAEEDE10285_ABE01F59B4C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ABE01F59B4C2_impl*
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstIndentLabel:push';
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstIndentComboBox';
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7169692D9230_var*
//#UC END# *4DDFD2EA0116_7169692D9230_var*
begin
//#UC START# *4DDFD2EA0116_7169692D9230_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7169692D9230_impl*
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_FirstIndentComboBox.RegisterInEngine;
//#UC START# *52A086150180_7169692D9230_var*
//#UC END# *52A086150180_7169692D9230_var*
begin
//#UC START# *52A086150180_7169692D9230_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7169692D9230_impl*
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9C2AFCFE1C6A_var*
//#UC END# *4DAEEDE10285_9C2AFCFE1C6A_var*
begin
//#UC START# *4DAEEDE10285_9C2AFCFE1C6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9C2AFCFE1C6A_impl*
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstIndentComboBox:push';
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceBeforeLabel';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_06C84028E4CB_var*
//#UC END# *4DDFD2EA0116_06C84028E4CB_var*
begin
//#UC START# *4DDFD2EA0116_06C84028E4CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_06C84028E4CB_impl*
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceBeforeLabel.RegisterInEngine;
//#UC START# *52A086150180_06C84028E4CB_var*
//#UC END# *52A086150180_06C84028E4CB_var*
begin
//#UC START# *52A086150180_06C84028E4CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_06C84028E4CB_impl*
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E11311671385_var*
//#UC END# *4DAEEDE10285_E11311671385_var*
begin
//#UC START# *4DAEEDE10285_E11311671385_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E11311671385_impl*
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceBeforeLabel:push';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceBeforeComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A12948763368_var*
//#UC END# *4DDFD2EA0116_A12948763368_var*
begin
//#UC START# *4DDFD2EA0116_A12948763368_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A12948763368_impl*
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.RegisterInEngine;
//#UC START# *52A086150180_A12948763368_var*
//#UC END# *52A086150180_A12948763368_var*
begin
//#UC START# *52A086150180_A12948763368_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A12948763368_impl*
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D744A08289F1_var*
//#UC END# *4DAEEDE10285_D744A08289F1_var*
begin
//#UC START# *4DAEEDE10285_D744A08289F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D744A08289F1_impl*
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceBeforeComboBox:push';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceAfterLabel';
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D53C6E25BE25_var*
//#UC END# *4DDFD2EA0116_D53C6E25BE25_var*
begin
//#UC START# *4DDFD2EA0116_D53C6E25BE25_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D53C6E25BE25_impl*
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceAfterLabel.RegisterInEngine;
//#UC START# *52A086150180_D53C6E25BE25_var*
//#UC END# *52A086150180_D53C6E25BE25_var*
begin
//#UC START# *52A086150180_D53C6E25BE25_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D53C6E25BE25_impl*
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_812B0D0A9BBC_var*
//#UC END# *4DAEEDE10285_812B0D0A9BBC_var*
begin
//#UC START# *4DAEEDE10285_812B0D0A9BBC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_812B0D0A9BBC_impl*
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceAfterLabel:push';
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceAfterComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8AF7C50072B6_var*
//#UC END# *4DDFD2EA0116_8AF7C50072B6_var*
begin
//#UC START# *4DDFD2EA0116_8AF7C50072B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8AF7C50072B6_impl*
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceAfterComboBox.RegisterInEngine;
//#UC START# *52A086150180_8AF7C50072B6_var*
//#UC END# *52A086150180_8AF7C50072B6_var*
begin
//#UC START# *52A086150180_8AF7C50072B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8AF7C50072B6_impl*
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_290DF23DA32B_var*
//#UC END# *4DAEEDE10285_290DF23DA32B_var*
begin
//#UC START# *4DAEEDE10285_290DF23DA32B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_290DF23DA32B_impl*
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceAfterComboBox:push';
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BD35815862F8_var*
//#UC END# *4DDFD2EA0116_BD35815862F8_var*
begin
//#UC START# *4DDFD2EA0116_BD35815862F8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BD35815862F8_impl*
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_BD35815862F8_var*
//#UC END# *52A086150180_BD35815862F8_var*
begin
//#UC START# *52A086150180_BD35815862F8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_BD35815862F8_impl*
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FB9E99498FB2_var*
//#UC END# *4DAEEDE10285_FB9E99498FB2_var*
begin
//#UC START# *4DAEEDE10285_FB9E99498FB2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FB9E99498FB2_impl*
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftIndentInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3272C32D85E5_var*
//#UC END# *4DDFD2EA0116_3272C32D85E5_var*
begin
//#UC START# *4DDFD2EA0116_3272C32D85E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3272C32D85E5_impl*
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_3272C32D85E5_var*
//#UC END# *52A086150180_3272C32D85E5_var*
begin
//#UC START# *52A086150180_3272C32D85E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3272C32D85E5_impl*
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5AC0FA744E64_var*
//#UC END# *4DAEEDE10285_5AC0FA744E64_var*
begin
//#UC START# *4DAEEDE10285_5AC0FA744E64_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5AC0FA744E64_impl*
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightIndentInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_77C2A0F42941_var*
//#UC END# *4DDFD2EA0116_77C2A0F42941_var*
begin
//#UC START# *4DDFD2EA0116_77C2A0F42941_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_77C2A0F42941_impl*
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_77C2A0F42941_var*
//#UC END# *52A086150180_77C2A0F42941_var*
begin
//#UC START# *52A086150180_77C2A0F42941_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_77C2A0F42941_impl*
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_34DD8667F219_var*
//#UC END# *4DAEEDE10285_34DD8667F219_var*
begin
//#UC START# *4DAEEDE10285_34DD8667F219_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_34DD8667F219_impl*
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstIndentInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceBeforeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_698A4FC0106D_var*
//#UC END# *4DDFD2EA0116_698A4FC0106D_var*
begin
//#UC START# *4DDFD2EA0116_698A4FC0106D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_698A4FC0106D_impl*
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_698A4FC0106D_var*
//#UC END# *52A086150180_698A4FC0106D_var*
begin
//#UC START# *52A086150180_698A4FC0106D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_698A4FC0106D_impl*
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_36280AA18EEC_var*
//#UC END# *4DAEEDE10285_36280AA18EEC_var*
begin
//#UC START# *4DAEEDE10285_36280AA18EEC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_36280AA18EEC_impl*
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceBeforeInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceAfterInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_261E72DE741E_var*
//#UC END# *4DDFD2EA0116_261E72DE741E_var*
begin
//#UC START# *4DDFD2EA0116_261E72DE741E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_261E72DE741E_impl*
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.RegisterInEngine;
//#UC START# *52A086150180_261E72DE741E_var*
//#UC END# *52A086150180_261E72DE741E_var*
begin
//#UC START# *52A086150180_261E72DE741E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_261E72DE741E_impl*
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_854FAD6E2C9D_var*
//#UC END# *4DAEEDE10285_854FAD6E2C9D_var*
begin
//#UC START# *4DAEEDE10285_854FAD6E2C9D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_854FAD6E2C9D_impl*
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceAfterInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StyleCaptionLabel';
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A88566B3D35D_var*
//#UC END# *4DDFD2EA0116_A88566B3D35D_var*
begin
//#UC START# *4DDFD2EA0116_A88566B3D35D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A88566B3D35D_impl*
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetString

class procedure Tkw_StyleEditorFont_Control_StyleCaptionLabel.RegisterInEngine;
//#UC START# *52A086150180_A88566B3D35D_var*
//#UC END# *52A086150180_A88566B3D35D_var*
begin
//#UC START# *52A086150180_A88566B3D35D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A88566B3D35D_impl*
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AB90C98E4049_var*
//#UC END# *4DAEEDE10285_AB90C98E4049_var*
begin
//#UC START# *4DAEEDE10285_AB90C98E4049_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AB90C98E4049_impl*
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StyleCaptionLabel:push';
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.GetWordNameForRegister

class function Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StyleCaptionComboBox';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E12149FDFACF_var*
//#UC END# *4DDFD2EA0116_E12149FDFACF_var*
begin
//#UC START# *4DDFD2EA0116_E12149FDFACF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E12149FDFACF_impl*
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_StyleCaptionComboBox.RegisterInEngine;
//#UC START# *52A086150180_E12149FDFACF_var*
//#UC END# *52A086150180_E12149FDFACF_var*
begin
//#UC START# *52A086150180_E12149FDFACF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E12149FDFACF_impl*
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.RegisterInEngine

procedure Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_21B177EE9653_var*
//#UC END# *4DAEEDE10285_21B177EE9653_var*
begin
//#UC START# *4DAEEDE10285_21B177EE9653_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_21B177EE9653_impl*
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StyleCaptionComboBox:push';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.GetWordNameForRegister

function TkwStyleEditorFontFormFontScrollBox.FontScrollBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TScrollBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontScrollBox }
//#UC START# *A80B5DF8AD75_954E69BCCC58_var*
//#UC END# *A80B5DF8AD75_954E69BCCC58_var*
begin
//#UC START# *A80B5DF8AD75_954E69BCCC58_impl*
 !!! Needs to be implemented !!!
//#UC END# *A80B5DF8AD75_954E69BCCC58_impl*
end;//TkwStyleEditorFontFormFontScrollBox.FontScrollBox

procedure TkwStyleEditorFontFormFontScrollBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_954E69BCCC58_var*
//#UC END# *4DAEEDE10285_954E69BCCC58_var*
begin
//#UC START# *4DAEEDE10285_954E69BCCC58_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_954E69BCCC58_impl*
end;//TkwStyleEditorFontFormFontScrollBox.DoDoIt

class function TkwStyleEditorFontFormFontScrollBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScrollBox';
end;//TkwStyleEditorFontFormFontScrollBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontScrollBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_954E69BCCC58_var*
//#UC END# *52D00B00031A_954E69BCCC58_var*
begin
//#UC START# *52D00B00031A_954E69BCCC58_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_954E69BCCC58_impl*
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
//#UC START# *5617F4D00243_954E69BCCC58_var*
//#UC END# *5617F4D00243_954E69BCCC58_var*
begin
//#UC START# *5617F4D00243_954E69BCCC58_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_954E69BCCC58_impl*
end;//TkwStyleEditorFontFormFontScrollBox.ParamsTypes

function TkwStyleEditorFontFormFontUnderlineLabel.FontUnderlineLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineLabel }
//#UC START# *FCA7FB44C32B_9AE4A7FEB94E_var*
//#UC END# *FCA7FB44C32B_9AE4A7FEB94E_var*
begin
//#UC START# *FCA7FB44C32B_9AE4A7FEB94E_impl*
 !!! Needs to be implemented !!!
//#UC END# *FCA7FB44C32B_9AE4A7FEB94E_impl*
end;//TkwStyleEditorFontFormFontUnderlineLabel.FontUnderlineLabel

procedure TkwStyleEditorFontFormFontUnderlineLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9AE4A7FEB94E_var*
//#UC END# *4DAEEDE10285_9AE4A7FEB94E_var*
begin
//#UC START# *4DAEEDE10285_9AE4A7FEB94E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9AE4A7FEB94E_impl*
end;//TkwStyleEditorFontFormFontUnderlineLabel.DoDoIt

class function TkwStyleEditorFontFormFontUnderlineLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontUnderlineLabel';
end;//TkwStyleEditorFontFormFontUnderlineLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontUnderlineLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9AE4A7FEB94E_var*
//#UC END# *52D00B00031A_9AE4A7FEB94E_var*
begin
//#UC START# *52D00B00031A_9AE4A7FEB94E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9AE4A7FEB94E_impl*
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
//#UC START# *5617F4D00243_9AE4A7FEB94E_var*
//#UC END# *5617F4D00243_9AE4A7FEB94E_var*
begin
//#UC START# *5617F4D00243_9AE4A7FEB94E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9AE4A7FEB94E_impl*
end;//TkwStyleEditorFontFormFontUnderlineLabel.ParamsTypes

function TkwStyleEditorFontFormFontStrikeoutLabel.FontStrikeoutLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutLabel }
//#UC START# *A61B4E1174AF_D1F4E42FF5EA_var*
//#UC END# *A61B4E1174AF_D1F4E42FF5EA_var*
begin
//#UC START# *A61B4E1174AF_D1F4E42FF5EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *A61B4E1174AF_D1F4E42FF5EA_impl*
end;//TkwStyleEditorFontFormFontStrikeoutLabel.FontStrikeoutLabel

procedure TkwStyleEditorFontFormFontStrikeoutLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D1F4E42FF5EA_var*
//#UC END# *4DAEEDE10285_D1F4E42FF5EA_var*
begin
//#UC START# *4DAEEDE10285_D1F4E42FF5EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D1F4E42FF5EA_impl*
end;//TkwStyleEditorFontFormFontStrikeoutLabel.DoDoIt

class function TkwStyleEditorFontFormFontStrikeoutLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutLabel';
end;//TkwStyleEditorFontFormFontStrikeoutLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontStrikeoutLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D1F4E42FF5EA_var*
//#UC END# *52D00B00031A_D1F4E42FF5EA_var*
begin
//#UC START# *52D00B00031A_D1F4E42FF5EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D1F4E42FF5EA_impl*
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
//#UC START# *5617F4D00243_D1F4E42FF5EA_var*
//#UC END# *5617F4D00243_D1F4E42FF5EA_var*
begin
//#UC START# *5617F4D00243_D1F4E42FF5EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D1F4E42FF5EA_impl*
end;//TkwStyleEditorFontFormFontStrikeoutLabel.ParamsTypes

function TkwStyleEditorFontFormFontSizeLabel.FontSizeLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeLabel }
//#UC START# *88FAED87321F_63ABFB869758_var*
//#UC END# *88FAED87321F_63ABFB869758_var*
begin
//#UC START# *88FAED87321F_63ABFB869758_impl*
 !!! Needs to be implemented !!!
//#UC END# *88FAED87321F_63ABFB869758_impl*
end;//TkwStyleEditorFontFormFontSizeLabel.FontSizeLabel

procedure TkwStyleEditorFontFormFontSizeLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_63ABFB869758_var*
//#UC END# *4DAEEDE10285_63ABFB869758_var*
begin
//#UC START# *4DAEEDE10285_63ABFB869758_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_63ABFB869758_impl*
end;//TkwStyleEditorFontFormFontSizeLabel.DoDoIt

class function TkwStyleEditorFontFormFontSizeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontSizeLabel';
end;//TkwStyleEditorFontFormFontSizeLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontSizeLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_63ABFB869758_var*
//#UC END# *52D00B00031A_63ABFB869758_var*
begin
//#UC START# *52D00B00031A_63ABFB869758_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_63ABFB869758_impl*
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
//#UC START# *5617F4D00243_63ABFB869758_var*
//#UC END# *5617F4D00243_63ABFB869758_var*
begin
//#UC START# *5617F4D00243_63ABFB869758_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_63ABFB869758_impl*
end;//TkwStyleEditorFontFormFontSizeLabel.ParamsTypes

function TkwStyleEditorFontFormFontNameLabel.FontNameLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontNameLabel }
//#UC START# *DDA1CB49A068_02676F13E290_var*
//#UC END# *DDA1CB49A068_02676F13E290_var*
begin
//#UC START# *DDA1CB49A068_02676F13E290_impl*
 !!! Needs to be implemented !!!
//#UC END# *DDA1CB49A068_02676F13E290_impl*
end;//TkwStyleEditorFontFormFontNameLabel.FontNameLabel

procedure TkwStyleEditorFontFormFontNameLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_02676F13E290_var*
//#UC END# *4DAEEDE10285_02676F13E290_var*
begin
//#UC START# *4DAEEDE10285_02676F13E290_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_02676F13E290_impl*
end;//TkwStyleEditorFontFormFontNameLabel.DoDoIt

class function TkwStyleEditorFontFormFontNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontNameLabel';
end;//TkwStyleEditorFontFormFontNameLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_02676F13E290_var*
//#UC END# *52D00B00031A_02676F13E290_var*
begin
//#UC START# *52D00B00031A_02676F13E290_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_02676F13E290_impl*
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
//#UC START# *5617F4D00243_02676F13E290_var*
//#UC END# *5617F4D00243_02676F13E290_var*
begin
//#UC START# *5617F4D00243_02676F13E290_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_02676F13E290_impl*
end;//TkwStyleEditorFontFormFontNameLabel.ParamsTypes

function TkwStyleEditorFontFormFontItalicLabel.FontItalicLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicLabel }
//#UC START# *680B7644517E_612141A18D21_var*
//#UC END# *680B7644517E_612141A18D21_var*
begin
//#UC START# *680B7644517E_612141A18D21_impl*
 !!! Needs to be implemented !!!
//#UC END# *680B7644517E_612141A18D21_impl*
end;//TkwStyleEditorFontFormFontItalicLabel.FontItalicLabel

procedure TkwStyleEditorFontFormFontItalicLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_612141A18D21_var*
//#UC END# *4DAEEDE10285_612141A18D21_var*
begin
//#UC START# *4DAEEDE10285_612141A18D21_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_612141A18D21_impl*
end;//TkwStyleEditorFontFormFontItalicLabel.DoDoIt

class function TkwStyleEditorFontFormFontItalicLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontItalicLabel';
end;//TkwStyleEditorFontFormFontItalicLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontItalicLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_612141A18D21_var*
//#UC END# *52D00B00031A_612141A18D21_var*
begin
//#UC START# *52D00B00031A_612141A18D21_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_612141A18D21_impl*
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
//#UC START# *5617F4D00243_612141A18D21_var*
//#UC END# *5617F4D00243_612141A18D21_var*
begin
//#UC START# *5617F4D00243_612141A18D21_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_612141A18D21_impl*
end;//TkwStyleEditorFontFormFontItalicLabel.ParamsTypes

function TkwStyleEditorFontFormFontForeColorLabel.FontForeColorLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorLabel }
//#UC START# *C909CC484E71_6035EB84A365_var*
//#UC END# *C909CC484E71_6035EB84A365_var*
begin
//#UC START# *C909CC484E71_6035EB84A365_impl*
 !!! Needs to be implemented !!!
//#UC END# *C909CC484E71_6035EB84A365_impl*
end;//TkwStyleEditorFontFormFontForeColorLabel.FontForeColorLabel

procedure TkwStyleEditorFontFormFontForeColorLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6035EB84A365_var*
//#UC END# *4DAEEDE10285_6035EB84A365_var*
begin
//#UC START# *4DAEEDE10285_6035EB84A365_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6035EB84A365_impl*
end;//TkwStyleEditorFontFormFontForeColorLabel.DoDoIt

class function TkwStyleEditorFontFormFontForeColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontForeColorLabel';
end;//TkwStyleEditorFontFormFontForeColorLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontForeColorLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6035EB84A365_var*
//#UC END# *52D00B00031A_6035EB84A365_var*
begin
//#UC START# *52D00B00031A_6035EB84A365_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6035EB84A365_impl*
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
//#UC START# *5617F4D00243_6035EB84A365_var*
//#UC END# *5617F4D00243_6035EB84A365_var*
begin
//#UC START# *5617F4D00243_6035EB84A365_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6035EB84A365_impl*
end;//TkwStyleEditorFontFormFontForeColorLabel.ParamsTypes

function TkwStyleEditorFontFormFontBoldLabel.FontBoldLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldLabel }
//#UC START# *1FE77393E4E4_3CFB1098B812_var*
//#UC END# *1FE77393E4E4_3CFB1098B812_var*
begin
//#UC START# *1FE77393E4E4_3CFB1098B812_impl*
 !!! Needs to be implemented !!!
//#UC END# *1FE77393E4E4_3CFB1098B812_impl*
end;//TkwStyleEditorFontFormFontBoldLabel.FontBoldLabel

procedure TkwStyleEditorFontFormFontBoldLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3CFB1098B812_var*
//#UC END# *4DAEEDE10285_3CFB1098B812_var*
begin
//#UC START# *4DAEEDE10285_3CFB1098B812_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3CFB1098B812_impl*
end;//TkwStyleEditorFontFormFontBoldLabel.DoDoIt

class function TkwStyleEditorFontFormFontBoldLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBoldLabel';
end;//TkwStyleEditorFontFormFontBoldLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBoldLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3CFB1098B812_var*
//#UC END# *52D00B00031A_3CFB1098B812_var*
begin
//#UC START# *52D00B00031A_3CFB1098B812_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3CFB1098B812_impl*
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
//#UC START# *5617F4D00243_3CFB1098B812_var*
//#UC END# *5617F4D00243_3CFB1098B812_var*
begin
//#UC START# *5617F4D00243_3CFB1098B812_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3CFB1098B812_impl*
end;//TkwStyleEditorFontFormFontBoldLabel.ParamsTypes

function TkwStyleEditorFontFormFontBackColorLabel.FontBackColorLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorLabel }
//#UC START# *E972D56FC696_A1144EFA0C0B_var*
//#UC END# *E972D56FC696_A1144EFA0C0B_var*
begin
//#UC START# *E972D56FC696_A1144EFA0C0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *E972D56FC696_A1144EFA0C0B_impl*
end;//TkwStyleEditorFontFormFontBackColorLabel.FontBackColorLabel

procedure TkwStyleEditorFontFormFontBackColorLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A1144EFA0C0B_var*
//#UC END# *4DAEEDE10285_A1144EFA0C0B_var*
begin
//#UC START# *4DAEEDE10285_A1144EFA0C0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A1144EFA0C0B_impl*
end;//TkwStyleEditorFontFormFontBackColorLabel.DoDoIt

class function TkwStyleEditorFontFormFontBackColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBackColorLabel';
end;//TkwStyleEditorFontFormFontBackColorLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBackColorLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A1144EFA0C0B_var*
//#UC END# *52D00B00031A_A1144EFA0C0B_var*
begin
//#UC START# *52D00B00031A_A1144EFA0C0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A1144EFA0C0B_impl*
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
//#UC START# *5617F4D00243_A1144EFA0C0B_var*
//#UC END# *5617F4D00243_A1144EFA0C0B_var*
begin
//#UC START# *5617F4D00243_A1144EFA0C0B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A1144EFA0C0B_impl*
end;//TkwStyleEditorFontFormFontBackColorLabel.ParamsTypes

function TkwStyleEditorFontFormFontScalableLabel.FontScalableLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableLabel }
//#UC START# *D8B8B0B68E72_67FD049E4DDD_var*
//#UC END# *D8B8B0B68E72_67FD049E4DDD_var*
begin
//#UC START# *D8B8B0B68E72_67FD049E4DDD_impl*
 !!! Needs to be implemented !!!
//#UC END# *D8B8B0B68E72_67FD049E4DDD_impl*
end;//TkwStyleEditorFontFormFontScalableLabel.FontScalableLabel

procedure TkwStyleEditorFontFormFontScalableLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_67FD049E4DDD_var*
//#UC END# *4DAEEDE10285_67FD049E4DDD_var*
begin
//#UC START# *4DAEEDE10285_67FD049E4DDD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_67FD049E4DDD_impl*
end;//TkwStyleEditorFontFormFontScalableLabel.DoDoIt

class function TkwStyleEditorFontFormFontScalableLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScalableLabel';
end;//TkwStyleEditorFontFormFontScalableLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontScalableLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_67FD049E4DDD_var*
//#UC END# *52D00B00031A_67FD049E4DDD_var*
begin
//#UC START# *52D00B00031A_67FD049E4DDD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_67FD049E4DDD_impl*
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
//#UC START# *5617F4D00243_67FD049E4DDD_var*
//#UC END# *5617F4D00243_67FD049E4DDD_var*
begin
//#UC START# *5617F4D00243_67FD049E4DDD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_67FD049E4DDD_impl*
end;//TkwStyleEditorFontFormFontScalableLabel.ParamsTypes

function TkwStyleEditorFontFormFontScalableBevel.FontScalableBevel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TBevel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableBevel }
//#UC START# *348831C52526_2D914FF67038_var*
//#UC END# *348831C52526_2D914FF67038_var*
begin
//#UC START# *348831C52526_2D914FF67038_impl*
 !!! Needs to be implemented !!!
//#UC END# *348831C52526_2D914FF67038_impl*
end;//TkwStyleEditorFontFormFontScalableBevel.FontScalableBevel

procedure TkwStyleEditorFontFormFontScalableBevel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2D914FF67038_var*
//#UC END# *4DAEEDE10285_2D914FF67038_var*
begin
//#UC START# *4DAEEDE10285_2D914FF67038_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2D914FF67038_impl*
end;//TkwStyleEditorFontFormFontScalableBevel.DoDoIt

class function TkwStyleEditorFontFormFontScalableBevel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScalableBevel';
end;//TkwStyleEditorFontFormFontScalableBevel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontScalableBevel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_2D914FF67038_var*
//#UC END# *52D00B00031A_2D914FF67038_var*
begin
//#UC START# *52D00B00031A_2D914FF67038_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_2D914FF67038_impl*
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
//#UC START# *5617F4D00243_2D914FF67038_var*
//#UC END# *5617F4D00243_2D914FF67038_var*
begin
//#UC START# *5617F4D00243_2D914FF67038_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2D914FF67038_impl*
end;//TkwStyleEditorFontFormFontScalableBevel.ParamsTypes

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.FontStrikeoutInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutInheritanceButton }
//#UC START# *3CF1E0EADB19_E4C87096091A_var*
//#UC END# *3CF1E0EADB19_E4C87096091A_var*
begin
//#UC START# *3CF1E0EADB19_E4C87096091A_impl*
 !!! Needs to be implemented !!!
//#UC END# *3CF1E0EADB19_E4C87096091A_impl*
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.FontStrikeoutInheritanceButton

procedure TkwStyleEditorFontFormFontStrikeoutInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E4C87096091A_var*
//#UC END# *4DAEEDE10285_E4C87096091A_var*
begin
//#UC START# *4DAEEDE10285_E4C87096091A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E4C87096091A_impl*
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutInheritanceButton';
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontStrikeoutInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E4C87096091A_var*
//#UC END# *52D00B00031A_E4C87096091A_var*
begin
//#UC START# *52D00B00031A_E4C87096091A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E4C87096091A_impl*
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
//#UC START# *5617F4D00243_E4C87096091A_var*
//#UC END# *5617F4D00243_E4C87096091A_var*
begin
//#UC START# *5617F4D00243_E4C87096091A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E4C87096091A_impl*
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormFontSizeInheritanceButton.FontSizeInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeInheritanceButton }
//#UC START# *6669A334E729_2E4C3AD6D6E8_var*
//#UC END# *6669A334E729_2E4C3AD6D6E8_var*
begin
//#UC START# *6669A334E729_2E4C3AD6D6E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *6669A334E729_2E4C3AD6D6E8_impl*
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.FontSizeInheritanceButton

procedure TkwStyleEditorFontFormFontSizeInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2E4C3AD6D6E8_var*
//#UC END# *4DAEEDE10285_2E4C3AD6D6E8_var*
begin
//#UC START# *4DAEEDE10285_2E4C3AD6D6E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2E4C3AD6D6E8_impl*
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontSizeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontSizeInheritanceButton';
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontSizeInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_2E4C3AD6D6E8_var*
//#UC END# *52D00B00031A_2E4C3AD6D6E8_var*
begin
//#UC START# *52D00B00031A_2E4C3AD6D6E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_2E4C3AD6D6E8_impl*
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
//#UC START# *5617F4D00243_2E4C3AD6D6E8_var*
//#UC END# *5617F4D00243_2E4C3AD6D6E8_var*
begin
//#UC START# *5617F4D00243_2E4C3AD6D6E8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2E4C3AD6D6E8_impl*
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormFontNameInheritanceButton.FontNameInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontNameInheritanceButton }
//#UC START# *3F12F548D12A_4C650B53B504_var*
//#UC END# *3F12F548D12A_4C650B53B504_var*
begin
//#UC START# *3F12F548D12A_4C650B53B504_impl*
 !!! Needs to be implemented !!!
//#UC END# *3F12F548D12A_4C650B53B504_impl*
end;//TkwStyleEditorFontFormFontNameInheritanceButton.FontNameInheritanceButton

procedure TkwStyleEditorFontFormFontNameInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4C650B53B504_var*
//#UC END# *4DAEEDE10285_4C650B53B504_var*
begin
//#UC START# *4DAEEDE10285_4C650B53B504_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4C650B53B504_impl*
end;//TkwStyleEditorFontFormFontNameInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontNameInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontNameInheritanceButton';
end;//TkwStyleEditorFontFormFontNameInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontNameInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4C650B53B504_var*
//#UC END# *52D00B00031A_4C650B53B504_var*
begin
//#UC START# *52D00B00031A_4C650B53B504_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4C650B53B504_impl*
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
//#UC START# *5617F4D00243_4C650B53B504_var*
//#UC END# *5617F4D00243_4C650B53B504_var*
begin
//#UC START# *5617F4D00243_4C650B53B504_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4C650B53B504_impl*
end;//TkwStyleEditorFontFormFontNameInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormFontItalicInheritanceButton.FontItalicInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicInheritanceButton }
//#UC START# *61C07B77CF06_3E8AD123B3F2_var*
//#UC END# *61C07B77CF06_3E8AD123B3F2_var*
begin
//#UC START# *61C07B77CF06_3E8AD123B3F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *61C07B77CF06_3E8AD123B3F2_impl*
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.FontItalicInheritanceButton

procedure TkwStyleEditorFontFormFontItalicInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3E8AD123B3F2_var*
//#UC END# *4DAEEDE10285_3E8AD123B3F2_var*
begin
//#UC START# *4DAEEDE10285_3E8AD123B3F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3E8AD123B3F2_impl*
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontItalicInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontItalicInheritanceButton';
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontItalicInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3E8AD123B3F2_var*
//#UC END# *52D00B00031A_3E8AD123B3F2_var*
begin
//#UC START# *52D00B00031A_3E8AD123B3F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3E8AD123B3F2_impl*
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
//#UC START# *5617F4D00243_3E8AD123B3F2_var*
//#UC END# *5617F4D00243_3E8AD123B3F2_var*
begin
//#UC START# *5617F4D00243_3E8AD123B3F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3E8AD123B3F2_impl*
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormFontForeColorInheritanceButton.FontForeColorInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorInheritanceButton }
//#UC START# *CE667130F431_DFA34DD9BC8B_var*
//#UC END# *CE667130F431_DFA34DD9BC8B_var*
begin
//#UC START# *CE667130F431_DFA34DD9BC8B_impl*
 !!! Needs to be implemented !!!
//#UC END# *CE667130F431_DFA34DD9BC8B_impl*
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.FontForeColorInheritanceButton

procedure TkwStyleEditorFontFormFontForeColorInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DFA34DD9BC8B_var*
//#UC END# *4DAEEDE10285_DFA34DD9BC8B_var*
begin
//#UC START# *4DAEEDE10285_DFA34DD9BC8B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DFA34DD9BC8B_impl*
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontForeColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontForeColorInheritanceButton';
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontForeColorInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_DFA34DD9BC8B_var*
//#UC END# *52D00B00031A_DFA34DD9BC8B_var*
begin
//#UC START# *52D00B00031A_DFA34DD9BC8B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_DFA34DD9BC8B_impl*
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
//#UC START# *5617F4D00243_DFA34DD9BC8B_var*
//#UC END# *5617F4D00243_DFA34DD9BC8B_var*
begin
//#UC START# *5617F4D00243_DFA34DD9BC8B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DFA34DD9BC8B_impl*
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormFontBoldInheritanceButton.FontBoldInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldInheritanceButton }
//#UC START# *72E78B7F0000_75DB636DA3EF_var*
//#UC END# *72E78B7F0000_75DB636DA3EF_var*
begin
//#UC START# *72E78B7F0000_75DB636DA3EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *72E78B7F0000_75DB636DA3EF_impl*
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.FontBoldInheritanceButton

procedure TkwStyleEditorFontFormFontBoldInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_75DB636DA3EF_var*
//#UC END# *4DAEEDE10285_75DB636DA3EF_var*
begin
//#UC START# *4DAEEDE10285_75DB636DA3EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_75DB636DA3EF_impl*
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontBoldInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBoldInheritanceButton';
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBoldInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_75DB636DA3EF_var*
//#UC END# *52D00B00031A_75DB636DA3EF_var*
begin
//#UC START# *52D00B00031A_75DB636DA3EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_75DB636DA3EF_impl*
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
//#UC START# *5617F4D00243_75DB636DA3EF_var*
//#UC END# *5617F4D00243_75DB636DA3EF_var*
begin
//#UC START# *5617F4D00243_75DB636DA3EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_75DB636DA3EF_impl*
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormFontBackColorInheritanceButton.FontBackColorInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorInheritanceButton }
//#UC START# *E6A4EBBD673A_A347ACCF48E9_var*
//#UC END# *E6A4EBBD673A_A347ACCF48E9_var*
begin
//#UC START# *E6A4EBBD673A_A347ACCF48E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *E6A4EBBD673A_A347ACCF48E9_impl*
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.FontBackColorInheritanceButton

procedure TkwStyleEditorFontFormFontBackColorInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A347ACCF48E9_var*
//#UC END# *4DAEEDE10285_A347ACCF48E9_var*
begin
//#UC START# *4DAEEDE10285_A347ACCF48E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A347ACCF48E9_impl*
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontBackColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBackColorInheritanceButton';
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBackColorInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A347ACCF48E9_var*
//#UC END# *52D00B00031A_A347ACCF48E9_var*
begin
//#UC START# *52D00B00031A_A347ACCF48E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A347ACCF48E9_impl*
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
//#UC START# *5617F4D00243_A347ACCF48E9_var*
//#UC END# *5617F4D00243_A347ACCF48E9_var*
begin
//#UC START# *5617F4D00243_A347ACCF48E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A347ACCF48E9_impl*
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.FontUnderlineInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineInheritanceButton }
//#UC START# *D3FFB59CC918_1E11F258142A_var*
//#UC END# *D3FFB59CC918_1E11F258142A_var*
begin
//#UC START# *D3FFB59CC918_1E11F258142A_impl*
 !!! Needs to be implemented !!!
//#UC END# *D3FFB59CC918_1E11F258142A_impl*
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.FontUnderlineInheritanceButton

procedure TkwStyleEditorFontFormFontUnderlineInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1E11F258142A_var*
//#UC END# *4DAEEDE10285_1E11F258142A_var*
begin
//#UC START# *4DAEEDE10285_1E11F258142A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1E11F258142A_impl*
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontUnderlineInheritanceButton';
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontUnderlineInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1E11F258142A_var*
//#UC END# *52D00B00031A_1E11F258142A_var*
begin
//#UC START# *52D00B00031A_1E11F258142A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1E11F258142A_impl*
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
//#UC START# *5617F4D00243_1E11F258142A_var*
//#UC END# *5617F4D00243_1E11F258142A_var*
begin
//#UC START# *5617F4D00243_1E11F258142A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1E11F258142A_impl*
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormFontUnderlineCheckBox.FontUnderlineCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineCheckBox }
//#UC START# *B382265A65CD_BDF04ACC3DA2_var*
//#UC END# *B382265A65CD_BDF04ACC3DA2_var*
begin
//#UC START# *B382265A65CD_BDF04ACC3DA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *B382265A65CD_BDF04ACC3DA2_impl*
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.FontUnderlineCheckBox

procedure TkwStyleEditorFontFormFontUnderlineCheckBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BDF04ACC3DA2_var*
//#UC END# *4DAEEDE10285_BDF04ACC3DA2_var*
begin
//#UC START# *4DAEEDE10285_BDF04ACC3DA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BDF04ACC3DA2_impl*
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontUnderlineCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontUnderlineCheckBox';
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontUnderlineCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BDF04ACC3DA2_var*
//#UC END# *52D00B00031A_BDF04ACC3DA2_var*
begin
//#UC START# *52D00B00031A_BDF04ACC3DA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BDF04ACC3DA2_impl*
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
//#UC START# *5617F4D00243_BDF04ACC3DA2_var*
//#UC END# *5617F4D00243_BDF04ACC3DA2_var*
begin
//#UC START# *5617F4D00243_BDF04ACC3DA2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BDF04ACC3DA2_impl*
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.ParamsTypes

function TkwStyleEditorFontFormFontStrikeoutCheckBox.FontStrikeoutCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutCheckBox }
//#UC START# *748815248976_346BEF6511CF_var*
//#UC END# *748815248976_346BEF6511CF_var*
begin
//#UC START# *748815248976_346BEF6511CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *748815248976_346BEF6511CF_impl*
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.FontStrikeoutCheckBox

procedure TkwStyleEditorFontFormFontStrikeoutCheckBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_346BEF6511CF_var*
//#UC END# *4DAEEDE10285_346BEF6511CF_var*
begin
//#UC START# *4DAEEDE10285_346BEF6511CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_346BEF6511CF_impl*
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontStrikeoutCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutCheckBox';
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontStrikeoutCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_346BEF6511CF_var*
//#UC END# *52D00B00031A_346BEF6511CF_var*
begin
//#UC START# *52D00B00031A_346BEF6511CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_346BEF6511CF_impl*
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
//#UC START# *5617F4D00243_346BEF6511CF_var*
//#UC END# *5617F4D00243_346BEF6511CF_var*
begin
//#UC START# *5617F4D00243_346BEF6511CF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_346BEF6511CF_impl*
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.ParamsTypes

function TkwStyleEditorFontFormFontSizeComboBox.FontSizeComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeComboBox }
//#UC START# *49E4F3A0A9B1_B7C3268A51AA_var*
//#UC END# *49E4F3A0A9B1_B7C3268A51AA_var*
begin
//#UC START# *49E4F3A0A9B1_B7C3268A51AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *49E4F3A0A9B1_B7C3268A51AA_impl*
end;//TkwStyleEditorFontFormFontSizeComboBox.FontSizeComboBox

procedure TkwStyleEditorFontFormFontSizeComboBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B7C3268A51AA_var*
//#UC END# *4DAEEDE10285_B7C3268A51AA_var*
begin
//#UC START# *4DAEEDE10285_B7C3268A51AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B7C3268A51AA_impl*
end;//TkwStyleEditorFontFormFontSizeComboBox.DoDoIt

class function TkwStyleEditorFontFormFontSizeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontSizeComboBox';
end;//TkwStyleEditorFontFormFontSizeComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontSizeComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B7C3268A51AA_var*
//#UC END# *52D00B00031A_B7C3268A51AA_var*
begin
//#UC START# *52D00B00031A_B7C3268A51AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B7C3268A51AA_impl*
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
//#UC START# *5617F4D00243_B7C3268A51AA_var*
//#UC END# *5617F4D00243_B7C3268A51AA_var*
begin
//#UC START# *5617F4D00243_B7C3268A51AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B7C3268A51AA_impl*
end;//TkwStyleEditorFontFormFontSizeComboBox.ParamsTypes

function TkwStyleEditorFontFormFontNameComboBox.FontNameComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontNameComboBox }
//#UC START# *93BA3E3C4B0D_EC0410979EB7_var*
//#UC END# *93BA3E3C4B0D_EC0410979EB7_var*
begin
//#UC START# *93BA3E3C4B0D_EC0410979EB7_impl*
 !!! Needs to be implemented !!!
//#UC END# *93BA3E3C4B0D_EC0410979EB7_impl*
end;//TkwStyleEditorFontFormFontNameComboBox.FontNameComboBox

procedure TkwStyleEditorFontFormFontNameComboBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EC0410979EB7_var*
//#UC END# *4DAEEDE10285_EC0410979EB7_var*
begin
//#UC START# *4DAEEDE10285_EC0410979EB7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EC0410979EB7_impl*
end;//TkwStyleEditorFontFormFontNameComboBox.DoDoIt

class function TkwStyleEditorFontFormFontNameComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontNameComboBox';
end;//TkwStyleEditorFontFormFontNameComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontNameComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_EC0410979EB7_var*
//#UC END# *52D00B00031A_EC0410979EB7_var*
begin
//#UC START# *52D00B00031A_EC0410979EB7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_EC0410979EB7_impl*
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
//#UC START# *5617F4D00243_EC0410979EB7_var*
//#UC END# *5617F4D00243_EC0410979EB7_var*
begin
//#UC START# *5617F4D00243_EC0410979EB7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_EC0410979EB7_impl*
end;//TkwStyleEditorFontFormFontNameComboBox.ParamsTypes

function TkwStyleEditorFontFormFontItalicCheckBox.FontItalicCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicCheckBox }
//#UC START# *2819861B803C_5B44D7F36F3A_var*
//#UC END# *2819861B803C_5B44D7F36F3A_var*
begin
//#UC START# *2819861B803C_5B44D7F36F3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *2819861B803C_5B44D7F36F3A_impl*
end;//TkwStyleEditorFontFormFontItalicCheckBox.FontItalicCheckBox

procedure TkwStyleEditorFontFormFontItalicCheckBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5B44D7F36F3A_var*
//#UC END# *4DAEEDE10285_5B44D7F36F3A_var*
begin
//#UC START# *4DAEEDE10285_5B44D7F36F3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5B44D7F36F3A_impl*
end;//TkwStyleEditorFontFormFontItalicCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontItalicCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontItalicCheckBox';
end;//TkwStyleEditorFontFormFontItalicCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontItalicCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5B44D7F36F3A_var*
//#UC END# *52D00B00031A_5B44D7F36F3A_var*
begin
//#UC START# *52D00B00031A_5B44D7F36F3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5B44D7F36F3A_impl*
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
//#UC START# *5617F4D00243_5B44D7F36F3A_var*
//#UC END# *5617F4D00243_5B44D7F36F3A_var*
begin
//#UC START# *5617F4D00243_5B44D7F36F3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5B44D7F36F3A_impl*
end;//TkwStyleEditorFontFormFontItalicCheckBox.ParamsTypes

function TkwStyleEditorFontFormFontForeColorBox.FontForeColorBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorBox }
//#UC START# *2D7BA1914A78_0834F2DF835D_var*
//#UC END# *2D7BA1914A78_0834F2DF835D_var*
begin
//#UC START# *2D7BA1914A78_0834F2DF835D_impl*
 !!! Needs to be implemented !!!
//#UC END# *2D7BA1914A78_0834F2DF835D_impl*
end;//TkwStyleEditorFontFormFontForeColorBox.FontForeColorBox

procedure TkwStyleEditorFontFormFontForeColorBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0834F2DF835D_var*
//#UC END# *4DAEEDE10285_0834F2DF835D_var*
begin
//#UC START# *4DAEEDE10285_0834F2DF835D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0834F2DF835D_impl*
end;//TkwStyleEditorFontFormFontForeColorBox.DoDoIt

class function TkwStyleEditorFontFormFontForeColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontForeColorBox';
end;//TkwStyleEditorFontFormFontForeColorBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontForeColorBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0834F2DF835D_var*
//#UC END# *52D00B00031A_0834F2DF835D_var*
begin
//#UC START# *52D00B00031A_0834F2DF835D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0834F2DF835D_impl*
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
//#UC START# *5617F4D00243_0834F2DF835D_var*
//#UC END# *5617F4D00243_0834F2DF835D_var*
begin
//#UC START# *5617F4D00243_0834F2DF835D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0834F2DF835D_impl*
end;//TkwStyleEditorFontFormFontForeColorBox.ParamsTypes

function TkwStyleEditorFontFormFontBoldCheckBox.FontBoldCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldCheckBox }
//#UC START# *3472F35BA9B8_BDDBA2C31A71_var*
//#UC END# *3472F35BA9B8_BDDBA2C31A71_var*
begin
//#UC START# *3472F35BA9B8_BDDBA2C31A71_impl*
 !!! Needs to be implemented !!!
//#UC END# *3472F35BA9B8_BDDBA2C31A71_impl*
end;//TkwStyleEditorFontFormFontBoldCheckBox.FontBoldCheckBox

procedure TkwStyleEditorFontFormFontBoldCheckBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BDDBA2C31A71_var*
//#UC END# *4DAEEDE10285_BDDBA2C31A71_var*
begin
//#UC START# *4DAEEDE10285_BDDBA2C31A71_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BDDBA2C31A71_impl*
end;//TkwStyleEditorFontFormFontBoldCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontBoldCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBoldCheckBox';
end;//TkwStyleEditorFontFormFontBoldCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBoldCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BDDBA2C31A71_var*
//#UC END# *52D00B00031A_BDDBA2C31A71_var*
begin
//#UC START# *52D00B00031A_BDDBA2C31A71_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BDDBA2C31A71_impl*
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
//#UC START# *5617F4D00243_BDDBA2C31A71_var*
//#UC END# *5617F4D00243_BDDBA2C31A71_var*
begin
//#UC START# *5617F4D00243_BDDBA2C31A71_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BDDBA2C31A71_impl*
end;//TkwStyleEditorFontFormFontBoldCheckBox.ParamsTypes

function TkwStyleEditorFontFormFontBackColorBox.FontBackColorBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorBox }
//#UC START# *2734AE8F8A5A_4856B8474DD1_var*
//#UC END# *2734AE8F8A5A_4856B8474DD1_var*
begin
//#UC START# *2734AE8F8A5A_4856B8474DD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *2734AE8F8A5A_4856B8474DD1_impl*
end;//TkwStyleEditorFontFormFontBackColorBox.FontBackColorBox

procedure TkwStyleEditorFontFormFontBackColorBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4856B8474DD1_var*
//#UC END# *4DAEEDE10285_4856B8474DD1_var*
begin
//#UC START# *4DAEEDE10285_4856B8474DD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4856B8474DD1_impl*
end;//TkwStyleEditorFontFormFontBackColorBox.DoDoIt

class function TkwStyleEditorFontFormFontBackColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBackColorBox';
end;//TkwStyleEditorFontFormFontBackColorBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBackColorBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4856B8474DD1_var*
//#UC END# *52D00B00031A_4856B8474DD1_var*
begin
//#UC START# *52D00B00031A_4856B8474DD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4856B8474DD1_impl*
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
//#UC START# *5617F4D00243_4856B8474DD1_var*
//#UC END# *5617F4D00243_4856B8474DD1_var*
begin
//#UC START# *5617F4D00243_4856B8474DD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4856B8474DD1_impl*
end;//TkwStyleEditorFontFormFontBackColorBox.ParamsTypes

function TkwStyleEditorFontFormFontScalableCheckBox.FontScalableCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableCheckBox }
//#UC START# *D46177E12C59_C6C7C49E08D5_var*
//#UC END# *D46177E12C59_C6C7C49E08D5_var*
begin
//#UC START# *D46177E12C59_C6C7C49E08D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *D46177E12C59_C6C7C49E08D5_impl*
end;//TkwStyleEditorFontFormFontScalableCheckBox.FontScalableCheckBox

procedure TkwStyleEditorFontFormFontScalableCheckBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C6C7C49E08D5_var*
//#UC END# *4DAEEDE10285_C6C7C49E08D5_var*
begin
//#UC START# *4DAEEDE10285_C6C7C49E08D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C6C7C49E08D5_impl*
end;//TkwStyleEditorFontFormFontScalableCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontScalableCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScalableCheckBox';
end;//TkwStyleEditorFontFormFontScalableCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontScalableCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C6C7C49E08D5_var*
//#UC END# *52D00B00031A_C6C7C49E08D5_var*
begin
//#UC START# *52D00B00031A_C6C7C49E08D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C6C7C49E08D5_impl*
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
//#UC START# *5617F4D00243_C6C7C49E08D5_var*
//#UC END# *5617F4D00243_C6C7C49E08D5_var*
begin
//#UC START# *5617F4D00243_C6C7C49E08D5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C6C7C49E08D5_impl*
end;//TkwStyleEditorFontFormFontScalableCheckBox.ParamsTypes

function TkwStyleEditorFontFormLeftIndentLabel.LeftIndentLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentLabel }
//#UC START# *F979EBE08C59_E019FF4C914D_var*
//#UC END# *F979EBE08C59_E019FF4C914D_var*
begin
//#UC START# *F979EBE08C59_E019FF4C914D_impl*
 !!! Needs to be implemented !!!
//#UC END# *F979EBE08C59_E019FF4C914D_impl*
end;//TkwStyleEditorFontFormLeftIndentLabel.LeftIndentLabel

procedure TkwStyleEditorFontFormLeftIndentLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E019FF4C914D_var*
//#UC END# *4DAEEDE10285_E019FF4C914D_var*
begin
//#UC START# *4DAEEDE10285_E019FF4C914D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E019FF4C914D_impl*
end;//TkwStyleEditorFontFormLeftIndentLabel.DoDoIt

class function TkwStyleEditorFontFormLeftIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.LeftIndentLabel';
end;//TkwStyleEditorFontFormLeftIndentLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormLeftIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E019FF4C914D_var*
//#UC END# *52D00B00031A_E019FF4C914D_var*
begin
//#UC START# *52D00B00031A_E019FF4C914D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E019FF4C914D_impl*
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
//#UC START# *5617F4D00243_E019FF4C914D_var*
//#UC END# *5617F4D00243_E019FF4C914D_var*
begin
//#UC START# *5617F4D00243_E019FF4C914D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E019FF4C914D_impl*
end;//TkwStyleEditorFontFormLeftIndentLabel.ParamsTypes

function TkwStyleEditorFontFormLeftIndentComboBox.LeftIndentComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentComboBox }
//#UC START# *8A2BF43A1B9A_4A630E1D42AC_var*
//#UC END# *8A2BF43A1B9A_4A630E1D42AC_var*
begin
//#UC START# *8A2BF43A1B9A_4A630E1D42AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *8A2BF43A1B9A_4A630E1D42AC_impl*
end;//TkwStyleEditorFontFormLeftIndentComboBox.LeftIndentComboBox

procedure TkwStyleEditorFontFormLeftIndentComboBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A630E1D42AC_var*
//#UC END# *4DAEEDE10285_4A630E1D42AC_var*
begin
//#UC START# *4DAEEDE10285_4A630E1D42AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4A630E1D42AC_impl*
end;//TkwStyleEditorFontFormLeftIndentComboBox.DoDoIt

class function TkwStyleEditorFontFormLeftIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.LeftIndentComboBox';
end;//TkwStyleEditorFontFormLeftIndentComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormLeftIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4A630E1D42AC_var*
//#UC END# *52D00B00031A_4A630E1D42AC_var*
begin
//#UC START# *52D00B00031A_4A630E1D42AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4A630E1D42AC_impl*
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
//#UC START# *5617F4D00243_4A630E1D42AC_var*
//#UC END# *5617F4D00243_4A630E1D42AC_var*
begin
//#UC START# *5617F4D00243_4A630E1D42AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4A630E1D42AC_impl*
end;//TkwStyleEditorFontFormLeftIndentComboBox.ParamsTypes

function TkwStyleEditorFontFormRightIndentLabel.RightIndentLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentLabel }
//#UC START# *7BB5FD2930EF_3E3554E6A89D_var*
//#UC END# *7BB5FD2930EF_3E3554E6A89D_var*
begin
//#UC START# *7BB5FD2930EF_3E3554E6A89D_impl*
 !!! Needs to be implemented !!!
//#UC END# *7BB5FD2930EF_3E3554E6A89D_impl*
end;//TkwStyleEditorFontFormRightIndentLabel.RightIndentLabel

procedure TkwStyleEditorFontFormRightIndentLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3E3554E6A89D_var*
//#UC END# *4DAEEDE10285_3E3554E6A89D_var*
begin
//#UC START# *4DAEEDE10285_3E3554E6A89D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3E3554E6A89D_impl*
end;//TkwStyleEditorFontFormRightIndentLabel.DoDoIt

class function TkwStyleEditorFontFormRightIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.RightIndentLabel';
end;//TkwStyleEditorFontFormRightIndentLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormRightIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3E3554E6A89D_var*
//#UC END# *52D00B00031A_3E3554E6A89D_var*
begin
//#UC START# *52D00B00031A_3E3554E6A89D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3E3554E6A89D_impl*
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
//#UC START# *5617F4D00243_3E3554E6A89D_var*
//#UC END# *5617F4D00243_3E3554E6A89D_var*
begin
//#UC START# *5617F4D00243_3E3554E6A89D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3E3554E6A89D_impl*
end;//TkwStyleEditorFontFormRightIndentLabel.ParamsTypes

function TkwStyleEditorFontFormRightIndentComboBox.RightIndentComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentComboBox }
//#UC START# *21C1B347928B_5BE934BE0F08_var*
//#UC END# *21C1B347928B_5BE934BE0F08_var*
begin
//#UC START# *21C1B347928B_5BE934BE0F08_impl*
 !!! Needs to be implemented !!!
//#UC END# *21C1B347928B_5BE934BE0F08_impl*
end;//TkwStyleEditorFontFormRightIndentComboBox.RightIndentComboBox

procedure TkwStyleEditorFontFormRightIndentComboBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5BE934BE0F08_var*
//#UC END# *4DAEEDE10285_5BE934BE0F08_var*
begin
//#UC START# *4DAEEDE10285_5BE934BE0F08_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5BE934BE0F08_impl*
end;//TkwStyleEditorFontFormRightIndentComboBox.DoDoIt

class function TkwStyleEditorFontFormRightIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.RightIndentComboBox';
end;//TkwStyleEditorFontFormRightIndentComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormRightIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_5BE934BE0F08_var*
//#UC END# *52D00B00031A_5BE934BE0F08_var*
begin
//#UC START# *52D00B00031A_5BE934BE0F08_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_5BE934BE0F08_impl*
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
//#UC START# *5617F4D00243_5BE934BE0F08_var*
//#UC END# *5617F4D00243_5BE934BE0F08_var*
begin
//#UC START# *5617F4D00243_5BE934BE0F08_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5BE934BE0F08_impl*
end;//TkwStyleEditorFontFormRightIndentComboBox.ParamsTypes

function TkwStyleEditorFontFormFirstIndentLabel.FirstIndentLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentLabel }
//#UC START# *9FF56FA834D2_E615B68194EF_var*
//#UC END# *9FF56FA834D2_E615B68194EF_var*
begin
//#UC START# *9FF56FA834D2_E615B68194EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *9FF56FA834D2_E615B68194EF_impl*
end;//TkwStyleEditorFontFormFirstIndentLabel.FirstIndentLabel

procedure TkwStyleEditorFontFormFirstIndentLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E615B68194EF_var*
//#UC END# *4DAEEDE10285_E615B68194EF_var*
begin
//#UC START# *4DAEEDE10285_E615B68194EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E615B68194EF_impl*
end;//TkwStyleEditorFontFormFirstIndentLabel.DoDoIt

class function TkwStyleEditorFontFormFirstIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FirstIndentLabel';
end;//TkwStyleEditorFontFormFirstIndentLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFirstIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E615B68194EF_var*
//#UC END# *52D00B00031A_E615B68194EF_var*
begin
//#UC START# *52D00B00031A_E615B68194EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E615B68194EF_impl*
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
//#UC START# *5617F4D00243_E615B68194EF_var*
//#UC END# *5617F4D00243_E615B68194EF_var*
begin
//#UC START# *5617F4D00243_E615B68194EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E615B68194EF_impl*
end;//TkwStyleEditorFontFormFirstIndentLabel.ParamsTypes

function TkwStyleEditorFontFormFirstIndentComboBox.FirstIndentComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentComboBox }
//#UC START# *6F92AAED897D_FEA1B672155D_var*
//#UC END# *6F92AAED897D_FEA1B672155D_var*
begin
//#UC START# *6F92AAED897D_FEA1B672155D_impl*
 !!! Needs to be implemented !!!
//#UC END# *6F92AAED897D_FEA1B672155D_impl*
end;//TkwStyleEditorFontFormFirstIndentComboBox.FirstIndentComboBox

procedure TkwStyleEditorFontFormFirstIndentComboBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FEA1B672155D_var*
//#UC END# *4DAEEDE10285_FEA1B672155D_var*
begin
//#UC START# *4DAEEDE10285_FEA1B672155D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FEA1B672155D_impl*
end;//TkwStyleEditorFontFormFirstIndentComboBox.DoDoIt

class function TkwStyleEditorFontFormFirstIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FirstIndentComboBox';
end;//TkwStyleEditorFontFormFirstIndentComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFirstIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FEA1B672155D_var*
//#UC END# *52D00B00031A_FEA1B672155D_var*
begin
//#UC START# *52D00B00031A_FEA1B672155D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FEA1B672155D_impl*
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
//#UC START# *5617F4D00243_FEA1B672155D_var*
//#UC END# *5617F4D00243_FEA1B672155D_var*
begin
//#UC START# *5617F4D00243_FEA1B672155D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FEA1B672155D_impl*
end;//TkwStyleEditorFontFormFirstIndentComboBox.ParamsTypes

function TkwStyleEditorFontFormSpaceBeforeLabel.SpaceBeforeLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeLabel }
//#UC START# *65BB60BC7526_A031CF88FA6A_var*
//#UC END# *65BB60BC7526_A031CF88FA6A_var*
begin
//#UC START# *65BB60BC7526_A031CF88FA6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *65BB60BC7526_A031CF88FA6A_impl*
end;//TkwStyleEditorFontFormSpaceBeforeLabel.SpaceBeforeLabel

procedure TkwStyleEditorFontFormSpaceBeforeLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A031CF88FA6A_var*
//#UC END# *4DAEEDE10285_A031CF88FA6A_var*
begin
//#UC START# *4DAEEDE10285_A031CF88FA6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A031CF88FA6A_impl*
end;//TkwStyleEditorFontFormSpaceBeforeLabel.DoDoIt

class function TkwStyleEditorFontFormSpaceBeforeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeLabel';
end;//TkwStyleEditorFontFormSpaceBeforeLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceBeforeLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A031CF88FA6A_var*
//#UC END# *52D00B00031A_A031CF88FA6A_var*
begin
//#UC START# *52D00B00031A_A031CF88FA6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A031CF88FA6A_impl*
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
//#UC START# *5617F4D00243_A031CF88FA6A_var*
//#UC END# *5617F4D00243_A031CF88FA6A_var*
begin
//#UC START# *5617F4D00243_A031CF88FA6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A031CF88FA6A_impl*
end;//TkwStyleEditorFontFormSpaceBeforeLabel.ParamsTypes

function TkwStyleEditorFontFormSpaceBeforeComboBox.SpaceBeforeComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeComboBox }
//#UC START# *F5CEB209B1E8_D009BF86496A_var*
//#UC END# *F5CEB209B1E8_D009BF86496A_var*
begin
//#UC START# *F5CEB209B1E8_D009BF86496A_impl*
 !!! Needs to be implemented !!!
//#UC END# *F5CEB209B1E8_D009BF86496A_impl*
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.SpaceBeforeComboBox

procedure TkwStyleEditorFontFormSpaceBeforeComboBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D009BF86496A_var*
//#UC END# *4DAEEDE10285_D009BF86496A_var*
begin
//#UC START# *4DAEEDE10285_D009BF86496A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D009BF86496A_impl*
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.DoDoIt

class function TkwStyleEditorFontFormSpaceBeforeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeComboBox';
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceBeforeComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D009BF86496A_var*
//#UC END# *52D00B00031A_D009BF86496A_var*
begin
//#UC START# *52D00B00031A_D009BF86496A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D009BF86496A_impl*
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
//#UC START# *5617F4D00243_D009BF86496A_var*
//#UC END# *5617F4D00243_D009BF86496A_var*
begin
//#UC START# *5617F4D00243_D009BF86496A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D009BF86496A_impl*
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.ParamsTypes

function TkwStyleEditorFontFormSpaceAfterLabel.SpaceAfterLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterLabel }
//#UC START# *CAA7E9F24699_CF58F0DFE7C9_var*
//#UC END# *CAA7E9F24699_CF58F0DFE7C9_var*
begin
//#UC START# *CAA7E9F24699_CF58F0DFE7C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *CAA7E9F24699_CF58F0DFE7C9_impl*
end;//TkwStyleEditorFontFormSpaceAfterLabel.SpaceAfterLabel

procedure TkwStyleEditorFontFormSpaceAfterLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CF58F0DFE7C9_var*
//#UC END# *4DAEEDE10285_CF58F0DFE7C9_var*
begin
//#UC START# *4DAEEDE10285_CF58F0DFE7C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CF58F0DFE7C9_impl*
end;//TkwStyleEditorFontFormSpaceAfterLabel.DoDoIt

class function TkwStyleEditorFontFormSpaceAfterLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceAfterLabel';
end;//TkwStyleEditorFontFormSpaceAfterLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceAfterLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_CF58F0DFE7C9_var*
//#UC END# *52D00B00031A_CF58F0DFE7C9_var*
begin
//#UC START# *52D00B00031A_CF58F0DFE7C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_CF58F0DFE7C9_impl*
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
//#UC START# *5617F4D00243_CF58F0DFE7C9_var*
//#UC END# *5617F4D00243_CF58F0DFE7C9_var*
begin
//#UC START# *5617F4D00243_CF58F0DFE7C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CF58F0DFE7C9_impl*
end;//TkwStyleEditorFontFormSpaceAfterLabel.ParamsTypes

function TkwStyleEditorFontFormSpaceAfterComboBox.SpaceAfterComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterComboBox }
//#UC START# *3B24C5728EB7_C6D86EC88CE3_var*
//#UC END# *3B24C5728EB7_C6D86EC88CE3_var*
begin
//#UC START# *3B24C5728EB7_C6D86EC88CE3_impl*
 !!! Needs to be implemented !!!
//#UC END# *3B24C5728EB7_C6D86EC88CE3_impl*
end;//TkwStyleEditorFontFormSpaceAfterComboBox.SpaceAfterComboBox

procedure TkwStyleEditorFontFormSpaceAfterComboBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C6D86EC88CE3_var*
//#UC END# *4DAEEDE10285_C6D86EC88CE3_var*
begin
//#UC START# *4DAEEDE10285_C6D86EC88CE3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C6D86EC88CE3_impl*
end;//TkwStyleEditorFontFormSpaceAfterComboBox.DoDoIt

class function TkwStyleEditorFontFormSpaceAfterComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceAfterComboBox';
end;//TkwStyleEditorFontFormSpaceAfterComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceAfterComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C6D86EC88CE3_var*
//#UC END# *52D00B00031A_C6D86EC88CE3_var*
begin
//#UC START# *52D00B00031A_C6D86EC88CE3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C6D86EC88CE3_impl*
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
//#UC START# *5617F4D00243_C6D86EC88CE3_var*
//#UC END# *5617F4D00243_C6D86EC88CE3_var*
begin
//#UC START# *5617F4D00243_C6D86EC88CE3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C6D86EC88CE3_impl*
end;//TkwStyleEditorFontFormSpaceAfterComboBox.ParamsTypes

function TkwStyleEditorFontFormLeftIndentInheritanceButton.LeftIndentInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentInheritanceButton }
//#UC START# *3E064C6E1147_C28516B71127_var*
//#UC END# *3E064C6E1147_C28516B71127_var*
begin
//#UC START# *3E064C6E1147_C28516B71127_impl*
 !!! Needs to be implemented !!!
//#UC END# *3E064C6E1147_C28516B71127_impl*
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.LeftIndentInheritanceButton

procedure TkwStyleEditorFontFormLeftIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C28516B71127_var*
//#UC END# *4DAEEDE10285_C28516B71127_var*
begin
//#UC START# *4DAEEDE10285_C28516B71127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C28516B71127_impl*
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormLeftIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.LeftIndentInheritanceButton';
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormLeftIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C28516B71127_var*
//#UC END# *52D00B00031A_C28516B71127_var*
begin
//#UC START# *52D00B00031A_C28516B71127_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C28516B71127_impl*
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
//#UC START# *5617F4D00243_C28516B71127_var*
//#UC END# *5617F4D00243_C28516B71127_var*
begin
//#UC START# *5617F4D00243_C28516B71127_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C28516B71127_impl*
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormRightIndentInheritanceButton.RightIndentInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentInheritanceButton }
//#UC START# *71F1498112DD_8CD155DF44C9_var*
//#UC END# *71F1498112DD_8CD155DF44C9_var*
begin
//#UC START# *71F1498112DD_8CD155DF44C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *71F1498112DD_8CD155DF44C9_impl*
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.RightIndentInheritanceButton

procedure TkwStyleEditorFontFormRightIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8CD155DF44C9_var*
//#UC END# *4DAEEDE10285_8CD155DF44C9_var*
begin
//#UC START# *4DAEEDE10285_8CD155DF44C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8CD155DF44C9_impl*
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormRightIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.RightIndentInheritanceButton';
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormRightIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8CD155DF44C9_var*
//#UC END# *52D00B00031A_8CD155DF44C9_var*
begin
//#UC START# *52D00B00031A_8CD155DF44C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8CD155DF44C9_impl*
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
//#UC START# *5617F4D00243_8CD155DF44C9_var*
//#UC END# *5617F4D00243_8CD155DF44C9_var*
begin
//#UC START# *5617F4D00243_8CD155DF44C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8CD155DF44C9_impl*
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormFirstIndentInheritanceButton.FirstIndentInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentInheritanceButton }
//#UC START# *D3B3B059EBEA_C2221ABA41AB_var*
//#UC END# *D3B3B059EBEA_C2221ABA41AB_var*
begin
//#UC START# *D3B3B059EBEA_C2221ABA41AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *D3B3B059EBEA_C2221ABA41AB_impl*
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.FirstIndentInheritanceButton

procedure TkwStyleEditorFontFormFirstIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C2221ABA41AB_var*
//#UC END# *4DAEEDE10285_C2221ABA41AB_var*
begin
//#UC START# *4DAEEDE10285_C2221ABA41AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C2221ABA41AB_impl*
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFirstIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FirstIndentInheritanceButton';
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFirstIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C2221ABA41AB_var*
//#UC END# *52D00B00031A_C2221ABA41AB_var*
begin
//#UC START# *52D00B00031A_C2221ABA41AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C2221ABA41AB_impl*
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
//#UC START# *5617F4D00243_C2221ABA41AB_var*
//#UC END# *5617F4D00243_C2221ABA41AB_var*
begin
//#UC START# *5617F4D00243_C2221ABA41AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C2221ABA41AB_impl*
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SpaceBeforeInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeInheritanceButton }
//#UC START# *BF3559C4B45F_CBEC26484423_var*
//#UC END# *BF3559C4B45F_CBEC26484423_var*
begin
//#UC START# *BF3559C4B45F_CBEC26484423_impl*
 !!! Needs to be implemented !!!
//#UC END# *BF3559C4B45F_CBEC26484423_impl*
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SpaceBeforeInheritanceButton

procedure TkwStyleEditorFontFormSpaceBeforeInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CBEC26484423_var*
//#UC END# *4DAEEDE10285_CBEC26484423_var*
begin
//#UC START# *4DAEEDE10285_CBEC26484423_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CBEC26484423_impl*
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeInheritanceButton';
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_CBEC26484423_var*
//#UC END# *52D00B00031A_CBEC26484423_var*
begin
//#UC START# *52D00B00031A_CBEC26484423_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_CBEC26484423_impl*
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
//#UC START# *5617F4D00243_CBEC26484423_var*
//#UC END# *5617F4D00243_CBEC26484423_var*
begin
//#UC START# *5617F4D00243_CBEC26484423_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CBEC26484423_impl*
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.SpaceAfterInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterInheritanceButton }
//#UC START# *299C6C6DFB49_06951EDD3ADA_var*
//#UC END# *299C6C6DFB49_06951EDD3ADA_var*
begin
//#UC START# *299C6C6DFB49_06951EDD3ADA_impl*
 !!! Needs to be implemented !!!
//#UC END# *299C6C6DFB49_06951EDD3ADA_impl*
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.SpaceAfterInheritanceButton

procedure TkwStyleEditorFontFormSpaceAfterInheritanceButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_06951EDD3ADA_var*
//#UC END# *4DAEEDE10285_06951EDD3ADA_var*
begin
//#UC START# *4DAEEDE10285_06951EDD3ADA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_06951EDD3ADA_impl*
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceAfterInheritanceButton';
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceAfterInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_06951EDD3ADA_var*
//#UC END# *52D00B00031A_06951EDD3ADA_var*
begin
//#UC START# *52D00B00031A_06951EDD3ADA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_06951EDD3ADA_impl*
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
//#UC START# *5617F4D00243_06951EDD3ADA_var*
//#UC END# *5617F4D00243_06951EDD3ADA_var*
begin
//#UC START# *5617F4D00243_06951EDD3ADA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_06951EDD3ADA_impl*
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.ParamsTypes

function TkwStyleEditorFontFormStyleCaptionLabel.StyleCaptionLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionLabel }
//#UC START# *6D590AE9E674_D81A105F7E2C_var*
//#UC END# *6D590AE9E674_D81A105F7E2C_var*
begin
//#UC START# *6D590AE9E674_D81A105F7E2C_impl*
 !!! Needs to be implemented !!!
//#UC END# *6D590AE9E674_D81A105F7E2C_impl*
end;//TkwStyleEditorFontFormStyleCaptionLabel.StyleCaptionLabel

procedure TkwStyleEditorFontFormStyleCaptionLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D81A105F7E2C_var*
//#UC END# *4DAEEDE10285_D81A105F7E2C_var*
begin
//#UC START# *4DAEEDE10285_D81A105F7E2C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D81A105F7E2C_impl*
end;//TkwStyleEditorFontFormStyleCaptionLabel.DoDoIt

class function TkwStyleEditorFontFormStyleCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.StyleCaptionLabel';
end;//TkwStyleEditorFontFormStyleCaptionLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormStyleCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D81A105F7E2C_var*
//#UC END# *52D00B00031A_D81A105F7E2C_var*
begin
//#UC START# *52D00B00031A_D81A105F7E2C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D81A105F7E2C_impl*
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
//#UC START# *5617F4D00243_D81A105F7E2C_var*
//#UC END# *5617F4D00243_D81A105F7E2C_var*
begin
//#UC START# *5617F4D00243_D81A105F7E2C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D81A105F7E2C_impl*
end;//TkwStyleEditorFontFormStyleCaptionLabel.ParamsTypes

function TkwStyleEditorFontFormStyleCaptionComboBox.StyleCaptionComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionComboBox }
//#UC START# *A288DB0A0CF0_11BE9A7BD28B_var*
//#UC END# *A288DB0A0CF0_11BE9A7BD28B_var*
begin
//#UC START# *A288DB0A0CF0_11BE9A7BD28B_impl*
 !!! Needs to be implemented !!!
//#UC END# *A288DB0A0CF0_11BE9A7BD28B_impl*
end;//TkwStyleEditorFontFormStyleCaptionComboBox.StyleCaptionComboBox

procedure TkwStyleEditorFontFormStyleCaptionComboBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_11BE9A7BD28B_var*
//#UC END# *4DAEEDE10285_11BE9A7BD28B_var*
begin
//#UC START# *4DAEEDE10285_11BE9A7BD28B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_11BE9A7BD28B_impl*
end;//TkwStyleEditorFontFormStyleCaptionComboBox.DoDoIt

class function TkwStyleEditorFontFormStyleCaptionComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.StyleCaptionComboBox';
end;//TkwStyleEditorFontFormStyleCaptionComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormStyleCaptionComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_11BE9A7BD28B_var*
//#UC END# *52D00B00031A_11BE9A7BD28B_var*
begin
//#UC START# *52D00B00031A_11BE9A7BD28B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_11BE9A7BD28B_impl*
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
//#UC START# *5617F4D00243_11BE9A7BD28B_var*
//#UC END# *5617F4D00243_11BE9A7BD28B_var*
begin
//#UC START# *5617F4D00243_11BE9A7BD28B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_11BE9A7BD28B_impl*
end;//TkwStyleEditorFontFormStyleCaptionComboBox.ParamsTypes

initialization
 Tkw_Form_StyleEditorFont.RegisterInEngine;
 {* Регистрация Tkw_Form_StyleEditorFont }
 Tkw_StyleEditorFont_Control_FontScrollBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontScrollBox }
 Tkw_StyleEditorFont_Control_FontScrollBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontScrollBox_Push }
 Tkw_StyleEditorFont_Control_FontUnderlineLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontUnderlineLabel }
 Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push }
 Tkw_StyleEditorFont_Control_FontStrikeoutLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutLabel }
 Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push }
 Tkw_StyleEditorFont_Control_FontSizeLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontSizeLabel }
 Tkw_StyleEditorFont_Control_FontSizeLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontSizeLabel_Push }
 Tkw_StyleEditorFont_Control_FontNameLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontNameLabel }
 Tkw_StyleEditorFont_Control_FontNameLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontNameLabel_Push }
 Tkw_StyleEditorFont_Control_FontItalicLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontItalicLabel }
 Tkw_StyleEditorFont_Control_FontItalicLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontItalicLabel_Push }
 Tkw_StyleEditorFont_Control_FontForeColorLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontForeColorLabel }
 Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontForeColorLabel_Push }
 Tkw_StyleEditorFont_Control_FontBoldLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBoldLabel }
 Tkw_StyleEditorFont_Control_FontBoldLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBoldLabel_Push }
 Tkw_StyleEditorFont_Control_FontBackColorLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBackColorLabel }
 Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBackColorLabel_Push }
 Tkw_StyleEditorFont_Control_FontScalableLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontScalableLabel }
 Tkw_StyleEditorFont_Control_FontScalableLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontScalableLabel_Push }
 Tkw_StyleEditorFont_Control_FontScalableBevel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontScalableBevel }
 Tkw_StyleEditorFont_Control_FontScalableBevel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontScalableBevel_Push }
 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton }
 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontSizeInheritanceButton }
 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontNameInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontNameInheritanceButton }
 Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontItalicInheritanceButton }
 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton }
 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBoldInheritanceButton }
 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton }
 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton }
 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontUnderlineCheckBox }
 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push }
 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox }
 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push }
 Tkw_StyleEditorFont_Control_FontSizeComboBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontSizeComboBox }
 Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontSizeComboBox_Push }
 Tkw_StyleEditorFont_Control_FontNameComboBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontNameComboBox }
 Tkw_StyleEditorFont_Control_FontNameComboBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontNameComboBox_Push }
 Tkw_StyleEditorFont_Control_FontItalicCheckBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontItalicCheckBox }
 Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push }
 Tkw_StyleEditorFont_Control_FontForeColorBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontForeColorBox }
 Tkw_StyleEditorFont_Control_FontForeColorBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontForeColorBox_Push }
 Tkw_StyleEditorFont_Control_FontBoldCheckBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBoldCheckBox }
 Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push }
 Tkw_StyleEditorFont_Control_FontBackColorBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBackColorBox }
 Tkw_StyleEditorFont_Control_FontBackColorBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontBackColorBox_Push }
 Tkw_StyleEditorFont_Control_FontScalableCheckBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontScalableCheckBox }
 Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push }
 Tkw_StyleEditorFont_Control_LeftIndentLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_LeftIndentLabel }
 Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_LeftIndentLabel_Push }
 Tkw_StyleEditorFont_Control_LeftIndentComboBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_LeftIndentComboBox }
 Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push }
 Tkw_StyleEditorFont_Control_RightIndentLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_RightIndentLabel }
 Tkw_StyleEditorFont_Control_RightIndentLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_RightIndentLabel_Push }
 Tkw_StyleEditorFont_Control_RightIndentComboBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_RightIndentComboBox }
 Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_RightIndentComboBox_Push }
 Tkw_StyleEditorFont_Control_FirstIndentLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FirstIndentLabel }
 Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FirstIndentLabel_Push }
 Tkw_StyleEditorFont_Control_FirstIndentComboBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FirstIndentComboBox }
 Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push }
 Tkw_StyleEditorFont_Control_SpaceBeforeLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeLabel }
 Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push }
 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeComboBox }
 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push }
 Tkw_StyleEditorFont_Control_SpaceAfterLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceAfterLabel }
 Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push }
 Tkw_StyleEditorFont_Control_SpaceAfterComboBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceAfterComboBox }
 Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push }
 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton }
 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_RightIndentInheritanceButton }
 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton }
 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton }
 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton }
 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push }
 Tkw_StyleEditorFont_Control_StyleCaptionLabel.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_StyleCaptionLabel }
 Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push }
 Tkw_StyleEditorFont_Control_StyleCaptionComboBox.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_StyleCaptionComboBox }
 Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push }
 TkwStyleEditorFontFormFontScrollBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontScrollBox }
 TkwStyleEditorFontFormFontUnderlineLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontUnderlineLabel }
 TkwStyleEditorFontFormFontStrikeoutLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontStrikeoutLabel }
 TkwStyleEditorFontFormFontSizeLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontSizeLabel }
 TkwStyleEditorFontFormFontNameLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontNameLabel }
 TkwStyleEditorFontFormFontItalicLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontItalicLabel }
 TkwStyleEditorFontFormFontForeColorLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontForeColorLabel }
 TkwStyleEditorFontFormFontBoldLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontBoldLabel }
 TkwStyleEditorFontFormFontBackColorLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontBackColorLabel }
 TkwStyleEditorFontFormFontScalableLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontScalableLabel }
 TkwStyleEditorFontFormFontScalableBevel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontScalableBevel }
 TkwStyleEditorFontFormFontStrikeoutInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontStrikeoutInheritanceButton }
 TkwStyleEditorFontFormFontSizeInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontSizeInheritanceButton }
 TkwStyleEditorFontFormFontNameInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontNameInheritanceButton }
 TkwStyleEditorFontFormFontItalicInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontItalicInheritanceButton }
 TkwStyleEditorFontFormFontForeColorInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontForeColorInheritanceButton }
 TkwStyleEditorFontFormFontBoldInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontBoldInheritanceButton }
 TkwStyleEditorFontFormFontBackColorInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontBackColorInheritanceButton }
 TkwStyleEditorFontFormFontUnderlineInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontUnderlineInheritanceButton }
 TkwStyleEditorFontFormFontUnderlineCheckBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontUnderlineCheckBox }
 TkwStyleEditorFontFormFontStrikeoutCheckBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontStrikeoutCheckBox }
 TkwStyleEditorFontFormFontSizeComboBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontSizeComboBox }
 TkwStyleEditorFontFormFontNameComboBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontNameComboBox }
 TkwStyleEditorFontFormFontItalicCheckBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontItalicCheckBox }
 TkwStyleEditorFontFormFontForeColorBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontForeColorBox }
 TkwStyleEditorFontFormFontBoldCheckBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontBoldCheckBox }
 TkwStyleEditorFontFormFontBackColorBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontBackColorBox }
 TkwStyleEditorFontFormFontScalableCheckBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FontScalableCheckBox }
 TkwStyleEditorFontFormLeftIndentLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_LeftIndentLabel }
 TkwStyleEditorFontFormLeftIndentComboBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_LeftIndentComboBox }
 TkwStyleEditorFontFormRightIndentLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_RightIndentLabel }
 TkwStyleEditorFontFormRightIndentComboBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_RightIndentComboBox }
 TkwStyleEditorFontFormFirstIndentLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FirstIndentLabel }
 TkwStyleEditorFontFormFirstIndentComboBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FirstIndentComboBox }
 TkwStyleEditorFontFormSpaceBeforeLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_SpaceBeforeLabel }
 TkwStyleEditorFontFormSpaceBeforeComboBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_SpaceBeforeComboBox }
 TkwStyleEditorFontFormSpaceAfterLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_SpaceAfterLabel }
 TkwStyleEditorFontFormSpaceAfterComboBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_SpaceAfterComboBox }
 TkwStyleEditorFontFormLeftIndentInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_LeftIndentInheritanceButton }
 TkwStyleEditorFontFormRightIndentInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_RightIndentInheritanceButton }
 TkwStyleEditorFontFormFirstIndentInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_FirstIndentInheritanceButton }
 TkwStyleEditorFontFormSpaceBeforeInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_SpaceBeforeInheritanceButton }
 TkwStyleEditorFontFormSpaceAfterInheritanceButton.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_SpaceAfterInheritanceButton }
 TkwStyleEditorFontFormStyleCaptionLabel.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_StyleCaptionLabel }
 TkwStyleEditorFontFormStyleCaptionComboBox.RegisterInEngine;
 {* Регистрация StyleEditorFontForm_StyleCaptionComboBox }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorFontForm));
 {* Регистрация типа StyleEditorFont }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TScrollBox));
 {* Регистрация типа TScrollBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBevel));
 {* Регистрация типа TBevel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* Регистрация типа TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* Регистрация типа TvtCheckBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBoxQS));
 {* Регистрация типа TvtComboBoxQS }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtColorBox));
 {* Регистрация типа TvtColorBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
