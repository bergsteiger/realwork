unit nsTabbedContainerUtils;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\TabInterface\nsTabbedContainerUtils.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

function DocumentsFromListOpenKind: TvcmMainFormOpenKind;
function LinksFromDocumentOpenKind: TvcmMainFormOpenKind;

implementation

uses
 l3ImplUses
 , nsConst
 , afwFacade
;

function GetOpenKindSettingsValue(const aSettingsName: AnsiString): TvcmMainFormOpenKind;
//#UC START# *53A40360003B_53A403330029_var*
//#UC END# *53A40360003B_53A403330029_var*
begin
//#UC START# *53A40360003B_53A403330029_impl*
 Result := TvcmMainFormOpenKind(afw.Settings.LoadInteger(aSettingsName));
//#UC END# *53A40360003B_53A403330029_impl*
end;//GetOpenKindSettingsValue

function DocumentsFromListOpenKind: TvcmMainFormOpenKind;
//#UC START# *53A4034102D5_53A403330029_var*
//#UC END# *53A4034102D5_53A403330029_var*
begin
//#UC START# *53A4034102D5_53A403330029_impl*
 Result := nsGetOpenKindSettingsValue(pi_OpenDocumentsFromList);
//#UC END# *53A4034102D5_53A403330029_impl*
end;//DocumentsFromListOpenKind

function LinksFromDocumentOpenKind: TvcmMainFormOpenKind;
//#UC START# *53A403510223_53A403330029_var*
//#UC END# *53A403510223_53A403330029_var*
begin
//#UC START# *53A403510223_53A403330029_impl*
 Result := nsGetOpenKindSettingsValue(pi_OpenLinksFromDocument);
//#UC END# *53A403510223_53A403330029_impl*
end;//LinksFromDocumentOpenKind

end.
