unit evdTasksHelpers;

interface

uses
 l3IntfUses
 , l3LongintList
 , l3Interfaces
 , Address_Const
 , Classes
 , l3ProtoObject
 , l3Variant
 , k2SizedMemoryPool
 , TaskID_Const
;

 (*
 MIntegerListTransformator = interface
  procedure ToList(aDest: Tl3LongintList);
  procedure FromList(aSource: Tl3LongintList); overload;
  procedure FromList(const aSource: Il3IntegerList); overload;
  function AsIntegerList: Il3IntegerList;
 end;//MIntegerListTransformator
 *)
 
type
 DocumentIDListHelper = interface
  procedure Save(aStream: TStream);
  procedure Load(aStream: TStream);
  procedure Clear;
  procedure Add(anItem: Integer);
  procedure Remove(anItem: Integer);
  procedure ToList(aDest: Tl3LongintList);
  procedure FromList(aSource: Tl3LongintList); overload;
  procedure FromList(const aSource: Il3IntegerList); overload;
  function AsIntegerList: Il3IntegerList;
 end;//DocumentIDListHelper
 
 StringListHelper = interface
  procedure Add(const anItem: AnsiString);
  procedure CopyTo(aDest: TStrings);
  procedure CopyFrom(aSource: TStrings);
 end;//StringListHelper
 
 TevdTagHelper = class(Tl3ProtoObject)
  procedure Create(aValue: Tl3Tag);
 end;//TevdTagHelper
 
 SABStreamHelper = interface(DocumentIDListHelper)
  procedure CopyFrom(Source: TStream;
   Count: Int64);
  procedure CopyTo(Dest: TStream;
   Count: Int64);
 end;//SABStreamHelper
 
 TAbstractStringListHelper = class(TevdTagHelper, StringListHelper)
  procedure DoAdd(const anItem: AnsiString);
  function DoGetStrings(anIndex: Integer): AnsiString;
  function Count: Integer;
  function Strings: AnsiString;
  procedure Add(const anItem: AnsiString);
  procedure CopyTo(aDest: TStrings);
  procedure CopyFrom(aSource: TStrings);
 end;//TAbstractStringListHelper
 
 RegionIDListHelper = DocumentIDListHelper;
 
 TasksIDListHelper = interface(StringListHelper)
 end;//TasksIDListHelper
 
 TDocumentIDListHelper = class(TevdTagHelper, DocumentIDListHelper)
  function Make(aValue: Tl3Tag): DocumentIDListHelper;
  procedure Save(aStream: TStream);
  procedure Load(aStream: TStream);
  procedure Clear;
  procedure Add(anItem: Integer);
  procedure Remove(anItem: Integer);
  function Count: Integer;
  function Items: Integer;
  procedure ToList(aDest: Tl3LongintList);
  procedure FromList(aSource: Tl3LongintList); overload;
  procedure FromList(const aSource: Il3IntegerList); overload;
  function AsIntegerList: Il3IntegerList;
 end;//TDocumentIDListHelper
 
 AccGroupsIDListHelper = DocumentIDListHelper;
 
 TAccGroupsIDListHelper = TDocumentIDListHelper;
 
 TImportedDocListHelper = TDocumentIDListHelper;
 
 ImportedDocListHelper = DocumentIDListHelper;
 
 TSourceIDListHelper = TDocumentIDListHelper;
 
 SourceIDListHelper = DocumentIDListHelper;
 
 TDossierSourceIDListHelper = TDocumentIDListHelper;
 
 DossierSourceIDListHelper = DocumentIDListHelper;
 
 TDocTypesIDListHelper = TDocumentIDListHelper;
 
 DocTypesIDListHelper = DocumentIDListHelper;
 
 TFASSourceIDListHelper = TDocumentIDListHelper;
 
 FASSourceIDListHelper = DocumentIDListHelper;
 
 TRegionIDListHelper = TDocumentIDListHelper;
 
 TBelongsIDListHelper = TDocumentIDListHelper;
 
 BelongsIDListHelper = DocumentIDListHelper;
 
 ExcludeAccGroupsIDListHelper = DocumentIDListHelper;
 
 TExcludeAccGroupsIDListHelper = TDocumentIDListHelper;
 
 CommentsIDListHelper = DocumentIDListHelper;
 
 TCommentsIDListHelper = TDocumentIDListHelper;
 
 ExcludeDocTypesIDListHelper = DocumentIDListHelper;
 
 TExcludeDocTypesIDListHelper = TDocumentIDListHelper;
 
 ExcludeDocBasesIDListHelper = DocumentIDListHelper;
 
 TExcludeDocBasesIDListHelper = TDocumentIDListHelper;
 
 BasesIDListHelper = DocumentIDListHelper;
 
 TBasesIDListHelper = TDocumentIDListHelper;
 
 TInfoIDListHelper = TDocumentIDListHelper;
 
 InfoIDListHelper = DocumentIDListHelper;
 
 TSABStreamHelper = class(TDocumentIDListHelper, SABStreamHelper)
  function Make(aValue: Tl3Tag): SABStreamHelper;
  procedure CopyFrom(Source: TStream;
   Count: Int64);
  procedure CopyTo(Dest: TStream;
   Count: Int64);
  function Size: Int64;
 end;//TSABStreamHelper
 
 TTasksIDListHelper = class(TAbstractStringListHelper, TasksIDListHelper)
  function Make(aValue: Tl3Tag): TasksIDListHelper;
  procedure DoAdd(const anItem: AnsiString);
  function DoGetStrings(anIndex: Integer): AnsiString;
 end;//TTasksIDListHelper
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , l3InterfacedIntegerList
;

end.
