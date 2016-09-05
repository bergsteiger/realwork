unit dt_DictTypes;

interface
Uses
 daInterfaces,
 daTypes,
 
 dt_Types,
 dt_Const,
 dt_AttrSchema,

 l3Date, dt_DictConst;

type
 PDictRec = ^TDictRec;
 TDictRec = record
  rDocID   : TDocID;
  rDictID  : TDictID;
  rSubID   : TSubID;
 end;

 PDictMessageRec = ^TDictMessageRec;
 TDictMessageRec = record
                    Family      : TdaFamilyID;
                    DictType    : TdaDictionaryType;
                    Operation   : TOperActionType;
                    ID,
                    ParentID,
                    NextID      : TDictID;
                   end;

 PDNDictRec = ^TDNDictRec;
 TDNDictRec = packed record
               ID      : TDictID;
               Date    : TStDate;
               Num     : TNumberStr;
               Typ     : TDNType;
               LDocID  : TDocID;
               {$IF c_DocBaseVersion > 133}
               LSubID  : TSubID;
               {$IFEND}
              end;

 TDNDictRecEx = packed record
                 ID      : LongWord;
                 Date    : LongWord;
                 Num     : TNumberStr;
                 Typ     : Byte;
                 LDocID  : Longword;
                 {$IF c_DocBaseVersion > 133}
                 LSubID  : Longword;
                 {$IFEND}
                end; // реально соответствующий структуре записи в таблице БД

 PCorrectDictRec = ^TCorrectDictRec;
 TCorrectDictRec = packed record
                    ID      : TDictID;
                    Date    : TStDate;
                    Sour    : TDictID;
                    Typ     : TCorType;
                    Author  : TdaUserID;
                    Comment : Array[1..70] of Char;
                   end;

 PPublishedDictRec = ^TPublishedDictRec;
 TPublishedDictRec = packed record
                      ID      : TDictID;
                      Sour    : TDictID;
                      SDate   : TStDate;
                      EDate   : TStDate;
                      Num     : Array[1..cPublInNumLen] of Char;
                      Comment : array[1..70] of Char;
                     end;

 PPublishedUniqueKeyRec = ^TPublishedDictRec;
 TPublishedUniqueKeyRec = packed record
                      Sour    : TDictID;
                      SDate   : TStDate;
                      EDate   : TStDate;
                      Num     : Array[1..cPublInNumLen] of Char;
                     end;

 PSourDictRec = ^TSourDictRec;
 TSourDictRec = packed record
                 FNameR    : Array[1..cSourceNameLen] of Char;
                 FNameE    : Array[1..cSourceNameLen] of Char;
                 SName     : Array[1..cSourceShortNameLen] of Char;
                 Sinon     : Array[1..cSourceSynonimsLen] of Char;
                end;
(*
 PNewClassDictRec = ^TNewClassDictRec;
 TNewClassDictRec = packed record
                     FNameR     : Array[1..200] of Char;
                     FNameE     : Array[1..200] of Char;
                     Flag       : Byte;
                     NewID      : TDictID;
                     Comment    : Array[1..500] of Char;
                    end;
*)
 IDictChangeNotifyRecipient = interface(IUnknown)
     ['{47342B12-03EF-45E9-8CCD-824E2F0A5529}']
  procedure dcn_DictionaryChange(const Info : TDictMessageRec);
 end;


implementation

end.
 