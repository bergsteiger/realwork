unit Inpharm_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm_Strange_Controls.pas"
// Начат: 30.07.2010 18:46
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Встроенные продукты::Inpharm::View::Strange
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
  vcmExternalInterfaces {a}
  ;

(* MedicListSynchroView = operations
  {* Синхронный просмотр ИНФАРМ }
   ['{337FF9E1-287B-4F58-B7C5-9E640E11F803}']
   operation OpenDocument; has states;
     {* Текст документа }
      Drug = state
       { Описание препарата }
      end;//Drug
      MedicFirm = state
       { Описание фирмы }
      end;//MedicFirm
   operation OpenList; has states;
     {* Список препаратов }
      Drug = state
       { Препараты-синонимы }
       { Список препаратов-синонимов по международному названию }
      end;//Drug
      MedicFirm = state
       { Производимые препараты }
       { Список производимых препаратов }
      end;//MedicFirm
   operation OpenDocument; has states;
   operation OpenAttributesForm;
   operation OpenList; has states;
 end;//MedicListSynchroView*)

(* MedicFirmList = operations
   ['{7AA0F678-0660-4DEA-B2B9-204C526629AD}']
   operation CountryFilter;
 end;//MedicFirmList*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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

// Состояния операций:
var st_user_MedicListSynchroView_OpenDocument_Drug : TvcmOperationStateIndex = (rID : -1);
  // Синхронный просмотр ИНФАРМ -> Текст документа <-> Описание препарата
var st_user_MedicListSynchroView_OpenDocument_MedicFirm : TvcmOperationStateIndex = (rID : -1);
  // Синхронный просмотр ИНФАРМ -> Текст документа <-> Описание фирмы
var st_user_MedicListSynchroView_OpenList_Drug : TvcmOperationStateIndex = (rID : -1);
  // Синхронный просмотр ИНФАРМ -> Список препаратов <-> Препараты-синонимы
var st_user_MedicListSynchroView_OpenList_MedicFirm : TvcmOperationStateIndex = (rID : -1);
  // Синхронный просмотр ИНФАРМ -> Список препаратов <-> Производимые препараты
{$IfEnd} //not Admin AND not Monitorings

implementation

end.