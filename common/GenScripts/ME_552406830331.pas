unit l3PicturePathService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3PicturePathService = interface
  {* Контракт сервиса Tl3PicturePathService }
  procedure SetEnableSave(aValue: Boolean);
  procedure SetPDF4Etalon(aValue: Boolean);
  procedure AddPicturePath(const aPath: AnsiString);
  procedure SetTestName(const aName: AnsiString);
 end;//Ml3PicturePathService
 *)
 
type
 Il3PicturePathService = interface
  {* Интерфейс сервиса Tl3PicturePathService }
  procedure SetEnableSave(aValue: Boolean);
  procedure SetPDF4Etalon(aValue: Boolean);
  procedure AddPicturePath(const aPath: AnsiString);
  procedure SetTestName(const aName: AnsiString);
 end;//Il3PicturePathService
 
 Tl3PicturePathService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure SetTestName(const aName: AnsiString);
  procedure AddPicturePath(const aPath: AnsiString);
  procedure SetEnableSave(aValue: Boolean);
  procedure SetPDF4Etalon(aValue: Boolean);
 end;//Tl3PicturePathService
 
implementation

uses
 l3ImplUses
 , PictureEtalonsWorkingPack
;

end.
