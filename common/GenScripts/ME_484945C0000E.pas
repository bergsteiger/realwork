unit l3String_Wrap;
 {* Wl3String }

// Модуль: "w:\common\components\rtl\Garant\K2\l3String_Wrap.pas"
// Стереотип: "Wrapper"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , Persistent_Wrap
 , k2String_Const
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
;

end.
