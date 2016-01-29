unit NOT_FINISHED_nsConsultationHAFPainterImages_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation$View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/NOT_FINISHED_nsConsultationHAFPainterImages_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMDataModule::Class>> F1 Пользовательские сервисы::Consultation::Consultation$View::HAFPainters::nsConsultationHAFPainterImages
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
  Classes,
  nsHAFPainter
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsConsultationHAFPainter = class(TnsHAFPainter)
 end;//TnsConsultationHAFPainter

 TnsConsultationHAFPainterImagesForm = {form} class(TDataModule)
 end;//TnsConsultationHAFPainterImagesForm

 TvcmDataModuleRef = TnsConsultationHAFPainterImagesForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация nsConsultationHAFPainterImages
 TtfwClassRef.Register(TnsConsultationHAFPainterImagesForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.