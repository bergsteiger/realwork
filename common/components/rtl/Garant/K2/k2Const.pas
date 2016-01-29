unit k2Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2Const.pas"
// Начат: 24.09.1998 12:09
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::K2::k2Const
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Types,
  l3Const
  ;

const
  { Tag Consts }
 k2_TransparentValue = Pred(High(Long));
 k2_tiByIndex = Succ(l3_siNative);
 k2_tiSelfID = Succ(k2_tiByIndex);
 k2_tiVoid = k2_tiSelfID;
 k2_tiMask = Succ(k2_tiSelfID);
 k2_tiNative = l3_siNative;

implementation

end.