{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBCommonTypes;

{$Z+}

interface

{ Db / SqlExpr }
type
  TLoginEvent = procedure(Sender: TObject; Username, Password: string) of object;

{ DBXpress / BDE }

type
  FLDVchk = (                           { Field Val Check type }
    fldvNOCHECKS,                       { Does not have explicit val checks }
    fldvHASCHECKS,                      { One or more val checks on the field }
    fldvUNKNOWN                         { Dont know at this time }
  );

type
  FLDRights = (                         { Field Rights }
    fldrREADWRITE,                      { Field can be Read/Written }
    fldrREADONLY,                       { Field is Read only }
    fldrNONE,                           { No Rights on this field }
    fldrUNKNOWN                         { Dont know at this time }
  );

type
  pCBType            = ^CBType;
  CBType = (                            { Call back type }
    cbGENERAL,                          { General purpose }
    cbRESERVED1,
    cbRESERVED2,
    cbINPUTREQ,                         { Input requested }
    cbRESERVED4,
    cbRESERVED5,
    cbBATCHRESULT,                      { Batch processing rslts }
    cbRESERVED7,
    cbRESTRUCTURE,                      { Restructure }
    cbRESERVED9,
    cbRESERVED10,
    cbRESERVED11,
    cbRESERVED12,
    cbRESERVED13,
    cbRESERVED14,
    cbRESERVED15,
    cbRESERVED16,
    cbRESERVED17,
    cbTABLECHANGED,                     { Table changed notification }
    cbRESERVED19,
    cbCANCELQRY,                        { Allow user to cancel Query }
    cbSERVERCALL,                       { Server Call }
    cbRESERVED22,
    cbGENPROGRESS,                      { Generic Progress report. }
    cbDBASELOGIN,                       { dBASE Login }
    cbDELAYEDUPD,                       { Delayed Updates }
    cbFIELDRECALC,                      { Field(s) recalculation }
    cbTRACE,                            { Trace }
    cbDBLOGIN,                          { Database login }
    cbDETACHNOTIFY,                     { DLL Detach Notification }
    cbNBROFCBS                          { Number of cbs }
  );

  CBRType = (                           { Call-back return type }
    cbrUSEDEF,                          { Take default action }
    cbrCONTINUE,                        { Continue }
    cbrABORT,                           { Abort the operation }
    cbrCHKINPUT,                        { Input given }
    cbrYES,                             { Take requested action }
    cbrNO,                              { Do not take requested action }
    cbrPARTIALASSIST,                   { Assist in completing the job }
    cbrSKIP,                            { Skip this operation }
    cbrRETRY                            { Retry this operation }
  );


{ DBClient / DBTables }
type 
  TKeyIndex = (kiLookup, kiRangeStart, kiRangeEnd, kiCurRangeStart,
    kiCurRangeEnd, kiSave);

implementation

end.
