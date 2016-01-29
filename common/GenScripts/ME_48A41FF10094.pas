unit Windows;

interface

uses
 l3IntfUses
 , Types
;

type
 PLongint = System.PLongint;
 
 hWnd = type Cardinal;
 
 HPALETTE = type Cardinal;
 
 HMETAFILE = type Cardinal;
 
 HFONT = type Cardinal;
 
 BOOL = Integer;
 
 PInteger = ^Integer;
 
 LPARAM = Integer;
 
 WPARAM = Integer;
 
 hRgn = Cardinal;
  {* Регион. }
 
 HANDLE = Cardinal;
 
 THandle = HANDLE;
 
 HGLOBAL = THandle;
 
 TMsg = record
 end;//TMsg
 
 hDC = HANDLE;
  {* Контекст устройства вывода. }
 
 TPoint = record
  {* Точка. }
 end;//TPoint
 
 HHOOK = HANDLE;
 
 TTextMetric = record
 end;//TTextMetric
 
 PTextMetric = TTextMetric;
  {* Указатель на TTextMetric. }
 
 TDeviceModeA = record
 end;//TDeviceModeA
 
 PDeviceModeA = ^TDeviceModeA;
 
 PDeviceMode = PDeviceModeA;
 
 DWORD = Types.DWORD;
 
 TRTLCriticalSection = record
 end;//TRTLCriticalSection
 
 UINT = LongWord;
 
 LCID = Cardinal;
  {* Идентификатор локали. }
 
 HWND = hWnd;
 
 TCWPStruct = record
 end;//TCWPStruct
 
 PCWPStruct = ^TCWPStruct;
 
 TInput = record
 end;//TInput
 
 TCWPRetStruct = record
 end;//TCWPRetStruct
 
 PCWPRetStruct = ^TCWPRetStruct;
 
 TMouseHookStruct = record
 end;//TMouseHookStruct
 
 PMouseHookStruct = ^TMouseHookStruct;
 
 LRESULT = Integer;
 
 TBlendFunction = record
 end;//TBlendFunction
 
 TScrollInfo = record
 end;//TScrollInfo
 
 PMsg = ^TMsg;
 
 TEnhMetaHeader = ;
 
 TFileTime = record
 end;//TFileTime
 
 TMetaHeader = ;
 
 TSmallRect = record
 end;//TSmallRect
 
 PSmallRect = ^TSmallRect;
 
 HCURSOR = ;
 
implementation

uses
 l3ImplUses
;

end.
