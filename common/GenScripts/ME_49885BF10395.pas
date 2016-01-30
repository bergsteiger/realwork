unit Document_F1Lite_Controls;
 {* Урезанные "сущности" для таких форм как документ-схема }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document_F1Lite_Controls.pas"
// Стереотип: "VCMControls"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

type
 // Edit

 // RemoveFromControl

 // AddToControl

 // Text

 // Selection
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
