unit Emacsbufferlist;

interface

procedure Register;

implementation

uses Windows, Classes, SysUtils, ToolsAPI, Menus, Forms, Dialogs, Controls,
  Emacsbasebindings;

type
  TEmacsBinding = class(TEmacsBindings, IOTAKeyboardBinding)
  protected
    procedure AdjustBlockCase(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure AdjustWordCase(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure BackspaceDelete(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure CapitalizeWord(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure CursorLeft(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure CursorRight(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure DeleteChar(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure DeleteToEOL(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure DeleteToBOL(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure DeleteWordLeft(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure DeleteWordRight(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure GotoBookmark(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure InsertCharacter(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure InsertFile(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure InsertTab(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure LineDown(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure LineUp(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToBOF(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToBOL(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToEOF(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToEOL(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure PageDown(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure PageUp(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure SaveFile(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure SaveAllFiles(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure SetBookmark(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ToggleInsertMode(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure TransposeChar(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure TransposeLine(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure TransposeWord(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure Undo(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure WordLeft(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure WordRight(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
  public
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);
  end;

resourcestring
  sNewIDEEmacs = 'New IDE Emacs';

procedure Register;
begin
  (BorlandIDEServices as IOTAKeyBoardServices).AddKeyboardBinding(TEmacsBinding.Create);
end;

{ TEmacsBinding }

{ Do no localize the following strings }

procedure TEmacsBinding.BindKeyboard(const BindingServices: IOTAKeyBindingServices);
begin
  // Commands and Help
  BindingServices.AddKeyBinding([ShortCut(Ord('H'), [ssCtrl])], HelpKeyword, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('S'), [ssCtrl])], SaveFile, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('S'), [])], SaveAllFiles, nil);

  // Cursor Movement
  BindingServices.AddKeyBinding([ShortCut(Ord('P'), [ssCtrl])], LineUp, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_UP, [])], LineUp, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('N'), [ssCtrl])], LineDown, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_DOWN, [])], LineDown, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('V'), [])], PageUp, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_PRIOR, [])], PageUp, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('V'), [ssCtrl])], PageDown, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_NEXT, [])], PageDown, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('B'), [ssCtrl])], CursorLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_LEFT, [])], CursorLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('F'), [ssCtrl])], CursorRight, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_RIGHT, [])], CursorRight, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('B'), [])], WordLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_LEFT, [ssCtrl])], WordLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('F'), [])], WordRight, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_RIGHT, [ssCtrl])], WordRight, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('A'), [ssCtrl])], MoveCursorToBOL, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('E'), [ssCtrl])], MoveCursorToEOL, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('<'), [])], MoveCursorToBOF, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('>'), [])], MoveCursorToEOF, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_HOME, [])], MoveCursorToBOF, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_END, [])], MoveCursorToEOF, nil);

  // Deleting Text
  BindingServices.AddKeyBinding([ShortCut(VK_BACK, [])], BackSpaceDelete, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('D'), [ssCtrl])], DeleteChar, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_DELETE, [])], BackspaceDelete, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(VK_BACK, [])], DeleteWordLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_DELETE, [ssCtrl])], DeleteWordLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('D'), [])], DeleteWordRight, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssAlt])], DeleteToBOL, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl])], DeleteToEOL, nil);

  // Cut, Paste, and Undo
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('I'), [])], InsertFile, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('U'), [])], Undo, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('W'), [])], ClipCopy, nil, kfImplicits, '', 'EditCopyItem');
  BindingServices.AddKeyBinding([ShortCut(Ord('W'), [ssCtrl])], ClipCut, nil, kfImplicits, '', 'EditCutItem');
  BindingServices.AddKeyBinding([ShortCut(Ord('Y'), [ssCtrl])], ClipPaste, nil, kfImplicits, '', 'EditPasteItem');
  BindingServices.AddMenuCommand(mcClipPaste, ClipPaste, nil);
  BindingServices.AddMenuCommand(mcClipCopy, ClipCopy, nil);
  BindingServices.AddMenuCommand(mcClipCut, ClipCut, nil);

  // Search and Replace
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('%'), [])], SearchReplace, nil);
//  BindingServices.AddKeyBinding([ShortCut(Ord('S'), [ssCtrl])], SearchFind, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('L'), [ssCtrl])], SearchAgain, nil, kfImplicits, '', 'SearchAgainItem');
  BindingServices.AddKeyBinding([ShortCut(Ord('S'), [ssCtrl])], IncrementalSearch, nil, kfImplicits, '', 'SearchIncrementalItem');
  BindingServices.AddKeyBinding([ShortCut(Ord('R'), [ssCtrl])], IncrementalSearch, Pointer(1), kfImplicits, '', 'SearchIncrementalItem');
  BindingServices.AddMenuCommand(mcIncrementalSearch, IncrementalSearch, nil);
  BindingServices.AddMenuCommand(mcReplace, SearchReplace, nil);
  BindingServices.AddMenuCommand(mcGetFindString, SearchFind, nil);

  // Transposing Text and Capitalization
//  Esc-c  Capitalizes the first Charcter after the point and makes the rest after lowercase
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('C'), [])], CapitalizeWord, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('T'), [ssCtrl])], TransposeChar, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('T'), [ssCtrl])], TransposeLine, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('T'), [])], TransposeWord, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('U'), [])], AdjustWordCase, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_ESCAPE, []), ShortCut(Ord('L'), [])], AdjustWordCase, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('U'), [ssCtrl])], AdjustBlockCase, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('L'), [ssCtrl])], AdjustBlockCase, Pointer(1));

  // Debug (Non-Emacs)
  BindingServices.AddKeyBinding([ShortCut(VK_F5, [ssAlt])], DebugInspect, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_F7, [ssCtrl])], AddWatchAtCursor, nil);
  BindingServices.AddMenuCommand(mcAddWatchAtCursor, AddWatchAtCursor, nil);
  BindingServices.AddMenuCommand(mcInspectAtCursor, DebugInspect, nil);
  BindingServices.AddMenuCommand(mcRunToHere, RunToCursor, nil);
  BindingServices.AddMenuCommand(mcModify, EvaluateModify, nil);

  // Bookmarks
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('0'), [ssShift, ssCtrl])], GotoBookmark, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('1'), [ssShift, ssCtrl])], GotoBookmark, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('2'), [ssShift, ssCtrl])], GotoBookmark, Pointer(2));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('3'), [ssShift, ssCtrl])], GotoBookmark, Pointer(3));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('4'), [ssShift, ssCtrl])], GotoBookmark, Pointer(4));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('5'), [ssShift, ssCtrl])], GotoBookmark, Pointer(5));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('6'), [ssShift, ssCtrl])], GotoBookmark, Pointer(6));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('7'), [ssShift, ssCtrl])], GotoBookmark, Pointer(7));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('8'), [ssShift, ssCtrl])], GotoBookmark, Pointer(8));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('B'), []), ShortCut(Ord('9'), [ssShift, ssCtrl])], GotoBookmark, Pointer(9));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('0'), [])], SetBookmark, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('1'), [])], SetBookmark, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('2'), [])], SetBookmark, Pointer(2));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('3'), [])], SetBookmark, Pointer(3));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('4'), [])], SetBookmark, Pointer(4));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('5'), [])], SetBookmark, Pointer(5));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('6'), [])], SetBookmark, Pointer(6));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('7'), [])], SetBookmark, Pointer(7));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('8'), [])], SetBookmark, Pointer(8));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl]), ShortCut(Ord('M'), []), ShortCut(Ord('9'), [])], SetBookmark, Pointer(9));

  BindingServices.AddMenuCommand(mcMoveToMark0, GotoBookmark, nil);
  BindingServices.AddMenuCommand(mcMoveToMark1, GotoBookmark, Pointer(1));
  BindingServices.AddMenuCommand(mcMoveToMark2, GotoBookmark, Pointer(2));
  BindingServices.AddMenuCommand(mcMoveToMark3, GotoBookmark, Pointer(3));
  BindingServices.AddMenuCommand(mcMoveToMark4, GotoBookmark, Pointer(4));
  BindingServices.AddMenuCommand(mcMoveToMark5, GotoBookmark, Pointer(5));
  BindingServices.AddMenuCommand(mcMoveToMark6, GotoBookmark, Pointer(6));
  BindingServices.AddMenuCommand(mcMoveToMark7, GotoBookmark, Pointer(7));
  BindingServices.AddMenuCommand(mcMoveToMark8, GotoBookmark, Pointer(8));
  BindingServices.AddMenuCommand(mcMoveToMark9, GotoBookmark, Pointer(9));
  BindingServices.AddMenuCommand(mcSetMark0, SetBookmark, nil);
  BindingServices.AddMenuCommand(mcSetMark1, SetBookmark, Pointer(1));
  BindingServices.AddMenuCommand(mcSetMark2, SetBookmark, Pointer(2));
  BindingServices.AddMenuCommand(mcSetMark3, SetBookmark, Pointer(3));
  BindingServices.AddMenuCommand(mcSetMark4, SetBookmark, Pointer(4));
  BindingServices.AddMenuCommand(mcSetMark5, SetBookmark, Pointer(5));
  BindingServices.AddMenuCommand(mcSetMark6, SetBookmark, Pointer(6));
  BindingServices.AddMenuCommand(mcSetMark7, SetBookmark, Pointer(7));
  BindingServices.AddMenuCommand(mcSetMark8, SetBookmark, Pointer(8));
  BindingServices.AddMenuCommand(mcSetMark9, SetBookmark, Pointer(9));


  // Delphi IDE (Non-Emacs) Keys
  BindingServices.AddKeyBinding([ShortCut(VK_RETURN, [ssCtrl])], OpenFileAtCursor, nil, kfImplicits, '', 'ecOpenFileAtCursor');
  BindingServices.AddKeyBinding([ShortCut(VK_INSERT, [])], ToggleInsertMode, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_TAB, [])], InsertTab, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_RETURN, [])], InsertCharacter, Pointer($0D));
  BindingServices.AddMenuCommand(mcOpenFileAtCursor, OpenFileAtCursor, nil);

  BindingServices.AddKeyBinding([ShortCut(Ord('/'), [ssAlt])], CodeCompletion, Pointer(csCodeList or csManual));
  BindingServices.AddKeyBinding([ShortCut(Ord('J'), [ssCtrl])], CodeTemplate, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('C'), [ssShift, ssCtrl])], ClassComplete, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('G'), [ssShift, ssCtrl])], InsertNewGUID, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_SPACE, [ssShift, ssCtrl])], CodeCompletion, Pointer(csParamList or csManual));
  BindingServices.AddKeyBinding([ShortCut(VK_UP, [ssShift, ssCtrl])], ClassNavigate, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_DOWN, [ssShift, ssCtrl])], ClassNavigate, nil);

  BindingServices.AddKeyBinding([TextToShortCut('.')], AutoCodeInsight, Pointer(Ord('.')));
  BindingServices.AddKeyBinding([ShortCut(Ord('>'), [])], AutoCodeInsight, Pointer(Ord('>')));
  BindingServices.AddKeyBinding([TextToShortCut('(')], AutoCodeInsight, Pointer(Ord('(')));

  // Duplicate Key Mappings to allow the Alt key to be used instead of ESC
  BindingServices.AddKeyBinding([ShortCut(Ord('V'), [ssAlt])], PageUp, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('B'), [ssAlt])], WordLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('F'), [ssAlt])], WordRight, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('<'), [ssAlt])], MoveCursorToBOF, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('>'), [ssAlt])], MoveCursorToEOF, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_BACK, [ssAlt])], DeleteWordLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('D'), [ssAlt])], DeleteWordRight, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('W'), [ssAlt])], ClipCopy, nil, kfImplicits, '', 'EditCopyItem');
  BindingServices.AddKeyBinding([ShortCut(Ord('%'), [ssAlt])], SearchReplace, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('C'), [ssAlt])], CapitalizeWord, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('T'), [ssAlt])], TransposeWord, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('U'), [ssAlt])], AdjustWordCase, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('L'), [ssAlt])], AdjustWordCase, Pointer(1));

end;

function TEmacsBinding.GetBindingType: TBindingType;
begin
{$IFDEF DEBUG}
   Result := btPartial;
{$ELSE}
  Result := btComplete;
{$ENDIF}
end;

function TEmacsBinding.GetDisplayName: string;
begin
  Result := sNewIDEEmacs;
end;

function TEmacsBinding.GetName: string;
begin
  Result := 'Borland.NewEmacs'; //do not localize
end;

procedure TEmacsBinding.DeleteToEOL(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  Pos: IOTAEditPosition;
  Block: IOTAEditBlock;
begin
  Pos := Context.EditBuffer.EditPosition;
  Block := Context.EditBuffer.EditBlock;
  Block.Visible := False;
  Block.Save;
  try
    Block.Style := btNonInclusive;
    Block.BeginBlock;
    Pos.MoveEOL;
    Block.EndBlock;
    Block.Delete;
  finally
    Block.Restore;
  end;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.DeleteToBOL(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  Pos: IOTAEditPosition;
  Block: IOTAEditBlock;
begin
  Pos := Context.EditBuffer.EditPosition;
  Block := Context.EditBuffer.EditBlock;
  Block.Visible := False;
  Block.Save;
  try
    Block.Style := btNonInclusive;
    Block.EndBlock;
    Pos.MoveBOL;
    Block.BeginBlock;
    Block.Delete;
  finally
    Block.Restore;
  end;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.WordLeft(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveCursor(mmSkipLeft or mmSkipNonWord);
  Context.EditBuffer.EditPosition.MoveCursor(mmSkipLeft or mmSkipWord or mmSkipStream);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.WordRight(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveCursor(mmSkipRight or mmSkipWord or mmSkipStream);
  Context.EditBuffer.EditPosition.MoveCursor(mmSkipRight or mmSkipNonWord);
  BindingResult := krHandled;
end;

const
  BOOKMARK_ID_SYSTEM_ONE   = 19;
  BOOKMARK_ID_SYSTEM_TWO   = 18;
  BOOKMARK_ID_SYSTEM_THREE = 17;

procedure TEmacsBinding.DeleteWordLeft(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  EV: IOTAEditView;
  Blocked: Boolean;
begin
  EV := Context.EditBuffer.TopView;
  EB := EV.Block;
  EP := EV.Position;
  if (EB.Style <> btNonInclusive) or (EB.Size <> 0) then
  begin
    EB.Save;
    try
      EP.Save;
      try
        EP.Move(EB.StartingRow, EB.StartingColumn);
        EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_ONE);
        EP.Move(EB.EndingRow,EB.EndingColumn);
        EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_TWO);
      finally
        EP.Restore;
      end;
    finally
      EB.Restore;
    end;
    Blocked := True;
  end else
    Blocked := False;
  EB.Style := btNonInclusive;
  EB.Reset;
  EB.EndBlock;
  EP.MoveCursor(mmSkipLeft or mmSkipNonWord);
  EP.MoveCursor(mmSkipLeft or mmSkipWord);
  EB.BeginBlock;
  EB.Delete;
  if Blocked then
  begin
    EB.Style := btNonInclusive;
    EP.Save;
    try
      EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
      EB.BeginBlock;
      EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_TWO);
      EB.EndBlock;
    finally
      EP.Restore;
    end;
  end;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.BackspaceDelete(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.BackspaceDelete(1);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.CursorRight(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(0, 1);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.LineUp(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(-1, 0);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.PageDown(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.TopView.PageDown;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.CursorLeft(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(0, -1);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.LineDown(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(1, 0);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.PageUp(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.TopView.PageUp;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.DeleteWordRight(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  EV: IOTAEditView;
  Blocked: Boolean;
  C, SpaceAdjust: Integer;
begin
  EV := Context.EditBuffer.TopView;
  EB := EV.Block;
  EP := EV.Position;
  if (EB.Style <> btNonInclusive) or (EB.Size <> 0) then
  begin
    EB.Save;
    try
      EP.Save;
      try
        EP.Move(EB.StartingRow, EB.StartingColumn);
        EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_ONE);
        EP.Move(EB.EndingRow,EB.EndingColumn);
        EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_TWO);
      finally
        EP.Restore;
      end;
    finally
      EB.Restore;
    end;
    Blocked := True;
  end else
    Blocked := False;
  EB.Style := btNonInclusive;
  EB.Reset;
  EB.BeginBlock;
  SpaceAdjust := 0;
  EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_THREE);
  if EP.IsWhiteSpace then
  begin
    if EP.Character = #9 then
    begin
      C := EP.Column;
      EP.Delete(1);
      if C <> EP.Column then
        SpaceAdjust := C - EP.Column;
    end;
    EP.MoveCursor(mmSkipRight or mmSkipWhite);
  end
  else if EP.IsWordCharacter then
  begin
    EP.MoveCursor(mmSkipRight or mmSkipWord);
    EP.MoveCursor(mmSkipRight or mmSkipWhite);
  end
  else if EP.IsSpecialCharacter then
  begin
    EP.Delete(1);
    EP.MoveCursor(mmSkipRight or mmSkipWhite);
  end
  else
    EP.Delete(1);
  EB.EndBlock;
  EB.Delete;
  while SpaceAdjust > 0 do
  begin
    EP.InsertCharacter(' ');
    Dec(SpaceAdjust);
  end;
  if Blocked then
  begin
    EB.Style := btNonInclusive;
    EP.Save;
    try
      EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
      EB.BeginBlock;
      EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_TWO);
      EB.EndBlock;
    finally
      EP.Restore;
    end;
  end;
  BindingResult := krHandled;
end;


procedure TEmacsBinding.DeleteChar(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Delete(1);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.InsertTab(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EO: IOTABufferOptions;
begin
  EP := Context.EditBuffer.EditPosition;
  EO := Context.EditBuffer.BufferOptions;
  if not EO.InsertMode then
    EP.Tab(1)
  else if EO.SmartTab then
    EP.Align(1)
  else
    EP.InsertCharacter(#9);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.AdjustWordCase(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
  EV: IOTAEditView;
  Blocked: Boolean;
begin
  EV := Context.EditBuffer.TopView;
  EB := EV.Block;
  if EB.Size <> 0 then
  begin
    EB.Save;
    Blocked := True;
  end else
    Blocked := False;
  try
    EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_ONE);
    try
      if LongBool(Context.Context) then
        MarkWord(Context).LowerCase
      else MarkWord(Context).UpperCase;
      EB.Reset;
    finally
      EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
    end;
  finally
    if Blocked then
      EB.Restore;
  end;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.AdjustBlockCase(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
begin
  EB := Context.EditBuffer.EditBlock;
  if EB.Size <> 0 then
  begin
    if Context.Context <> nil then
      EB.LowerCase
    else EB.UpperCase;
  end else
    Context.EditBuffer.TopView.SetTempMsg(sNoBlockMarked);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.InsertFile(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
begin
  EP := Context.EditBuffer.EditPosition;
  EP.Save;
  try
    EP.InsertFile('');
  finally
    EP.Restore;
  end;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.SetBookmark(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.TopView.BookmarkToggle(Integer(Context.Context));
  BindingResult := krHandled;
end;

procedure TEmacsBinding.MoveCursorToBOF(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Move(1, 1);
  BindingResult := krHandled;
end;

procedure TEmacsBinding.MoveCursorToEOF(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveEOF;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.MoveCursorToBOL(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveBOL;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.MoveCursorToEOL(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveEOL;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.GotoBookmark(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.TopView.BookmarkGoto(Integer(Context.Context));
  Context.EditBuffer.TopView.MoveViewToCursor;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.ToggleInsertMode(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EO: IOTABufferOptions;
begin
  EO := (Context.KeyboardServices.EditorServices as IOTAEditorServices60).EditOptions.BufferOptions;
  EO.InsertMode := not EO.InsertMode;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.InsertCharacter(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.InsertCharacter(Char(Byte(Context.Context)));
  BindingResult := krHandled;
end;

procedure TEmacsBinding.SaveAllFiles(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).SaveAll;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.SaveFile(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  (Context.EditBuffer.TopView as IOTAEditActions).Save;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.TransposeChar(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  EV: IOTAEditView;
  Blocked: Boolean;
begin
  EV := Context.EditBuffer.TopView;
  EB := EV.Block;
  EP := EV.Position;
  if EB.Size <> 0 then
  begin
    EB.Save;
    Blocked := True;
  end else
    Blocked := False;
  try
    EP.Save;
    EB.Visible := false;
    EP.MoveRelative(0, -1);
    EB.BeginBlock;
    EP.MoveRelative(0,1);
    EB.EndBlock;
    EB.Cut(false);
    EP.MoveRelative(0,1);
    EP.Paste;
    EB.Reset;
  finally
    EP.Restore;
    if Blocked then
      EB.Restore;
  end;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.TransposeLine(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  EV: IOTAEditView;
  Blocked: Boolean;
begin
  EV := Context.EditBuffer.TopView;
  EB := EV.Block;
  EP := EV.Position;
  if EB.Size <> 0 then
  begin
    EB.Save;
    Blocked := True;
  end else
    Blocked := False;
  try
    EP.Save;
    EB.Visible := false;
    EP.MoveBOL;
    EP.MoveRelative(-1, 0);
    EB.BeginBlock;
    EP.MoveRelative(1,0);
    EB.EndBlock;
    EB.Cut(false);
    EP.MoveRelative(1,0);
    EP.Paste;
    EB.Reset;
  finally
    EP.Restore;
    if Blocked then
      EB.Restore;
  end;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.TransposeWord(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  EV: IOTAEditView;
  Blocked: Boolean;
  OnFirstWord: Boolean;
  LastCol: integer;
begin
  EV := Context.EditBuffer.TopView;
  EB := Context.EditBuffer.EditBlock;
  EP := Context.EditBuffer.EditPosition;
  OnFirstWord := False;
  if EB.Size <> 0 then
  begin
    EB.Save;
    Blocked := True;
  end else
    Blocked := False;
  try
    EP.Save;
    // Cursor is not on a word so skip left to a word
    if not EP.IsWordCharacter then
    begin
      EP.MoveCursor(mmSkipLeft or mmSkipStream or mmSkipNonWord or mmSkipWhite);
      OnFirstWord := True;
    end;
    // Cursor is on a valid word position
    if EP.IsWordCharacter then
    begin
      EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_TWO);
      EP.MoveCursor(mmSkipLeft or mmSkipWhite);
      if (EP.IsWhiteSpace or (EP.Column = 1)) and not OnFirstWord then
      begin
        // first character of word or line so assume its the word on the right
        EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_TWO);
        EB.Reset;
        EB.Visible := False;
        EB.Style := btNonInclusive;
        EB.BeginBlock;
        EP.MoveCursor(mmSkipRight or mmSkipWord);
        EB.EndBlock;
        EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_ONE);
        EB.Cut(False);
        // skip left to the first word or to the top of the file
        repeat
          EP.MoveCursor(mmSkipLeft or mmSkipStream or mmSkipNonWord);
          EP.MoveCursor(mmSkipLeft or mmSkipStream or mmSkipWhite);
          EP.MoveCursor(mmSkipLeft or mmSkipStream or mmSkipWord);
        until EP.IsWordCharacter or ((EP.Row = 1) and (EP.Column = 1));
        EP.Paste;
        EB.BeginBlock;
        EP.MoveCursor(mmSkipRight or mmSkipWord);
        EB.EndBlock;
        EB.Cut(False);
        EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_TWO);
        EP.Paste;
        EB.Reset;
        // Position the cursor at the end of the second word
        EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
      end
      else
      begin
        // not first char so its the word on the left
        //skip to the beginning of the word
        EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_TWO);
        EP.MoveCursor(mmSkipLeft or mmSkipWord);
        EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_ONE);
        EB.Reset;
        EB.Visible := False;
        EB.Style := btNonInclusive;
        EB.BeginBlock;
        EP.MoveCursor(mmSkipRight or mmSkipWord);
        EB.EndBlock;
        EB.Cut(False);
        // locate the EOF
        EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_THREE);
        EP.MoveEOF;
        LastCol := EP.Column;
        EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_THREE);
        // skip right to the first word or to the end of the file
        repeat
          EP.MoveCursor(mmSkipRight or mmSkipStream or mmSkipWord);
          EP.MoveCursor(mmSkipRight or mmSkipNonWord);
        until EP.IsWordCharacter or ((EP.Row >= EP.LastRow) and (EP.Column >= LastCol));
        if not EP.IsWordCharacter then
        begin
          // Hit EOF
          EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
          EP.Paste;
        end
        else
        begin
          // Found a word instead of EOF
          EP.Paste;
          EB.BeginBlock;
          EP.MoveCursor(mmSkipRight or mmSkipWord);
          EB.EndBlock;
          EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_TWO);
          EB.Cut(False);
          EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
          EP.Paste;
        end;
        EB.Reset;
        // Position the cursor at the end of the second word
        EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_TWO);
      end
    end;
  finally
    if Blocked then
      EB.Restore;
  end;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.Undo(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.Undo;
  BindingResult := krHandled;
end;

procedure TEmacsBinding.CapitalizeWord(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  EV: IOTAEditView;
  Blocked: Boolean;
  LastCol: integer;
begin
  EV := Context.EditBuffer.TopView;
  EB := Context.EditBuffer.EditBlock;
  EP := Context.EditBuffer.EditPosition;
  if EB.Size <> 0 then
  begin
    EB.Save;
    Blocked := True;
  end else
    Blocked := False;
  try
    // locate the EOF
    EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_ONE);
    EP.MoveEOF;
    LastCol := EP.Column;
    EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
    // Not on a word so skip right to the next word or EOF
    if not EP.IsWordCharacter then
      repeat
        EP.MoveCursor(mmSkipRight or mmSkipStream or mmSkipWord);
        EP.MoveCursor(mmSkipRight or mmSkipNonWord);
      until EP.IsWordCharacter or ((EP.Row >= EP.LastRow) and (EP.Column >= LastCol));
    // Cursor is on a valid word position
    if EP.IsWordCharacter then
    begin
      // Capitalize the character
      EB.BeginBlock;
      EP.MoveRelative(0, 1);
      EB.EndBlock;
      EB.UpperCase;
      // Lowercase the rest of the word
      EB.BeginBlock;
      EP.MoveCursor(mmSkipRight or mmSkipWord);
      EB.EndBlock;
      EB.LowerCase;
      EB.Reset;
    end;
  finally
    if Blocked then
      EB.Restore;
  end;
  BindingResult := krHandled;
end;

end .
