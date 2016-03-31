unit stDocumentShowChangesInfoItem;
 {* Визуализатор для настройки "Показывать историю изменений в документе" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\stDocumentShowChangesInfoItem.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TstDocumentShowChangesInfoItem" MUID: (A8C41C353B7D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ddAppConfigTypes
;

type
 TstDocumentShowChangesInfoItem = class(TddComboBoxConfigItem)
  {* Визуализатор для настройки "Показывать историю изменений в документе" }
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstDocumentShowChangesInfoItem
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DocumentShowChangesInfoSettingRes
 , l3Base
 , ddAppConfigConst
;

constructor TstDocumentShowChangesInfoItem.Create(aMasterItem: TddBaseConfigItem = nil);
//#UC START# *5A0AB6F96B6F_A8C41C353B7D_var*
//#UC END# *5A0AB6F96B6F_A8C41C353B7D_var*
begin
//#UC START# *5A0AB6F96B6F_A8C41C353B7D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5A0AB6F96B6F_A8C41C353B7D_impl*
end;//TstDocumentShowChangesInfoItem.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
