unit dsAACDocumentRight;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AAC$DataSources"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/AAC/dsAACDocumentRight.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Пользовательские сервисы::AAC::AAC$DataSources::AACImplementation::TdsAACDocumentRight
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
 TdsAACDocumentRight = {vac} class(TdsAACDocumentPrim)
 protected
 // realized methods
   function BlockViewKind: TevBlockViewKind; override;
 protected
 // overridden protected methods
   function GetIsReadOnly: Boolean; override;
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
 end;//TdsAACDocumentRight
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsAACRightDocumentContainer
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsAACDocumentRight

function TdsAACDocumentRight.BlockViewKind: TevBlockViewKind;
//#UC START# *500E74C30088_500E747B0047_var*
//#UC END# *500E74C30088_500E747B0047_var*
begin
//#UC START# *500E74C30088_500E747B0047_impl*
 Result := ev_bvkRight;
//#UC END# *500E74C30088_500E747B0047_impl*
end;//TdsAACDocumentRight.BlockViewKind

function TdsAACDocumentRight.GetIsReadOnly: Boolean;
//#UC START# *491C263E03AF_500E747B0047_var*
//#UC END# *491C263E03AF_500E747B0047_var*
begin
//#UC START# *491C263E03AF_500E747B0047_impl*
 Result := True;
//#UC END# *491C263E03AF_500E747B0047_impl*
end;//TdsAACDocumentRight.GetIsReadOnly

function TdsAACDocumentRight.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_500E747B0047_var*
//#UC END# *4C6AB38800F3_500E747B0047_var*
begin
//#UC START# *4C6AB38800F3_500E747B0047_impl*
 Result := TnsAACRightDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_500E747B0047_impl*
end;//TdsAACDocumentRight.MakeContainer

{$IfEnd} //not Admin AND not Monitorings

end.