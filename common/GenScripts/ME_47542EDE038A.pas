unit eeTextSourceExport;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , nevTools
;

type
 TeeMakeDocumentContainerEvent = procedure(Sender: TObject;
  var aMade: InevDocumentContainer) of object;
 
 TeeTextSourceExport = class(IvcmState)
  function SaveState(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadState(const theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
 end;//TeeTextSourceExport
 
implementation

uses
 l3ImplUses
;

end.
