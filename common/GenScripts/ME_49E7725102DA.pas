unit l3ProtoPersistent;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoPersistent.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3CastablePersistent
 , l3PureMixIns
;

type
 _l3Unknown_Parent_ = Tl3CastablePersistent;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 Tl3ProtoPersistent = {abstract} class(_l3Unknown_)
 end;//Tl3ProtoPersistent

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

end.
