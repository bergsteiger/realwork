unit l3ProtoObjectWithHandle;

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProtoObjectWithHandle.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Types
;

type
 Tl3ProtoObjectWithHandle = class(Tl3ProtoObject)
  protected
   function pm_GetHandle: Tl3Handle; virtual; abstract;
   procedure pm_SetHandle(aValue: Tl3Handle); virtual; abstract;
  public
   function CompareWith(anOther: Tl3ProtoObjectWithHandle): Integer; virtual; abstract;
  public
   property Handle: Tl3Handle
    read pm_GetHandle
    write pm_SetHandle;
 end;//Tl3ProtoObjectWithHandle

implementation

uses
 l3ImplUses
;

end.
