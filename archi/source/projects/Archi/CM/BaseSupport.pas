unit BaseSupport;

//{$I w:\common\components\gui\garant\Everest\evDefine.inc}

interface

function LockBase(aMsg: String; const aStartLock, aStopLock: TDateTime): Boolean; overload;

function LockBase(const aMsg: String): Boolean; overload;

function LockBase: Boolean; overload;

procedure UnlockBase;

function LockHolidayBase: Boolean;

procedure UnlockHolidayBase;

function IsBaseLocked(var aMsg: String): Boolean; overload;

function IsBaseLocked: Boolean; overload;

function NeverExpireDate: TDateTime;

function ConfigFeature : String;

function FullConfigFeature: String;
{* - выдает строку с "особенностями" собранной версии}

function GetProjectConfigStr(aNeedDate : boolean = false): String;
{* - выдает строку с Версией, "особенностями" собранной версии и датой сборки}

const
 ddLockFileName = 'lock.txt';

implementation

Uses
  Types,
  l3IniFile, l3FileUtils,
  l3DateSt,
  SysUtils, DateUtils,
  vtVerInf,

  daInterfaces,
  dt_Const,

  m3StgMgr
  ;

const
  dd_LockSection    = 'LockInfo';
  dd_Message        = 'Message';
  dd_ExpireDate     = 'ExpireDate';
  dd_StartDate      = 'StartDate';
  dd_DefaultMessage = 'База используется в монопольном режиме';
var  
  BaseLockCount     : Integer = 0;

function LockFileName: String;
var
  S: ShortString;
begin
  ServerConfig.Section:= 'FamilyConst';
  S:= ServerConfig.ReadParamStrDef('FamilyPath', '');
  Result:= ConcatDirName(S, ddLockFileName);
end;

function HolidayLockFileName: String;
var
  S: ShortString;
begin
  StationConfig.Section:= 'AutoLoad';
  S:= StationConfig.ReadParamStrDef('WeekendBaseDir', '');
  Result:= ConcatDirName(S, ddLockFileName);
end;

function NeverExpireDate: TDateTime;
begin
  Result:= EncodeDateTime(9999, 1, 1, 0, 0, 0, 0);
end;

function LockHolidayBase: Boolean;
begin
 try
  with TCfgList.Create(HolidayLockFileName)do
  try
   Section:= dd_LockSection;
   WriteParamStr(dd_Message, dd_DefaultMessage);
   WriteParamDateTime(dd_ExpireDate, NeverExpireDate);
   Result:= True;
  finally
   Free;
  end; // try..finally
 except
  Result:= False;
 end;
end;

procedure UnlockHolidayBase;
begin
 if FileExists(HolidayLockFileName) then
    DeleteFile(HolidayLockFileName);
end;



function LockBase(aMsg: String; const aStartLock, aStopLock: TDateTime): Boolean;
begin
 if not FileExists(LockFileName) then
 try
  with TCfgList.Create(LockFileName)do
  try
   Section:= dd_LockSection;
   if aMsg = '' then aMsg:= dd_DefaultMessage;
   WriteParamStr(dd_Message, aMsg);
   WriteParamDateTime(dd_StartDate, aStartLock);
   if CompareDateTime(Now, aStopLock) = LessThanValue then
    WriteParamDateTime(dd_ExpireDate, aStopLock)
   else
    WriteParamDateTime(dd_ExpireDate, NeverExpireDate);
   Result:= True;
  finally
   Free;
  end; // try..finally
 except
  Result:= False;
 end;
 Inc(BaseLockCount);
end;

function LockBase: Boolean;
begin
  Result:= LockBase(dd_DefaultMessage, Now, NeverExpireDate);
end;

function LockBase(const aMsg: String): Boolean;
begin
  Result:= LockBase(aMsg, Now, NeverExpireDate);
end;


procedure UnlockBase;
begin
 Dec(BaseLockCount);
 if FileExists(LockFileName) and (BaseLockCount = 0) then
  DeleteFile(LockFileName);
end;


function IsBaseLocked(var aMsg: String): Boolean;
var
 l_StartDate,
 l_ExpireDate: TDateTime;
begin
 if FileExists(LockFileName) then
 begin
  try
   with TCfgList.Create(LockFileName)do
   try
    Section:= dd_LockSection;
    aMsg:= ReadParamStrDef(dd_Message, dd_DefaultMessage);
    l_StartDate:= ReadParamDateTimeDef(dd_StartDate, 0);
    l_ExpireDate:= ReadParamDateTimeDef(dd_ExpireDate, NeverExpireDate);
    if CompareDateTime(l_ExpireDate, NeverExpireDate) = EqualsValue then
     aMsg:= aMsg + #10 + 'Базу должен открыть администратор системы.'
    else
     aMsg:= aMsg + #10 + FormatDateTime('База закрыта до hh:nn:ss dd mmm yyyy', l_ExpireDate);
   finally
    Free;
   end; // try..finally
   if CompareDateTime(Now, l_StartDate) = GreaterThanValue then
   begin
    if CompareDateTime(Now, l_ExpireDate) <> GreaterThanValue then
      Result:= True
    else
    begin
      Result:= False;
      UnlockBase;
    end;
   end
   else
    Result:= False;
  except
   Result:= False;
  end;
 end
 else
  Result:= False;
 if Result and (BaseLockCount = 0) then
  Inc(BaseLockCount);
end;

function IsBaseLocked: Boolean;
var
  l_S: String;
begin
  Result:= IsBaseLocked(l_S);
end;

{$I ProjectDefine.inc}
{$I m3Define.inc}

function ConfigFeature : String;
begin
 // Result := 'ne';
 Result := '';

 {$IFDEF arAttrInEVD}
  {if Result <> '' then
   Result := Result + ', ';
  Result := Result + 'nAttr';
  }
 {$EndIF arAttrInEVD}

 {$IFDEF HT_NEWDLL}
  if Result <> '' then
   Result := Result + ', ';
  Result := Result + 'nHT';
 {$EndIF HT_NEWDLL}

 if Tm3StorageManager.UseSplitted then
 begin
  if Result <> '' then
   Result := Result + ', ';
  Result := Result + 'AutoSplitStg';
 end;//Tm3StorageManager.UseSplitted

 {$IFDEF ForRegion}
  if Result <> '' then
   Result := Result + ', ';
  Result := Result + 'R';
 {$EndIF ForRegion}
end;

function FullConfigFeature: String;
begin
  Result := '';

 {$IFDEF arAttrInEVD}
  if Result <> '' then
   Result := Result + ', ';
  Result := Result + 'Атрибуты в документе';
 {$EndIF arAttrInEVD}

 {$IFDEF HT_NEWDLL}
  if Result <> '' then
   Result := Result + ', ';
  Result := Result + 'Новый HyTech';
 {$EndIF HT_NEWDLL}

 if Tm3StorageManager.UseSplitted then
 begin
  if Result <> '' then
   Result := Result + ', ';
  Result := Result + 'Автоопределение составного хранилища';
 end;//Tm3StorageManager.UseSplitted

end;

function GetProjectConfigStr(aNeedDate : boolean = false): String;
var
 lFeatureStr : String;
 lDateStr : String;
begin
 With TVersionInfo.Create, FileLongVersion do
 try
  lFeatureStr := ConfigFeature;
  if lFeatureStr <> '' then
   lFeatureStr := ' ['+lFeatureStr+']';

  if aNeedDate then
   lDateStr := Format(' of %s', [l3DateToStr(VerFileDate)]);

  Result := Format('version %d.%d.%d build %d%s%s', [All[2], All[1], c_DocBaseVersion, All[3], lFeatureStr, lDateStr]);
 finally
  Free;
 end;
end;

end.
