//USEUNIT Dialogs
//USEUNIT Menus
//USEUNIT dcedit
//USEUNIT DCGen
//USEUNIT ComCtrls
//USEUNIT StdCtrls
//USEUNIT ExtCtrls
//USEUNIT reabout

var  FFileName = 'Untitled';
var  FUpdating = false;
var  RulerAdj = 4/3;
var  GutterWid = 6;
var  FDragOfs = 0;
var  FDragging = false;
// ------------------------------------------------------------------

function SetFileName(FileName)
{
  FFileName = FileName;
  Caption = ExtractFileName(FileName);
}

// ------------------------------------------------------------------

function  SetModified(Value)
{
var
  stext='';
  if (Value)
    stext = 'Modified';
  StatusBar.Panels.Items(1).Text = stext;
}

// ------------------------------------------------------------------

function PerformFileOpen(AFileName)
{
  Editor.Lines.LoadFromFile(AFileName);
  SetFileName(AFileName);
  Editor.SetFocus;
  Editor.Modified = false;
  SetModified(false);
}

// ------------------------------------------------------------------

function CheckFileSave()
{
  if (!Editor.Modified)
    return true;
  res = MessageDlg("Save changes to " + FFileName + "?", mtConfirmation, mbYesNoCancel, 0)
  if (res == mrYes)
    FileSave(MainForm);
  if (res == mrCancel)
    return false
  else
    return true;
}
// ------------------------------------------------------------------

function CurrText()
{
  return Editor.SelAttributes;
}

// ------------------------------------------------------------------

function UpdateCursorPos()
{
var CharPosX;
var CharPosY;

  CharPosY = Editor.Perform(EM_LINEFROMCHAR, Editor.SelStart, 0);
  CharPosX = (Editor.SelStart - Editor.Perform(EM_LINEINDEX, CharPosY, 0));
  CharPosY++;
  CharPosX++;
  StatusBar.Panels(0).Text = "Line: "+  CharPosY + " Col: "+ CharPosX;
  CopyButton.Enabled = (Editor.SelLength > 0);
  EditCopyItem.Enabled = CopyButton.Enabled;
  CutButton.Enabled = CopyButton.Enabled;
  EditCutItem.Enabled = CopyButton.Enabled;
}

// ------------------------------------------------------------------

function SetupRuler()
{
var  i;
var  S="";
var  T = chr(9) +  "|";
  for (i=1;i<100;i++)
    S = S + T;
  Ruler.Caption = S;
}


// ------------------------------------------------------------------

function FileSave(Sender)
{
  if (FFileName == 'Untitled')
    FileSaveAs(MainForm);
  else
  {
    Editor.Lines.SaveToFile(FFileName);
    Editor.Modified = false;
    SetModified(false);
  }
}

// ------------------------------------------------------------------

function FileSaveAs(Sender)
{
  if (SaveDialog.Execute)
  {
    if ( FileExists(SaveDialog.FileName) )
     if ( MessageDlg( "OK to overwrite "+ SaveDialog.FileName,  mtConfirmation, mbYesNoCancel, 0) != mrYes )
      return;
    Editor.Lines.SaveToFile(SaveDialog.FileName);
    SetFileName(SaveDialog.FileName);
    Editor.Modified = false;
    SetModified(false);
  }
}


// ------------------------------------------------------------------

function FileOpen(Sender)
{
  if (CheckFileSave())
    if (OpenDialog.Execute)
    {
      PerformFileOpen(OpenDialog.FileName);
      Editor.ReadOnly = (ofReadOnly & OpenDialog.Options);
    }
}

// ------------------------------------------------------------------

function FileNew(Sender)
{
  if (CheckFileSave())
  {
    SetFileName('Untitled');
    Editor.Lines.Text ='';
    Editor.Modified = false;
    SetModified(false);
  }
}

// ------------------------------------------------------------------

function FilePrint(Sender)
{
  if (PrintDialog.Execute)
    Editor.Print(FFileName);
}


// ------------------------------------------------------------------

function FileExit(Sender)
{
  MainForm.Close;
}


// ------------------------------------------------------------------

function EditUndo(Sender)
{
  if (Editor.HandleAllocated)
    Editor.Perform(EM_UNDO, 0, 0);
}

// ------------------------------------------------------------------

function EditCut(Sender)
{
  Editor.CutToClipboard;
}

// ------------------------------------------------------------------

function EditCopy(Sender)
{
  Editor.CopyToClipboard;
}

// ------------------------------------------------------------------

function EditPaste(Sender)
{
  Editor.PasteFromClipboard;
}

// ------------------------------------------------------------------

function SelectFont(Sender)
{
  FontDialog1.Font.Assign(Editor.SelAttributes);
  if (FontDialog1.Execute)
    CurrText().Assign(FontDialog1.Font);
  Editor.SetFocus;
}

// ------------------------------------------------------------------

function FontNameChange(Sender)
{
  if (!FUpdating)
    CurrText().Name = FontName.Text;
}

// ------------------------------------------------------------------

function FontSizeExit(Sender)
{
  if (!FUpdating)
    CurrText().Size = StrToInt(FontSize.Text);
}

// ------------------------------------------------------------------

function BoldButtonClick(Sender)
{
  if (!FUpdating)
  {
    if (BoldButton.Down)
      CurrText().Style |= mkset(fsBold);
    else
      CurrText().Style &=  ~mkset(fsBold);
  }
}

// ------------------------------------------------------------------

function ItalicButtonClick(Sender)
{
  if (!FUpdating)
  {
    if (ItalicButton.Down)
      CurrText().Style |= mkset(fsItalic);
    else
      CurrText().Style &= ~mkset(fsItalic);
  }
}

// ------------------------------------------------------------------

function UnderlineButtonClick(Sender)
{
  if (!FUpdating)
  {
    if (UnderlineButton.Down)
      CurrText().Style |= mkset(fsUnderline);
    else
      CurrText().Style &= ~mkset(fsUnderline);
  }
}

// ------------------------------------------------------------------

function AlignClick(Sender)
{
  if (!FUpdating)
    Editor.Paragraph.Alignment = Sender.Tag;
}

// ------------------------------------------------------------------

function BulletsButtonClick(Sender)
{
  if (!FUpdating)
    Editor.Paragraph.Numbering = BulletsButton.Down ? nsBullet :nsNone ;
}

// ------------------------------------------------------------------

function SelectionChange(Sender)
{
  FUpdating = true;
  FirstInd.Left = (Editor.Paragraph.FirstIndent*RulerAdj) - 4 + GutterWid;
  LeftInd.Left = ((Editor.Paragraph.LeftIndent+Editor.Paragraph.FirstIndent)*RulerAdj)-4+GutterWid;
  RightInd.Left = Ruler.ClientWidth-6-((Editor.Paragraph.RightIndent+GutterWid)*RulerAdj);
  BoldButton.Down = inset(fsBold,Editor.SelAttributes.Style);
  ItalicButton.Down = inset(fsItalic, Editor.SelAttributes.Style);
  UnderlineButton.Down = inset(fsUnderline , Editor.SelAttributes.Style);
  BulletsButton.Down = (Editor.Paragraph.Numbering == nsBullet);
  FontSize.Text = Editor.SelAttributes.Size;
  FontName.Text = Editor.SelAttributes.Name;
  switch (Editor.Paragraph.Alignment)
  {
    case 0: LeftAlign.Down = true; break;
    case 1: RightAlign.Down = true;break;
    case 2: CenterAlign.Down = true;break;
  }
  UpdateCursorPos();
  FUpdating = false;
}

// ------------------------------------------------------------------

function EditorChange(Sender)
{
  SetModified(Editor.Modified);
}

// ------------------------------------------------------------------


function FormShow(Sender)
{
  OpenDialog.InitialDir = ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir = OpenDialog.InitialDir;
  SetFileName('Untitled');
  GetFontNames(FontName.PopupWindow.Items);
  SetupRuler();
  SelectionChange(MainForm);
  UpdateCursorPos();
  Editor.SetFocus;
}

// ------------------------------------------------------------------

function HelpContents(Sender)
{
  Application.HelpCommand(HELP_CONTENTS, 0);
}

// ------------------------------------------------------------------

function HelpSearch(Sender)
{
  Application.HelpCommand(HELP_PARTIALKEY, 0);
}

// ------------------------------------------------------------------

function HelpHowToUse(Sender)
{
  Application.HelpCommand(HELP_HELPONHELP, 0);
}

// ------------------------------------------------------------------

function HelpAbout(Sender)
{
 AboutBox.Showmodal;
}

// ------------------------------------------------------------------

function RulerResize(Sender)
{
  RulerLine.Width = Ruler.ClientWidth - (RulerLine.Left*2);
}

// ------------------------------------------------------------------

function FormCloseQuery(Sender, CanClose)
{
  CheckFileSave();
}

// ------------------------------------------------------------------

function RightIndMouseDown(Sender, Button, Shift, X, Y)
{
  FDragOfs = Sender.Width / 2;
  Sender.Left = Sender.Left+X-FDragOfs;
  FDragging = true;
}

// ------------------------------------------------------------------

function RightIndMouseMove(Sender, Shift, X, Y)
{
  if (FDragging)
    Sender.Left =  Sender.Left+X-FDragOfs;
}

// ------------------------------------------------------------------

function RightIndMouseUp(Sender, Button, Shift, X, Y)
{
  FDragging = false;
  Editor.Paragraph.RightIndent = (Ruler.ClientWidth-RightInd.Left+FDragOfs-2) / RulerAdj-2*GutterWid;
  SelectionChange(Sender);
}

// ------------------------------------------------------------------

function LeftIndMouseUp(Sender, Button, Shift, X, Y)
{
  FDragging = false;
  Editor.Paragraph.LeftIndent = (LeftInd.Left+FDragOfs-GutterWid) / RulerAdj - Editor.Paragraph.FirstIndent;
  SelectionChange(Sender);
}

// ------------------------------------------------------------------

function FirstIndMouseUp(Sender, Button, Shift, X, Y)
{
  FDragging = false;
  Editor.Paragraph.FirstIndent = (FirstInd.Left+FDragOfs-GutterWid) / RulerAdj;
  LeftIndMouseUp(Sender, Button, Shift, X, Y);
}


function FontSizeKeyPress(Sender, Key)
{
  if (Key == chr(13))
    FontSizeExit(Sender);

}