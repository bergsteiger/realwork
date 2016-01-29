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
{*                  OVCXFRC1.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcXfrC1;
  {-Property editor for the transfer component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, ClipBrd, Graphics, Forms,
  Controls, Buttons, StdCtrls, ExtCtrls, SysUtils,
  OvcConst, OvcData, OvcEF, OvcHelp, {OvcRLbl,} OvcNbk, OvcBase;

type
  TOvcTabListbox = class(TListbox)
  protected
    procedure CreateParams(var Params: TCreateParams);
      override;
  end;

type
  TOvcfrmTransfer = class(TForm)
    NB: TOvcNotebook;
    lbTemp: TListBox;
    memoTransfer: TMemo;
    memoInitialize: TMemo;
    memoSample: TMemo;
    btnClearAll: TButton;
    btnSelectAll: TButton;
    btnGenerate: TBitBtn;
    btnCopyToClipboard: TBitBtn;
    btnClose: TBitBtn;
    btnHelp: TBitBtn;
    cbInitialize: TCheckBox;
    cbTransfer: TCheckBox;
    cbSample: TCheckBox;
    gbGenerate: TGroupBox;
    bvlLarge: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OvcController1: TOvcController;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure SelectionChange(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnGenerateClick(Sender: TObject);
    procedure btnCopyToClipboardClick(Sender: TObject);
    procedure NBPageChanged(Sender: TObject; Index: Integer);
  public
    { Public declarations }
    lbAllComponents : TOvcTabListBox;
    ComponentForm   : TComponent;
    ComponentList   : TList;

    procedure SetButtonStatus;
    procedure SetInstructionText;
  end;

implementation

{$R *.DFM}


type
  TLocalEF = class(TOvcBaseEntryField);


{*** TOvcTabListbox ***}

procedure TOvcTabListbox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do Style := Style or LBS_USETABSTOPS;
end;


{*** TfrmTransfer ***}

procedure TOvcfrmTransfer.SetButtonStatus;
begin
  btnGenerate.Enabled :=
    (lbAllComponents.SelCount > 0) and
    (cbInitialize.Checked or cbTransfer.Checked or cbSample.Checked);
end;

procedure TOvcfrmTransfer.SetInstructionText;
begin
  Label2.Caption := 'Copy the method declaration to the form''s ' +
                    '"private" section in the header and place the ' +
                    'method definition in the source unit for the form.';
  Label1.Caption := 'Copy this declaration to the form''s header, ' +
                    'prior to the form class'' declaration.';
end;

procedure TOvcfrmTransfer.FormCreate(Sender: TObject);
begin
  lbAllComponents := TOvcTabListbox.Create(lbTemp.Owner);
  with lbAllComponents do begin
    Top         := lbTemp.Top;
    Left        := lbTemp.Left;
    Height      := lbTemp.Height;
    Width       := lbTemp.Width;
    MultiSelect := True;
    Sorted      := False;
    Font        := lbTemp.Font;
    TabStop     := True;
    OnClick     := lbTemp.OnClick;
    Parent      := lbTemp.Parent;
    TabOrder    := 0;
  end;
  lbTemp.Free;
  lbTemp := nil;

  SetButtonStatus;
  {$IFDEF CBuilder}
  SetInstructionText;
  {$ENDIF}
end;

procedure TOvcfrmTransfer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  lbAllComponents.Free;
  lbAllComponents := nil;
end;

procedure TOvcfrmTransfer.btnSelectAllClick(Sender: TObject);
var
  I : Integer;
begin
  with lbAllComponents do
    for I := 0 to Items.Count-1 do
      Selected[I] := True;
  SetButtonStatus;
end;

procedure TOvcfrmTransfer.btnClearAllClick(Sender: TObject);
var
  I : Integer;
begin
  with lbAllComponents do
    for I := 0 to Items.Count-1 do
      Selected[I] := False;
  SetButtonStatus;
end;

procedure TOvcfrmTransfer.SelectionChange(Sender: TObject);
begin
  SetButtonStatus;
end;

procedure TOvcfrmTransfer.btnGenerateClick(Sender: TObject);
var
  I    : Integer;
  J    : Integer;
  C    : TComponent;
  Len  : Byte;
  S    : string;
  NL   : TStringList;

  function Spaces(Len : Integer) : string;
  begin
    Result := '';
    if Len > 255 then
      Exit;

    while Length(Result) < Len do
      Result := Result + ' ';
  end;

begin
  {get length of longest name}
  Len := 0;
  for I := 0 to ComponentList.Count-1 do begin
    if not lbAllComponents.Selected[I] then
      Continue;
    C := TComponent(ComponentList.Items[I]);
    J := Length(C.Name);

    {adjust length for tag added to end of field name}
    {(e.g., the "Text" added to string fields)}
    if (C is TEdit) or (C is TLabel) or
       (C is TPanel) {or (C is TOvcRotatedLabel)} then
      Inc(J, 4)
    else if (C is TMemo) or (C is TOvcBaseEntryField) then
      Inc(J, 5)
    else if (C is TCheckBox) or (C is TRadioButton) then
      Inc(J, 7)
    else if (C is TListBox) or (C is TComboBox) then
      Inc(J, 14);

    if  J > Len then
      Len := J;
  end;

  if cbTransfer.Checked then with memoTransfer do begin
    {$IFDEF CBuilder}
    memoTransfer.Clear;

    {emit record definition}
    Lines.Add(Format('// transfer buffer for the %s form', [ComponentForm.Name]));
    Lines.Add(Format('#pragma pack(push, 1)', [ComponentForm.Name]));
    Lines.Add(Format('struct T%sTransferRec {', [ComponentForm.Name]));

    {emit data declaration for each component}
    for I := 0 to ComponentList.Count-1 do begin
      if not lbAllComponents.Selected[I] then
        Continue;
      C := TComponent(ComponentList.Items[I]);

      if (C is TEdit) then begin
        if TEdit(C).MaxLength = 0 then
          Lines.Add(Format('  char %sText[256];',
            [C.Name]))
        else
          Lines.Add(Format('  char %sText[%d];',
           [C.Name, TEdit(C).MaxLength]));
      end else if (C is TLabel) or
         (C is TPanel) or (C is TOvcRotatedLabel) then begin
        Lines.Add(Format('  char %sText[256];',
         [C.Name]));
      end else if (C is TCheckBox) or (C is TRadioButton) then begin
        Lines.Add(Format('  bool %sChecked;',
         [C.Name]));
      end else if (C is TMemo) then begin
        Lines.Add(Format('  TStringList* %sLines;',
         [C.Name]));
      end else if (C is TListBox) then begin
        Lines.Add(Format('  TListBoxTransfer %sXfer;',
         [C.Name]));
      end else if (C is TComboBox) then begin
        Lines.Add(Format('  TComboBoxTransfer %sXfer;',
         [C.Name]));
      end else if (C is TOvcBaseEntryField) then begin
        case TLocalEF(C).efDataType mod fcpDivisor of
          fsubString   :
            S := Format('  char %sValue[%d];', [C.Name, TLocalEF(C).DataSize]);
          fsubChar     : S := 'char';
          fsubBoolean  : S := 'bool';
          fsubYesNo    : S := 'bool';
          fsubLongInt  : S := 'int';
          fsubWord     : S := 'Word';
          fsubInteger  : S := 'int';
          fsubByte     : S := 'Byte';
          fsubShortInt : S := 'int';
          fsubReal     : S := 'double';
          fsubExtended : S := 'Extended';
          fsubDouble   : S := 'double';
          fsubSingle   : S := 'float';
          fsubComp     : S := 'Comp';
          fsubDate     : S := 'TStDate';
          fsubTime     : S := 'TStTime';
        else
          S := '';
        end;
        if (TLocalEF(C).efDataType mod fcpDivisor) = fsubString then
          Lines.Add(S)
        else
          Lines.Add(Format('  %s %sValue;',
            [S, C.Name]));
      end;
    end;
    {end of record structure}
    Lines.Add('};');
    Lines.Add('#pragma pack(pop)');
    {$ELSE}
    memoTransfer.Clear;

    {emit record definition}
    Lines.Add(       'type');
    Lines.Add(Format('  {transfer buffer for the %s form}', [ComponentForm.Name]));
    Lines.Add(Format('  T%sTransferRec = packed record', [ComponentForm.Name]));

    {emit data declaration for each component}
    for I := 0 to ComponentList.Count-1 do begin
      if not lbAllComponents.Selected[I] then
        Continue;
      C := TComponent(ComponentList.Items[I]);
      J := Length(C.Name);

      if (C is TEdit) then begin
        if TEdit(C).MaxLength = 0 then
          Lines.Add(Format('    %sText%s : string[255];',
           [C.Name, Spaces(Len-J-4)]))
        else
          Lines.Add(Format('    %sText%s : string[%d];',
           [C.Name, Spaces(Len-J-4), TEdit(C).MaxLength]));
      end else if (C is TLabel) or
         (C is TPanel) {or (C is TOvcRotatedLabel)} then begin
        Lines.Add(Format('    %sText%s : string[255];',
         [C.Name, Spaces(Len-J-4)]));
      end else if (C is TCheckBox) or (C is TRadioButton) then begin
        Lines.Add(Format('    %sChecked%s : Boolean;',
         [C.Name, Spaces(Len-J-7)]));
      end else if (C is TMemo) then begin
        Lines.Add(Format('    %sLines%s : TStrings;',
         [C.Name, Spaces(Len-J-5)]));
      end else if (C is TListBox) then begin
        Lines.Add(Format('    %sXfer%s : TListBoxTransfer;',
         [C.Name, Spaces(Len-J-4)]));
      end else if (C is TComboBox) then begin
        Lines.Add(Format('    %sXfer%s : TComboBoxTransfer;',
         [C.Name, Spaces(Len-J-4)]));
      end else if (C is TOvcBaseEntryField) then begin
        case TLocalEF(C).efDataType mod fcpDivisor of
          fsubString   :
            S := Format('string[%d];', [TLocalEF(C).DataSize-1]);
          {$IFDEF Win32}
          fsubChar     : S := 'AnsiChar;';
          {$ELSE}
          fsubChar     : S := 'Char;';
          {$ENDIF}
          fsubBoolean  : S := 'Boolean;';
          fsubYesNo    : S := 'Boolean;';
          fsubLongInt  : S := 'LongInt;';
          fsubWord     : S := 'Word;';
          {$IFDEF Win32}
          fsubInteger  : S := 'SmallInt;';
          {$ELSE}
          fsubInteger  : S := 'Integer;';
          {$ENDIF}
          fsubByte     : S := 'Byte;';
          fsubShortInt : S := 'ShortInt;';
          fsubReal     : S := 'Real;';
          fsubExtended : S := 'Extended;';
          fsubDouble   : S := 'Double;';
          fsubSingle   : S := 'Single;';
          fsubComp     : S := 'Comp;';
          fsubDate     : S := 'TWdDate;';
          fsubTime     : S := 'TWdTime;';
        else
          S := '';
        end;
        Lines.Add(Format('    %sValue%s : %s',
         [C.Name, Spaces(Len-J-5), S]));
      end;
    end;
    {end of record structure}
    Lines.Add('  end;');
    {$ENDIF}
  end;

  if cbInitialize.Checked then with memoInitialize do begin
    memoInitialize.Clear;

    {$IFDEF CBuilder}
    {create stub for initialization method}
    Lines.Add(       '  // declaration - place in header');
    Lines.Add(Format('  void Init%sTransfer(T%0:sTransferRec& Data);', [ComponentForm.Name]));
    Lines.Add(       ' ');

    {create initialization method}
    Lines.Add(       '// initialize transfer buffer');
    Lines.Add(Format('void T%s::Init%0:sTransfer(T%0:sTransferRec& Data)',
     [ComponentForm.Name]));
    Lines.Add(       '{');

    {initialize each field in the record}
    for I := 0 to ComponentList.Count-1 do begin
      if not lbAllComponents.Selected[I] then
        Continue;
      C := TComponent(ComponentList.Items[I]);
      J := Length(C.Name);

      if (C is TEdit) or (C is TLabel) or
         (C is TPanel) or (C is TOvcRotatedLabel) then begin
        Lines.Add(Format('  strcpy(Data.%sText, "");',
         [C.Name]));
      end else if (C is TCheckBox) or (C is TRadioButton) then begin
        Lines.Add(Format('  Data.%sChecked%s = false;',
         [C.Name, Spaces(Len-J-7)]));
      end else if (C is TMemo) then begin
        Lines.Add(Format('  Data.%sLines%s = new TStringList;',
         [C.Name, Spaces(Len-J-5)]));
      end else if (C is TListbox) then begin
        Lines.Add(Format('  Data.%sXfer.Items%s = new TStringList;',
         [C.Name, Spaces(Len-J-10)]));
        Lines.Add(Format('  Data.%sXfer.ItemIndex%s = 0;',
         [C.Name, Spaces(Len-J-14)]));
      end else if (C is TComboBox) then begin
        Lines.Add(Format('  Data.%sXfer.Items%s = new TStringList;',
         [C.Name, Spaces(Len-J-10)]));
        Lines.Add(Format('  Data.%sXfer.ItemIndex%s = 0;',
         [C.Name, Spaces(Len-J-14)]));
        Lines.Add(Format('  Data.%sXfer.Text%s = "";',
         [C.Name, Spaces(Len-J-9)]));
      end else if (C is TOvcBaseEntryField) then begin
        case TLocalEF(C).efDataType mod fcpDivisor of
          fsubString   :
            S := Format('  strcpy(Data.%sValue, "");', [C.Name]);
          fsubChar     : S := ''' '';';
          fsubBoolean,
          fsubYesNo    : S := 'false;';
          fsubLongInt,
          fsubWord,
          fsubInteger,
          fsubByte,
          fsubShortInt,
          fsubReal,
          fsubExtended,
          fsubDouble,
          fsubSingle,
          fsubComp     : S := '0;';
          fsubDate     : S := 'Stdate::CurrentDate(); // in Stdate unit';
          fsubTime     : S := 'Stdate::CurrentTime(); // in Stdate unit';
        else
          S := '';
        end;
        if (TLocalEF(C).efDataType mod fcpDivisor) = fsubString then
          Lines.Add(S)
        else
          Lines.Add(Format('  Data.%sValue%s = %s',
         [C.Name, Spaces(Len-J-5), S]));
      end;
    end;

    {add end of with and method}
    Lines.Add('}');
    {$ELSE}
    {create stub for initialization method}
    Lines.Add(Format('procedure Init%sTransfer(var Data : T%0:sTransferRec);', [ComponentForm.Name]));
    Lines.Add(       '  {-initialize transfer buffer}');
    Lines.Add(       ' ');

    {create initialization method}
    Lines.Add(Format('procedure T%s.Init%0:sTransfer(var Data : T%0:sTransferRec);',
     [ComponentForm.Name]));
    Lines.Add(       '  {-initialize transfer buffer}');
    Lines.Add(       'begin');
    Lines.Add(       '  with Data do begin');

    {initialize each field in the record}
    for I := 0 to ComponentList.Count-1 do begin
      if not lbAllComponents.Selected[I] then
        Continue;
      C := TComponent(ComponentList.Items[I]);
      J := Length(C.Name);

      if (C is TEdit) or (C is TLabel) or
         (C is TPanel) {or (C is TOvcRotatedLabel)} then begin
        Lines.Add(Format('    %sText%s := '''';',
         [C.Name, Spaces(Len-J-4)]));
      end else if (C is TCheckBox) or (C is TRadioButton) then begin
        Lines.Add(Format('    %sChecked%s := False;',
         [C.Name, Spaces(Len-J-7)]));
      end else if (C is TMemo) then begin
        Lines.Add(Format('    %sLines%s := TStringList.Create;',
         [C.Name, Spaces(Len-J-5)]));
      end else if (C is TListbox) then begin
        Lines.Add(Format('    %sXfer.Items%s := TStringList.Create;',
         [C.Name, Spaces(Len-J-10)]));
        Lines.Add(Format('    %sXfer.ItemIndex%s := 0;',
         [C.Name, Spaces(Len-J-14)]));
      end else if (C is TComboBox) then begin
        Lines.Add(Format('    %sXfer.Items%s := TStringList.Create;',
         [C.Name, Spaces(Len-J-10)]));
        Lines.Add(Format('    %sXfer.ItemIndex%s := 0;',
         [C.Name, Spaces(Len-J-14)]));
        Lines.Add(Format('    %sXfer.Text%s := '''';',
         [C.Name, Spaces(Len-J-9)]));
      end else if (C is TOvcBaseEntryField) then begin
        case TLocalEF(C).efDataType mod fcpDivisor of
          fsubString   : S := ''''';';
          fsubChar     : S := ''' '';';
          fsubBoolean,
          fsubYesNo    : S := 'False;';
          fsubLongInt,
          fsubWord,
          fsubInteger,
          fsubByte,
          fsubShortInt,
          fsubReal,
          fsubExtended,
          fsubDouble,
          fsubSingle,
          fsubComp     : S := '0;';
          fsubDate     : S := 'STDate.CurrentDate; {in stdate unit}';
          fsubTime     : S := 'STDate.CurrentTime; {in stdate unit}';
        else
          S := '';
        end;
        Lines.Add(Format('    %sValue%s := %s',
         [C.Name, Spaces(Len-J-5), S]));
      end;
    end;

    {add end of with and method}
    Lines.Add('  end; {with}');
    Lines.Add('end;');
    {$ENDIF}
  end;

  if cbSample.Checked then with memoSample do begin
    memoSample.Clear;

    {$IFDEF CBuilder}
    Lines.Add(       '// transfer record declaration');
    Lines.Add(Format('T%sTransferRec TR;', [ComponentForm.Name]));
    Lines.Add(       #13);
    Lines.Add(       '  // call to initialize the transfer record');
    Lines.Add(Format('  Init%sTransfer(TR);', [ComponentForm.Name]));

    NL := TStringList.Create;
    try
      {build list of component names}
      for I := 0 to ComponentList.Count-1 do
        if lbAllComponents.Selected[I] then
          NL.Add(TComponent(ComponentList.Items[I]).Name);

      Lines.Add(#13);
      Lines.Add('  // call to transfer data to the form');
      S :=      '  OvcTransfer1->TransferToFormZ(OPENARRAY(TComponent*, (';

      if NL.Count = 1 then
        Lines.Add(S + NL[0] + ')), &TR);')
      else begin
        Lines.Add(S);
        for I := 0 to NL.Count-2 do
          Lines.Add('    ' + NL[I] + ',');

        {add the last item}
        Lines.Add('    ' + NL[NL.Count-1] + ')), &TR);');
      end;

      Lines.Add(#13);
      Lines.Add('  // call to transfer data from the form');
      S :=      '  OvcTransfer1->TransferFromFormZ(OPENARRAY(TComponent*, (';

      if NL.Count = 1 then
        Lines.Add(S + NL[0] + ')), &TR);')
      else begin
        Lines.Add(S);
        for I := 0 to NL.Count-2 do
          Lines.Add('    ' + NL[I] + ',');

        {add the last item}
        Lines.Add('    ' + NL[NL.Count-1] + ')), &TR);');
      end;

    finally
      NL.Free;
    end;
    {$ELSE}
    Lines.Add(       'var');
    Lines.Add(       '{transfer record declaration}');
    Lines.Add(Format('  TR : T%sTransferRec;', [ComponentForm.Name]));
    Lines.Add(       #13);
    Lines.Add(       '{call to initialize the transfer record}');
    Lines.Add(Format('Init%sTransfer(TR);', [ComponentForm.Name]));

    NL := TStringList.Create;
    try
      {build list of component names}
      for I := 0 to ComponentList.Count-1 do
        if lbAllComponents.Selected[I] then
          NL.Add(TComponent(ComponentList.Items[I]).Name);

      Lines.Add(#13);
      Lines.Add('{call to transfer data to the form}');
      S :=      'OvcTransfer1.TransferToForm([';
      Len := Length(S);

      if NL.Count = 1 then
        Lines.Add(S + NL[0] + '], TR);')
      else begin
        for I := 0 to NL.Count-2 do begin
          if I = 0 then
            Lines.Add(S + NL[0] + ',')
          else
            Lines.Add(Spaces(Len) + NL[I] + ',');
        end;

        {add the last item}
        Lines.Add(Spaces(Len) + NL[NL.Count-1] + '], TR);');
      end;

      Lines.Add(#13);
      Lines.Add('{call to transfer data from the form}');
      S :=      'OvcTransfer1.TransferFromForm([';
      Len := Length(S);

      if NL.Count = 1 then
        Lines.Add(S + NL[0] + '], TR);')
      else begin
        for I := 0 to NL.Count-2 do begin
          if I = 0 then
            Lines.Add(S + NL[0] + ',')
          else
            Lines.Add(Spaces(Len) + NL[I] + ',');
        end;

        {add the last item}
        Lines.Add(Spaces(Len) + NL[NL.Count-1] + '], TR);');
      end;

    finally
      NL.Free;
    end;
    {$ENDIF}
  end;

  if cbTransfer.Checked then
    NB.PagesEnabled[1] := True;
  if cbInitialize.Checked then
    NB.PagesEnabled[2] := True;
  if cbSample.Checked then
    NB.PagesEnabled[3] := True;

  {enable button for clipboard copy}
  btnCopyToClipboard.Enabled := True;
end;

procedure TOvcfrmTransfer.btnCopyToClipboardClick(Sender: TObject);
var
  I : Integer;
  M : TStringList;
  P : Integer;
begin
  {get active notebook page index}
  P := NB.PageIndex;

  M := TStringList.Create;
  try
    {copy transfer record to string list}
    if ((P = 0) or (P = 1)) and (memoTransfer.Lines.Count > 0) then begin
      {$IFDEF CBuilder}
      M.Add(#13#10'//  >>> Transfer record <<<'#13#10);
      {$ELSE}
      M.Add(#13#10'>>> Transfer record <<<'#13#10);
      {$ENDIF}
      for I := 0 to memoTransfer.Lines.Count-1 do
        M.Add(memoTransfer.Lines[I]);
    end;

    {copy init code to the string list}
    if ((P = 0) or (P = 2)) and (memoInitialize.Lines.Count > 0) then begin
      {$IFDEF CBuilder}
      M.Add(#13#10'// >>> Initialization header and method <<<'#13#10);
      {$ELSE}
      M.Add(#13#10'>>> Initialization header and method <<<'#13#10);
      {$ENDIF}
      for I := 0 to memoInitialize.Lines.Count-1 do
        M.Add(memoInitialize.Lines[I]);
    end;

    {copy sample transfer calls to string list}
    if ((P = 0) or (P = 3)) and (memoSample.Lines.Count > 0) then begin
      {$IFDEF CBuilder}
      M.Add(#13#10'// >>> Sample transfer calls <<<'#13#10);
      {$ELSE}
      M.Add(#13#10'>>> Sample transfer calls <<<'#13#10);
      {$ENDIF}
      for I := 0 to memoSample.Lines.Count-1 do
        M.Add(memoSample.Lines[I]);
    end;

    {copy string list to the clipboard}
    if M.Count > 0 then
    {$IFDEF Win32}
      Clipboard.SetTextBuf(PAnsiChar(M.Text));
    {$ELSE}
      Clipboard.SetTextBuf(M.GetText);
    {$ENDIF}
  finally
    M.Free;
  end;
end;

procedure TOvcfrmTransfer.NBPageChanged(Sender: TObject; Index: Integer);
begin
  btnCopyToClipboard.Caption := NB.PageHint;
end;

procedure TOvcfrmTransfer.btnHelpClick(Sender: TObject);
begin
  ShowHelpContext(hcTransfer);
end;

end.