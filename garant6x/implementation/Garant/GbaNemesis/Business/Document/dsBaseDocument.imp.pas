{$IfNDef dsBaseDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsBaseDocument.imp.pas"
// Начат: 21.11.2008 17:53
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::Business::BaseDocument::dsBaseDocument
//
// БОФ, базовый для прецедентов с документом. ОПРЕДЕЛЯЕТ конечный интерфейс бизнес-объекта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dsBaseDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _FormDataSourceType_ = IdsBaseDocument;
 {$Include ..\Document\dsBaseDocumentPrim.imp.pas}
 _dsBaseDocument_ = {abstract vac} class(_dsBaseDocumentPrim_)
  {* БОФ, базовый для прецедентов с документом. ОПРЕДЕЛЯЕТ конечный интерфейс бизнес-объекта }
 end;//_dsBaseDocument_
{$Else}

 {$Include ..\Document\dsBaseDocumentPrim.imp.pas}
 _dsBaseDocument_ = _dsBaseDocumentPrim_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dsBaseDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\Document\dsBaseDocumentPrim.imp.pas}


{$IfEnd} //not Admin AND not Monitorings

{$EndIf dsBaseDocument_imp}
