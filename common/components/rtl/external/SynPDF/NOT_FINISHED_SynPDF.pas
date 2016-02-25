unit NOT_FINISHED_SynPDF;

// Модуль: "w:\common\components\rtl\external\SynPDF\NOT_FINISHED_SynPDF.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\external\SynPDF\Synopse.inc}

interface

uses
 l3IntfUses
;

type
 TPdfDocument = class
  private
   f_ForEtalon: Boolean;
    {* Поле для свойства ForEtalon }
  protected
   function pm_GetForEtalon: Boolean; virtual;
   procedure pm_SetForEtalon(aValue: Boolean); virtual;
   procedure DoSet4Etalon(aValue: Boolean); virtual;
  public
   property ForEtalon: Boolean
    read pm_GetForEtalon
    write pm_SetForEtalon;
 end;//TPdfDocument

 TPdfCanvas = class
 end;//TPdfCanvas

 TPdfStream = class
 end;//TPdfStream

 TPdfImage = class
 end;//TPdfImage

 TPdfPageGDI = class
 end;//TPdfPageGDI

procedure GDICommentStatAAC;
procedure GDICommentEndAAC;

implementation

uses
 l3ImplUses
 , SynCommons
 , SynCrypto
 , SynZip
 , SynGdiPlus
 , SynLZ
;

procedure GDICommentStatAAC;
//#UC START# *54B4DF3C00FD_545CBD310006_var*
//#UC END# *54B4DF3C00FD_545CBD310006_var*
begin
//#UC START# *54B4DF3C00FD_545CBD310006_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B4DF3C00FD_545CBD310006_impl*
end;//GDICommentStatAAC

procedure GDICommentEndAAC;
//#UC START# *54B4DF5101C2_545CBD310006_var*
//#UC END# *54B4DF5101C2_545CBD310006_var*
begin
//#UC START# *54B4DF5101C2_545CBD310006_impl*
 !!! Needs to be implemented !!!
//#UC END# *54B4DF5101C2_545CBD310006_impl*
end;//GDICommentEndAAC

function TPdfDocument.pm_GetForEtalon: Boolean;
//#UC START# *56B470F10230_545CBD8C00E0get_var*
//#UC END# *56B470F10230_545CBD8C00E0get_var*
begin
//#UC START# *56B470F10230_545CBD8C00E0get_impl*
 !!! Needs to be implemented !!!
//#UC END# *56B470F10230_545CBD8C00E0get_impl*
end;//TPdfDocument.pm_GetForEtalon

procedure TPdfDocument.pm_SetForEtalon(aValue: Boolean);
//#UC START# *56B470F10230_545CBD8C00E0set_var*
//#UC END# *56B470F10230_545CBD8C00E0set_var*
begin
//#UC START# *56B470F10230_545CBD8C00E0set_impl*
 !!! Needs to be implemented !!!
//#UC END# *56B470F10230_545CBD8C00E0set_impl*
end;//TPdfDocument.pm_SetForEtalon

procedure TPdfDocument.DoSet4Etalon(aValue: Boolean);
//#UC START# *56B471530132_545CBD8C00E0_var*
//#UC END# *56B471530132_545CBD8C00E0_var*
begin
//#UC START# *56B471530132_545CBD8C00E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *56B471530132_545CBD8C00E0_impl*
end;//TPdfDocument.DoSet4Etalon

end.
