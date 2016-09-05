unit ddAutolinkTypes;

{ $Id: ddAutolinkTypes.pas,v 1.3 2016/08/24 09:11:13 fireton Exp $ }

interface
uses
 l3Except,
 dt_Types;

type
 TddLinkSetRoutine = procedure (aFrom, aTo : Integer;
                                aDocID     : TDocID;
                                aBlockID   : Longint;
                                aLinkMsg   : string) of object;

 EddAutolinkError = class(El3Error);

implementation

end.