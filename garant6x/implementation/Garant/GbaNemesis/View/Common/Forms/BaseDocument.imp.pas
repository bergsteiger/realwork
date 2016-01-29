{$IfNDef BaseDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/BaseDocument.imp.pas"
// Начат: 02.02.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Common::View::Common::BaseDocument
//
// Абстрактное представление базового документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define BaseDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _BaseDocument_ = {abstract form} class(_BaseDocument_Parent_)
  {* Абстрактное представление базового документа }
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
 protected
 // protected fields
   sdsBaseDocument : IsdsBaseDocument;
    {* Базовый прецедент работы с документом}
 end;//_BaseDocument_
{$Else}

 _BaseDocument_ = _BaseDocument_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else BaseDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}

// start class _BaseDocument_

procedure _BaseDocument_.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  sdsBaseDocument := nil;
 end//aDsNew = nil
 else
 begin
  aDsNew.CastUCC(IsdsBaseDocument, sdsBaseDocument);
 end;//aDsNew = nil
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf BaseDocument_imp}
