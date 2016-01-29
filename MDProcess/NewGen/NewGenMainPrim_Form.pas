unit NewGenMainPrim_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/NewGen/NewGenMainPrim_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> MDProcess$NewGen$Interface::NewGen::NewGen::NewGenMainPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\NewGen\ngDefine.inc}

interface

{$If defined(NewGen)}
uses
  MainPrim_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //NewGen

{$If defined(NewGen)}
type
 TNewGenMainPrimForm = {form} class(TMainPrimForm)
 end;//TNewGenMainPrimForm

 TvcmMainFormRef = TNewGenMainPrimForm;
{$IfEnd} //NewGen

implementation

{$If defined(NewGen)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //NewGen

{$If defined(NewGen)}


{$IfEnd} //NewGen

initialization
{$If defined(NewGen) AND not defined(NoScripts)}
// Регистрация NewGenMainPrim
 TtfwClassRef.Register(TNewGenMainPrimForm);
{$IfEnd} //NewGen AND not NoScripts

end.