unit NewBaseSearchForDFM_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\NewBaseSearchForDFM_Form.pas"
// Стереотип: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimBaseSearchOptions_Form
 {$If NOT Defined(NoVGScene)}
 , vg_controls
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_listbox
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_objects
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_layouts
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_scene
 {$IfEnd} // NOT Defined(NoVGScene)
 , l3Interfaces
 , BaseSearchInterfaces
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
;

type
 TvgRadioButtonItem = object
  public
   rButton: TvgRadioButton;
   rClass: InsBaseSearchClass;
  public
   function EQ(const anOther: TvgRadioButtonItem): Boolean;
 end;//TvgRadioButtonItem

 _ItemType_ = TvgRadioButtonItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvgRadioButtonArray = class(_l3RecordWithEQList_)
 end;//TvgRadioButtonArray

 TNewBaseSearchForDFMForm = class(TPrimBaseSearchOptionsForm)
  private
   f_Themes: TvgRadioButtonArray;
    {* Темы }
   f_FindBtn: TvgPathButton;
    {* Поле для свойства FindBtn }
   f_FindBackBtn: TvgPathButton;
    {* Поле для свойства FindBackBtn }
   f_CloseBtn: TvgCloseButton;
    {* Поле для свойства CloseBtn }
   f_AreaCombo: TvgComboBox;
    {* Поле для свойства AreaCombo }
   f_QueryExampleLabel: TvgText;
    {* Поле для свойства QueryExampleLabel }
   f_DropButton: TvgButton;
    {* Поле для свойства DropButton }
   f_FoundCountLabel: TvgText;
    {* Поле для свойства FoundCountLabel }
   f_ExampleLabel: TvgText;
    {* Поле для свойства ExampleLabel }
   f_ContextEditPanel: TvgNonVGLayout;
    {* Поле для свойства ContextEditPanel }
   f_Layout1: TvgLayout;
    {* Поле для свойства Layout1 }
   f_Layout2: TvgLayout;
    {* Поле для свойства Layout2 }
   f_Layout3: TvgLayout;
    {* Поле для свойства Layout3 }
   f_vgScene1: TvgScene;
    {* Поле для свойства vgScene1 }
   f_MoreTab: TvgComboBox;
    {* Поле для свойства MoreTab }
   f_Border: TvgRectangle;
    {* Поле для свойства Border }
   f_InnerBorder: TvgRectangle;
    {* Поле для свойства InnerBorder }
   f_MostOuterRectangle: TvgRectangle;
    {* Поле для свойства MostOuterRectangle }
   f_Rectangle1: TvgRectangle;
    {* Поле для свойства Rectangle1 }
  private
   procedure DoResize(aSender: TObject);
   procedure MoreTabChange(aSender: TObject);
   procedure DoSearch(aTag: Integer;
    aReallyNeedSearch: Boolean;
    aUpdateClassBeforeSearch: Boolean);
   procedure DoRealignLayout1(aSender: TObject);
   procedure TabChange(aSender: TObject);
   procedure ContextEditFocusChanged(aSender: TObject);
   procedure DoEmptyAddingClick(aSender: TObject);
  protected
   function pm_GetFindBtn: TvgPathButton;
   function pm_GetFindBackBtn: TvgPathButton;
   function pm_GetCloseBtn: TvgCloseButton;
   function pm_GetAreaCombo: TvgComboBox;
   function pm_GetQueryExampleLabel: TvgText;
   function pm_GetDropButton: TvgButton;
   function pm_GetFoundCountLabel: TvgText;
   function pm_GetExampleLabel: TvgText;
   function pm_GetContextEditPanel: TvgNonVGLayout;
   function pm_GetLayout1: TvgLayout;
   function pm_GetvgScene1: TvgScene;
   function pm_GetMoreTab: TvgComboBox;
   function pm_GetBorder: TvgRectangle;
   function pm_GetInnerBorder: TvgRectangle;
   function pm_GetMostOuterRectangle: TvgRectangle;
   function pm_GetRectangle1: TvgRectangle;
   function pm_GetActiveClassTab: TvgRadioButton;
   procedure TabClick(aSender: TObject);
   function AddListItem(aParent: TvgComboBox;
    const aStr: Il3CString): TvgListBoxItem;
   procedure AdjustParamsPagesHeight; override;
   procedure SetUpFindButtons; override;
   procedure SetupClasses(aFromUpdate: Boolean); override;
   procedure UpdateExamplePanelWidthAndPosition; override;
   procedure pm_SetFindBtnEnabled(aValue: Boolean); override;
   procedure pm_SetFindBackBtnEnabled(aValue: Boolean); override;
   procedure CheckParamsPagesCount(aCount: Integer); override;
   procedure SetCurrentContextKind(aKind: TnsBaseSearchKind); override;
   function pm_GetContextLabelVisible: Boolean; override;
   procedure pm_SetContextLabelVisible(aValue: Boolean); override;
   function pm_GetCloseBtnEnabled: Boolean; override;
   procedure pm_SetCloseBtnEnabled(aValue: Boolean); override;
   procedure SetCurrentSearchArea(anArea: TnsSearchArea); override;
   procedure SetupThemePages; override;
   procedure DoCheckFragmentsCount(const aFragmentsCountSuffix: Il3CString); override;
   procedure DoExampleChanged(const anExampleText: Il3CString); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure BeforeRelease; override;
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ApplyCurrentExample; override;
  public
   {$If NOT Defined(NoVCM)}
   function NeedSetMyFocus: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property ActiveClassTab: TvgRadioButton
    read pm_GetActiveClassTab;
  public
   property FindBtn: TvgPathButton
    read pm_GetFindBtn;
   property FindBackBtn: TvgPathButton
    read pm_GetFindBackBtn;
   property CloseBtn: TvgCloseButton
    read pm_GetCloseBtn;
   property AreaCombo: TvgComboBox
    read pm_GetAreaCombo;
   property QueryExampleLabel: TvgText
    read pm_GetQueryExampleLabel;
   property DropButton: TvgButton
    read pm_GetDropButton;
   property FoundCountLabel: TvgText
    read pm_GetFoundCountLabel;
   property ExampleLabel: TvgText
    read pm_GetExampleLabel;
   property ContextEditPanel: TvgNonVGLayout
    read pm_GetContextEditPanel;
   property Layout1: TvgLayout
    read pm_GetLayout1;
   property vgScene1: TvgScene
    read pm_GetvgScene1;
   property MoreTab: TvgComboBox
    read pm_GetMoreTab;
   property Border: TvgRectangle
    read pm_GetBorder;
   property InnerBorder: TvgRectangle
    read pm_GetInnerBorder;
   property MostOuterRectangle: TvgRectangle
    read pm_GetMostOuterRectangle;
   property Rectangle1: TvgRectangle
    read pm_GetRectangle1;
 end;//TNewBaseSearchForDFMForm

function TvgRadioButtonItem_C(const aClass: InsBaseSearchClass): TvgRadioButtonItem; overload;
function TvgRadioButtonItem_C(aButton: TvgRadioButton;
 const aClass: InsBaseSearchClass): TvgRadioButtonItem; overload;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3String
 , nsConst
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MinMax
 , Graphics
 , l3ControlsTypes
 , l3Base
 , SysUtils
 , l3ScreenIC
 , l3InternalInterfaces
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , Math
 , RTLConsts
;

const
 {* Локализуемые строки AreaStrings }
 str_asEverywhere: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'asEverywhere'; rValue : 'Везде');
  {* 'Везде' }
 str_asListDocuments: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'asListDocuments'; rValue : 'Список: в документах');
  {* 'Список: в документах' }
 str_asListNames: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'asListNames'; rValue : 'Список: в названиях');
  {* 'Список: в названиях' }
 str_asDocument: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'asDocument'; rValue : 'В документе');
  {* 'В документе' }
 {* Локализуемые строки ExampleText }
 str_etExample: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'etExample'; rValue : 'Пример:');
  {* 'Пример:' }
 str_etFoundCount: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'etFoundCount'; rValue : 'Всего найдено');
  {* 'Всего найдено' }
 {* Локализуемые строки MoreTabConsts }
 str_mtcMore: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'mtcMore'; rValue : 'Еще');
  {* 'Еще' }
 {* Локализуемые строки Local }
 str_ClassNotInBase: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ClassNotInBase'; rValue : 'Данный вид информации отсутствует в Вашем комплекте');
  {* 'Данный вид информации отсутствует в Вашем комплекте' }
 str_FoundFragmentCountHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'FoundFragmentCountHint'; rValue : 'Количество найденных в документе вхождений с искомым контекстом');
  {* 'Количество найденных в документе вхождений с искомым контекстом' }

function TvgRadioButtonItem_C(const aClass: InsBaseSearchClass): TvgRadioButtonItem;
//#UC START# *4DE6712F01AA_4DE66EAE0351_var*
//#UC END# *4DE6712F01AA_4DE66EAE0351_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4DE6712F01AA_4DE66EAE0351_impl*
 Result.rClass := aClass;
//#UC END# *4DE6712F01AA_4DE66EAE0351_impl*
end;//TvgRadioButtonItem_C

function TvgRadioButtonItem_C(aButton: TvgRadioButton;
 const aClass: InsBaseSearchClass): TvgRadioButtonItem;
//#UC START# *4DE6734A00D5_4DE66EAE0351_var*
//#UC END# *4DE6734A00D5_4DE66EAE0351_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4DE6734A00D5_4DE66EAE0351_impl*
 Result.rButton := aButton;
 Result.rClass := aClass;
//#UC END# *4DE6734A00D5_4DE66EAE0351_impl*
end;//TvgRadioButtonItem_C

function TvgRadioButtonItem.EQ(const anOther: TvgRadioButtonItem): Boolean;
//#UC START# *4DE6709D02E9_4DE66EAE0351_var*
//#UC END# *4DE6709D02E9_4DE66EAE0351_var*
begin
//#UC START# *4DE6709D02E9_4DE66EAE0351_impl*
 Result := (rClass = anOther.rClass) OR (rClass.IsSame(anOther.rClass));
 if Result then
  Result := (anOther.rButton = nil) OR (rButton = anOther.rButton);
//#UC END# *4DE6709D02E9_4DE66EAE0351_impl*
end;//TvgRadioButtonItem.EQ

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4CFCF49601B1_var*
//#UC END# *47B2C42A0163_4CFCF49601B1_var*
begin
//#UC START# *47B2C42A0163_4CFCF49601B1_impl*
 Assert(False);
//#UC END# *47B2C42A0163_4CFCF49601B1_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4CFCF49601B1_var*
//#UC END# *47B99D4503A2_4CFCF49601B1_var*
begin
//#UC START# *47B99D4503A2_4CFCF49601B1_impl*
 Result := -1;
 Assert(False);
//#UC END# *47B99D4503A2_4CFCF49601B1_impl*
end;//CompareExistingItems

type _Instance_R_ = TvgRadioButtonArray;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

function TNewBaseSearchForDFMForm.pm_GetFindBtn: TvgPathButton;
//#UC START# *4CFCE561011D_4CFCBB3600E0get_var*
//#UC END# *4CFCE561011D_4CFCBB3600E0get_var*
begin
//#UC START# *4CFCE561011D_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFCE561011D_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetFindBtn

function TNewBaseSearchForDFMForm.pm_GetFindBackBtn: TvgPathButton;
//#UC START# *4CFCE56E009C_4CFCBB3600E0get_var*
//#UC END# *4CFCE56E009C_4CFCBB3600E0get_var*
begin
//#UC START# *4CFCE56E009C_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFCE56E009C_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetFindBackBtn

function TNewBaseSearchForDFMForm.pm_GetCloseBtn: TvgCloseButton;
//#UC START# *4CFCE5B200A9_4CFCBB3600E0get_var*
//#UC END# *4CFCE5B200A9_4CFCBB3600E0get_var*
begin
//#UC START# *4CFCE5B200A9_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFCE5B200A9_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetCloseBtn

function TNewBaseSearchForDFMForm.pm_GetAreaCombo: TvgComboBox;
//#UC START# *4CFE0E5F02D5_4CFCBB3600E0get_var*
//#UC END# *4CFE0E5F02D5_4CFCBB3600E0get_var*
begin
//#UC START# *4CFE0E5F02D5_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFE0E5F02D5_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetAreaCombo

function TNewBaseSearchForDFMForm.pm_GetQueryExampleLabel: TvgText;
//#UC START# *4CFE2C9F0029_4CFCBB3600E0get_var*
//#UC END# *4CFE2C9F0029_4CFCBB3600E0get_var*
begin
//#UC START# *4CFE2C9F0029_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFE2C9F0029_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetQueryExampleLabel

function TNewBaseSearchForDFMForm.pm_GetDropButton: TvgButton;
//#UC START# *4CFF56750396_4CFCBB3600E0get_var*
//#UC END# *4CFF56750396_4CFCBB3600E0get_var*
begin
//#UC START# *4CFF56750396_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFF56750396_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetDropButton

function TNewBaseSearchForDFMForm.pm_GetFoundCountLabel: TvgText;
//#UC START# *4CFF80CC027F_4CFCBB3600E0get_var*
//#UC END# *4CFF80CC027F_4CFCBB3600E0get_var*
begin
//#UC START# *4CFF80CC027F_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFF80CC027F_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetFoundCountLabel

function TNewBaseSearchForDFMForm.pm_GetExampleLabel: TvgText;
//#UC START# *4CFF86B00026_4CFCBB3600E0get_var*
//#UC END# *4CFF86B00026_4CFCBB3600E0get_var*
begin
//#UC START# *4CFF86B00026_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFF86B00026_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetExampleLabel

function TNewBaseSearchForDFMForm.pm_GetContextEditPanel: TvgNonVGLayout;
//#UC START# *4CFFAEBB0305_4CFCBB3600E0get_var*
//#UC END# *4CFFAEBB0305_4CFCBB3600E0get_var*
begin
//#UC START# *4CFFAEBB0305_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFFAEBB0305_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetContextEditPanel

function TNewBaseSearchForDFMForm.pm_GetLayout1: TvgLayout;
//#UC START# *4CFFB1B500DB_4CFCBB3600E0get_var*
//#UC END# *4CFFB1B500DB_4CFCBB3600E0get_var*
begin
//#UC START# *4CFFB1B500DB_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFFB1B500DB_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetLayout1

function TNewBaseSearchForDFMForm.pm_GetvgScene1: TvgScene;
//#UC START# *4CFFB59200DB_4CFCBB3600E0get_var*
//#UC END# *4CFFB59200DB_4CFCBB3600E0get_var*
begin
//#UC START# *4CFFB59200DB_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CFFB59200DB_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetvgScene1

function TNewBaseSearchForDFMForm.pm_GetMoreTab: TvgComboBox;
//#UC START# *4D49931D0389_4CFCBB3600E0get_var*
//#UC END# *4D49931D0389_4CFCBB3600E0get_var*
begin
//#UC START# *4D49931D0389_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D49931D0389_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetMoreTab

function TNewBaseSearchForDFMForm.pm_GetBorder: TvgRectangle;
//#UC START# *4D70E56F0066_4CFCBB3600E0get_var*
//#UC END# *4D70E56F0066_4CFCBB3600E0get_var*
begin
//#UC START# *4D70E56F0066_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D70E56F0066_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetBorder

function TNewBaseSearchForDFMForm.pm_GetInnerBorder: TvgRectangle;
//#UC START# *4D70E57F00C3_4CFCBB3600E0get_var*
//#UC END# *4D70E57F00C3_4CFCBB3600E0get_var*
begin
//#UC START# *4D70E57F00C3_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D70E57F00C3_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetInnerBorder

function TNewBaseSearchForDFMForm.pm_GetMostOuterRectangle: TvgRectangle;
//#UC START# *4D70E7DD0123_4CFCBB3600E0get_var*
//#UC END# *4D70E7DD0123_4CFCBB3600E0get_var*
begin
//#UC START# *4D70E7DD0123_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D70E7DD0123_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetMostOuterRectangle

function TNewBaseSearchForDFMForm.pm_GetRectangle1: TvgRectangle;
//#UC START# *4DE6764D000D_4CFCBB3600E0get_var*
//#UC END# *4DE6764D000D_4CFCBB3600E0get_var*
begin
//#UC START# *4DE6764D000D_4CFCBB3600E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DE6764D000D_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetRectangle1

function TNewBaseSearchForDFMForm.pm_GetActiveClassTab: TvgRadioButton;
//#UC START# *4DE66D94033D_4CFCBB3600E0get_var*
var
 l_I : Integer;
//#UC END# *4DE66D94033D_4CFCBB3600E0get_var*
begin
//#UC START# *4DE66D94033D_4CFCBB3600E0get_impl*
 l_I := f_Themes.IndexOf(TvgRadioButtonItem_C(f_BaseSearcher.WindowData.ActiveClass));
 if (l_I < 0) then
  Result := nil
 else
  Result := f_Themes[l_I].rButton;
//#UC END# *4DE66D94033D_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetActiveClassTab

procedure TNewBaseSearchForDFMForm.TabClick(aSender: TObject);
//#UC START# *4CFE4BA60063_4CFCBB3600E0_var*
//#UC END# *4CFE4BA60063_4CFCBB3600E0_var*
begin
//#UC START# *4CFE4BA60063_4CFCBB3600E0_impl*
// Assert(Sender Is TvgRadioButton);
(* if not TvgRadioButton(Sender).IsChecked then
  Exit;*)
// DoSearch(TvgRadioButton(Sender).Tag);
//#UC END# *4CFE4BA60063_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.TabClick

function TNewBaseSearchForDFMForm.AddListItem(aParent: TvgComboBox;
 const aStr: Il3CString): TvgListBoxItem;
//#UC START# *4D3D7176028B_4CFCBB3600E0_var*
var
 l_Item: TvgListBoxItem;
//#UC END# *4D3D7176028B_4CFCBB3600E0_var*
begin
//#UC START# *4D3D7176028B_4CFCBB3600E0_impl*
 l_Item := TvgListBoxItem.Create(nil);
 l_Item.Parent := aParent.ListBox;
 if (aParent = MoreTab) then
  l_Item.Resource := {'docSetElementStyle'}'moreButtonElementStyle'
 else
 if (aParent = AreaCombo) then
  l_Item.Resource := 'docSetElementStyle'
 else
  Assert(False); 
 l_Item.Binding['text'] := l3WideString(aStr);
 if (aParent = MoreTab) then
 begin
  l_Item.Font.Size := 11;
  l_Item.Font.Family := 'Tahoma';
 end//aParent = MoreTab
 else
 begin
  l_Item.Font.Size := 12;
  l_Item.Font.Family := 'Arial';
 end;//aParent = MoreTab
 Result := l_Item;
 //l_Item.Font.Style := vgFontBold;
//#UC END# *4D3D7176028B_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.AddListItem

procedure TNewBaseSearchForDFMForm.DoResize(aSender: TObject);
//#UC START# *4D4AA2B500C8_4CFCBB3600E0_var*
//#UC END# *4D4AA2B500C8_4CFCBB3600E0_var*
begin
//#UC START# *4D4AA2B500C8_4CFCBB3600E0_impl*
 if (Parent <> nil) then
 begin
  if (ClientHeight > 122{99{80{ + 13}){ AND (ClientHeight <> 86 + 13)} then
  begin
   ClientHeight := 86 + 13;
   Height := 86 + 13;
   Parent.Height := 86 + 13;
  end;//ClientHeight > 80
 end;//Parent <> nil
 SetupThemePages;
//#UC END# *4D4AA2B500C8_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.DoResize

procedure TNewBaseSearchForDFMForm.MoreTabChange(aSender: TObject);
//#UC START# *4D4ACB9900F6_4CFCBB3600E0_var*
//#UC END# *4D4ACB9900F6_4CFCBB3600E0_var*
begin
//#UC START# *4D4ACB9900F6_4CFCBB3600E0_impl*
 if (f_LockParamsChange = 0) then
  with MoreTab do
   if Assigned(f_BaseSearcher) AND
      (ItemIndex >= 0) AND (ItemIndex < MoreTab.Count) AND
      //см. ниже (Popup.JustClosed = 0) - проверям для отсечения вызова из TvgComboBox.MouseDown, чтобы не возникала ошибка
      //http://mdp.garant.ru/pages/viewpage.action?pageId=294604800
      (Popup.JustClosed = 0) then
    DoSearch(ListBox.Items[ItemIndex].Tag, not Popup.IsOpen, False);
//#UC END# *4D4ACB9900F6_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.MoreTabChange

procedure TNewBaseSearchForDFMForm.DoSearch(aTag: Integer;
 aReallyNeedSearch: Boolean;
 aUpdateClassBeforeSearch: Boolean);
//#UC START# *4D4BD7C902EA_4CFCBB3600E0_var*

var
 l_Class : InsBaseSearchClass;

{ procedure UpdateSearcherClass;
 begin//UpdateSearcherClass
  Inc(f_LockParamsChange);
  try
(*   if not Focused and ThemePages.ChangingActivePageByMouse then
    ActivateWindow(False);*)

   if Assigned(f_BaseSearcher) and (not f_BaseSearcher.ActiveClass.IsSameNode(l_Class))
   // проверка отсекает повторную установку уже выбранного Вида информации,
   // без данной проверки, в vgscene возникает артифакт отрисовки при клике
   // по тому же Виду информации - http://mdp.garant.ru/pages/viewpage.action?pageId=327353074
   then
   begin
    f_BaseSearcher.ActiveClass := l_Class;

    // в перерисовки нет необходимости, на vgscene могут возникать артефакты в эффектах
    //if (f_BaseSearcher <> nil) then
    //begin
    // if (ActiveClassTab <> nil) then
    //  ActiveClassTab.Repaint;
    // Application.ProcessMessages;
    //end;//f_BaseSearcher <> nil
   end;//Assigned(f_BaseSearcher)
   if FlashTimer.Enabled then
    StopFlash;
  finally
   Dec(f_LockParamsChange);
  end;//try..finally
 end;//UpdateSearcherClass}
 // - Переехало в TPrimBaseSearchForm.SearchByContext

var
 l_NeedSearch : Boolean;
//#UC END# *4D4BD7C902EA_4CFCBB3600E0_var*
begin
//#UC START# *4D4BD7C902EA_4CFCBB3600E0_impl*
 if (f_LockParamsChange > 0) or (aTag >= f_Themes.Count) then
  Exit;

 l_Class := f_Themes[aTag].rClass;
 l_NeedSearch := aReallyNeedSearch AND
                 Assigned(f_BaseSearcher){ AND
                 (f_BaseSearcher.ActiveClass <> l_Class)};
                 // - иначе при повторном выборе из "Ещё" пункта,
                 //   который уже был выбран - поиск не работал

 if l_NeedSearch then
 begin
(*  Assert(f_BaseSearcher <> nil);
  Assert(f_BaseSearcher.Presentation <> nil);
  if f_BaseSearcher.Presentation.NeedSaveActiveClassBeforeSearch then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=327826220
   f_ActiveClassForSaveInHistory := f_BaseSearcher.ActiveClass
  else
   f_ActiveClassForSaveInHistory := l_Class;
  f_BaseSearcher.StoreActiveClass;

  // чтобы избежать http://mdp.garant.ru/pages/viewpage.action?pageId=326775251
  // UpdateSearcherClass вызываем, если l_NeedSearch
  UpdateSearcherClass;*)
  // - Переехало в TPrimBaseSearchForm.SearchByContext

  try
   SearchByContext(l_Class, True, aUpdateClassBeforeSearch);
  except
   on ETryToFindEmptyContext do ;
  end;//try..except
 end;//l_NeedSearch
//#UC END# *4D4BD7C902EA_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.DoSearch

procedure TNewBaseSearchForDFMForm.DoRealignLayout1(aSender: TObject);
//#UC START# *4D5164A30162_4CFCBB3600E0_var*
var
 l_Delta : Single;
//#UC END# *4D5164A30162_4CFCBB3600E0_var*
begin
//#UC START# *4D5164A30162_4CFCBB3600E0_impl*
 if not Layout3.Visible then
  Layout2.Width := DropButton.Width
 else
  Layout2.Width := Math.Min(220, (Layout1.Width {* 2}) / 3);
 if AreaCombo.Visible then
  l_Delta := AreaCombo.Width
 else
  l_Delta := 0;
 Border.Position.X := MostOuterRectangle.Position.X + l_Delta;
 Border.Position.Y := MostOuterRectangle.Position.Y;
 Border.Height := MostOuterRectangle.Height;
 Border.Width := MostOuterRectangle.Width - l_Delta - DropButton.Width + 1;
 InnerBorder.Position.X := MostOuterRectangle.Position.X + 2 + l_Delta;
 InnerBorder.Position.Y := MostOuterRectangle.Position.Y + 2;
 InnerBorder.Height := MostOuterRectangle.Height - 4;
 InnerBorder.Width := MostOuterRectangle.Width - l_Delta - 4 - DropButton.Width + 1;
//#UC END# *4D5164A30162_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.DoRealignLayout1

procedure TNewBaseSearchForDFMForm.TabChange(aSender: TObject);
//#UC START# *4D5C0D11022D_4CFCBB3600E0_var*
//#UC END# *4D5C0D11022D_4CFCBB3600E0_var*
begin
//#UC START# *4D5C0D11022D_4CFCBB3600E0_impl*
 Assert(aSender Is TvgRadioButton);
 if not TvgRadioButton(aSender).IsChecked then
  Exit;
 DoSearch(TvgRadioButton(aSender).Tag, True, True);
//#UC END# *4D5C0D11022D_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.TabChange

procedure TNewBaseSearchForDFMForm.ContextEditFocusChanged(aSender: TObject);
//#UC START# *4D70ED5901BF_4CFCBB3600E0_var*
//#UC END# *4D70ED5901BF_4CFCBB3600E0_var*
begin
//#UC START# *4D70ED5901BF_4CFCBB3600E0_impl*
(* Border.Visible := ContextEdit.Focused;
 InnerBorder.Visible := ContextEdit.Focused;*)
 Border.Visible := False;
 InnerBorder.Visible := False;
//#UC END# *4D70ED5901BF_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.ContextEditFocusChanged

procedure TNewBaseSearchForDFMForm.DoEmptyAddingClick(aSender: TObject);
//#UC START# *4E7899330095_4CFCBB3600E0_var*
//#UC END# *4E7899330095_4CFCBB3600E0_var*
begin
//#UC START# *4E7899330095_4CFCBB3600E0_impl*
 ApplyCurrentExample;
//#UC END# *4E7899330095_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.DoEmptyAddingClick

procedure TNewBaseSearchForDFMForm.AdjustParamsPagesHeight;
//#UC START# *4CF4D1AD01B3_4CFCBB3600E0_var*
//#UC END# *4CF4D1AD01B3_4CFCBB3600E0_var*
begin
//#UC START# *4CF4D1AD01B3_4CFCBB3600E0_impl*
 // - ничего не делаем
//#UC END# *4CF4D1AD01B3_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.AdjustParamsPagesHeight

procedure TNewBaseSearchForDFMForm.SetUpFindButtons;
//#UC START# *4CF4D56E0258_4CFCBB3600E0_var*
const
 cMinFindBtnWidth = 80;
 cFindBackBtnWidth = 37;
 cDelta = c_ControlBorder;
var
 l_WasVisible : Boolean;
//#UC END# *4CF4D56E0258_4CFCBB3600E0_var*
begin
//#UC START# *4CF4D56E0258_4CFCBB3600E0_impl*
 Dispatcher.FormDispatcher.Lock;
 try
  l_WasVisible := FindBackBtn.Visible;
  if f_BaseSearcher.WindowData.FindBackSupported then
  begin
   FindBackBtn.Enabled := f_BaseSearcher.WindowData.FindBackEnabled;
   FindBackBtn.Visible := True;
   FindBtn.Width := cMinFindBtnWidth;
   FindBackBtn.Position.X := FindBtn.Position.X + FindBtn.Width + cDelta;
   FindBtn.PathFill.Style := vgBrushSolid;
   FindBtn.PathSize := 13;
   //FindBtn.Layout := blGlyphRight;
  end//f_BaseSearcher.FindBackSupported
  else
  begin
   FindBackBtn.Enabled := False;
   FindBackBtn.Visible := False;
   FindBtn.Width := cMinFindBtnWidth + cFindBackBtnWidth + cDelta;
   FindBtn.PathFill.Style := vgBrushNone;
   FindBtn.PathSize := 0;
   //FindBtn.Layout := blGlyphLeft;
  end;//f_BaseSearcher.FindBackSupported
 finally
  Dispatcher.FormDispatcher.UnLock;
 end;//try..finally
//#UC END# *4CF4D56E0258_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.SetUpFindButtons

procedure TNewBaseSearchForDFMForm.SetupClasses(aFromUpdate: Boolean);
//#UC START# *4CF4D6C40292_4CFCBB3600E0_var*

 function AddButton(const aClass : InsBaseSearchClass): TvgRadioButton;
 var
  l_B : TvgRadioButton;
 begin//AddButton
  l_B := TvgRadioButton.Create(Self);
  l_B.Resource := 'filterButtonStyle';
  l_B.Height := 31;
  l_B.TextAlign := vgTextAlignCenter;
  l_B.Parent := CloseBtn.Parent{Rectangle1};
  l_B.Position.X := 20;
  l_B.Position.Y := 6;
  f_Themes.Add(TvgRadioButtonItem_C(l_B, aClass));
  Result := l_B;
 end;//AddButton

var
 l_Index : Integer;
 l_SeachClassEnumerator: InsBaseSearchClassesEnumerator;
 l_F : InsBaseSearchClass;
 l_N : InsBaseSearchClass;
 l_AC : InsBaseSearchClasses;
 l_Item : TvgRadioButtonItem;
 l_Button: TvgRadioButton;
const
 cRadioButtonMargin = 15;
//#UC END# *4CF4D6C40292_4CFCBB3600E0_var*
begin
//#UC START# *4CF4D6C40292_4CFCBB3600E0_impl*
 if aFromUpdate then
 begin
  if (f_Themes <> nil) then
  begin
   for l_Index := 0 to Pred(f_Themes.Count) do
   begin
    l_Item := f_Themes[l_Index];
    vgScene1.RemoveTabStop(l_Item.rButton);
    // - удаляем ссылку без счётчика ссылок - дабы не огрести AV
    FreeAndNil(l_Item.rButton);
    f_Themes[l_Index] := l_Item;
   end;//for l_Index
   vgScene1.Invalidate;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=294600483&focusedCommentId=320738798#comment-320738798
  end;//f_Themes <> nil
  // http://mdp.garant.ru/pages/viewpage.action?pageId=294600483
  // - "на коленке" убиваем ненужные кнопки
  //   На коленке - потому, что я ещё не решил - надо ли всегда кнопкам счётчик ссылок дёргать.
  //   А если его не всегда дёргать, то список не может сам кнопки уничтожать.
  FreeAndNil(f_Themes);
  // - тут есть проблема кнопки не уничтожаются, а попадают в отстойник
  // http://mdp.garant.ru/pages/viewpage.action?pageId=294609591&focusedCommentId=294609752&#comment-294609752
  // Надо переделывать список и убивать кнопки при FreeItem
 end;//aFromUpdate

 if (f_Themes = nil) then
 begin
  f_Themes := TvgRadioButtonArray.Create;

  l_SeachClassEnumerator := f_BaseSearcher.WindowData.AvailableClasses.GetEnumerator;

  while l_SeachClassEnumerator.MoveNext do
   AddButton(l_SeachClassEnumerator.Current);
  // - тут надо вывести f_BaseSearcher.AllClasses
  //   чтобы по-любому создать все кнопки

  for l_Index := 0 to f_Themes.Hi do
    with f_Themes[l_Index].rButton do
    begin
     OnClick := Self.TabClick;
     OnChange := Self.TabChange;
     Tag := l_Index;
    end;

  for l_Index := 0 to f_Themes.Hi do
   vgScene1.AddTabStop(f_Themes[l_Index].rButton);

  vgScene1.AddTabStop(MoreTab);
  vgScene1.AddTabStop(AreaCombo);
  vgScene1.AddTabStop(ContextEditPanel);
  vgScene1.AddTabStop(QueryExampleLabel);
  vgScene1.AddTabStop(FindBtn);
  vgScene1.AddTabStop(FindBackBtn);
 end;//f_Themes = nil
 
 for l_Index := 0 to f_Themes.Hi do
 begin
  f_Themes[l_Index].rButton.Text := l3WideString(f_Themes[l_Index].rClass.Name);
  l_Button := f_Themes[l_Index].rButton;
  TvgCanvas(l_Button.Canvas).Font.Assign(f_Themes[l_Index].rButton.Font);
  l_Button.Width := TvgCanvas(l_Button.Canvas).TextWidth(l_Button.Text) + 2 * cRadioButtonMargin;
 end;//for l_Index
 if aFromUpdate then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=294600483&focusedCommentId=320742020#comment-320742020
  SetupThemePages;
//#UC END# *4CF4D6C40292_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.SetupClasses

procedure TNewBaseSearchForDFMForm.UpdateExamplePanelWidthAndPosition;
//#UC START# *4CF4DC7C0129_4CFCBB3600E0_var*
//#UC END# *4CF4DC7C0129_4CFCBB3600E0_var*
begin
//#UC START# *4CF4DC7C0129_4CFCBB3600E0_impl*
 // - ничего не делаем
//#UC END# *4CF4DC7C0129_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.UpdateExamplePanelWidthAndPosition

procedure TNewBaseSearchForDFMForm.pm_SetFindBtnEnabled(aValue: Boolean);
//#UC START# *4CFCCE4B0112_4CFCBB3600E0set_var*
//#UC END# *4CFCCE4B0112_4CFCBB3600E0set_var*
begin
//#UC START# *4CFCCE4B0112_4CFCBB3600E0set_impl*
 FindBtn.Enabled := aValue;
//#UC END# *4CFCCE4B0112_4CFCBB3600E0set_impl*
end;//TNewBaseSearchForDFMForm.pm_SetFindBtnEnabled

procedure TNewBaseSearchForDFMForm.pm_SetFindBackBtnEnabled(aValue: Boolean);
//#UC START# *4CFCD6270160_4CFCBB3600E0set_var*
//#UC END# *4CFCD6270160_4CFCBB3600E0set_var*
begin
//#UC START# *4CFCD6270160_4CFCBB3600E0set_impl*
 FindBackBtn.Enabled := aValue;
//#UC END# *4CFCD6270160_4CFCBB3600E0set_impl*
end;//TNewBaseSearchForDFMForm.pm_SetFindBackBtnEnabled

procedure TNewBaseSearchForDFMForm.CheckParamsPagesCount(aCount: Integer);
//#UC START# *4CFCE1AE01A0_4CFCBB3600E0_var*
//#UC END# *4CFCE1AE01A0_4CFCBB3600E0_var*
begin
//#UC START# *4CFCE1AE01A0_4CFCBB3600E0_impl*
 // - ничего не делаем
//#UC END# *4CFCE1AE01A0_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.CheckParamsPagesCount

procedure TNewBaseSearchForDFMForm.SetCurrentContextKind(aKind: TnsBaseSearchKind);
//#UC START# *4CFCE22D03D1_4CFCBB3600E0_var*
//#UC END# *4CFCE22D03D1_4CFCBB3600E0_var*
begin
//#UC START# *4CFCE22D03D1_4CFCBB3600E0_impl*
 AreaCombo.Clear;
 AddListItem(AreaCombo, str_asEverywhere.AsCStr);
 Case aKind of
  ns_bskMenu:
   ;
  ns_bskList:
  begin
   AddListItem(AreaCombo, str_asListDocuments.AsCStr);
   AddListItem(AreaCombo, str_asListNames.AsCStr);
  end;//ns_bskList
  ns_bskDocument:
  begin
   AddListItem(AreaCombo, str_asDocument.AsCStr);
  end;//ns_bskDocument
  ns_bskQuery:
   ;
  else
   Assert(False);
 end;//Case aKind
 AreaCombo.DropDownCount := AreaCombo.Count;
 AreaCombo.Visible := (AreaCombo.Count > 1);
 if AreaCombo.Visible then
 begin
  AreaCombo.ItemIndex := 1;
  ContextEditPanel.Padding.Left := 4;
  //ContextEdit.Regionable := False;
  Layout1.Position.X := AreaCombo.Position.X + AreaCombo.Width
 end//AreaCombo.Visible
 else
 begin
  AreaCombo.ItemIndex := 0;
  ContextEditPanel.Padding.Left := 5;
  //ContextEdit.Regionable := True;
  Layout1.Position.X := AreaCombo.Position.X;
 end;//AreaCombo.Visible
 Layout1.Realign;
 AreaCombo.Repaint;
//#UC END# *4CFCE22D03D1_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.SetCurrentContextKind

function TNewBaseSearchForDFMForm.pm_GetContextLabelVisible: Boolean;
//#UC START# *4CFCEBFA0350_4CFCBB3600E0get_var*
//#UC END# *4CFCEBFA0350_4CFCBB3600E0get_var*
begin
//#UC START# *4CFCEBFA0350_4CFCBB3600E0get_impl*
 Result := Border.Visible;
 //Result := ContextEdit.Focused;
 //Result := (ContextEdit.BorderStyle = bsNone);
//#UC END# *4CFCEBFA0350_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetContextLabelVisible

procedure TNewBaseSearchForDFMForm.pm_SetContextLabelVisible(aValue: Boolean);
//#UC START# *4CFCEBFA0350_4CFCBB3600E0set_var*
//#UC END# *4CFCEBFA0350_4CFCBB3600E0set_var*
begin
//#UC START# *4CFCEBFA0350_4CFCBB3600E0set_impl*
(* if not ContextEdit.Focused then
  aValue := not aValue;*)
 Border.Visible := aValue;
 InnerBorder.Visible := aValue;
 
(* if aValue then
  ContextEdit.BorderStyle := bsNone
 else
  ContextEdit.BorderStyle := bsSingle;*)
 Border.Repaint;
 InnerBorder.Repaint;
 ContextEdit.Repaint;
//#UC END# *4CFCEBFA0350_4CFCBB3600E0set_impl*
end;//TNewBaseSearchForDFMForm.pm_SetContextLabelVisible

function TNewBaseSearchForDFMForm.pm_GetCloseBtnEnabled: Boolean;
//#UC START# *4CFCEE450210_4CFCBB3600E0get_var*
//#UC END# *4CFCEE450210_4CFCBB3600E0get_var*
begin
//#UC START# *4CFCEE450210_4CFCBB3600E0get_impl*
 Result := CloseBtn.Enabled;
//#UC END# *4CFCEE450210_4CFCBB3600E0get_impl*
end;//TNewBaseSearchForDFMForm.pm_GetCloseBtnEnabled

procedure TNewBaseSearchForDFMForm.pm_SetCloseBtnEnabled(aValue: Boolean);
//#UC START# *4CFCEE450210_4CFCBB3600E0set_var*
//#UC END# *4CFCEE450210_4CFCBB3600E0set_var*
begin
//#UC START# *4CFCEE450210_4CFCBB3600E0set_impl*
 CloseBtn.Enabled := aValue;
 CloseBtn.Visible := aValue;
//#UC END# *4CFCEE450210_4CFCBB3600E0set_impl*
end;//TNewBaseSearchForDFMForm.pm_SetCloseBtnEnabled

procedure TNewBaseSearchForDFMForm.SetCurrentSearchArea(anArea: TnsSearchArea);
//#UC START# *4CFE140401CF_4CFCBB3600E0_var*
//#UC END# *4CFE140401CF_4CFCBB3600E0_var*
begin
//#UC START# *4CFE140401CF_4CFCBB3600E0_impl*
 Case anArea of
  ns_saEverywere:
   AreaCombo.ItemIndex := 0;
  ns_saText:
   AreaCombo.ItemIndex := 1;
  ns_saTitlesOnly:
   AreaCombo.ItemIndex := 2;
  else
   Assert(False);
 end;//Case anArea
//#UC END# *4CFE140401CF_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.SetCurrentSearchArea

procedure TNewBaseSearchForDFMForm.SetupThemePages;
//#UC START# *4CFE192200C5_4CFCBB3600E0_var*

 procedure UpdateChecked;
 var
  l_ACT : TvgRadioButton;
 begin//UpdateChecked
  l_ACT := ActiveClassTab;
  if (l_ACT <> nil) then
  begin
   l_ACT.IsChecked := True;
   MoreTab.IsChecked := not l_ACT.Visible;
  end//ActiveClassTab <> nil
  else
   MoreTab.IsChecked := True;
 end;//UpdateChecked
 
 procedure SetText(anObj: TvgObject;
                   const aResName: String;
                   const aText: Tl3StringIDEx);
 var
  l_Index : Integer;
  l_Child : TvgObject;
 begin//SetText
  for l_Index := 0 to Pred(anObj.ChildrenCount) do
  begin
   l_Child := anObj.Children[l_Index];
   if (l_Child.ResourceName = aResName) then
   begin
    if (l_Child Is TvgText) then
     TvgText(l_Child).Text := aText.AsWideString
    else
     Assert(False);
    Break;
   end//l_Child.ResourceName = aResName
   else
    SetText(l_Child, aResName, aText);
  end;//for l_Index
 end;//SetText

var
 l_Idx : Integer;
 l_IdxP : Integer;
 l_LastVisible : Integer;
 l_LastVisiblePos : Extended;
 l_Pos : Extended;
 l_Enabled : Boolean;
 l_LimitWidth : Extended;
 // - максимальная ширина в которой могут располагаться кнопки-закладки
//#UC END# *4CFE192200C5_4CFCBB3600E0_var*
begin
//#UC START# *4CFE192200C5_4CFCBB3600E0_impl*
 if (f_BaseSearcher <> nil) then
 begin
  Inc(f_LockParamsChange);
  try
   l_LimitWidth := Self.Width - FindBtn.Width - 20;
   if FindBackBtn.Visible then
    l_LimitWidth := l_LimitWidth - FindBackBtn.Width;
   l_LastVisible := -1;
   UpdateChecked;
   l_Pos := 20;
   if AreaCombo.Visible then
    l_Pos := l_Pos + AreaCombo.Width;
   l_LastVisiblePos := l_Pos; 
   for l_Idx := 0 to f_Themes.Hi do
    with f_Themes[l_Idx].rButton do
    begin
     if (f_BaseSearcher.Presentation = nil) OR
        (f_BaseSearcher.Presentation.ContextSearcher = nil) OR
        not f_BaseSearcher.Presentation.ContextSearcher.IsLocalSearchArea then
      l_Enabled := True
     else
      l_Enabled := False;
     //l_Enabled := (f_BaseSearcher.AvailableClasses <> nil){(l_Idx in f_BaseSearcher.AvailableClasses)};
     Enabled := l_Enabled;
     if Enabled or (f_BaseSearcher.WindowData.ClassesAnywayDisabled) then
      Hint := ''
     else
      Hint := str_ClassNotInBase.AsWideString;
{     if (l_IDX in cVisibleEqualEnabled) then
      Visible := Enabled
     else}
      Visible := True;
(*     if (f_BaseSearcher.Presentation = nil) OR
        (f_BaseSearcher.Presentation.ContextSearcher = nil) OR
        f_BaseSearcher.Presentation.ContextSearcher.IsLocalSearchArea then
      Visible := True
     else
      Visible := l_Enabled;*)
     if Visible then
     begin
      Position.X := l_Pos;
      l_Pos := l_Pos + Width + c_ControlBorder + 1;
      if (l_LastVisible = -1) then
      begin
       if (l_Pos > l_LimitWidth) then
       begin
        l_LastVisible := l_Idx;
        l_LastVisiblePos := Position.X;
        Visible := False;
       end;//l_Pos > l_LimitWidth
      end//l_LastVisible = -1
      else
       Visible := False;
     end;//Visible
    end;//with f_Themes[l_Idx]
   if (ActiveClassTab <> nil) then
    with ActiveClassTab do
     if Enabled then
      IsChecked := False;
   MoreTab.ApplyResource;
   SetText(MoreTab, 'ComboText', str_mtcMore);
   if (l_LastVisible = -1) then
    MoreTab.Position.X := l_Pos
   else
   begin
    MoreTab.Position.X := l_LastVisiblePos;
    l_IdxP := Pred(l_LastVisible);
    while (l_IdxP > {Low(l_IdxP)} -1) AND
          (MoreTab.Position.X + MoreTab.Width > l_LimitWidth) do
    begin
     if f_Themes[l_IdxP].rButton.Visible then
     begin
      MoreTab.Position.X := f_Themes[l_IdxP].rButton.Position.X;
      f_Themes[l_IdxP].rButton.Visible := False;
     end;//f_Themes[l_IdxP].Visible
     Assert(l_IdxP > Low(l_IdxP));
     Dec(l_IdxP);
    end;//l_IdxP > Low(l_IdxP
    l_LastVisible := Succ(l_IdxP);
   end;//l_LastVisible = -1
   MoreTab.ListBox.Resource := 'docSetComboListStyle'{'moreButtonListStyle'};
   MoreTab.ListBox.ShowScrollBars := False;
   MoreTab.Clear;
   if (l_LastVisible >= 0) then
    if not f_Themes.Empty then
     for l_IdxP := Max(0, l_LastVisible) to f_Themes.Hi do
      if f_Themes[l_IdxP].rButton.Enabled then
       AddListItem(MoreTab, l3CStr(f_Themes[l_IdxP].rButton.Text)).Tag := l_IdxP;
   //AddListItem(MoreTab, str_mtcMore.AsCStr).Visible := False;
   MoreTab.ItemHeight := 25;
   MoreTab.ItemIndex := -1;
   if (l_LastVisible >= 0) AND
      (ActiveClassTab <> nil) then
    MoreTab.ItemIndex := ActiveClassTab.Tag - l_LastVisible
   else
    MoreTab.ItemIndex := 0{MoreTab.Count - 1};
   MoreTab.DropDownCount := MoreTab.Count{ - 1};
   MoreTab.Visible := (MoreTab.DropDownCount > 0);
   //MoreTab.Text := str_mtcMore.AsWideString;
  (* ThemePages.TabStop := f_BaseSearcher.AvailableClasses <> [];
   ThemePages.InactiveTabColor := BackColor1;
   if f_BaseSearcher.AvailableClasses = [] then
    ThemePages.ActiveTabColor := ThemePages.InactiveTabColor
   else
    ThemePages.ActiveTabColor := clWhite;*)
   UpdateChecked; 
  finally
   Dec(f_LockParamsChange);
  end;//try..finally
 end;//f_BaseSearcher <> nil
//#UC END# *4CFE192200C5_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.SetupThemePages

procedure TNewBaseSearchForDFMForm.DoCheckFragmentsCount(const aFragmentsCountSuffix: Il3CString);
//#UC START# *4CFE28330018_4CFCBB3600E0_var*
(*var
 l_D : Extended;*)
//#UC END# *4CFE28330018_4CFCBB3600E0_var*
begin
//#UC START# *4CFE28330018_4CFCBB3600E0_impl*
 if VCMCLosing then
  Exit;
 FoundCountLabel.Text := l3WideString(aFragmentsCountSuffix);
 if l3IsNil(aFragmentsCountSuffix) then
 begin
  FoundCountLabel.ShowHint := False;
  FoundCountLabel.Hint := '';
  QueryExampleLabel.Position := FoundCountLabel.Position;
  FoundCountLabel.Visible := False;
  QueryExampleLabel.Visible := False{True};
  ExampleLabel.Text := str_etExample.AsWideString;
  ExampleLabel.Visible := False;
  QueryExampleLabel.Position.X := ExampleLabel.Position.X + ExampleLabel.Width;
  ExampleLabel.Visible := False;
  //l_D := Layout3.Width;
  Layout3.Visible := False;
  ContextEditPanel.Width := Layout1.Width - DropButton.Width;
(*  ContextEditPanel.Width := ContextEditPanel.Width + l_D;
  ContextEdit.Width := ContextEdit.Width + Round(l_D);*)
 end//l3IsNil(aFragmentsCountSuffix)
 else
 begin
  FoundCountLabel.ShowHint := True;
  FoundCountLabel.Hint := str_FoundFragmentCountHint.AsWideString;
  FoundCountLabel.Position := QueryExampleLabel.Position;
  FoundCountLabel.Visible := True;
  QueryExampleLabel.Visible := False;
  ExampleLabel.Text := str_etFoundCount.AsWideString;
  FoundCountLabel.Position.X := ExampleLabel.Position.X + ExampleLabel.Width;
  ExampleLabel.Visible := True;
  Layout3.Visible := True;
  Layout2.Width := Math.Min(220, (Layout1.Width {* 2}) / 3);
  Layout3.Width := Layout2.Width - DropButton.Width;
  ContextEditPanel.Width := Layout1.Width - Layout2.Width;
(*  ContextEditPanel.Width := ContextEditPanel.Width - l_D;
  ContextEdit.Width := ContextEdit.Width - Round(l_D);*)
 end;//l3IsNil(aFragmentsCountSuffix)
//#UC END# *4CFE28330018_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.DoCheckFragmentsCount

procedure TNewBaseSearchForDFMForm.DoExampleChanged(const anExampleText: Il3CString);
//#UC START# *4CFE2AA80164_4CFCBB3600E0_var*
//#UC END# *4CFE2AA80164_4CFCBB3600E0_var*
begin
//#UC START# *4CFE2AA80164_4CFCBB3600E0_impl*
 if not l3Same(anExampleText, QueryExampleLabel.Text) then
 begin
  ContextEdit.CEmptyHintAdding := anExampleText;
  QueryExampleLabel.Text := l3WideString(anExampleText);
  QueryExampleLabel.Hint := QueryExampleLabel.Text;
  QueryExampleLabel.ShowHint := True;
  UpdateExamplePanelWidthAndPosition;
 end;//not l3Same(anExampleText, QueryExampleLabel.Text)
//#UC END# *4CFE2AA80164_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.DoExampleChanged

procedure TNewBaseSearchForDFMForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4CFCBB3600E0_var*
//#UC END# *479731C50290_4CFCBB3600E0_var*
begin
//#UC START# *479731C50290_4CFCBB3600E0_impl*
 MoreTab.OnChange := nil;
 Layout1.OnRealign := nil;
 ContextEdit.OnEmptyAddingClick := nil;
 ContextEdit.OnFocusChanged := nil;
 FreeAndNil(f_Themes);
 inherited;
//#UC END# *479731C50290_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.Cleanup

procedure TNewBaseSearchForDFMForm.BeforeRelease;
//#UC START# *49BFC98902FF_4CFCBB3600E0_var*
//#UC END# *49BFC98902FF_4CFCBB3600E0_var*
begin
//#UC START# *49BFC98902FF_4CFCBB3600E0_impl*
 inherited;
 ContextEdit.ExtButton := nil;
//#UC END# *49BFC98902FF_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.BeforeRelease

{$If NOT Defined(NoVCM)}
procedure TNewBaseSearchForDFMForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4CFCBB3600E0_var*
//#UC END# *4A8E8F2E0195_4CFCBB3600E0_var*
begin
//#UC START# *4A8E8F2E0195_4CFCBB3600E0_impl*
 inherited;
 Self.OnResize := DoResize;
 with ContextEdit do
 begin
  Button.Visible := False;
  ExtButton := DropButton;
 end;//with ContextEdit
 QueryExampleLabel.DrawWithEllipsis := True;
 AreaCombo.ItemHeight := 25; 
 AreaCombo.ListBox.Resource := 'docSetComboListStyle';
 AreaCombo.ListBox.ShowScrollBars := False;
 vgScene1.TabStop := True;
 vgScene1.ActivateWindowOnClick := True;

 ActiveControl := ContextEdit;
 vgScene1.Focused := ContextEditPanel;
 with ContextEdit do
 begin
  PromptColor := clBlack;
  PromptStyle := [];
  PromptBackColor := $EBFDFE;
  PromptViewOptions := {PromptViewOptions + }
   [voShowOpenChip, voShowItemEdgeLine, voShowInterRowSpace, voShowSelectAsArrow];
 end;//with ContextEdit
 MoreTab.OnChange := MoreTabChange;
 Layout1.OnRealign := DoRealignLayout1;
 DropButton.CanFocused := False;
 QueryExampleLabel.CanFocused := True;
 Border.Visible := False;
 InnerBorder.Visible := False;
 Border.HitTest := False;
 InnerBorder.HitTest := False;
 ContextEdit.OnEmptyAddingClick := Self.DoEmptyAddingClick;
 ContextEdit.OnFocusChanged := ContextEditFocusChanged;
//#UC END# *4A8E8F2E0195_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

procedure TNewBaseSearchForDFMForm.ApplyCurrentExample;
//#UC START# *4B13B419036C_4CFCBB3600E0_var*
//#UC END# *4B13B419036C_4CFCBB3600E0_var*
begin
//#UC START# *4B13B419036C_4CFCBB3600E0_impl*
 inherited;
 if ContextEdit.Focused then
  //if QueryExampleLabel.Visible then
   ContextEditPanel.SetFocus;
//#UC END# *4B13B419036C_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.ApplyCurrentExample

{$If NOT Defined(NoVCM)}
function TNewBaseSearchForDFMForm.NeedSetMyFocus: Boolean;
//#UC START# *4B4F13E80365_4CFCBB3600E0_var*
//#UC END# *4B4F13E80365_4CFCBB3600E0_var*
begin
//#UC START# *4B4F13E80365_4CFCBB3600E0_impl*
 if Assigned(f_BaseSearcher) and (f_BaseSearcher.WindowData.ContextKind = ns_bskMenu) then
  Result := True
 else
  Result := inherited NeedSetMyFocus;
//#UC END# *4B4F13E80365_4CFCBB3600E0_impl*
end;//TNewBaseSearchForDFMForm.NeedSetMyFocus
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_asEverywhere.Init;
 {* Инициализация str_asEverywhere }
 str_asListDocuments.Init;
 {* Инициализация str_asListDocuments }
 str_asListNames.Init;
 {* Инициализация str_asListNames }
 str_asDocument.Init;
 {* Инициализация str_asDocument }
 str_etExample.Init;
 {* Инициализация str_etExample }
 str_etFoundCount.Init;
 {* Инициализация str_etFoundCount }
 str_mtcMore.Init;
 {* Инициализация str_mtcMore }
 str_ClassNotInBase.Init;
 {* Инициализация str_ClassNotInBase }
 str_FoundFragmentCountHint.Init;
 {* Инициализация str_FoundFragmentCountHint }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNewBaseSearchForDFMForm);
 {* Регистрация NewBaseSearchForDFM }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
