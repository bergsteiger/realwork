unit sdsSendConsultation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Consultation"
// Автор: Морозов М.А
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Consultation/sdsSendConsultation.pas"
// Начат: 2006/04/07 08:15:44
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Пользовательские сервисы::Consultation::Consultation::Consultation::TsdsSendConsultation
//
// Бизнес объект прецедента "Запрос на консультацию"
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  ConsultationInterfaces,
  sdsQuery
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetType_ = IsdsSendConsultation;
 TsdsSendConsultation = {ucc} class(TsdsQuery, IsdsSendConsultation)
  {* Бизнес объект прецедента "Запрос на консультацию" }
 protected
 // overridden protected methods
   function GetQueryClass: TdsQueryClass; override;
 end;//TsdsSendConsultation
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsSendConsultation
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TsdsSendConsultation

function TsdsSendConsultation.GetQueryClass: TdsQueryClass;
//#UC START# *492FEE0000FD_492FF1C500B5_var*
//#UC END# *492FEE0000FD_492FF1C500B5_var*
begin
//#UC START# *492FEE0000FD_492FF1C500B5_impl*
 Result := TdsSendConsultation;
//#UC END# *492FEE0000FD_492FF1C500B5_impl*
end;//TsdsSendConsultation.GetQueryClass

{$IfEnd} //not Admin AND not Monitorings

end.