unit ddExportFilerDispatcherElem;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddPipeOutInterfaces
 , l3Interfaces
 , l3Filer
;

type
 TddExportFilerDispatcherElem = class(Tl3ProtoObject, IddExportFilerDispatcherElem)
  procedure Create(const aFileMask: Il3CString;
   aCodePage: Integer;
   aPartSize: Integer;
   aUpdateFiles: Boolean);
  function Make(const aFileMask: Il3CString;
   aCodePage: Integer;
   aPartSize: Integer;
   aUpdateFiles: Boolean): IddExportFilerDispatcherElem;
  function Filer: Tl3CustomFiler;
  procedure RollBack;
 end;//TddExportFilerDispatcherElem
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , l3Types
 , Classes
 , l3Base
;

end.
