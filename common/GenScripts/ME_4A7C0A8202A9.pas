unit Base_Operations_View_Controls;
 {* Операции влияющие на визальное представление объектов системы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_View_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "View" MUID: (4A7C0A8202A9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 // Document
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
