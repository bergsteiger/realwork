Unit arTypes;

interface

uses  Windows, Messages, SysUtils;

type
 EarSilent = class(Exception);

const
 WM_SHOWCHANGEDICTWARN  = WM_USER + 11;
 WM_SHOWMESSAGE         = WM_USER + 12;
 WM_SERVERSTATUSCHANGED = WM_USER + 13;

implementation
end.