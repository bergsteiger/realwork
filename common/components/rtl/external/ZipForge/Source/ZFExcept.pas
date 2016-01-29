unit ZFExcept;

{$I ZFVer.Inc}

interface

uses SysUtils, Classes;

type
  EZFException = class(Exception)
  public
    ErrorCode:   integer;
    NativeError: integer;

    constructor Create(NativeErr: integer; Component: TComponent = nil); overload;
    constructor Create(NativeErr: integer; const Args: array of const;
      Component: TComponent = nil); overload;
  end;

implementation

uses ZFConst;

constructor EZFException.Create(NativeErr: integer; Component: TComponent = nil);
var
  ErMessage, s: string;
  i: integer;
begin
  NativeError := NativeErr;

  ErrorCode := ErUnknownError;
  for i := 0 to ZFMaxNativeError do
    if (ZFNativeToErrorCode[i][0] = NativeErr) then
    begin
      ErrorCode := ZFNativeToErrorCode[i][1];
      break;
    end;
  ErMessage := ZFErrorMessages[ErrorCode];
  if Assigned(Component) and (Component.Name <> '') then
    ErMessage := Format('%s: %s', [Component.Name, ErMessage]);

  s := StringReplace(Format('%5d', [NativeError]), ' ', '0', [rfReplaceAll]);
  ErMessage := ErMessage + ' - Native error: ' + s;
  inherited Create(ErMessage);
end;


constructor EZFException.Create(NativeErr: integer; const Args: array of const;
  Component: TComponent = nil);
var
  ErMessage, s: string;
  i: integer;
begin
  NativeError := NativeErr;

  ErrorCode := ErUnknownError;
  for i := 0 to ZFMaxNativeError do
    if (ZFNativeToErrorCode[i][0] = NativeErr) then
    begin
      ErrorCode := ZFNativeToErrorCode[i][1];
      break;
    end;
  ErMessage := ZFErrorMessages[ErrorCode];
  ErMessage := Format(ErMessage, Args);
  if Assigned(Component) and (Component.Name <> '') then
    ErMessage := Format('%s: %s', [Component.Name, ErMessage]);

  s := StringReplace(Format('%5d', [NativeError]), ' ', '0', [rfReplaceAll]);
  ErMessage := ErMessage + ' - Native error: ' + s;
  inherited Create(ErMessage);
end;

end.
