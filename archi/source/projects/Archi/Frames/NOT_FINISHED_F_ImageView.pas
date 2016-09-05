unit NOT_FINISHED_F_ImageView;
 {* Фрейм для просмотра многостраничных TIFF }

// Модуль: "w:\archi\source\projects\Archi\Frames\NOT_FINISHED_F_ImageView.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "F_ImageView" MUID: (4F8D785201A4)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 {$If NOT Defined(NoImageEn)}
 , imageenview
 {$IfEnd} // NOT Defined(NoImageEn)
;

type
 TfrmImgViewer = class
  public
   PageView: TImageEnView;
 end;//TfrmImgViewer
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 //#UC START# *4F8D785201A4impl_uses*
 //#UC END# *4F8D785201A4impl_uses*
;
{$IfEnd} // Defined(AppClientSide)

end.
