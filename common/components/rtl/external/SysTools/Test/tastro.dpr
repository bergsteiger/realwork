{*********************************************************}
{*                   TASTRO.DPR 1.05                     *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$IFDEF Win32}
{$APPTYPE CONSOLE}
{$ENDIF}

program Tastro;

uses
{$IFNDEF Win32}
WinCrt,
{$ENDIF}

StConst,
StDate,
StDateSt,
StAstro,
StAstroP;

var
  F         : Text;
  TheDT     : TStDateTimeRec;
  RS        : TStRiseSetRec;
  PA        : TStPlanetsArray;


procedure DoDivider;
begin
  writeln(F);
  writeln(F,'===============================================================');
  writeln(F);
end;


procedure DoFixedCalcs(S : String);
var
  Y,
  M ,
  D    : integer;
  DTR  : TStDateTimeRec;
  MPR  : TStMoonPosRec;
  SPR  : TStPosRec;
  TS   : String;
  LR   : TStLunarRecord;
  PA   : TStPlanetsArray;

begin
  writeln(F, S);
  writeln(F);

  TheDT.D := CurrentDate;
  TheDT.T := CurrentTime;

{--------------------------------------------------------------------------}

  TS := CurrentTimeString('hh:mm:ss', False) + ' = '
      + HoursMin(SiderealTime(TheDT)) + ' sidereal time';
  writeln(F, TS);
  writeln(F);

{--------------------------------------------------------------------------}

  SPR := SunPos(TheDT);
  writeln(F, 'Sun Position:  RA:  ' + HoursMin(SPR.RA));
  writeln(F, '               DC: ' + DegsMin(SPR.DC));
  writeln(F);

{--------------------------------------------------------------------------}

  MPR := MoonPos(TheDT);
  writeln(F, 'Moon Position:  RA:  ' + HoursMin(MPR.RA));
  writeln(F, '                DC: ' + DegsMin(MPR.DC));
  writeln(F);

{--------------------------------------------------------------------------}

  if LunarPhase(TheDT) >= 0 then
    writeln(F, 'The moon is waxing')
  else
    writeln(F, 'The moon is waning');
  writeln(F);

{--------------------------------------------------------------------------}

  LR := NewMoon(TheDT.D);
  TS := 'New Moon: '
      + StDateToDateString('mm/dd/yyyy', LR.T[0].D, False)
          + ' @ ' + StTimeToTimeString('hh:mm', LR.T[0].T, False);
  writeln(F, TS);
  if LR.T[1].D <> BadDate then
  begin
    TS := 'New Moon: '
        + StDateToDateString('mm/dd/yyyy', LR.T[1].D, False)
        + ' @ ' + StTimeToTimeString('hh:mm', LR.T[1].T, False);

  end else
    TS := 'Only one New Moon this month';
  writeln(F, TS);
  writeln(F);

{--------------------------------------------------------------------------}

  LR := FirstQuarter(TheDT.D);
  TS := 'First Quarter: '
      + StDateToDateString('mm/dd/yyyy', LR.T[0].D, False)
          + ' @ ' + StTimeToTimeString('hh:mm', LR.T[0].T, False);
  writeln(F, TS);
  if LR.T[1].D <> BadDate then
  begin
    TS := 'First Quarter: '
        + StDateToDateString('mm/dd/yyyy', LR.T[1].D, False)
        + ' @ ' + StTimeToTimeString('hh:mm', LR.T[1].T, False);

  end else
    TS := 'Only one First Quarter this month';
  writeln(F, TS);
  writeln(F);

{--------------------------------------------------------------------------}

  LR := FullMoon(TheDT.D);
  TS := 'Full Moon: '
      + StDateToDateString('mm/dd/yyyy', LR.T[0].D, False)
          + ' @ ' + StTimeToTimeString('hh:mm', LR.T[0].T, False);
  writeln(F, TS);
  if LR.T[1].D <> BadDate then
  begin
    TS := 'Full Moon: '
        + StDateToDateString('mm/dd/yyyy', LR.T[1].D, False)
        + ' @ ' + StTimeToTimeString('hh:mm', LR.T[1].T, False);

  end else
    TS := 'Only one Full Moon this month';
  writeln(F, TS);
  writeln(F);

{--------------------------------------------------------------------------}

  LR := LastQuarter(TheDT.D);
  TS := 'Last Quarter: '
      + StDateToDateString('mm/dd/yyyy', LR.T[0].D, False)
          + ' @ ' + StTimeToTimeString('hh:mm', LR.T[0].T, False);
  writeln(F, TS);
  if LR.T[1].D <> BadDate then
  begin
    TS := 'Last Quarter: '
        + StDateToDateString('mm/dd/yyyy', LR.T[1].D, False)
        + ' @ ' + StTimeToTimeString('hh:mm', LR.T[1].T, False);

  end else
    TS := 'Only one Last Quarter this month';
  writeln(F, TS);
  writeln(F);


{--------------------------------------------------------------------------}

  DTR := PrevNewMoon(CurrentDate);
  if DTR.D <> BadDate then
      writeln(F, 'Prev NM: ' + StDateToDateString('mm/dd/yyyy', DTR.D, False)
         + ' @ ' + StTimeToTimeString('hh:mm:ss', DTR.T, False));

{--------------------------------------------------------------------------}

  DTR := NextNewMoon(CurrentDate);
  if DTR.D <> BadDate then
    writeln(F, 'Next NM: ' + StDateToDateString('mm/dd/yyyy', DTR.D, False)
       + ' @ ' + StTimeToTimeString('hh:mm:ss', DTR.T, False));
  writeln(F);

{--------------------------------------------------------------------------}

  DTR := PrevFirstQuarter(CurrentDate);
  if DTR.D <> BadDate then
      writeln(F, 'Prev FQ: ' + StDateToDateString('mm/dd/yyyy', DTR.D, False)
         + ' @ ' + StTimeToTimeString('hh:mm:ss', DTR.T, False));

  DTR := NextFirstQuarter(CurrentDate);
  if DTR.D <> BadDate then
    writeln(F, 'Next FQ: ' + StDateToDateString('mm/dd/yyyy', DTR.D, False)
       + ' @ ' + StTimeToTimeString('hh:mm:ss', DTR.T, False));
  writeln(F);

{--------------------------------------------------------------------------}

  DTR := PrevFullMoon(CurrentDate);
  if DTR.D <> BadDate then
      writeln(F, 'Prev FM: ' + StDateToDateString('mm/dd/yyyy', DTR.D, False)
         + ' @ ' + StTimeToTimeString('hh:mm:ss', DTR.T, False));

  DTR := NextFullMoon(CurrentDate);
  if DTR.D <> BadDate then
    writeln(F, 'Next FM: ' + StDateToDateString('mm/dd/yyyy', DTR.D, False)
       + ' @ ' + StTimeToTimeString('hh:mm:ss', DTR.T, False));
  writeln(F);

{--------------------------------------------------------------------------}

  DTR := PrevLastQuarter(CurrentDate);
  if DTR.D <> BadDate then
      writeln(F, 'Prev LQ: ' + StDateToDateString('mm/dd/yyyy', DTR.D, False)
         + ' @ ' + StTimeToTimeString('hh:mm:ss', DTR.T, False));

  DTR := NextLastQuarter(CurrentDate);
  if DTR.D <> BadDate then
    writeln(F, 'Next LQ: ' + StDateToDateString('mm/dd/yyyy', DTR.D, False)
       + ' @ ' + StTimeToTimeString('hh:mm:ss', DTR.T, False));

  writeln(F);
  writeln(F);

{--------------------------------------------------------------------------}


  PlanetsPos(AstJulianDate(TheDT.D) + TheDT.T/86400, PA);
  writeln(F, 'Positions of the planets:');
  writeln(F);
  writeln(F, 'Planet      RA          DC');
  writeln(F, '-----------------------------');
  writeln(F, 'Mercury   ', HoursMin(PA[1].RA), '   ', DegsMin(PA[1].DC));
  writeln(F, 'Venus     ', HoursMin(PA[2].RA), '   ', DegsMin(PA[2].DC));
  writeln(F, 'Mars      ', HoursMin(PA[3].RA), '   ', DegsMin(PA[3].DC));
  writeln(F, 'Jupiter   ', HoursMin(PA[4].RA), '   ', DegsMin(PA[4].DC));
  writeln(F, 'Saturn    ', HoursMin(PA[5].RA), '   ', DegsMin(PA[5].DC));
  writeln(F, 'Uranus    ', HoursMin(PA[6].RA), '   ', DegsMin(PA[6].DC));
  writeln(F, 'Neptune   ', HoursMin(PA[7].RA), '   ', DegsMin(PA[7].DC));

  writeln(F);

{--------------------------------------------------------------------------}

  StDateToDMY(CurrentDate, D, M, Y);
  writeln(F, 'Easter: ' ,
          StDateToDateString('mm/dd', Easter(Y, 0), False));
  writeln(F);

{--------------------------------------------------------------------------}

  DTR := Equinox(Y, 0, True);
  writeln(F, 'Spring: ' , StDateToDateString('mm/dd', DTR.D, False), ' @ ',
          StTimeToTimeString('hh:mm', DTR.T, False));
  writeln(F);

{--------------------------------------------------------------------------}

  DTR := Equinox(Y, 0, False);
  writeln(F, 'Autumn: ' , StDateToDateString('mm/dd', DTR.D, False), ' @ ',
          StTimeToTimeString('hh:mm', DTR.T, False));
  writeln(F);

{--------------------------------------------------------------------------}

  DTR := Solstice(Y, 0, True);
  writeln(F, 'Summer: ' , StDateToDateString('mm/dd', DTR.D, False), ' @ ',
          StTimeToTimeString('hh:mm', DTR.T, False));
  writeln(F);

{--------------------------------------------------------------------------}

  DTR := Solstice(Y, 0, False);
  writeln(F, 'Winter: ' , StDateToDateString('mm/dd', DTR.D, False), ' @ ',
          StTimeToTimeString('hh:mm', DTR.T, False));
  writeln(F);
end;



procedure DoCalcs(S : String; ObsLong, ObsLat : Double);
begin
  writeln(F, S);
  writeln(F);

  TheDT.D := CurrentDate;
  TheDT.T := CurrentTime;

  writeln(F, 'Amount of Sunlight: ', StTimeToTimeString('hh:mm',
              AmountOfSunlight(TheDT.D, ObsLong, ObsLat), False));
  writeln(F);

  RS := MoonRiseSet(TheDT.D, ObsLong, ObsLat);
  writeln(F, 'Moon Rise: ',
          StTimeToTimeString('hh:mm', RS.ORise, False));
  writeln(F, 'Moon Set:  ',
          StTimeToTimeString('hh:mm', RS.OSet, False));
  writeln(F);

  RS := SunRiseSet(TheDT.D, ObsLong, ObsLat);
  writeln(F, 'Sun Rise:  ',
          StTimeToTimeString('hh:mm', RS.ORise, False));
  writeln(F, 'Sun Set:   ',
          StTimeToTimeString('hh:mm', RS.OSet, False));
  writeln(F);


  RS := Twilight(TheDT.D, ObsLong, ObsLat, ttAstronomical);
  writeln(F, 'Twilight (Astronomical)');
  writeln(F, 'Start: ',
          StTimeToTimeString('hh:mm', RS.ORise, False));
  writeln(F, 'End:   ',
          StTimeToTimeString('hh:mm', RS.OSet, False));
  writeln(F);
end;


begin
  AssignFile(F, 'ASTRO.TXT');
  ReWrite(F);

  DoFixedCalcs('Data for ' + CurrentDateString('mm/dd/yyyy', False));
  DoDivider;

  writeln('Test run for Florissant, CO');
  DoCalcs('Test run for Florissant, CO', -105.27, 38.82);
  DoDivider;

  writeln('Test run for Adelaide, South Australia');
  DoCalcs('Test run for Adelaide, South Australia', 140.00, -34.00);
  DoDivider;

  writeln('Test run for Quito, Equador');
  DoCalcs('Test run for Quito, Equador', -78, 0.00);


  Close(F);
  writeln('Press <Enter> to continue');
  readln;
end.

