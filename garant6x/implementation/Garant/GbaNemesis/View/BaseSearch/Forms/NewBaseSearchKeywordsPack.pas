unit NewBaseSearchKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� NewBaseSearch }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\NewBaseSearchKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "NewBaseSearchKeywordsPack" MUID: (4CF4BE9C035F_Pack)

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
 , NewBaseSearch_Form
 , tfwPropertyLike
 {$If NOT Defined(NoVGScene)}
 , vg_controls
 {$IfEnd} // NOT Defined(NoVGScene)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
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
 {$If Defined(Nemesis)}
 , nscTreeComboWithHistoryAndOperations
 {$IfEnd} // Defined(Nemesis)
 , ExtCtrls
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4CF4BE9C035F_Packimpl_uses*
 //#UC END# *4CF4BE9C035F_Packimpl_uses*
;

type
 TkwNewBaseSearchFormFindBtn = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.FindBtn }
  private
   function FindBtn(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
    {* ���������� ����� ������� .TNewBaseSearchForm.FindBtn }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormFindBtn

 TkwNewBaseSearchFormFindBackBtn = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.FindBackBtn }
  private
   function FindBackBtn(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
    {* ���������� ����� ������� .TNewBaseSearchForm.FindBackBtn }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormFindBackBtn

 TkwNewBaseSearchFormCloseBtn = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.CloseBtn }
  private
   function CloseBtn(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgCloseButton;
    {* ���������� ����� ������� .TNewBaseSearchForm.CloseBtn }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormCloseBtn

 TkwNewBaseSearchFormAreaCombo = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.AreaCombo }
  private
   function AreaCombo(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
    {* ���������� ����� ������� .TNewBaseSearchForm.AreaCombo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormAreaCombo

 TkwNewBaseSearchFormQueryExampleLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.QueryExampleLabel }
  private
   function QueryExampleLabel(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
    {* ���������� ����� ������� .TNewBaseSearchForm.QueryExampleLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormQueryExampleLabel

 TkwNewBaseSearchFormDropButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.DropButton }
  private
   function DropButton(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgButton;
    {* ���������� ����� ������� .TNewBaseSearchForm.DropButton }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormDropButton

 TkwNewBaseSearchFormFoundCountLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.FoundCountLabel }
  private
   function FoundCountLabel(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
    {* ���������� ����� ������� .TNewBaseSearchForm.FoundCountLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormFoundCountLabel

 TkwNewBaseSearchFormExampleLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.ExampleLabel }
  private
   function ExampleLabel(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
    {* ���������� ����� ������� .TNewBaseSearchForm.ExampleLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormExampleLabel

 TkwNewBaseSearchFormContextEditPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.ContextEditPanel }
  private
   function ContextEditPanel(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgNonVGLayout;
    {* ���������� ����� ������� .TNewBaseSearchForm.ContextEditPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormContextEditPanel

 TkwNewBaseSearchFormLayout1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.Layout1 }
  private
   function Layout1(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
    {* ���������� ����� ������� .TNewBaseSearchForm.Layout1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormLayout1

 TkwNewBaseSearchFormLayout2 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.Layout2 }
  private
   function Layout2(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
    {* ���������� ����� ������� .TNewBaseSearchForm.Layout2 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormLayout2

 TkwNewBaseSearchFormLayout3 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.Layout3 }
  private
   function Layout3(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
    {* ���������� ����� ������� .TNewBaseSearchForm.Layout3 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormLayout3

 TkwNewBaseSearchFormVgScene1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.vgScene1 }
  private
   function vgScene1(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgScene;
    {* ���������� ����� ������� .TNewBaseSearchForm.vgScene1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormVgScene1

 TkwNewBaseSearchFormMoreTab = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.MoreTab }
  private
   function MoreTab(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
    {* ���������� ����� ������� .TNewBaseSearchForm.MoreTab }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormMoreTab

 TkwNewBaseSearchFormBorder = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.Border }
  private
   function Border(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
    {* ���������� ����� ������� .TNewBaseSearchForm.Border }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormBorder

 TkwNewBaseSearchFormInnerBorder = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.InnerBorder }
  private
   function InnerBorder(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
    {* ���������� ����� ������� .TNewBaseSearchForm.InnerBorder }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormInnerBorder

 TkwNewBaseSearchFormMostOuterRectangle = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.MostOuterRectangle }
  private
   function MostOuterRectangle(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
    {* ���������� ����� ������� .TNewBaseSearchForm.MostOuterRectangle }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormMostOuterRectangle

 TkwNewBaseSearchFormRectangle1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.Rectangle1 }
  private
   function Rectangle1(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
    {* ���������� ����� ������� .TNewBaseSearchForm.Rectangle1 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormRectangle1

 TkwNewBaseSearchFormContextEdit = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.ContextEdit }
  private
   function ContextEdit(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TnscTreeComboWithHistoryAndOperations;
    {* ���������� ����� ������� .TNewBaseSearchForm.ContextEdit }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormContextEdit

 TkwNewBaseSearchFormFlashTimer = {final} class(TtfwPropertyLike)
  {* ����� ������� .TNewBaseSearchForm.FlashTimer }
  private
   function FlashTimer(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TTimer;
    {* ���������� ����� ������� .TNewBaseSearchForm.FlashTimer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNewBaseSearchFormFlashTimer

 Tkw_Form_NewBaseSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� NewBaseSearch
----
*������ �������������*:
[code]�����::NewBaseSearch TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_NewBaseSearch

 Tkw_NewBaseSearch_Control_FindBtn = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FindBtn
----
*������ �������������*:
[code]�������::FindBtn TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FindBtn

 Tkw_NewBaseSearch_Control_FindBtn_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FindBtn
----
*������ �������������*:
[code]�������::FindBtn:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FindBtn_Push

 Tkw_NewBaseSearch_Control_FindBackBtn = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FindBackBtn
----
*������ �������������*:
[code]�������::FindBackBtn TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FindBackBtn

 Tkw_NewBaseSearch_Control_FindBackBtn_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FindBackBtn
----
*������ �������������*:
[code]�������::FindBackBtn:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FindBackBtn_Push

 Tkw_NewBaseSearch_Control_CloseBtn = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� CloseBtn
----
*������ �������������*:
[code]�������::CloseBtn TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_CloseBtn

 Tkw_NewBaseSearch_Control_CloseBtn_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� CloseBtn
----
*������ �������������*:
[code]�������::CloseBtn:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_CloseBtn_Push

 Tkw_NewBaseSearch_Control_AreaCombo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� AreaCombo
----
*������ �������������*:
[code]�������::AreaCombo TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_AreaCombo

 Tkw_NewBaseSearch_Control_AreaCombo_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� AreaCombo
----
*������ �������������*:
[code]�������::AreaCombo:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_AreaCombo_Push

 Tkw_NewBaseSearch_Control_QueryExampleLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� QueryExampleLabel
----
*������ �������������*:
[code]�������::QueryExampleLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_QueryExampleLabel

 Tkw_NewBaseSearch_Control_QueryExampleLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� QueryExampleLabel
----
*������ �������������*:
[code]�������::QueryExampleLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_QueryExampleLabel_Push

 Tkw_NewBaseSearch_Control_DropButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� DropButton
----
*������ �������������*:
[code]�������::DropButton TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_DropButton

 Tkw_NewBaseSearch_Control_DropButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� DropButton
----
*������ �������������*:
[code]�������::DropButton:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_DropButton_Push

 Tkw_NewBaseSearch_Control_FoundCountLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FoundCountLabel
----
*������ �������������*:
[code]�������::FoundCountLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FoundCountLabel

 Tkw_NewBaseSearch_Control_FoundCountLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� FoundCountLabel
----
*������ �������������*:
[code]�������::FoundCountLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FoundCountLabel_Push

 Tkw_NewBaseSearch_Control_ExampleLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ExampleLabel
----
*������ �������������*:
[code]�������::ExampleLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ExampleLabel

 Tkw_NewBaseSearch_Control_ExampleLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ExampleLabel
----
*������ �������������*:
[code]�������::ExampleLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ExampleLabel_Push

 Tkw_NewBaseSearch_Control_ContextEditPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextEditPanel
----
*������ �������������*:
[code]�������::ContextEditPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ContextEditPanel

 Tkw_NewBaseSearch_Control_ContextEditPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ContextEditPanel
----
*������ �������������*:
[code]�������::ContextEditPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ContextEditPanel_Push

 Tkw_NewBaseSearch_Control_Layout1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Layout1
----
*������ �������������*:
[code]�������::Layout1 TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout1

 Tkw_NewBaseSearch_Control_Layout1_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Layout1
----
*������ �������������*:
[code]�������::Layout1:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout1_Push

 Tkw_NewBaseSearch_Control_Layout2 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Layout2
----
*������ �������������*:
[code]�������::Layout2 TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout2

 Tkw_NewBaseSearch_Control_Layout2_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Layout2
----
*������ �������������*:
[code]�������::Layout2:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout2_Push

 Tkw_NewBaseSearch_Control_Layout3 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Layout3
----
*������ �������������*:
[code]�������::Layout3 TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout3

 Tkw_NewBaseSearch_Control_Layout3_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Layout3
----
*������ �������������*:
[code]�������::Layout3:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout3_Push

 Tkw_NewBaseSearch_Control_vgScene1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� vgScene1
----
*������ �������������*:
[code]�������::vgScene1 TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_vgScene1

 Tkw_NewBaseSearch_Control_vgScene1_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� vgScene1
----
*������ �������������*:
[code]�������::vgScene1:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_vgScene1_Push

 Tkw_NewBaseSearch_Control_MoreTab = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� MoreTab
----
*������ �������������*:
[code]�������::MoreTab TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_MoreTab

 Tkw_NewBaseSearch_Control_MoreTab_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MoreTab
----
*������ �������������*:
[code]�������::MoreTab:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_MoreTab_Push

 Tkw_NewBaseSearch_Control_Border = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Border
----
*������ �������������*:
[code]�������::Border TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Border

 Tkw_NewBaseSearch_Control_Border_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Border
----
*������ �������������*:
[code]�������::Border:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Border_Push

 Tkw_NewBaseSearch_Control_InnerBorder = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� InnerBorder
----
*������ �������������*:
[code]�������::InnerBorder TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_InnerBorder

 Tkw_NewBaseSearch_Control_InnerBorder_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� InnerBorder
----
*������ �������������*:
[code]�������::InnerBorder:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_InnerBorder_Push

 Tkw_NewBaseSearch_Control_MostOuterRectangle = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� MostOuterRectangle
----
*������ �������������*:
[code]�������::MostOuterRectangle TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_MostOuterRectangle

 Tkw_NewBaseSearch_Control_MostOuterRectangle_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MostOuterRectangle
----
*������ �������������*:
[code]�������::MostOuterRectangle:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_MostOuterRectangle_Push

 Tkw_NewBaseSearch_Control_Rectangle1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Rectangle1
----
*������ �������������*:
[code]�������::Rectangle1 TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Rectangle1

 Tkw_NewBaseSearch_Control_Rectangle1_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Rectangle1
----
*������ �������������*:
[code]�������::Rectangle1:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Rectangle1_Push

 Tkw_NewBaseSearch_Control_ContextEdit = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextEdit
----
*������ �������������*:
[code]�������::ContextEdit TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ContextEdit

 Tkw_NewBaseSearch_Control_ContextEdit_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ContextEdit
----
*������ �������������*:
[code]�������::ContextEdit:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ContextEdit_Push

 Tkw_NewBaseSearch_Component_FlashTimer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� FlashTimer
----
*������ �������������*:
[code]���������::FlashTimer TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Component_FlashTimer

function TkwNewBaseSearchFormFindBtn.FindBtn(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
 {* ���������� ����� ������� .TNewBaseSearchForm.FindBtn }
begin
 Result := aNewBaseSearchForm.FindBtn;
end;//TkwNewBaseSearchFormFindBtn.FindBtn

class function TkwNewBaseSearchFormFindBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FindBtn';
end;//TkwNewBaseSearchFormFindBtn.GetWordNameForRegister

function TkwNewBaseSearchFormFindBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgPathButton);
end;//TkwNewBaseSearchFormFindBtn.GetResultTypeInfo

function TkwNewBaseSearchFormFindBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormFindBtn.GetAllParamsCount

function TkwNewBaseSearchFormFindBtn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormFindBtn.ParamsTypes

procedure TkwNewBaseSearchFormFindBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FindBtn', aCtx);
end;//TkwNewBaseSearchFormFindBtn.SetValuePrim

procedure TkwNewBaseSearchFormFindBtn.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindBtn(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormFindBtn.DoDoIt

function TkwNewBaseSearchFormFindBackBtn.FindBackBtn(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
 {* ���������� ����� ������� .TNewBaseSearchForm.FindBackBtn }
begin
 Result := aNewBaseSearchForm.FindBackBtn;
end;//TkwNewBaseSearchFormFindBackBtn.FindBackBtn

class function TkwNewBaseSearchFormFindBackBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FindBackBtn';
end;//TkwNewBaseSearchFormFindBackBtn.GetWordNameForRegister

function TkwNewBaseSearchFormFindBackBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgPathButton);
end;//TkwNewBaseSearchFormFindBackBtn.GetResultTypeInfo

function TkwNewBaseSearchFormFindBackBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormFindBackBtn.GetAllParamsCount

function TkwNewBaseSearchFormFindBackBtn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormFindBackBtn.ParamsTypes

procedure TkwNewBaseSearchFormFindBackBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FindBackBtn', aCtx);
end;//TkwNewBaseSearchFormFindBackBtn.SetValuePrim

procedure TkwNewBaseSearchFormFindBackBtn.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindBackBtn(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormFindBackBtn.DoDoIt

function TkwNewBaseSearchFormCloseBtn.CloseBtn(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgCloseButton;
 {* ���������� ����� ������� .TNewBaseSearchForm.CloseBtn }
begin
 Result := aNewBaseSearchForm.CloseBtn;
end;//TkwNewBaseSearchFormCloseBtn.CloseBtn

class function TkwNewBaseSearchFormCloseBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.CloseBtn';
end;//TkwNewBaseSearchFormCloseBtn.GetWordNameForRegister

function TkwNewBaseSearchFormCloseBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgCloseButton);
end;//TkwNewBaseSearchFormCloseBtn.GetResultTypeInfo

function TkwNewBaseSearchFormCloseBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormCloseBtn.GetAllParamsCount

function TkwNewBaseSearchFormCloseBtn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormCloseBtn.ParamsTypes

procedure TkwNewBaseSearchFormCloseBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� CloseBtn', aCtx);
end;//TkwNewBaseSearchFormCloseBtn.SetValuePrim

procedure TkwNewBaseSearchFormCloseBtn.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CloseBtn(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormCloseBtn.DoDoIt

function TkwNewBaseSearchFormAreaCombo.AreaCombo(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
 {* ���������� ����� ������� .TNewBaseSearchForm.AreaCombo }
begin
 Result := aNewBaseSearchForm.AreaCombo;
end;//TkwNewBaseSearchFormAreaCombo.AreaCombo

class function TkwNewBaseSearchFormAreaCombo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.AreaCombo';
end;//TkwNewBaseSearchFormAreaCombo.GetWordNameForRegister

function TkwNewBaseSearchFormAreaCombo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgComboBox);
end;//TkwNewBaseSearchFormAreaCombo.GetResultTypeInfo

function TkwNewBaseSearchFormAreaCombo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormAreaCombo.GetAllParamsCount

function TkwNewBaseSearchFormAreaCombo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormAreaCombo.ParamsTypes

procedure TkwNewBaseSearchFormAreaCombo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� AreaCombo', aCtx);
end;//TkwNewBaseSearchFormAreaCombo.SetValuePrim

procedure TkwNewBaseSearchFormAreaCombo.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(AreaCombo(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormAreaCombo.DoDoIt

function TkwNewBaseSearchFormQueryExampleLabel.QueryExampleLabel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
 {* ���������� ����� ������� .TNewBaseSearchForm.QueryExampleLabel }
begin
 Result := aNewBaseSearchForm.QueryExampleLabel;
end;//TkwNewBaseSearchFormQueryExampleLabel.QueryExampleLabel

class function TkwNewBaseSearchFormQueryExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.QueryExampleLabel';
end;//TkwNewBaseSearchFormQueryExampleLabel.GetWordNameForRegister

function TkwNewBaseSearchFormQueryExampleLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgText);
end;//TkwNewBaseSearchFormQueryExampleLabel.GetResultTypeInfo

function TkwNewBaseSearchFormQueryExampleLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormQueryExampleLabel.GetAllParamsCount

function TkwNewBaseSearchFormQueryExampleLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormQueryExampleLabel.ParamsTypes

procedure TkwNewBaseSearchFormQueryExampleLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� QueryExampleLabel', aCtx);
end;//TkwNewBaseSearchFormQueryExampleLabel.SetValuePrim

procedure TkwNewBaseSearchFormQueryExampleLabel.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(QueryExampleLabel(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormQueryExampleLabel.DoDoIt

function TkwNewBaseSearchFormDropButton.DropButton(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgButton;
 {* ���������� ����� ������� .TNewBaseSearchForm.DropButton }
begin
 Result := aNewBaseSearchForm.DropButton;
end;//TkwNewBaseSearchFormDropButton.DropButton

class function TkwNewBaseSearchFormDropButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.DropButton';
end;//TkwNewBaseSearchFormDropButton.GetWordNameForRegister

function TkwNewBaseSearchFormDropButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgButton);
end;//TkwNewBaseSearchFormDropButton.GetResultTypeInfo

function TkwNewBaseSearchFormDropButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormDropButton.GetAllParamsCount

function TkwNewBaseSearchFormDropButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormDropButton.ParamsTypes

procedure TkwNewBaseSearchFormDropButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� DropButton', aCtx);
end;//TkwNewBaseSearchFormDropButton.SetValuePrim

procedure TkwNewBaseSearchFormDropButton.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DropButton(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormDropButton.DoDoIt

function TkwNewBaseSearchFormFoundCountLabel.FoundCountLabel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
 {* ���������� ����� ������� .TNewBaseSearchForm.FoundCountLabel }
begin
 Result := aNewBaseSearchForm.FoundCountLabel;
end;//TkwNewBaseSearchFormFoundCountLabel.FoundCountLabel

class function TkwNewBaseSearchFormFoundCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FoundCountLabel';
end;//TkwNewBaseSearchFormFoundCountLabel.GetWordNameForRegister

function TkwNewBaseSearchFormFoundCountLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgText);
end;//TkwNewBaseSearchFormFoundCountLabel.GetResultTypeInfo

function TkwNewBaseSearchFormFoundCountLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormFoundCountLabel.GetAllParamsCount

function TkwNewBaseSearchFormFoundCountLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormFoundCountLabel.ParamsTypes

procedure TkwNewBaseSearchFormFoundCountLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FoundCountLabel', aCtx);
end;//TkwNewBaseSearchFormFoundCountLabel.SetValuePrim

procedure TkwNewBaseSearchFormFoundCountLabel.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FoundCountLabel(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormFoundCountLabel.DoDoIt

function TkwNewBaseSearchFormExampleLabel.ExampleLabel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
 {* ���������� ����� ������� .TNewBaseSearchForm.ExampleLabel }
begin
 Result := aNewBaseSearchForm.ExampleLabel;
end;//TkwNewBaseSearchFormExampleLabel.ExampleLabel

class function TkwNewBaseSearchFormExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.ExampleLabel';
end;//TkwNewBaseSearchFormExampleLabel.GetWordNameForRegister

function TkwNewBaseSearchFormExampleLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgText);
end;//TkwNewBaseSearchFormExampleLabel.GetResultTypeInfo

function TkwNewBaseSearchFormExampleLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormExampleLabel.GetAllParamsCount

function TkwNewBaseSearchFormExampleLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormExampleLabel.ParamsTypes

procedure TkwNewBaseSearchFormExampleLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ExampleLabel', aCtx);
end;//TkwNewBaseSearchFormExampleLabel.SetValuePrim

procedure TkwNewBaseSearchFormExampleLabel.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ExampleLabel(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormExampleLabel.DoDoIt

function TkwNewBaseSearchFormContextEditPanel.ContextEditPanel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgNonVGLayout;
 {* ���������� ����� ������� .TNewBaseSearchForm.ContextEditPanel }
begin
 Result := aNewBaseSearchForm.ContextEditPanel;
end;//TkwNewBaseSearchFormContextEditPanel.ContextEditPanel

class function TkwNewBaseSearchFormContextEditPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.ContextEditPanel';
end;//TkwNewBaseSearchFormContextEditPanel.GetWordNameForRegister

function TkwNewBaseSearchFormContextEditPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgNonVGLayout);
end;//TkwNewBaseSearchFormContextEditPanel.GetResultTypeInfo

function TkwNewBaseSearchFormContextEditPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormContextEditPanel.GetAllParamsCount

function TkwNewBaseSearchFormContextEditPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormContextEditPanel.ParamsTypes

procedure TkwNewBaseSearchFormContextEditPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContextEditPanel', aCtx);
end;//TkwNewBaseSearchFormContextEditPanel.SetValuePrim

procedure TkwNewBaseSearchFormContextEditPanel.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextEditPanel(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormContextEditPanel.DoDoIt

function TkwNewBaseSearchFormLayout1.Layout1(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
 {* ���������� ����� ������� .TNewBaseSearchForm.Layout1 }
begin
 Result := aNewBaseSearchForm.Layout1;
end;//TkwNewBaseSearchFormLayout1.Layout1

class function TkwNewBaseSearchFormLayout1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Layout1';
end;//TkwNewBaseSearchFormLayout1.GetWordNameForRegister

function TkwNewBaseSearchFormLayout1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgLayout);
end;//TkwNewBaseSearchFormLayout1.GetResultTypeInfo

function TkwNewBaseSearchFormLayout1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormLayout1.GetAllParamsCount

function TkwNewBaseSearchFormLayout1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormLayout1.ParamsTypes

procedure TkwNewBaseSearchFormLayout1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Layout1', aCtx);
end;//TkwNewBaseSearchFormLayout1.SetValuePrim

procedure TkwNewBaseSearchFormLayout1.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Layout1(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormLayout1.DoDoIt

function TkwNewBaseSearchFormLayout2.Layout2(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
 {* ���������� ����� ������� .TNewBaseSearchForm.Layout2 }
begin
 Result := aNewBaseSearchForm.Layout2;
end;//TkwNewBaseSearchFormLayout2.Layout2

class function TkwNewBaseSearchFormLayout2.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Layout2';
end;//TkwNewBaseSearchFormLayout2.GetWordNameForRegister

function TkwNewBaseSearchFormLayout2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgLayout);
end;//TkwNewBaseSearchFormLayout2.GetResultTypeInfo

function TkwNewBaseSearchFormLayout2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormLayout2.GetAllParamsCount

function TkwNewBaseSearchFormLayout2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormLayout2.ParamsTypes

procedure TkwNewBaseSearchFormLayout2.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Layout2', aCtx);
end;//TkwNewBaseSearchFormLayout2.SetValuePrim

procedure TkwNewBaseSearchFormLayout2.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Layout2(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormLayout2.DoDoIt

function TkwNewBaseSearchFormLayout3.Layout3(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
 {* ���������� ����� ������� .TNewBaseSearchForm.Layout3 }
begin
 Result := aNewBaseSearchForm.Layout3;
end;//TkwNewBaseSearchFormLayout3.Layout3

class function TkwNewBaseSearchFormLayout3.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Layout3';
end;//TkwNewBaseSearchFormLayout3.GetWordNameForRegister

function TkwNewBaseSearchFormLayout3.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgLayout);
end;//TkwNewBaseSearchFormLayout3.GetResultTypeInfo

function TkwNewBaseSearchFormLayout3.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormLayout3.GetAllParamsCount

function TkwNewBaseSearchFormLayout3.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormLayout3.ParamsTypes

procedure TkwNewBaseSearchFormLayout3.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Layout3', aCtx);
end;//TkwNewBaseSearchFormLayout3.SetValuePrim

procedure TkwNewBaseSearchFormLayout3.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Layout3(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormLayout3.DoDoIt

function TkwNewBaseSearchFormVgScene1.vgScene1(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgScene;
 {* ���������� ����� ������� .TNewBaseSearchForm.vgScene1 }
begin
 Result := aNewBaseSearchForm.vgScene1;
end;//TkwNewBaseSearchFormVgScene1.vgScene1

class function TkwNewBaseSearchFormVgScene1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.vgScene1';
end;//TkwNewBaseSearchFormVgScene1.GetWordNameForRegister

function TkwNewBaseSearchFormVgScene1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgScene);
end;//TkwNewBaseSearchFormVgScene1.GetResultTypeInfo

function TkwNewBaseSearchFormVgScene1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormVgScene1.GetAllParamsCount

function TkwNewBaseSearchFormVgScene1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormVgScene1.ParamsTypes

procedure TkwNewBaseSearchFormVgScene1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� vgScene1', aCtx);
end;//TkwNewBaseSearchFormVgScene1.SetValuePrim

procedure TkwNewBaseSearchFormVgScene1.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vgScene1(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormVgScene1.DoDoIt

function TkwNewBaseSearchFormMoreTab.MoreTab(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
 {* ���������� ����� ������� .TNewBaseSearchForm.MoreTab }
begin
 Result := aNewBaseSearchForm.MoreTab;
end;//TkwNewBaseSearchFormMoreTab.MoreTab

class function TkwNewBaseSearchFormMoreTab.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.MoreTab';
end;//TkwNewBaseSearchFormMoreTab.GetWordNameForRegister

function TkwNewBaseSearchFormMoreTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgComboBox);
end;//TkwNewBaseSearchFormMoreTab.GetResultTypeInfo

function TkwNewBaseSearchFormMoreTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormMoreTab.GetAllParamsCount

function TkwNewBaseSearchFormMoreTab.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormMoreTab.ParamsTypes

procedure TkwNewBaseSearchFormMoreTab.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� MoreTab', aCtx);
end;//TkwNewBaseSearchFormMoreTab.SetValuePrim

procedure TkwNewBaseSearchFormMoreTab.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MoreTab(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormMoreTab.DoDoIt

function TkwNewBaseSearchFormBorder.Border(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* ���������� ����� ������� .TNewBaseSearchForm.Border }
begin
 Result := aNewBaseSearchForm.Border;
end;//TkwNewBaseSearchFormBorder.Border

class function TkwNewBaseSearchFormBorder.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Border';
end;//TkwNewBaseSearchFormBorder.GetWordNameForRegister

function TkwNewBaseSearchFormBorder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgRectangle);
end;//TkwNewBaseSearchFormBorder.GetResultTypeInfo

function TkwNewBaseSearchFormBorder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormBorder.GetAllParamsCount

function TkwNewBaseSearchFormBorder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormBorder.ParamsTypes

procedure TkwNewBaseSearchFormBorder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Border', aCtx);
end;//TkwNewBaseSearchFormBorder.SetValuePrim

procedure TkwNewBaseSearchFormBorder.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Border(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormBorder.DoDoIt

function TkwNewBaseSearchFormInnerBorder.InnerBorder(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* ���������� ����� ������� .TNewBaseSearchForm.InnerBorder }
begin
 Result := aNewBaseSearchForm.InnerBorder;
end;//TkwNewBaseSearchFormInnerBorder.InnerBorder

class function TkwNewBaseSearchFormInnerBorder.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.InnerBorder';
end;//TkwNewBaseSearchFormInnerBorder.GetWordNameForRegister

function TkwNewBaseSearchFormInnerBorder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgRectangle);
end;//TkwNewBaseSearchFormInnerBorder.GetResultTypeInfo

function TkwNewBaseSearchFormInnerBorder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormInnerBorder.GetAllParamsCount

function TkwNewBaseSearchFormInnerBorder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormInnerBorder.ParamsTypes

procedure TkwNewBaseSearchFormInnerBorder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� InnerBorder', aCtx);
end;//TkwNewBaseSearchFormInnerBorder.SetValuePrim

procedure TkwNewBaseSearchFormInnerBorder.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InnerBorder(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormInnerBorder.DoDoIt

function TkwNewBaseSearchFormMostOuterRectangle.MostOuterRectangle(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* ���������� ����� ������� .TNewBaseSearchForm.MostOuterRectangle }
begin
 Result := aNewBaseSearchForm.MostOuterRectangle;
end;//TkwNewBaseSearchFormMostOuterRectangle.MostOuterRectangle

class function TkwNewBaseSearchFormMostOuterRectangle.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.MostOuterRectangle';
end;//TkwNewBaseSearchFormMostOuterRectangle.GetWordNameForRegister

function TkwNewBaseSearchFormMostOuterRectangle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgRectangle);
end;//TkwNewBaseSearchFormMostOuterRectangle.GetResultTypeInfo

function TkwNewBaseSearchFormMostOuterRectangle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormMostOuterRectangle.GetAllParamsCount

function TkwNewBaseSearchFormMostOuterRectangle.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormMostOuterRectangle.ParamsTypes

procedure TkwNewBaseSearchFormMostOuterRectangle.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� MostOuterRectangle', aCtx);
end;//TkwNewBaseSearchFormMostOuterRectangle.SetValuePrim

procedure TkwNewBaseSearchFormMostOuterRectangle.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MostOuterRectangle(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormMostOuterRectangle.DoDoIt

function TkwNewBaseSearchFormRectangle1.Rectangle1(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* ���������� ����� ������� .TNewBaseSearchForm.Rectangle1 }
begin
 Result := aNewBaseSearchForm.Rectangle1;
end;//TkwNewBaseSearchFormRectangle1.Rectangle1

class function TkwNewBaseSearchFormRectangle1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Rectangle1';
end;//TkwNewBaseSearchFormRectangle1.GetWordNameForRegister

function TkwNewBaseSearchFormRectangle1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgRectangle);
end;//TkwNewBaseSearchFormRectangle1.GetResultTypeInfo

function TkwNewBaseSearchFormRectangle1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormRectangle1.GetAllParamsCount

function TkwNewBaseSearchFormRectangle1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormRectangle1.ParamsTypes

procedure TkwNewBaseSearchFormRectangle1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Rectangle1', aCtx);
end;//TkwNewBaseSearchFormRectangle1.SetValuePrim

procedure TkwNewBaseSearchFormRectangle1.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Rectangle1(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormRectangle1.DoDoIt

function TkwNewBaseSearchFormContextEdit.ContextEdit(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TnscTreeComboWithHistoryAndOperations;
 {* ���������� ����� ������� .TNewBaseSearchForm.ContextEdit }
begin
 Result := aNewBaseSearchForm.ContextEdit;
end;//TkwNewBaseSearchFormContextEdit.ContextEdit

class function TkwNewBaseSearchFormContextEdit.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.ContextEdit';
end;//TkwNewBaseSearchFormContextEdit.GetWordNameForRegister

function TkwNewBaseSearchFormContextEdit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeComboWithHistoryAndOperations);
end;//TkwNewBaseSearchFormContextEdit.GetResultTypeInfo

function TkwNewBaseSearchFormContextEdit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormContextEdit.GetAllParamsCount

function TkwNewBaseSearchFormContextEdit.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormContextEdit.ParamsTypes

procedure TkwNewBaseSearchFormContextEdit.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContextEdit', aCtx);
end;//TkwNewBaseSearchFormContextEdit.SetValuePrim

procedure TkwNewBaseSearchFormContextEdit.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextEdit(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormContextEdit.DoDoIt

function TkwNewBaseSearchFormFlashTimer.FlashTimer(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TTimer;
 {* ���������� ����� ������� .TNewBaseSearchForm.FlashTimer }
begin
 Result := aNewBaseSearchForm.FlashTimer;
end;//TkwNewBaseSearchFormFlashTimer.FlashTimer

class function TkwNewBaseSearchFormFlashTimer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FlashTimer';
end;//TkwNewBaseSearchFormFlashTimer.GetWordNameForRegister

function TkwNewBaseSearchFormFlashTimer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTimer);
end;//TkwNewBaseSearchFormFlashTimer.GetResultTypeInfo

function TkwNewBaseSearchFormFlashTimer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormFlashTimer.GetAllParamsCount

function TkwNewBaseSearchFormFlashTimer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormFlashTimer.ParamsTypes

procedure TkwNewBaseSearchFormFlashTimer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� FlashTimer', aCtx);
end;//TkwNewBaseSearchFormFlashTimer.SetValuePrim

procedure TkwNewBaseSearchFormFlashTimer.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FlashTimer(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormFlashTimer.DoDoIt

function Tkw_Form_NewBaseSearch.GetString: AnsiString;
begin
 Result := 'NewBaseSearchForm';
end;//Tkw_Form_NewBaseSearch.GetString

class procedure Tkw_Form_NewBaseSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TNewBaseSearchForm);
end;//Tkw_Form_NewBaseSearch.RegisterInEngine

class function Tkw_Form_NewBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::NewBaseSearch';
end;//Tkw_Form_NewBaseSearch.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_FindBtn.GetString: AnsiString;
begin
 Result := 'FindBtn';
end;//Tkw_NewBaseSearch_Control_FindBtn.GetString

class procedure Tkw_NewBaseSearch_Control_FindBtn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgPathButton);
end;//Tkw_NewBaseSearch_Control_FindBtn.RegisterInEngine

class function Tkw_NewBaseSearch_Control_FindBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FindBtn';
end;//Tkw_NewBaseSearch_Control_FindBtn.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_FindBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FindBtn');
 inherited;
end;//Tkw_NewBaseSearch_Control_FindBtn_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_FindBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FindBtn:push';
end;//Tkw_NewBaseSearch_Control_FindBtn_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_FindBackBtn.GetString: AnsiString;
begin
 Result := 'FindBackBtn';
end;//Tkw_NewBaseSearch_Control_FindBackBtn.GetString

class procedure Tkw_NewBaseSearch_Control_FindBackBtn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgPathButton);
end;//Tkw_NewBaseSearch_Control_FindBackBtn.RegisterInEngine

class function Tkw_NewBaseSearch_Control_FindBackBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FindBackBtn';
end;//Tkw_NewBaseSearch_Control_FindBackBtn.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_FindBackBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FindBackBtn');
 inherited;
end;//Tkw_NewBaseSearch_Control_FindBackBtn_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_FindBackBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FindBackBtn:push';
end;//Tkw_NewBaseSearch_Control_FindBackBtn_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_CloseBtn.GetString: AnsiString;
begin
 Result := 'CloseBtn';
end;//Tkw_NewBaseSearch_Control_CloseBtn.GetString

class procedure Tkw_NewBaseSearch_Control_CloseBtn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgCloseButton);
end;//Tkw_NewBaseSearch_Control_CloseBtn.RegisterInEngine

class function Tkw_NewBaseSearch_Control_CloseBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CloseBtn';
end;//Tkw_NewBaseSearch_Control_CloseBtn.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_CloseBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('CloseBtn');
 inherited;
end;//Tkw_NewBaseSearch_Control_CloseBtn_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_CloseBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CloseBtn:push';
end;//Tkw_NewBaseSearch_Control_CloseBtn_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_AreaCombo.GetString: AnsiString;
begin
 Result := 'AreaCombo';
end;//Tkw_NewBaseSearch_Control_AreaCombo.GetString

class procedure Tkw_NewBaseSearch_Control_AreaCombo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgComboBox);
end;//Tkw_NewBaseSearch_Control_AreaCombo.RegisterInEngine

class function Tkw_NewBaseSearch_Control_AreaCombo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AreaCombo';
end;//Tkw_NewBaseSearch_Control_AreaCombo.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_AreaCombo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('AreaCombo');
 inherited;
end;//Tkw_NewBaseSearch_Control_AreaCombo_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_AreaCombo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::AreaCombo:push';
end;//Tkw_NewBaseSearch_Control_AreaCombo_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_QueryExampleLabel.GetString: AnsiString;
begin
 Result := 'QueryExampleLabel';
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel.GetString

class procedure Tkw_NewBaseSearch_Control_QueryExampleLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgText);
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel.RegisterInEngine

class function Tkw_NewBaseSearch_Control_QueryExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::QueryExampleLabel';
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('QueryExampleLabel');
 inherited;
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::QueryExampleLabel:push';
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_DropButton.GetString: AnsiString;
begin
 Result := 'DropButton';
end;//Tkw_NewBaseSearch_Control_DropButton.GetString

class procedure Tkw_NewBaseSearch_Control_DropButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgButton);
end;//Tkw_NewBaseSearch_Control_DropButton.RegisterInEngine

class function Tkw_NewBaseSearch_Control_DropButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DropButton';
end;//Tkw_NewBaseSearch_Control_DropButton.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_DropButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('DropButton');
 inherited;
end;//Tkw_NewBaseSearch_Control_DropButton_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_DropButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DropButton:push';
end;//Tkw_NewBaseSearch_Control_DropButton_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_FoundCountLabel.GetString: AnsiString;
begin
 Result := 'FoundCountLabel';
end;//Tkw_NewBaseSearch_Control_FoundCountLabel.GetString

class procedure Tkw_NewBaseSearch_Control_FoundCountLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgText);
end;//Tkw_NewBaseSearch_Control_FoundCountLabel.RegisterInEngine

class function Tkw_NewBaseSearch_Control_FoundCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FoundCountLabel';
end;//Tkw_NewBaseSearch_Control_FoundCountLabel.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_FoundCountLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FoundCountLabel');
 inherited;
end;//Tkw_NewBaseSearch_Control_FoundCountLabel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_FoundCountLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::FoundCountLabel:push';
end;//Tkw_NewBaseSearch_Control_FoundCountLabel_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_ExampleLabel.GetString: AnsiString;
begin
 Result := 'ExampleLabel';
end;//Tkw_NewBaseSearch_Control_ExampleLabel.GetString

class procedure Tkw_NewBaseSearch_Control_ExampleLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgText);
end;//Tkw_NewBaseSearch_Control_ExampleLabel.RegisterInEngine

class function Tkw_NewBaseSearch_Control_ExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ExampleLabel';
end;//Tkw_NewBaseSearch_Control_ExampleLabel.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_ExampleLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ExampleLabel');
 inherited;
end;//Tkw_NewBaseSearch_Control_ExampleLabel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_ExampleLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ExampleLabel:push';
end;//Tkw_NewBaseSearch_Control_ExampleLabel_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_ContextEditPanel.GetString: AnsiString;
begin
 Result := 'ContextEditPanel';
end;//Tkw_NewBaseSearch_Control_ContextEditPanel.GetString

class procedure Tkw_NewBaseSearch_Control_ContextEditPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgNonVGLayout);
end;//Tkw_NewBaseSearch_Control_ContextEditPanel.RegisterInEngine

class function Tkw_NewBaseSearch_Control_ContextEditPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextEditPanel';
end;//Tkw_NewBaseSearch_Control_ContextEditPanel.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_ContextEditPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextEditPanel');
 inherited;
end;//Tkw_NewBaseSearch_Control_ContextEditPanel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_ContextEditPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextEditPanel:push';
end;//Tkw_NewBaseSearch_Control_ContextEditPanel_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Layout1.GetString: AnsiString;
begin
 Result := 'Layout1';
end;//Tkw_NewBaseSearch_Control_Layout1.GetString

class procedure Tkw_NewBaseSearch_Control_Layout1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgLayout);
end;//Tkw_NewBaseSearch_Control_Layout1.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Layout1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Layout1';
end;//Tkw_NewBaseSearch_Control_Layout1.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Layout1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Layout1');
 inherited;
end;//Tkw_NewBaseSearch_Control_Layout1_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Layout1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Layout1:push';
end;//Tkw_NewBaseSearch_Control_Layout1_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Layout2.GetString: AnsiString;
begin
 Result := 'Layout2';
end;//Tkw_NewBaseSearch_Control_Layout2.GetString

class procedure Tkw_NewBaseSearch_Control_Layout2.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgLayout);
end;//Tkw_NewBaseSearch_Control_Layout2.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Layout2.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Layout2';
end;//Tkw_NewBaseSearch_Control_Layout2.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Layout2_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Layout2');
 inherited;
end;//Tkw_NewBaseSearch_Control_Layout2_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Layout2_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Layout2:push';
end;//Tkw_NewBaseSearch_Control_Layout2_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Layout3.GetString: AnsiString;
begin
 Result := 'Layout3';
end;//Tkw_NewBaseSearch_Control_Layout3.GetString

class procedure Tkw_NewBaseSearch_Control_Layout3.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgLayout);
end;//Tkw_NewBaseSearch_Control_Layout3.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Layout3.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Layout3';
end;//Tkw_NewBaseSearch_Control_Layout3.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Layout3_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Layout3');
 inherited;
end;//Tkw_NewBaseSearch_Control_Layout3_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Layout3_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Layout3:push';
end;//Tkw_NewBaseSearch_Control_Layout3_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_vgScene1.GetString: AnsiString;
begin
 Result := 'vgScene1';
end;//Tkw_NewBaseSearch_Control_vgScene1.GetString

class procedure Tkw_NewBaseSearch_Control_vgScene1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgScene);
end;//Tkw_NewBaseSearch_Control_vgScene1.RegisterInEngine

class function Tkw_NewBaseSearch_Control_vgScene1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vgScene1';
end;//Tkw_NewBaseSearch_Control_vgScene1.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_vgScene1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vgScene1');
 inherited;
end;//Tkw_NewBaseSearch_Control_vgScene1_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_vgScene1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vgScene1:push';
end;//Tkw_NewBaseSearch_Control_vgScene1_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_MoreTab.GetString: AnsiString;
begin
 Result := 'MoreTab';
end;//Tkw_NewBaseSearch_Control_MoreTab.GetString

class procedure Tkw_NewBaseSearch_Control_MoreTab.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgComboBox);
end;//Tkw_NewBaseSearch_Control_MoreTab.RegisterInEngine

class function Tkw_NewBaseSearch_Control_MoreTab.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MoreTab';
end;//Tkw_NewBaseSearch_Control_MoreTab.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_MoreTab_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MoreTab');
 inherited;
end;//Tkw_NewBaseSearch_Control_MoreTab_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_MoreTab_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MoreTab:push';
end;//Tkw_NewBaseSearch_Control_MoreTab_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Border.GetString: AnsiString;
begin
 Result := 'Border';
end;//Tkw_NewBaseSearch_Control_Border.GetString

class procedure Tkw_NewBaseSearch_Control_Border.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgRectangle);
end;//Tkw_NewBaseSearch_Control_Border.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Border.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Border';
end;//Tkw_NewBaseSearch_Control_Border.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Border_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Border');
 inherited;
end;//Tkw_NewBaseSearch_Control_Border_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Border_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Border:push';
end;//Tkw_NewBaseSearch_Control_Border_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_InnerBorder.GetString: AnsiString;
begin
 Result := 'InnerBorder';
end;//Tkw_NewBaseSearch_Control_InnerBorder.GetString

class procedure Tkw_NewBaseSearch_Control_InnerBorder.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgRectangle);
end;//Tkw_NewBaseSearch_Control_InnerBorder.RegisterInEngine

class function Tkw_NewBaseSearch_Control_InnerBorder.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::InnerBorder';
end;//Tkw_NewBaseSearch_Control_InnerBorder.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_InnerBorder_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('InnerBorder');
 inherited;
end;//Tkw_NewBaseSearch_Control_InnerBorder_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_InnerBorder_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::InnerBorder:push';
end;//Tkw_NewBaseSearch_Control_InnerBorder_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_MostOuterRectangle.GetString: AnsiString;
begin
 Result := 'MostOuterRectangle';
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle.GetString

class procedure Tkw_NewBaseSearch_Control_MostOuterRectangle.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgRectangle);
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle.RegisterInEngine

class function Tkw_NewBaseSearch_Control_MostOuterRectangle.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MostOuterRectangle';
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MostOuterRectangle');
 inherited;
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MostOuterRectangle:push';
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Rectangle1.GetString: AnsiString;
begin
 Result := 'Rectangle1';
end;//Tkw_NewBaseSearch_Control_Rectangle1.GetString

class procedure Tkw_NewBaseSearch_Control_Rectangle1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgRectangle);
end;//Tkw_NewBaseSearch_Control_Rectangle1.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Rectangle1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Rectangle1';
end;//Tkw_NewBaseSearch_Control_Rectangle1.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Rectangle1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Rectangle1');
 inherited;
end;//Tkw_NewBaseSearch_Control_Rectangle1_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Rectangle1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Rectangle1:push';
end;//Tkw_NewBaseSearch_Control_Rectangle1_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_ContextEdit.GetString: AnsiString;
begin
 Result := 'ContextEdit';
end;//Tkw_NewBaseSearch_Control_ContextEdit.GetString

class procedure Tkw_NewBaseSearch_Control_ContextEdit.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeComboWithHistoryAndOperations);
end;//Tkw_NewBaseSearch_Control_ContextEdit.RegisterInEngine

class function Tkw_NewBaseSearch_Control_ContextEdit.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextEdit';
end;//Tkw_NewBaseSearch_Control_ContextEdit.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_ContextEdit_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextEdit');
 inherited;
end;//Tkw_NewBaseSearch_Control_ContextEdit_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_ContextEdit_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextEdit:push';
end;//Tkw_NewBaseSearch_Control_ContextEdit_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Component_FlashTimer.GetString: AnsiString;
begin
 Result := 'FlashTimer';
end;//Tkw_NewBaseSearch_Component_FlashTimer.GetString

class procedure Tkw_NewBaseSearch_Component_FlashTimer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TTimer);
end;//Tkw_NewBaseSearch_Component_FlashTimer.RegisterInEngine

class function Tkw_NewBaseSearch_Component_FlashTimer.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::FlashTimer';
end;//Tkw_NewBaseSearch_Component_FlashTimer.GetWordNameForRegister

initialization
 TkwNewBaseSearchFormFindBtn.RegisterInEngine;
 {* ����������� NewBaseSearchForm_FindBtn }
 TkwNewBaseSearchFormFindBackBtn.RegisterInEngine;
 {* ����������� NewBaseSearchForm_FindBackBtn }
 TkwNewBaseSearchFormCloseBtn.RegisterInEngine;
 {* ����������� NewBaseSearchForm_CloseBtn }
 TkwNewBaseSearchFormAreaCombo.RegisterInEngine;
 {* ����������� NewBaseSearchForm_AreaCombo }
 TkwNewBaseSearchFormQueryExampleLabel.RegisterInEngine;
 {* ����������� NewBaseSearchForm_QueryExampleLabel }
 TkwNewBaseSearchFormDropButton.RegisterInEngine;
 {* ����������� NewBaseSearchForm_DropButton }
 TkwNewBaseSearchFormFoundCountLabel.RegisterInEngine;
 {* ����������� NewBaseSearchForm_FoundCountLabel }
 TkwNewBaseSearchFormExampleLabel.RegisterInEngine;
 {* ����������� NewBaseSearchForm_ExampleLabel }
 TkwNewBaseSearchFormContextEditPanel.RegisterInEngine;
 {* ����������� NewBaseSearchForm_ContextEditPanel }
 TkwNewBaseSearchFormLayout1.RegisterInEngine;
 {* ����������� NewBaseSearchForm_Layout1 }
 TkwNewBaseSearchFormLayout2.RegisterInEngine;
 {* ����������� NewBaseSearchForm_Layout2 }
 TkwNewBaseSearchFormLayout3.RegisterInEngine;
 {* ����������� NewBaseSearchForm_Layout3 }
 TkwNewBaseSearchFormVgScene1.RegisterInEngine;
 {* ����������� NewBaseSearchForm_vgScene1 }
 TkwNewBaseSearchFormMoreTab.RegisterInEngine;
 {* ����������� NewBaseSearchForm_MoreTab }
 TkwNewBaseSearchFormBorder.RegisterInEngine;
 {* ����������� NewBaseSearchForm_Border }
 TkwNewBaseSearchFormInnerBorder.RegisterInEngine;
 {* ����������� NewBaseSearchForm_InnerBorder }
 TkwNewBaseSearchFormMostOuterRectangle.RegisterInEngine;
 {* ����������� NewBaseSearchForm_MostOuterRectangle }
 TkwNewBaseSearchFormRectangle1.RegisterInEngine;
 {* ����������� NewBaseSearchForm_Rectangle1 }
 TkwNewBaseSearchFormContextEdit.RegisterInEngine;
 {* ����������� NewBaseSearchForm_ContextEdit }
 TkwNewBaseSearchFormFlashTimer.RegisterInEngine;
 {* ����������� NewBaseSearchForm_FlashTimer }
 Tkw_Form_NewBaseSearch.RegisterInEngine;
 {* ����������� Tkw_Form_NewBaseSearch }
 Tkw_NewBaseSearch_Control_FindBtn.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_FindBtn }
 Tkw_NewBaseSearch_Control_FindBtn_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_FindBtn_Push }
 Tkw_NewBaseSearch_Control_FindBackBtn.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_FindBackBtn }
 Tkw_NewBaseSearch_Control_FindBackBtn_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_FindBackBtn_Push }
 Tkw_NewBaseSearch_Control_CloseBtn.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_CloseBtn }
 Tkw_NewBaseSearch_Control_CloseBtn_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_CloseBtn_Push }
 Tkw_NewBaseSearch_Control_AreaCombo.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_AreaCombo }
 Tkw_NewBaseSearch_Control_AreaCombo_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_AreaCombo_Push }
 Tkw_NewBaseSearch_Control_QueryExampleLabel.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_QueryExampleLabel }
 Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_QueryExampleLabel_Push }
 Tkw_NewBaseSearch_Control_DropButton.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_DropButton }
 Tkw_NewBaseSearch_Control_DropButton_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_DropButton_Push }
 Tkw_NewBaseSearch_Control_FoundCountLabel.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_FoundCountLabel }
 Tkw_NewBaseSearch_Control_FoundCountLabel_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_FoundCountLabel_Push }
 Tkw_NewBaseSearch_Control_ExampleLabel.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_ExampleLabel }
 Tkw_NewBaseSearch_Control_ExampleLabel_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_ExampleLabel_Push }
 Tkw_NewBaseSearch_Control_ContextEditPanel.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_ContextEditPanel }
 Tkw_NewBaseSearch_Control_ContextEditPanel_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_ContextEditPanel_Push }
 Tkw_NewBaseSearch_Control_Layout1.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Layout1 }
 Tkw_NewBaseSearch_Control_Layout1_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Layout1_Push }
 Tkw_NewBaseSearch_Control_Layout2.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Layout2 }
 Tkw_NewBaseSearch_Control_Layout2_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Layout2_Push }
 Tkw_NewBaseSearch_Control_Layout3.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Layout3 }
 Tkw_NewBaseSearch_Control_Layout3_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Layout3_Push }
 Tkw_NewBaseSearch_Control_vgScene1.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_vgScene1 }
 Tkw_NewBaseSearch_Control_vgScene1_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_vgScene1_Push }
 Tkw_NewBaseSearch_Control_MoreTab.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_MoreTab }
 Tkw_NewBaseSearch_Control_MoreTab_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_MoreTab_Push }
 Tkw_NewBaseSearch_Control_Border.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Border }
 Tkw_NewBaseSearch_Control_Border_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Border_Push }
 Tkw_NewBaseSearch_Control_InnerBorder.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_InnerBorder }
 Tkw_NewBaseSearch_Control_InnerBorder_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_InnerBorder_Push }
 Tkw_NewBaseSearch_Control_MostOuterRectangle.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_MostOuterRectangle }
 Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_MostOuterRectangle_Push }
 Tkw_NewBaseSearch_Control_Rectangle1.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Rectangle1 }
 Tkw_NewBaseSearch_Control_Rectangle1_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_Rectangle1_Push }
 Tkw_NewBaseSearch_Control_ContextEdit.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_ContextEdit }
 Tkw_NewBaseSearch_Control_ContextEdit_Push.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Control_ContextEdit_Push }
 Tkw_NewBaseSearch_Component_FlashTimer.RegisterInEngine;
 {* ����������� Tkw_NewBaseSearch_Component_FlashTimer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TNewBaseSearchForm));
 {* ����������� ���� TNewBaseSearchForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgPathButton));
 {* ����������� ���� TvgPathButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgCloseButton));
 {* ����������� ���� TvgCloseButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgComboBox));
 {* ����������� ���� TvgComboBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgText));
 {* ����������� ���� TvgText }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgButton));
 {* ����������� ���� TvgButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgNonVGLayout));
 {* ����������� ���� TvgNonVGLayout }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgLayout));
 {* ����������� ���� TvgLayout }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgScene));
 {* ����������� ���� TvgScene }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgRectangle));
 {* ����������� ���� TvgRectangle }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeComboWithHistoryAndOperations));
 {* ����������� ���� TnscTreeComboWithHistoryAndOperations }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTimer));
 {* ����������� ���� TTimer }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
