unit evNative_Schema;
 {* ������ ����� EVD-���������� }

// ������: "w:\common\components\gui\Garant\Everest\evNative_Schema.pas"
// ���������: "TagTable"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdNative_Schema
;

type
 // TevNativeSchema

implementation

uses
 l3ImplUses
 , Bookmark_Const
 , Mark_Const
 , evQueryCardInt
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evNative_AttrValues
;

initialization
 TevNativeSchema.SetAsDefault;

end.
