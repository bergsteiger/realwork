unit afwLongProcessVisualizer;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , afwInterfaces
 , l3AsincMessageWindow
;

type
 TafwLongProcessVisualizer = class(Tl3ProtoObject, IafwLongProcessVisualizer)
  procedure Create(const aCaption: IafwCString;
   anAttachWnd: THandle;
   anInitialTimeout: Cardinal;
   anImageList: TafwCustomImageList;
   anImageIndex: Integer);
   {* Создает экземпляр класса. }
  function Make(const aCaption: IafwCString;
   anAttachWnd: THandle;
   anInitialTimeout: Cardinal;
   anImageList: TafwCustomImageList;
   anImageIndex: Integer): IafwLongProcessVisualizer;
   {* Создает экземпляр класса в виде интерфейса IafwLongProcessVisualizer. }
 end;//TafwLongProcessVisualizer
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
