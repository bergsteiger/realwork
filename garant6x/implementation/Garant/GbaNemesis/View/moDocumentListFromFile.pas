unit moDocumentListFromFile;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/moDocumentListFromFile.pas"
// Начат: 12.04.2011 16:54
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMUseCaseRealization::Class>> F1 Интерфейсные элементы::DocumentListFromFile::DocumentListFromFile
//
// Список документов из файла
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
  PrimDocumentListFromFile_Module
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
Tmo_DocumentListFromFile = {final formspack} class(TPrimDocumentListFromFileModule)
 {* Список документов из файла }
end;//Tmo_DocumentListFromFile
{$IfEnd} //not Admin AND not Monitorings

implementation

end.