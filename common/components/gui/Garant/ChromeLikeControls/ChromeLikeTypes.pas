unit ChromeLikeTypes;

interface
uses
 Windows,
 Types,
 Graphics;

type
 PTITLEBARINFOEX = ^TITLEBARINFOEX;
 tagTITLEBARINFOEX = record
  cbSize: DWORD;
  rcTitleBar: TRect;
  rgstate: packed array[0..CCHILDREN_TITLEBAR] of DWORD;
  rgrect: packed array[0..CCHILDREN_TITLEBAR] of TRect;
 end;
 TITLEBARINFOEX = tagTITLEBARINFOEX;
 TTitleBarInfoEx = TITLEBARINFOEX;

 TVistaWindowCaptionMetrics = record
  rTitleBarInfo: TTitleBarInfoEx;
  rWindowRect: TRect;
 end;

 TGradientDirection = (gdVertical, gdHorizontal);

 TWindowZOrderInfo = record
  rHWndBackground: HWND;
  rHWndForeground: HWND;
 end;

const
 WM_GETTITLEBARINFOEX = $033F;
 WM_DWMCOMPOSITIONCHANGED = $031E;
 WM_SYNCPAINT = $0088;

 BS_INACTIVE = 5; // недокументированный флаг для рисования неактивной кнопки
                  // в заголовке окна
 SWP_STATECHANGED = $8000;


implementation

end.