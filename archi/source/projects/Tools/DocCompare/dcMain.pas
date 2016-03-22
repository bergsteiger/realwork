unit dcMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit,
  evSCSub, evSCSubAttr, evSubCompareInterfaces, evSCSubAttrList, evSCSubList, evSCCollectFilter;

type
  TForm1 = class(TForm)
    fnFile1: TFilenameEdit;
    fnFile2: TFilenameEdit;
    btnDoJob: TButton;
    Label1: TLabel;
    memResult: TMemo;
    procedure btnDoJobClick(Sender: TObject);
  private
    f_Differs: Boolean;
    procedure OutString(const aStr: AnsiString; const aArgs: array of const);
    procedure CompareAttrs(const aSub1, aSub2: IevSCSub);
    procedure DoJob;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 k2TagGen,
 k2Reader,
 evdReader,
 l3Filer,
 l3Diff,
 l3DiffSupport,
 ddNSRC_r;

{$R *.dfm}

type
 TFileType = (ftEVD, ftNSRC);

procedure TForm1.btnDoJobClick(Sender: TObject);
begin
 DoJob;
end;

procedure TForm1.CompareAttrs(const aSub1, aSub2: IevSCSub);

 function CompareAttr(I1: Integer; I2: Integer): Boolean;
 var
  l_A1, l_A2: IevSCAttrElement;
 begin
  l_A1 := aSub1.Attr[I1];
  l_A2 := aSub2.Attr[I2];
  Result := (l_A1.AttrType = l_A2.AttrType) and (l_A1.ID = l_A2.ID) and (l_A1.SubID = l_A2.SubID);
 end;

 procedure ReportAttr(const aARR: Tl3DiffReportRec);
 var
  l_AttrStr: AnsiString;
  l_Attr: IevSCAttrElement;
 begin
  if aARR.rOp = l3diffSame then
   Exit;
  if aARR.rOp = l3diffDeleted then
   l_Attr := aSub1.Attr[aARR.rLeftIdx]
  else
   l_Attr := aSub2.Attr[aARR.rRightIdx];
  if l_Attr.AttrType = sca_Link then
   l_AttrStr := Format('%s на документ %d.%d', [cSCAttrTypeName[l_Attr.AttrType], l_Attr.ID, l_Attr.SubID])
  else
   l_AttrStr := Format('%s (%d)', [cSCAttrTypeName[l_Attr.AttrType], l_Attr.ID]);
  case aARR.rOp of
   l3diffDeleted: OutString('Второй документ, %s с номером %d: отсутствует %s', [
                   cSCSubTypeName[aSub1.SubType],
                   aSub1.Handle,
                   l_AttrStr
                  ]);
   l3diffAdded  : OutString('Первый документ, %s с номером %d: отсутствует %s', [
                   cSCSubTypeName[aSub1.SubType],
                   aSub1.Handle,
                   l_AttrStr
                  ]);
  end;
  f_Differs := True;
 end;
var
  l_AttrCF: Tl3DiffCompareFunc;
  l_AttrRP: Tl3DiffReportProc;
begin
 l_AttrCF := l3L2CF(@CompareAttr);
 try
  l_AttrRP := l3L2RP(@ReportAttr);
  try
   L3DoDiff(aSub1.AttrCount, aSub2.AttrCount, l_AttrCF, l_AttrRP);
  finally
   l3FreeRP(l_AttrRP);
  end;
 finally
  l3FreeCF(l_AttrCF);
 end;
end;

procedure TForm1.OutString(const aStr: AnsiString; const aArgs: array of const);
begin
 memResult.Lines.Insert(0, Format(aStr, aArgs));
end;

procedure TForm1.DoJob;
var
 l_SubList1, l_SubList2: TevSCSubList;
 l_Gen: Tk2TagGenerator;
 l_CollectList: TevSCSubList;
 l_Filer: Tl3DOSFiler;
 I : Integer;
 l_Ext1: AnsiString;
 l_Ext2: AnsiString;
 l_FT: TFileType;
 l_SubCF: Tl3DiffCompareFunc;
 l_SubRP: Tl3DiffReportProc;

 function CompareSub(I: Integer; J: Integer): Boolean;
 var
  l_S1, l_S2: IevSCSub;
 begin
  l_S1 := l_SubList1.Items[I];
  l_S2 := l_SubList2.Items[J];
  Result := {(l_S1.SubType = l_S2.SubType) and} (l_S1.Handle = l_S2.Handle);
 end;

 procedure ReportSub(const aSRR: Tl3DiffReportRec);
 var
  l_Sub1, l_Sub2: IevSCSub;
 begin
  case aSRR.rOp of
   l3diffSame:
    begin
     l_Sub1 := l_SubList1.Items[aSRR.rLeftIdx];
     l_Sub2 := l_SubList2.Items[aSRR.rRightIdx];
     if l_Sub1.SubType <> l_Sub2.SubType then
     begin
      OutString('В первом документе есть %s с номером %d, а во втором с этим номером - %s.', [
       cSCSubTypeName[l_Sub1.SubType], l_Sub1.Handle, cSCSubTypeName[l_Sub2.SubType]
       ]);
      f_Differs := True;
     end
     else
      CompareAttrs(l_Sub1, l_Sub2);
    end;
   l3diffDeleted:
    begin
     l_Sub1 := l_SubList1.Items[aSRR.rLeftIdx];
     OutString('Во втором документе отсутствует %s с номером %d', [cSCSubTypeName[l_Sub1.SubType], l_Sub1.Handle]);
     f_Differs := True;
    end;
   l3diffAdded:
    begin
     l_Sub2 := l_SubList2.Items[aSRR.rRightIdx];
     OutString('В первом документе отсутствует %s с номером %d', [cSCSubTypeName[l_Sub2.SubType], l_Sub2.Handle]);
     f_Differs := True;
    end;
  end;
 end;

begin
 if not FileExists(fnFile1.FileName) then
 begin
  MessageDlg('Не найден файл первого документа!', mtError, [mbOk], 0);
  Exit;
 end;
 if not FileExists(fnFile2.FileName) then
 begin
  MessageDlg('Не найден файл второго документа!', mtError, [mbOk], 0);
  Exit;
 end;
 l_Ext1 := AnsiUpperCase(ExtractFileExt(fnFile1.FileName));
 l_Ext2 := AnsiUpperCase(ExtractFileExt(fnFile2.FileName));
 if l_Ext1 <> l_Ext2 then
 begin
  MessageDlg('Я не умею сравнивать файлы разных типов. Извините.', mtError, [mbOk], 0);
  Exit;
 end;
 if (l_Ext1 = '.EVD') or (l_Ext1 = '.EVT') then
  l_FT := ftEVD
 else
 {
  if l_Ext1 = '.NSR' then
   l_FT := ftNSRC
  else }
  begin
   MessageDlg('Я умею сравнивать только файлы формата EVD.', mtError, [mbOk], 0);
   Exit;
  end;
 l_SubList1 := TevSCSubList.Make;
 l_SubList2 := TevSCSubList.Make;
 f_Differs := False;
 try
  l_Gen := nil;
  try
   TevSCCollectFilter.SetTo(l_Gen);
   l_CollectList := TevSCCollectFilter(l_Gen).SubList;
   case l_FT of
    ftEVD  : TevdNativeReader.SetTo(l_Gen);
    ftNSRC : TCustomNSRCReader.SetTo(l_Gen);
   end;
   l_Filer := Tl3DOSFiler.Make(fnFile1.FileName);
   try
    l_Filer.Open;
    TevdNativeReader(l_Gen).Filer := l_Filer;
    TevdNativeReader(l_Gen).Execute;
    for I := 0 to l_CollectList.Count - 1 do
     l_SubList1.Add(l_CollectList.Items[I]);
    l_Filer.Close;
    l_Filer.FileName := fnFile2.FileName;
    l_Filer.Open;
    Tk2CustomFileReader(l_Gen).Execute;
    for I := 0 to l_CollectList.Count - 1 do
     l_SubList2.Add(l_CollectList.Items[I]);
   finally
    FreeAndNil(l_Filer);
   end;
  finally
   FreeAndNil(l_Gen);
  end;
  // данные набрали, теперь будем сравнивать
  memResult.Clear;
  l_SubCF := l3L2CF(@CompareSub);
  try
   l_SubRP := l3L2RP(@ReportSub);
   try
    L3DoDiff(l_SubList1.Count, l_SubList2.Count, l_SubCF, l_SubRP);
   finally
    l3FreeRP(l_SubRP);
   end;
  finally
   l3FreeCF(l_SubCF);
  end;      
  if not f_Differs then
   OutString('Различий в документах не найдено.',[]);
 finally
  FreeAndNil(l_SubList1);
  FreeAndNil(l_SubList2);
 end;
end;

end.
