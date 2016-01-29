unit PharmFirmListUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/PharmFirmListUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::PharmFirmList
//
// Список фирм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  DocumentUnit
  ;

type
 IPharmFirmListEntry = interface(IEntityBase)
  {* Обертка для документа-фирмы из списка }
   ['{7408C436-42FD-4AD7-879D-5C2625EFAE18}']
   procedure GetDocument(out aRet {: IDocument}); stdcall;
 end;//IPharmFirmListEntry

implementation

end.