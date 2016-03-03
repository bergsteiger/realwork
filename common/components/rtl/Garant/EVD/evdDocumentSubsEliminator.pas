unit evdDocumentSubsEliminator;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdDocumentSubsEliminator.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , evdDocumentMarksEliminator
 , l3Variant
;

type
 TevdDocumentSubsEliminator = class(TevdDocumentMarksEliminator)
  protected
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdDocumentSubsEliminator

implementation

uses
 l3ImplUses
 , evdTypes
 , k2Tags
;

function TevdDocumentSubsEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* Определяет нужно ли фильтровать переданный абзац }
//#UC START# *49E48829016F_4E6756B3015E_var*
//#UC END# *49E48829016F_4E6756B3015E_var*
begin
//#UC START# *49E48829016F_4E6756B3015E_impl*
 Result := aLeaf.IntA[k2_tiHandle] <> Ord(ev_sbtSub);
//#UC END# *49E48829016F_4E6756B3015E_impl*
end;//TevdDocumentSubsEliminator.NeedWritePara

end.
