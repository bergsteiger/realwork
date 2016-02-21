unit l3ProtoPersistentWithHandle;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoPersistentWithHandle.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoPersistent
 , l3Types
;

type
 Tl3ProtoPersistentWithHandle = class(Tl3ProtoPersistent)
  protected
   function pm_GetHandle: Tl3Handle; virtual; abstract;
   procedure pm_SetHandle(aValue: Tl3Handle); virtual; abstract;
  public
   function CompareWith(anOther: Tl3ProtoPersistentWithHandle): Integer; virtual; abstract;
  public
   property Handle: Tl3Handle
    read pm_GetHandle
    write pm_SetHandle;
 end;//Tl3ProtoPersistentWithHandle

implementation

uses
 l3ImplUses
;

end.
