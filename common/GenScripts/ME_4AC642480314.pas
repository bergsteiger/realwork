unit PrimStyleEditorFont_Form;
 {* Параметры шрифта }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\PrimStyleEditorFont_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Settings_Strange_Controls
 , ConfigInterfaces
 , evStyleInterface
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
 , l3Interfaces
 , Classes
;

const
 fiSpecialParentTransparent = 0;
  {* Специальное значение в UI попадать не должно... }
 fiOwn = 1;
  {* "С"обственный шрифт }
 fiParent = 2;
  {* Унаследованный от "Р"одителя шрифт }
 fiTransparent = 3;
  {* "П"розрачный шрифт }

type
 TseIntegerComboValueType = (
  icvFontSize
  , icvFirstIndent
  , icvLeftIndent
  , icvRightIndent
  , icvSpaceAfter
  , icvSpaceBefore
 );//TseIntegerComboValueType

 TFontInheritance = fiSpecialParentTransparent .. fiTransparent;

 TseComboValues = array [TseIntegerComboValueType] of AnsiString;

 TPrimStyleEditorFontForm = class(TvcmEntityForm)
  {* Параметры шрифта }
  private
   f_UpdateLockCount: Integer;
   f_FontScrollBox: TScrollBox;
    {* Поле для свойства FontScrollBox }
   f_FontUnderlineLabel: TvtLabel;
    {* Поле для свойства FontUnderlineLabel }
   f_FontStrikeoutLabel: TvtLabel;
    {* Поле для свойства FontStrikeoutLabel }
   f_FontSizeLabel: TvtLabel;
    {* Поле для свойства FontSizeLabel }
   f_FontNameLabel: TvtLabel;
    {* Поле для свойства FontNameLabel }
   f_FontItalicLabel: TvtLabel;
    {* Поле для свойства FontItalicLabel }
   f_FontForeColorLabel: TvtLabel;
    {* Поле для свойства FontForeColorLabel }
   f_FontBoldLabel: TvtLabel;
    {* Поле для свойства FontBoldLabel }
   f_FontBackColorLabel: TvtLabel;
    {* Поле для свойства FontBackColorLabel }
   f_FontScalableLabel: TvtLabel;
    {* Поле для свойства FontScalableLabel }
   f_FontScalableBevel: TBevel;
    {* Поле для свойства FontScalableBevel }
   f_FontStrikeoutInheritanceButton: TElPopupButton;
    {* Поле для свойства FontStrikeoutInheritanceButton }
   f_FontSizeInheritanceButton: TElPopupButton;
    {* Поле для свойства FontSizeInheritanceButton }
   f_FontNameInheritanceButton: TElPopupButton;
    {* Поле для свойства FontNameInheritanceButton }
   f_FontItalicInheritanceButton: TElPopupButton;
    {* Поле для свойства FontItalicInheritanceButton }
   f_FontForeColorInheritanceButton: TElPopupButton;
    {* Поле для свойства FontForeColorInheritanceButton }
   f_FontBoldInheritanceButton: TElPopupButton;
    {* Поле для свойства FontBoldInheritanceButton }
   f_FontBackColorInheritanceButton: TElPopupButton;
    {* Поле для свойства FontBackColorInheritanceButton }
   f_FontUnderlineInheritanceButton: TElPopupButton;
    {* Поле для свойства FontUnderlineInheritanceButton }
   f_FontUnderlineCheckBox: TvtCheckBox;
    {* Поле для свойства FontUnderlineCheckBox }
   f_FontStrikeoutCheckBox: TvtCheckBox;
    {* Поле для свойства FontStrikeoutCheckBox }
   f_FontSizeComboBox: TvtComboBoxQS;
    {* Поле для свойства FontSizeComboBox }
   f_FontNameComboBox: TvtComboBoxQS;
    {* Поле для свойства FontNameComboBox }
   f_FontItalicCheckBox: TvtCheckBox;
    {* Поле для свойства FontItalicCheckBox }
   f_FontForeColorBox: TvtColorBox;
    {* Поле для свойства FontForeColorBox }
   f_FontBoldCheckBox: TvtCheckBox;
    {* Поле для свойства FontBoldCheckBox }
   f_FontBackColorBox: TvtColorBox;
    {* Поле для свойства FontBackColorBox }
   f_FontScalableCheckBox: TvtCheckBox;
    {* Поле для свойства FontScalableCheckBox }
   f_LeftIndentLabel: TvtLabel;
    {* Поле для свойства LeftIndentLabel }
   f_LeftIndentComboBox: TvtComboBoxQS;
    {* Поле для свойства LeftIndentComboBox }
   f_RightIndentLabel: TvtLabel;
    {* Поле для свойства RightIndentLabel }
   f_RightIndentComboBox: TvtComboBoxQS;
    {* Поле для свойства RightIndentComboBox }
   f_FirstIndentLabel: TvtLabel;
    {* Поле для свойства FirstIndentLabel }
   f_FirstIndentComboBox: TvtComboBoxQS;
    {* Поле для свойства FirstIndentComboBox }
   f_SpaceBeforeLabel: TvtLabel;
    {* Поле для свойства SpaceBeforeLabel }
   f_SpaceBeforeComboBox: TvtComboBoxQS;
    {* Поле для свойства SpaceBeforeComboBox }
   f_SpaceAfterLabel: TvtLabel;
    {* Поле для свойства SpaceAfterLabel }
   f_SpaceAfterComboBox: TvtComboBoxQS;
    {* Поле для свойства SpaceAfterComboBox }
   f_LeftIndentInheritanceButton: TElPopupButton;
    {* Поле для свойства LeftIndentInheritanceButton }
   f_RightIndentInheritanceButton: TElPopupButton;
    {* Поле для свойства RightIndentInheritanceButton }
   f_FirstIndentInheritanceButton: TElPopupButton;
    {* Поле для свойства FirstIndentInheritanceButton }
   f_SpaceBeforeInheritanceButton: TElPopupButton;
    {* Поле для свойства SpaceBeforeInheritanceButton }
   f_SpaceAfterInheritanceButton: TElPopupButton;
    {* Поле для свойства SpaceAfterInheritanceButton }
   f_StyleCaptionLabel: TvtLabel;
    {* Поле для свойства StyleCaptionLabel }
   f_StyleCaptionComboBox: TvtComboBoxQS;
    {* Поле для свойства StyleCaptionComboBox }
  protected
   f_SettingsInfo: InsStyleTableSettingsInfo;
   f_StyleInterface: TevStyleInterface;
   f_LastKnownGoodComboBoxText: TseComboValues;
  private
   procedure SendToAggregateReloadStylesTreeNotify(const aStyleName: Il3CString);
   procedure SendToAggregateReloadStyleTableNotify(aModified: Boolean = True);
   procedure DisableUpdate;
   procedure EnableUpdate;
   procedure LoadCurrentStateFromStyleInterface(aStyleID: Integer);
   function IsUpdateEnabled: Boolean;
   procedure UpdateControlsFromStyleInterface(aChangeEnabled: Boolean;
    aEnabled: Boolean = True);
   procedure ReloadFontNameList;
   procedure ReloadFontSizeList(const aFontName: AnsiString);
   procedure SetCurrentComboBoxItemByString(aComboBox: TvtComboBoxQS;
    const aString: AnsiString);
   procedure SynchronizeFontNameComboBoxByFontName(const aFontName: AnsiString);
   function GetInheritanceFromFontByTagIndex(aTagIndex: Integer;
    aFromFont: Boolean;
    aParentTransparent: Boolean = False): TFontInheritance;
   procedure ModifyControlsJoinWithInheritanceButton(aSender: TObject); overload;
   procedure ModifyControlsJoinWithInheritanceButton(aSender: TObject;
    aEnabled: Boolean); overload;
   procedure UpdateFontInheritanceState(aInheritance: TFontInheritance;
    aTagIndex: Integer;
    aFont: Boolean);
   function GetNextInheritance(aInheritance: TFontInheritance;
    aTransparentAvailable: Boolean = True): TFontInheritance;
   class function IsTransparentFont(aInheritance: TFontInheritance): Boolean;
   procedure FontBackColorBoxChange(Sender: TObject);
   procedure FontBackColorInheritanceButtonClick(Sender: TObject);
   procedure FontBoldCheckBoxClick(Sender: TObject);
   procedure FontBoldInheritanceButtonClick(Sender: TObject);
   procedure FontForeColorBoxChange(Sender: TObject);
   procedure FontForeColorInheritanceButtonClick(Sender: TObject);
   procedure FontItalicCheckBoxClick(Sender: TObject);
   procedure FontItalicInheritanceButtonClick(Sender: TObject);
   procedure FontNameComboBoxChange(Sender: TObject);
   procedure FontNameInheritanceButtonClick(Sender: TObject);
   procedure FontScalableCheckBoxClick(Sender: TObject);
   procedure FontSizeComboBoxChange(Sender: TObject);
   procedure FontSizeInheritanceButtonClick(Sender: TObject);
   procedure FontStrikeoutCheckBoxClick(Sender: TObject);
   procedure FontStrikeoutInheritanceButtonClick(Sender: TObject);
   procedure FontUnderlineCheckBoxClick(Sender: TObject);
   procedure FontUnderlineInheritanceButtonClick(Sender: TObject);
   procedure LeftIndentInheritanceButtonClick(Sender: TObject);
   procedure RightIndentInheritanceButtonClick(Sender: TObject);
   procedure FirstIndentInheritanceButtonClick(Sender: TObject);
   procedure SpaceBeforeInheritanceButtonClick(Sender: TObject);
   procedure SpaceAfterInheritanceButtonClick(Sender: TObject);
   procedure LeftIndentComboBoxChange(Sender: TObject);
   procedure RightIndentComboBoxChange(Sender: TObject);
   procedure FirstIndentComboBoxChange(Sender: TObject);
   procedure SpaceBeforeComboBoxChange(Sender: TObject);
   procedure SpaceAfterComboBoxChange(Sender: TObject);
   procedure SynchronizeIntegerComboBoxByText(anIndex: TseIntegerComboValueType;
    const aValue: AnsiString);
   procedure CheckComboBoxValue(aValueType: TseIntegerComboValueType);
   procedure SpacingComboExit(Sender: TObject);
   procedure StyleCaptionComboBoxChange(Sender: TObject);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   class function Make(const aData: InsStyleTableSettingsInfo): StyleEditor; reintroduce;
   procedure RestoreStyleTable; override;
   procedure SaveStyleTable; override;
   procedure SetNewContent; override;
   constructor Create(AOwner: TComponent); override;
  public
   property FontScrollBox: TScrollBox
    read f_FontScrollBox;
 end;//TPrimStyleEditorFontForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3MessageID
 , l3StringIDEx
 , nsTypes
 , Graphics
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , Windows
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , k2Tags
 , vtCtrls
 , evdStyles
 , l3String
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , ctTypes
 , afwFacade
 , afwInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ScreenIC
 , l3Units
 , l3Interlocked
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки  }
 str_ValueIsGreaterThan: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ValueIsGreaterThan'; rValue : 'Значение не может быть больше чем %d');
  {* 'Значение не может быть больше чем %d' }
 str_ValueIsLessThan: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'ValueIsLessThan'; rValue : 'Значение не может быть меньше чем %d');
  {* 'Значение не может быть меньше чем %d' }
 str_InheritanceButtonHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InheritanceButtonHint'; rValue : 'Тип наследования (Собственное, Родительское, Прозрачное)');
  {* 'Тип наследования (Собственное, Родительское, Прозрачное)' }
 str_InheritanceButtonNoTransparentHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InheritanceButtonNoTransparentHint'; rValue : 'Тип наследования (Собственное, Родительское)');
  {* 'Тип наследования (Собственное, Родительское)' }

class function TPrimStyleEditorFontForm.Make(const aData: InsStyleTableSettingsInfo): StyleEditor;
var
 l_Inst : TPrimStyleEditorFontForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimStyleEditorFontForm.Make

procedure TPrimStyleEditorFontForm.SendToAggregateReloadStylesTreeNotify(const aStyleName: Il3CString);
//#UC START# *52709A7B00B1_4AC642480314_var*
//#UC END# *52709A7B00B1_4AC642480314_var*
begin
//#UC START# *52709A7B00B1_4AC642480314_impl*
 op_StyleEditor_ReloadStylesTree.Call(Aggregate, aStyleName);
//#UC END# *52709A7B00B1_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SendToAggregateReloadStylesTreeNotify

procedure TPrimStyleEditorFontForm.SendToAggregateReloadStyleTableNotify(aModified: Boolean = True);
//#UC START# *52709AC30234_4AC642480314_var*
//#UC END# *52709AC30234_4AC642480314_var*
begin
//#UC START# *52709AC30234_4AC642480314_impl*
 evNotifyStyleTableChanging;
 evNotifyStyleTableChanged;
 //
 if aModified then
  f_SettingsInfo.MarkModified;
 op_StyleEditor_ReloadStyleTable.Call(Aggregate);
//#UC END# *52709AC30234_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SendToAggregateReloadStyleTableNotify

procedure TPrimStyleEditorFontForm.DisableUpdate;
//#UC START# *52709AF200D7_4AC642480314_var*
//#UC END# *52709AF200D7_4AC642480314_var*
begin
//#UC START# *52709AF200D7_4AC642480314_impl*
 l3InterlockedIncrement(f_UpdateLockCount);
//#UC END# *52709AF200D7_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.DisableUpdate

procedure TPrimStyleEditorFontForm.EnableUpdate;
//#UC START# *52709AFB00A3_4AC642480314_var*
//#UC END# *52709AFB00A3_4AC642480314_var*
begin
//#UC START# *52709AFB00A3_4AC642480314_impl*
 l3InterlockedDecrement(f_UpdateLockCount);
//#UC END# *52709AFB00A3_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.EnableUpdate

procedure TPrimStyleEditorFontForm.LoadCurrentStateFromStyleInterface(aStyleID: Integer);
//#UC START# *52709B0801C5_4AC642480314_var*
const
 CRootStyleId = ev_saTxtNormalANSI;
//#UC END# *52709B0801C5_4AC642480314_var*
begin
//#UC START# *52709B0801C5_4AC642480314_impl*
 DisableUpdate;
 try
  with f_StyleInterface do
  begin
   SelectStyle(aStyleID);
   //
   UpdateControlsFromStyleInterface(True, (aStyleID <> CRootStyleId));
   //
   CCaption := vcmFmt(str_StyleEditorFontCaption, [Name]);
  end;
 finally
  EnableUpdate;
 end;
//#UC END# *52709B0801C5_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.LoadCurrentStateFromStyleInterface

function TPrimStyleEditorFontForm.IsUpdateEnabled: Boolean;
//#UC START# *52709CE701BA_4AC642480314_var*
//#UC END# *52709CE701BA_4AC642480314_var*
begin
//#UC START# *52709CE701BA_4AC642480314_impl*
 Result := (l3InterlockedExchangeAdd(@f_UpdateLockCount, 0) = 0);
//#UC END# *52709CE701BA_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.IsUpdateEnabled

procedure TPrimStyleEditorFontForm.UpdateControlsFromStyleInterface(aChangeEnabled: Boolean;
 aEnabled: Boolean = True);
//#UC START# *52709F5D014F_4AC642480314_var*

const            
 CInheritanceCaptions: array [TFontInheritance] of PvcmSTringID = (
  @str_Empty, // fisSpecialParentTransparent
  @str_FontInheritanceOwn, // fisOwn
  @str_FontInheritanceParent, // fisParent
  @str_FontInheritanceTransparent // fisTransparent
 );

 procedure UpdateInheritanceButtonStatus(aSpeedButton: TElPopupButton; aTagIndex: Integer; aFromFont: Boolean);
 var
  l_Caption: AnsiString;
 begin
  with aSpeedButton do
  begin
   Tag := GetInheritanceFromFontByTagIndex(aTagIndex, aFromFont);
   l_Caption := GetHotkey(vcmConstString(CInheritanceCaptions[Tag]^));
   if l_Caption = '' then
    l_Caption := ANSIUpperCase(vcmConstString(CInheritanceCaptions[Tag]^));
   Caption := l_Caption;
   if aChangeEnabled then
    Enabled := aEnabled;
  end;
  ModifyControlsJoinWithInheritanceButton(aSpeedButton);
 end;

 function l_LP2DP(aValue: Integer): Integer;
 begin
  Result := l3CrtIC.LP2DP(l3PointX(aValue)).X;
 end;

 procedure lp_SetEnabled(AControls: array of TControl; aValue: Boolean);
 var
  I: Integer;
 begin
  for I := Low(AControls) to High(AControls) do
   AControls[I].Enabled := aValue;
 end;
//#UC END# *52709F5D014F_4AC642480314_var*
begin
//#UC START# *52709F5D014F_4AC642480314_impl*
 Dispatcher.FormDispatcher.Lock;
 try
  DisableUpdate;
  try
   with f_StyleInterface.Font do
   begin
    SynchronizeFontNameComboBoxByFontName(Name);
    SynchronizeIntegerComboBoxByText(icvFontSize, IntToStr(Size));
    //
    FontForeColorBox.Selected := ForeColor;
    FontBackColorBox.Selected := BackColor;
    //
    FontBoldCheckBox.Checked := Bold;
    FontItalicCheckBox.Checked := Italic;
    FontUnderlineCheckBox.Checked := Underline;
    FontStrikeoutCheckBox.Checked := Strikeout;
   end;
   FontScalableCheckBox.Checked := f_StyleInterface.Scalable;

   with f_StyleInterface do
   begin
    SynchronizeIntegerComboBoxByText(icvFirstIndent, IntToStr(l_LP2DP(FirstIndent)));
    SynchronizeIntegerComboBoxByText(icvLeftIndent, IntToStr(l_LP2DP(LeftIndent)));
    SynchronizeIntegerComboBoxByText(icvRightIndent, IntToStr(l_LP2DP(RightIndent)));
    SynchronizeIntegerComboBoxByText(icvSpaceAfter, IntToStr(l_LP2DP(SpaceAfter)));
    SynchronizeIntegerComboBoxByText(icvSpaceBefore, IntToStr(l_LP2DP(SpaceBefore)));
   end;

   StyleCaptionComboBox.Text := l3CStr(f_StyleInterface.Caption);
   //
   UpdateInheritanceButtonStatus(FontNameInheritanceButton, k2_tiName, True);
   UpdateInheritanceButtonStatus(FontSizeInheritanceButton, k2_tiSize, True);

   UpdateInheritanceButtonStatus(FirstIndentInheritanceButton, k2_tiFirstIndent, False);
   UpdateInheritanceButtonStatus(LeftIndentInheritanceButton, k2_tiLeftIndent, False);
   UpdateInheritanceButtonStatus(RightIndentInheritanceButton, k2_tiRightIndent, False);
   UpdateInheritanceButtonStatus(SpaceAfterInheritanceButton, k2_tiSpaceAfter, False);
   UpdateInheritanceButtonStatus(SpaceBeforeInheritanceButton, k2_tiSpaceBefore, False);
   //
   UpdateInheritanceButtonStatus(FontForeColorInheritanceButton, k2_tiForeColor, True);
   UpdateInheritanceButtonStatus(FontBackColorInheritanceButton, k2_tiBackColor, True);
   //
   UpdateInheritanceButtonStatus(FontBoldInheritanceButton, k2_tiBold, True);
   UpdateInheritanceButtonStatus(FontItalicInheritanceButton, k2_tiItalic, True);
   UpdateInheritanceButtonStatus(FontUnderlineInheritanceButton, k2_tiUnderline, True);
   UpdateInheritanceButtonStatus(FontStrikeoutInheritanceButton, k2_tiStrikeout, True);

   lp_SetEnabled([FirstIndentComboBox,
                  LeftIndentComboBox,
                  RightIndentComboBox,
                  SpaceAfterComboBox,
                  SpaceBeforeComboBox,
                  StyleCaptionComboBox],
                  f_StyleInterface.Apply2Para);
  finally
   EnableUpdate;
  end;
 finally
  Dispatcher.FormDispatcher.UnLock;
 end;
//#UC END# *52709F5D014F_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.UpdateControlsFromStyleInterface

procedure TPrimStyleEditorFontForm.ReloadFontNameList;
//#UC START# *5270A26E0251_4AC642480314_var*
var
 l_CharSet: Byte;
//#UC END# *5270A26E0251_4AC642480314_var*
begin
//#UC START# *5270A26E0251_4AC642480314_impl*
 with FontNameComboBox.Items do
 begin
  Sorted := False;
  try
   //http://mdp.garant.ru/pages/viewpage.action?pageId=499495428
   if (afw.Application.LocaleInfo.Language <> afw_lngEnglish) then
    l_CharSet := RUSSIAN_CHARSET
   else
    l_CharSet := ANSI_CHARSET;
   GetFontListEx(FontNameComboBox.Items, l_CharSet);
  finally
   Sorted := True;
  end;//try..finally
 end;//with FontNameComboBox.Items
//#UC END# *5270A26E0251_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.ReloadFontNameList

procedure TPrimStyleEditorFontForm.ReloadFontSizeList(const aFontName: AnsiString);
//#UC START# *5270A27F012C_4AC642480314_var*
var
 l_Text: Il3CString;
 l_CharSet: Byte;
//#UC END# *5270A27F012C_4AC642480314_var*
begin
//#UC START# *5270A27F012C_4AC642480314_impl*
 with FontSizeComboBox do
 begin
  l_Text := Text;
  try
   //http://mdp.garant.ru/pages/viewpage.action?pageId=499495428
   if (afw.Application.LocaleInfo.Language <> afw_lngEnglish) then
    l_CharSet := RUSSIAN_CHARSET
   else
    l_CharSet := ANSI_CHARSET;
   GetFontSizeListEx(aFontName, Items, l_CharSet);
  finally
   Text := l_Text;
  end;//try..finally
 end;//with FontSizeComboBox
//#UC END# *5270A27F012C_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.ReloadFontSizeList

procedure TPrimStyleEditorFontForm.SetCurrentComboBoxItemByString(aComboBox: TvtComboBoxQS;
 const aString: AnsiString);
//#UC START# *5270A2B700C8_4AC642480314_var*
//#UC END# *5270A2B700C8_4AC642480314_var*
begin
//#UC START# *5270A2B700C8_4AC642480314_impl*
 with aComboBox do
 begin
  ItemIndex := Items.IndexOf(aString);
  if (ItemIndex = -1) then
   Text := l3CStr(aString);
 end;
//#UC END# *5270A2B700C8_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SetCurrentComboBoxItemByString

procedure TPrimStyleEditorFontForm.SynchronizeFontNameComboBoxByFontName(const aFontName: AnsiString);
//#UC START# *5270A300021B_4AC642480314_var*
//#UC END# *5270A300021B_4AC642480314_var*
begin
//#UC START# *5270A300021B_4AC642480314_impl*
 (* Выходим при прозрачности поля пустые *)
 if (*not f_StyleInterface.Font.IsOwn[k2_tiName] and *)
    IsTransparentFont(GetInheritanceFromFontByTagIndex(k2_tiName, True, True)) then
  Exit;

 if not l3Same(FontNameComboBox.Text, aFontName) then
  ReloadFontSizeList(aFontName);
 //
 SetCurrentComboBoxItemByString(FontNameComboBox, aFontName);
//#UC END# *5270A300021B_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SynchronizeFontNameComboBoxByFontName

function TPrimStyleEditorFontForm.GetInheritanceFromFontByTagIndex(aTagIndex: Integer;
 aFromFont: Boolean;
 aParentTransparent: Boolean = False): TFontInheritance;
//#UC START# *5270A3500235_4AC642480314_var*
 function CheckParentTransparent(const aStyleInterface: TevStyleInterface; const aTagIndex: Integer): Boolean;
 begin
  with aStyleInterface do
   if (Param[k2_tiHandle] = ParentInterface.Param[k2_tiHandle]) then
    Result := False // fix: если попали сюда, значит "что-то не в порядке" и стиль имеет в качестве родителя самого себя.
   else
    if aFromFont then
     with Font do
      if not(IsOwn[aTagIndex])
       then Result := CheckParentTransparent(ParentInterface, aTagIndex)
       else Result := IsTransparent[aTagIndex]
    else
     if not(IsOwn[aTagIndex])
      then Result := CheckParentTransparent(ParentInterface, aTagIndex)
      else Result := IsTransparent[aTagIndex];
 end;
//#UC END# *5270A3500235_4AC642480314_var*
begin
//#UC START# *5270A3500235_4AC642480314_impl*
 if aFromFont then
  with f_StyleInterface.Font do
   if IsOwn[aTagIndex] then
    if IsTransparent[aTagIndex]
     then Result := fiTransparent
     else Result := fiOwn
   else
    Result := fiParent
 else
  with f_StyleInterface do
   if IsOwn[aTagIndex] then
    if IsTransparent[aTagIndex]
     then Result := fiTransparent
     else Result := fiOwn
   else
    Result := fiParent;
 //
 if (aParentTransparent and (Result = fiParent) and CheckParentTransparent(f_StyleInterface.ParentInterface, aTagIndex)) then
  Result := fiSpecialParentTransparent;
//#UC END# *5270A3500235_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.GetInheritanceFromFontByTagIndex

procedure TPrimStyleEditorFontForm.ModifyControlsJoinWithInheritanceButton(aSender: TObject);
//#UC START# *5270A3A003D5_4AC642480314_var*
//#UC END# *5270A3A003D5_4AC642480314_var*
begin
//#UC START# *5270A3A003D5_4AC642480314_impl*
 with (aSender as TElPopupButton) do
  if Tag in [fiParent, fiTransparent] then
   ModifyControlsJoinWithInheritanceButton(aSender, False)
  else
   if Tag = fiOwn then
    ModifyControlsJoinWithInheritanceButton(aSender, True)
   else
    Assert(False);
//#UC END# *5270A3A003D5_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.ModifyControlsJoinWithInheritanceButton

procedure TPrimStyleEditorFontForm.ModifyControlsJoinWithInheritanceButton(aSender: TObject;
 aEnabled: Boolean);
//#UC START# *5270A3C90385_4AC642480314_var*
 procedure ModifyComboBoxStatus(aTagIndex: Integer; const aComboBox: TvtComboBoxQS; aEnabled: Boolean; aFromFont: Boolean);
 begin
  with aComboBox do
  begin
   if IsTransparentFont(GetInheritanceFromFontByTagIndex(aTagIndex, aFromFont, True)) then
    ItemIndex := -1;
   //
   Enabled := aEnabled;
   if Enabled then
    Color := clWindow
   else
    Color := $00F9F8FA;
  end;
 end;
 //
 procedure ModifyColorBoxStatus(aTagIndex: Integer; const aColorBox: TvtColorBox; aEnabled: Boolean);
 begin
  with aColorBox do
  begin
   if IsTransparentFont(GetInheritanceFromFontByTagIndex(aTagIndex, True, True)) then
    ItemIndex := -1;
   //
   Enabled := aEnabled;
   if Enabled then
    Color := clWindow
   else
    Color := $00F9F8FA;
  end;
 end;
 //
 procedure ModifyCheckBoxStatus(aTagIndex: Integer; const aCheckBox: TvtCheckBox; aEnabled: Boolean);
 var
  l_Inheritance: TFontInheritance;
 begin
  with aCheckBox do
  begin
   l_Inheritance := GetInheritanceFromFontByTagIndex(aTagIndex, True, True);

   Visible := not IsTransparentFont(l_Inheritance);

   Enabled := aEnabled;
  end;
 end;
//#UC END# *5270A3C90385_4AC642480314_var*
begin
//#UC START# *5270A3C90385_4AC642480314_impl*
 if (aSender = FontNameInheritanceButton) then
  ModifyComboBoxStatus(k2_tiName, FontNameComboBox, aEnabled, True)
 else
 if (aSender = FontSizeInheritanceButton) then
  ModifyComboBoxStatus(k2_tiSize, FontSizeComboBox, aEnabled, True)
 else

  if (aSender = FirstIndentInheritanceButton) then
   ModifyComboBoxStatus(k2_tiFirstIndent, FirstIndentComboBox, aEnabled, False)
  else
  if (aSender = LeftIndentInheritanceButton) then
   ModifyComboBoxStatus(k2_tiLeftIndent, LeftIndentComboBox, aEnabled, False)
  else
  if (aSender = RightIndentInheritanceButton) then
   ModifyComboBoxStatus(k2_tiRightIndent, RightIndentComboBox, aEnabled, False)
  else
  if (aSender = SpaceAfterInheritanceButton) then
   ModifyComboBoxStatus(k2_tiSpaceAfter, SpaceAfterComboBox, aEnabled, False)
  else
  if (aSender = SpaceBeforeInheritanceButton) then
   ModifyComboBoxStatus(k2_tiSpaceBefore, SpaceBeforeComboBox, aEnabled, False)
  else
  
 if (aSender = FontForeColorInheritanceButton) then
  ModifyColorBoxStatus(k2_tiForeColor, FontForeColorBox, aEnabled)
 else
 if (aSender = FontBackColorInheritanceButton) then
  ModifyColorBoxStatus(k2_tiBackColor, FontBackColorBox, aEnabled)
 else
 if (aSender = FontBoldInheritanceButton) then
  ModifyCheckBoxStatus(k2_tiBold, FontBoldCheckBox, aEnabled)
 else
 if (aSender = FontItalicInheritanceButton) then
  ModifyCheckBoxStatus(k2_tiItalic, FontItalicCheckBox, aEnabled)
 else
 if (aSender = FontUnderlineInheritanceButton) then
  ModifyCheckBoxStatus(k2_tiUnderline, FontUnderlineCheckBox, aEnabled)
 else
 if (aSender = FontStrikeoutInheritanceButton) then
  ModifyCheckBoxStatus(k2_tiStrikeout, FontStrikeoutCheckBox, aEnabled)
 else
  Assert(False);
//#UC END# *5270A3C90385_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.ModifyControlsJoinWithInheritanceButton

procedure TPrimStyleEditorFontForm.UpdateFontInheritanceState(aInheritance: TFontInheritance;
 aTagIndex: Integer;
 aFont: Boolean);
//#UC START# *52709F0702E9_4AC642480314_var*
//#UC END# *52709F0702E9_4AC642480314_var*
begin
//#UC START# *52709F0702E9_4AC642480314_impl*
 if aFont then
  case aInheritance of
   fiTransparent: f_StyleInterface.Font.IsTransparent[aTagIndex] := True;
   fiParent: f_StyleInterface.Font.IsOwn[aTagIndex] := False;
  else
   Assert(False);
  end
 else
  case aInheritance of
   fiTransparent: f_StyleInterface.IsTransparent[aTagIndex] := True;
   fiParent: f_StyleInterface.IsOwn[aTagIndex] := False;
  else
   Assert(False);
  end;
 Assert(GetInheritanceFromFontByTagIndex(aTagIndex, aFont) = aInheritance);
//#UC END# *52709F0702E9_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.UpdateFontInheritanceState

function TPrimStyleEditorFontForm.GetNextInheritance(aInheritance: TFontInheritance;
 aTransparentAvailable: Boolean = True): TFontInheritance;
//#UC START# *5270A33102D8_4AC642480314_var*
//#UC END# *5270A33102D8_4AC642480314_var*
begin
//#UC START# *5270A33102D8_4AC642480314_impl*
 if aInheritance = fiSpecialParentTransparent then
  Result := aInheritance
 else
  if aInheritance = High(TFontInheritance) then
   Result := Succ(Low(TFontInheritance))
  else
   Result := Succ(aInheritance);
 if not aTransparentAvailable and (Result = fiTransparent) then
  Result := GetNextInheritance(Result, aTransparentAvailable);
//#UC END# *5270A33102D8_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.GetNextInheritance

class function TPrimStyleEditorFontForm.IsTransparentFont(aInheritance: TFontInheritance): Boolean;
//#UC START# *5270E51C0231_4AC642480314_var*
//#UC END# *5270E51C0231_4AC642480314_var*
begin
//#UC START# *5270E51C0231_4AC642480314_impl*
 Result := aInheritance in [fiSpecialParentTransparent, fiTransparent];
//#UC END# *5270E51C0231_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.IsTransparentFont

procedure TPrimStyleEditorFontForm.FontBackColorBoxChange(Sender: TObject);
//#UC START# *5270A4A70280_4AC642480314_var*
//#UC END# *5270A4A70280_4AC642480314_var*
begin
//#UC START# *5270A4A70280_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontBackColorBox do
   f_StyleInterface.Font.BackColor := Selected;
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4A70280_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontBackColorBoxChange

procedure TPrimStyleEditorFontForm.FontBackColorInheritanceButtonClick(Sender: TObject);
//#UC START# *5270A49C01A0_4AC642480314_var*
 procedure UpdateFontBackColorAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface.Font do
    BackColor := BackColor
  else
   UpdateFontInheritanceState(aInheritance, k2_tiBackColor, True);
 end;
//#UC END# *5270A49C01A0_4AC642480314_var*
begin
//#UC START# *5270A49C01A0_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontBackColorInheritanceButton do
   UpdateFontBackColorAndInheritanceState(GetNextInheritance(Tag));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A49C01A0_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontBackColorInheritanceButtonClick

procedure TPrimStyleEditorFontForm.FontBoldCheckBoxClick(Sender: TObject);
//#UC START# *5270A4BB00A1_4AC642480314_var*
//#UC END# *5270A4BB00A1_4AC642480314_var*
begin
//#UC START# *5270A4BB00A1_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontBoldCheckBox do
   f_StyleInterface.Font.Bold := Checked;
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4BB00A1_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontBoldCheckBoxClick

procedure TPrimStyleEditorFontForm.FontBoldInheritanceButtonClick(Sender: TObject);
//#UC START# *5270A4B20394_4AC642480314_var*
 procedure UpdateFontBoldAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface.Font do
    Bold := Bold
  else
   UpdateFontInheritanceState(aInheritance, k2_tiBold, True);
 end;
//#UC END# *5270A4B20394_4AC642480314_var*
begin
//#UC START# *5270A4B20394_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontBoldInheritanceButton do
   UpdateFontBoldAndInheritanceState(GetNextInheritance(Tag));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4B20394_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontBoldInheritanceButtonClick

procedure TPrimStyleEditorFontForm.FontForeColorBoxChange(Sender: TObject);
//#UC START# *5270A4930193_4AC642480314_var*
//#UC END# *5270A4930193_4AC642480314_var*
begin
//#UC START# *5270A4930193_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontForeColorBox do
   f_StyleInterface.Font.ForeColor := Selected;
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4930193_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontForeColorBoxChange

procedure TPrimStyleEditorFontForm.FontForeColorInheritanceButtonClick(Sender: TObject);
//#UC START# *5270A48B0154_4AC642480314_var*
 procedure UpdateFontForeColorAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface.Font do
    ForeColor := ForeColor
  else
   UpdateFontInheritanceState(aInheritance, k2_tiForeColor, True);
 end;
//#UC END# *5270A48B0154_4AC642480314_var*
begin
//#UC START# *5270A48B0154_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontForeColorInheritanceButton do
   UpdateFontForeColorAndInheritanceState(GetNextInheritance(Tag));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A48B0154_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontForeColorInheritanceButtonClick

procedure TPrimStyleEditorFontForm.FontItalicCheckBoxClick(Sender: TObject);
//#UC START# *5270A4CC03E2_4AC642480314_var*
//#UC END# *5270A4CC03E2_4AC642480314_var*
begin
//#UC START# *5270A4CC03E2_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontItalicCheckBox do
   f_StyleInterface.Font.Italic := Checked;
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4CC03E2_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontItalicCheckBoxClick

procedure TPrimStyleEditorFontForm.FontItalicInheritanceButtonClick(Sender: TObject);
//#UC START# *5270A4C4013A_4AC642480314_var*
 procedure UpdateFontItalicAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface.Font do
    Italic := Italic
  else
   UpdateFontInheritanceState(aInheritance, k2_tiItalic, True);
 end;
//#UC END# *5270A4C4013A_4AC642480314_var*
begin
//#UC START# *5270A4C4013A_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontItalicInheritanceButton do
   UpdateFontItalicAndInheritanceState(GetNextInheritance(Tag));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4C4013A_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontItalicInheritanceButtonClick

procedure TPrimStyleEditorFontForm.FontNameComboBoxChange(Sender: TObject);
//#UC START# *5270A44F0105_4AC642480314_var*
//#UC END# *5270A44F0105_4AC642480314_var*
begin
//#UC START# *5270A44F0105_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  DisableUpdate;
  try
   with FontNameComboBox do
   begin
    ReloadFontSizeList(l3Str(Text));
    //
    f_StyleInterface.Font.Name := l3Str(Text);
   end;
   //
   UpdateControlsFromStyleInterface(False);
  finally
   EnableUpdate;
  end;//try..finally
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A44F0105_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontNameComboBoxChange

procedure TPrimStyleEditorFontForm.FontNameInheritanceButtonClick(Sender: TObject);
//#UC START# *5270A4450142_4AC642480314_var*
 procedure UpdateFontNameAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface.Font do
    Name := Name
  else
   UpdateFontInheritanceState(aInheritance, k2_tiName, True);
 end;
//#UC END# *5270A4450142_4AC642480314_var*
begin
//#UC START# *5270A4450142_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontNameInheritanceButton do
  UpdateFontNameAndInheritanceState(GetNextInheritance(Tag));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4450142_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontNameInheritanceButtonClick

procedure TPrimStyleEditorFontForm.FontScalableCheckBoxClick(Sender: TObject);
//#UC START# *5270A5010089_4AC642480314_var*
//#UC END# *5270A5010089_4AC642480314_var*
begin
//#UC START# *5270A5010089_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  f_StyleInterface.Scalable := FontScalableCheckBox.Checked;
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A5010089_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontScalableCheckBoxClick

procedure TPrimStyleEditorFontForm.FontSizeComboBoxChange(Sender: TObject);
//#UC START# *5270A47E0168_4AC642480314_var*
//#UC END# *5270A47E0168_4AC642480314_var*
begin
//#UC START# *5270A47E0168_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  CheckComboBoxValue(icvFontSize);
  f_StyleInterface.Font.Size := StrToInt(l3Str(FontSizeComboBox.Text));
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A47E0168_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontSizeComboBoxChange

procedure TPrimStyleEditorFontForm.FontSizeInheritanceButtonClick(Sender: TObject);
//#UC START# *5270A45A0310_4AC642480314_var*
 procedure UpdateFontSizeAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface.Font do
    Size := Size
  else
   UpdateFontInheritanceState(aInheritance, k2_tiSize, True);
 end;
//#UC END# *5270A45A0310_4AC642480314_var*
begin
//#UC START# *5270A45A0310_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontSizeInheritanceButton do
   UpdateFontSizeAndInheritanceState(GetNextInheritance(Tag));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A45A0310_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontSizeInheritanceButtonClick

procedure TPrimStyleEditorFontForm.FontStrikeoutCheckBoxClick(Sender: TObject);
//#UC START# *5270A4F801A8_4AC642480314_var*
//#UC END# *5270A4F801A8_4AC642480314_var*
begin
//#UC START# *5270A4F801A8_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontStrikeoutCheckBox do
   f_StyleInterface.Font.Strikeout := Checked;
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4F801A8_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontStrikeoutCheckBoxClick

procedure TPrimStyleEditorFontForm.FontStrikeoutInheritanceButtonClick(Sender: TObject);
//#UC START# *5270A4EC0017_4AC642480314_var*
 procedure UpdateFontStrikeoutAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface.Font do
    Strikeout := Strikeout
  else
   UpdateFontInheritanceState(aInheritance, k2_tiStrikeout, True);
 end;
//#UC END# *5270A4EC0017_4AC642480314_var*
begin
//#UC START# *5270A4EC0017_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontStrikeoutInheritanceButton do
   UpdateFontStrikeoutAndInheritanceState(GetNextInheritance(Tag));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4EC0017_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontStrikeoutInheritanceButtonClick

procedure TPrimStyleEditorFontForm.FontUnderlineCheckBoxClick(Sender: TObject);
//#UC START# *5270A4E30367_4AC642480314_var*
//#UC END# *5270A4E30367_4AC642480314_var*
begin
//#UC START# *5270A4E30367_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontUnderlineCheckBox do
   f_StyleInterface.Font.Underline := Checked;
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4E30367_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontUnderlineCheckBoxClick

procedure TPrimStyleEditorFontForm.FontUnderlineInheritanceButtonClick(Sender: TObject);
//#UC START# *5270A4D601A5_4AC642480314_var*
 procedure UpdateFontUnderlineAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface.Font do
    Underline := Underline
  else
   UpdateFontInheritanceState(aInheritance, k2_tiUnderline, True);
 end;
//#UC END# *5270A4D601A5_4AC642480314_var*
begin
//#UC START# *5270A4D601A5_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FontUnderlineInheritanceButton do
   UpdateFontUnderlineAndInheritanceState(GetNextInheritance(Tag));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *5270A4D601A5_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FontUnderlineInheritanceButtonClick

procedure TPrimStyleEditorFontForm.LeftIndentInheritanceButtonClick(Sender: TObject);
//#UC START# *530DBD890048_4AC642480314_var*
 procedure UpdateLeftIndentAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface do
    LeftIndent := LeftIndent
  else
   UpdateFontInheritanceState(aInheritance, k2_tiLeftIndent, False);
 end;
//#UC END# *530DBD890048_4AC642480314_var*
begin
//#UC START# *530DBD890048_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with LeftIndentInheritanceButton do
   UpdateLeftIndentAndInheritanceState(GetNextInheritance(Tag, False));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBD890048_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.LeftIndentInheritanceButtonClick

procedure TPrimStyleEditorFontForm.RightIndentInheritanceButtonClick(Sender: TObject);
//#UC START# *530DBD9A01B7_4AC642480314_var*
 procedure UpdateRightIndentAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface do
    RightIndent := RightIndent
  else
   UpdateFontInheritanceState(aInheritance, k2_tiRightIndent, False);
 end;
//#UC END# *530DBD9A01B7_4AC642480314_var*
begin
//#UC START# *530DBD9A01B7_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with RightIndentInheritanceButton do
   UpdateRightIndentAndInheritanceState(GetNextInheritance(Tag, False));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBD9A01B7_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.RightIndentInheritanceButtonClick

procedure TPrimStyleEditorFontForm.FirstIndentInheritanceButtonClick(Sender: TObject);
//#UC START# *530DBDAC0212_4AC642480314_var*
 procedure UpdateFirstIndentAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface do
    FirstIndent := FirstIndent
  else
   UpdateFontInheritanceState(aInheritance, k2_tiFirstIndent, False);
 end;
//#UC END# *530DBDAC0212_4AC642480314_var*
begin
//#UC START# *530DBDAC0212_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with FirstIndentInheritanceButton do
   UpdateFirstIndentAndInheritanceState(GetNextInheritance(Tag, False));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBDAC0212_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FirstIndentInheritanceButtonClick

procedure TPrimStyleEditorFontForm.SpaceBeforeInheritanceButtonClick(Sender: TObject);
//#UC START# *530DBDB602D7_4AC642480314_var*
 procedure UpdateSpaceBeforeAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface do
    SpaceBefore := SpaceBefore
  else
   UpdateFontInheritanceState(aInheritance, k2_tiSpaceBefore, False);
 end;
//#UC END# *530DBDB602D7_4AC642480314_var*
begin
//#UC START# *530DBDB602D7_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with SpaceBeforeInheritanceButton do
   UpdateSpaceBeforeAndInheritanceState(GetNextInheritance(Tag, False));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBDB602D7_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SpaceBeforeInheritanceButtonClick

procedure TPrimStyleEditorFontForm.SpaceAfterInheritanceButtonClick(Sender: TObject);
//#UC START# *530DBDC801F6_4AC642480314_var*
 procedure UpdateSpaceAfterAndInheritanceState(const aInheritance: TFontInheritance);
 begin
  if (aInheritance = fiOwn) then
   with f_StyleInterface do
    SpaceAfter := SpaceAfter
  else
   UpdateFontInheritanceState(aInheritance, k2_tiSpaceAfter, False);
 end;
//#UC END# *530DBDC801F6_4AC642480314_var*
begin
//#UC START# *530DBDC801F6_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  with SpaceAfterInheritanceButton do
   UpdateSpaceAfterAndInheritanceState(GetNextInheritance(Tag, False));
  //
  UpdateControlsFromStyleInterface(False);
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBDC801F6_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SpaceAfterInheritanceButtonClick

procedure TPrimStyleEditorFontForm.LeftIndentComboBoxChange(Sender: TObject);
//#UC START# *530DBE110062_4AC642480314_var*
//#UC END# *530DBE110062_4AC642480314_var*
begin
//#UC START# *530DBE110062_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  CheckComboBoxValue(icvLeftIndent);
  with LeftIndentComboBox do
   f_StyleInterface.LeftIndent := l3CrtIC.DP2LP(PointX(StrToIntDef(l3Str(Text), 0))).X;
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBE110062_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.LeftIndentComboBoxChange

procedure TPrimStyleEditorFontForm.RightIndentComboBoxChange(Sender: TObject);
//#UC START# *530DBE1D0076_4AC642480314_var*
//#UC END# *530DBE1D0076_4AC642480314_var*
begin
//#UC START# *530DBE1D0076_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  CheckComboBoxValue(icvRightIndent);
  with RightIndentComboBox do
   f_StyleInterface.RightIndent := l3CrtIC.DP2LP(PointX(StrToIntDef(l3Str(Text), 0))).X;
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBE1D0076_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.RightIndentComboBoxChange

procedure TPrimStyleEditorFontForm.FirstIndentComboBoxChange(Sender: TObject);
//#UC START# *530DBE25012F_4AC642480314_var*
//#UC END# *530DBE25012F_4AC642480314_var*
begin
//#UC START# *530DBE25012F_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  CheckComboBoxValue(icvFirstIndent);
  with FirstIndentComboBox do
   f_StyleInterface.FirstIndent := l3CrtIC.DP2LP(PointX(StrToIntDef(l3Str(Text), 0))).X;
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBE25012F_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.FirstIndentComboBoxChange

procedure TPrimStyleEditorFontForm.SpaceBeforeComboBoxChange(Sender: TObject);
//#UC START# *530DBE600072_4AC642480314_var*
//#UC END# *530DBE600072_4AC642480314_var*
begin
//#UC START# *530DBE600072_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  CheckComboBoxValue(icvSpaceBefore);
  with SpaceBeforeComboBox do
   f_StyleInterface.SpaceBefore := l3CrtIC.DP2LP(PointX(StrToIntDef(l3Str(Text), 0))).X;
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBE600072_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SpaceBeforeComboBoxChange

procedure TPrimStyleEditorFontForm.SpaceAfterComboBoxChange(Sender: TObject);
//#UC START# *530DBE6D008C_4AC642480314_var*
//#UC END# *530DBE6D008C_4AC642480314_var*
begin
//#UC START# *530DBE6D008C_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  CheckComboBoxValue(icvSpaceAfter);
  with SpaceAfterComboBox do
   f_StyleInterface.SpaceAfter := l3CrtIC.DP2LP(PointX(StrToIntDef(l3Str(Text), 0))).X;
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *530DBE6D008C_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SpaceAfterComboBoxChange

procedure TPrimStyleEditorFontForm.SynchronizeIntegerComboBoxByText(anIndex: TseIntegerComboValueType;
 const aValue: AnsiString);
//#UC START# *5270A30903D4_4AC642480314_var*
const
 c_Tag: array[TseIntegerComboValueType] of Integer = (k2_tiSize, k2_tiFirstIndent, k2_tiLeftIndent,
  k2_tiRightIndent, k2_tiSpaceAfter, k2_tiSpaceBefore);
var
 l_Combo: TvtComboBoxQS;
 l_Value: Integer;
//#UC END# *5270A30903D4_4AC642480314_var*
begin
//#UC START# *5270A30903D4_4AC642480314_impl*
 case anIndex of
  icvFontSize:
   (* Если установлена прозрачность, то поле пустое *)
   if (*not f_StyleInterface.Font.IsOwn[k2_tiSize] and *)
    not IsTransparentFont(GetInheritanceFromFontByTagIndex(k2_tiSize, True)) then
    SetCurrentComboBoxItemByString(FontSizeComboBox, aValue);
 else
  case anIndex of
   icvfirstIndent: l_Combo := FirstIndentComboBox;
   icvLeftIndent: l_Combo := LeftIndentComboBox;
   icvRightIndent: l_Combo := RightIndentComboBox;
   icvSpaceAfter: l_Combo := SpaceAfterComboBox;
   icvSpaceBefore: l_Combo := SpaceBeforeComboBox;
  else
   l_Combo := nil;
   Assert(False);
  end;
  
  //l_Value := l3CrtIC.LP2DP(l3PointX(StrToInt(aValue))).X;

  if not IsTransparentFont(GetInheritanceFromFontByTagIndex(c_Tag[anIndex], True)) then
   SetCurrentComboBoxItemByString(l_Combo, aValue);
 end;
//#UC END# *5270A30903D4_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SynchronizeIntegerComboBoxByText

procedure TPrimStyleEditorFontForm.CheckComboBoxValue(aValueType: TseIntegerComboValueType);
//#UC START# *531051E20053_4AC642480314_var*
type
 TValueTypeConstraints = array[TseIntegerComboValueType] of Integer;
const
 c_MinValue: TValueTypeConstraints = (1, 0, 0, 0, 0, 0);
 c_MaxValue: TValueTypeConstraints = (MaxInt, 500, 500, 500, 250, 250);
var
 l_Value: Integer;
 l_Combo: TvtComboBoxQS;
//#UC END# *531051E20053_4AC642480314_var*
begin
//#UC START# *531051E20053_4AC642480314_impl*
 case aValueType of
  icvFontSize:
   with FontSizeComboBox do
   begin
    if ((Items.IndexOf(Text) = -1) and (StrToIntDef(l3Str(Text), 0) <= 0)) then
     Text := l3CStr(f_LastKnownGoodComboBoxText[icvFontSize])
    else
     f_LastKnownGoodComboBoxText[icvFontSize] := l3Str(Text);
   end;
 else
  case aValueType of
   icvfirstIndent: l_Combo := FirstIndentComboBox;
   icvLeftIndent: l_Combo := LeftIndentComboBox;
   icvRightIndent: l_Combo := RightIndentComboBox;
   icvSpaceAfter: l_Combo := SpaceAfterComboBox;
   icvSpaceBefore: l_Combo := SpaceBeforeComboBox;
  else
   l_Combo := nil;
   Assert(False);
  end;

  if l3Str(l_Combo.Text) <> '' then
  begin
   l_Value := StrToIntDef(l3Str(l_Combo.Text), -1);

   if l_Value = -1 then
    l_Combo.Text := l3CStr(f_LastKnownGoodComboBoxText[aValueType])
   else
   begin
    if l_Value < c_MinValue[aValueType] then
    begin
     l_Value := c_MinValue[aValueType];
     vcmMessageDlg(str_ValueIsLessThan, [c_MinValue[aValueType]]);
    end;

    if l_Value > c_MaxValue[aValueType] then
    begin
     l_Value := c_MaxValue[aValueType];
     vcmMessageDlg(str_ValueIsGreaterThan, [c_MaxValue[aValueType]]);
    end;

    f_LastKnownGoodComboBoxText[aValueType] := IntToStr(l_Value);

    with l_Combo do
     if not l3Same(Text, l3CStr(f_LastKnownGoodComboBoxText[aValueType])) then
      Text := l3CStr(f_LastKnownGoodComboBoxText[aValueType]);
   end;
  end;
 end;
//#UC END# *531051E20053_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.CheckComboBoxValue

procedure TPrimStyleEditorFontForm.SpacingComboExit(Sender: TObject);
//#UC START# *53108AEA00D5_4AC642480314_var*
//#UC END# *53108AEA00D5_4AC642480314_var*
begin
//#UC START# *53108AEA00D5_4AC642480314_impl*
 Assert(Sender is TvtComboBoxQS);
 if l3Str(TvtComboBoxQS(Sender).Text) = '' then
  TvtComboBoxQS(Sender).Text := nsCStr('0');
//#UC END# *53108AEA00D5_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SpacingComboExit

procedure TPrimStyleEditorFontForm.StyleCaptionComboBoxChange(Sender: TObject);
//#UC START# *531868C7033D_4AC642480314_var*
//#UC END# *531868C7033D_4AC642480314_var*
begin
//#UC START# *531868C7033D_4AC642480314_impl*
 if IsUpdateEnabled then
 begin
  DisableUpdate;
  try
   f_StyleInterface.Caption := l3Str(StyleCaptionComboBox.Text);
   UpdateControlsFromStyleInterface(False);
  finally
   EnableUpdate;
  end;//try..finally
  SendToAggregateReloadStyleTableNotify;
 end;
//#UC END# *531868C7033D_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.StyleCaptionComboBoxChange

procedure TPrimStyleEditorFontForm.RestoreStyleTable;
//#UC START# *4AE8696C001B_4AC642480314_var*
//#UC END# *4AE8696C001B_4AC642480314_var*
begin
//#UC START# *4AE8696C001B_4AC642480314_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE8696C001B_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.RestoreStyleTable

procedure TPrimStyleEditorFontForm.SaveStyleTable;
//#UC START# *4AE869C10245_4AC642480314_var*
//#UC END# *4AE869C10245_4AC642480314_var*
begin
//#UC START# *4AE869C10245_4AC642480314_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE869C10245_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SaveStyleTable

procedure TPrimStyleEditorFontForm.SetNewContent;
//#UC START# *4AEAE333001D_4AC642480314_var*
//#UC END# *4AEAE333001D_4AC642480314_var*
begin
//#UC START# *4AEAE333001D_4AC642480314_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEAE333001D_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.SetNewContent

procedure TPrimStyleEditorFontForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AC642480314_var*
//#UC END# *479731C50290_4AC642480314_var*
begin
//#UC START# *479731C50290_4AC642480314_impl*
 Assert(f_UpdateLockCount = 0);
 l3Free(f_StyleInterface);
 f_SettingsInfo := nil;
 inherited;
//#UC END# *479731C50290_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.Cleanup

procedure TPrimStyleEditorFontForm.InitFields;
//#UC START# *47A042E100E2_4AC642480314_var*
//#UC END# *47A042E100E2_4AC642480314_var*
begin
//#UC START# *47A042E100E2_4AC642480314_impl*
 inherited;
 Anchors := [];
 BorderIcons := [];
 Font.Height := -12;
 ShowHint := True;
//#UC END# *47A042E100E2_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.InitFields

constructor TPrimStyleEditorFontForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4AC642480314_var*
//#UC END# *47D1602000C6_4AC642480314_var*
begin
//#UC START# *47D1602000C6_4AC642480314_impl*
 inherited;
 f_LastKnownGoodComboBoxText[icvFontSize] := '10';
 f_LastKnownGoodComboBoxText[icvFirstIndent] := '48';
 f_LastKnownGoodComboBoxText[icvLeftIndent] := '0';
 f_LastKnownGoodComboBoxText[icvRightIndent] := '0';
 f_LastKnownGoodComboBoxText[icvSpaceAfter] := '0';
 f_LastKnownGoodComboBoxText[icvSpaceBefore] := '0';

 f_StyleInterface := TevStyleInterface.Make;
//#UC END# *47D1602000C6_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.Create

{$If NOT Defined(NoVCM)}
procedure TPrimStyleEditorFontForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AC642480314_var*
 procedure lp_SetDoubleBuffered(AControls: array of TWinControl; aValue: Boolean);
 var
  I: Integer;
 begin
  for I := Low(AControls) to High(AControls) do
   AControls[I].DoubleBuffered := aValue;
 end;
 
 procedure lp_SetVisible(AControls: array of TControl; aValue: Boolean);
 var
  I: Integer;
 begin
  for I := Low(AControls) to High(AControls) do
   AControls[I].Visible := aValue;
 end;
//#UC END# *4A8E8F2E0195_4AC642480314_var*
begin
//#UC START# *4A8E8F2E0195_4AC642480314_impl*
 inherited;
 lp_SetDoubleBuffered([Self,
                    FontNameComboBox,
                    FontSizeComboBox,
                    FirstIndentComboBox,
                    LeftIndentComboBox,
                    RightIndentComboBox,
                    SpaceAfterComboBox,
                    SpaceBeforeComboBox,
                    FontForeColorBox,
                    FontBackColorBox,
                    FontBoldCheckBox,
                    FontItalicCheckBox,
                    FontStrikeoutCheckBox,
                    FontUnderlineCheckBox,
                    FontScalableCheckBox,
                    StyleCaptionComboBox], True);

 lp_SetVisible([FirstIndentComboBox,
                LeftIndentComboBox,
                RightIndentComboBox,
                SpaceAfterComboBox,
                SpaceBeforeComboBox,
                FirstIndentInheritanceButton,
                LeftIndentInheritanceButton,
                RightIndentInheritanceButton,
                SpaceAfterInheritanceButton,
                SpaceBeforeInheritanceButton,
                FirstIndentLabel,
                LeftIndentLabel,
                RightIndentLabel,
                SpaceAfterLabel,
                SpaceBeforeLabel,
                StyleCaptionLabel,
                StyleCaptionComboBox],
                afw.Application.IsInternal);
 //
 ReloadFontNameList;
  
 with FontScrollBox do
 begin
  Align := alClient;
  BevelInner := bvNone;
  BevelOuter := bvNone;
 end;
 with FontUnderlineLabel do
 begin
  AutoSize := False;
  Left := 323;
  Top := 64;
  Width := 108;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with FontStrikeoutLabel do
 begin
  AutoSize := False;
  Left := 323;
  Top := 80;
  Width := 108;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with FontSizeLabel do
 begin
  AutoSize := False;
  Left := 341;
  Top := 9;
  Width := 56;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with FontNameLabel do
 begin
  AutoSize := False;
  Left := 10;
  Top := 9;
  Width := 63;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with FontItalicLabel do
 begin
  AutoSize := False;
  Left := 323;
  Top := 48;
  Width := 108;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with FontForeColorLabel do
 begin
  AutoSize := False;
  Left := 10;
  Top := 33;
  Width := 63;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with FontBoldLabel do
 begin
  AutoSize := False;
  Left := 323;
  Top := 32;
  Width := 108;
  Height := 16;
  Alignment := taRightJustify;
  Layout := tlCenter;
 end;
 with FontBackColorLabel do
 begin
  AutoSize := False;
  Left := 0;
  Top := 57;
  Width := 73;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with FontScalableLabel do
 begin
  AutoSize := False;
  Left := 323;
  Top := 104;
  Width := 108;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with FirstIndentLabel do
 begin
  AutoSize := False;
  Left := 10;
  Top := 94;
  Width := 173;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with LeftIndentLabel do
 begin
  AutoSize := False;
  Left := 10;
  Top := 118;
  Width := 173;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with RightIndentLabel do
 begin
  AutoSize := False;
  Left := 10;
  Top := 142;
  Width := 173;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with SpaceAfterLabel do
 begin
  AutoSize := False;
  Left := 10;
  Top := 166;
  Width := 173;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with SpaceBeforeLabel do
 begin
  AutoSize := False;
  Left := 10;
  Top := 190;
  Width := 173;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with FontScalableBevel do
 begin
  Left := 296;
  Top := 100;
  Width := 173;
  Height := 4;
  Shape := bsTopLine;
 end;
 with FontNameInheritanceButton do
 begin
  Left := 76;
  Top := 8;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 0;
  ParentFont := True;
  OnClick := FontNameInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with FontNameComboBox do
 begin
  Left := 95;
  Top := 7;
  Width := 158;
  Height := 21;
  OnChange := FontNameComboBoxChange;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 1;
  ComboStyle := ct_cbDropDownList;
 end;
 with FontForeColorInheritanceButton do
 begin
  Left := 76;
  Top := 32;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 2;
  ParentFont := True;
  OnClick := FontForeColorInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with FontForeColorBox do
 begin
  Left := 95;
  Top := 31;
  Width := 158;
  Height := 21;
  OnChange := FontForeColorBoxChange;
  ColorStyle := [cbStandardColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames];
  DefaultColorColor := clWindowText;
  NoneColorColor := clNone;
  Selected := clScrollBar;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 3;
  TabStop := True;
 end;
 with FontBackColorInheritanceButton do
 begin
  Left := 76;
  Top := 56;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 4;
  ParentFont := True;
  OnClick := FontBackColorInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with FontBackColorBox do
 begin
  Left := 95;
  Top := 55;
  Width := 158;
  Height := 21;
  OnChange := FontBackColorBoxChange;
  ColorStyle := [cbStandardColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames];
  DefaultColorColor := clWindow;
  NoneColorColor := clNone;
  Selected := clScrollBar;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 5;
  TabStop := True;
 end;
 with FirstIndentInheritanceButton do
 begin
  Left := 187;
  Top := 95;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonNoTransparentHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 6;
  ParentFont := True;
  OnClick := FirstIndentInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with FirstIndentComboBox do
 begin
  Left := 207;
  Top := 93;
  Width := 46;
  Height := 21;
  OnChange := FirstIndentComboBoxChange;
  OnExit := SpacingComboExit;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 7;
  ComboStyle := ct_cbEdit;
 end;
 with LeftIndentInheritanceButton do
 begin
  Left := 187;
  Top := 119;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonNoTransparentHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 8;
  ParentFont := True;
  OnClick := LeftIndentInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with LeftIndentComboBox do
 begin
  Left := 207;
  Top := 117;
  Width := 46;
  Height := 21;
  OnChange := LeftIndentComboBoxChange;
  OnExit := SpacingComboExit;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 9;
  ComboStyle := ct_cbEdit;
 end;
 with RightIndentInheritanceButton do
 begin
  Left := 187;
  Top := 143;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonNoTransparentHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 10;
  ParentFont := True;
  OnClick := RightIndentInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with RightIndentComboBox do
 begin
  Left := 207;
  Top := 141;
  Width := 46;
  Height := 21;
  OnChange := RightIndentComboBoxChange;
  OnExit := SpacingComboExit;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 11;
  ComboStyle := ct_cbEdit;
 end;
 with SpaceAfterInheritanceButton do
 begin
  Left := 187;
  Top := 167;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonNoTransparentHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 12;
  ParentFont := True;
  OnClick := SpaceAfterInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with SpaceAfterComboBox do
 begin
  Left := 207;
  Top := 165;
  Width := 46;
  Height := 21;
  OnChange := SpaceAfterComboBoxChange;
  OnExit := SpacingComboExit;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 13;
  ComboStyle := ct_cbEdit;
 end;
 with SpaceBeforeInheritanceButton do
 begin
  Left := 187;
  Top := 191;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonNoTransparentHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 14;
  ParentFont := True;
  OnClick := SpaceBeforeInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with SpaceBeforeComboBox do
 begin
  Left := 207;
  Top := 189;
  Width := 46;
  Height := 21;
  OnChange := SpaceBeforeComboBoxChange;
  OnExit := SpacingComboExit;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 15;
  ComboStyle := ct_cbEdit;
 end;
 with FontSizeInheritanceButton do
 begin
  Left := 402;
  Top := 9;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 16;
  ParentFont := True;
  OnClick := FontSizeInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with FontSizeComboBox do
 begin
  Left := 420;
  Top := 7;
  Width := 46;
  Height := 21;
  OnChange := FontSizeComboBoxChange;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 17;
 end;
 with FontBoldInheritanceButton do
 begin
  Left := 434;
  Top := 31;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 18;
  ParentFont := True;
  OnClick := FontBoldInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with FontBoldCheckBox do
 begin
  Left := 453;
  Top := 32;
  Width := 14;
  Height := 14;
  TabOrder := 19;
  OnClick := FontBoldCheckBoxClick;
 end;
 with FontItalicInheritanceButton do
 begin
  Left := 434;
  Top := 47;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 20;
  ParentFont := True;
  OnClick := FontItalicInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with FontItalicCheckBox do
 begin
  Left := 453;
  Top := 48;
  Width := 14;
  Height := 14;
  TabOrder := 21;
  OnClick := FontItalicCheckBoxClick;
 end;
 with FontUnderlineInheritanceButton do
 begin
  Left := 434;
  Top := 63;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  ShowGlyph := False;
  TabOrder := 22;
  ParentFont := True;
  OnClick := FontUnderlineInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with FontUnderlineCheckBox do
 begin
  Left := 453;
  Top := 64;
  Width := 14;
  Height := 14;
  TabOrder := 23;
  OnClick := FontUnderlineCheckBoxClick;
 end;           
 with FontStrikeoutInheritanceButton do
 begin
  Left := 434;
  Top := 79;
  Width := 16;
  Height := 16;
  Hint := str_InheritanceButtonHint.AsStr;
  DrawDefaultFrame := False;
  AdjustSpaceForGlyph := False;
  Flat := True;
  NumGlyphs := 1;
  TabOrder := 24;
  ParentFont := True;
  OnClick := FontStrikeoutInheritanceButtonClick;
  DockOrientation := doNoOrient;
 end;
 with FontStrikeoutCheckBox do
 begin
  Left := 453;
  Top := 80;
  Width := 14;
  Height := 14;
  TabOrder := 25;
  OnClick := FontStrikeoutCheckBoxClick;
 end;
 with FontScalableCheckBox do
 begin
  Left := 453;
  Top := 105;
  Width := 14;
  Height := 14;
  TabOrder := 26;
  OnClick := FontScalableCheckBoxClick;
 end;
 with StyleCaptionLabel do
 begin
  AutoSize := False;
  Left := 263;
  Top := 130;
  Width := 108;
  Height := 16;
  Alignment := taRightJustify;
 end;
 with StyleCaptionComboBox do
 begin
  Left := 377;
  Top := 129;
  Width := 93;
  Height := 21;
  OnChange := StyleCaptionComboBoxChange;
  ParentShowHint := False;
  ShowHint := True;
  TabOrder := 27;
  ComboStyle := ct_cbEdit;
 end;
//#UC END# *4A8E8F2E0195_4AC642480314_impl*
end;//TPrimStyleEditorFontForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ValueIsGreaterThan.Init;
!!! Lost Message ini !!!
 {* Инициализация str_ValueIsGreaterThan }
 str_ValueIsLessThan.Init;
!!! Lost Message ini !!!
 {* Инициализация str_ValueIsLessThan }
 str_InheritanceButtonHint.Init;
 {* Инициализация str_InheritanceButtonHint }
 str_InheritanceButtonNoTransparentHint.Init;
 {* Инициализация str_InheritanceButtonNoTransparentHint }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimStyleEditorFontForm);
 {* Регистрация PrimStyleEditorFont }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
