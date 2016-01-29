unit Extbl1u;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, OvcEf, OvcPb, OvcPf, OvcTCPic, OvcTCBEF, OvcTCHdr,
  OvcTCmmn, OvcTable, OvcTCStr, OvcTCEdt, OvcBase, StdCtrls, Buttons,
  OvcTCell;

type
  TForm1 = class(TForm)
    OvcTable1: TOvcTable;
    OvcController1: TOvcController;
    OvcTCString1: TOvcTCString;
    OvcTCString2: TOvcTCString;
    OvcTCRowHead1: TOvcTCRowHead;
    OvcTCPictureField1: TOvcTCPictureField;
    BitBtn1: TBitBtn;
    procedure OvcTable1GetCellData(Sender: TObject; RowNum: Longint;
      ColNum: Integer; var Data: Pointer; Purpose : TOvcCellDataPurpose);
    procedure OvcTable1GetCellAttributes(Sender: TObject; RowNum: Longint;
      ColNum: Integer; var CellAttr: TOvcCellAttributes);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.OvcTable1GetCellData(Sender: TObject; RowNum: Longint;
  ColNum: Integer; var Data: Pointer; Purpose : TOvcCellDataPurpose);
type
  TTestRec = record
    Name  : string[49];
    Age   : word;
  end;
  TTestDataBase = array [1..9] of TTestRec;
const
  TestDatabase : TTestDataBase = (
    (Name:'Bucknall, Julian'; Age:38),
    (Name:'Inman, Lee';       Age:43),
    (Name:'Hughes, Terry';    Age:36),
    (Name:'Slater, Bryan';    Age:18),
    (Name:'Leier, John';      Age:31),
    (Name:'Frerking, Gary';   Age:27),
    (Name:'Kokkonen, Kim';    Age:42),
    (Name:'';                 Age:0),
    (Name:'';                 Age:0));
const
  ColHeading : string[15] = '';
begin
  Data := nil;
  if (1 <= RowNum) and (RowNum <= 9) then
    begin
      case ColNum of
        1 : Data := @TestDatabase[RowNum].Name;
        2 : Data := @TestDatabase[RowNum].Age;
      end;{case}
    end
  else
    begin
      case ColNum of
        0 : ColHeading := 'TP';
        1 : ColHeading := 'Name';
        2 : ColHeading := 'Age';
      end;{case}
      Data := @ColHeading;
    end;
end;

procedure TForm1.OvcTable1GetCellAttributes(Sender: TObject;
  RowNum: Longint; ColNum: Integer; var CellAttr: TOvcCellAttributes);
begin
  if (RowNum = 0) and (ColNum = 2) then
    CellAttr.caAdjust := otaCenterRight;
end;

end.
