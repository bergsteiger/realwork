unit eePicture;

interface

uses
 l3IntfUses
 , eePara
 , eeInterfaces
 , l3Interfaces
 , ActiveX
;

type
 TeePicture = class(TeePara, IeePicture)
  function Name: Il3CString;
  procedure SaveToStream(const aStream: IStream);
 end;//TeePicture
 
implementation

uses
 l3ImplUses
;

end.
