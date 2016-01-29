unit Child_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/Forms/Child_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalContainer::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::ParentAndChildPrim::Child
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
  PrimChild_Form,
  F1Like_FormDefinitions_Controls
  {$If defined(Nemesis)}
  ,
  nscFormsPageControl
  {$IfEnd} //Nemesis
  ,
  ElPgCtl,
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
  TChildForm = {final form} class(TPrimChildForm, ChildFormDef)
  Entities : TvcmEntities;
  end;//TChildForm

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
  ChildKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// Регистрация Child
 TtfwClassRef.Register(TChildForm);
{$IfEnd} //not NoScripts
// Регистрация фабрики формы Child
 fm_ChildForm.SetFactory(TChildForm.Make);

end.