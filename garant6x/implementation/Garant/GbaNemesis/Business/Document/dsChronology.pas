unit dsChronology;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsChronology.pas"
// Начат: 08.12.2008 19:08
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::DocumentAndList::TdsChronology
//
// Хронология судебного дела
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
  dsChildDocument,
  l3StringIDEx,
  afwInterfaces,
  nevTools,
  l3Interfaces,
  DocumentAndListInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsChronology = {vac} class(TdsChildDocument)
  {* Хронология судебного дела }
 protected
 // overridden protected methods
   function DoGetPreviewCaleeArea: TafwPreviewCaleeArea; override;
   function MakeContainer: InevDocumentContainer; override;
     {* Конструирует контейнер документа }
   function DoGetDocumentShortName: Il3CString; override;
 end;//TdsChronology
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsChronologyDocumentContainer,
  l3String,
  l3MessageID,
  IOUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки Chronology Local Const }
  str_OldDocumentNamePrefix : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'OldDocumentNamePrefix'; rValue : 'Справка к');
   { 'Справка к' }
  str_NewDocumentNamePrefix : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'NewDocumentNamePrefix'; rValue : 'Хронология судебного дела');
   { 'Хронология судебного дела' }

// start class TdsChronology

function TdsChronology.DoGetPreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_53BFEDC40225_var*
//#UC END# *49589999029F_53BFEDC40225_var*
begin
//#UC START# *49589999029F_53BFEDC40225_impl*
 Result := afw_pcaChronology;
//#UC END# *49589999029F_53BFEDC40225_impl*
end;//TdsChronology.DoGetPreviewCaleeArea

function TdsChronology.MakeContainer: InevDocumentContainer;
//#UC START# *4C6AB38800F3_53BFEDC40225_var*
//#UC END# *4C6AB38800F3_53BFEDC40225_var*
begin
//#UC START# *4C6AB38800F3_53BFEDC40225_impl*
 Result := TnsChronologyDocumentContainer.Make(DocInfo);
//#UC END# *4C6AB38800F3_53BFEDC40225_impl*
end;//TdsChronology.MakeContainer

function TdsChronology.DoGetDocumentShortName: Il3CString;
//#UC START# *53D8E620037C_53BFEDC40225_var*
//#UC END# *53D8E620037C_53BFEDC40225_var*
begin
//#UC START# *53D8E620037C_53BFEDC40225_impl*
 Result := inherited DoGetDocumentShortName;
 if not l3IsNil(Result) then
  Result := l3StringReplace(Result, str_OldDocumentNamePrefix.AsWStr, str_NewDocumentNamePrefix.AsWStr, []);
//#UC END# *53D8E620037C_53BFEDC40225_impl*
end;//TdsChronology.DoGetDocumentShortName

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_OldDocumentNamePrefix
 str_OldDocumentNamePrefix.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_NewDocumentNamePrefix
 str_NewDocumentNamePrefix.Init;
{$IfEnd} //not Admin AND not Monitorings

end.