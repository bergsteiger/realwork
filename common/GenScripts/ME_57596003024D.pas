{$IfNDef sdsDocInfoFS_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\NOT_FINISHED_sdsDocInfoFS.imp.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "sdsDocInfoFS" MUID: (57596003024D)
// Имя типа: "_sdsDocInfoFS_"

{$Define sdsDocInfoFS_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsDocInfo.imp.pas}
 _sdsDocInfoFS_ = {abstract} class(_sdsDocInfo_)
 end;//_sdsDocInfoFS_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsDocInfo.imp.pas}
_sdsDocInfoFS_ = _sdsDocInfo_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else sdsDocInfoFS_imp}

{$IfNDef sdsDocInfoFS_imp_impl}

{$Define sdsDocInfoFS_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsDocInfo.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf sdsDocInfoFS_imp_impl}

{$EndIf sdsDocInfoFS_imp}

