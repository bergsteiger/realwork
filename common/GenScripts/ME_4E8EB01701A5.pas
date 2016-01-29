unit ddAutolinkDocEntry;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddAutolinkInterfaces
 , l3LongintList
 , l3Date
 , l3Interfaces
 , ddBaseAutoLinkDataSource
 , l3Types
;

type
 TddAutolinkDocEntry = class(Tl3ProtoObject, IddAutolinkDocEntry)
  procedure Create(aDocType: Integer;
   aDate: TStDate;
   const aNum: Tl3PCharLen;
   aSources: Tl3LongintList;
   const aDocID: TddALDocRec);
  function Make(aDocType: Integer;
   aDate: TStDate;
   const aNum: Tl3PCharLen;
   aSources: Tl3LongintList;
   const aDocID: TddALDocRec): IddAutolinkDocEntry;
  function Sources: Integer;
  function DocType: Integer;
  function Num: Il3CString;
  function Date: TStDate;
  procedure AddSource(aSource: Integer);
  procedure DelSource(anIndex: Integer);
  procedure Clear;
   {* очищает все данные }
  function SourceCount: Integer;
  function IsEmpty: Boolean;
   {* ≈сли нет никаких данных... }
  function IsSame(const anEntry: IddAutolinkDocEntry): Boolean;
  function SourcesIdenticalTo(const anEntry: IddAutolinkDocEntry): Boolean;
  function Clone: IddAutolinkDocEntry;
  function DocID: TddALDocRec;
 end;//TddAutolinkDocEntry
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Base
;

end.
