unit evdDocumentBookmarksEliminator;

// Модуль: "w:\common\components\rtl\Garant\EVD\evdDocumentBookmarksEliminator.pas"
// Стереотип: "SimpleClass"

{$Include evdDefine.inc}

interface

uses
 l3IntfUses
 , evdDocumentMarksEliminator
 , l3Variant
;

type
 TevdDocumentBookmarksEliminator = class(TevdDocumentMarksEliminator)
  protected
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* Определяет нужно ли фильтровать переданный абзац }
 end;//TevdDocumentBookmarksEliminator

implementation

uses
 l3ImplUses
 , evdTypes
 , k2Tags
;

function TevdDocumentBookmarksEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* Определяет нужно ли фильтровать переданный абзац }
//#UC START# *49E48829016F_4E6750EF020D_var*
//#UC END# *49E48829016F_4E6750EF020D_var*
begin
//#UC START# *49E48829016F_4E6750EF020D_impl*
 Result := aLeaf.IntA[k2_tiHandle] <> Ord(ev_sbtBookmark);
//#UC END# *49E48829016F_4E6750EF020D_impl*
end;//TevdDocumentBookmarksEliminator.NeedWritePara

end.
