unit dsAACDocumentPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AAC$DataSources"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/AAC/dsAACDocumentPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::AAC::AAC$DataSources::AACImplementation::TdsAACDocumentPrim
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
  evdTypes,
  dsDocument
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsAACDocumentPrim = {vac} class(TdsDocument)
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   function GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean; override;
   {$IfEnd} //not NoVCM
 protected
 // protected methods
   function BlockViewKind: TevBlockViewKind; virtual; abstract;
 end;//TdsAACDocumentPrim
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsAACDocumentPrim

{$If not defined(NoVCM)}
function TdsAACDocumentPrim.GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean;
//#UC START# *49147B4602C0_500E749D0046_var*
//#UC END# *49147B4602C0_500E749D0046_var*
begin
//#UC START# *49147B4602C0_500E749D0046_impl*
 Result := (_FormDataSourceType_(Self) = aDataSource);
//#UC END# *49147B4602C0_500E749D0046_impl*
end;//TdsAACDocumentPrim.GetIsNeedChangePosition
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.