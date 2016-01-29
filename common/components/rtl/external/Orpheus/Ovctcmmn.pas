{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCTCMMN.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcTCmmn;
  {-Orpheus table: common unit}

interface

uses
  {$IFDEF Win32}
  Windows,
  {$ELSE}
  WinTypes, WinProcs,
  {$ENDIF}
  SysUtils, Messages,
  Graphics, Forms, StdCtrls, Classes, Controls, OvcBase, OvcData;

{---Enumeration types}
type
  TOvcTblAdjust = (                {data adjustment in cell}
              otaDefault,          {the default for the next higher class}
              otaTopLeft,          {top left hand corner}
              otaTopCenter,        {top, centered horizontally}
              otaTopRight,         {top right hand corner}
              otaCenterLeft,       {left hand side, centered vertically}
              otaCenter,           {centered vertically and horizontally}
              otaCenterRight,      {right hand side, centered vertically}
              otaBottomLeft,       {bottom left hand corner}
              otaBottomCenter,     {bottom, centered horizontally}
              otaBottomRight);     {bottom right hand corner}

  TOvcTblAccess = (                {cell access types}
              otxDefault,          {the default for the next higher class}
              otxNormal,           {read & write}
              otxReadOnly,         {read only, no write}
              otxInvisible);       {no read or write, ie invisible}

  TOvcTblState = (                 {grid states}
                                   {..Major}
              otsFocused,          {  focused, or cell being edited}
              otsUnfocused,        {  unfocused}
              otsDesigning,        {  being designed}
                                   {..Minor}
              otsNormal,           {  normal}
              otsEditing,          {  cell being edited}
              otsHiddenEdit,       {  ditto, however currently hidden}
              otsMouseSelect,      {  mouse is selecting}
              otsShowSize,         {  row/col sizing cursor shown}
              otsSizing,           {  row/col being resized}
              otsShowMove,         {  row/col move cursor shown}
              otsMoving,           {  row/col is being moved}
                                   {..Qualifiers}
              otsDoingRow,         {  moving/sizing a row}
              otsDoingCol,         {  moving/sizing a column}

              otsANOther);
  TOvcTblStates = set of TOvcTblState;

  TOvcTblKeyNeeds = (              {grid's requirements for keystrokes}
              otkDontCare,         {grid does not need key}
              otkWouldLike,        {grid would like key, but cell can take it}
              otkMustHave);        {grid must have key}

  TOvcTblRegion = (                {table regions}
              otrInMain,           {..main table area}
              otrInLocked,         {..locked row or col area}
              otrInUnused,         {..unused bit}
              otrOutside);         {..outside table client area}

  TOvcTblOption = (                {table options}
              otoBrowseRow,        {Highlight row when browsing}
              otoNoRowResizing,    {No run-time row resizing allowed}
              otoNoColResizing,    {No run-time column resizing allowed}
              otoTabToArrow,       {Tab moves cell to right, ShiftTab left}
              otoEnterToArrow,     {Enter stops editing and moves cell right}
              otoAlwaysEditing,    {Edit mode is always active}
              otoNoSelection,      {No run-time selection allowed}
              otoMouseDragSelect,  {dragging with mouse selects}
              otoRowSelection,     {clicking on row header selects entire row}
              otoColSelection,     {clicking on column header selects entire column}
              otoThumbTrack,       {Scrollbar thumb-tracking}
              otoAllowColMoves,    {Enable column moves}
              otoAllowRowMoves);   {Enable row moves}
  TOvcTblOptionSet = set of TOvcTblOption;

  TOvcScrollBar = (                {scroll bar identifiers}
              otsbVertical,        {..the vertical one}
              otsbHorizontal);     {..the horizontal one}

  TOvcTblActions = (               {configuration actions on rows/columns}
              taGeneral,           {..general}
              taSingle,            {..changing a single row/column}
              taAll,               {..changing all rows/columns}
              taInsert,            {..inserting a row/column}
              taDelete,            {..deleting a row/column}
              taExchange);         {..exchanging two rows/columns}

  TOvcCellDataPurpose = (          {OnGetCellData data request purpose}
              cdpForPaint,         {..for painting}
              cdpForEdit,          {..for editing}
              cdpForSave);         {..for saving an edited data}

  TOvcTextStyle = (                {text painting styles}
              tsFlat,              {..flat}
              tsRaised,            {..raised look}
              tsLowered);          {..lowered look}

  TOvcTblSelectionType = (         {Internal selection type}
              tstDeselectAll,      {..deselect all selections}
              tstAdditional);      {..additional selection/deselection}

  TOvcTblEditorStyle = (           {Table's cell editor style}
              tesNormal,           {..normal (ie nothing special)}
              tesBorder,           {..with border}
              tes3D);              {..3D look}

{---Row/Column number (index) types}
type
  TRowNum = longint;  {actually 0..2 billion}
  TColNum = integer;  {actually 0..16K}

{---record types for cells---}
type
  PCellBitMapInfo = ^TCellBitMapInfo;
  TCellBitMapInfo = record
    BM          : TBitMap;    {bitmap object to display}
    Count       : integer;    {number of glyphs}
    ActiveCount : integer;    {number of active glyphs}
    Index       : integer;    {index of glyph to display}
  end;

  PCellComboBoxInfo = ^TCellComboBoxInfo;
  TCellComboBoxInfo = record
    Index : integer;                {index into Items list}
    {$IFDEF CBuilder}
    case integer of
      0 : (St      : array[0..255] of AnsiChar);
      1 : (RTItems : TStrings;
           RTSt    : array[0..255] of AnsiChar);
    {$ELSE}
    case integer of
      0 : (St      : ShortString);  {AnsiString value if Index = -1}
      1 : (RTItems : TStrings;      {run-time items list}
           RTSt    : ShortString);  {run-time AnsiString value if Index = -1}
    {$ENDIF}
  end;

  TOvcCellAttributes = record      {display attributes for a cell}
    caAccess      : TOvcTblAccess;   {..access rights}
    caAdjust      : TOvcTblAdjust;   {..data adjustment}
    caColor       : TColor;          {..background color}
    caFont        : TFont;           {..text font}
    caFontColor   : TColor;          {..text color}
    caFontHiColor : TColor;          {..text highlight color}
    caTextStyle   : TOvcTextStyle;   {..text style}
  end;


{---Table cell ancestor---}
  TOvcTableCellAncestor = class(TComponent)
    protected {private}
      {.Z+}
      FOnCfgChanged : TNotifyEvent;
      {.Z-}
    protected
      {.Z+}
      procedure tcChangeScale(M, D : integer); dynamic;
      procedure tcDoCfgChanged;
      {.Z-}
    public {protected}
      {.Z+}
      procedure tcResetTableValues; virtual; abstract;
      property OnCfgChanged : TNotifyEvent
        write FOnCfgChanged;
      {.Z-}
    public
  end;

{---Table ancestor---}
  _l3Unknown_Parent_ = TOvcBase;
  {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
  TOvcTableAncestor = class(_l3Unknown_)
    protected {private}
      {.Z+}
      taCellList : TList;
      taLoadList : TStringList;
      {.Z-}

    protected
      {.Z+}
      {streaming routines}
      procedure ChangeScale(M, D : integer); override;
      procedure DefineProperties(Filer : TFiler); override;
      procedure Loaded; override;

      procedure tbFinishLoadingCellList;
      procedure tbReadCellData(Reader : TReader);
      procedure tbWriteCellData(Writer : TWriter);

      procedure tbCellChanged(Sender : TObject); virtual; abstract;
      {.Z-}

    public {protected}
      {.Z+}
      {internal use only methods}
      procedure tbExcludeCell(Cell : TOvcTableCellAncestor);
      procedure tbIncludeCell(Cell : TOvcTableCellAncestor);
      procedure tbNotifyCellsOfTableChange;
      {.Z-}

    public
      constructor Create(AOwner : TComponent); override;
      procedure Cleanup; override;

      function FilterKey(var Msg : TWMKey) : TOvcTblKeyNeeds; virtual; abstract;
      procedure ResolveCellAttributes(RowNum : TRowNum; ColNum : TColNum;
                                      var CellAttr : TOvcCellAttributes); virtual; abstract;
  end;

type
  POvcSparseAttr = ^TOvcSparseAttr;
  TOvcSparseAttr = record  {attributes for cells in sparse matrix--INTERNAL USE}
    scaAccess : TOvcTblAccess;
    scaAdjust : TOvcTblAdjust;
    scaColor  : TColor;
    scaFont   : TFont;
    scaCell   : TOvcTableCellAncestor;
  end;

  POvcTableNumberArray = ^TOvcTableNumberArray;
  TOvcTableNumberArray = record {structure passed to GetDisplayedRow(Col)Numbers}
    NumElements : longint;      {..number of elements in Number array}
    Count       : longint;      {..return count of used elements in Number array}
    Number      : array [0..29] of longint; {..Number array}
  end;

{---Row style type}
type
  PRowStyle = ^TRowStyle;
  TRowStyle = record
    Height : Integer; {-1 means default}
    Hidden : boolean;
  end;

{---Short AnsiString type (length-byte AnsiString)}
{$IFDEF Win32}
type
  POvcShortString = ^ShortString;  {pointer to shortstring}
{$ELSE}
type
  POvcShortString = ^AnsiString;       {pointer to pascal AnsiString}
{$ENDIF}

{---Exception classes}
type
  EOrpheusTable = class(Exception);

{---Notification events}
type
  TRowNotifyEvent = procedure (Sender : TObject; RowNum : TRowNum) of object;
  TColNotifyEvent = procedure (Sender : TObject; ColNum : TColNum) of object;
  TCellNotifyEvent = procedure (Sender : TObject;
                                RowNum : TRowNum; ColNum : TColNum) of object;
  TCellDataNotifyEvent = procedure (Sender : TObject;
                                    RowNum : TRowNum; ColNum : TColNum;
                                    var Data : pointer;
                                    Purpose : TOvcCellDataPurpose) of object;
  TCellAttrNotifyEvent = procedure (Sender : TObject;
                                    RowNum : TRowNum; ColNum : TColNum;
                                    var CellAttr : TOvcCellAttributes) of object;
  TCellPaintNotifyEvent = procedure (Sender : TObject;
                                     TableCanvas : TCanvas;
                               const CellRect    : TRect;
                                     RowNum      : TRowNum;
                                     ColNum      : TColNum;
                               const CellAttr    : TOvcCellAttributes;
                                     Data        : pointer;
                                 var DoneIt      : boolean) of object;
  TCellBeginEditNotifyEvent = procedure (Sender : TObject;
                                         RowNum : TRowNum; ColNum : TColNum;
                                         var AllowIt : boolean) of object;
  TCellEndEditNotifyEvent = procedure (Sender : TObject;
                                       Cell : TOvcTableCellAncestor;
                                       RowNum : TRowNum; ColNum : TColNum;
                                       var AllowIt : boolean) of object;
  TCellMoveNotifyEvent = procedure (Sender : TObject; Command : word;
                                    var RowNum : TRowNum;
                                    var ColNum : TColNum) of object;
  TCellChangeNotifyEvent = procedure (Sender : TObject;
                                      var RowNum : TRowNum;
                                      var ColNum : TColNum) of object;
  TRowChangeNotifyEvent = procedure (Sender : TObject; RowNum1, RowNum2 : TRowNum;
                                     Action : TOvcTblActions) of object;
  TColChangeNotifyEvent = procedure (Sender : TObject; ColNum1, ColNum2 : TColNum;
                                     Action : TOvcTblActions) of object;
  TSizeCellEditorNotifyEvent = procedure (Sender   : TObject;
                                          RowNum   : TRowNum;
                                          ColNum   : TColNum;
                                      var CellRect : TRect;
                                      var CellStyle: TOvcTblEditorStyle) of object;
  TSelectionIterator = function(RowNum1 : TRowNum; ColNum1 : TColNum;
                                RowNum2 : TRowNum; ColNum2 : TColNum;
                                ExtraData : pointer) : boolean of object;


{---Cell-Table interaction messages---}
const
  ctim_Base = WM_USER + $4545;
  ctim_QueryOptions = ctim_Base;
  ctim_QueryColor = ctim_Base + 1;
  ctim_QueryFont = ctim_Base + 2;
  ctim_QueryLockedCols = ctim_Base + 3;
  ctim_QueryLockedRows = ctim_Base + 4;
  ctim_QueryActiveCol = ctim_Base + 5;
  ctim_QueryActiveRow = ctim_Base + 6;

  ctim_RemoveCell = ctim_Base + 10;
  ctim_StartEdit = ctim_Base + 11;
  ctim_StartEditMouse = ctim_Base + 12;
  ctim_StartEditKey = ctim_Base + 13;

  ctim_SetFocus = ctim_Base + 14;
  ctim_KillFocus = ctim_Base + 15;

  ctim_LoadDefaultCells = ctim_Base + 20;

{---Property defaults}
const
  tbDefAccess = otxNormal;
  tbDefAdjust = otaCenterLeft;
  tbDefBorderStyle = bsSingle;
  tbDefColCount = 10;
  tbDefColWidth = 150;
  tbDefGridColor = clBlack;
  tbDefHeight = 100;
  tbDefLockedCols = 1;
  tbDefLockedRows = 1;
  tbDefMargin = 4;
  tbDefRowCount = 10;
  tbDefRowHeight = 30;
  tbDefScrollBars = ssBoth;
  tbDefTableColor = clBtnFace;
  tbDefWidth = 300;

{---Default color for cells (to force them to table color)}
const
  clOvcTableDefault = $2FFFFFF;

{---Handy extra constants for table's CalcRowColFromXY method}
const
  CRCFXY_RowAbove = -2;    {Y is above all table cells}
  CRCFXY_RowBelow = -1;    {Y is below all table cells}
  CRCFXY_ColToLeft = -2;   {X is to left of all table cells}
  CRCFXY_ColToRight = -1;  {X is to right of all table cells}

{---Handy extra constants for TRowNum variables, Row Heights}
const
  RowLimitChanged = -2;
  UseDefHt = -1;

type {internal use only}
  TOvcTblDisplayItem = record
    Number : longint;
    Offset : Integer;
  end;
  POvcTblDisplayArray = ^TOvcTblDisplayArray;
  TOvcTblDisplayArray = record
    AllocNm : word;
    Count : word;
    Ay : array [0..127] of TOvcTblDisplayItem; {127 is arbitrary}
  end;

{--Utility routines}
function MinI(X, Y : Integer) : Integer;
  {Return the minimum of two integers}
  {$IFNDEF Win32}
  inline($58/      {  pop ax}
         $5A/      {  pop dx}
         $39/$D0/  {  cmp ax, dx}
         $7E/$01/  {  jle @@Exit}
         $92       {  xchg ax, dx}
         );        {@@Exit:}
  {$ENDIF}
function MaxI(X, Y : Integer) : Integer;
  {Return the maximum of two integers}
  {$IFNDEF Win32}
  inline($58/      {  pop ax}
         $5A/      {  pop dx}
         $39/$D0/  {  cmp ax, dx}
         $7D/$01/  {  jge @@Exit}
         $92       {  xchg ax, dx}
         );        {@@Exit:}
  {$ENDIF}
function MaxL(A, B : longint) : longint;
function MinL(A, B : longint) : longint;

function MakeRowStyle(AHeight : Integer; AHidden : boolean) : TRowStyle;
  {-Make a row style variable from a height and hidden flag.}

procedure TableError(Msg : AnsiString);
  {-Raise an exception with supplied AnsiString}
procedure TableErrorRes(StringCode : word);
  {-Raise an exception with supplied AnsiString resource code}

procedure AssignDisplayArray(var A : POvcTblDisplayArray; Num : word);
  {-Table internal: (re)assign a display array}

implementation

uses
  l3Interfaces,
  l3Base,
  l3Interlocked
  ;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

{===Standard routines================================================}
{$IFDEF Win32}
function MinI(X, Y : Integer) : Integer;
  {Return the minimum of two integers}
asm
  cmp  eax, edx
  jle  @@Exit
  mov  eax, edx
@@Exit:
end;
{--------}
function MaxI(X, Y : Integer) : Integer;
  {Return the maximum of two integers}
asm
  cmp  eax, edx
  jge  @@Exit
  mov  eax, edx
@@Exit:
end;
{$ENDIF}
{--------}
procedure TableError(Msg : AnsiString);
  begin
    raise EOrpheusTable.Create(Msg);
  end;
{--------}
procedure TableErrorRes(StringCode : word);
  begin
    raise EOrpheusTable.Create(GetOrphStr(StringCode));
  end;
{--------}
function MaxL(A, B : longint) : longint;
  begin
    if (A < B) then Result := B else Result := A;
  end;
{--------}
function MinL(A, B : longint) : longint;
  begin
    if (A < B) then Result := A else Result := B;
  end;
{--------}
procedure AssignDisplayArray(var A : POvcTblDisplayArray; Num : word);
  var
    NewA : POvcTblDisplayArray;
    NumToXfer : word;
  begin
    NewA := nil;
    if (Num > 0) then
       begin
         GetMem(NewA, Num*sizeof(TOvcTblDisplayItem)+2*sizeof(word));
         {$IFOPT D+}
         l3FillChar(NewA^, Num*sizeof(TOvcTblDisplayItem)+2*sizeof(word), $CC);
         {$ENDIF}
         if Assigned(A) then
           begin
             NumToXfer := MinL(Num, A^.Count);
             if (NumToXfer > 0) then
               l3Move(A^.Ay, NewA^.Ay, NumToXFer*sizeof(TOvcTblDisplayItem));
           end
         else
           NumToXfer := 0;
         with NewA^ do
           begin
             AllocNm := Num;
             Count := NumToXfer;
           end;
       end;
    if Assigned(A) then
      FreeMem(A, A^.AllocNm*sizeof(TOvcTblDisplayItem)+2*sizeof(word));
    A := NewA;
  end;
{--------}
function MakeRowStyle(AHeight : Integer; AHidden : boolean) : TRowStyle;
  begin
    with Result do
      begin
        Height := AHeight;
        Hidden := AHidden;
      end;
  end;
{====================================================================}


{===TOvcTableCellAncestor============================================}
procedure TOvcTableCellAncestor.tcChangeScale(M, D : integer);
  begin
    {do nothing at this level in the cell component hierarchy}
  end;
{--------}
procedure TOvcTableCellAncestor.tcDoCfgChanged;
  begin
    if Assigned(FOnCfgChanged) then
      FOnCfgChanged(Self);
  end;
{====================================================================}


{===TOvcTableAncestor================================================}
constructor TOvcTableAncestor.Create(AOwner : TComponent);
  begin
    inherited Create(AOwner);
    taCellList := TList.Create;
  end;
{--------}
procedure TOvcTableAncestor.Cleanup;
  begin
    FreeAndNil(taLoadList);
    FreeAndNil(taCellList);
    inherited;
  end;
{--------}
procedure TOvcTableAncestor.ChangeScale(M, D : integer);
  var
    i : integer;
  begin
    inherited ChangeScale(M, D);
    if (M <> D) then
      for i := 0 to pred(taCellList.Count) do
        TOvcTableCellAncestor(taCellList[i]).tcChangeScale(M, D);
  end;
{--------}
procedure TOvcTableAncestor.DefineProperties(Filer : TFiler);
  begin
    inherited DefineProperties(Filer);
    with Filer do
      DefineProperty('CellData', tbReadCellData, tbWriteCellData, true);
  end;
{--------}
procedure TOvcTableAncestor.tbExcludeCell(Cell : TOvcTableCellAncestor);
  begin
    taCellList.Remove(pointer(Cell));
  end;
{--------}
procedure TOvcTableAncestor.tbFinishLoadingCellList;
  {------}
  function GetImmediateParentForm(Control : TControl) : TForm;
    var
      ParentCtrl : TControl;
    begin
      ParentCtrl := Control.Parent;
      while Assigned(ParentCtrl) and (not (ParentCtrl is TCustomForm)) do{!!.16}
        ParentCtrl := ParentCtrl.Parent;
      Result := TForm(ParentCtrl);
    end;
  {------}
  function FormNamesEqual(CmptFormName, FormName : AnsiString) : boolean;{!!.01}
    var
      PosUL : integer;
    begin
      Result := true;
      if (FormName = '') or (CmptFormName = FormName) then
        Exit;
      PosUL := length(FormName);
      while (PosUL > 0) and (FormName[PosUL] <> '_') do
        dec(PosUL);
      if (PosUL > 0) then
        if (CmptFormName = Copy(FormName, 1, pred(PosUL))) then
          Exit;
      Result := false;
    end;
  {------}
  function GetFormName(const S, FormName : AnsiString) : AnsiString;
    var
      PosDot : integer;
    begin
      PosDot := Pos('.', S);
      if (PosDot <> 0) then
        Result := Copy(S, 1, pred(PosDot))
      else
        Result := FormName;
    end;
  {------}
  function GetComponentName(const S : AnsiString) : AnsiString;
    var
      PosDot : integer;
    begin
      PosDot := Pos('.', S);
      if (PosDot <> 0) then
        Result := Copy(S, succ(PosDot), length(S))
      else
        Result := S;
    end;
  {------}
  var
    i      : integer;
    Form   : TForm;
    Compnt : TComponent;
    {$IFDEF Win32}
    DM     : integer;
    DataMod: TDataModule;
    DMCount: integer;
    {$ENDIF}
  begin
    if Assigned(taLoadList) then
      begin
        {fixup the cell component list: the cells now exist}
        try
          Form := GetImmediateParentForm(Self);
          for i := pred(taLoadList.Count) downto 0 do
            if FormNamesEqual(GetFormName(taLoadList[i], Form.Name),
                              Form.Name) then                   {!!.01}
              begin
                Compnt := Form.FindComponent(GetComponentName(taLoadList[i]));
                if Assigned(Compnt) and (Compnt is TOvcTableCellAncestor) then
                  begin
                    tbIncludeCell(TOvcTableCellAncestor(Compnt));
                    taLoadList.Delete(i);
                  end;
              end;
          {$IFDEF Win32}
          {fixup references to cell components on any data modules}
          if (taLoadList.Count <> 0) then
            begin
              DM := 0;
              DMCount := Screen.DataModuleCount;
              while (taLoadList.Count > 0) and (DM < DMCount) do
                begin
                  DataMod := Screen.DataModules[DM];
                  for i := pred(taLoadList.Count) downto 0 do
                    if (GetFormName(taLoadList[i], Form.Name) = DataMod.Name) then
                      begin
                        Compnt := DataMod.FindComponent(GetComponentName(taLoadList[i]));
                        if Assigned(Compnt) and (Compnt is TOvcTableCellAncestor) then
                          begin
                            tbIncludeCell(TOvcTableCellAncestor(Compnt));
                            taLoadList.Delete(i);
                          end;
                      end;
                  inc(DM);
                end;
            end;
          {$ENDIF}
        finally
          FreeAndNil(taLoadList);
        end;
      end;
  end;
{--------}
procedure TOvcTableAncestor.tbIncludeCell(Cell : TOvcTableCellAncestor);
  begin
    if Assigned(Cell) then
      with taCellList do
        if (IndexOf(pointer(Cell)) = -1) then
          begin
            Add(pointer(Cell));
            Cell.OnCfgChanged := tbCellChanged;
          end;
  end;
{--------}
procedure TOvcTableAncestor.Loaded;
  begin
    inherited Loaded;
    {$IFNDEF Win32}
    tbFinishLoadingCellList;
    {$ENDIF}
  end;
{--------}
procedure TOvcTableAncestor.tbNotifyCellsOfTableChange;
  var
    i : integer;
  begin
    if Assigned(taCellList) then
      for i := 0 to pred(taCellList.Count) do
        TOvcTableCellAncestor(taCellList[i]).tcResetTableValues;
  end;
{--------}
procedure TOvcTableAncestor.tbReadCellData(Reader : TReader);
  begin
    if Assigned(taLoadList) then
      taLoadList.Clear
    else
      taLoadList := TStringList.Create;
    with Reader do
      begin
        ReadListBegin;
        while not EndOfList do
          taLoadList.Add(ReadString);
        ReadListEnd;
      end;
  end;
{--------}
procedure TOvcTableAncestor.tbWriteCellData(Writer : TWriter);
  var
    i : integer;
    {$IFDEF Win32}
    Cell : TOvcTableCellAncestor;
    S : AnsiString;
    {$ENDIF}
  begin
    with Writer do
      begin
        WriteListBegin;
        for i := 0 to pred(taCellList.Count) do
          begin
            {$IFDEF Win32}
            Cell := TOvcTableCellAncestor(taCellList[i]);
            S := Cell.Owner.Name;
            if (S <> '') then
              S := S + '.' + Cell.Name
            else
              S := Cell.Name;
            WriteString(S);
            {$ELSE}
            WriteString(TOvcTableCellAncestor(taCellList[i]).Name);
            {$ENDIF}
          end;
        WriteListEnd;
      end;
  end;
{====================================================================}

end.