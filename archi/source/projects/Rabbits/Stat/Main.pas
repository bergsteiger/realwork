unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, l3Types, l3Base, OvcBase,  W95Meter;

type
  TMainForm = class(TForm)
    btStart: TButton;
    btStartAll: TButton;
    btStartLong: TButton;
    Meter: TvtW95Meter;
    Controller: TOvcController;
    procedure btStartClick(Sender: TObject);
    procedure btStartAllClick(Sender: TObject);
    procedure btStartLongClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  ActiveX,
  COMObj,

  l3Chars,
  l3String,
  l3Filer,
  l3KeyWrd,

  m2COMLib,

  m3IndexConst,
  m3StorageInterfaces,
  m3StgCla,
  m3StorageTools,
  m3StgMgr,
  m3IdxCla,
  m3DocumentAddress
  ;

{$R *.dfm}

procedure TMainForm.btStartClick(Sender: TObject);
var
 l_TextIndex : Im3IndexedStorage;
 l_HashInfo  : Tm3HashInfoStream;
 l_Word      : WideString;
 l_Hist      : Tl3LongintList;
 l_Length    : Long;
 l_Total     : Long;
 l_Filer     : Tl3DOSFiler;
 l_Index     : Long;
 l_Percent   : Double;
 l_TotalPercent : Double;
begin
 l_TextIndex := Tm3ReadModeStorageManager.MakeInterface('N:\Bases\Stat\bserv001.idx');
 try
  l_HashInfo := Tm3HashInfoStream.Create(
                  m3COMOpenStream(l_TextIndex,
                                  l3PCharLen(WideString(m3HashInfoName)),
                                  STGM_READ or STGM_SHARE_EXCLUSIVE,
                                  false), STGM_READ);
  try
   l_Hist := Tl3LongintList.Create;
   try
    l_Total := 0;
    while (m3ReadWideString(l_HashInfo, l_Word) = S_Ok) do begin
     l_Length := Length(l_Word);
     if (l_Length > 0) then begin
      Inc(l_Total);
      Dec(l_Length);
      with l_Hist do begin
       if (l_Length > Hi) then
        Count := Succ(l_Length);
       Items[l_Length] := Succ(Items[l_Length]);
      end;//with l_Hist
     end;//Length > 0
 //    l_DeltaWords.SearchBranchHandle(l_Word, nil);
    end;//while (m3ReadWideString(l_HashInfo, l_Word) = S_Ok)
    l_Filer := Tl3DOSFiler.Make('N:\Bases\Stat\stat.lst ', l3_fmWrite, false);
    try
     l_Filer.Open;
     if (l_Total > 0) then begin
      l_TotalPercent := 0.0;
      with l_Hist do
       for l_Index := Lo to Hi do begin
        l_Percent := Items[l_Index] / l_Total * 100;
        l_TotalPercent := l_TotalPercent + l_Percent;
        l_Filer.WriteLn(Format('%d'#9'%.5f%%'#9'%.5f%%', [Succ(l_Index), l_Percent, l_TotalPercent]));
       end;//for l_Index
     end;//l_Total > 0
    finally
     l3Free(l_Filer);
    end;//try..finally
   finally
    l3Free(l_Hist);
   end;//try..finally
  finally
   l3Free(l_HashInfo);
  end;//try..finally
 finally
  l_TextIndex := nil;
 end;//try..finally
end;

procedure TMainForm.btStartAllClick(Sender: TObject);

var
 l_Total  : Int64;
 l_Hist   : Tl3LongintList;
 l_InHash : Im3IndexedStorage;

 function DoHash(const aStoreInfo: Tm3StoreInfo; anIndex: Long): Bool;

 var
  l_InHashElement : Im3IndexedStorage;

  function DoWord(const aStoreInfo : Tm3StorageElementInfo): Bool;
  var
   l_Length       : Long;
   l_InWordStream : IStream;
   l_Count        : Int64;
  begin
   Result := true;
   l_Length := aName.SLen;
   if (l_Length > 0) then begin
    with aStoreInfo do
     l_InWordStream := IStream(
                         l_InHashElement.OpenStore(rPosition,
                                                   STGM_READ or STGM_SHARE_EXCLUSIVE,
                                                   aName,
                                                   rStoreType));
    try
     l_Count := m2COMGetSize(l_InWordStream) div SizeOf(Tm3DocumentAddress);
    finally
     l_InWordStream := nil;
    end;//try..finally
    Inc(l_Total, l_Count);
    Dec(l_Length);
    with l_Hist do begin
     if (l_Length > Hi) then
      Count := Succ(l_Length);
     Items[l_Length] := Items[l_Length] + l_Count;
    end;//with l_Hist
   end;//l_Length > 0
  end;

 begin//DoHash
  Result := true;
  with aStoreInfo do
   l_InHashElement := Im3IndexedStorage(
                       l_InHash.OpenStore(rPosition,
                                          STGM_READ or STGM_SHARE_EXCLUSIVE,
                                          anIndex,
                                          rStoreType));
  try
   l_InHashElement.IterateF(m3L2SEA(@DoWord));
  finally
   l_InHashElement := nil;
  end;//try..finally
 end;//DoHash

var
 l_TextIndex    : Im3IndexedStorage;
 l_Filer        : Tl3DOSFiler;
 l_Index        : Long;
 l_Percent      : Double;
 l_TotalPercent : Double;
begin
 l_TextIndex := Tm3ReadModeStorageManager.MakeInterface('N:\Bases\Stat\bserv001.idx');
 try
  l_Hist := Tl3LongintList.Create;
  try
   l_InHash := m3COMOpenStorage(l_TextIndex,
                                l3PCharLen(WideString(m3HashDataName)),
                                STGM_READ or STGM_SHARE_EXCLUSIVE,
                                false);
   try
    l_Total := 0;
    l_InHash.IterateF(m3L2SA(@DoHash));
   finally
    l_InHash := nil;
   end;//try..finally
   l_Filer := Tl3DOSFiler.Make('N:\Bases\Stat\statall.lst ', l3_fmWrite, false);
   try
    l_Filer.Open;
    if (l_Total > 0) then begin
     l_TotalPercent := 0.0;
     with l_Hist do
      for l_Index := Lo to Hi do begin
       l_Percent := Items[l_Index] / l_Total * 100;
       l_TotalPercent := l_TotalPercent + l_Percent;
       l_Filer.WriteLn(Format('%d'#9'%.5f%%'#9'%.5f%%', [Succ(l_Index), l_Percent, l_TotalPercent]));
      end;//for l_Index
    end;//l_Total > 0
   finally
    l3Free(l_Filer);
   end;//try..finally
  finally
   l3Free(l_Hist);
  end;//try..finally
 finally
  l_TextIndex := nil;
 end;//try..finally
end;

procedure TMainForm.btStartLongClick(Sender: TObject);

var
 l_Hist   : Tl3VList;
 l_InHash : Im3IndexedStorage;
 l_ConvertBuff : PChar;

 function DoHash(const aStoreInfo: Tm3StoreInfo; anIndex: Long): Bool;

 var
  l_InHashElement : Im3IndexedStorage;

  function DoWord(const aStoreInfo : Tm3StorageElementInfo): Bool;
  var
   l_Length       : Long;
   l_InWordStream : IStream;
   l_Read         : Int64;
   l_PrevDoc      : Long;
   l_Address      : Tm3DocumentAddress;
   l_Code         : hResult;
   l_Count        : Long;
   l_Keyword      : Tl3KeyWord;
  begin
   Result := true;
   l_Count := 0;
   l_Length := aName.SLen;
   if (l_Length > 0) then begin
    with aStoreInfo do
     l_InWordStream := IStream(
                         l_InHashElement.OpenStore(rPosition,
                                                   STGM_READ or STGM_SHARE_EXCLUSIVE,
                                                   aName,
                                                   rStoreType));
    try
     if l_Hist.Empty OR
        (m2COMGetSize(l_InWordStream) div SizeOf(Tm3DocumentAddress) >= Tl3KeyWord(l_Hist.First).Handle) then begin
      l_PrevDoc := -1;
      while true do begin
       l_Code := l_InWordStream.Read(@l_Address, SizeOf(l_Address), @l_Read);
       if (l_Code = S_False) then
        break;
       OleCheck(l_Code);
       if (l_Address.rDocument <> l_PrevDoc) then begin
        Inc(l_Count);
        l_PrevDoc := l_Address.rDocument;
       end;//l_Address.rDocument <> l_PrevDoc
      end;//while true
     end;//l_Hist.Empty..
    finally
     l_InWordStream := nil;
    end;//try..finally
    if (l_Count > 0) then begin
     with l_Hist do begin
      if (Count < 100) then begin
       l_Keyword := Tl3KeyWord.Create(l3PCharLen2String(aName, CP_ANSI, @l_ConvertBuff), l_Count);
       try
        Add(l_Keyword);
       finally
        l3Free(l_Keyword);
       end;//try..finally
      end else begin
       if (Tl3KeyWord(First).Handle < l_Count) then begin
        l_Keyword := Tl3KeyWord.Create(l3PCharLen2String(aName, CP_ANSI, @l_ConvertBuff), l_Count);
        try
         Delete(0);
         Add(l_Keyword);
        finally
         l3Free(l_Keyword);
        end;//try..finally
       end;//Tl3KeyWord(First).Handle < l_Count
      end;//Count < 100
     end;//with l_Hist
    end;//l_Count > 0 
   end;//l_Length > 0
  end;

 begin//DoHash
  Result := true;
  Meter.ProgressProc_ev(piCurrent, anIndex, '');
  Application.ProcessMessages;
  with aStoreInfo do
   l_InHashElement := Im3IndexedStorage(
                       l_InHash.OpenStore(rPosition,
                                          STGM_READ or STGM_SHARE_EXCLUSIVE,
                                          anIndex,
                                          rStoreType));
  try
   l_InHashElement.IterateF(m3L2SEA(@DoWord));
  finally
   l_InHashElement := nil;
  end;//try..finally
 end;//DoHash

var
 l_TextIndex    : Im3IndexedStorage;
 l_Filer        : Tl3DOSFiler;
 l_Index        : Long;
begin
 l_ConvertBuff := nil;
 try
  l_TextIndex := Tm3ReadModeStorageManager.MakeInterface('N:\Bases\Stat\bserv001.idx');
  try
   l_Hist := Tl3VList.MakePersistentSorted(l3_dupAccept, l3_siByID);
   try
    l_InHash := m3COMOpenStorage(l_TextIndex,
                                 l3PCharLen(WideString(m3HashDataName)),
                                 STGM_READ or STGM_SHARE_EXCLUSIVE,
                                 false);
    try
     Meter.ProgressProc_ev(piStart, 16383, '—бор статистики');
     try
      l_InHash.IterateF(m3L2SA(@DoHash));
     finally
      Meter.ProgressProc_ev(piEnd, 0, '');
     end;//try..finally
    finally
     l_InHash := nil;
    end;//try..finally
    l_Filer := Tl3DOSFiler.Make('N:\Bases\Stat\stat100.lst ', l3_fmWrite, false);
    try
     l_Filer.Open;
     with l_Hist do
      for l_Index := Lo to Hi do begin
       with Tl3KeyWord(Items[l_Index]) do
        l_Filer.WriteLn(Format('%d'#9'%s', [Handle, AsString]));
      end;//for l_Index
    finally
     l3Free(l_Filer);
    end;//try..finally
   finally
    l3Free(l_Hist);
   end;//try..finally
  finally
   l_TextIndex := nil;
  end;//try..finally
 finally
  l3System.FreeLocalMem(l_ConvertBuff);
 end;//try..finally
end;

end.
