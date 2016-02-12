{$IfNDef dsBaseDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocument.imp.pas"
// Стереотип: "ViewAreaControllerImp"

{$Define dsBaseDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _FormDataSourceType_ = IdsBaseDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
 _dsBaseDocument_ = {abstract} class(_dsBaseDocumentPrim_)
  {* БОФ, базовый для прецедентов с документом. ОПРЕДЕЛЯЕТ конечный интерфейс бизнес-объекта }
 end;//_dsBaseDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
_dsBaseDocument_ = _dsBaseDocumentPrim_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsBaseDocument_imp}

{$IfNDef dsBaseDocument_imp_impl}

{$Define dsBaseDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$If not Declared(_InitDataType_)}type _InitDataType_ = IdeDocInfo;{$IfEnd}

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dsBaseDocument_imp_impl}

{$EndIf dsBaseDocument_imp}

