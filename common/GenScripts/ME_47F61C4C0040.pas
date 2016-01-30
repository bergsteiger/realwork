unit NOT_FINISHED_nsDocumentTools;
 {* Утилиты для работы с документом. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\NOT_FINISHED_nsDocumentTools.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

procedure nsGetDocumentShortName;
procedure CreateFileName;
procedure nsGetBookmarkName;
procedure nsGetDocumentWarning;
procedure DocumentSaveAs;
 {* Сохранить документ. }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDocumentPreview
 , nsDocumentPreviewWithoutBlockNames
;

procedure nsGetDocumentShortName;
//#UC START# *4ADF1473035D_47F61C4C0040_var*
//#UC END# *4ADF1473035D_47F61C4C0040_var*
begin
//#UC START# *4ADF1473035D_47F61C4C0040_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADF1473035D_47F61C4C0040_impl*
end;//nsGetDocumentShortName

procedure CreateFileName;
//#UC START# *4AE1B27300BA_47F61C4C0040_var*
//#UC END# *4AE1B27300BA_47F61C4C0040_var*
begin
//#UC START# *4AE1B27300BA_47F61C4C0040_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE1B27300BA_47F61C4C0040_impl*
end;//CreateFileName

procedure nsGetBookmarkName;
//#UC START# *4AE85B500231_47F61C4C0040_var*
//#UC END# *4AE85B500231_47F61C4C0040_var*
begin
//#UC START# *4AE85B500231_47F61C4C0040_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AE85B500231_47F61C4C0040_impl*
end;//nsGetBookmarkName

procedure nsGetDocumentWarning;
//#UC START# *4C80D59101F1_47F61C4C0040_var*
//#UC END# *4C80D59101F1_47F61C4C0040_var*
begin
//#UC START# *4C80D59101F1_47F61C4C0040_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C80D59101F1_47F61C4C0040_impl*
end;//nsGetDocumentWarning

procedure DocumentSaveAs;
 {* Сохранить документ. }
//#UC START# *47F61D6301A7_47F61C4C0040_var*
//#UC END# *47F61D6301A7_47F61C4C0040_var*
begin
//#UC START# *47F61D6301A7_47F61C4C0040_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F61D6301A7_47F61C4C0040_impl*
end;//DocumentSaveAs
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
