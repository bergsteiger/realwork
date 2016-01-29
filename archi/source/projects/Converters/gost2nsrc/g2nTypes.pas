unit g2nTypes;

{ $Id: g2nTypes.pas,v 1.1 2015/02/04 12:18:31 fireton Exp $ }

interface

type
 Tg2nGetDocIDEvent = procedure (out theDocID: Integer) of object;
 Tg2nGetTitleEvent = procedure (out theTitle: string) of object;

implementation

end.