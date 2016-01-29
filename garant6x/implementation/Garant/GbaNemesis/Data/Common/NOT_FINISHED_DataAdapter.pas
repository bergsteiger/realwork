unit NOT_FINISHED_DataAdapter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Common/NOT_FINISHED_DataAdapter.pas"
// Начат: 2003/05/23 14:19:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Common::DataAdapter
//
// Фасад для работы с адаптером
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  AdminDomainInterfaces
  {$If not defined(Admin) AND not defined(Monitorings)}
  ,
  DataAdapterInterfaces
  {$IfEnd} //not Admin AND not Monitorings
  
  ;

type
 TDataAdapter = class
  {* Объект для связи всех главных форм с адаптером сервера приложений }
 private
 // private fields
  {$If not defined(Admin) AND not defined(Monitorings)}
   f_TimeMachine : InsTimeMachine;
    {* Поле для свойства TimeMachine}
  {$IfEnd} //not Admin AND not Monitorings
 protected
 // property methods
   {$If not defined(Admin) AND not defined(Monitorings)}
   function pm_GetTimeMachine: InsTimeMachine; virtual;
   {$IfEnd} //not Admin AND not Monitorings
   function pm_GetAdminInfo: InsAdminInfo; virtual;
 private
 // private properties
     {$If not defined(Admin) AND not defined(Monitorings)}
   property TimeMachine: InsTimeMachine
     read pm_GetTimeMachine;
     {$IfEnd} //not Admin AND not Monitorings
   property AdminInfo: InsAdminInfo
     read pm_GetAdminInfo;
 end;//TDataAdapter

var DefDataAdapter : TDataAdapter;

var g_ShowFinalSplash : Boolean;
procedure DefDataAdapter; overload; 
   {* Сигнатура метода DefDataAdapter }

implementation

uses
  nsQuestionsWithChoices,
  nsLoginUtils
  ;

// start class TDataAdapter

{$If not defined(Admin) AND not defined(Monitorings)}
function TDataAdapter.pm_GetTimeMachine: InsTimeMachine;
//#UC START# *4AC21B930363_48FF55B500CCget_var*
//#UC END# *4AC21B930363_48FF55B500CCget_var*
begin
//#UC START# *4AC21B930363_48FF55B500CCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC21B930363_48FF55B500CCget_impl*
end;//TDataAdapter.pm_GetTimeMachine
{$IfEnd} //not Admin AND not Monitorings

function TDataAdapter.pm_GetAdminInfo: InsAdminInfo;
//#UC START# *4AC21F4503DE_48FF55B500CCget_var*
//#UC END# *4AC21F4503DE_48FF55B500CCget_var*
begin
//#UC START# *4AC21F4503DE_48FF55B500CCget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC21F4503DE_48FF55B500CCget_impl*
end;//TDataAdapter.pm_GetAdminInfo

procedure DefDataAdapter;
//#UC START# *4B1E8FAE0380_48FF556602BA_var*
//#UC END# *4B1E8FAE0380_48FF556602BA_var*
begin
//#UC START# *4B1E8FAE0380_48FF556602BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B1E8FAE0380_48FF556602BA_impl*
end;//DefDataAdapter

end.