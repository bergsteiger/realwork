unit vcmKeyDataListener.imp;

interface

uses
 l3IntfUses
 , l3InternalInterfaces
 , Classes
;

type
 _vcmKeyDataListener_ = class(Il3KeyDataListener)
  function NeedProcessKeyData(aKey: Byte;
   aShift: TShiftState): Boolean;
  procedure DoProcessKeyData(aKey: Byte;
   aShift: TShiftState);
  function ProcessKeyData(aKey: Byte;
   aShiftFlags: Byte): Boolean;
 end;//_vcmKeyDataListener_
 
implementation

uses
 l3ImplUses
 , Controls
 , Forms
;

end.
