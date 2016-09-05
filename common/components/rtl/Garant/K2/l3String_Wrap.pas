unit l3String_Wrap;
 {* Wl3String }

// Модуль: "w:\common\components\rtl\Garant\K2\l3String_Wrap.pas"
// Стереотип: "Wrapper"
// Элемент модели: "Wl3String" MUID: (484945C0000E)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , Persistent_Wrap
;

type
 Wl3String = class(WPersistent)
  {* Wl3String }
 end;//Wl3String

implementation

uses
 l3ImplUses
 , l3_String
 , l3CustomString
 , SysUtils
 , k2String
 , k2String_Const
 //#UC START# *484945C0000Eimpl_uses*
 //#UC END# *484945C0000Eimpl_uses*
;

end.
