unit NOT_FINISHED_nsSubPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\NOT_FINISHED_nsSubPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , eeSubExport
 {$IfEnd} // Defined(Nemesis)
 , l3Variant
;

type
 TnsSubPrim = class(TeeSubExport)
  protected
   function Tag: Tl3Tag; virtual;
   function SubPara: Tl3Tag; virtual;
 end;//TnsSubPrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

function TnsSubPrim.Tag: Tl3Tag;
//#UC START# *4C9B0AD90093_46835879030A_var*
//#UC END# *4C9B0AD90093_46835879030A_var*
begin
//#UC START# *4C9B0AD90093_46835879030A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C9B0AD90093_46835879030A_impl*
end;//TnsSubPrim.Tag

function TnsSubPrim.SubPara: Tl3Tag;
//#UC START# *4C9B0AEF009B_46835879030A_var*
//#UC END# *4C9B0AEF009B_46835879030A_var*
begin
//#UC START# *4C9B0AEF009B_46835879030A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C9B0AEF009B_46835879030A_impl*
end;//TnsSubPrim.SubPara
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
