unit Block_Const;
 {* ������� ��������� ��������� }

// ������: "w:\common\components\gui\Garant\Everest\Block_Const.pas"
// ���������: "Tag"
// ������� ������: "Block" MUID: (4857A87D0337)
// ��� ����: "BlockTag"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , ParaList_Const
 , k2Handle_Const
 , k2Long_Const
 , k2Bool_Const
 , evdTypes
 , evdTextStyle_Const
 , Font_Const
;

 // BlockTag

implementation

uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evDocumentPart
 {$IfEnd} // Defined(k2ForEditor)
 , l3Defaults
;

end.
