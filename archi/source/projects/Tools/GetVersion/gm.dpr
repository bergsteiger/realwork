program gm;

{$APPTYPE CONSOLE}

{$R VERSIONINFO.RES}

uses
  TypInfo,
  
  ActiveX,

  SysUtils,

  l3Types,
  l3Base,
  l3Stream,
  l3FileUtils,

  m3StorageInterfaces,
  m3DBInterfaces,
  m3BackupTools,
  m3DB,
  
  JwaWinBase in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'W:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
  ;

procedure Execute;  
const
 cName = 'bserv001';
var
 l_Stream    : IStream;
 l_BaseName  : String;
 l_OutStream : Tl3FileStream;
 l_Summ      : Tm3BaseSummary;
 l_Read      : Int64;
 l_Written   : Int64;
 l_Base      : Im3IndexedStorage;
 l_Part      : Tm3DocPartSelector;
 l_OutDir    : String;
 l_DB        : Im3DB;
begin//Execute
 WriteLn('Archi documents extractor. Alex W. Lulin.');
 if (ParamCount < 1) OR ANSISameText(ParamStr(1), '-h') OR ANSISameText(ParamStr(1), '-?') then
 begin
  WriteLn('usage: gm DocID | -stat | -all [BaseName | #] [OutputDir]');
 end//ParamCount < 1
 else
 begin
  try
   if (ParamCount < 2) then
    l_BaseName := ''
   else
    l_BaseName := ParamStr(2);
   if (ParamCount < 3) then
    l_OutDir := ''
   else
    l_OutDir :=  ParamStr(3);
   if (l_BaseName = '') OR (l_BaseName = '#') then
    l_BaseName := cName;
   if (l_BaseName[Length(l_BaseName)] = '\') then
    l_BaseName := l_BaseName + cName;
   if ANSISameText(ParamStr(1), '-all') then
   begin
    Tm3DB.Make(l_BaseName).ExtractMainTo(l_OutDir);
    Exit;
   end;//ANSISameText(ParamStr(1), '-all')
   if ANSISameText(ParamStr(1), '-stat') then
   begin
    l_Base := Tm3DB.Make(l_BaseName).MainStorage(m3_saRead);
    try
     if m3GetBaseSummary(l_Base, l_Summ) then
     begin
      WriteLn('Min = ', l_Summ.rMin);
      WriteLn('Max = ', l_Summ.rMax);
     end//l_Stream.Read
     else
      WriteLn('No stat');
    finally
     l_Base := nil;
    end;//try..finally
   end//ANSISameText(ParamStr(1), '-stat')
   else
   begin
    l_DB := Tm3DB.Make(l_BaseName);
    for l_Part := Low(Tm3DocPartSelector) to High(Tm3DocPartSelector) do
    begin
     l_Stream := l_DB.GetDocument(StrToInt(ParamStr(1))).GetConst.Open(m3_saRead, l_Part);
     //l_Stream := m3GetMain(l_Base, StrToInt(ParamStr(1)), l_Part);
     try
      if (l_Stream = nil) then
       WriteLn(Format('No such document %s %s', [ParamStr(1), GetEnumName(TypeInfo(Tm3DocPartSelector), Ord(l_Part))]))
      else
      begin
       if (l_Part = m3_defDocPart) then
        l_OutStream := Tl3FileStream.Create(ConcatDirName(l_OutDir, ParamStr(1) + '.main.evd'), l3_fmWrite)
       else
        l_OutStream := Tl3FileStream.Create(ConcatDirName(l_OutDir, ParamStr(1) + '.' + m3_cDocPartName[l_Part] + '.evd'), l3_fmWrite);
       try
        l_Stream.CopyTo(l3Stream2IStream(l_OutStream), High(Int64), l_Read, l_Written);
        WriteLn('Read: ', l_Read);
        WriteLn('Written: ', l_Written);
       finally
        l3Free(l_OutStream);
       end;//try..finally
      end;//l_Stream = nil
     finally
      l_Stream := nil;
     end;//try..finally
    end;//for l_Part
   end;//ANSISameText(ParamStr(1), '-stat'
  except
   on E : Exception do
    WriteLn(E.Message);
  end;//try..except
 end;//ParamCount <= 0
end;//Execute

begin
 Execute;
end.
