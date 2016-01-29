unit ddPicturePathListner;

interface

uses
 l3IntfUses
 , l3SimpleObject
 , l3VCLStrings
 , l3ProtoObject
 , l3PicturePathService
;

type
 TddPicturePathService = class(Tl3ProtoObject, Il3PicturePathService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure SetTestName(const aName: AnsiString);
  procedure AddPicturePath(const aPath: AnsiString);
  procedure SetEnableSave(aValue: Boolean);
  procedure SetPDF4Etalon(aValue: Boolean);
 end;//TddPicturePathService
 
 TddPicturePathListner = class(Tl3SimpleObject)
  procedure AddPicturePath(const aPath: AnsiString);
  procedure Clear;
  function PathCount: Integer;
  function GetPath(anIndex: Integer): AnsiString;
  function Exists: Boolean;
  function GetUniqPictureName(aForRTF: Boolean): AnsiString;
  function GetUniqPictureNameWithPath(aFormat: Integer;
   aForRTF: Boolean): AnsiString;
  function CorrectCVSPath(const aStartPath: AnsiString;
   const aOtherPath: AnsiString): AnsiString;
 end;//TddPicturePathListner
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ddConst
 , ddUtils
;

end.
