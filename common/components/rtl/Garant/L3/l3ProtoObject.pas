unit l3ProtoObject;

// ������: "w:\common\components\rtl\Garant\L3\l3ProtoObject.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3CastableObject
 , l3PureMixIns
;

type
 _l3Unknown_Parent_ = Tl3CastableObject;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 Tl3ProtoObject = {abstract} class(_l3Unknown_)
 end;//Tl3ProtoObject

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
