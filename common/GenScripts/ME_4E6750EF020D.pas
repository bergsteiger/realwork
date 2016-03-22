unit evdDocumentBookmarksEliminator;

// ������: "w:\common\components\rtl\Garant\EVD\evdDocumentBookmarksEliminator.pas"
// ���������: "SimpleClass"
// ������� ������: "TevdDocumentBookmarksEliminator" MUID: (4E6750EF020D)

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

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
    {* ���������� ����� �� ����������� ���������� ����� }
 end;//TevdDocumentBookmarksEliminator

implementation

uses
 l3ImplUses
 , evdTypes
 , k2Tags
;

function TevdDocumentBookmarksEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* ���������� ����� �� ����������� ���������� ����� }
//#UC START# *49E48829016F_4E6750EF020D_var*
//#UC END# *49E48829016F_4E6750EF020D_var*
begin
//#UC START# *49E48829016F_4E6750EF020D_impl*
 Result := aLeaf.IntA[k2_tiHandle] <> Ord(ev_sbtBookmark);
//#UC END# *49E48829016F_4E6750EF020D_impl*
end;//TevdDocumentBookmarksEliminator.NeedWritePara

end.
