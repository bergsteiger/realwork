unit NOT_FINISHED_F_ImageView;
 {* ����� ��� ��������� ��������������� TIFF }

// ������: "w:\archi\source\projects\Archi\Frames\NOT_FINISHED_F_ImageView.pas"
// ���������: "UtilityPack"

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
;
{$IfEnd} // Defined(AppClientSide)

end.
