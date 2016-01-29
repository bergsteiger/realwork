unit nsUnknownComponentWithIvcmState.imp;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
;

type
 _nsUnknownComponentWithIvcmState_ = class(_nsUnknownComponent_, IvcmState)
  function DoLoadState(const theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function DoSaveState(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function SaveState(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadState(const theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
 end;//_nsUnknownComponentWithIvcmState_
 
implementation

uses
 l3ImplUses
;

end.
