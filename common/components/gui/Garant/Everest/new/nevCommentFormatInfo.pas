unit nevCommentFormatInfo;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevCommentFormatInfo.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevCommentFormatInfo" MUID: (4E5F3389001D)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevDocumentPartFormatInfo
 , l3Variant
;

type
 TnevCommentFormatInfo = class(TnevDocumentPartFormatInfo)
  protected
   procedure TuneFrameText(aText: Tl3Variant); override;
   function AllowTotalRecalc: Boolean; override;
 end;//TnevCommentFormatInfo

implementation

uses
 l3ImplUses
 , evdStyles
 , k2Tags
 //#UC START# *4E5F3389001Dimpl_uses*
 //#UC END# *4E5F3389001Dimpl_uses*
;

procedure TnevCommentFormatInfo.TuneFrameText(aText: Tl3Variant);
//#UC START# *4E5F8B2601DC_4E5F3389001D_var*
//#UC END# *4E5F8B2601DC_4E5F3389001D_var*
begin
//#UC START# *4E5F8B2601DC_4E5F3389001D_impl*
 aText.IntA[k2_tiStyle] := ev_saUserComment;
//#UC END# *4E5F8B2601DC_4E5F3389001D_impl*
end;//TnevCommentFormatInfo.TuneFrameText

function TnevCommentFormatInfo.AllowTotalRecalc: Boolean;
//#UC START# *4E7095FC023D_4E5F3389001D_var*
//#UC END# *4E7095FC023D_4E5F3389001D_var*
begin
//#UC START# *4E7095FC023D_4E5F3389001D_impl*
 Result := true;
//#UC END# *4E7095FC023D_4E5F3389001D_impl*
end;//TnevCommentFormatInfo.AllowTotalRecalc

end.
