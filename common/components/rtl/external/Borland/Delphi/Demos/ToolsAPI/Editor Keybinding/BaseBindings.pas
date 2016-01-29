unit BaseBindings;

interface

uses SysUtils, Classes, ToolsAPI;

const
  kfImplicits = kfImplicitShift or kfImplicitModifier or kfImplicitKeypad;

type
  TBaseBindings = class(TNotifierObject, IUnknown, IOTANotifier)
  protected
    { Utility functions }
    function MarkWord(const Context: IOTAKeyContext): IOTAEditBlock;
    procedure SlideBlock(const Context: IOTAKeyContext; Backward: Boolean);
    { Default binding implementations }
    procedure AddWatchAtCursor(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure AutoCodeInsight(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure BrowseSymbolAtCursor(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure BlockSave(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure ClassNavigate(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure ClassComplete(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure ClipClear(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure ClipCopy(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure ClipCut(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure ClipPaste(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure CodeTemplate(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure CodeCompletion(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure DebugInspect(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure GotoLine(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure HelpKeyword(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure IncrementalSearch(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure InsertCompilerOptions(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure InsertNewGUID(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure NullCmd(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure OpenFileAtCursor(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure OpenLine(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure Print(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure SetBlockStyle(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure SearchAgain(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure SearchFind(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure SearchReplace(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure SwapCPPHeader(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure ViewExplorer(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
  end;

resourcestring
  sNoBlockMarked = 'No block marked';  

implementation

{ TBaseBindings }

procedure TBaseBindings.AddWatchAtCursor(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).AddWatchAtCursor;
  BindingResult := krHandled;
end;

procedure TBaseBindings.AutoCodeInsight(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EA: IOTAEditActions;
  AChar: Char;
begin
  EP := Context.EditBuffer.EditPosition;
  EA := Context.EditBuffer.TopView as IOTAEditActions;
  AChar := Char(Byte(Context.Context));
  EP.InsertCharacter(AChar);
  case AChar of
    '.', '>': EA.CodeCompletion(csCodeList);
    '(': EA.CodeCompletion(csParamList);
  end;
  BindingResult := krHandled;  
end;

procedure TBaseBindings.BlockSave(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.SaveToFile('');
  BindingResult := krHandled;
end;

procedure TBaseBindings.BrowseSymbolAtCursor(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).BrowseSymbolAtCursor;
  BindingResult := krHandled;
end;

procedure TBaseBindings.ClassComplete(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).ClassComplete;
  BindingResult := krHandled;
end;

procedure TBaseBindings.ClassNavigate(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).ClassNavigate(0);
  BindingResult := krHandled;
end;

procedure TBaseBindings.ClipClear(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.Delete;
  BindingResult := krHandled;
end;

procedure TBaseBindings.ClipCopy(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.Copy(False);
  BindingResult := krHandled;
end;

procedure TBaseBindings.ClipCut(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.Cut(False);
  BindingResult := krHandled;
end;

procedure TBaseBindings.ClipPaste(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Paste;
  BindingResult := krHandled;
end;

procedure TBaseBindings.CodeCompletion(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).CodeCompletion(Byte(Context.Context));
  BindingResult := krHandled;
end;

procedure TBaseBindings.CodeTemplate(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).CodeTemplate;
  BindingResult := krHandled;
end;

procedure TBaseBindings.DebugInspect(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).InspectAtCursor;
  BindingResult := krHandled;
end;

procedure TBaseBindings.GotoLine(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.GotoLine(0);
  BindingResult := krHandled;
end;

procedure TBaseBindings.HelpKeyword(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).HelpKeyword;
  BindingResult := krHandled;
end;

procedure TBaseBindings.IncrementalSearch(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).IncrementalSearch;
  BindingResult := krHandled;
end;

procedure TBaseBindings.InsertCompilerOptions(const Context: IOTAKeyContext; KeyCode: TShortcut;
  var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).InsertCompilerOptions;
  BindingResult := krHandled;
end;

procedure TBaseBindings.InsertNewGUID(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).InsertNewGUID;
  BindingResult := krHandled;
end;

function TBaseBindings.MarkWord(const Context: IOTAKeyContext): IOTAEditBlock;
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
begin
  EP := Context.EditBuffer.EditPosition;
  EB := Context.EditBuffer.EditBlock;
  if EP.IsWordCharacter then
    EP.MoveCursor(mmSkipLeft or mmSkipWord);
  if EP.IsWhiteSpace then
    EP.MoveCursor(mmSkipRight or mmSkipWhite);
  if not EP.IsWhiteSpace then
  begin
    if not EP.IsWordCharacter then
      EP.MoveCursor(mmSkipRight or mmSkipNonWord);
    if EP.IsWordCharacter then
    begin
      EB.Reset;
      EB.Style := btNonInclusive;
      EB.BeginBlock;
      EP.MoveCursor(mmSkipRight or mmSkipWord);
      EB.EndBlock;
    end;
  end;
  Result := EB;
end;

procedure TBaseBindings.NullCmd(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  BindingResult := krHandled;
end;

procedure TBaseBindings.OpenFileAtCursor(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).OpenFileAtCursor;
  BindingResult := krHandled;
end;

procedure TBaseBindings.OpenLine(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
begin
  EP := Context.EditBuffer.EditPosition;
  EP.Save;
  try
    EP.InsertCharacter(#10);
  finally
    EP.Restore;
  end;
  BindingResult := krHandled;
end;

procedure TBaseBindings.Print(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.Print;
  BindingResult := krHandled;
end;

procedure TBaseBindings.SearchAgain(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.RepeatLastSearchOrReplace;
  BindingResult := krHandled;
end;

procedure TBaseBindings.SearchFind(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Search;
  BindingResult := krHandled;
end;

procedure TBaseBindings.SearchReplace(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Replace;
  BindingResult := krHandled;
end;

procedure TBaseBindings.SetBlockStyle(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
var
  Style: TOTABlockType;
begin
  Style := TOTABlockType(Context.Context);
  Assert((Style >= btInclusive) and (Style < btUnknown), 'Invalid block style'); // do not localize
  Context.EditBuffer.EditBlock.Style := Style;
  BindingResult := krHandled;
end;

procedure TBaseBindings.SlideBlock(const Context: IOTAKeyContext;
  Backward: Boolean);
var
  EB: IOTAEditBlock;
  IndentAmount: Integer;
begin
  EB := Context.EditBuffer.EditBlock;
  if EB.Size <> 0 then
  begin
    IndentAmount := (Context.KeyboardServices.EditorServices as IOTAEditorServices60).EditOptions.BlockIndent;
    if Backward then
      IndentAmount := IndentAmount * -1;
    EB.Indent(IndentAmount);
  end else
    Context.EditBuffer.TopView.SetTempMsg(sNoBlockMarked);
end;

procedure TBaseBindings.SwapCPPHeader(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).SwapCPPHeader;
  BindingResult := krHandled;
end;

procedure TBaseBindings.ViewExplorer(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).ViewExplorer;
  BindingResult := krHandled;
end;

end.
