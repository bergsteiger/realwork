unit Inpharm_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4C52E591003F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_MedicListSynchroView = 'MedicListSynchroView';
 en_capMedicListSynchroView = 'Синхронный просмотр ИНФАРМ';
 op_OpenDocument = 'OpenDocument';
 op_capOpenDocument = 'Текст документа';
 op_OpenList = 'OpenList';
 op_capOpenList = 'Список препаратов';
 op_OpenAttributesForm = 'OpenAttributesForm';
 op_capOpenAttributesForm = '';
 en_MedicFirmList = 'MedicFirmList';
 en_capMedicFirmList = '';
 op_CountryFilter = 'CountryFilter';
 op_capCountryFilter = '';

var st_user_MedicListSynchroView_OpenDocument_Drug: TvcmOperationStateIndex = (rID : -1);
 {* Синхронный просмотр ИНФАРМ -> Текст документа <-> Описание препарата }
var st_user_MedicListSynchroView_OpenDocument_MedicFirm: TvcmOperationStateIndex = (rID : -1);
 {* Синхронный просмотр ИНФАРМ -> Текст документа <-> Описание фирмы }
var st_user_MedicListSynchroView_OpenList_Drug: TvcmOperationStateIndex = (rID : -1);
 {* Синхронный просмотр ИНФАРМ -> Список препаратов <-> Препараты-синонимы }
var st_user_MedicListSynchroView_OpenList_MedicFirm: TvcmOperationStateIndex = (rID : -1);
 {* Синхронный просмотр ИНФАРМ -> Список препаратов <-> Производимые препараты }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
