unit k2Const;

// Модуль: "w:\common\components\rtl\Garant\K2\k2Const.pas"
// Стереотип: "Interfaces"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
;

const
 k2_TransparentValue = Pred(High(Long));
 k2_tiByIndex = Succ(l3_siNative);
 k2_tiSelfID = Succ(k2_tiByIndex);
 k2_tiVoid = k2_tiSelfID;
 k2_tiMask = Succ(k2_tiSelfID);
 k2_tiNative = l3_siNative;

implementation

uses
 l3ImplUses
;

end.
