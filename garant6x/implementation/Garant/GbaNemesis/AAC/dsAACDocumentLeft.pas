unit dsAACDocumentLeft;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AAC$DataSources"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/AAC/dsAACDocumentLeft.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::AAC::AAC$DataSources::AACImplementation::TdsAACDocumentLeft
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
  dsAACDocumentPrim,
  nevTools,
  evdTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsAACDocumentLeft = {vac} class(TdsAACDocumentPrim)
 protected
 // realized methods
   function BlockViewKind: TevBlockViewKind; override;
 protected
 // overridden protected methods
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsAACDocumentLeft
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsAACLeftDocumentContainer
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsAACDocumentLeft

function TdsAACDocumentLeft.BlockViewKind: TevBlockViewKind;
//#UC START# *500E74C30088_500E746B0273_var*
//#UC END# *500E74C30088_500E746B0273_var*
begin
//#UC START# *500E74C30088_500E746B0273_impl*
 Result := ev_bvkLeft;
//#UC END# *500E74C30088_500E746B0273_impl*
end;//TdsAACDocumentLeft.BlockViewKind

function TdsAACDocumentLeft.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_500E746B0273_var*
//#UC END# *4C6AB38800F3_500E746B0273_var*
begin
//#UC START# *4C6AB38800F3_500E746B0273_impl*
 Result := TnsAACLeftDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_500E746B0273_impl*
end;//TdsAACDocumentLeft.MakeContainer

{$IfEnd} //not Admin AND not Monitorings

end.