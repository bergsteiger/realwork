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
   {* ������� ��������� ������. }
  function Make(const aCaption: IafwCString;
   anAttachWnd: THandle;
   anInitialTimeout: Cardinal;
   anImageList: TafwCustomImageList;
   anImageIndex: Integer): IafwLongProcessVisualizer;
   {* ������� ��������� ������ � ���� ���������� IafwLongProcessVisualizer. }
 end;//TafwLongProcessVisualizer
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
