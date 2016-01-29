{*********************************************************}
{*                    STDATEST.PAS 3.01                  *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit STDateSt;
  {-Date and time AnsiString manipulation}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  SysUtils,
  STStrS,
  StStrZ,
  {$IFDEF WIN32}
  STStrL,
  {$ENDIF}
  STConst,
  STBase,
  STUtils,
  STDate;

const
  {the following characters are meaningful in date Picture strings}
  MonthOnly = 'm';      {Formatting character for a date AnsiString picture mask}
  DayOnly = 'd';        {Formatting character for a date AnsiString picture mask}
  YearOnly = 'y';       {Formatting character for a date AnsiString picture mask}
  MonthOnlyU = 'M';     {Formatting character for a date AnsiString picture mask.
  Uppercase means pad with ' ' rather than '0'}
  DayOnlyU = 'D';       {Formatting character for a date AnsiString picture mask.
  Uppercase means pad with ' ' rather then '0'}
  DateSlash = '/';      {Formatting character for a date AnsiString picture mask}

  {'n'/'N' may be used in place of 'm'/'M' when the name of the month is
   desired instead of its number. E.g., 'dd/nnn/yyyy' -\> '01-Jan-1980'.
   'dd/NNN/yyyy' -\> '01-JAN-1980' (if SlashChar = '-'). The abbreviation used
   is based on the width of the subfield (3 in the example) and the current
   contents of the MonthString array.}
  NameOnly = 'n';       {Formatting character for a date AnsiString picture mask}
  NameOnlyU = 'N';      {Formatting character for a date AnsiString picture mask.
  Uppercase causes the output to be in uppercase}

  {'w'/'W' may be used to include the day of the week in a date AnsiString. E.g.,
  'www dd nnn yyyy' -\> 'Mon 01 Jan 1989'. The abbreviation used is based on
  the width of the subfield (3 in the example) and the current contents of the
  DayString array. Note that TurboPower Entry Fields will not allow the user to
  enter text into a subfield containing 'w' or 'W'. The day of the week will be
  supplied automatically when a valid date is entered.}
  WeekDayOnly = 'w';    {Formatting character for a date AnsiString picture mask}
  WeekDayOnlyU = 'W';   {Formatting character for a date AnsiString picture mask.
  Uppercase causes the output to be in uppercase}

  LongDateSub1 = 'f';   {Mask character used strictly for dealing with Window's
  long date format}
  LongDateSub2 = 'g';   {Mask character used strictly for dealing with Window's
  long date format}
  LongDateSub3 = 'h';   {Mask character used strictly for dealing with Window's
  long date format}

  HourOnly = 'h';       {Formatting character for a time AnsiString picture mask}
  MinOnly = 'm';        {Formatting character for a time AnsiString picture mask}
  SecOnly = 's';        {Formatting character for a time AnsiString picture mask}
  {if uppercase letters are used, numbers are padded with ' ' rather than '0'}
  HourOnlyU = 'H';      {Formatting character for a time AnsiString picture mask.
  Uppercase means pad with ' ' rather than '0'}
  MinOnlyU = 'M';       {Formatting character for a time AnsiString picture mask.
  Uppercase means pad with ' ' rather than '0'}
  SecOnlyU = 'S';       {Formatting character for a time AnsiString picture mask.
  Uppercase means pad with ' ' rather than '0'}
  {'hh:mm:ss tt' -\> '12:00:00 pm', 'hh:mmt' -\> '12:00p'}
  TimeOnly = 't';       {Formatting character for a time AnsiString picture mask.
  This generates 'AM' or 'PM'}
  TimeColon = ':';      {Formatting character for a time AnsiString picture mask}


  {-------julian date routines---------------}

function DateStringHMStoAstJD(Picture, DS : AnsiString; H,M,S,Epoch : integer) : Double;
  {-Returns the Astronomical Julian Date using a Date AnsiString,
  Hours, Minutes, Seconds}

function MonthToString(const Month : Integer) : AnsiString;
  {-Return the month as a AnsiString}

  {-------date AnsiString routines---------------}

function DateStringToStDate(const Picture, S : AnsiString; Epoch : Integer) : TStDate;
  {-Convert a AnsiString to a Julian date}

function DateStringToDMY(const Picture, S : AnsiString;
                         Epoch : Integer;
                         var D, M, Y : Integer) : Boolean;
  {-Extract day, month, and year from a date AnsiString}

function StDateToDateString(const Picture : AnsiString; const Julian : TStDate;
                            Pack : Boolean) : AnsiString;
  {-Convert a Julian date to a AnsiString}

function DayOfWeekToString(const WeekDay : TStDayType) : AnsiString;
  {-Return the day of the week specified by WeekDay as a AnsiString in Dest.}

function DMYtoDateString(const Picture : AnsiString;
                         Day, Month, Year, Epoch : Integer;
                         Pack : Boolean) : AnsiString;
  {-Merge the month, day, and year into the picture}

function CurrentDateString(const Picture : AnsiString; Pack : Boolean) : AnsiString;
  {-Return today's date as a AnsiString}

  {-------time routines---------------}

function CurrentTimeString(const Picture : AnsiString;
                           Pack : Boolean) : AnsiString;
  {-Return the current time as a AnsiString of the specified form}

function TimeStringToHMS(const Picture, St : AnsiString;
                         var H, M, S : Integer) : Boolean;
  {-Extract hours, minutes, seconds from a time AnsiString}

function TimeStringToStTime(const Picture, S : AnsiString) : TStTime;
  {-Convert a time AnsiString to a time variable}

function StTimeToAmPmString(const Picture : AnsiString;
                             const T : TStTime; Pack : Boolean) : AnsiString;
  {-Convert a time variable to a time AnsiString in am/pm format}

function StTimeToTimeString(const Picture : AnsiString; const T : TStTime;
                            Pack : Boolean) : AnsiString;
  {-Convert a time variable to a time AnsiString}


  {-------- routines for international date/time strings ---------}

function DateStringIsBlank(const Picture, S : AnsiString) : Boolean;
  {-Return True if the month, day, and year in S are all blank}

function InternationalDate(ForceCentury : Boolean) : AnsiString;
  {-Return a picture mask for a short date AnsiString, based on Windows' international
    information}

function InternationalLongDate(ShortNames : Boolean;
                               ExcludeDOW : Boolean) : AnsiString;
  {-Return a picture mask for a date AnsiString, based on Windows' international
    information}

function InternationalTime(ShowSeconds : Boolean) : AnsiString;
  {-Return a picture mask for a time AnsiString, based on Windows' international
    information}

procedure ResetInternationalInfo;
  {-Update internal info to match Windows' international info}


implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  Classes,
  Forms,
  IniFiles,
  ShellAPI,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}


const
  First2Months = 59;           {1600 was a leap year}
  FirstDayOfWeek = Saturday;   {01/01/1600 was a Saturday}
  DateLen = 40;                {maximum length of Picture strings}
  MaxMonthName = 15;
  MaxDayName   = 15;

type
{  DateString = AnsiString[DateLen];}
  SString = String[255];

var
  wLongDate  : String[40];
  wldSub1    : String[6];
  wldSub2    : String[6];
  wldSub3    : String[6];
  wShortDate : String[31];
  w1159      : String[7];
  w2359      : String[7];
  wSlashChar : ANSIChar;
  wColonChar : ANSIChar;
  wTLZero    : Boolean;
  w12Hour    : Boolean;
  DefaultYear : Integer;     {default year--used by DateStringToDMY}
  DefaultMonth : ShortInt;   {default month}

  procedure ExtractFromPicture(Picture, S : AnsiString; Ch : ANSIChar; var I : Integer;
                               Blank, Default : Integer); forward;

{$IFDEF WIN32}
  procedure AppendChar(var S : AnsiString; Ch : AnsiChar);
  begin
    SetLength(S,Succ(Length(S)));
    S[Length(S)] := Ch;
  end;
{$ELSE}
  procedure AppendChar(var S : ShortString; Ch : AnsiChar);
  begin
    Inc(S[0]);
    S[Length(S)] := Ch;
  end;
{$ENDIF}

  function DayOfWeekToString(const WeekDay : TStDayType) : AnsiString;
    {-Return the day of the week specified by WeekDay as a AnsiString in Dest.
    Will honor international names}
  begin
    Result := {$IfDef XE}FormatSettings.{$EndIf}LongDayNames[Ord(WeekDay)+1];
  end;

  function MonthToString(const Month : Integer) : AnsiString;
  {-Return the month as a AnsiString. Will honor international names}
  begin
    if (Month >= 1) and (Month <= 12) then
      Result := {$IfDef XE}FormatSettings.{$EndIf}LongMonthNames[Month]
    else
       Result := '';
  end;

  function AstJulianDatePrim(Year,Month,Date : Integer) : Double;
  var
    A, B : integer;
  begin
    if Month < 2 then
    begin
      Dec(Year);
      Inc(Month,12);
    end;
    A := Trunc(Year/100);
    B := 2 - A + Trunc(A/4);

    Result := Trunc(365.25 * (Year+4716))
            + Trunc(30.6001 * (Month+1))
            + Date + B - 1524.5;
  end;

  function DateStringHMSToAstJD(Picture, DS : AnsiString; H,M,S,Epoch : Integer) : Double;
    {-Returns the Astronomical Julian Date using a Date AnsiString,
    Hours, Minutes, Seconds}
  var
    Date, Month, Year : Integer;
  begin
    ExtractFromPicture(Picture, DS, NameOnly, Month, -1, 0);
    if M = 0 then
      ExtractFromPicture(Picture, DS, MonthOnly, Month, -1, DefaultMonth);
    ExtractFromPicture(Picture, DS, DayOnly, Date, -1, 1);
    ExtractFromPicture(Picture, DS, YearOnly, Year, -1, DefaultYear);

    Year := ResolveEpoch(Year, Epoch);
    Result := AstJulianDatePrim(Year,Month,Date)
            + H/HoursInDay + M/MinutesInDay + S/SecondsInDay;
  end;

  function MonthStringToMonth(MSt : AnsiString; Width : Byte) : Byte;
    {-Convert the month name in MSt to a month (1..12)}
  var
    S   : AnsiString;
    T   : AnsiString;
    Len : Byte;
    I   : Word;
  begin
    {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
    S := UpperCase(MSt);
    Len := Length(S);
{$IFDEF WIN32}
    SetLength(S,Width);
{$ELSE}
    S[0] := Chr(Width);
{$ENDIF}
    if Width > Len then
      FillChar(S[Len+1], Length(S)-Len, ' ');

    for I := 1 to 12 do begin
      T := UpperCase({$IfDef XE}FormatSettings.{$EndIf}LongMonthNames[I]);
      Len := Length(T);
{$IFDEF WIN32}
      SetLength(T,Width);
{$ELSE}
      T[0] := Chr(Width);
{$ENDIF}
      if Width > Len then
        FillChar(T[Len+1], Length(T)-Len, ' ');

      if S = T then begin
        Result := I;
        Exit;
      end;
    end;
    Result := 0;
  end;

  procedure ExtractFromPicture(Picture, S : AnsiString;
                               Ch : ANSIChar; var I : Integer;
                               Blank, Default : Integer);
    {-Extract the value of the subfield specified by Ch from S and return in
      I. I will be set to -1 in case of an error, Blank if the subfield exists
      in Picture but is empty, Default if the subfield doesn't exist in
      Picture.}
  var
    PTmp : AnsiString;
    C, posLCCh, posUCCh : Cardinal;
    Code : Integer;
  begin
    {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
    {find the start of the subfield}
    I := Default;

{$IFDEF WIN32}
    StrChPosL(Picture, Ch, posLCCh);
    Ch := Upcase(Ch);
    StrChPosL(Picture, Ch, posUCCh);
{$ELSE}
    StrChPosS(Picture, Ch, posLCCh);
    Ch := Upcase(Ch);
    StrChPosS(Picture, Ch, posUCCh);
{$ENDIF}

    if (posLCCh < 1) or ((posUCCh > 0) and (posUCCh < posLCCh)) then
      posLCCh := posUCCh;
    if (posLCCh < 1)  or (Length(S) <> Length(Picture)) then
       Exit;

    {extract the substring}

    PTmp := '';
    C := Length(Picture);
    while (posLCCh <= C) and (Upcase(Picture[posLCCh]) = Ch) do begin
      if S[posLCCh] <> ' ' then
        AppendChar(PTmp,AnsiChar(S[posLCCh]));
      Inc(posLCCh);
    end;

    if Length(PTmp) = 0 then
      I := Blank
    else if Ch = NameOnlyU then begin
      I := MonthStringToMonth(PTmp, Length(PTmp));
      if I = 0 then
        I := -1;
    end
    else begin
      {convert to a value}
      Val(PTmp, I, Code);
      if Code <> 0 then
        I := -1;
    end;
  end;

  function DateStringToDMY(const Picture, S : AnsiString;
                           Epoch : Integer;
                           var D, M, Y : Integer) : Boolean;
    {-Extract day, month, and year from S, returning true if AnsiString is valid}
  begin
    ExtractFromPicture(Picture, S, NameOnly, M, -1, 0);
    if M = 0 then
      ExtractFromPicture(Picture, S, MonthOnly, M, -1, DefaultMonth);
    ExtractFromPicture(Picture, S, DayOnly, D, -1, 1);
    ExtractFromPicture(Picture, S, YearOnly, Y, -1, DefaultYear);
    if ValidDate(D, M, Y, Epoch) then begin                          
      Result := True;                                                
      Y := ResolveEpoch(Y, Epoch);                                   
    end else                                                         
      Result := False;                                               
  end;

  function DateStringIsBlank(const Picture, S : AnsiString) : Boolean;
    {-Return True if the month, day, and year in S are all blank}
  var
    M, D, Y : Integer;
  begin
    ExtractFromPicture(Picture, S, NameOnly,  M, -2, 0);
    if M = 0 then
      ExtractFromPicture(Picture, S, MonthOnly, M, -2, -2);
    ExtractFromPicture(Picture, S, DayOnly,   D, -2, -2);
    ExtractFromPicture(Picture, S, YearOnly,  Y, -2, -2);
    Result := (M = -2) and (D = -2) and (Y = -2);
  end;


  function DateStringToStDate(const Picture, S : AnsiString; Epoch : Integer) : TStDate;
    {-Convert S, a AnsiString of the form indicated by Picture, to a julian date.
      Picture and S must be of equal lengths}
  var
    Month, Day, Year : Integer;
  begin
    {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
    {extract day, month, year from S}
    if DateStringToDMY(Picture, S, Epoch, Day, Month, Year) then
      {convert to julian date}
      Result := DMYtoStDate(Day, Month, Year, Epoch)
    else
      Result := BadDate;
  end;

  function SubstCharSim(P : AnsiString; OC, NC : ANSIChar) : AnsiString;
  var
     step : integer;
  begin
    for step := 1 to Length(P) do
    begin
      if P[step] = OC then
        P[step] := NC;
    end;
    Result := P;
  end;

  function SubstChar(Picture : AnsiString; OldCh, NewCh : ANSIChar) : AnsiString;
    {-Replace all instances of OldCh in Picture with NewCh}
  var
    I    : Integer;
    UpCh : ANSIChar;
    P    : Cardinal;
  begin
    UpCh := Upcase(OldCh);
{$IFDEF WIN32}
    if (StrChPosL(Picture,OldCh,P)) or (StrChPosL(Picture,UpCh,P)) then
{$ELSE}
    if (StrChPosS(Picture,OldCh,P)) or (StrChPosS(Picture,UpCh,P)) then
{$ENDIF}
      for I := 1 to Length(Picture) do
        if Upcase(Picture[I]) = UpCh then
          Picture[I] := NewCh;
    Result := Picture;
  end;

  function PackResult(Picture, S : AnsiString) : AnsiString;
    {-Remove unnecessary blanks from S}
  var
    step     : Integer;
  begin
    Result := '';

    for step := 1 to Length(Picture) do
    begin
      case Picture[step] of
        MonthOnlyU, DayOnlyU, NameOnly, NameOnlyU, WeekDayOnly,
        WeekDayOnlyU, HourOnlyU, SecOnlyU :
          if S[step] <> ' ' then
            AppendChar(Result,S[Step]);
        TimeOnly :
          if S[step] <> ' ' then
            AppendChar(Result,S[step]);
      else
        AppendChar(Result,S[step]);
      end;
    end;
  end;

  procedure MergeIntoPicture(var Picture : AnsiString; Ch : ANSIChar; I : Integer);
    {-Merge I into location in Picture indicated by format character Ch}
  var
    Tmp     : String[40];
    C,
    J, K, L : Cardinal;
    UCh,
    CPJ,
    CTI     : ANSIChar;
    OK, Done: Boolean;
    step  : Cardinal;
  begin
    {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
    {find the start of the subfield}
{$IFDEF WIN32}
    OK := StrChPosL(Picture,Ch,J);
{$ELSE}
    OK := StrChPosS(Picture,Ch,J);
{$ENDIF}
    UCh := Upcase(Ch);
    if (NOT OK) then
    begin
{$IFDEF WIN32}
      if NOT (StrChPosL(Picture, UCh, J)) then
{$ELSE}
      if NOT (StrChPosS(Picture, UCh, J)) then
{$ENDIF}
        Exit;
    end;

    {find the end of the subfield}
    K := J;
    C := Length(Picture);
    while (J <= C) and (Upcase(Picture[J]) = UCh) do
      Inc(J);
    Dec(J);

    if (UCh = WeekDayOnlyU) or (UCh = NameOnlyU) then begin
      if UCh = WeekDayOnlyU then
        case I of
          Ord(Sunday)..Ord(Saturday) :
            Tmp := {$IfDef XE}FormatSettings.{$EndIf}LongDayNames[I+1];
          else
            Tmp := '';
        end
      else
        case I of
          1..12 :
            Tmp := {$IfDef XE}FormatSettings.{$EndIf}LongMonthNames[I];
          else
            Tmp := '';
        end;
      K := Succ(J-K);
      if K > Length(Tmp) then
        for step := 1 to (K-Length(Tmp)) do
          Tmp := Tmp + ' ';
      Tmp := Copy(Tmp,1,K);
    end else
      {convert I to a AnsiString}
      Str(I:DateLen, Tmp);

    {now merge}
    L := Length(Tmp);
    Done := False;
    CPJ := Picture[J];

    while (Upcase(CPJ) = UCh) and not Done do
    begin
      CTI := Tmp[L];
      if (UCh = NameOnlyU) or (UCh = WeekDayOnlyU) then
      begin
        case CPJ of
          NameOnlyU, WeekDayOnlyU :
            CTI := Upcase(CTI);
        end;
      end
      else{change spaces to 0's if desired}
        if (CPJ >= 'a') and (CTI = ' ') then
          CTI := '0';
      Picture[J] := CTI;
      Done := (J = 1) or (L = 0);
      if not Done then
      begin
        Dec(J);
        Dec(L);
      end;
      CPJ := Picture[J];
    end;
  end;


  procedure MergePictureSt(Picture : AnsiString; var P : AnsiString;
                          MC : ANSIChar; SP : AnsiString);
  var
    I, J : Cardinal;
    L    : Cardinal;
  begin
{$IFDEF WIN32}
    if NOT (StrChPosL(Picture,MC,I)) then
{$ELSE}
    if NOT (StrChPosS(Picture,MC,I)) then
{$ENDIF}
       Exit;
    J := 1;
    L := Length(SP);
    while Picture[I] = MC do begin
      {if J <= Length(SP) then}
      if (L = 0) or (J > L) then
        P[I] := ' '
      else begin
        P[I] := SP[J];
        Inc(J);
      end;
      Inc(I);
    end;
  end;


  function DMYtoDateString(const Picture : AnsiString; Day, Month, Year, Epoch : Integer;
                           Pack : Boolean) : AnsiString;
    {-Merge the month, day, and year into the picture}
  var
    DOW  : Integer;

  begin
    Result := Picture;

    Year := ResolveEpoch(Year, Epoch);

    DOW := Integer( DayOfWeekDMY(Day, Month, Year, 0) );
    MergeIntoPicture(Result, MonthOnly,   Month);
    MergeIntoPicture(Result, DayOnly,     Day);
    MergeIntoPicture(Result, YearOnly,    Year);
    MergeIntoPicture(Result, NameOnly,    Month);
    MergeIntoPicture(Result, WeekDayOnly, DOW);

    {map slashes}
    Result := SubstChar(Result, DateSlash, wSlashChar);

    MergePictureSt(Picture, Result, LongDateSub1, wldSub1);
    MergePictureSt(Picture, Result, LongDateSub2, wldSub2);
    MergePictureSt(Picture, Result, LongDateSub3, wldSub3);

    if Pack then
      Result:= PackResult(Picture, Result);
  end;

  function StDateToDateString(const Picture : AnsiString; const Julian : TStDate;
                              Pack : Boolean) : AnsiString;
    {-Convert Julian to a AnsiString of the form indicated by Picture}
  var
    Month, Day, Year : Integer;
  begin
    Result := Picture;
    if Julian = BadDate then begin
      {map picture characters to spaces}
      Result := SubstChar(Result, MonthOnly,   ' ');
      Result := SubstChar(Result, NameOnly,    ' ');
      Result := SubstChar(Result, DayOnly,     ' ');
      Result := SubstChar(Result, YearOnly,    ' ');
      Result := SubstChar(Result, WeekDayOnly, ' ');

      MergePictureSt(Picture, Result, LongDateSub1, wldSub1);
      MergePictureSt(Picture, Result, LongDateSub2, wldSub2);
      MergePictureSt(Picture, Result, LongDateSub3, wldSub3);

      {map slashes}
      Result := SubstChar(Result, DateSlash, wSlashChar);
    end
    else begin
      {convert Julian to day/month/year}
      StDateToDMY(Julian, Day, Month, Year);

      {merge the month, day, and year into the picture}
      Result := DMYtoDateString(Picture, Day, Month, Year, 0, Pack);
    end;
  end;

  function CurrentDateString(const Picture : AnsiString; Pack : Boolean) : AnsiString;
    {-Returns today's date as a AnsiString of the specified form}
  begin
    Result := StDateToDateString(Picture, CurrentDate, Pack);
  end;

  function TimeStringToHMS(const Picture, St : AnsiString; var H, M, S : Integer) : Boolean;
    {-Extract Hours, Minutes, Seconds from St, returning true if AnsiString is valid}
  var
    I,
    J      : Cardinal;
    Tmp,
    t1159,
    t2359  : String[20];
  begin
    {extract hours, minutes, seconds from St}
    ExtractFromPicture(Picture, St, HourOnly, H, -1, 0);
    ExtractFromPicture(Picture, St, MinOnly,  M, -1, 0);
    ExtractFromPicture(Picture, St, SecOnly,  S, -1, 0);
    if (H = -1) or (M = -1) or (S = -1) then begin
      Result := False;
      Exit;
    end;

    {check for TimeOnly}
{$IFDEF WIN32}
    if (StrChPosL(Picture, TimeOnly, I)) and
{$ELSE}
    if (StrChPosS(Picture, TimeOnly, I)) and
{$ENDIF}
       (Length(w1159) > 0) and (Length(w2359) > 0) then begin

      Tmp := '';
      J := 1;
      while Picture[I] = TimeOnly do begin
        Inc(Tmp[0]);
        Tmp[J] := St[I];
        Inc(J);
        Inc(I);
      end;
      Tmp := TrimTrailS(Tmp);

      t1159 := w1159;
      t2359 := w2359;
      if (Length(Tmp) = 0) then
         H := -1
      else if (UpperCase(Tmp) = UpperCase(t2359)) then begin
        if (H < 12) then
          Inc(H,12)
        else if (H=0) or (H > 12) then
          {force BadTime}
          H := -1;
      end
      else if (UpperCase(Tmp) = UpperCase(t1159)) then begin
        if H = 12 then
          H := 0
        else if (H = 0) or (H > 12) then
          {force BadTime}
          H := -1;
      end
      else
        {force BadTime}
        H := -1;
      end;
    Result := ValidTime(H, M, S);
  end;

  function TimeStringToStTime(const Picture, S : AnsiString) : TStTime;
    {-Convert S, a AnsiString of the form indicated by Picture, to a Time variable}
  var
    Hours, Minutes, Seconds : Integer;
  begin
    if TimeStringToHMS(Picture, S, Hours, Minutes, Seconds) then
      Result := HMStoStTime(Hours, Minutes, Seconds)
    else
      Result := BadTime;
  end;

  function TimeToTimeStringPrim(Picture : AnsiString; T : TStTime;
                                Pack : Boolean; t1159, t2359 : AnsiString) : AnsiString;
    {-Convert T to a AnsiString of the form indicated by Picture}
  var
    Hours,
    Minutes,
    Seconds  : Byte;
    L, I,
    TPos     : Cardinal;
    P        : AnsiString;
    OK       : Boolean;
    C        : String[1];
  begin
    {merge the hours, minutes, and seconds into the picture}
    StTimeToHMS(T, Hours, Minutes, Seconds);
    Result := Picture;

    {check for TimeOnly}
{$IFDEF WIN32}
    OK := StrChPosL(Result, TimeOnly, TPos);
{$ELSE}
    OK := StrChPosS(Result, TimeOnly, TPos);
{$ENDIF}
    if OK then begin
      if (Hours >= 12) then
        P := t2359
      else
        P := t1159;
      if (Length(t1159) > 0) and (Length(t2359) > 0) then
        case Hours of
          0 : Hours := 12;
          13..23 : Dec(Hours, 12);
        end;
    end;

    if T = BadTime then begin
      {map picture characters to spaces}
      Result := SubstChar(Result, HourOnly, ' ');
      Result := SubstChar(Result, MinOnly, ' ');
      Result := SubstChar(Result, SecOnly, ' ');
    end
    else begin
      {merge the numbers into the picture}
      MergeIntoPicture(Result, HourOnly, Hours);
      MergeIntoPicture(Result, MinOnly, Minutes);
      MergeIntoPicture(Result, SecOnly, Seconds);
    end;

    {map colons}
    Result := SubstChar(Result, TimeColon, wColonChar);

    {plug in AM/PM AnsiString if appropriate}
    if OK then begin
      if (Length(t1159) = 0) and (Length(t2359) = 0) then begin
        C := SubstCharSim(Result[TPos], TimeOnly, ' ');
        Result[TPos] := C[1];
      end else if (T = BadTime) and (Length(t1159) = 0) then begin
        C := SubstCharSim(Result[TPos], TimeOnly, ' ');
        Result[TPos] := C[1];
      end else begin
        I := 1;
        L := Length(P);
        while (Result[TPos] = TimeOnly) and (I <= L) do begin
          Result[TPos] := P[I];
          Inc(I);
          Inc(TPos);
        end;
      end;
    end;

    if Pack and (T <> BadTime) then
      Result := PackResult(Picture, Result);
  end;

  function StTimeToTimeString(const Picture : AnsiString; const T : TStTime;
                              Pack : Boolean) : AnsiString;
    {-Convert T to a AnsiString of the form indicated by Picture}
  begin
    Result := TimeToTimeStringPrim(Picture, T, Pack, w1159, w2359);
  end;

  function StTimeToAmPmString(const Picture : AnsiString; const T : TStTime;
                            Pack : Boolean) : AnsiString;
    {-Convert T to a AnsiString of the form indicated by Picture. Times are always
      displayed in am/pm format.}
  const
    t1159 = 'AM';
    t2359 = 'PM';
  var
    P    : Cardinal;
  begin
    Result := Picture;
{$IFDEF WIN32}
    if NOT (StrChPosL(Result, TimeOnly, P)) then
{$ELSE}
    if NOT (StrChPosS(Result, TimeOnly, P)) then
{$ENDIF}
      Result := Result + TimeOnly;
    Result := TimeToTimeStringPrim(Result, T, Pack, t1159, t2359);
  end;

  function CurrentTime : TStTime;
    {-Returns current time in seconds since midnight}
  begin
    Result := Trunc(SysUtils.Time * SecondsInDay);
  end;

  function CurrentTimeString(const Picture : AnsiString; Pack : Boolean) : AnsiString;
    {-Returns current time as a AnsiString of the specified form}
  begin
    Result := StTimeToTimeString(Picture, CurrentTime, Pack);
  end;

  function MaskCharCount(P : AnsiString; MC : ANSIChar) : Integer;
  var
    I, R,                                                              
    Len  : Cardinal;
    OK   : Boolean;
  begin
{$IFDEF WIN32}
    OK := StrChPosL(P, MC, I);
{$ELSE}
    OK := StrChPosS(P, MC, I);
{$ENDIF}
    R := Ord(OK);                                                      
    Len := Length(P);
    if OK then
      while (P[I+R] = MC) AND (I+R <= Len) do                          
        Inc(R);                                                        
    Result := R;                                                       
  end;

  function InternationalDate(ForceCentury : Boolean) : AnsiString;
    {-Return a picture mask for a date AnsiString, based on Windows' int'l info}

    procedure FixMask(MC : ANSIChar; DL : Integer);
    var
      I, J, AL, D : Cardinal;                                          
      MCT : ANSIChar;
      OK  : Boolean;
    begin
      {find number of matching characters}
{$IFDEF WIN32}
      OK := StrChPosL(Result, MC, I);
{$ELSE}
      OK := StrChPosS(Result, MC, I);
{$ENDIF}
      MCT := MC;
      if not OK then begin
        MCT := UpCase(MC);
{$IFDEF WIN32}
        OK := StrChPosL(Result, MCT, I);
{$ELSE}
        OK := StrChPosS(Result, MCT, I);
{$ENDIF}
      end;
      if NOT OK then
        Exit;

      D := DL;                                                         
      {pad substring to desired length}
      AL := MaskCharCount(Result, MCT);
      if AL < D then                                                   
        for J := 1 to D-AL do                                          
{$IFDEF WIN32}
          Result := StrChInsertL(Result, MCT, I);
{$ELSE}
          Result := StrChInsertS(Result, MCT, I);
{$ENDIF}

      if MC <> YearOnly then begin
        {choose blank/zero padding}
        case AL of
          1 : if MCT = MC then
                Result := SubstCharSim(Result, MCT, UpCase(MCT));
          2 : if MCT <> MC then
                Result := SubstCharSim(Result, MCT, MC);
        end;
      end;
    end;

  begin
    {copy Windows mask into our var}
    Result := wShortDate;

    {if single Day marker, make double}
    FixMask(DayOnly, 2);

    {if single Month marker, make double}
    FixMask(MonthOnly, 2);

    {force yyyy if desired}
    FixMask(YearOnly, 2 shl Ord(ForceCentury));
  end;


  function InternationalLongDate(ShortNames : Boolean;
                                 ExcludeDOW : Boolean) : AnsiString;
    {-Return a picture mask for a date AnsiString, based on Windows' int'l info}
  var
    I, WC : Cardinal;
    OK,
    Stop : Boolean;
    Temp : String[81];

    function LongestMonthName : Integer;
    var
      L, I : Integer;
    begin
      L := 0;
      for I := 1 to 12 do
        L := Maxword(L, Length({$IfDef XE}FormatSettings.{$EndIf}LongMonthNames[I]));
      LongestMonthName := L;
    end;

    function LongestDayName : Integer;
    var
      D : TStDayType;
      L : Integer;
    begin
      L := 0;
      for D := Sunday to Saturday do
        L := Maxword(L, Length({$IfDef XE}FormatSettings.{$EndIf}LongDayNames[Ord(D)+1]));
      LongestDayName := L;
    end;

    procedure FixMask(MC : ANSIChar; DL : Integer);
    var
      I, J, AL, D : Cardinal;                                          
      MCT : ANSIChar;
    begin
      {find first matching mask character}
      OK := StrChPosS(Temp, MC, I);
      MCT := MC;
      if NOT OK then begin
        MCT := UpCase(MC);
        OK := StrChPosS(Temp, MCT, I);
      end;
      if NOT OK then
        Exit;

      D := DL;                                                         
      {pad substring to desired length}
      AL := MaskCharCount(Temp, MCT);
      if AL < D then begin                                             
        for J := 1 to D-AL do                                          
          Temp := StrChInsertS(Temp, MCT, I);
      end else if (AL > D) then                                        
        Temp := StrStDeleteS(Temp, I, AL-D);                           

      if MC <> YearOnly then
        {choose blank/zero padding}
        case AL of
          1 : if MCT = MC then
                Temp := SubstCharSim(Temp, MCT, UpCase(MCT));
          2 : if MCT <> MC then
                Temp := SubstCharSim(Temp, MCT, MC);
        end;
    end;

  begin
    {copy Windows mask into temporary var}
    Temp := wLongDate;

    if ExcludeDOW then begin
      {remove day-of-week and any junk that follows}
      if (StrChPosS(Temp, WeekDayOnly,I)) then begin
        Stop := False;
        WC := I+1;
        while (WC <= Length(Temp)) AND (NOT Stop) do
        begin
          if LoCase(Temp[WC]) in [MonthOnly,DayOnly,YearOnly,NameOnly] then
            Stop := TRUE
          else
            Inc(WC);
        end;
        if (NOT ShortNames) then
          Dec(WC);
        Temp := StrStDeleteS(Temp, I, WC);
      end;
    end
    else if ShortNames then
      FixMask(WeekDayOnly, 3)
    else if MaskCharCount(Temp, WeekdayOnly) = 4 then
      FixMask(WeekDayOnly, LongestDayName);

    {fix month names}
    if ShortNames then
      FixMask(NameOnly, 3)
    else if MaskCharCount(Temp, NameOnly) = 4 then
      FixMask(NameOnly, LongestMonthName);

    {if single Day marker, make double}
    FixMask(DayOnly, 2);

    {if single Month marker, make double}
    FixMask(MonthOnly, 2);

    {force yyyy}
    FixMask(YearOnly, 4);

    Result := Temp;
  end;

  function InternationalTime(ShowSeconds : Boolean) : AnsiString;
    {-Return a picture mask for a time AnsiString, based on Windows' int'l info}
  var
    ML,
    I  : Integer;
  begin
    {format the default AnsiString}

{$IFDEF WIN32}
    SetLength(Result,21);
{$ELSE}
    Result[0] := Chr(21);
{$ENDIF}
    Result := 'hh:mm:ss';
    if not wTLZero then
       Result[1] :=  HourOnlyU;

    {show seconds?}
    if not ShowSeconds then
{$IFDEF WIN32}
      SetLength(Result,5);
{$ELSE}
      Result[0] := Chr(5);
{$ENDIF}

    {handle international AM/PM markers}
    if w12Hour then begin
      ML := Maxword(Length(w1159), Length(w2359));
      if (ML <> 0) then begin
        AppendChar(Result,' ');
        for I := 1 to ML do
          AppendChar(Result, TimeOnly);
      end;
    end;
  end;

  procedure SetDefaultYear;
    {-Initialize DefaultYear and DefaultMonth}
  var
    Month, Day : Word;
    T : TDateTime;
    W : Word;
  begin
    T := Now;
    W := DefaultYear;
    DecodeDate(T,W,Month,Day);
    DefaultYear := W;
    DefaultMonth := Month;
  end;

  procedure ResetInternationalInfo;
  var
    I : Integer;
    S : array[0..20] of AnsiChar;

    procedure ExtractSubString(SubChar : ANSIChar; Dest : AnsiString);
    var
      I, L, P : Cardinal;
    begin
{$IFDEF WIN32}
      SetLength(Dest,sizeof(wldSub1));
{$ELSE}
      Dest[0] := Chr(sizeof(wldSub1));
{$ENDIF}
      FillChar(Dest[1], SizeOf(wldSub1), 0);
      if NOT (StrChPosS(wLongDate, '''',I)) then
        Exit;

      {delete the first quote}
      wLongDate := StrChDeleteS(wLongDate, I);

      {assure that there is another quote}
      if NOT (StrChPosS(wLongDate, '''',P)) then
        Exit;

      {copy substring into Dest, replace substring with SubChar}
      L := 1;
      while wLongDate[I] <> '''' do
        if L < SizeOf(wldSub1) then begin
          Dest[L] := wLongDate[I];
          Inc(L);
          wLongDate[I] := SubChar;
          Inc(I);
        end else
          wLongDate := StrChDeleteS(wLongDate, I);

      {delete the second quote}
      wLongDate := StrChDeleteS(wLongDate, I);
    end;

  begin
    wTLZero := {$IfDef XE}FormatSettings.{$EndIf}LongTimeFormat[2] = 'h';
    w12Hour := {$IfDef XE}FormatSettings.{$EndIf}LongTimeFormat[length({$IfDef XE}FormatSettings.{$EndIf}LongTimeFormat)] = 'M';

    wColonChar := AnsiChar({$IfDef XE}FormatSettings.{$EndIf}TimeSeparator);
    wSlashChar := AnsiChar({$IfDef XE}FormatSettings.{$EndIf}DateSeparator);

    GetProfileStringA('intl','s1159','AM', S, SizeOf(S));
    w1159 := StrPas(S);
    GetProfileStringA('intl','s2359','PM', S, SizeOf(S));
    w2359 := StrPas(S);

    {get short date mask and fix it up}
    wShortDate := {$IfDef XE}FormatSettings.{$EndIf}ShortDateFormat;
    for I := 1 to Length(wShortDate) do
      if (wShortDate[I] = wSlashChar) then
        wShortDate[I] := '/';

    {get long date mask and fix it up}
    wLongDate := {$IfDef XE}FormatSettings.{$EndIf}LongDateFormat;
    ExtractSubString(LongDateSub1, wldSub1);
    ExtractSubString(LongDateSub2, wldSub2);
    ExtractSubString(LongDateSub3, wldSub3);

    {replace ddd/dddd with www/wwww}
    I := pos('ddd',wLongDate);
    if I > 0 then begin
      while wLongDate[I] = 'd' do begin
        wLongDate[I] := 'w';
        Inc(I);
      end;
    end;

    {replace MMM/MMMM with nnn/nnnn}
    if pos('MMM',wLongDate) > 0 then
      while (pos('M',wLongDate) > 0) do
        wLongDate[pos('M',wLongDate)] := 'n';

    {deal with oddities concerning . and ,}
    for I := 1 to Length(wLongDate)-1 do begin
      case wLongDate[I] of
        '.', ',' :
          if wLongDate[I+1] <> ' ' then
            wLongDate := StrChInsertS(wLongDate, ' ', I+1);
      end;
    end;
  end;


initialization
  {initialize DefaultYear and DefaultMonth}
  SetDefaultYear;
  ResetInternationalInfo;
end.