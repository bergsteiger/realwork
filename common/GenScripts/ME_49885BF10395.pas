unit Document_F1Lite_Controls;
 {* Урезанные "сущности" для таких форм как документ-схема }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document_F1Lite_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "F1Lite" MUID: (49885BF10395)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
