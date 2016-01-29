unit Parent_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/Forms/Parent_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalContainer::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::ParentAndChildPrim::Parent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
  PrimParent_Form,
  F1Like_FormDefinitions_Controls,
  vtPanel,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;

type
  TParentForm = {final form} class(TPrimParentForm, ParentFormDef)
  Entities : TvcmEntities;
  end;//TParentForm

implementation

{$R *.DFM}

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  ParentKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// Регистрация Parent
 TtfwClassRef.Register(TParentForm);
{$IfEnd} //not NoScripts
// Регистрация фабрики формы Parent
 fm_ParentForm.SetFactory(TParentForm.Make);

end.