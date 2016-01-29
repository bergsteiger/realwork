unit NOT_FINISHED_NewBaseSearch_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/Forms/NOT_FINISHED_NewBaseSearch_Form.pas"
// Начат: 30.11.2010 12:07
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Основные прецеденты::BaseSearch::View::BaseSearch$Module::BaseSearch::NewBaseSearch
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Common_FormDefinitions_Controls,
  NewBaseSearchForDFM_Form
  {$If defined(Nemesis)}
  ,
  nscTreeComboWithHistoryAndOperations
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVGScene)}
  ,
  vg_controls
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_listbox
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_objects
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_layouts
  {$IfEnd} //not NoVGScene
  
  {$If not defined(NoVGScene)}
  ,
  vg_scene
  {$IfEnd} //not NoVGScene
  ,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  TNewBaseSearchForm = {final form} class(TNewBaseSearchForDFMForm, NewBaseSearchFormDef)
  Entities : TvcmEntities;
  ContextEdit: TnscTreeComboWithHistoryAndOperations;
  FindBtn: TvgPathButton;
  FindBackBtn: TvgPathButton;
  CloseBtn: TvgCloseButton;
  AreaCombo: TvgComboBox;
  QueryExampleLabel: TvgText;
  DropButton: TvgButton;
  FoundCountLabel: TvgText;
  ExampleLabel: TvgText;
  ContextEditPanel: TvgNonVGLayout;
  Layout1: TvgLayout;
  Layout2: TvgLayout;
  Layout3: TvgLayout;
  vgScene1: TvgScene;
  MoreTab: TvgComboBox;
  Border: TvgRectangle;
  InnerBorder: TvgRectangle;
  MostOuterRectangle: TvgRectangle;
  Rectangle1: TvgRectangle;
  end;//TNewBaseSearchForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  NewBaseSearchKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация NewBaseSearch
 TtfwClassRef.Register(TNewBaseSearchForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.