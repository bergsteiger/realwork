unit evdScriptHyperlinkEliminator;
 {* ������, ���������� ������ �� ������� }

// ������: "w:\common\components\gui\Garant\Everest\evdScriptHyperlinkEliminator.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdHyperlinkEliminator
 , l3Variant
;

type
 TevdScriptHyperlinkEliminator = class(TevdHyperlinkEliminator)
  {* ������, ���������� ������ �� ������� }
  protected
   function NeedWritePara(aLeaf: Tl3Variant): Boolean; override;
    {* ���������� ����� �� ����������� ���������� ����� }
 end;//TevdScriptHyperlinkEliminator

implementation

uses
 l3ImplUses
 , k2Tags
 , l3String
 , evdTypes
;

function TevdScriptHyperlinkEliminator.NeedWritePara(aLeaf: Tl3Variant): Boolean;
 {* ���������� ����� �� ����������� ���������� ����� }
//#UC START# *49E48829016F_4F352A840264_var*
//#UC END# *49E48829016F_4F352A840264_var*
begin
//#UC START# *49E48829016F_4F352A840264_impl*
 Result := True;
 if Result then
  if l3Starts('script:', aLeaf.PCharLenA[k2_tiURL]) OR
     ((aLeaf.ChildrenCount > 0) AND
      (aLeaf.Child[0].IntA[k2_tiType] = CI_SCRIPT)) then
   Result := false
  else
   Result := true;
//#UC END# *49E48829016F_4F352A840264_impl*
end;//TevdScriptHyperlinkEliminator.NeedWritePara

end.
