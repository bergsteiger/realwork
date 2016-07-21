unit PharmFirmListUnit;
 {* Список фирм }

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\PharmFirmListUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "PharmFirmList" MUID: (47E8DDB10253)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , DocumentUnit
;

type
 IPharmFirmListEntry = interface(IEntityBase)
  {* Обертка для документа-фирмы из списка }
  ['{7408C436-42FD-4AD7-879D-5C2625EFAE18}']
  procedure GetDocument(out aRet
   {* IDocument }); stdcall;
 end;//IPharmFirmListEntry

implementation

uses
 l3ImplUses
;

end.
