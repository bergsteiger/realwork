unit nsRootManager;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsRootManager.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3PureMixIns
 , DynamicTreeUnit
 , l3Core
 , l3Interfaces
 , l3NotifyPtrList
 , l3IID
;

type
 _l3Changing_Parent_ = Tl3CProtoObject;
 {$Include l3Changing.imp.pas}
 _nsRootManager_Parent_ = _l3Changing_;
 {$Include nsRootManager.imp.pas}
 _l3COMQueryInterface_Parent_ = _nsRootManager_;
 {$Include l3COMQueryInterface.imp.pas}
 TnsRootManager = class(_l3COMQueryInterface_)
 end;//TnsRootManager

implementation

uses
 l3ImplUses
 , nsTypes
 , Classes
 , Windows
 , l3Base
 , Messages
 , l3Interlocked
 , l3Types
 , SysUtils
 , l3InterfacesMisc
;

{$Include l3Changing.imp.pas}

{$Include nsRootManager.imp.pas}

{$Include l3COMQueryInterface.imp.pas}

end.
