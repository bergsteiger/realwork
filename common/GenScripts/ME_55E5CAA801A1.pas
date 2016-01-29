unit l3CStringDataObject;

interface

uses
 l3IntfUses
 , l3StorableDataObject
 , l3Interfaces
;

type
 Tl3CStringDataObject = class(Tl3StorableDataObject, Il3DataObjectInfo)
  procedure Create(const aString: Il3CString);
  function Make(const aString: Il3CString): IDataObject;
  function IsQuestionNeedBeforeFlush: Boolean;
  function Store(aFormat: Tl3ClipboardFormat;
   const aPool: IStream): Boolean;
 end;//Tl3CStringDataObject
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3_String
 , l3Chars
 , l3String
;

end.
