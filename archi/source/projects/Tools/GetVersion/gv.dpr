program gv;

{$APPTYPE CONSOLE}
{$R VERSIONINFO.RES}

uses
  ActiveX,

  SysUtils,
  StrUtils,

  l3Types,
  l3Base,
  l3Stream,
  l3FileUtils,

  m3DBInterfaces,
  m3BackupTools
  ,
  m3StorageInterfaces,
  m3DB,
  m3StorageTools,
  
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
 l_Level     : Long;
 l_OutStream : Tl3FileStream;
 l_Read      : Int64;
 l_Written   : Int64;
 l_Summ      : Tm3BaseSummary;
 l_Part      : Tm3DocPartSelector;
 l_Storage   : Im3IndexedStorage;
 l_DocStorage : Im3IndexedStorage;
 l_OutDir    : String;
 l_DocID     : Integer;
 l_DB        : Im3DB;
begin//Execute
 WriteLn('Archi documents version extractor. Alex W. Lulin.');
 if (ParamCount < 1) OR ANSISameText(ParamStr(1), '-h') OR ANSISameText(ParamStr(1), '-?') then
 begin
  WriteLn('usage: gv DocID | -stat | -all [BaseName | #] [Version Level | -all] [OutputDir] [-backup]');
 end
 else
 begin
  try
   if (ParamCount < 2) then
    l_BaseName := ''
   else
    l_BaseName := ParamStr(2);
   if (l_BaseName = '') OR (l_BaseName = '#') then
    l_BaseName := cName;
   if (l_BaseName[Length(l_BaseName)] = '\') then
    l_BaseName := l_BaseName + cName;

   if ANSISameText(ParamStr(1), '-all') then
   begin
    if (ParamCount < 3) then
     l_OutDir := ''
    else
     l_OutDir :=  ParamStr(3);
    if (ParamCount > 3) AND ANSISameText(ParamStr(4), '-backup') then
     Tm3DB.Make(l_BaseName).ExtractBackupTo(l_OutDir)
    else
     Tm3DB.Make(l_BaseName).ExtractVersionTo(l_OutDir);
    Exit;
   end;//ANSISameText(ParamStr(1), '-all')

   if (ParamCount < 4) then
    l_OutDir := ''
   else
    l_OutDir :=  ParamStr(4);
   if ANSISameText(ParamStr(1), '-stat') then
   begin
    if m3GetBaseSummary(Tm3DB.Make(l_BaseName).GetVersionsStorage(m3_saRead), l_Summ) then
    begin
     WriteLn('Min = ', l_Summ.rMin);
     WriteLn('Max = ', l_Summ.rMax);
    end//l_Stream.Read
    else
     WriteLn('No stat');
   end//..'-stat'..
   else
   begin
    l_DocID := StrToInt(ParamStr(1));
    if ANSISameText(ParamStr(3), '-all') then
    begin
     if (ParamCount > 4) AND ANSISameText(ParamStr(5), '-backup') then
      l_Storage := Tm3DB.Make(l_BaseName).GetBackupStorage(m3_saRead)
     else
      l_Storage := Tm3DB.Make(l_BaseName).GetVersionsStorage(m3_saRead);
     try
      l_DocStorage := m3COMOpenStorage(l_Storage,
                                       l_DocID,
                                       m3_saRead,
                                       false);
      try
       m3ExtractStorage(l_DocStorage, ConcatDirName(l_OutDir, IntToStr(l_DocID)));
      finally
       l_DocStorage := nil;
      end;//try..finally
     finally
      l_Storage := nil;
     end;//try..finally
     Exit;
    end;//ANSISameText(ParamStr(3), '-all')
    if (ParamCount < 3) then
     l_Level := 0
    else
     l_Level := StrToInt(ParamStr(3));

    l_DB := Tm3DB.Make(l_BaseName);
     
    for l_Part := Low(Tm3DocPartSelector) to High(Tm3DocPartSelector) do
    begin
     //l_Storage := m3GetVersionsStorage(l_BaseName, False, m3_saRead);
     //if l_Storage <> nil then
     try
      l_Stream := l_DB.GetDocument(l_DocID).GetVersion(l_Level).Open(m3_saRead, l_Part);
      //l_Stream := m3GetVersionForRead(l_Storage, l_DocID, True, l_Part, 0, l_Level);
      try
       if (l_Stream <> nil) then
       begin
        if (l_Part = m3_defDocPart) then
         l_OutStream := Tl3FileStream.Create(ConcatDirName(l_OutDir, ParamStr(1) + '.' + IntToStr(l_Level) + '.evd'), l3_fmWrite)
        else
         l_OutStream := Tl3FileStream.Create(ConcatDirName(l_OutDir, ParamStr(1) + '.' + IntToStr(l_Level) + '.' + m3_cDocPartName[l_Part] + '.evd'), l3_fmWrite);
        try
         l_Stream.CopyTo(l3Stream2IStream(l_OutStream), High(Int64), l_Read, l_Written);
         WriteLn('Read: ', l_Read);
         WriteLn('Written: ', l_Written);
        finally
         l3Free(l_OutStream);
        end;//try..finally
       end;//l_Stream <> nil
      finally
       l_Stream := nil;
      end;//try..finally
     finally
      l_Storage := nil;
     end;//try..finally, if l_Storage <> nil
    end;//for l_Part
   end;//..'-stat'.. 
  except
   on E : Exception do
    WriteLn(E.Message);
  end;//try..except
 end;//ParamCount <= 0
end;//Execute

begin
 Execute;
end.
