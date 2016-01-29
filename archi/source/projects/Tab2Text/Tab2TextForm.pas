unit Tab2TextForm;
{$DEFINE FirstStep}
{$DEFINE NewParser}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  l3ProgressComponent, l3Filer, OvcBase,  W95Meter,
  StdCtrls, RXCtrls, Mask, ToolEdit, RXSpin, l3InterfacedComponent,
  ComCtrls, LED, ddProgressObj, XPMan;

type
  TForm1 = class(TForm)
    editInFile: TFilenameEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    InFiler: TevDOSFiler;
    OutFiler: TevDOSFiler;
    OvcController1: TOvcController;
    FinalFiler: TevDOSFiler;
    evDOSFiler1: TevDOSFiler;
    RxSpinEdit1: TRxSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    cbBorders: TCheckBox;
    ProgressBar1: TProgressBar;
    Step1LED: TLED;
    Step2Led: TLED;
    Step3Led: TLED;
    ProgressBar2: TProgressBar;
    ProgressBar3: TProgressBar;
    XPManifest1: TXPManifest;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure editInFileChange(Sender: TObject);
  private
    { Private declarations }
   f_Progressor: TddProgressObject;
   f_StepNo : Integer;
   procedure ProgressProc(Sender: TObject; aState: Byte);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

Uses
  l3Base, l3Types, l3Prg, l3String, l3Chars,
  evTextFormatter, 
  k2Tags,
  ddUtils, ddDocReader, ddBase, Tab2TableGen;

procedure TForm1.Button1Click(Sender: TObject);
var
  l_DocReader  : TddDocReader;
  l_Formatter  : TevTextFormatter;
  l_TextGen    : TevPlainTextGenerator;
  l_Mask       : Tl3String;
  l_TableMask  : Tl3String;
  l_TopTable,
  l_BottomTable: Tl3String;
  l_Text       : Tl3String;
  i, Delta     : Integer;
  l_Line       : Integer;
  l_S          : Tl3String;
  l_BT         : Tl3BMTable;
  l_Pos        : Cardinal;
  l_TableStart : Boolean;
  l_Handle     : Longint;

  l_Row        : TddTableRow;
  l_CellCount  : Integer;
  l_CellIndex  : Integer;
  l_CellDelta  : Integer;
  l_CellFound  : Integer;
  {$IFDEF NewParser}
  l_Gen: TddTab2TableGenerator;
  {$ENDIF}
begin
 Button1.Enabled:= False;
 Try
  Step1Led.Lit:= False;
  Step2Led.Lit:= False;
  Step3Led.Lit:= False;

  ProgressBar1.Position:= 0;
  ProgressBar2.Position:= 0;
  ProgressBar3.Position:= 0;

  InFiler.FileName:= editInFile.Text;
  OutFiler.FileName:= ChangeFileExt(editInFile.Text, '.temp');
  OutFiler.CodePage:= cp_ANSI;
  finalFiler.FileName:= ChangeFileExt(editInFile.Text, '.txt');
  finalFiler.Mode:= l3_fmWrite;
  finalFiler.CodePage:= cp_OEM;
  f_StepNo:= 1;
  {$IFDEF FirstStep}
  l_DocReader:= TddDocReader.Create(nil);
  try
   l_DocReader.Filer:= InFiler;
   {$IFDEF NewParser}
   l_Gen:= TddTab2TableGenerator.Create(nil);
   try
    l_DocReader.Generator:= l_Gen;
    l_Gen.Filer:= OutFiler;
    l_gen.CharPerLine:= RxSpinEdit1.AsInteger;
    InFiler.Indicator.OnProgressProc:= f_Progressor.Update;
    f_Progressor.Start;
    l_DocReader.Execute;
    f_Progressor.Stop;
   finally
    l3Free(l_Gen);
   end;
   {$ELSE}
   l_Formatter:= TevTextFormatter.Create(nil);
   try
     l_DocReader.Generator:= l_Formatter;
     l_Formatter.CharsInLine:= RxSpinEdit1.AsInteger;
     l_Formatter.FormatOrdinalParas:= False;
     l_Formatter.CodePage:= cp_OEMLite;
     l_TextGen:= TevPlainTextGenerator.Create(nil);
     try
       l_Formatter.Generator:= l_TextGen;
       l_TextGen.Filer:= OutFiler;
       InFiler.Indicator.OnProgressProc:= f_Progressor.Update;
       f_Progressor.Start;
       l_DocReader.Execute;
       f_Progressor.Stop;
     finally
       l3Free(l_TextGen);
     end; {l_TextGen}
   finally
     l3FRee(l_Formatter);
   end; {l_Formatter }
   {$ENDIF}
  finally
   l3Free(l_DocReader);
  end; { l_DocREader }
  Step1Led.Lit:= True;
  ProgressBar1.Position:= 0;
  Application.ProcessMessages;
  {$ENDIF}

  { Создание маски строки }
  f_StepNo:= 2;
  l_Mask:= Tl3String.CReate(nil);
  try
   OutFiler.Indicator.OnProgressProc:= f_Progressor.Update;
   OutFiler.Mode:= l3_fmRead;
   OutFiler.Open;
   l_Line:= 0;
   f_Progressor.Start;
   while {(l_Line <=100) and} (not OutFiler.EOF) do
   begin
    l_Text:= OutFiler.Readln;
    if (l_Text.Len > 0) and (l_Text.Ch[0] <> '>') then
    begin
     if l_Text.Len > l_Mask.Len then
      l_Mask.RPad2(l_Text.Len, ' ');
     for i:= 0 to Pred(l_Text.Len) do
     begin
      if l_Text.Ch[i] <> ' ' then
       l_Mask.Ch[i]:= 'X';
      if (i in [128..129]) and (l_Text.Ch[i] <> ' ') then
       l_Mask.Ch[i]:= 'X';
     end; { for }
     Inc(l_Line);
    end; // (l_Text.Len > 0) and (l_Text.Ch[0] <> '>')
   end; { while EOF }
   f_Progressor.Stop;

   Step2Led.Lit:= True;
   ProgressBar2.Position:= 0;
   Application.ProcessMessages;

   l_S:= Tl3String.Create;
   try
    l_S.AsString:= '  ';
    l_S.MakeBMTable(l_BT);
    while l_S.BMSearch(l_Mask, l_BT, l_Pos) do
    begin
     i:= l_Pos+1;
     while (l_Mask.Ch[i] = ' ') and (i < l_Mask.Len) do
     begin
      l_Mask.Ch[i]:= '0';
      Inc(i);
     end;
    end; // while l_S.BMSearch(l_Mask, l_BT, l_Pos)
   finally
    l3FRee(l_S);
   end;

   l_CellCount:= 0;

   l_TableMask:= Tl3String.Create(nil);
   l_TopTable:= Tl3String.Create(nil);
   l_BottomTable:= Tl3String.Create(nil);
   try
    // Коррекция маски для расставления признаков колонки.
    // Потом можно будет удалить
    for i:= 0 to l_Mask.Len-1 do
    begin
     if (i > 0) and (i< l_Mask.Len-1) then
     begin
      if (l_Mask.Ch[i] = ' ') then
       if (l_Mask.Ch[i-1] = 'X') and (l_Mask.Ch[i+1] <> 'X') then
        l_Mask.Ch[i] := '#'
     end; // (i > 0) and (i< l_Mask.Len-1)
     if l_Mask.Ch[i] in ['X', ' '] then
     begin
      l_TableMask.Append(cc_HLine);
      l_TopTable.Append(cc_HLine);
      l_BottomTable.Append(cc_HLine);
     end
     else
     if l_Mask.Ch[i] = '#' then
     begin
      l_TableMask.Append(cc_Cross);
      l_TopTable.Append(cc_UpCross);
      l_BottomTable.Append(cc_DownCross);
      Inc(l_CellCount);
     end;
    end;

    Inc(l_CellCount);
    l_Mask.Append('#');
    l_TableMask.Ch[0]:= cc_LeftCross;
    l_TableMask.Ch[l_TableMask.Len]:= cc_RightCross;
    l_TopTable.Ch[0]:= cc_TopLeft;
    l_TopTable.Ch[l_TableMask.Len-1]:= cc_TopRight;
    l_BottomTable.Ch[0]:= cc_BottomLeft;
    l_BottomTable.Ch[l_TableMask.Len-1]:= cc_BottomRight;

    { Запись результирующего файла }
    OutFiler.Close;
    f_StepNo:= 3;
    evDoSFiler1.FileName:= OutFiler.FileName;
    evDOSFiler1.Open;

    l_TableStart:= False;
{$IFDEF Table}
    l_Formatter:= TevTextFormatter.Create(nil);
    try
      l_Formatter.CharsInLine:= RxSpinEdit1.AsInteger-30;
      l_Formatter.FormatOrdinalParas:= False;
      l_TextGen:= TevPlainTextGenerator.Create(nil);
      try
        l_Formatter.Generator:= l_TextGen;
        l_TextGen.Filer:= finalFiler;

        l_Formatter.Start;
        l_Formatter.StartChild(k2_idDocument);
        try
          l_Row:= nil;
          f_Progressor.Start;
          while not evDOSFiler1.EOF do
          begin
            l_Text:= evDOSFiler1.Readln;

            if (l_Text.Len > 0) and ((l_Text.Ch[0] <> '>') or (l_TableStart))then
            begin
              if not ev_lpCharSetPresent(l_Text.st, l_Text.Len, [#0..#31, #33..#255]) then
              begin
                if l_TableStart then  // Прерывание строки таблицы
                begin
                  if l_Row <> nil then
                    l_Row.Write2Generator(l_Formatter);
                  l3Free(l_Row);
                  Continue;
                end;
              end
              else
              begin
                if not l_TableStart then
                begin
                  l_Formatter.StartChild(k2_idTable);

                  if cbBorders.Checked then
                  begin
                    { Добавляем рамки }

                  end; { if cbBorders}
                end; { if not l_TableStart }

                if (l_Text.Ch[0] = '>') then
                begin
                  l_Text.Ch[0]:= ' ';
                  if l_Text.Ch[1] = #9 then
                    l_Text.Ch[1]:= ' ';
                end;

                l_TableStart:= True;
                l_Text.RPad2(l_Mask.Len, ' ');
                Delta:= 0;
                for i:= 0 to Pred(l_Mask.Len) do
                begin
                  try
                    if (l_Mask.Ch[i] = '0') and (l_Text.Ch[i-Delta] = ' ') then
                    begin
                      l_Text.Delete(i-Delta, 1);
                      Inc(Delta);
                    end
                    else
                    if (l_Mask.Ch[i] = '#') and (l_Text.Ch[i-Delta] = ' ') then
                      l_Text.Ch[i-Delta]:= cc_VLine;
                  except
                  end;
                end;
                l_Text.RTrim;
                l_Text.RPad2(l_TableMask.Len, ' ');

              end;

            end
            else
            if (l_Text.Len > 0) and (l_Text.Ch[0] = '>') then
            begin
              l_Text.RTrim;
              l_Text.Delete(0, 1);
            end;

            if l_TableStart then
            begin
              // Разделяем текст на кусочки и добавляем к содержимому ячеек
              if l_Row = nil then
                  begin
                    l_Row:= TddTableRow.Create(nil);

                    for i:= 1 to l_CellCount do
                    begin
                      l_Row.AddCellAndPara;
                      l_Row.Cells[i-1].LastPara.FirstStep:= False;
                      if cbBorders.Checked then
                      begin
                        { Добавляем рамки }
                        l_Row.TAP.CellsProps[i-1].Border.IsFramed:= True;
                      end; { if cbBorders}
                      l_Row.TAP.CellsProps[i-1].LeftPad:= 0;
                      l_Row.TAP.CellsProps[i-1].RightPad:= 0;
                    end; { for i }


                  end; { if l_Row = nil }
              Delta:= 0; l_CellDelta:= 1;
              l_CellIndex:= 0;
              i:= l_Text.FindChar(Delta, cc_VLine);
              while (i <> -1) and (i < l_Text.Len) do
              begin
                l_Row.Cells[l_CellIndex].LastPara.Text.Append(l3PCharLen(l_Text.St+Delta, i-Delta));
                l_Row.Cells[l_CellIndex].LastPara.Text.TrimAll;
                l_Row.Cells[l_CellIndex].LastPara.Text.Append(cc_SoftEnter);

                l_CellFound:= l_TableMask.FindChar(l_CellDelta, cc_Cross);
                if l_CellFound = -1 then
                  l_CellFound:= l_TableMask.Len;


                l_Row.TAP.CellsProps[l_CellIndex].Width:= evChar2Pixel(l_CellFound-l_CellDelta)*100 div 144;
                if l_CellIndex > 0 then
                  l_Row.TAP.CellsProps[l_CellIndex].Width:= l_Row.TAP.CellsProps[l_CellIndex].Width+l_Row.TAP.CellsProps[l_CellIndex-1].Width;

                l_CellDelta:= l_CellFound+1;
                Inc(l_CellIndex);
                Delta:= i+1;
                i:= l_Text.FindChar(Delta, cc_VLine);
              end;
            end
            else
            begin
              l_Formatter.StartChild(k2_idTextPara);
              try
                l_Formatter.AddStringAtom(k2_tiText, l_Text);
              finally
                l_Formatter.Finish;
              end;
            end;
          end; { while..do }
          f_Progressor.Stop;
          if l_TableStart then  // Прерывание строки таблицы
                begin
                  l_Row.Write2Generator(l_Formatter);
                  l3Free(l_Row);
                  l_Formatter.Finish;
                end;
        finally
          l_Formatter.Finish;
        end;
        l_Formatter.Finish;
      finally
        l3Free(l_TextGen)
      end;
    finally
      l3Free(l_Formatter);
    end;


{$ELSE}
    finalFiler.Open;
    while not evDOSFiler1.EOF do
    begin
      l_Text:= evDOSFiler1.Readln;

      if (l_Text.Len > 0) and ((l_Text.Ch[0] <> '>') or (l_TableStart))then
      begin
        if not ev_lpCharSetPresent(l_Text.st, l_Text.Len, [#0..#31, #33..#255]) then
        begin
          if l_TableStart and cbBorders.Checked then  // Прерывание строки таблицы
          begin
            l_Text.Assign(l_TableMask);
          end;
          //else
        //  begin
        //    finalFiler.Write(l_Text);
        //    finalFiler.Write(#13#10);
        //  end;
        end
        else
        begin
          if not l_TableStart and cbBorders.Checked then
          begin
            finalFiler.Write(l_TopTable);
            finalFiler.Write(#13#10);
          end;

          if (l_Text.Ch[0] = '>') then
          begin
            //l_Text.Delete(0, 1);
            l_Text.Ch[0]:= ' ';
            if l_Text.Ch[1] = #9 then
              l_Text.Ch[1]:= ' ';
          end;

          l_TableStart:= True;
          l_Text.RPad2(l_Mask.Len, ' ');
          Delta:= 0;
          for i:= 0 to Pred(l_Mask.Len) do
          begin
            try
              if (l_Mask.Ch[i] = '0') and (l_Text.Ch[i-Delta] = ' ') then
              begin
                l_Text.Delete(i-Delta, 1);
                Inc(Delta);
              end
              else
              if (l_Mask.Ch[i] = '#') and (l_Text.Ch[i-Delta] = ' ') and cbBorders.Checked then
                l_Text.Ch[i-Delta]:= cc_VLine;
            except
            end;
          end;
          l_Text.RTrim;
          l_Text.RPad2(l_TableMask.Len, ' ');
          if cbBorders.Checked then
          begin
            l_Text.Ch[0]:= cc_VLine;
            l_Text.Ch[l_Text.Len-1]:= cc_VLine;
          end;
        end;

      end
      else
      if (l_Text.Len > 0) and (l_Text.Ch[0] = '>') then
      begin
        l_Text.Delete(0, 1);
      end;
      if l_TExt.Empty and cbBorders.Checked and l_TableStart then
        finalFiler.Write({l_BottomTable}l_TableMask)
      else
        finalFiler.Write(l_Text);
      finalFiler.Write(#13#10);
    end; { while..do }
    finalFiler.Write(l_BottomTable);
    finalFiler.Write(#13#10);
   {$ENDIF}
   finally
     l3Free(l_TableMask);
     l3Free(l_TopTable);
     l3Free(l_BottomTable);
   end;
    Step3Led.Lit:= True;
    ProgressBar3.Position:= 0;
    Application.ProcessMessages;
  finally
    evDOSFiler1.Close;
    finalFiler.Close;
    l3FRee(l_Mask);                          
    DeleteFile(OutFiler.FileName);
  end;

 finally
  Button1.Enabled:= True;
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label5.Caption:= GetProgramVersion;
  f_Progressor:= TddProgressObject.Create(nil);
  f_Progressor.OnUpdate:= ProgressProc;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
 L3Free(f_Progressor);
end;

procedure TForm1.ProgressProc(Sender: TObject; aState: Byte);
begin
 case aState of
  0:
  begin
   case f_StepNo of
    1:
    begin
     ProgressBar1.Position:= 0;
     ProgressBar1.Max:= f_Progressor.Max;
    end;
    2:
    begin
     ProgressBar2.Position:= 0;
     ProgressBar2.Max:= f_Progressor.Max;
    end;
    3:
    begin
     ProgressBar3.Position:= 0;
     ProgressBar3.Max:= f_Progressor.Max;
    end;
   end;
  end;
  1:
  begin
   case f_StepNo of
    1: ProgressBar1.Position:= f_Progressor.Cur;
    2: ProgressBar2.Position:= f_Progressor.Cur;
    3: ProgressBar3.Position:= f_Progressor.Cur;
   end;
  end;
  2:
  begin
   case f_StepNo of
    1: ProgressBar1.Position:= 0;
    2: ProgressBar2.Position:= 0;
    3: ProgressBar3.Position:= 0;
   end;
  end;
 end;

 Application.ProcessMessages;
end;
procedure TForm1.editInFileChange(Sender: TObject);
begin
 editInFile.Text:= AnsiDequotedStr(editInFile.Text, '"');
 Button1.Enabled:= (editInFile.Text <> '') and (FileExists(editInFile.Text));
end;

end.
