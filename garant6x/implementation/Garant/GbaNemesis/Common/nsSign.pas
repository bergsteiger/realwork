unit nsSign;

{$Z1}

interface

{.$Define nsSignAdapter}
{$IfDef nsSignAdapter}
{$Else  nsSignAdapter}
 {$Define nsSaveWaterMark}
{$EndIf nsSignAdapter}

uses
  Windows

  {$IfDef nsSignAdapter}
  ,
  GblAdapter
  {$EndIf nsSignAdapter}
  ;

type
  TBMP = record
    Bitmap : hBitmap;
    width  : Integer;
    height : Integer;
    pvBits : Pointer;
  end;//TBMP

function CanSign: Boolean;
  {-}
function SignBitmap(const bitmap: TBMP): Boolean;
  {-}
function CreateDIB(width      : Integer;
                   height     : Integer;
                   var bitmap : TBMP): Boolean;
  {-}
procedure FreeDIB(var bitmap : TBMP);
  {-}

{$IfDef nsSignAdapter}
{$Else  nsSignAdapter}
const
  DSignLib = 'DSign.dll';

function GetWatermarkSize: Integer;
  stdcall;
  {-}
procedure SetWatermarkSize(aSize: Integer);
  stdcall;
  {-}
function GetAlpha: Double;
  stdcall;
  {-}
procedure SetAlpha(anAlpha: Double);
  stdcall;
  {-}

type
  TWaterMark = record
    size      : Integer;
    watermark : PChar;
  end;//TWaterMark

function GenWatermark(var outWM: TWaterMark): Boolean;
  stdcall;
  {-}
procedure FreeWatermark(var inWM: TWaterMark);
  stdcall;
  {-}

function EmbedWatermark(const inWM: TWaterMark; const bitmap: TBMP): Boolean;
  stdcall;
  {-}
function CheckWatermark(const inWM: TWaterMark; const bitmap: TBMP): Double;
  stdcall;
  {-}
function CheckBitmap(const bitmap: TBMP): Double;
  {-}
procedure CheckBitmapFake(const bitmap: TBMP);
  {-}
{$EndIf nsSignAdapter}

{$IfDef nsSignAdapter}
var
 g_Common : ICommon = nil;
{$EndIf nsSignAdapter}

implementation

{$IfDef nsSaveWaterMark}
uses
  SysUtils
  ;
{$EndIf nsSaveWaterMark}

{$IfDef nsSignAdapter}
{$Else  nsSignAdapter}
function GetWatermarkSize: Integer;
  stdcall;
  external DSignLib name '?GetWatermarkSize@@YGHXZ';
  {-}
procedure SetWatermarkSize(aSize: Integer);
  stdcall;
  external DSignLib name '?SetWatermarkSize@@YGXH@Z';
  {-}
function GetAlpha: Double;
  stdcall;
  external DSignLib name '?GetAlpha@@YGNXZ';
  {-}
procedure SetAlpha(anAlpha: Double);
  stdcall;
  external DSignLib name '?SetAlpha@@YGXN@Z';
  {-}
function GenWatermark2(var outWM: TWaterMark; aStr: PChar; aLen: Integer): Boolean;
  stdcall;
  external DSignLib name '?GenWatermark2@@YG_NPAUWaterMark@@PADH@Z';
  {-}
function GenWatermark(var outWM: TWaterMark): Boolean;
  stdcall;
  external DSignLib name '?GenWatermark@@YG_NPAUWaterMark@@@Z';
  {-}
procedure FreeWatermark(var inWM: TWaterMark);
  stdcall;
  external DSignLib name '?FreeWatermark@@YGXPAUWaterMark@@@Z';
  {-}
function EmbedWatermark(const inWM: TWaterMark; const bitmap: TBMP): Boolean;
  stdcall;
  external DSignLib name '?EmbedWatermark@@YG_NPAUWaterMark@@PAUBMP@@@Z';
  {-}
function CheckWatermark(const inWM: TWaterMark; const bitmap: TBMP): Double;
  external DSignLib name '?CheckWatermark@@YGNPAUWaterMark@@PAUBMP@@@Z';
  {-}
function _CreateDIB(width      : Integer;
                   height     : Integer;
                   var bitmap : TBMP): Boolean;
  stdcall;
  external DSignLib name '?CreateDIB@@YG_NHHPAUBMP@@@Z';
  {-}
procedure _FreeDIB(var bitmap : TBMP);
  stdcall;
  external DSignLib name '?FreeDIB@@YGXPAUBMP@@@Z';
  {-}
function SaveWatermark(const inWM: TWaterMark; sFileName: PChar): Boolean;
  stdcall;
  external DSignLib name '?SaveWatermark@@YG_NPAUWaterMark@@PAD@Z';
  {-}
function LoadWatermark(var outWM: TWaterMark; sFileName: PChar): Boolean;
  stdcall;
  external DSignLib name '?LoadWatermark@@YG_NPAUWaterMark@@PAD@Z';
  {-}
function GetAlgorythmCount: Integer;
  stdcall;
  external DSignLib name '?GetAlgorythmCount@@YGHXZ';
  {-}
function GetAlgorythmInfo(algo: Integer; outStr: PChar): Boolean;
  stdcall;
  external DSignLib name '?GetAlgorythmInfo@@YG_NHPAD@Z';
  {-}
function GetCurrentAlgorythm: Integer;
  stdcall;
  external DSignLib name '?GetCurrentAlgorythm@@YGHXZ';
  {-}
function SetCurrentAlgorythm(algo: Integer): Boolean;
  stdcall;
  external DSignLib name '?SetCurrentAlgorythm@@YG_NH@Z';
  {-}

(*const
  c_Hello = 'Hello world !!!';
const
  g_WaterMark : TWaterMark = (size: Length(c_Hello); watermark : c_Hello);*)
var
  g_WaterMark      : TWaterMark;
  g_FakeWaterMark  : array [0..0] of TWaterMark;
{$EndIf nsSignAdapter}

function CanSign: Boolean;
  {-}
begin
 {$IfDef nsSignAdapter}
 Result := (g_Common <> nil);
 {$Else  nsSignAdapter}
 Result := true;
 {$EndIf nsSignAdapter}
end;

{$IfDef nsSignAdapter}
function PrivProfile: IPrivateUserProfile;
var
 lUserManager : IUserManager;
begin
 g_Common.GetUserManager(lUserManager);
 try
  lUserManager.GetSelfProfile(Result);
 finally
  lUserManager := nil;
 end;
end;
{$EndIf nsSignAdapter}

function  CreateDIB(width      : Integer;
                    height     : Integer;
                    var bitmap : TBMP): Boolean;
begin
 {$IfDef nsSignAdapter}
 if CanSign then
  Result := PrivProfile.CreateDIB(width, height, LongInt(@bitmap))
 else
  Result := false; 
 {$Else  nsSignAdapter}
 Result := _CreateDIB(width, height, bitmap);
 {$EndIf nsSignAdapter}
end;

procedure FreeDIB(var bitmap : TBMP);
  {-}
begin
 {$IfDef nsSignAdapter}
 if CanSign then
  PrivProfile.FreeDIB(LongInt(@bitmap));
 {$Else  nsSignAdapter}
 _FreeDIB(bitmap);
 {$EndIf nsSignAdapter}
end;

function SignBitmap(const bitmap: TBMP): Boolean;
  {-}
begin
 {$IfDef nsSignAdapter}
 if CanSign then
  Result := PrivProfile.EmbedWatermark(LongInt(@bitmap))
 else
  Result := false; 
 {$Else  nsSignAdapter}
 Result := EmbedWatermark(g_WaterMark, bitmap);
 {$EndIf nsSignAdapter}
end;

{$IfDef nsSignAdapter}
{$Else  nsSignAdapter}
function CheckBitmap(const bitmap: TBMP): Double;
  {-}
begin
 Result := CheckWatermark(g_WaterMark, bitmap);
end;

procedure CheckBitmapFake(const bitmap: TBMP);
  {-}
var
 l_Real  : Double;
 l_C     : Double;
 l_Max   : Double;
 l_Count : Integer;
 l_Index : Integer;
begin
 l_Real := CheckWatermark(g_WaterMark, bitmap);
 l_Max := l_Real;
 l_Count := 0;
 for l_Index := Low(g_FakeWaterMark) to High(g_FakeWaterMark) do
 begin
  l_C := CheckWatermark(g_FakeWaterMark[l_Index], bitmap);
  if (l_C >= l_Real) then
   Inc(l_Count);
  if (l_C > l_Max) then
   l_Max := l_C; 
 end;//for l_Index
 if (l_Count > 0) then  
  WriteLn(l_Count, l_Max);
end;
{$EndIf nsSignAdapter}

const
 c_Len = 31;
 c_St1 = #255#255#255#255#255#255;
 c_St2 = #01#01;
var
 l_Index : Integer;
 l_J     : Integer;     
 l_GUID  : TGUID;
 l_S     : String;
initialization
  {$IfDef nsSignAdapter}
  {$Else  nsSignAdapter}
  //WriteLn(GetAlgorythmCount);
  //WriteLn(GetCurrentAlgorythm);
  //SetCurrentAlgorythm(1);
  //WriteLn(GetCurrentAlgorythm);
  //SetWatermarkSize(1000);
  SetAlpha(0.5);
  //SetAlpha(1);
  //SetAlpha(0.9);
  //SetAlpha(0.325);
  //if (GetCurrentAlgorythm = 1) then
  // SetAlpha(0.2);
   begin
    l_S := '';
    for l_J := 0 to Pred(c_Len) do
    begin
     CreateGUID(l_GUID);
     l_S := l_S + GUIDToString(l_GUID);
    end;//for l_J
//    if not GenWatermark2(g_WaterMark, PChar(l_S), Length(l_S)) then
//     Assert(false);
    if not GenWatermark2(g_WaterMark, PChar(c_St1), Length(c_St1)) then
     Assert(false);
    for l_Index := Low(g_FakeWaterMark) to High(g_FakeWaterMark) do
    begin
     l_S := '';
     for l_J := 0 to Pred(c_Len) do
     begin
      CreateGUID(l_GUID);
      l_S := l_S + GUIDToString(l_GUID);
     end;//for l_J
     l_S := l_S + GUIDToString(l_GUID);
//     if not GenWatermark2(g_FakeWaterMark[l_Index], PChar(l_S), Length(l_S)) then
//      Assert(false);
     if not GenWatermark2(g_FakeWaterMark[l_Index], PChar(c_St2), Length(c_st2)) then
      Assert(false);
    end;//for l_Index
   end;//GetCurrentAlgorythm = 1
  {$IfDef nsSaveWaterMark}
  SaveWaterMark(g_WaterMark, PChar(ExtractFilePath(ParamStr(0)) + '0.sig'));
  for l_Index := Low(g_FakeWaterMark) to High(g_FakeWaterMark) do
   SaveWaterMark(g_FakeWaterMark[l_Index], PChar(ExtractFilePath(ParamStr(0)) + IntToStr(l_Index) + '.sig'));
  {$EndIf nsSaveWaterMark}
  {$EndIf nsSignAdapter}

finalization
  {$IfDef nsSignAdapter}
  {$Else  nsSignAdapter}
  for l_Index := Low(g_FakeWaterMark) to High(g_FakeWaterMark) do
   FreeWatermark(g_FakeWaterMark[l_Index]);
  FreeWatermark(g_WaterMark);
  {$EndIf nsSignAdapter}

end.