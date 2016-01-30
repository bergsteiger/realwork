unit sdsSendConsultation;
 {* Бизнес объект прецедента "Запрос на консультацию" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\sdsSendConsultation.pas"
// Стереотип: "UseCaseControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , sdsQuery
 , ConsultationInterfaces
;

type
 _SetType_ = IsdsSendConsultation;
 TsdsSendConsultation = class(TsdsQuery, IsdsSendConsultation)
  {* Бизнес объект прецедента "Запрос на консультацию" }
  protected
   function GetQueryClass: TdsQueryClass; override;
 end;//TsdsSendConsultation
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsSendConsultation
;

function TsdsSendConsultation.GetQueryClass: TdsQueryClass;
//#UC START# *492FEE0000FD_492FF1C500B5_var*
//#UC END# *492FEE0000FD_492FF1C500B5_var*
begin
//#UC START# *492FEE0000FD_492FF1C500B5_impl*
 Result := TdsSendConsultation;
//#UC END# *492FEE0000FD_492FF1C500B5_impl*
end;//TsdsSendConsultation.GetQueryClass
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
