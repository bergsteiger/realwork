unit NOT_FINISHED_NewBaseSearch_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\NOT_FINISHED_NewBaseSearch_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "NewBaseSearch" MUID: (4CF4BE9C035F)
// Имя типа: "TNewBaseSearchForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , NewBaseSearchForDFM_Form
 , Common_FormDefinitions_Controls
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If Defined(Nemesis)}
 , nscTreeComboWithHistoryAndOperations
 {$IfEnd} // Defined(Nemesis)
;

type
 TNewBaseSearchForm = {final} class(TNewBaseSearchForDFMForm, NewBaseSearchFormDef)
   Entities : TvcmEntities;
   FindBtn : TvgPathButton;
   FindBackBtn : TvgPathButton;
   CloseBtn : TvgCloseButton;
   AreaCombo : TvgComboBox;
   QueryExampleLabel : TvgText;
   DropButton : TvgButton;
   FoundCountLabel : TvgText;
   ExampleLabel : TvgText;
   ContextEditPanel : TvgNonVGLayout;
   Layout1 : TvgLayout;
   Layout2 : TvgLayout;
   Layout3 : TvgLayout;
   vgScene1 : TvgScene;
   MoreTab : TvgComboBox;
   Border : TvgRectangle;
   InnerBorder : TvgRectangle;
   MostOuterRectangle : TvgRectangle;
   Rectangle1 : TvgRectangle;
   ContextEdit : TnscTreeComboWithHistoryAndOperations;
 end;//TNewBaseSearchForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , NewBaseSearchKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TNewBaseSearchForm);
 {* Регистрация NewBaseSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
