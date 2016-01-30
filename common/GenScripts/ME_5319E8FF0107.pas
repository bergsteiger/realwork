unit l3DataContainerWithoutIUnknownPrim;

// ������: "w:\common\components\rtl\Garant\L3\l3DataContainerWithoutIUnknownPrim.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3CastablePersistent
 , l3PureMixIns
 , l3IID
 , l3Interfaces
;

 {$Define l3Unknown_NoIUnknown}

 {$Undef l3Unknown_NoMultiThread}

type
 _l3Unknown_Parent_ = Tl3CastablePersistent;
 {$Include l3Unknown.imp.pas}
 _l3DataContainer_Parent_ = _l3Unknown_;
 {$Include l3DataContainer.imp.pas}
 _l3COMQueryInterface_Parent_ = _l3DataContainer_;
 {$Include l3COMQueryInterface.imp.pas}
 Tl3DataContainerWithoutIUnknownPrim = {abstract} class(_l3COMQueryInterface_)
 end;//Tl3DataContainerWithoutIUnknownPrim

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
 , l3InterfacesMisc
;

{$Include l3Unknown.imp.pas}

{$Include l3DataContainer.imp.pas}

{$Include l3COMQueryInterface.imp.pas}

end.
