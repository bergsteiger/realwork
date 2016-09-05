unit StyleEditorFontKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы StyleEditorFont }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorFontKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "StyleEditorFontKeywordsPack" MUID: (4ABA143303B0_Pack)

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
 , StyleEditorFont_Form
 , tfwPropertyLike
 , Forms
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , vtLabel
 , ExtCtrls
 , ElPopBtn
 , vtCheckBox
 , vtComboBoxQS
 , vtColorBox
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4ABA143303B0_Packimpl_uses*
 //#UC END# *4ABA143303B0_Packimpl_uses*
;

type
 TkwStyleEditorFontFormFontScrollBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontScrollBox }
  private
   function FontScrollBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TScrollBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontScrollBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontScrollBox

 TkwStyleEditorFontFormFontUnderlineLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontUnderlineLabel }
  private
   function FontUnderlineLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontUnderlineLabel

 TkwStyleEditorFontFormFontStrikeoutLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontStrikeoutLabel }
  private
   function FontStrikeoutLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontStrikeoutLabel

 TkwStyleEditorFontFormFontSizeLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontSizeLabel }
  private
   function FontSizeLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontSizeLabel

 TkwStyleEditorFontFormFontNameLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontNameLabel }
  private
   function FontNameLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontNameLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontNameLabel

 TkwStyleEditorFontFormFontItalicLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontItalicLabel }
  private
   function FontItalicLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontItalicLabel

 TkwStyleEditorFontFormFontForeColorLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontForeColorLabel }
  private
   function FontForeColorLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontForeColorLabel

 TkwStyleEditorFontFormFontBoldLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontBoldLabel }
  private
   function FontBoldLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontBoldLabel

 TkwStyleEditorFontFormFontBackColorLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontBackColorLabel }
  private
   function FontBackColorLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontBackColorLabel

 TkwStyleEditorFontFormFontScalableLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontScalableLabel }
  private
   function FontScalableLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontScalableLabel

 TkwStyleEditorFontFormFontScalableBevel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontScalableBevel }
  private
   function FontScalableBevel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TBevel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableBevel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontScalableBevel

 TkwStyleEditorFontFormFontStrikeoutInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontStrikeoutInheritanceButton }
  private
   function FontStrikeoutInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton

 TkwStyleEditorFontFormFontSizeInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontSizeInheritanceButton }
  private
   function FontSizeInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontSizeInheritanceButton

 TkwStyleEditorFontFormFontNameInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontNameInheritanceButton }
  private
   function FontNameInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontNameInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontNameInheritanceButton

 TkwStyleEditorFontFormFontItalicInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontItalicInheritanceButton }
  private
   function FontItalicInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontItalicInheritanceButton

 TkwStyleEditorFontFormFontForeColorInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontForeColorInheritanceButton }
  private
   function FontForeColorInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontForeColorInheritanceButton

 TkwStyleEditorFontFormFontBoldInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontBoldInheritanceButton }
  private
   function FontBoldInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontBoldInheritanceButton

 TkwStyleEditorFontFormFontBackColorInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontBackColorInheritanceButton }
  private
   function FontBackColorInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontBackColorInheritanceButton

 TkwStyleEditorFontFormFontUnderlineInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontUnderlineInheritanceButton }
  private
   function FontUnderlineInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton

 TkwStyleEditorFontFormFontUnderlineCheckBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontUnderlineCheckBox }
  private
   function FontUnderlineCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineCheckBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontUnderlineCheckBox

 TkwStyleEditorFontFormFontStrikeoutCheckBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontStrikeoutCheckBox }
  private
   function FontStrikeoutCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutCheckBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontStrikeoutCheckBox

 TkwStyleEditorFontFormFontSizeComboBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontSizeComboBox }
  private
   function FontSizeComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeComboBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontSizeComboBox

 TkwStyleEditorFontFormFontNameComboBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontNameComboBox }
  private
   function FontNameComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontNameComboBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontNameComboBox

 TkwStyleEditorFontFormFontItalicCheckBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontItalicCheckBox }
  private
   function FontItalicCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicCheckBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontItalicCheckBox

 TkwStyleEditorFontFormFontForeColorBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontForeColorBox }
  private
   function FontForeColorBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontForeColorBox

 TkwStyleEditorFontFormFontBoldCheckBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontBoldCheckBox }
  private
   function FontBoldCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldCheckBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontBoldCheckBox

 TkwStyleEditorFontFormFontBackColorBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontBackColorBox }
  private
   function FontBackColorBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontBackColorBox

 TkwStyleEditorFontFormFontScalableCheckBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FontScalableCheckBox }
  private
   function FontScalableCheckBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
    {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableCheckBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFontScalableCheckBox

 TkwStyleEditorFontFormLeftIndentLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.LeftIndentLabel }
  private
   function LeftIndentLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormLeftIndentLabel

 TkwStyleEditorFontFormLeftIndentComboBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.LeftIndentComboBox }
  private
   function LeftIndentComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentComboBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormLeftIndentComboBox

 TkwStyleEditorFontFormRightIndentLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.RightIndentLabel }
  private
   function RightIndentLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormRightIndentLabel

 TkwStyleEditorFontFormRightIndentComboBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.RightIndentComboBox }
  private
   function RightIndentComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentComboBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormRightIndentComboBox

 TkwStyleEditorFontFormFirstIndentLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FirstIndentLabel }
  private
   function FirstIndentLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFirstIndentLabel

 TkwStyleEditorFontFormFirstIndentComboBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FirstIndentComboBox }
  private
   function FirstIndentComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentComboBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFirstIndentComboBox

 TkwStyleEditorFontFormSpaceBeforeLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.SpaceBeforeLabel }
  private
   function SpaceBeforeLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormSpaceBeforeLabel

 TkwStyleEditorFontFormSpaceBeforeComboBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.SpaceBeforeComboBox }
  private
   function SpaceBeforeComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeComboBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormSpaceBeforeComboBox

 TkwStyleEditorFontFormSpaceAfterLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.SpaceAfterLabel }
  private
   function SpaceAfterLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormSpaceAfterLabel

 TkwStyleEditorFontFormSpaceAfterComboBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.SpaceAfterComboBox }
  private
   function SpaceAfterComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterComboBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormSpaceAfterComboBox

 TkwStyleEditorFontFormLeftIndentInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.LeftIndentInheritanceButton }
  private
   function LeftIndentInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormLeftIndentInheritanceButton

 TkwStyleEditorFontFormRightIndentInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.RightIndentInheritanceButton }
  private
   function RightIndentInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormRightIndentInheritanceButton

 TkwStyleEditorFontFormFirstIndentInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.FirstIndentInheritanceButton }
  private
   function FirstIndentInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormFirstIndentInheritanceButton

 TkwStyleEditorFontFormSpaceBeforeInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.SpaceBeforeInheritanceButton }
  private
   function SpaceBeforeInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton

 TkwStyleEditorFontFormSpaceAfterInheritanceButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.SpaceAfterInheritanceButton }
  private
   function SpaceAfterInheritanceButton(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
    {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterInheritanceButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton

 TkwStyleEditorFontFormStyleCaptionLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.StyleCaptionLabel }
  private
   function StyleCaptionLabel(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
    {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormStyleCaptionLabel

 TkwStyleEditorFontFormStyleCaptionComboBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TStyleEditorFontForm.StyleCaptionComboBox }
  private
   function StyleCaptionComboBox(const aCtx: TtfwContext;
    aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
    {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionComboBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwStyleEditorFontFormStyleCaptionComboBox

 Tkw_Form_StyleEditorFont = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы StyleEditorFont
----
*Пример использования*:
[code]форма::StyleEditorFont TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_StyleEditorFont

 Tkw_StyleEditorFont_Control_FontScrollBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontScrollBox
----
*Пример использования*:
[code]контрол::FontScrollBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScrollBox

 Tkw_StyleEditorFont_Control_FontScrollBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontScrollBox
----
*Пример использования*:
[code]контрол::FontScrollBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push

 Tkw_StyleEditorFont_Control_FontUnderlineLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontUnderlineLabel
----
*Пример использования*:
[code]контрол::FontUnderlineLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel

 Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontUnderlineLabel
----
*Пример использования*:
[code]контрол::FontUnderlineLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push

 Tkw_StyleEditorFont_Control_FontStrikeoutLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontStrikeoutLabel
----
*Пример использования*:
[code]контрол::FontStrikeoutLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel

 Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontStrikeoutLabel
----
*Пример использования*:
[code]контрол::FontStrikeoutLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push

 Tkw_StyleEditorFont_Control_FontSizeLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontSizeLabel
----
*Пример использования*:
[code]контрол::FontSizeLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeLabel

 Tkw_StyleEditorFont_Control_FontSizeLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontSizeLabel
----
*Пример использования*:
[code]контрол::FontSizeLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push

 Tkw_StyleEditorFont_Control_FontNameLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontNameLabel
----
*Пример использования*:
[code]контрол::FontNameLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameLabel

 Tkw_StyleEditorFont_Control_FontNameLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontNameLabel
----
*Пример использования*:
[code]контрол::FontNameLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push

 Tkw_StyleEditorFont_Control_FontItalicLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontItalicLabel
----
*Пример использования*:
[code]контрол::FontItalicLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicLabel

 Tkw_StyleEditorFont_Control_FontItalicLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontItalicLabel
----
*Пример использования*:
[code]контрол::FontItalicLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push

 Tkw_StyleEditorFont_Control_FontForeColorLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontForeColorLabel
----
*Пример использования*:
[code]контрол::FontForeColorLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorLabel

 Tkw_StyleEditorFont_Control_FontForeColorLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontForeColorLabel
----
*Пример использования*:
[code]контрол::FontForeColorLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push

 Tkw_StyleEditorFont_Control_FontBoldLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBoldLabel
----
*Пример использования*:
[code]контрол::FontBoldLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldLabel

 Tkw_StyleEditorFont_Control_FontBoldLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBoldLabel
----
*Пример использования*:
[code]контрол::FontBoldLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push

 Tkw_StyleEditorFont_Control_FontBackColorLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBackColorLabel
----
*Пример использования*:
[code]контрол::FontBackColorLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorLabel

 Tkw_StyleEditorFont_Control_FontBackColorLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBackColorLabel
----
*Пример использования*:
[code]контрол::FontBackColorLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push

 Tkw_StyleEditorFont_Control_FontScalableLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontScalableLabel
----
*Пример использования*:
[code]контрол::FontScalableLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableLabel

 Tkw_StyleEditorFont_Control_FontScalableLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontScalableLabel
----
*Пример использования*:
[code]контрол::FontScalableLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push

 Tkw_StyleEditorFont_Control_FontScalableBevel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontScalableBevel
----
*Пример использования*:
[code]контрол::FontScalableBevel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableBevel

 Tkw_StyleEditorFont_Control_FontScalableBevel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontScalableBevel
----
*Пример использования*:
[code]контрол::FontScalableBevel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push

 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontStrikeoutInheritanceButton
----
*Пример использования*:
[code]контрол::FontStrikeoutInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton

 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontStrikeoutInheritanceButton
----
*Пример использования*:
[code]контрол::FontStrikeoutInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontSizeInheritanceButton
----
*Пример использования*:
[code]контрол::FontSizeInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton

 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontSizeInheritanceButton
----
*Пример использования*:
[code]контрол::FontSizeInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontNameInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontNameInheritanceButton
----
*Пример использования*:
[code]контрол::FontNameInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton

 Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontNameInheritanceButton
----
*Пример использования*:
[code]контрол::FontNameInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontItalicInheritanceButton
----
*Пример использования*:
[code]контрол::FontItalicInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton

 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontItalicInheritanceButton
----
*Пример использования*:
[code]контрол::FontItalicInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontForeColorInheritanceButton
----
*Пример использования*:
[code]контрол::FontForeColorInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton

 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontForeColorInheritanceButton
----
*Пример использования*:
[code]контрол::FontForeColorInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBoldInheritanceButton
----
*Пример использования*:
[code]контрол::FontBoldInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton

 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBoldInheritanceButton
----
*Пример использования*:
[code]контрол::FontBoldInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBackColorInheritanceButton
----
*Пример использования*:
[code]контрол::FontBackColorInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton

 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBackColorInheritanceButton
----
*Пример использования*:
[code]контрол::FontBackColorInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontUnderlineInheritanceButton
----
*Пример использования*:
[code]контрол::FontUnderlineInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton

 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontUnderlineInheritanceButton
----
*Пример использования*:
[code]контрол::FontUnderlineInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontUnderlineCheckBox
----
*Пример использования*:
[code]контрол::FontUnderlineCheckBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox

 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontUnderlineCheckBox
----
*Пример использования*:
[code]контрол::FontUnderlineCheckBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push

 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontStrikeoutCheckBox
----
*Пример использования*:
[code]контрол::FontStrikeoutCheckBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox

 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontStrikeoutCheckBox
----
*Пример использования*:
[code]контрол::FontStrikeoutCheckBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push

 Tkw_StyleEditorFont_Control_FontSizeComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontSizeComboBox
----
*Пример использования*:
[code]контрол::FontSizeComboBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeComboBox

 Tkw_StyleEditorFont_Control_FontSizeComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontSizeComboBox
----
*Пример использования*:
[code]контрол::FontSizeComboBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push

 Tkw_StyleEditorFont_Control_FontNameComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontNameComboBox
----
*Пример использования*:
[code]контрол::FontNameComboBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameComboBox

 Tkw_StyleEditorFont_Control_FontNameComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontNameComboBox
----
*Пример использования*:
[code]контрол::FontNameComboBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push

 Tkw_StyleEditorFont_Control_FontItalicCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontItalicCheckBox
----
*Пример использования*:
[code]контрол::FontItalicCheckBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox

 Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontItalicCheckBox
----
*Пример использования*:
[code]контрол::FontItalicCheckBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push

 Tkw_StyleEditorFont_Control_FontForeColorBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontForeColorBox
----
*Пример использования*:
[code]контрол::FontForeColorBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorBox

 Tkw_StyleEditorFont_Control_FontForeColorBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontForeColorBox
----
*Пример использования*:
[code]контрол::FontForeColorBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push

 Tkw_StyleEditorFont_Control_FontBoldCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBoldCheckBox
----
*Пример использования*:
[code]контрол::FontBoldCheckBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox

 Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBoldCheckBox
----
*Пример использования*:
[code]контрол::FontBoldCheckBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push

 Tkw_StyleEditorFont_Control_FontBackColorBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontBackColorBox
----
*Пример использования*:
[code]контрол::FontBackColorBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorBox

 Tkw_StyleEditorFont_Control_FontBackColorBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontBackColorBox
----
*Пример использования*:
[code]контрол::FontBackColorBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push

 Tkw_StyleEditorFont_Control_FontScalableCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FontScalableCheckBox
----
*Пример использования*:
[code]контрол::FontScalableCheckBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox

 Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FontScalableCheckBox
----
*Пример использования*:
[code]контрол::FontScalableCheckBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push

 Tkw_StyleEditorFont_Control_LeftIndentLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftIndentLabel
----
*Пример использования*:
[code]контрол::LeftIndentLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentLabel

 Tkw_StyleEditorFont_Control_LeftIndentLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftIndentLabel
----
*Пример использования*:
[code]контрол::LeftIndentLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push

 Tkw_StyleEditorFont_Control_LeftIndentComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftIndentComboBox
----
*Пример использования*:
[code]контрол::LeftIndentComboBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox

 Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftIndentComboBox
----
*Пример использования*:
[code]контрол::LeftIndentComboBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push

 Tkw_StyleEditorFont_Control_RightIndentLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightIndentLabel
----
*Пример использования*:
[code]контрол::RightIndentLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentLabel

 Tkw_StyleEditorFont_Control_RightIndentLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightIndentLabel
----
*Пример использования*:
[code]контрол::RightIndentLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push

 Tkw_StyleEditorFont_Control_RightIndentComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightIndentComboBox
----
*Пример использования*:
[code]контрол::RightIndentComboBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentComboBox

 Tkw_StyleEditorFont_Control_RightIndentComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightIndentComboBox
----
*Пример использования*:
[code]контрол::RightIndentComboBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push

 Tkw_StyleEditorFont_Control_FirstIndentLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FirstIndentLabel
----
*Пример использования*:
[code]контрол::FirstIndentLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentLabel

 Tkw_StyleEditorFont_Control_FirstIndentLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FirstIndentLabel
----
*Пример использования*:
[code]контрол::FirstIndentLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push

 Tkw_StyleEditorFont_Control_FirstIndentComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FirstIndentComboBox
----
*Пример использования*:
[code]контрол::FirstIndentComboBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox

 Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FirstIndentComboBox
----
*Пример использования*:
[code]контрол::FirstIndentComboBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push

 Tkw_StyleEditorFont_Control_SpaceBeforeLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceBeforeLabel
----
*Пример использования*:
[code]контрол::SpaceBeforeLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel

 Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceBeforeLabel
----
*Пример использования*:
[code]контрол::SpaceBeforeLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push

 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceBeforeComboBox
----
*Пример использования*:
[code]контрол::SpaceBeforeComboBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox

 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceBeforeComboBox
----
*Пример использования*:
[code]контрол::SpaceBeforeComboBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push

 Tkw_StyleEditorFont_Control_SpaceAfterLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceAfterLabel
----
*Пример использования*:
[code]контрол::SpaceAfterLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel

 Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceAfterLabel
----
*Пример использования*:
[code]контрол::SpaceAfterLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push

 Tkw_StyleEditorFont_Control_SpaceAfterComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceAfterComboBox
----
*Пример использования*:
[code]контрол::SpaceAfterComboBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox

 Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceAfterComboBox
----
*Пример использования*:
[code]контрол::SpaceAfterComboBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push

 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftIndentInheritanceButton
----
*Пример использования*:
[code]контрол::LeftIndentInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton

 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftIndentInheritanceButton
----
*Пример использования*:
[code]контрол::LeftIndentInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push

 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightIndentInheritanceButton
----
*Пример использования*:
[code]контрол::RightIndentInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton

 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightIndentInheritanceButton
----
*Пример использования*:
[code]контрол::RightIndentInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push

 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FirstIndentInheritanceButton
----
*Пример использования*:
[code]контрол::FirstIndentInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton

 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FirstIndentInheritanceButton
----
*Пример использования*:
[code]контрол::FirstIndentInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push

 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceBeforeInheritanceButton
----
*Пример использования*:
[code]контрол::SpaceBeforeInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton

 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceBeforeInheritanceButton
----
*Пример использования*:
[code]контрол::SpaceBeforeInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push

 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SpaceAfterInheritanceButton
----
*Пример использования*:
[code]контрол::SpaceAfterInheritanceButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton

 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SpaceAfterInheritanceButton
----
*Пример использования*:
[code]контрол::SpaceAfterInheritanceButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push

 Tkw_StyleEditorFont_Control_StyleCaptionLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StyleCaptionLabel
----
*Пример использования*:
[code]контрол::StyleCaptionLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel

 Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола StyleCaptionLabel
----
*Пример использования*:
[code]контрол::StyleCaptionLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push

 Tkw_StyleEditorFont_Control_StyleCaptionComboBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола StyleCaptionComboBox
----
*Пример использования*:
[code]контрол::StyleCaptionComboBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox

 Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола StyleCaptionComboBox
----
*Пример использования*:
[code]контрол::StyleCaptionComboBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push

function TkwStyleEditorFontFormFontScrollBox.FontScrollBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TScrollBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontScrollBox }
begin
 Result := aStyleEditorFontForm.FontScrollBox;
end;//TkwStyleEditorFontFormFontScrollBox.FontScrollBox

class function TkwStyleEditorFontFormFontScrollBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScrollBox';
end;//TkwStyleEditorFontFormFontScrollBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontScrollBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontScrollBox', aCtx);
end;//TkwStyleEditorFontFormFontScrollBox.SetValuePrim

procedure TkwStyleEditorFontFormFontScrollBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontScrollBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontScrollBox.DoDoIt

function TkwStyleEditorFontFormFontUnderlineLabel.FontUnderlineLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineLabel }
begin
 Result := aStyleEditorFontForm.FontUnderlineLabel;
end;//TkwStyleEditorFontFormFontUnderlineLabel.FontUnderlineLabel

class function TkwStyleEditorFontFormFontUnderlineLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontUnderlineLabel';
end;//TkwStyleEditorFontFormFontUnderlineLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontUnderlineLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontUnderlineLabel', aCtx);
end;//TkwStyleEditorFontFormFontUnderlineLabel.SetValuePrim

procedure TkwStyleEditorFontFormFontUnderlineLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontUnderlineLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontUnderlineLabel.DoDoIt

function TkwStyleEditorFontFormFontStrikeoutLabel.FontStrikeoutLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutLabel }
begin
 Result := aStyleEditorFontForm.FontStrikeoutLabel;
end;//TkwStyleEditorFontFormFontStrikeoutLabel.FontStrikeoutLabel

class function TkwStyleEditorFontFormFontStrikeoutLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutLabel';
end;//TkwStyleEditorFontFormFontStrikeoutLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontStrikeoutLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontStrikeoutLabel', aCtx);
end;//TkwStyleEditorFontFormFontStrikeoutLabel.SetValuePrim

procedure TkwStyleEditorFontFormFontStrikeoutLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontStrikeoutLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontStrikeoutLabel.DoDoIt

function TkwStyleEditorFontFormFontSizeLabel.FontSizeLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeLabel }
begin
 Result := aStyleEditorFontForm.FontSizeLabel;
end;//TkwStyleEditorFontFormFontSizeLabel.FontSizeLabel

class function TkwStyleEditorFontFormFontSizeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontSizeLabel';
end;//TkwStyleEditorFontFormFontSizeLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontSizeLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontSizeLabel', aCtx);
end;//TkwStyleEditorFontFormFontSizeLabel.SetValuePrim

procedure TkwStyleEditorFontFormFontSizeLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontSizeLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontSizeLabel.DoDoIt

function TkwStyleEditorFontFormFontNameLabel.FontNameLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontNameLabel }
begin
 Result := aStyleEditorFontForm.FontNameLabel;
end;//TkwStyleEditorFontFormFontNameLabel.FontNameLabel

class function TkwStyleEditorFontFormFontNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontNameLabel';
end;//TkwStyleEditorFontFormFontNameLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontNameLabel', aCtx);
end;//TkwStyleEditorFontFormFontNameLabel.SetValuePrim

procedure TkwStyleEditorFontFormFontNameLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontNameLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontNameLabel.DoDoIt

function TkwStyleEditorFontFormFontItalicLabel.FontItalicLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicLabel }
begin
 Result := aStyleEditorFontForm.FontItalicLabel;
end;//TkwStyleEditorFontFormFontItalicLabel.FontItalicLabel

class function TkwStyleEditorFontFormFontItalicLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontItalicLabel';
end;//TkwStyleEditorFontFormFontItalicLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontItalicLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontItalicLabel', aCtx);
end;//TkwStyleEditorFontFormFontItalicLabel.SetValuePrim

procedure TkwStyleEditorFontFormFontItalicLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontItalicLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontItalicLabel.DoDoIt

function TkwStyleEditorFontFormFontForeColorLabel.FontForeColorLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorLabel }
begin
 Result := aStyleEditorFontForm.FontForeColorLabel;
end;//TkwStyleEditorFontFormFontForeColorLabel.FontForeColorLabel

class function TkwStyleEditorFontFormFontForeColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontForeColorLabel';
end;//TkwStyleEditorFontFormFontForeColorLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontForeColorLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontForeColorLabel', aCtx);
end;//TkwStyleEditorFontFormFontForeColorLabel.SetValuePrim

procedure TkwStyleEditorFontFormFontForeColorLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontForeColorLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontForeColorLabel.DoDoIt

function TkwStyleEditorFontFormFontBoldLabel.FontBoldLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldLabel }
begin
 Result := aStyleEditorFontForm.FontBoldLabel;
end;//TkwStyleEditorFontFormFontBoldLabel.FontBoldLabel

class function TkwStyleEditorFontFormFontBoldLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBoldLabel';
end;//TkwStyleEditorFontFormFontBoldLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontBoldLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBoldLabel', aCtx);
end;//TkwStyleEditorFontFormFontBoldLabel.SetValuePrim

procedure TkwStyleEditorFontFormFontBoldLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBoldLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBoldLabel.DoDoIt

function TkwStyleEditorFontFormFontBackColorLabel.FontBackColorLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorLabel }
begin
 Result := aStyleEditorFontForm.FontBackColorLabel;
end;//TkwStyleEditorFontFormFontBackColorLabel.FontBackColorLabel

class function TkwStyleEditorFontFormFontBackColorLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBackColorLabel';
end;//TkwStyleEditorFontFormFontBackColorLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontBackColorLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBackColorLabel', aCtx);
end;//TkwStyleEditorFontFormFontBackColorLabel.SetValuePrim

procedure TkwStyleEditorFontFormFontBackColorLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBackColorLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBackColorLabel.DoDoIt

function TkwStyleEditorFontFormFontScalableLabel.FontScalableLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableLabel }
begin
 Result := aStyleEditorFontForm.FontScalableLabel;
end;//TkwStyleEditorFontFormFontScalableLabel.FontScalableLabel

class function TkwStyleEditorFontFormFontScalableLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScalableLabel';
end;//TkwStyleEditorFontFormFontScalableLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontScalableLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontScalableLabel', aCtx);
end;//TkwStyleEditorFontFormFontScalableLabel.SetValuePrim

procedure TkwStyleEditorFontFormFontScalableLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontScalableLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontScalableLabel.DoDoIt

function TkwStyleEditorFontFormFontScalableBevel.FontScalableBevel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TBevel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableBevel }
begin
 Result := aStyleEditorFontForm.FontScalableBevel;
end;//TkwStyleEditorFontFormFontScalableBevel.FontScalableBevel

class function TkwStyleEditorFontFormFontScalableBevel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScalableBevel';
end;//TkwStyleEditorFontFormFontScalableBevel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontScalableBevel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontScalableBevel', aCtx);
end;//TkwStyleEditorFontFormFontScalableBevel.SetValuePrim

procedure TkwStyleEditorFontFormFontScalableBevel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontScalableBevel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontScalableBevel.DoDoIt

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.FontStrikeoutInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontStrikeoutInheritanceButton;
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.FontStrikeoutInheritanceButton

class function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutInheritanceButton';
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontStrikeoutInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontStrikeoutInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormFontStrikeoutInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontStrikeoutInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.DoDoIt

function TkwStyleEditorFontFormFontSizeInheritanceButton.FontSizeInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontSizeInheritanceButton;
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.FontSizeInheritanceButton

class function TkwStyleEditorFontFormFontSizeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontSizeInheritanceButton';
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontSizeInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontSizeInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormFontSizeInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontSizeInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.DoDoIt

function TkwStyleEditorFontFormFontNameInheritanceButton.FontNameInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontNameInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontNameInheritanceButton;
end;//TkwStyleEditorFontFormFontNameInheritanceButton.FontNameInheritanceButton

class function TkwStyleEditorFontFormFontNameInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontNameInheritanceButton';
end;//TkwStyleEditorFontFormFontNameInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontNameInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontNameInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontNameInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormFontNameInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontNameInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontNameInheritanceButton.DoDoIt

function TkwStyleEditorFontFormFontItalicInheritanceButton.FontItalicInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontItalicInheritanceButton;
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.FontItalicInheritanceButton

class function TkwStyleEditorFontFormFontItalicInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontItalicInheritanceButton';
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontItalicInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontItalicInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormFontItalicInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontItalicInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.DoDoIt

function TkwStyleEditorFontFormFontForeColorInheritanceButton.FontForeColorInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontForeColorInheritanceButton;
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.FontForeColorInheritanceButton

class function TkwStyleEditorFontFormFontForeColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontForeColorInheritanceButton';
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontForeColorInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontForeColorInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormFontForeColorInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontForeColorInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.DoDoIt

function TkwStyleEditorFontFormFontBoldInheritanceButton.FontBoldInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontBoldInheritanceButton;
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.FontBoldInheritanceButton

class function TkwStyleEditorFontFormFontBoldInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBoldInheritanceButton';
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontBoldInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBoldInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormFontBoldInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBoldInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.DoDoIt

function TkwStyleEditorFontFormFontBackColorInheritanceButton.FontBackColorInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontBackColorInheritanceButton;
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.FontBackColorInheritanceButton

class function TkwStyleEditorFontFormFontBackColorInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBackColorInheritanceButton';
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontBackColorInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBackColorInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormFontBackColorInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBackColorInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.DoDoIt

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.FontUnderlineInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineInheritanceButton }
begin
 Result := aStyleEditorFontForm.FontUnderlineInheritanceButton;
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.FontUnderlineInheritanceButton

class function TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontUnderlineInheritanceButton';
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontUnderlineInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontUnderlineInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormFontUnderlineInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontUnderlineInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.DoDoIt

function TkwStyleEditorFontFormFontUnderlineCheckBox.FontUnderlineCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineCheckBox }
begin
 Result := aStyleEditorFontForm.FontUnderlineCheckBox;
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.FontUnderlineCheckBox

class function TkwStyleEditorFontFormFontUnderlineCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontUnderlineCheckBox';
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontUnderlineCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontUnderlineCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.SetValuePrim

procedure TkwStyleEditorFontFormFontUnderlineCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontUnderlineCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.DoDoIt

function TkwStyleEditorFontFormFontStrikeoutCheckBox.FontStrikeoutCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutCheckBox }
begin
 Result := aStyleEditorFontForm.FontStrikeoutCheckBox;
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.FontStrikeoutCheckBox

class function TkwStyleEditorFontFormFontStrikeoutCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutCheckBox';
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontStrikeoutCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontStrikeoutCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.SetValuePrim

procedure TkwStyleEditorFontFormFontStrikeoutCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontStrikeoutCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.DoDoIt

function TkwStyleEditorFontFormFontSizeComboBox.FontSizeComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeComboBox }
begin
 Result := aStyleEditorFontForm.FontSizeComboBox;
end;//TkwStyleEditorFontFormFontSizeComboBox.FontSizeComboBox

class function TkwStyleEditorFontFormFontSizeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontSizeComboBox';
end;//TkwStyleEditorFontFormFontSizeComboBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontSizeComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontSizeComboBox', aCtx);
end;//TkwStyleEditorFontFormFontSizeComboBox.SetValuePrim

procedure TkwStyleEditorFontFormFontSizeComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontSizeComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontSizeComboBox.DoDoIt

function TkwStyleEditorFontFormFontNameComboBox.FontNameComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontNameComboBox }
begin
 Result := aStyleEditorFontForm.FontNameComboBox;
end;//TkwStyleEditorFontFormFontNameComboBox.FontNameComboBox

class function TkwStyleEditorFontFormFontNameComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontNameComboBox';
end;//TkwStyleEditorFontFormFontNameComboBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontNameComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontNameComboBox', aCtx);
end;//TkwStyleEditorFontFormFontNameComboBox.SetValuePrim

procedure TkwStyleEditorFontFormFontNameComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontNameComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontNameComboBox.DoDoIt

function TkwStyleEditorFontFormFontItalicCheckBox.FontItalicCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicCheckBox }
begin
 Result := aStyleEditorFontForm.FontItalicCheckBox;
end;//TkwStyleEditorFontFormFontItalicCheckBox.FontItalicCheckBox

class function TkwStyleEditorFontFormFontItalicCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontItalicCheckBox';
end;//TkwStyleEditorFontFormFontItalicCheckBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontItalicCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontItalicCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontItalicCheckBox.SetValuePrim

procedure TkwStyleEditorFontFormFontItalicCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontItalicCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontItalicCheckBox.DoDoIt

function TkwStyleEditorFontFormFontForeColorBox.FontForeColorBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorBox }
begin
 Result := aStyleEditorFontForm.FontForeColorBox;
end;//TkwStyleEditorFontFormFontForeColorBox.FontForeColorBox

class function TkwStyleEditorFontFormFontForeColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontForeColorBox';
end;//TkwStyleEditorFontFormFontForeColorBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontForeColorBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontForeColorBox', aCtx);
end;//TkwStyleEditorFontFormFontForeColorBox.SetValuePrim

procedure TkwStyleEditorFontFormFontForeColorBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontForeColorBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontForeColorBox.DoDoIt

function TkwStyleEditorFontFormFontBoldCheckBox.FontBoldCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldCheckBox }
begin
 Result := aStyleEditorFontForm.FontBoldCheckBox;
end;//TkwStyleEditorFontFormFontBoldCheckBox.FontBoldCheckBox

class function TkwStyleEditorFontFormFontBoldCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBoldCheckBox';
end;//TkwStyleEditorFontFormFontBoldCheckBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontBoldCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBoldCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontBoldCheckBox.SetValuePrim

procedure TkwStyleEditorFontFormFontBoldCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBoldCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBoldCheckBox.DoDoIt

function TkwStyleEditorFontFormFontBackColorBox.FontBackColorBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorBox }
begin
 Result := aStyleEditorFontForm.FontBackColorBox;
end;//TkwStyleEditorFontFormFontBackColorBox.FontBackColorBox

class function TkwStyleEditorFontFormFontBackColorBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontBackColorBox';
end;//TkwStyleEditorFontFormFontBackColorBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontBackColorBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBackColorBox', aCtx);
end;//TkwStyleEditorFontFormFontBackColorBox.SetValuePrim

procedure TkwStyleEditorFontFormFontBackColorBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontBackColorBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontBackColorBox.DoDoIt

function TkwStyleEditorFontFormFontScalableCheckBox.FontScalableCheckBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableCheckBox }
begin
 Result := aStyleEditorFontForm.FontScalableCheckBox;
end;//TkwStyleEditorFontFormFontScalableCheckBox.FontScalableCheckBox

class function TkwStyleEditorFontFormFontScalableCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FontScalableCheckBox';
end;//TkwStyleEditorFontFormFontScalableCheckBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFontScalableCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontScalableCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontScalableCheckBox.SetValuePrim

procedure TkwStyleEditorFontFormFontScalableCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FontScalableCheckBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFontScalableCheckBox.DoDoIt

function TkwStyleEditorFontFormLeftIndentLabel.LeftIndentLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentLabel }
begin
 Result := aStyleEditorFontForm.LeftIndentLabel;
end;//TkwStyleEditorFontFormLeftIndentLabel.LeftIndentLabel

class function TkwStyleEditorFontFormLeftIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.LeftIndentLabel';
end;//TkwStyleEditorFontFormLeftIndentLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormLeftIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftIndentLabel', aCtx);
end;//TkwStyleEditorFontFormLeftIndentLabel.SetValuePrim

procedure TkwStyleEditorFontFormLeftIndentLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftIndentLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormLeftIndentLabel.DoDoIt

function TkwStyleEditorFontFormLeftIndentComboBox.LeftIndentComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentComboBox }
begin
 Result := aStyleEditorFontForm.LeftIndentComboBox;
end;//TkwStyleEditorFontFormLeftIndentComboBox.LeftIndentComboBox

class function TkwStyleEditorFontFormLeftIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.LeftIndentComboBox';
end;//TkwStyleEditorFontFormLeftIndentComboBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormLeftIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftIndentComboBox', aCtx);
end;//TkwStyleEditorFontFormLeftIndentComboBox.SetValuePrim

procedure TkwStyleEditorFontFormLeftIndentComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftIndentComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormLeftIndentComboBox.DoDoIt

function TkwStyleEditorFontFormRightIndentLabel.RightIndentLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentLabel }
begin
 Result := aStyleEditorFontForm.RightIndentLabel;
end;//TkwStyleEditorFontFormRightIndentLabel.RightIndentLabel

class function TkwStyleEditorFontFormRightIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.RightIndentLabel';
end;//TkwStyleEditorFontFormRightIndentLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormRightIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightIndentLabel', aCtx);
end;//TkwStyleEditorFontFormRightIndentLabel.SetValuePrim

procedure TkwStyleEditorFontFormRightIndentLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightIndentLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormRightIndentLabel.DoDoIt

function TkwStyleEditorFontFormRightIndentComboBox.RightIndentComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentComboBox }
begin
 Result := aStyleEditorFontForm.RightIndentComboBox;
end;//TkwStyleEditorFontFormRightIndentComboBox.RightIndentComboBox

class function TkwStyleEditorFontFormRightIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.RightIndentComboBox';
end;//TkwStyleEditorFontFormRightIndentComboBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormRightIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightIndentComboBox', aCtx);
end;//TkwStyleEditorFontFormRightIndentComboBox.SetValuePrim

procedure TkwStyleEditorFontFormRightIndentComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightIndentComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormRightIndentComboBox.DoDoIt

function TkwStyleEditorFontFormFirstIndentLabel.FirstIndentLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentLabel }
begin
 Result := aStyleEditorFontForm.FirstIndentLabel;
end;//TkwStyleEditorFontFormFirstIndentLabel.FirstIndentLabel

class function TkwStyleEditorFontFormFirstIndentLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FirstIndentLabel';
end;//TkwStyleEditorFontFormFirstIndentLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFirstIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FirstIndentLabel', aCtx);
end;//TkwStyleEditorFontFormFirstIndentLabel.SetValuePrim

procedure TkwStyleEditorFontFormFirstIndentLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FirstIndentLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFirstIndentLabel.DoDoIt

function TkwStyleEditorFontFormFirstIndentComboBox.FirstIndentComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentComboBox }
begin
 Result := aStyleEditorFontForm.FirstIndentComboBox;
end;//TkwStyleEditorFontFormFirstIndentComboBox.FirstIndentComboBox

class function TkwStyleEditorFontFormFirstIndentComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FirstIndentComboBox';
end;//TkwStyleEditorFontFormFirstIndentComboBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFirstIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FirstIndentComboBox', aCtx);
end;//TkwStyleEditorFontFormFirstIndentComboBox.SetValuePrim

procedure TkwStyleEditorFontFormFirstIndentComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FirstIndentComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFirstIndentComboBox.DoDoIt

function TkwStyleEditorFontFormSpaceBeforeLabel.SpaceBeforeLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeLabel }
begin
 Result := aStyleEditorFontForm.SpaceBeforeLabel;
end;//TkwStyleEditorFontFormSpaceBeforeLabel.SpaceBeforeLabel

class function TkwStyleEditorFontFormSpaceBeforeLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeLabel';
end;//TkwStyleEditorFontFormSpaceBeforeLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormSpaceBeforeLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceBeforeLabel', aCtx);
end;//TkwStyleEditorFontFormSpaceBeforeLabel.SetValuePrim

procedure TkwStyleEditorFontFormSpaceBeforeLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceBeforeLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceBeforeLabel.DoDoIt

function TkwStyleEditorFontFormSpaceBeforeComboBox.SpaceBeforeComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeComboBox }
begin
 Result := aStyleEditorFontForm.SpaceBeforeComboBox;
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.SpaceBeforeComboBox

class function TkwStyleEditorFontFormSpaceBeforeComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeComboBox';
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormSpaceBeforeComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceBeforeComboBox', aCtx);
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.SetValuePrim

procedure TkwStyleEditorFontFormSpaceBeforeComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceBeforeComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.DoDoIt

function TkwStyleEditorFontFormSpaceAfterLabel.SpaceAfterLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterLabel }
begin
 Result := aStyleEditorFontForm.SpaceAfterLabel;
end;//TkwStyleEditorFontFormSpaceAfterLabel.SpaceAfterLabel

class function TkwStyleEditorFontFormSpaceAfterLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceAfterLabel';
end;//TkwStyleEditorFontFormSpaceAfterLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormSpaceAfterLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceAfterLabel', aCtx);
end;//TkwStyleEditorFontFormSpaceAfterLabel.SetValuePrim

procedure TkwStyleEditorFontFormSpaceAfterLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceAfterLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceAfterLabel.DoDoIt

function TkwStyleEditorFontFormSpaceAfterComboBox.SpaceAfterComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterComboBox }
begin
 Result := aStyleEditorFontForm.SpaceAfterComboBox;
end;//TkwStyleEditorFontFormSpaceAfterComboBox.SpaceAfterComboBox

class function TkwStyleEditorFontFormSpaceAfterComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceAfterComboBox';
end;//TkwStyleEditorFontFormSpaceAfterComboBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormSpaceAfterComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceAfterComboBox', aCtx);
end;//TkwStyleEditorFontFormSpaceAfterComboBox.SetValuePrim

procedure TkwStyleEditorFontFormSpaceAfterComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceAfterComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceAfterComboBox.DoDoIt

function TkwStyleEditorFontFormLeftIndentInheritanceButton.LeftIndentInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentInheritanceButton }
begin
 Result := aStyleEditorFontForm.LeftIndentInheritanceButton;
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.LeftIndentInheritanceButton

class function TkwStyleEditorFontFormLeftIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.LeftIndentInheritanceButton';
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormLeftIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftIndentInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormLeftIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftIndentInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.DoDoIt

function TkwStyleEditorFontFormRightIndentInheritanceButton.RightIndentInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentInheritanceButton }
begin
 Result := aStyleEditorFontForm.RightIndentInheritanceButton;
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.RightIndentInheritanceButton

class function TkwStyleEditorFontFormRightIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.RightIndentInheritanceButton';
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormRightIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightIndentInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormRightIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightIndentInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.DoDoIt

function TkwStyleEditorFontFormFirstIndentInheritanceButton.FirstIndentInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentInheritanceButton }
begin
 Result := aStyleEditorFontForm.FirstIndentInheritanceButton;
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.FirstIndentInheritanceButton

class function TkwStyleEditorFontFormFirstIndentInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.FirstIndentInheritanceButton';
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormFirstIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FirstIndentInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormFirstIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FirstIndentInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.DoDoIt

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SpaceBeforeInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeInheritanceButton }
begin
 Result := aStyleEditorFontForm.SpaceBeforeInheritanceButton;
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SpaceBeforeInheritanceButton

class function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeInheritanceButton';
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceBeforeInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormSpaceBeforeInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceBeforeInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.DoDoIt

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.SpaceAfterInheritanceButton(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterInheritanceButton }
begin
 Result := aStyleEditorFontForm.SpaceAfterInheritanceButton;
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.SpaceAfterInheritanceButton

class function TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.SpaceAfterInheritanceButton';
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormSpaceAfterInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceAfterInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.SetValuePrim

procedure TkwStyleEditorFontFormSpaceAfterInheritanceButton.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SpaceAfterInheritanceButton(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.DoDoIt

function TkwStyleEditorFontFormStyleCaptionLabel.StyleCaptionLabel(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionLabel }
begin
 Result := aStyleEditorFontForm.StyleCaptionLabel;
end;//TkwStyleEditorFontFormStyleCaptionLabel.StyleCaptionLabel

class function TkwStyleEditorFontFormStyleCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.StyleCaptionLabel';
end;//TkwStyleEditorFontFormStyleCaptionLabel.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormStyleCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству StyleCaptionLabel', aCtx);
end;//TkwStyleEditorFontFormStyleCaptionLabel.SetValuePrim

procedure TkwStyleEditorFontFormStyleCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StyleCaptionLabel(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormStyleCaptionLabel.DoDoIt

function TkwStyleEditorFontFormStyleCaptionComboBox.StyleCaptionComboBox(const aCtx: TtfwContext;
 aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionComboBox }
begin
 Result := aStyleEditorFontForm.StyleCaptionComboBox;
end;//TkwStyleEditorFontFormStyleCaptionComboBox.StyleCaptionComboBox

class function TkwStyleEditorFontFormStyleCaptionComboBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TStyleEditorFontForm.StyleCaptionComboBox';
end;//TkwStyleEditorFontFormStyleCaptionComboBox.GetWordNameForRegister

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

procedure TkwStyleEditorFontFormStyleCaptionComboBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству StyleCaptionComboBox', aCtx);
end;//TkwStyleEditorFontFormStyleCaptionComboBox.SetValuePrim

procedure TkwStyleEditorFontFormStyleCaptionComboBox.DoDoIt(const aCtx: TtfwContext);
var l_aStyleEditorFontForm: TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(StyleCaptionComboBox(aCtx, l_aStyleEditorFontForm));
end;//TkwStyleEditorFontFormStyleCaptionComboBox.DoDoIt

function Tkw_Form_StyleEditorFont.GetString: AnsiString;
begin
 Result := 'StyleEditorFontForm';
end;//Tkw_Form_StyleEditorFont.GetString

class procedure Tkw_Form_StyleEditorFont.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TStyleEditorFontForm);
end;//Tkw_Form_StyleEditorFont.RegisterInEngine

class function Tkw_Form_StyleEditorFont.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::StyleEditorFont';
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
 Result := 'контрол::FontScrollBox';
end;//Tkw_StyleEditorFont_Control_FontScrollBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontScrollBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontScrollBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScrollBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScrollBox:push';
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
 Result := 'контрол::FontUnderlineLabel';
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontUnderlineLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontUnderlineLabel:push';
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
 Result := 'контрол::FontStrikeoutLabel';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontStrikeoutLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontStrikeoutLabel:push';
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
 Result := 'контрол::FontSizeLabel';
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontSizeLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontSizeLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontSizeLabel:push';
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
 Result := 'контрол::FontNameLabel';
end;//Tkw_StyleEditorFont_Control_FontNameLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontNameLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontNameLabel:push';
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
 Result := 'контрол::FontItalicLabel';
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontItalicLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontItalicLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontItalicLabel:push';
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
 Result := 'контрол::FontForeColorLabel';
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontForeColorLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontForeColorLabel:push';
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
 Result := 'контрол::FontBoldLabel';
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBoldLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBoldLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBoldLabel:push';
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
 Result := 'контрол::FontBackColorLabel';
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBackColorLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBackColorLabel:push';
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
 Result := 'контрол::FontScalableLabel';
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontScalableLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontScalableLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScalableLabel:push';
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
 Result := 'контрол::FontScalableBevel';
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontScalableBevel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontScalableBevel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableBevel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScalableBevel:push';
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
 Result := 'контрол::FontStrikeoutInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontStrikeoutInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontStrikeoutInheritanceButton:push';
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
 Result := 'контрол::FontSizeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontSizeInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontSizeInheritanceButton:push';
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
 Result := 'контрол::FontNameInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontNameInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontNameInheritanceButton:push';
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
 Result := 'контрол::FontItalicInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontItalicInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontItalicInheritanceButton:push';
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
 Result := 'контрол::FontForeColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontForeColorInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontForeColorInheritanceButton:push';
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
 Result := 'контрол::FontBoldInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBoldInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBoldInheritanceButton:push';
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
 Result := 'контрол::FontBackColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBackColorInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBackColorInheritanceButton:push';
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
 Result := 'контрол::FontUnderlineInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontUnderlineInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontUnderlineInheritanceButton:push';
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
 Result := 'контрол::FontUnderlineCheckBox';
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontUnderlineCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontUnderlineCheckBox:push';
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
 Result := 'контрол::FontStrikeoutCheckBox';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontStrikeoutCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontStrikeoutCheckBox:push';
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
 Result := 'контрол::FontSizeComboBox';
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontSizeComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontSizeComboBox:push';
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
 Result := 'контрол::FontNameComboBox';
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontNameComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontNameComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontNameComboBox:push';
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
 Result := 'контрол::FontItalicCheckBox';
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontItalicCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontItalicCheckBox:push';
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
 Result := 'контрол::FontForeColorBox';
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontForeColorBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontForeColorBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontForeColorBox:push';
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
 Result := 'контрол::FontBoldCheckBox';
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBoldCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBoldCheckBox:push';
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
 Result := 'контрол::FontBackColorBox';
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontBackColorBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontBackColorBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontBackColorBox:push';
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
 Result := 'контрол::FontScalableCheckBox';
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FontScalableCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FontScalableCheckBox:push';
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
 Result := 'контрол::LeftIndentLabel';
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftIndentLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftIndentLabel:push';
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
 Result := 'контрол::LeftIndentComboBox';
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftIndentComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftIndentComboBox:push';
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
 Result := 'контрол::RightIndentLabel';
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_RightIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightIndentLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightIndentLabel:push';
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
 Result := 'контрол::RightIndentComboBox';
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightIndentComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightIndentComboBox:push';
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
 Result := 'контрол::FirstIndentLabel';
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FirstIndentLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstIndentLabel:push';
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
 Result := 'контрол::FirstIndentComboBox';
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FirstIndentComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstIndentComboBox:push';
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
 Result := 'контрол::SpaceBeforeLabel';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceBeforeLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceBeforeLabel:push';
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
 Result := 'контрол::SpaceBeforeComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceBeforeComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceBeforeComboBox:push';
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
 Result := 'контрол::SpaceAfterLabel';
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceAfterLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceAfterLabel:push';
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
 Result := 'контрол::SpaceAfterComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceAfterComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceAfterComboBox:push';
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
 Result := 'контрол::LeftIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftIndentInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftIndentInheritanceButton:push';
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
 Result := 'контрол::RightIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightIndentInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightIndentInheritanceButton:push';
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
 Result := 'контрол::FirstIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FirstIndentInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FirstIndentInheritanceButton:push';
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
 Result := 'контрол::SpaceBeforeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceBeforeInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceBeforeInheritanceButton:push';
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
 Result := 'контрол::SpaceAfterInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SpaceAfterInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SpaceAfterInheritanceButton:push';
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
 Result := 'контрол::StyleCaptionLabel';
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StyleCaptionLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StyleCaptionLabel:push';
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
 Result := 'контрол::StyleCaptionComboBox';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetWordNameForRegister

procedure Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('StyleCaptionComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::StyleCaptionComboBox:push';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.GetWordNameForRegister

initialization
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorFontForm));
 {* Регистрация типа TStyleEditorFontForm }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
