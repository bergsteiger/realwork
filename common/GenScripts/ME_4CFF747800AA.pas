unit nscConst;

// ������: "w:\common\components\gui\Garant\Nemesis\nscConst.pas"
// ���������: "UtilityPack"

{$Include nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , Graphics
;

const
 cDefaultContextEmptyColor = Graphics.clGrayText;
 cPlusKeyCode = 188;
 cMinusKeyCode = 189;
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
