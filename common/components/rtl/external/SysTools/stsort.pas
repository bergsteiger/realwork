{*********************************************************}
{*                   STSORT.PAS 3.01                     *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{Notes:
  The sequence to sort data is this:

     Sorter := TStSorter.Create(MaxHeap, RecLen);
     Sorter.Compare := ACompareFunction;
     repeat
       ... obtain ADataRecord from somewhere ...
       Sorter.Put(ADataRecord);
     until NoMoreData;
     while Sorter.Get(ADataRecord) do
       ... do something with ADataRecord ...
     Sorter.Free;

  While Put is called, the sorter buffers as many records as it can fit in
  MaxHeap.  When that space is filled, it sorts the buffer and stores that
  buffer to a temporary merge file. When Get is called, the sorter sorts the
  last remaining buffer and starts either returning the records from the
  buffer (if all records fit into memory) or merging the files and returning
  the records from there.

  The Compare function can be used as a place to display status and to abort
  the sort. It is not possible to accurately predict the total number of
  times Compare will be called, but it is called very frequently throughout
  the sort. To abort a sort from the Compare function, just raise an
  exception there.

  The Reset method can be called to sort another set of data of the same
  record length. Once Get has been called, Put cannot be called again unless
  Reset is called first.

  There is no default Compare function. One must be assigned after creating
  a TStSorter and before calling Put. Otherwise an exception is raised the
  first time a Compare function is needed.

  In Win32, if Create cannot allocate MaxHeap bytes for a work buffer, it
  repeatedly divides MaxHeap by two until it can successfully allocate that
  much space. After finding a block it can allocate, it does not attempt to
  allocate larger blocks that might still fit. In Win16, the sorter does a
  better job of allocating all available space (up to MaxHeap bytes) because
  it is performing multiple allocations of smaller blocks instead of allocating
  one big block.

  Unlike MSORTP, STSORT always swaps full records. It does not use pointer
  swapping for large records. If this is desirable, the application should
  pass pointers to previously allocated records into the TStSorter class.

  The OptimumHeapToUse, MinimumHeapToUse, and MergeInfo functions can be used
  to optimize the buffer size before starting a sort.

  By default, temporary merge files are saved in the current directory with
  names of the form SORnnnnn.TMP, where nnnnn is a sequential file number.
  You can supply a different merge name function via the MergeName property
  to put the files in a different location or use a different form for the
  names.

  The sorter is thread-aware and uses critical sections to protect the Put,
  Get, and Reset methods. Be sure that one thread does not call Put after
  another thread has already called Get.
}

unit STSort;
{-General purpose sorting class using merge sort algorithm}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  SysUtils, STConst, STBase;

const
{.Z+}
  MinRecsPerRun = 4;    {Minimum number of records in run buffer}
  MergeOrder = 5;       {Input files used at a time during merge, >=2, <=10}
  MedianThreshold = 16; {Threshold for using median-of-three quicksort}
{$IFNDEF WIN32}
  MaxBlocks = 256;      {Maximum number of buffer blocks allocated}
{$ENDIF}
{.Z-}

type
  TMergeNameFunc = function (MergeNum : Integer) : string;

  TMergeInfo = record          {Record returned by MergeInfo}
    SortStatus   : Integer;    {Predicted status of sort, assuming disk ok}
    MergeFiles   : Integer;    {Total number of merge files created}
    MergeHandles : Integer;    {Maximum file handles used}
    MergePhases  : Integer;    {Number of merge phases}
    MaxDiskSpace : LongInt;    {Maximum peak disk space used}
    HeapUsed     : LongInt;    {Heap space actually used}
  end;

  {.Z+}
  TMergeIntArray = array[1..MergeOrder] of Integer;
  TMergeLongArray = array[1..MergeOrder] of LongInt;
  TMergePtrArray = array[1..MergeOrder] of Pointer;
{$IFNDEF WIN32}
  TPtrArray = array[0..MaxBlocks-1] of Pointer;
{$ENDIF}
  {.Z-}

  TStSorter = class(TObject)
  {.Z+}
  protected
    {property instance variables}
    FCount     : LongInt;                {Number of records put to sort}
    FRecLen    : Cardinal;               {Size of each record}
    FCompare   : TUntypedCompareFunc;    {Compare function}
    FMergeName : TMergeNameFunc;         {Merge file naming function}

    {private instance variables}
    sorRunCapacity : LongInt;            {Capacity (in records) of run buffer}
    sorRunCount    : LongInt;            {Current number of records in run buffer}
    sorGetIndex    : LongInt;            {Last run element passed back to user}
    sorPivotPtr    : Pointer;            {Pointer to pivot record}
    sorSwapPtr     : Pointer;            {Pointer to swap record}
    sorState       : Integer;            {0 = empty, 1 = adding, 2 = getting}
    sorMergeFileCount  : Integer;        {Number of merge files created}
    sorMergeFileMerged : Integer;        {Index of last merge file merged}
    sorMergeOpenCount  : Integer;        {Count of open merge files}
    sorMergeBufSize    : LongInt;        {Usable bytes in merge buffer}
    sorMergeFileNumber : TMergeIntArray; {File number of each open merge file}
    sorMergeFiles      : TMergeIntArray; {File handles for merge files}
    sorMergeBytesLoaded: TMergeLongArray;{Count of bytes in each merge buffer}
    sorMergeBytesUsed : TMergeLongArray; {Bytes used in each merge buffer}
    sorMergeBases     : TMergePtrArray;  {Base index for each merge buffer}
    sorMergePtrs      : TMergePtrArray;  {Current head elements in each merge buffer}
    sorOutFile        : Integer;         {Output file handle}
    sorOutPtr         : Pointer;         {Pointer for output buffer}
    sorOutBytesUsed   : LongInt;         {Number of bytes in output buffer}
{$IFDEF WIN32}
 {$IFDEF ThreadSafe}
  {$IFDEF WIN32}
    sorThreadSafe  : TRTLCriticalSection;{Windows critical section record}
  {$ELSE}
    sorThreadSafe  : hMtx;
  {$ENDIF}
 {$ENDIF}
 {$IFDEF VirtualPascal}
    sorBufSize     : Longint;            {Length of global buffer}
 {$ENDIF}
    sorBuffer      : Pointer;            {Pointer to global buffer}
{$ELSE}
    sorBlockCount  : Integer;            {Number of pointers allocated}
    sorRecsPerBlock: Word;               {Number of records mapped by one pointer}
    sorRecsShr     : Word;               {SHR count corresponding to RecsPerBlock}
    sorRecsMask    : Word;               {AND mask corresponding to RecsPerBlock}
    sorBuffer      : TPtrArray;          {Array of pointers for global buffer}
{$ENDIF}

    {protected undocumented methods}
    procedure sorAllocBuffer(MaxHeap : LongInt);
    procedure sorCreateNewMergeFile(var Handle : Integer);
    procedure sorDeleteMergeFiles;
    function  sorElementPtr(Index : LongInt) : Pointer;
    procedure sorFlushOutBuffer;
    procedure sorFreeBuffer;
    procedure sorGetMergeElementPtr(M : Integer);
    function  sorGetNextElementIndex : Integer;
    procedure sorMergeFileGroup;
    procedure sorMoveElement(Src, Dest : Pointer);
    procedure sorOpenMergeFiles;
    procedure sorPrimaryMerge;
    procedure sorRunSort(L, R : LongInt);
    procedure sorStoreElement(Src : Pointer);
    procedure sorStoreNewMergeFile;
    procedure sorSwapElements(L, R : LongInt);
    procedure sorSetCompare(Comp : TUntypedCompareFunc);

    {protected documented methods}
    procedure EnterCS;
      {-Enter critical section for this instance}
    procedure LeaveCS;
      {-Leave critical section}
  {.Z-}

  public
    constructor Create(MaxHeap : LongInt; RecLen : Cardinal); virtual;
      {-Initialize a sorter}
    destructor Destroy; override;
      {-Destroy a sorter}

    procedure Put(const X);
      {-Add an element to the sort system}
    function Get(var X) : Boolean;
      {-Return next sorted element from the sort system}

    procedure Reset;
      {-Reset sorter before starting another sort}

    property Count : LongInt
      {-Return the number of elements in the sorter}
      read FCount;

    property Compare : TUntypedCompareFunc
      {-Set or read the element comparison function}
      read FCompare
      write sorSetCompare;

    property MergeName : TMergeNameFunc
      {-Set or read the merge filename function}
      read FMergeName
      write FMergeName;

    property RecLen : Cardinal
      {-Return the size of each record}
      read FRecLen;
  end;

function OptimumHeapToUse(RecLen : Cardinal; NumRecs : LongInt) : LongInt;
  {-Returns the optimum amount of heap space to sort NumRecs records
    of RecLen bytes each. Less heap space causes merging; more heap
    space is partially unused.}

function MinimumHeapToUse(RecLen : Cardinal) : LongInt;
  {-Returns the absolute minimum heap that allows MergeSort to succeed}

function MergeInfo(MaxHeap : LongInt; RecLen : Cardinal;
                   NumRecs : LongInt) : TMergeInfo;
  {-Predicts status and resource usage of a merge sort}

function DefaultMergeName(MergeNum : Integer) : string;
  {-Default function used for returning merge file names}

procedure ArraySort(var A; RecLen, NumRecs : Cardinal;
                    Compare : TUntypedCompareFunc);
 {-Sort a normal Delphi array (A) in place}

{======================================================================}

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
  ecOutOfMemory = 8;

procedure RaiseError(Code : longint);
var
  E : ESTSortError;
begin
  if Code = ecOutOfMemory then
    OutOfMemoryError
  else begin
    E := ESTSortError.CreateResTP(Code, 0);
    E.ErrorCode := Code;
    raise E;
  end;
end;

function DefaultMergeName(MergeNum : Integer) : string;
begin
  Result := 'SOR'+IntToStr(MergeNum)+'.TMP';
end;

{$IFNDEF WIN32}
procedure GetMaxRecsPerBlock(RecLen : Cardinal; var RecsShr, RecsPerBlock : Word);
var
  R : LongInt;
begin
  R := 1;
  RecsShr := 0;
  while R*RecLen < 65536 do begin
    R := R shl 1;
    inc(RecsShr);
  end;
  if RecsShr > 0 then begin
    R := R shr 1;
    dec(RecsShr);
  end;
  RecsPerBlock := R;
end;
{$ENDIF}

function MergeInfo(MaxHeap : LongInt; RecLen : Cardinal;
                   NumRecs : LongInt) : TMergeInfo;
type
  MergeFileSizeArray = array[1..(StMaxBlockSize div SizeOf(LongInt))] of LongInt;
var
{$IFNDEF WIN32}
  BlockCount, RecsShr, RecsPerBlock : Word;
  TmpMaxBlocks, BlockSize : LongInt;
{$ENDIF}
  MFileMerged, MOpenCount, MFileCount : Integer;
  SizeBufSize, DiskSpace,  OutputSpace, PeakDiskSpace : LongInt;
  AllocRecs, RunCapacity, RecordsLeft, RecordsInFile : LongInt;
  MFileSizeP : ^MergeFileSizeArray;
begin
  {Set defaults for the result}
  FillChar(Result, SizeOf(TMergeInfo), 0);

  {Validate input parameters}
  if (RecLen = 0) or (MaxHeap <= 0) or (NumRecs <= 0) then begin
    Result.SortStatus := stscBadSize;
    Exit;
  end;

{$IFDEF WIN32}
  AllocRecs := MaxHeap div LongInt(RecLen);                            
  if AllocRecs < MergeOrder+1 then begin
    Result.SortStatus := stscBadSize;
    Exit;
  end;
{$ELSE}
  GetMaxRecsPerBlock(RecLen, RecsShr, RecsPerBlock);
  repeat
    BlockSize := LongInt(RecsPerBlock)*RecLen;
    TmpMaxBlocks := MaxHeap div BlockSize;
    if TmpMaxBlocks > MaxBlocks then
      TmpMaxBlocks := MaxBlocks;

    if TmpMaxBlocks >= MergeOrder+1 then begin
      BlockCount := TmpMaxBlocks;
      break;
    end else begin
      RecsPerBlock := RecsPerBlock shr 1;
      if RecsPerBlock = 0 then begin
        {failed}
        Result.SortStatus := stscBadSize;
        Exit;
      end;
    end;
  until False;

  AllocRecs := LongInt(RecsPerBlock)*BlockCount;
{$ENDIF}

  RunCapacity := AllocRecs-2;
  if RunCapacity < MinRecsPerRun then begin
    Result.SortStatus := stscBadSize;
    Exit;
  end;

  {Compute amount of memory used}
  Result.HeapUsed := AllocRecs*LongInt(RecLen);                        

  if RunCapacity >= NumRecs then
    {All the records fit into memory}
    Exit;

  {Compute initial number of merge files and disk space}
  MFileCount := NumRecs div (AllocRecs-2);
  if NumRecs mod (AllocRecs-2) <> 0 then
    inc(MFileCount);
  {if MFileCount > MaxInt then begin       }                           
  {  Result.SortStatus := stscTooManyFiles;}                           
  {  Exit;                                 }                           
  {end;                                    }                           
  DiskSpace := NumRecs*LongInt(RecLen);                                

  {At least one merge phase required}
  Result.MergePhases := 1;

  if MFileCount <= MergeOrder then begin
    {Only one merge phase, direct to user}
    Result.MergeFiles := MFileCount;
    Result.MergeHandles := MFileCount;
    Result.MaxDiskSpace := DiskSpace;
    Exit;
  end;

  {Compute total number of merge files and merge phases}
  MFileMerged := 0;
  while MFileCount-MFileMerged > MergeOrder do begin
    inc(Result.MergePhases);
    MOpenCount := 0;
    while (MOpenCount < MergeOrder) and (MFileMerged < MFileCount) do begin
      inc(MOpenCount);
      inc(MFileMerged);
    end;
    inc(MFileCount);
  end;

  {Store the information we already know}
  Result.MergeFiles := MFileCount;
  Result.MergeHandles := MergeOrder+1; {MergeOrder input files, 1 output file}

  {Determine whether the disk space analysis can proceed}
  Result.MaxDiskSpace := -1;
  if MFileCount > (StMaxBlockSize div SizeOf(LongInt)) then
    Exit;
  SizeBufSize := MFileCount*SizeOf(LongInt);
  try
    GetMem(MFileSizeP, SizeBufSize);
  except
    Exit;
  end;

  {Compute size of initial merge files}
  RecordsLeft := NumRecs;
  MFileCount := 0;
  while RecordsLeft > 0 do begin
    inc(MFileCount);
    if RecordsLeft >= RunCapacity then
      RecordsInFile := RunCapacity
    else
      RecordsInFile := RecordsLeft;
    MFileSizeP^[MFileCount] := RecordsInFile*LongInt(RecLen);          
    dec(RecordsLeft, RecordsInFile);
  end;

  {Carry sizes forward to get disk space used}
  PeakDiskSpace := DiskSpace;
  MFileMerged := 0;
  while MFileCount-MFileMerged > MergeOrder do begin
    MOpenCount := 0;
    OutputSpace := 0;
    while (MOpenCount < MergeOrder) and (MFileMerged < MFileCount) do begin
      inc(MOpenCount);
      inc(MFileMerged);
      inc(OutputSpace, MFileSizeP^[MFileMerged]);
    end;
    inc(MFileCount);
    {Save size of output file}
    MFileSizeP^[MFileCount] := OutputSpace;
    {Output file and input files coexist temporarily}
    inc(DiskSpace, OutputSpace);
    {Store new peak disk space}
    if DiskSpace > PeakDiskSpace then
      PeakDiskSpace := DiskSpace;
    {Account for deleting input files}
    dec(DiskSpace, OutputSpace);
  end;
  Result.MaxDiskSpace := PeakDiskSpace;

  FreeMem(MFileSizeP, SizeBufSize);
end;

function MinimumHeapToUse(RecLen : Cardinal) : LongInt;
{$IFDEF WIN32}
var
  HeapToUse : LongInt;
begin
  HeapToUse := (MergeOrder+1)*RecLen;
  Result := (MinRecsPerRun+2)*RecLen;
  if Result < HeapToUse then
    Result := HeapToUse;
end;
{$ELSE}
var
  BlockCount : Integer;
  RecsShr, RecsPerBlock : Word;
  AllocatedRecs, RunCapacity, MinHeapUsed, HeapToUse : LongInt;
begin
  {Compute largest power-of-two number of recs that fit into 64K}
  GetMaxRecsPerBlock(RecLen, RecsShr, RecsPerBlock);

  {Try all valid RecsPerSel}
  MinHeapUsed := MaxLongInt;
  repeat
    {Try minimum number of selectors}
    BlockCount := MergeOrder+1;
    repeat
      AllocatedRecs := LongInt(RecsPerBlock)*BlockCount;
      RunCapacity := AllocatedRecs-2;
      if RunCapacity < MinRecsPerRun then
        inc(BlockCount);
    until RunCapacity >= MinRecsPerRun;
    HeapToUse := BlockCount*LongInt(RecsPerBlock)*RecLen;
    if HeapToUse < MinHeapUsed then
      MinHeapUsed := HeapToUse;
    RecsPerBlock := RecsPerBlock shr 1;
  until RecsPerBlock = 0;

  Result := MinHeapUsed;
end;
{$ENDIF}

function OptimumHeapToUse(RecLen : Cardinal; NumRecs : LongInt) : LongInt;
{$IFDEF WIN32}
begin
  if (NumRecs < MergeOrder+1) then
    NumRecs := MergeOrder+1;
  Result := LongInt(RecLen)*(NumRecs+2);                               
end;
{$ELSE}
var
  BlockCount : Integer;
  RecsShr, RecsPerBlock : Word;
begin
  {Account for pivot and swap elements}
  inc(NumRecs, 2);

  {Compute largest power-of-two number of recs that fit into 64K}
  GetMaxRecsPerBlock(RecLen, RecsShr, RecsPerBlock);

  {Compute number of blocks}
  repeat
    BlockCount := NumRecs div RecsPerBlock;
    if NumRecs mod RecsPerBlock <> 0 then
      inc(BlockCount);
    if BlockCount < MergeOrder+1 then
      RecsPerBlock := RecsPerBlock shr 1;
  until (BlockCount >= MergeOrder+1) or (RecsPerBlock = 0);

  if RecsPerBlock = 0 then begin
    {Special case for very small number of records}
    RecsPerBlock := 1;
    BlockCount := MergeOrder+1;
  end;

  Result := BlockCount*LongInt(RecsPerBlock)*RecLen;
end;
{$ENDIF}

{----------------------------------------------------------------------}

constructor TStSorter.Create(MaxHeap : LongInt; RecLen : Cardinal);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  if (RecLen = 0) or (MaxHeap <= 0) then
    RaiseError(stscBadSize);

  {FCount := 0;}
  {@FCompare := nil;}
  {sorRunCount := 0;}
  {sorGetIndex := 0;}
  {sorMergeFileCount := 0;}
  {sorMergeFileMerged := 0;}
  {sorMergeOpenCount := 0;}

  FMergeName := DefaultMergeName;
  FRecLen := RecLen;

  {Allocate a sort work buffer using at most MaxHeap bytes}
  sorAllocBuffer(MaxHeap);

{$IFDEF ThreadSafe}
 {$IFDEF WIN32}
  Windows.InitializeCriticalSection(sorThreadSafe);
 {$ELSE}
  DosCreateMutexSem(nil, sorThreadSafe, 0, False);
 {$ENDIF}
{$ENDIF}
end;

destructor TStSorter.Destroy;
begin
{$IFDEF ThreadSafe}
 {$IFDEF WIN32}
  Windows.DeleteCriticalSection(sorThreadSafe);
 {$ELSE}
  DosCloseMutexSem(sorThreadSafe);
 {$ENDIF}
{$ENDIF}
  sorDeleteMergeFiles;
  sorFreeBuffer;
end;

procedure TStSorter.EnterCS;
begin
{$IFDEF ThreadSafe}
 {$IFDEF WIN32}
  EnterCriticalSection(sorThreadSafe);
 {$ELSE}
  DosRequestMutexSem(sorThreadSafe, sem_Indefinite_Wait);
 {$ENDIF}
{$ENDIF}
end;

function TStSorter.Get(var X) : Boolean;
var
  NextIndex : Integer;
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    Result := False;

    if sorState <> 2 then begin
      {First call to Get}
      if sorRunCount > 0 then begin
        {Still have elements to sort}
        sorRunSort(0, sorRunCount-1);
        if sorMergeFileCount > 0 then begin
          {Already have other merge files}
          sorStoreNewMergeFile;
          sorPrimaryMerge;
          sorOpenMergeFiles;
        end else
          {No merging necessary}
          sorGetIndex := 0;
      end else if FCount = 0 then
        {No elements were sorted}
        Exit;

      sorState := 2;
    end;

    if sorMergeFileCount > 0 then begin
      {Get next record from merge files}
      NextIndex := sorGetNextElementIndex;
      if NextIndex <> 0 then begin
        {Return the element}
        sorMoveElement(sorMergePtrs[NextIndex], @X);
        {Get pointer to next element in the stream just used}
        sorGetMergeElementPtr(NextIndex);
        Result := True;
      end;
    end else if sorGetIndex < sorRunCount then begin
      {Get next record from run buffer}
      sorMoveElement(sorElementPtr(sorGetIndex), @X);
      inc(sorGetIndex);
      Result := True;
    end;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

procedure TStSorter.LeaveCS;
begin
{$IFDEF ThreadSafe}
 {$IFDEF WIN32}
  LeaveCriticalSection(sorThreadSafe);
 {$ELSE}
  DosReleaseMutexSem(sorThreadSafe);
 {$ENDIF}
{$ENDIF}
end;

procedure TStSorter.Reset;
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    sorDeleteMergeFiles;
    FCount := 0;
    sorState := 0;
    sorRunCount := 0;
    sorMergeFileCount := 0;
    sorMergeFileMerged := 0;
    sorMergeOpenCount := 0;
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

procedure TStSorter.Put(const X);
begin
{$IFDEF ThreadSafe}
  EnterCS;
  try
{$ENDIF}
    if sorState = 2 then
      {Can't Put after calling Get}
      RaiseError(stscBadState);

    sorState := 1;

    if sorRunCount >= sorRunCapacity then begin
      {Run buffer full; sort buffer and store to disk}
      sorRunSort(0, sorRunCount-1);
      sorStoreNewMergeFile;
      sorRunCount := 0;
    end;

    {Store new element into run buffer}
    sorMoveElement(@X, sorElementPtr(sorRunCount));
    inc(sorRunCount);
    inc(FCount);
{$IFDEF ThreadSafe}
  finally
    LeaveCS;
  end;
{$ENDIF}
end;

procedure TStSorter.sorAllocBuffer(MaxHeap : LongInt);
  {-Allocate a work buffer of records in at most MaxHeap bytes}
{$IFDEF WIN32}
var
  Status : Integer;
  AllocRecs : LongInt;
begin
  Status := stscBadSize;
  repeat
    AllocRecs := MaxHeap div LongInt(FRecLen);                         
    if AllocRecs < MergeOrder+1 then
      RaiseError(Status);
    {$IFDEF VirtualPascal}
    SorBufSize := AllocRecs*FRecLen;
    GetMem(sorBuffer, SorBufSize);
    {$ELSE}
    sorBuffer := GlobalAllocPtr(HeapAllocFlags, AllocRecs*LongInt(FRecLen));
    {$ENDIF}
    if sorBuffer = nil then begin
      Status := ecOutOfMemory;
      MaxHeap := MaxHeap div 2;
    end else
      break;
  until False;

  sorMergeBufSize := LongInt(FRecLen)*(AllocRecs div (MergeOrder+1));  

  sorRunCapacity := AllocRecs-2;
  if sorRunCapacity < MinRecsPerRun then
    RaiseError(Status);

  sorPivotPtr := sorElementPtr(AllocRecs-1);
  sorSwapPtr := sorElementPtr(AllocRecs-2);
end;
{$ELSE}
var
  Status, I : Integer;
  AllocRecs, TmpMaxBlocks, BlockSize : LongInt;
begin
  GetMaxRecsPerBlock(FRecLen, sorRecsShr, sorRecsPerBlock);

  repeat
    BlockSize := LongInt(sorRecsPerBlock)*FRecLen;
    TmpMaxBlocks := MaxHeap div BlockSize;
    if TmpMaxBlocks > MaxBlocks then
      TmpMaxBlocks := MaxBlocks;

    {If we fail, it's because MaxHeap was too small}
    Status := stscBadSize;

    sorBlockCount := 0;
    if TmpMaxBlocks >= MergeOrder+1 then
      for I := 0 to TmpMaxBlocks-1 do begin
        sorBuffer[I] := GlobalAllocPtr(HeapAllocFlags, BlockSize);
        if sorBuffer[I] = nil then begin
          {If we fail, it's because there was insufficient heap space}
          Status := ecOutOfMemory;
          break;
        end else
          Inc(sorBlockCount);
      end;

    if sorBlockCount < MergeOrder+1 then begin
      {Not enough blocks, cut size in two}
      sorFreeBuffer;
      sorRecsPerBlock := sorRecsPerBlock shr 1;
      dec(sorRecsShr);
      if sorRecsPerBlock = 0 then
        RaiseError(Status);
    end else
      break;
  until False;

  sorRecsMask := sorRecsPerBlock-1;
  AllocRecs := LongInt(sorRecsPerBlock)*sorBlockCount;
  sorMergeBufSize := FRecLen*sorRecsPerBlock;

  sorRunCapacity := AllocRecs-2;
  if sorRunCapacity < MinRecsPerRun then
    RaiseError(Status);

  sorPivotPtr := sorElementPtr(AllocRecs-1);
  sorSwapPtr := sorElementPtr(AllocRecs-2);
end;
{$ENDIF}

procedure TStSorter.sorCreateNewMergeFile(var Handle : Integer);
  {-Create another merge file and return its handle}
begin
  if sorMergeFileCount = MaxInt then
    {Too many merge files}
    RaiseError(stscTooManyFiles);

  {Create new merge file}
  inc(sorMergeFileCount);
  Handle := FileCreate(FMergeName(sorMergeFileCount));
  if Handle < 0 then begin
    dec(sorMergeFileCount);
    RaiseError(stscFileCreate);
  end;
end;

procedure TStSorter.sorDeleteMergeFiles;
  {-Delete open and already-closed merge files}
var
  I : Integer;
begin
  for I := 1 to sorMergeOpenCount do begin
    FileClose(sorMergeFiles[I]);
    SysUtils.DeleteFile(FMergeName(sorMergeFileNumber[I]));
  end;

  for I := sorMergeFileMerged+1 to sorMergeFileCount do
    SysUtils.DeleteFile(FMergeName(I));
end;

function TStSorter.sorElementPtr(Index : LongInt) : Pointer;
  {-Return a pointer to the given element in the sort buffer}
{$IFDEF WIN32}
begin
  Result := PChar(sorBuffer)+Index*LongInt(FRecLen);                   
end;
{$ELSE}
assembler;
asm
  les di,Self
  mov cl,byte ptr TStSorter(es:[di]).sorRecsShr
  mov ax,word ptr Index
  mov dx,word ptr Index+2
  mov si,ax                               {Save low word of ElNum}
  {The following stuff circumvents the use of a 32-bit shift}
  cmp cl,8                                {RecLen > 256 bytes?}
  jb  @2                                  {Jump if so}
  cmp cl,16                               {RecLen = 1 byte?}
  jne @1                                  {Jump if not}
  mov ax,dx                               {RecLen = 1 byte}
  jmp @3
@1:
  mov al,ah                               {RecLen <= 256 bytes}
  mov ah,dl
  sub cl,8
@2:
  shr ax,cl
@3:
  shl ax,2
  mov bx,ax                               {bx = offset into sorBuffer array}
  mov ax,TStSorter(es:[di]).sorRecsMask   {ax = offset mask}
  and ax,si                               {ax = Word(Index) and sorRecsMask}
  mul word ptr TStSorter(es:[di]).FRecLen {ax = data offset}
  add di,bx
  mov dx,word ptr TStSorter(es:[di+2]).sorBuffer
  add ax,word ptr TStSorter(es:[di]).sorBuffer
end;
(*
begin
  Result := PChar(sorBuffer[Index shr Byte(sorRecsShr)])+
            (Word(Index) and sorRecsMask)*FRecLen;
end;
*)
{$ENDIF}

procedure TStSorter.sorFlushOutBuffer;
  {-Write the merge output buffer to disk}
var
  BytesWritten : LongInt;
begin
  if sorOutBytesUsed <> 0 then begin
    BytesWritten := FileWrite(sorOutFile, sorOutPtr^, sorOutBytesUsed);
    if BytesWritten <> sorOutBytesUsed then
      RaiseError(stscFileWrite);
  end;
end;

procedure TStSorter.sorFreeBuffer;
{$IFDEF WIN32}
begin
  {$IFDEF VirtualPascal}
  FreeMem( sorBuffer, SorBufSize);
  {$ELSE}
  GlobalFreePtr(sorBuffer);
  {$ENDIF}
end;
{$ELSE}
var
  I : Integer;
begin
  for I := 0 to sorBlockCount-1 do
    GlobalFreePtr(sorBuffer[I]);
end;
{$ENDIF}

procedure TStSorter.sorGetMergeElementPtr(M : Integer);
  {-Update head pointer in input buffer of specified open merge file}
var
  BytesRead : LongInt;
begin
  if sorMergeBytesUsed[M] >= sorMergeBytesLoaded[M] then begin
    {Try to load new data into buffer}
    BytesRead := FileRead(sorMergeFiles[M], sorMergeBases[M]^, sorMergeBufSize);
    if BytesRead < 0 then
      {Error reading file}
      RaiseError(stscFileRead);
    if BytesRead < LongInt(FRecLen) then begin                         
      {End of file. Close and delete it}
      FileClose(sorMergeFiles[M]);
      SysUtils.DeleteFile(FMergeName(sorMergeFileNumber[M]));
      {Remove file from merge list}
      if M <> sorMergeOpenCount then begin
        sorMergeFileNumber[M] := sorMergeFileNumber[sorMergeOpenCount];
        sorMergeFiles[M] := sorMergeFiles[sorMergeOpenCount];
        sorMergePtrs[M] := sorMergePtrs[sorMergeOpenCount];
        sorMergeBytesLoaded[M] := sorMergeBytesLoaded[sorMergeOpenCount];
        sorMergeBytesUsed[M] := sorMergeBytesUsed[sorMergeOpenCount];
        sorMergeBases[M] := sorMergeBases[sorMergeOpenCount];
      end;
      dec(sorMergeOpenCount);
      Exit;
    end;
    sorMergeBytesLoaded[M] := BytesRead;
    sorMergeBytesUsed[M] := 0;
  end;

  sorMergePtrs[M] := PChar(sorMergeBases[M])+sorMergeBytesUsed[M];
  inc(sorMergeBytesUsed[M], FRecLen);
end;

function TStSorter.sorGetNextElementIndex : Integer;
  {-Return index into open merge file of next smallest element}
var
  M : Integer;
  MinElPtr : Pointer;
begin
  if sorMergeOpenCount = 0 then begin
    {All merge streams are empty}
    Result := 0;
    Exit;
  end;

  {Assume first element is the least}
  MinElPtr := sorMergePtrs[1];
  Result := 1;

  {Scan the other elements}
  for M := 2 to sorMergeOpenCount do
    if FCompare(sorMergePtrs[M]^, MinElPtr^) < 0 then begin
      Result := M;
      MinElPtr := sorMergePtrs[M];
    end;
end;

procedure TStSorter.sorMergeFileGroup;
  {-Merge a group of input files into one output file}
var
  NextIndex : Integer;
begin
  sorOutBytesUsed := 0;
  repeat
    {Find index of minimum element}
    NextIndex := sorGetNextElementIndex;
    if NextIndex = 0 then
      break
    else begin
      {Copy element to output}
      sorStoreElement(sorMergePtrs[NextIndex]);
      {Get the next element from its merge stream}
      sorGetMergeElementPtr(NextIndex);
    end;
  until False;

  {Flush and close the output file}
  sorFlushOutBuffer;
  FileClose(sorOutFile);
end;

procedure TStSorter.sorMoveElement(Src, Dest : Pointer); assembler;
  {-Copy one record to another location, non-overlapping}
{$IFDEF WIN32}
register;
asm
  {eax = Self, edx = Src, ecx = Dest}
  push esi
  mov esi,Src
  mov edx,edi
  mov edi,Dest
  mov ecx,TStSorter([eax]).FRecLen
  mov eax,ecx
  shr ecx,2
  rep movsd
  mov ecx,eax
  and ecx,3
  rep movsb
  mov edi,edx
  pop esi
end;
{$ELSE}
asm
  mov dx,ds
  les di,Self
  mov cx,TStSorter(es:[di]).FRecLen
  lds si,Src
  les di,Dest
  shr cx,1
  rep movsw
  rcl cx,1
  rep movsb
  mov ds,dx
end;
{$ENDIF}

procedure TStSorter.sorOpenMergeFiles;
  {-Open a group of up to MergeOrder input files}
begin
  sorMergeOpenCount := 0;
  while (sorMergeOpenCount < MergeOrder) and
    (sorMergeFileMerged < sorMergeFileCount) do begin
    inc(sorMergeOpenCount);
    {Open associated merge file}
    inc(sorMergeFileMerged);
    sorMergeFiles[sorMergeOpenCount] :=
      FileOpen(FMergeName(sorMergeFileMerged), fmOpenRead);
    if sorMergeFiles[sorMergeOpenCount] < 0 then begin
      dec(sorMergeFileMerged);
      dec(sorMergeOpenCount);
      RaiseError(stscFileOpen);
    end;
    {File number of merge file}
    sorMergeFileNumber[sorMergeOpenCount] := sorMergeFileMerged;
    {Selector for merge file}
{$IFDEF WIN32}
    sorMergePtrs[sorMergeOpenCount] := PChar(sorBuffer)+
      (sorMergeOpenCount-1)*sorMergeBufSize;
{$ELSE}
    sorMergePtrs[sorMergeOpenCount] := sorBuffer[sorMergeOpenCount-1];
{$ENDIF}
    {Number of bytes currently in merge buffer}
    sorMergeBytesLoaded[sorMergeOpenCount] := 0;
    {Number of bytes used in merge buffer}
    sorMergeBytesUsed[sorMergeOpenCount] := 0;
    {Save the merge pointer}
    sorMergeBases[sorMergeOpenCount] := sorMergePtrs[sorMergeOpenCount];
    {Get the first element}
    sorGetMergeElementPtr(sorMergeOpenCount);
  end;
end;

procedure TStSorter.sorPrimaryMerge;
  {-Merge until there are no more than MergeOrder merge files left}
begin
{$IFDEF WIN32}
  sorOutPtr := PChar(sorBuffer)+MergeOrder*sorMergeBufSize;
{$ELSE}
  sorOutPtr := sorBuffer[MergeOrder];
{$ENDIF}
  while sorMergeFileCount-sorMergeFileMerged > MergeOrder do begin
    {Open next group of MergeOrder files}
    sorOpenMergeFiles;
    {Create new output file}
    sorCreateNewMergeFile(sorOutFile);
    {Merge these files into the output}
    sorMergeFileGroup;
  end;
end;

procedure TStSorter.sorRunSort(L, R : LongInt);
  {-Sort one run buffer full of records in memory using non-recursive QuickSort}
const
  StackSize = 32;
type
  Stack = array[0..StackSize-1] of LongInt;
var
  Pl : LongInt;            {Left edge within partition}
  Pr : LongInt;            {Right edge within partition}
  Pm : LongInt;            {Mid-point of partition}
  PartitionLen : LongInt;  {Size of current partition}
  StackP : Integer;        {Stack pointer}
  Lstack : Stack;          {Pending partitions, left edge}
  Rstack : Stack;          {Pending partitions, right edge}
begin
  {Make sure there's a compare function}
  if @FCompare = nil then
    RaiseError(stscNoCompare);

  {Initialize the stack}
  StackP := 0;
  Lstack[0] := L;
  Rstack[0] := R;

  {Repeatedly take top partition from stack}
  repeat

    {Pop the stack}
    L := Lstack[StackP];
    R := Rstack[StackP];
    Dec(StackP);

    {Sort current partition}
    repeat
      Pl := L;
      Pr := R;
      PartitionLen := Pr-Pl+1;

      {$IFDEF MidPoint}
      Pm := Pl+(PartitionLen shr 1);
      {$ENDIF}

      {$IFDEF Random}
      Pm := Pl+Random(PartitionLen);
      {$ENDIF}

      {$IFDEF Median}
      Pm := Pl+(PartitionLen shr 1);
      if PartitionLen >= MedianThreshold then begin
        {Sort elements Pl, Pm, Pr}
        if FCompare(sorElementPtr(Pm)^, sorElementPtr(Pl)^) < 0 then
          sorSwapElements(Pm, Pl);
        if FCompare(sorElementPtr(Pr)^, sorElementPtr(Pl)^) < 0 then
          sorSwapElements(Pr, Pl);
        if FCompare(sorElementPtr(Pr)^, sorElementPtr(Pm)^) < 0 then
          sorSwapElements(Pr, Pm);

        {Exchange Pm with Pr-1 but use Pm's value as the pivot}
        sorSwapElements(Pm, Pr-1);
        Pm := Pr-1;

        {Reduce range of swapping}
        inc(Pl);
        dec(Pr, 2);
      end;
      {$ENDIF}

      {Save the pivot element}
      sorMoveElement(sorElementPtr(Pm), sorPivotPtr);

      {Swap items in sort order around the pivot}
      repeat
        while FCompare(sorElementPtr(Pl)^, sorPivotPtr^) < 0 do
          Inc(Pl);
        while FCompare(sorPivotPtr^, sorElementPtr(Pr)^) < 0 do
          Dec(Pr);

        if Pl = Pr then begin
          {Reached the pivot}
          Inc(Pl);
          Dec(Pr);
        end else if Pl < Pr then begin
          {Swap elements around the pivot}
          sorSwapElements(Pl, Pr);
          Inc(Pl);
          Dec(Pr);
        end;
      until Pl > Pr;

      {Decide which partition to sort next}
      if (Pr-L) < (R-Pl) then begin
        {Left partition is bigger}
        if Pl < R then begin
          {Stack the request for sorting right partition}
          Inc(StackP);
          Lstack[StackP] := Pl;
          Rstack[StackP] := R;
        end;
        {Continue sorting left partition}
        R := Pr;
      end else begin
        {Right partition is bigger}
        if L < Pr then begin
          {Stack the request for sorting left partition}
          Inc(StackP);
          Lstack[StackP] := L;
          Rstack[StackP] := Pr;
        end;
        {Continue sorting right partition}
        L := Pl;
      end;
    until L >= R;
  until StackP < 0;
end;

procedure TStSorter.sorSetCompare(Comp : TUntypedCompareFunc);
  {-Set the compare function, with error checking}
begin
  if ((FCount <> 0) or (@Comp = nil)) and (@Comp <> @FCompare) then
    RaiseError(stscBadCompare);
  FCompare := Comp;
end;

procedure TStSorter.sorStoreElement(Src : Pointer);
  {-Store element in the merge output buffer}
begin
  if sorOutBytesUsed >= sorMergeBufSize then begin
    sorFlushOutBuffer;
    sorOutBytesUsed := 0;
  end;
  sorMoveElement(Src, PChar(sorOutPtr)+sorOutBytesUsed);
  inc(sorOutBytesUsed, FRecLen);
end;

procedure TStSorter.sorStoreNewMergeFile;
  {-Create new merge file, write run buffer to it, close file}
{$IFDEF WIN32}
var
  BytesToWrite, BytesWritten : Integer;
begin
  sorCreateNewMergeFile(sorOutFile);
  try
    BytesToWrite := sorRunCount*LongInt(FRecLen);                      
    BytesWritten := FileWrite(sorOutFile, sorBuffer^, BytesToWrite);
    if BytesWritten <> BytesToWrite then
      RaiseError(stscFileWrite);
  finally
    {Close merge file}
    FileClose(sorOutFile);
  end;
end;
{$ELSE}
var
  SelNum : Integer;
  BytesLeft, BytesToWrite, BytesWritten : LongInt;
begin
  {Create new merge file}
  sorCreateNewMergeFile(sorOutFile);
  try
    {Write the run buffer by blocks to the merge file}
    BytesLeft := sorRunCount*FRecLen;
    BytesToWrite := sorRecsPerBlock*FRecLen;
    SelNum := 0;
    while BytesLeft > 0 do begin
      if BytesLeft < BytesToWrite then
        BytesToWrite := BytesLeft;
      BytesWritten := FileWrite(sorOutFile, sorBuffer[SelNum]^, BytesToWrite);
      if BytesWritten <> BytesToWrite then
        RaiseError(stscFileWrite);
      dec(BytesLeft, BytesToWrite);
      inc(SelNum);
    end;
  finally
    {Close merge file}
    FileClose(sorOutFile);
  end;
end;
{$ENDIF}

procedure TStSorter.sorSwapElements(L, R : LongInt);
  {-Swap elements with indexes L and R}
var
  LPtr : Pointer;
  RPtr : Pointer;
begin
  LPtr := sorElementPtr(L);
  RPtr := sorElementPtr(R);
  sorMoveElement(LPtr, sorSwapPtr);
  sorMoveElement(RPtr, LPtr);
  sorMoveElement(sorSwapPtr, RPtr);
end;

procedure ArraySort(var A; RecLen, NumRecs : Cardinal;
                    Compare : TUntypedCompareFunc);
const
  StackSize = 32;
type
  Stack = array[0..StackSize-1] of LongInt;
var
  Pl, Pr, Pm, L, R : LongInt;
  ArraySize, PartitionLen : LongInt;
  PivotPtr : Pointer;
  SwapPtr : Pointer;
  StackP : Integer;
  Lstack, Rstack : Stack;

  function ElementPtr(Index : Cardinal) : Pointer;
  begin
    Result := PChar(@A)+Index*RecLen;
  end;

  procedure SwapElements(L, R : LongInt);
  var
    LPtr : Pointer;
    RPtr : Pointer;
  begin
    LPtr := ElementPtr(L);
    RPtr := ElementPtr(R);
    Move(LPtr^, SwapPtr^, RecLen);
    Move(RPtr^, LPtr^, RecLen);
    Move(SwapPtr^, RPtr^, RecLen);
  end;

begin
  {Make sure there's a compare function}
  if @Compare = nil then
    RaiseError(stscNoCompare);

  {Make sure the array size is reasonable}
  ArraySize := LongInt(RecLen)*LongInt(NumRecs);                       
  if (ArraySize = 0) {or (ArraySize > MaxBlockSize)} then              
    RaiseError(stscBadSize);

  {Get pivot and swap elements}
  GetMem(PivotPtr, RecLen);
  try
    GetMem(SwapPtr, RecLen);
    try
      {Initialize the stack}
      StackP := 0;
      Lstack[0] := 0;
      Rstack[0] := NumRecs-1;

      {Repeatedly take top partition from stack}
      repeat

        {Pop the stack}
        L := Lstack[StackP];
        R := Rstack[StackP];
        Dec(StackP);

        {Sort current partition}
        repeat
          Pl := L;
          Pr := R;
          PartitionLen := Pr-Pl+1;

          {$IFDEF MidPoint}
          Pm := Pl+(PartitionLen shr 1);
          {$ENDIF}

          {$IFDEF Random}
          Pm := Pl+Random(PartitionLen);
          {$ENDIF}

          {$IFDEF Median}
          Pm := Pl+(PartitionLen shr 1);
          if PartitionLen >= MedianThreshold then begin
            {Sort elements Pl, Pm, Pr}
            if Compare(ElementPtr(Pm)^, ElementPtr(Pl)^) < 0 then
              SwapElements(Pm, Pl);
            if Compare(ElementPtr(Pr)^, ElementPtr(Pl)^) < 0 then
              SwapElements(Pr, Pl);
            if Compare(ElementPtr(Pr)^, ElementPtr(Pm)^) < 0 then
              SwapElements(Pr, Pm);

            {Exchange Pm with Pr-1 but use Pm's value as the pivot}
            SwapElements(Pm, Pr-1);
            Pm := Pr-1;

            {Reduce range of swapping}
            inc(Pl);
            dec(Pr, 2);
          end;
          {$ENDIF}

          {Save the pivot element}
          Move(ElementPtr(Pm)^, PivotPtr^, RecLen);

          {Swap items in sort order around the pivot}
          repeat
            while Compare(ElementPtr(Pl)^, PivotPtr^) < 0 do
              Inc(Pl);
            while Compare(PivotPtr^, ElementPtr(Pr)^) < 0 do
              Dec(Pr);

            if Pl = Pr then begin
              {Reached the pivot}
              Inc(Pl);
              Dec(Pr);
            end else if Pl < Pr then begin
              {Swap elements around the pivot}
              SwapElements(Pl, Pr);
              Inc(Pl);
              Dec(Pr);
            end;
          until Pl > Pr;

          {Decide which partition to sort next}
          if (Pr-L) < (R-Pl) then begin
            {Left partition is bigger}
            if Pl < R then begin
              {Stack the request for sorting right partition}
              Inc(StackP);
              Lstack[StackP] := Pl;
              Rstack[StackP] := R;
            end;
            {Continue sorting left partition}
            R := Pr;
          end else begin
            {Right partition is bigger}
            if L < Pr then begin
              {Stack the request for sorting left partition}
              Inc(StackP);
              Lstack[StackP] := L;
              Rstack[StackP] := Pr;
            end;
            {Continue sorting right partition}
            L := Pl;
          end;
        until L >= R;
      until StackP < 0;

    finally
      FreeMem(SwapPtr, RecLen);
    end;
  finally
    FreeMem(PivotPtr, RecLen);
  end;
end;


end.