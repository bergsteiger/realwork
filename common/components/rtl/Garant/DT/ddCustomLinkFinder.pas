unit ddCustomLinkFinder;

{ $Id: ddCustomLinkFinder.pas,v 1.2 2016/07/18 10:49:49 fireton Exp $ }

interface

uses
 l3Interfaces,
 l3ProtoObject,
 l3Date,
 ddTypes,
 ddAutolinkTypes,
 dt_Types;

type
 TddCustomLinkFinder = class(Tl3ProtoObject)
 protected
  f_OnError: TddErrorEvent;
 protected
  procedure pm_SetOnError(const Value: TddErrorEvent); virtual;
 public
  procedure Done; virtual; abstract;
  procedure DoOnNewDocument; virtual;
  procedure FindLinks(const aText     : string;    // text from master doc
                      aDocID          : TDocID;    // master doc id
                      aDocDate        : TStDate;   // master doc date
                      const aCaseCode : Il3CString; // casecode
                      aLinkProc       : TddLinkSetRoutine); virtual; abstract;
  procedure Init; virtual; abstract;
  property OnError: TddErrorEvent read f_OnError write pm_SetOnError;
 end;

implementation

procedure TddCustomLinkFinder.DoOnNewDocument;
begin
 // empty in base class
end;

procedure TddCustomLinkFinder.pm_SetOnError(const Value: TddErrorEvent);
begin
 f_OnError := Value;
end;

end.