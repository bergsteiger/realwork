{$IfNDef BaseDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "BaseDocument" MUID: (49870A7E033E)
// Имя типа: "_BaseDocument_"

{$Define BaseDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _BaseDocument_ = {abstract} class(_BaseDocument_Parent_)
  {* Абстрактное представление базового документа }
  protected
   sdsBaseDocument: IsdsBaseDocument;
    {* Базовый прецедент работы с документом }
  protected
   {$If NOT Defined(NoVCM)}
   procedure SignalDataSourceChanged(const anOld: IvcmFormDataSource;
    const aNew: IvcmFormDataSource); override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_BaseDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_BaseDocument_ = _BaseDocument_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else BaseDocument_imp}

{$IfNDef BaseDocument_imp_impl}

{$Define BaseDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If NOT Defined(NoVCM)}
procedure _BaseDocument_.SignalDataSourceChanged(const anOld: IvcmFormDataSource;
 const aNew: IvcmFormDataSource);
begin
 inherited;
 if (aNew = nil) then
 begin
  sdsBaseDocument := nil;
 end//aNew = nil
 else
 begin
  aNew.CastUCC(IsdsBaseDocument, sdsBaseDocument);
 end;//aNew = nil
end;//_BaseDocument_.SignalDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf BaseDocument_imp_impl}

{$EndIf BaseDocument_imp}

