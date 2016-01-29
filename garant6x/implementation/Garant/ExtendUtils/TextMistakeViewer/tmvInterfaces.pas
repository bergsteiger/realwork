unit tmvInterfaces;

interface

uses
 SysUtils,
 Classes,

 l3Interfaces
 ;

type
 TtmvRecordKind = (
  rkNewRareWord,
  rkHumanMistake,
  rkScanerMistake,
  rkUnknownMistake,
  rkWrongText,
  rkNewRegularWord,
  rkVariant,
  rkAbbreviation
 );

type
 ItmvRecord = interface(IUnknown)
  ['{A019B551-9D8A-4800-9E7E-C9DED38B6FDC}']
  function pm_GetCaption: Il3CString;
    {-}
  function pm_GetFrequency: Il3CString;
    {-}
  function pm_GetMistakeKind: TtmvRecordKind;
  procedure pm_SetMistakeKind(aValue: TtmvRecordKind);
    {-}
  function pm_GetInfo: String;
  procedure pm_SetInfo(const aValue: String);
    {-}
  function pm_GetContext: Il3CString;
    {-}
  function pm_GetModified: Boolean;
    {-}
  function pm_CanWriteInfo: Boolean;
    {-}
  property Caption: Il3CString
     read pm_getCaption;
    {-}
  property Frequency: Il3CString
     read pm_getFrequency;
    {-}
  property MistakeKind: TtmvRecordKind
     read pm_GetMistakeKind
    write pm_SetMistakeKind;
    {-}
  property Context: Il3CString
     read pm_GetContext;
    {-}
  property Modified: Boolean
     read pm_GetModified;
    {-}
  property Info: String
    read pm_GetInfo
    write pm_SetInfo;

  property CanWriteInfo: Boolean
    read pm_CanWriteInfo;
    {-}
 end;//ItmvRecord

 ItmvRecordOffsets = interface(IUnknown)
  ['{D30C4EA1-DBBF-41CE-823A-98C2DE04CF3D}']
  function pm_GetStartOffset: Int64;
    {-}
  function pm_GetEndOffset: Int64;
    {-}
  property StartOffset: Int64
     read pm_GetStartOffset;
    {-}
  property EndOffset: Int64
     read pm_GetEndOffset;
    {-}
 end;//ItmvRecordOffsets

 ItmvRecordInfo = interface(ItmvRecordOffsets)
  ['{4E43F62E-8022-4665-96B2-A8227218AB40}']
  function pm_GetRecordIndex: Cardinal;
    {-}
  procedure SaveData(const aStream: TStream);
    {-}
  property RecordIndex: Cardinal
     read pm_GetRecordIndex;
    {-}
 end;//ItmvRecordInfo

 ItmvController = interface(IUnknown)
  ['{0CE51DB7-D5CC-4958-81F5-E51C05B27297}']
  function pm_GetCurrent: ItmvRecord;
    {-}
  function pm_GetProgressCaption: Il3CString;
    {-}
  procedure Prev;
    {-}
  procedure Next;
    {-}
  function CanPrev: Boolean;
    {-}
  function CanNext: Boolean;
    {-}
  property Current: ItmvRecord
     read pm_GetCurrent;
    {-}
  property ProgressCaption: Il3CString
     read pm_GetProgressCaption;
 end;//ItmvController

 EtvmEndOfFile = class(Exception);
 EtvmInvalidFileFormat = class(Exception);

const
 c_tvmCodePage = CP_OEM;
 c_tvmMaxInfoLength = 40;

implementation

end.

