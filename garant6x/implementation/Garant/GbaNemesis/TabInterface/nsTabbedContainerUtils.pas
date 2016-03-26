unit nsTabbedContainerUtils;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\TabInterface\nsTabbedContainerUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsTabbedContainerUtils" MUID: (53A403330029)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

function nsDocumentsFromListOpenKind: TvcmMainFormOpenKind;
function nsLinksFromDocumentOpenKind: TvcmMainFormOpenKind;

implementation

uses
 l3ImplUses
 , nsConst
 , afwFacade
;

function nsGetOpenKindSettingsValue(const aSettingsName: AnsiString): TvcmMainFormOpenKind;
//#UC START# *53A40360003B_53A403330029_var*
//#UC END# *53A40360003B_53A403330029_var*
begin
//#UC START# *53A40360003B_53A403330029_impl*
 Result := TvcmMainFormOpenKind(afw.Settings.LoadInteger(aSettingsName));
//#UC END# *53A40360003B_53A403330029_impl*
end;//nsGetOpenKindSettingsValue

function nsDocumentsFromListOpenKind: TvcmMainFormOpenKind;
//#UC START# *53A4034102D5_53A403330029_var*
//#UC END# *53A4034102D5_53A403330029_var*
begin
//#UC START# *53A4034102D5_53A403330029_impl*
 Result := nsGetOpenKindSettingsValue(pi_OpenDocumentsFromList);
//#UC END# *53A4034102D5_53A403330029_impl*
end;//nsDocumentsFromListOpenKind

function nsLinksFromDocumentOpenKind: TvcmMainFormOpenKind;
//#UC START# *53A403510223_53A403330029_var*
//#UC END# *53A403510223_53A403330029_var*
begin
//#UC START# *53A403510223_53A403330029_impl*
 Result := nsGetOpenKindSettingsValue(pi_OpenLinksFromDocument);
//#UC END# *53A403510223_53A403330029_impl*
end;//nsLinksFromDocumentOpenKind

end.
