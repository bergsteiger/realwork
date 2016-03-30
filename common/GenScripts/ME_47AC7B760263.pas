unit k2Const;

// Модуль: "w:\common\components\rtl\Garant\K2\k2Const.pas"
// Стереотип: "Interfaces"
// Элемент модели: "k2Const" MUID: (47AC7B760263)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Types
 , l3Const
;

const
 k2_TransparentValue = Pred(High(Integer));
 k2_tiByIndex = l3Types.l3_siNative + 1;
 k2_tiSelfID = Succ(k2_tiByIndex);
 k2_tiVoid = k2_tiSelfID;
 k2_tiMask = Succ(k2_tiSelfID);
 k2_tiNative = l3_siNative;

implementation

uses
 l3ImplUses
;

end.
