unit EmacsBaseBindings;

interface

uses SysUtils, Classes, ToolsAPI;

const
  kfImplicits = kfImplicitShift or kfImplicitModifier or kfImplicitKeypad;

type
  TEmacsBindings = class(TNotifierObject, IUnknown, IOTANotifier)
  protected
    { Utility functions }
    function MarkWord(const Context: IOTAKeyContext): IOTAEditBlock;
    procedure SlideBlock(const Context: IOTAKeyContext; Backward: Boolean);
    { Default binding implementations }
    procedure AddWatchAtCursor(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure RunToCursor(const Context: IOTAKeyContext; KeyCode: TShortcut;
      var BindingResult: TKeyBindingResult);
    procedure EvaluateModify(const Context: IOTAKeyContext; KeyCode: TShortcut;
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

{ TEmacsBindings }

procedure TEmacsBindings.AddWatchAtCursor(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).AddWatchAtCursor;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.RunToCursor(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).RunToCursor;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.EvaluateModify(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).EvaluateModify;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.AutoCodeInsight(const Context: IOTAKeyContext;
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

procedure TEmacsBindings.BlockSave(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.SaveToFile('');
  BindingResult := krHandled;
end;

procedure TEmacsBindings.BrowseSymbolAtCursor(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).BrowseSymbolAtCursor;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.ClassComplete(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).ClassComplete;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.ClassNavigate(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).ClassNavigate(0);
  BindingResult := krHandled;
end;

procedure TEmacsBindings.ClipClear(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.Delete;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.ClipCopy(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.Copy(False);
  BindingResult := krHandled;
end;

procedure TEmacsBindings.ClipCut(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.Cut(False);
  BindingResult := krHandled;
end;

procedure TEmacsBindings.ClipPaste(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Paste;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.CodeCompletion(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).CodeCompletion(Byte(Context.Context));
  BindingResult := krHandled;
end;

procedure TEmacsBindings.CodeTemplate(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).CodeTemplate;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.DebugInspect(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).InspectAtCursor;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.GotoLine(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.GotoLine(0);
  BindingResult := krHandled;
end;

procedure TEmacsBindings.HelpKeyword(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).HelpKeyword;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.IncrementalSearch(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  if Assigned(Context.Context) then
    Context.EditBuffer.EditPosition.SearchOptions.SetDirection(sdBackward)
  else
    Context.EditBuffer.EditPosition.SearchOptions.SetDirection(sdForward);
  (Context.EditBuffer.TopView as IOTAEditActions).IncrementalSearch;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.InsertCompilerOptions(const Context: IOTAKeyContext; KeyCode: TShortcut;
  var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).InsertCompilerOptions;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.InsertNewGUID(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).InsertNewGUID;
  BindingResult := krHandled;
end;


function TEmacsBindings.MarkWord(const Context: IOTAKeyContext): IOTAEditBlock;
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

procedure TEmacsBindings.NullCmd(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  BindingResult := krHandled;
end;

procedure TEmacsBindings.OpenFileAtCursor(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).OpenFileAtCursor;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.OpenLine(const Context: IOTAKeyContext;
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

procedure TEmacsBindings.Print(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.Print;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.SearchAgain(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.RepeatLastSearchOrReplace;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.SearchFind(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Search;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.SearchReplace(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Replace;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.SetBlockStyle(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
var
  Style: TOTABlockType;
begin
  Style := TOTABlockType(Context.Context);
  Assert((Style >= btInclusive) and (Style < btUnknown), 'Invalid block style'); // do not localize
  Context.EditBuffer.EditBlock.Style := Style;
  BindingResult := krHandled;
end;


procedure TEmacsBindings.SlideBlock(const Context: IOTAKeyContext;
  Backward: Boolean);
var
  EB: IOTAEditBlock;
  IndentAmount: Integer;
begin
  EB := Context.EditBuffer.EditBlock;
  if EB.Size <> 0 then
  begin
    IndentAmount :=
      (Context.KeyboardServices.EditorServices as IOTAEditorServices60).EditOptions.BlockIndent;
    if Backward then
      IndentAmount := IndentAmount * -1;
    EB.Indent(IndentAmount);
  end else
    Context.EditBuffer.TopView.SetTempMsg(sNoBlockMarked);
end;

procedure TEmacsBindings.SwapCPPHeader(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).SwapCPPHeader;
  BindingResult := krHandled;
end;

procedure TEmacsBindings.ViewExplorer(const Context: IOTAKeyContext;
  KeyCode: TShortcut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).ViewExplorer;
  BindingResult := krHandled;
end;

end.
