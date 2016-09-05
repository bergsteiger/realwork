unit ddBaseAutolinkDataSource;

{ $Id: ddBaseAutolinkDataSource.pas,v 1.5 2016/08/24 09:11:09 fireton Exp $ }

interface

uses
 l3Date, l3LongintList, l3ProtoObject, l3Types, l3Except,
 DT_Types,
 ddTypes, ddDocStructBase,
 ddAutolinkInterfaces;

type
 EddAutoLinkDataSourceError = class(El3Exception);

type
 TddBaseAutolinkDataSource = class(Tl3ProtoObject)
 private
  f_OnError: TddErrorEvent;
 protected
  procedure DoError(const aMessage: AnsiString);
  function DoGetContemporalEdition(const aExtDocID: TDocID; const aDate: TStDate): TddALDocRec; virtual; abstract;
 public
  constructor Create(aOnError: TddErrorEvent);
  function GetContemporalEdition(const aExtDocID: TDocID; const aDate: TStDate): TddALDocRec;
  procedure DocumentAlreadyDefined; virtual;
  procedure StartDocQuery; virtual; abstract; // начало подготовки запроса
  procedure FilterByDocType(aDocType: TDictID); virtual; abstract;
  procedure FilterByCasecode(const aCaseCode: Tl3PCharLen); virtual; abstract;
  procedure FilterByDateNum(aDate: TStDate; const aNum: Tl3PCharLen); virtual; abstract;
  procedure FilterBySources(const aSources: Tl3LongintList); virtual; abstract;
  procedure FilterByActualEditions; virtual; abstract;
  function  FindBlock(const aDocID: TDocID; const aEntryAddr: TddDocStructElementRec): Longint; virtual; abstract;
  function  ExecuteDocQuery: TddALDocRec; virtual; abstract;  // cBlankDocID         = "не найдено"
                                                              // TDocID(cUndefDocID) = "неоднозначно определён"
  procedure CleanupDocQuery; virtual; abstract; // "подчистка" за запросом
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;


implementation
uses
 l3Base
 {$IFNDEF NotArchi}
 ,daSchemeConsts,
 DT_Const,
 DT_LinkServ
 {$ENDIF}
 ;

constructor TddBaseAutolinkDataSource.Create(aOnError: TddErrorEvent);
begin
 inherited Create;
 f_OnError := aOnError;
end;

procedure TddBaseAutolinkDataSource.DocumentAlreadyDefined;
begin
 // empty in base class
end;

procedure TddBaseAutolinkDataSource.DoError(const aMessage: AnsiString);
begin
 if Assigned(f_OnError) then
  f_OnError(aMessage)
 else
  l3System.Msg2Log(aMessage); 
end;

//** TddBaseAutolinkDataSource **//

function TddBaseAutolinkDataSource.GetContemporalEdition(const aExtDocID: TDocID; const aDate: TStDate): TddALDocRec;
begin
 Result := DoGetContemporalEdition(aExtDocID, aDate);
end;

end.
