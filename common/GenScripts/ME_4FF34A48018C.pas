unit DocumentUtil;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUtil.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_IsDocumentUsefulCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'IsDocumentUsefulCaption'; rValue : 'Полезен ли документ?');
  {* 'Полезен ли документ?' }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3MessageID
;

initialization
 str_IsDocumentUsefulCaption.Init;
 {* Инициализация str_IsDocumentUsefulCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
