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
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkBoolean;
 l_Value.AsBoolean := dv_Document_ShowChangesInfo;
 inherited Create(pi_Document_ShowChangesInfo,
  str_ShowChangesInfo.AsStr,
  l_Value, TShowChangesInfoValuesMapImpl.Make, aMasterItem);
end;//TstDocumentShowChangesInfoItem.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
