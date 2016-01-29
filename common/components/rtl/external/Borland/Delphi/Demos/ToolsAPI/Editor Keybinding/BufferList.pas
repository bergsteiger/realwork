unit BufferList;

interface

procedure Register;

implementation

uses Windows, Classes, SysUtils, ToolsAPI, Menus, Forms, Dialogs, Controls,
  BufferListForm, BaseBindings, SaveKeyMacro, ActiveX;

type
  TBufferList = class(TNotifierObject, IUnknown, IOTANotifier,
    IOTAKeyboardBinding)
    procedure BufferListProc(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    function GetBindingType: TBindingType;
    function GetDisplayName: string;
    function GetName: string;
    procedure BindKeyboard(const BindingServices: IOTAKeyBindingServices);
  end;

  TClassicBinding = class(TBaseBindings, IOTAKeyboardBinding)
  protected
    procedure AdjustBlockCase(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure AdjustWordCase(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure BackspaceDelete(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicBlockDelete(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicDeleteLine(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicMarkWord(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicMarkToViewBottom(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicMarkToViewTop(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicMarkToBOF(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicMarkToBOL(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicMarkToEOF(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicMarkToEOL(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicMoveBlock(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ClassicToggleCase(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure CopyBlock(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure CursorLeft(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure CursorRight(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure DeleteChar(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure DeleteToEOL(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure DeleteWordLeft(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure DeleteWordRight(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure EndCursor(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure GotoBookmark(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure HomeCursor(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure IndentBlock(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure InsertCharacter(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure InsertFile(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure InsertLiteralKey(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure InsertTab(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure LineDown(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure LineUp(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure LiteralKeyProc(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure LoadKeyMacro(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MarkBlockBegin(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MarkBlockEnd(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MarkLine(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MarkToPageDown(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MarkToPageUp(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MarkToRelativeHoriz(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MarkToRelativeVert(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MarkToWordLeft(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MarkToWordRight(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorHorizontal(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToBOF(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToBOL(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToEOF(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToEOL(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToLastEdit(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToMarkBegin(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorToMarkEnd(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveCursorVertical(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveLineViewBottom(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure MoveLineViewTop(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure PageDown(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure PageUp(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure SetBookmark(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure Scroll(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ToggleBlock(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ToggleInsertMode(const Context: IOTAKeyContext; KeyCode: TShortCut;
      var BindingResult: TKeyBindingResult);
    procedure ToggleMacroRecord(const Context: IOTAKeyContext; KeyCode: TShortCut;
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
  sBufferList = 'Buffer List';
  sNewIDEClassic = 'New IDE Classic';

procedure Register;
begin
  (BorlandIDEServices as IOTAKeyBoardServices).AddKeyboardBinding(TBufferList.Create);
  (BorlandIDEServices as IOTAKeyBoardServices).AddKeyboardBinding(TClassicBinding.Create);
end;

{ TBufferList }

procedure TBufferList.BindKeyboard(const BindingServices: IOTAKeyBindingServices);
begin
  BindingServices.AddKeyBinding([ShortCut(Ord('B'), [ssCtrl])], BufferListProc, nil);
end;

procedure TBufferList.BufferListProc(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  I: Integer;
  InterfaceList: IInterfaceList;
  Iter: IOTAEditBufferIterator;
  Buffer: IOTAEditBuffer;
begin
  with TBufferListFrm.Create(Application) do
  try
    InterfaceList := TInterfaceList.Create;
    Context.KeyboardServices.EditorServices.GetEditBufferIterator(Iter);
    for I := 0 to Iter.Count - 1 do
    begin
      Buffer := Iter.EditBuffers[I];
      InterfaceList.Add(Buffer);
      BufferListBox.Items.Add(Buffer.FileName);
    end;
    if BufferListBox.Items.Count > 1 then
      BufferListBox.ItemIndex := 1
    else BufferListBox.ItemIndex := 0;
    Iter := nil;
    if ShowModal = mrOK then
      (InterfaceList[BufferListBox.ItemIndex] as IOTAEditBuffer).Show;
  finally
    Free;
  end;
  BindingResult := krHandled;
end;

function TBufferList.GetBindingType: TBindingType;
begin
  Result := btPartial;
end;

function TBufferList.GetDisplayName: string;
begin
  Result := sBufferList;
end;

function TBufferList.GetName: string;
begin
  Result := 'Borland.BufferList';  //do not localize
end;

{ TClassicBinding }

{ Do no localize the following strings }

procedure TClassicBinding.BindKeyboard(const BindingServices: IOTAKeyBindingServices);
begin
  BindingServices.AddKeyBinding([ShortCut(VK_F5, [ssAlt])], DebugInspect, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_F1, [ssCtrl])], HelpKeyword, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_F7, [ssCtrl])], AddWatchAtCursor, nil);
  BindingServices.AddMenuCommand(mcAddWatchAtCursor, AddWatchAtCursor, nil);
  BindingServices.AddMenuCommand(mcInspectAtCursor, DebugInspect, nil);

  BindingServices.AddKeyBinding([ShortCut(Ord('A'), [ssCtrl])], WordLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('C'), [ssCtrl])], PageDown, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('D'), [ssCtrl])], CursorRight, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('E'), [ssCtrl])], LineUp, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('F'), [ssCtrl])], WordRight, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('G'), [ssCtrl])], DeleteChar, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('H'), [ssCtrl])], BackSpaceDelete, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('I'), [ssCtrl])], InsertTab, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('J'), [ssCtrl])], CodeTemplate, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('L'), [ssCtrl])], SearchAgain, nil, kfImplicits, '', 'SearchAgainItem');
  BindingServices.AddKeyBinding([ShortCut(Ord('R'), [ssCtrl])], PageUp, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('S'), [ssCtrl])], CursorLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('T'), [ssCtrl])], DeleteWordRight, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('V'), [ssCtrl])], ToggleInsertMode, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('W'), [ssCtrl])], Scroll, Pointer(-1));
  BindingServices.AddKeyBinding([ShortCut(Ord('X'), [ssCtrl])], LineDown, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Y'), [ssCtrl])], ClassicDeleteLine, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Z'), [ssCtrl])], Scroll, Pointer(1));
  BindingServices.AddMenuCommand(mcRepeatSearch, SearchAgain, nil);

  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('B'), [ssCtrl])], MarkBlockBegin, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('C'), [ssCtrl])], CopyBlock, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('E'), [ssCtrl])], AdjustWordCase, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('F'), [ssCtrl])], AdjustWordCase, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('H'), [ssCtrl])], ToggleBlock, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('I'), [ssCtrl])], IndentBlock, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('K'), [ssCtrl])], MarkBlockEnd, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('L'), [ssCtrl])], MarkLine, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('N'), [ssCtrl])], AdjustBlockCase, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('O'), [ssCtrl])], AdjustBlockCase, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('P'), [ssCtrl])], Print, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('R'), [ssCtrl])], InsertFile, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('T'), [ssCtrl])], ClassicMarkWord, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('U'), [ssCtrl])], IndentBlock, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('V'), [ssCtrl])], ClassicMoveBlock, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('W'), [ssCtrl])], BlockSave, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('Y'), [ssCtrl])], ClassicBlockDelete, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('0'), [])], SetBookmark, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('1'), [])], SetBookmark, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('2'), [])], SetBookmark, Pointer(2));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('3'), [])], SetBookmark, Pointer(3));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('4'), [])], SetBookmark, Pointer(4));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('5'), [])], SetBookmark, Pointer(5));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('6'), [])], SetBookmark, Pointer(6));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('7'), [])], SetBookmark, Pointer(7));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('8'), [])], SetBookmark, Pointer(8));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('9'), [])], SetBookmark, Pointer(9));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('0'), [ssCtrl])], SetBookmark, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('1'), [ssCtrl])], SetBookmark, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('2'), [ssCtrl])], SetBookmark, Pointer(2));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('3'), [ssCtrl])], SetBookmark, Pointer(3));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('4'), [ssCtrl])], SetBookmark, Pointer(4));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('5'), [ssCtrl])], SetBookmark, Pointer(5));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('6'), [ssCtrl])], SetBookmark, Pointer(6));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('7'), [ssCtrl])], SetBookmark, Pointer(7));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('8'), [ssCtrl])], SetBookmark, Pointer(8));
  BindingServices.AddKeyBinding([ShortCut(Ord('K'), [ssCtrl]), ShortCut(Ord('9'), [ssCtrl])], SetBookmark, Pointer(9));

  BindingServices.AddKeyBinding([ShortCut(Ord('N'), [ssCtrl])], OpenLine, nil);

  BindingServices.AddKeyBinding([ShortCut(Ord('O'), [ssCtrl]), ShortCut(Ord('A'), [ssCtrl])], OpenFileAtCursor, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('O'), [ssCtrl]), ShortCut(Ord('B'), [ssCtrl])], BrowseSymbolAtCursor, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('O'), [ssCtrl]), ShortCut(Ord('C'), [ssCtrl])], SetBlockStyle, Pointer(btColumn));
  BindingServices.AddKeyBinding([ShortCut(Ord('O'), [ssCtrl]), ShortCut(Ord('G'), [ssCtrl])], GotoLine, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('O'), [ssCtrl]), ShortCut(Ord('I'), [ssCtrl])], SetBlockStyle, Pointer(btInclusive));
  BindingServices.AddKeyBinding([ShortCut(Ord('O'), [ssCtrl]), ShortCut(Ord('K'), [ssCtrl])], SetBlockStyle, Pointer(btNonInclusive));
  BindingServices.AddKeyBinding([ShortCut(Ord('O'), [ssCtrl]), ShortCut(Ord('L'), [ssCtrl])], SetBlockStyle, Pointer(btLine));
  BindingServices.AddKeyBinding([ShortCut(Ord('O'), [ssCtrl]), ShortCut(Ord('O'), [ssCtrl])], InsertCompilerOptions, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('O'), [ssCtrl]), ShortCut(Ord('U'), [ssCtrl])], ClassicToggleCase, nil);
  BindingServices.AddMenuCommand(mcGotoLine, GotoLine, nil);

  BindingServices.AddKeyBinding([ShortCut(Ord('P'), [ssCtrl])], InsertLiteralKey, nil);

  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('A'), [ssCtrl])], SearchReplace, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('B'), [ssCtrl])], MoveCursorToMarkBegin, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('C'), [ssCtrl])], MoveCursorToEOF, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('D'), [ssCtrl])], MoveCursorToEOL, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('E'), [ssCtrl])], HomeCursor, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('F'), [ssCtrl])], SearchFind, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('G'), [ssCtrl])], NullCmd, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('H'), [ssCtrl])], NullCmd, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('I'), [ssCtrl])], NullCmd, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('J'), [ssCtrl])], NullCmd, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('K'), [ssCtrl])], MoveCursorToMarkEnd, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('P'), [ssCtrl])], MoveCursorToLastEdit, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('R'), [ssCtrl])], MoveCursorToBOF, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('S'), [ssCtrl])], MoveCursorToBOL, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('T'), [ssCtrl])], MoveLineViewTop, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('U'), [ssCtrl])], MoveLineViewBottom, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('X'), [ssCtrl])], EndCursor, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('Y'), [ssCtrl])], DeleteToEOL, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('0'), [])], GotoBookmark, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('1'), [])], GotoBookmark, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('2'), [])], GotoBookmark, Pointer(2));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('3'), [])], GotoBookmark, Pointer(3));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('4'), [])], GotoBookmark, Pointer(4));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('5'), [])], GotoBookmark, Pointer(5));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('6'), [])], GotoBookmark, Pointer(6));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('7'), [])], GotoBookmark, Pointer(7));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('8'), [])], GotoBookmark, Pointer(8));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('9'), [])], GotoBookmark, Pointer(9));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('0'), [ssCtrl])], GotoBookmark, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('1'), [ssCtrl])], GotoBookmark, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('2'), [ssCtrl])], GotoBookmark, Pointer(2));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('3'), [ssCtrl])], GotoBookmark, Pointer(3));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('4'), [ssCtrl])], GotoBookmark, Pointer(4));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('5'), [ssCtrl])], GotoBookmark, Pointer(5));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('6'), [ssCtrl])], GotoBookmark, Pointer(6));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('7'), [ssCtrl])], GotoBookmark, Pointer(7));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('8'), [ssCtrl])], GotoBookmark, Pointer(8));
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('9'), [ssCtrl])], GotoBookmark, Pointer(9));
  BindingServices.AddMenuCommand(mcReplace, SearchReplace, nil);
  BindingServices.AddMenuCommand(mcGetFindString, SearchFind, nil);
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

  BindingServices.AddKeyBinding([ShortCut(VK_RETURN, [ssCtrl])], OpenFileAtCursor, nil, kfImplicits, '', 'ecOpenFileAtCursor');
  BindingServices.AddKeyBinding([ShortCut(VK_SPACE, [ssCtrl])], CodeCompletion, Pointer(csCodeList or csManual));
  BindingServices.AddKeyBinding([ShortCut(VK_PRIOR, [ssCtrl])], MoveCursorToBOF, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_NEXT, [ssCtrl])], MoveCursorToEOF, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_RIGHT, [ssCtrl])], WordRight, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_LEFT, [ssCtrl])], WordLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_HOME, [ssCtrl])], HomeCursor, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_END, [ssCtrl])], EndCursor, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_BACK, [ssctrl])], DeleteWordLeft, nil);

  BindingServices.AddKeyBinding([ShortCut(VK_TAB, [])], InsertTab, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_BACK, [])], BackSpaceDelete, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_HOME, [])], MoveCursorToBOL, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_END, [])], MoveCursorToEOL, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_DELETE, [])], DeleteChar, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_INSERT, [])], ToggleInsertMode, nil);

  BindingServices.AddKeyBinding([ShortCut(VK_DOWN, [])], MoveCursorVertical, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(VK_UP, [])], MoveCursorVertical, Pointer(-1));
  BindingServices.AddKeyBinding([ShortCut(VK_RIGHT, [])], MoveCursorHorizontal, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(VK_LEFT, [])], MoveCursorHorizontal, Pointer(-1));

  BindingServices.AddKeyBinding([ShortCut(VK_PRIOR, [])], PageUp, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_NEXT, [])], PageDown, nil);

  BindingServices.AddKeyBinding([ShortCut(VK_RETURN, [])], InsertCharacter, Pointer($0D));

  BindingServices.AddKeyBinding([ShortCut(VK_BACK, [ssShift])], BackSpaceDelete, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_LEFT, [ssShift])], MarkToRelativeHoriz, Pointer(-1));
  BindingServices.AddKeyBinding([ShortCut(VK_RIGHT, [ssShift])], MarkToRelativeHoriz, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(VK_UP, [ssShift])], MarkToRelativeVert, Pointer(-1));
  BindingServices.AddKeyBinding([ShortCut(VK_DOWN, [ssShift])], MarkToRelativeVert, Pointer(1));
  BindingServices.AddKeyBinding([ShortCut(VK_END, [ssShift])], ClassicMarkToEOL, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_HOME, [ssShift])], ClassicMarkToBOL, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_PRIOR, [ssShift])], MarkToPageUp, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_NEXT, [ssShift])], MarkToPageDown, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_RETURN, [ssShift])], InsertCharacter, Pointer($0D));

  BindingServices.AddKeyBinding([ShortCut(VK_INSERT, [ssShift])], ClipPaste, nil, kfImplicits, '', 'EditPasteItem');
  BindingServices.AddKeyBinding([ShortCut(VK_INSERT, [ssCtrl])], ClipCopy, nil, kfImplicits, '', 'EditCopyItem');
  BindingServices.AddKeyBinding([ShortCut(VK_DELETE, [ssShift])], ClipCut, nil, kfImplicits, '', 'EditCutItem');
  BindingServices.AddKeyBinding([ShortCut(VK_DELETE, [ssCtrl])], ClipClear, nil, kfImplicits, '', 'EditDeleteItem');
  BindingServices.AddMenuCommand(mcClipPaste, ClipPaste, nil);
  BindingServices.AddMenuCommand(mcClipCopy, ClipCopy, nil);
  BindingServices.AddMenuCommand(mcClipCut, ClipCut, nil);
  BindingServices.AddMenuCommand(mcClipClear, ClipClear, nil);

  BindingServices.AddKeyBinding([ShortCut(VK_LEFT, [ssShift, ssCtrl])], MarkToWordLeft, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_RIGHT, [ssShift, ssCtrl])], markToWordRight, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('C'), [ssShift, ssCtrl])], ClassComplete, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('G'), [ssShift, ssCtrl])], InsertNewGUID, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('S'), [ssShift, ssCtrl])], IncrementalSearch, nil, kfImplicits, '', 'SearchIncrementalItem');
  BindingServices.AddKeyBinding([ShortCut(VK_SPACE, [ssShift, ssCtrl])], CodeCompletion, Pointer(csParamList or csManual));
  BindingServices.AddKeyBinding([ShortCut(VK_END, [ssShift, ssCtrl])], ClassicMarkToViewBottom, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_HOME, [ssShift, ssCtrl])], ClassicMarkToViewTop, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_PRIOR, [ssShift, ssCtrl])], ClassicMarkToBOF, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_NEXT, [ssShift, ssCtrl])], ClassicMarkToEOF, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_UP, [ssShift, ssCtrl])], ClassNavigate, nil);
  BindingServices.AddKeyBinding([ShortCut(VK_DOWN, [ssShift, ssCtrl])], ClassNavigate, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('R'), [ssShift, ssCtrl])], ToggleMacroRecord, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('P'), [ssShift, ssCtrl, ssAlt])], LoadKeyMacro, nil);
  BindingServices.AddMenuCommand(mcIncrementalSearch, IncrementalSearch, nil);

  BindingServices.AddKeyBinding([TextToShortCut('.')], AutoCodeInsight, Pointer(Ord('.')));
  BindingServices.AddKeyBinding([ShortCut(Ord('>'), [])], AutoCodeInsight, Pointer(Ord('>')));
  BindingServices.AddKeyBinding([TextToShortCut('(')], AutoCodeInsight, Pointer(Ord('(')));

{  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('y'), [])], DeleteToEOL, nil);
  BindingServices.AddKeyBinding([ShortCut(Ord('Q'), [ssCtrl]), ShortCut(Ord('Y'), [])], DeleteToEOL, nil);}
  // Create the literal key table.. Note: needs at least one keybinding in order to be created
  BindingServices.AddKeyBinding([ShortCut(0, [])], NullCmd, nil, 7, 'LiteralKeyTable');
  BindingServices.SetDefaultKeyProc(LiteralKeyProc, nil, 'LiteralKeyTable');
end;

function TClassicBinding.GetBindingType: TBindingType;
begin
{$IFDEF DEBUG}
   Result := btPartial;
{$ELSE}
  Result := btComplete;
{$ENDIF}
end;

function TClassicBinding.GetDisplayName: string;
begin
  Result := sNewIDEClassic;
end;

function TClassicBinding.GetName: string;
begin
  Result := 'Borland.NewClassic'; //do not localize
end;

procedure TClassicBinding.DeleteToEOL(const Context: IOTAKeyContext;
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

procedure TClassicBinding.WordLeft(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveCursor(mmSkipLeft or mmSkipNonWord);
  Context.EditBuffer.EditPosition.MoveCursor(mmSkipLeft or mmSkipWord or mmSkipStream);
  BindingResult := krHandled;
end;

procedure TClassicBinding.WordRight(const Context: IOTAKeyContext;
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

procedure TClassicBinding.DeleteWordLeft(const Context: IOTAKeyContext;
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

procedure TClassicBinding.BackspaceDelete(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.BackspaceDelete(1);
  BindingResult := krHandled;
end;

procedure TClassicBinding.CursorRight(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(0, 1);
  BindingResult := krHandled;
end;

procedure TClassicBinding.LineUp(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(-1, 0);
  BindingResult := krHandled;
end;

procedure TClassicBinding.PageDown(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.TopView.PageDown;
  BindingResult := krHandled;
end;

procedure TClassicBinding.CursorLeft(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(0, -1);
  BindingResult := krHandled;
end;

procedure TClassicBinding.LineDown(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(1, 0);
  BindingResult := krHandled;
end;

procedure TClassicBinding.PageUp(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.TopView.PageUp;
  BindingResult := krHandled;
end;

procedure TClassicBinding.DeleteWordRight(const Context: IOTAKeyContext;
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

procedure TClassicBinding.Scroll(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EV: IOTAEditView;
  Delta: Integer;
begin
  EV := Context.EditBuffer.TopView;
  EP := EV.Position;
  Delta := Integer(Context.Context);
  EV.Scroll(Delta, 0);
  if EP.Row >= EV.GetBottomRow then
  begin
    EP.Move(EP.Row - 1, EP.Column);
    EV.MoveViewToCursor;
  end;
  if EP.Row < EV.GetTopRow then
  begin
    EP.Move(EP.Row + 1, EP.Column);
    EV.MoveViewToCursor;
  end;
  BindingResult := krHandled;
end;

procedure TClassicBinding.DeleteChar(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Delete(1);
  BindingResult := krHandled;
end;

procedure TClassicBinding.InsertTab(const Context: IOTAKeyContext;
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

procedure TClassicBinding.HomeCursor(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Move(Context.EditBuffer.TopView.TopRow, 0);
  BindingResult := krHandled;
end;

procedure TClassicBinding.EndCursor(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Move(Context.EditBuffer.TopView.BottomRow, 0);
  BindingResult := krHandled;
end;

procedure TClassicBinding.MarkBlockBegin(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
  EP: IOTAEditPosition;
  EV: IOTAEditView;
  EndCol, EndRow: Integer;
  TopRow, LeftCol: Integer;
begin
  EB := Context.EditBuffer.EditBlock;
  EP := Context.EditBuffer.EditPosition;
  EV := Context.EditBuffer.TopView;
  if (EB.Style <> btNonInclusive) or (EB.Size <> 0) then
  begin
    TopRow := EV.TopRow;
    LeftCol := EV.LeftColumn;
    EndCol := EB.EndingColumn;
    EndRow := EB.EndingRow;
    if EP.Row = EndRow then
      if EP.Column >= EndCol then
        EndCol := EP.Column;
    if EP.Row > EndRow then
      EndRow := EP.Row;
    EP.Save;
    try
      EB.Reset;
      EB.BeginBlock;
      EB.Style := btNonInclusive;
      EP.Move(EndRow, EndCol);
      EB.EndBlock;
    finally
      EP.Restore;
    end;
    EV.SetTopLeft(TopRow, LeftCol);
  end else
  begin
    EB.Reset;
    EB.BeginBlock;
    EB.Style := btNonInclusive;
  end;
  BindingResult := krHandled;
end;

procedure TClassicBinding.MarkBlockEnd(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
  EP: IOTAEditPosition;
  StartRow, StartCol: Integer;
begin
  EB := Context.EditBuffer.EditBlock;
  EP := Context.EditBuffer.EditPosition;
  if (EB.Style <> btNonInclusive) or (EB.Size <> 0) then
  begin
    StartCol := EB.StartingColumn;
    StartRow := EB.StartingRow;
    if EP.Row = StartRow then
      if EP.Column <= StartCol then
        StartCol := EP.Column;
    if EP.Row < StartRow then
      StartRow := EP.Row;
    EP.Save;
    try
      EP.Move(StartRow, StartCol);
      EB.Reset;
      EB.BeginBlock;
      EB.Style := btNonInclusive;
    finally
      EP.Restore;
    end;
  end;
  EB.EndBlock;
  EB.Style := btNonInclusive;
  BindingResult := krHandled;
end;

resourcestring
  sBlockCopied = 'Block copied';

procedure TClassicBinding.CopyBlock(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
begin
  EB := Context.EditBuffer.EditBlock;
  if EB.Size <> 0 then
  begin
    EB.Copy(False);
    Context.EditBuffer.EditPosition.Paste;
    Context.EditBuffer.TopView.SetTempMsg(sBlockCopied);
  end else
    Context.EditBuffer.TopView.SetTempMsg(sNoBlockMarked);
end;

procedure TClassicBinding.AdjustWordCase(const Context: IOTAKeyContext;
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

procedure TClassicBinding.ToggleBlock(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.Visible := not Context.EditBuffer.EditBlock.Visible;
  BindingResult := krHandled;
end;

procedure TClassicBinding.IndentBlock(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  SlideBlock(Context, LongBool(Context.Context));
  BindingResult := krHandled;
end;

procedure TClassicBinding.MarkLine(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
begin
  EP := Context.EditBuffer.EditPosition;
  EB := Context.EditBuffer.EditBlock;
  EP.Save;
  try
    EP.Move(0, 1);
    EB.Style := btNonInclusive;
    EB.BeginBlock;
    EP.MoveRelative(1, 0);
    EB.EndBlock;
  finally
    EP.Restore;
  end;
  BindingResult := krHandled;    
end;

procedure TClassicBinding.AdjustBlockCase(const Context: IOTAKeyContext;
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

procedure TClassicBinding.InsertFile(const Context: IOTAKeyContext;
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

procedure TClassicBinding.ClassicMarkWord(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
begin
  EP := Context.EditBuffer.EditPosition;
  if not EP.IsWordCharacter then
    WordLeft(Context, KeyCode, BindingResult);
  MarkWord(Context);
  BindingResult := krHandled;
end;

resourcestring
  sBlockMoved = 'Block moved';

procedure TClassicBinding.ClassicMoveBlock(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  EV: IOTAEditView;
  NewRow, NewColumn: Integer;
begin
  EP := Context.EditBuffer.EditPosition;
  EB := Context.EditBuffer.EditBlock;
  EV := Context.EditBuffer.TopView;
  if EB.Size <> 0 then
  begin
    EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_ONE);
    EB.Save;
    try
      EP.Move(EB.StartingRow, EB.StartingColumn);
    finally
      EB.Restore;
    end;
    EB.Cut(False);
    EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
    NewRow := EP.Row;
    NewColumn := EP.Column;
    EP.Paste;
    EP.Move(NewRow, NewColumn);
    EB.BeginBlock;
    EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
    EB.Extend(EP.Row, EP.Column);
    EB.Save;
    try
      EP.Move(NewRow, NewColumn);
    finally
      EB.Restore;
    end;
    EV.SetTempMsg(sBlockMoved);
  end else
    EV.SetTempMsg(sNoBlockMarked);
  BindingResult := krHandled;
end;

resourcestring
  sBlockDeleted = 'Block deleted';

procedure TClassicBinding.ClassicBlockDelete(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
  EV: IOTAEditView;
begin
  EV := Context.EditBuffer.TopView;
  EB := EV.Block;
  if EB.Size <> 0 then
  begin
    EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_ONE);
    EB.Delete;
    EV.BookmarkGoto(BOOKMARK_ID_SYSTEM_ONE);
    EV.SetTempMsg(sBlockDeleted);
  end else
    EV.SetTempMsg(sNoBlockMarked);
  BindingResult := krHandled;
end;

procedure TClassicBinding.SetBookmark(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.TopView.BookmarkToggle(Integer(Context.Context));
  BindingResult := krHandled;
end;

procedure TClassicBinding.ClassicToggleCase(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  Blocked: Boolean;
begin
  EB := Context.EditBuffer.EditBlock;
  EP := Context.EditBuffer.EditPosition;
  if EB.Size <> 0 then
  begin
    EB.Save;
    Blocked := True;
  end else
    Blocked := False;
  try
    if ((EP.Column <= EB.EndingColumn) and (EP.Row <= EB.EndingRow)) and
      ((EP.Column >= EB.StartingColumn) and (EP.Row >= EB.StartingRow)) then
      EB.ToggleCase
    else
    begin
      EB.BeginBlock;
      EP.MoveRelative(0, 1);
      EB.EndBlock;
      EB.ToggleCase;
      EB.Reset;
    end;
  finally
    if Blocked then
      EB.Restore;
  end;
end;

resourcestring
  sLiteralKeyInserted = 'Literal key inserted';

procedure TClassicBinding.LiteralKeyProc(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  Key: Word;
  Shift: TShiftState;
begin
  ShortCutToKey(KeyCode, Key, Shift);
  if Shift = [ssCtrl] then
  begin
    if (Key >= $40) and (Key < $5F) then
    begin
      Dec(Key, $40);
      Shift := [];
    end else if (Key >= $60) and (Key < $7F) then
    begin
      Dec(Key, $60);
      Shift := [];
    end;
  end;
  if Shift = [] then
    Context.EditBuffer.EditPosition.InsertCharacter(Char(Key));
  Context.EditBuffer.TopView.SetTempMsg(sLiteralKeyInserted);
  Context.KeyboardServices.PopKeyboard('LiteralKeyTable'); //do not localize
  BindingResult := krHandled;
end;

procedure TClassicBinding.LoadKeyMacro(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  KS: IOTAKeyboardServices;
  Stream: IStream;
begin
  KS := Context.KeyboardServices;
  if not KS.CurrentPlayback.IsPlaying and not KS.CurrentRecord.IsRecording then
  begin
    with TSaveKeyMacroDlg.Create(Application) do
    try
      if OpenDialog1.Execute then
      try
        Stream := TStreamAdapter.Create(TFileStream.Create(OpenDialog1.FileName,
          fmOpenRead or fmShareDenyWrite), soOwned);
        KS.CurrentPlayback.Clear;
        KS.CurrentPlayback.ReadFromStream(Stream);
      except
        Application.HandleException(Self);
      end;
    finally
      Free;
    end;
  end;
  BindingResult := krHandled;
end;

resourcestring
  sInsertLiteralChar = 'Inserting literal character';

procedure TClassicBinding.InsertLiteralKey(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.KeyboardServices.PushKeyboard('LiteralKeyTable'); //do not localise
  Context.EditBuffer.TopView.SetTempMsg(sInsertLiteralChar);
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveCursorToBOF(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.Move(1, 1);
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveCursorToEOF(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveEOF;
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveCursorToMarkBegin(const Context: IOTAKeyContext; KeyCode: TShortCut;
  var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
begin
  EB := Context.EditBuffer.EditBlock;
  if EB.Visible and (EB.Size <> 0) then
  begin
    EB.Save;
    try
      Context.EditBuffer.EditPosition.Move(EB.StartingRow, EB.StartingColumn);
    finally
      EB.Restore;
    end;
  end else
    Context.EditBuffer.TopView.SetTempMsg(sNoBlockMarked);
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveCursorToBOL(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveBOL;
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveCursorToEOL(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveEOL;
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveCursorToMarkEnd(const Context: IOTAKeyContext; KeyCode: TShortCut;
  var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
begin
  EB := Context.EditBuffer.EditBlock;
  if EB.Visible and (EB.Size <> 0) then
  begin
    EB.Save;
    try
      Context.EditBuffer.EditPosition.Move(EB.EndingRow, EB.EndingColumn);
    finally
      EB.Restore;
    end;
  end else
    Context.EditBuffer.TopView.SetTempMsg(sNoBlockMarked);
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveCursorToLastEdit(const Context: IOTAKeyContext; KeyCode: TShortCut;
  var BindingResult: TKeyBindingResult);
var
  EP: IOTAEditPosition;
  EV: IOTAEditView;
begin
  EP := Context.EditBuffer.EditPosition;
  EV := Context.EditBuffer.TopView;
  EP.Move(EV.GetLastEditRow, EV.GetLastEditColumn);
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveLineViewBottom(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EV: IOTAEditView;
  Row, TopRow, BottomRow, Height: Integer;
begin
  EV := Context.EditBuffer.TopView;
  Row := EV.Position.GetRow;
  TopRow := EV.TopRow;
  BottomRow := EV.BottomRow;
  Height := BottomRow - TopRow;
  if Row > Height then
    EV.SetTopLeft(Row - (Height - 1), 0);
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveLineViewTop(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EV: IOTAEditView;
begin
  EV := Context.EditBuffer.TopView;
  EV.SetTopLeft(EV.Position.Row, 0);
  BindingResult := krHandled;
end;

procedure TClassicBinding.GotoBookmark(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.TopView.BookmarkGoto(Integer(Context.Context));
  BindingResult := krHandled;
end;

procedure TClassicBinding.ToggleInsertMode(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EO: IOTABufferOptions;
begin
  EO := (Context.KeyboardServices.EditorServices as IOTAEditorServices60).EditOptions.BufferOptions;
  EO.InsertMode := not EO.InsertMode;
  BindingResult := krHandled;
end;

procedure TClassicBinding.ToggleMacroRecord(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  KS: IOTAKeyboardServices;
  Stream: IStream;
begin
  KS := Context.KeyboardServices;
  if not KS.CurrentPlayback.IsPlaying then
    if KS.CurrentRecord.IsRecording then
    begin
      KS.ResumeRecord;
      with TSaveKeyMacroDlg.Create(Application) do
      try
        if ShowModal = mrOK then
        try
          Stream := TStreamAdapter.Create(TFileStream.Create(Edit1.Text, fmCreate), soOwned);
          KS.CurrentRecord.WriteToStream(Stream);
        except
          Application.HandleException(Self);
        end;
      finally
        Free;
      end;
    end else
      KS.ResumeRecord;
  BindingResult := krHandled;
end;

procedure TClassicBinding.ClassicDeleteLine(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EV: IOTAEditView;
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  Blocked: Boolean;
  Style: TOTABlockType;
begin
  EV := Context.EditBuffer.TopView;
  EP := EV.Position;
  EB := EV.Block;
  if EB.Size <> 0 then
  begin
    EB.Save;
    try
      EP.Save;
      try
        EP.Move(EB.StartingRow, EB.StartingColumn);
        EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_ONE);
        EP.Move(EB.EndingRow, EB.EndingColumn);
        EV.BookmarkRecord(BOOKMARK_ID_SYSTEM_TWO);
        Blocked := True;
      finally
        EP.Restore;
      end;
    finally
      EB.Restore;
    end;
  end else
    Blocked := False;
  try
    Style := EB.Style;
    try
      EP.MoveBOL;
      EP.Save;
      try
        EB.Reset;
        EB.Style := btLine;
        EB.BeginBlock;
        EB.Delete;
      finally
        EP.Restore;
      end;
    finally
      EB.Style := Style;
    end;
  finally
    if Blocked then
    begin
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
  end;
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveCursorHorizontal(const Context: IOTAKeyContext; KeyCode: TShortCut;
  var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(0, Integer(Context.Context));
  BindingResult := krHandled;
end;

procedure TClassicBinding.MoveCursorVertical(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.MoveRelative(Integer(Context.Context), 0);
  BindingResult := krHandled;
end;

procedure TClassicBinding.InsertCharacter(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditPosition.InsertCharacter(Char(Byte(Context.Context)));
  BindingResult := krHandled;
end;

procedure TClassicBinding.ClassicMarkToViewBottom(const Context: IOTAKeyContext; KeyCode: TShortCut;
  var BindingResult: TKeyBindingResult);
var
  EV: IOTAEditView;
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
begin
  EV := Context.EditBuffer.TopView;
  EP := EV.Position;
  EB := EV.Block;
  if (EB.EndingRow = EP.Row) and (EB.EndingColumn = EP.Column) then
  begin
//    EB.Style := btNonInclusive;
    EP.Move(EB.StartingRow, EB.StartingColumn);
    EB.BeginBlock;
    EB.Extend(EV.BottomRow - 1, EP.Column);
    EB.EndBlock;
  end else
  begin
    EB.Reset;
//    EB.Style := btNonInclusive;
    EB.BeginBlock;
    EB.Extend(EV.BottomRow - 1, EP.Column);
    EB.EndBlock;
  end;
  BindingResult := krHandled;
end;

procedure TClassicBinding.ClassicMarkToViewTop(const Context: IOTAKeyContext; KeyCode: TShortCut;
  var BindingResult: TKeyBindingResult);
var
  EV: IOTAEditView;
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
begin
  EV := Context.EditBuffer.TopView;
  EP := EV.Position;
  EB := EV.Block;
  if (EB.StartingRow = EP.Row) and (EB.StartingColumn = EP.Column) then
  begin
//    EB.Style := btNonInclusive;
    EP.Move(EB.EndingRow, EB.EndingColumn);
    EB.EndBlock;
    EB.Extend(EV.TopRow, EP.Column);
    EB.BeginBlock;
  end else
  begin
    EB.Reset;
//    EB.Style := btNonInclusive;
    EB.EndBlock;
    EB.Extend(EV.TopRow, EP.Column);
    EB.BeginBlock;
  end;
  BindingResult := krHandled;
end;

procedure TClassicBinding.MarkToWordLeft(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
  EP: IOTAEditPosition;
  NewRow, NewColumn: Integer;
begin
  EB := Context.EditBuffer.EditBlock;
  EP := Context.EditBuffer.EditPosition;
  EP.Save;
  try
    EB.Save;
    try
      WordLeft(Context, KeyCode, BindingResult);
      NewRow := EP.Row;
      NewColumn := EP.Column;
    finally
      EB.Restore;
    end;
  finally
    EP.Restore;
  end;
  EB.Extend(NewRow, NewColumn);
  BindingResult := krHandled;
end;

procedure TClassicBinding.MarkToWordRight(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EB: IOTAEditBlock;
  EP: IOTAEditPosition;
  NewRow, NewColumn: Integer;
begin
  EB := Context.EditBuffer.EditBlock;
  EP := Context.EditBuffer.EditPosition;
  EP.Save;
  try
    EB.Save;
    try
      WordRight(Context, KeyCode, BindingResult);
      NewRow := EP.Row;
      NewColumn := EP.Column;
    finally
      EB.Restore;
    end;
  finally
    EP.Restore;
  end;
  EB.Extend(NewRow, NewColumn);
  BindingResult := krHandled;
end;

procedure TClassicBinding.ClassicMarkToBOF(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EV: IOTAEditView;
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
begin
  EV := Context.EditBuffer.TopView;
  EP := EV.Position;
  EB := EV.Block;
  if (EB.StartingRow = EP.Row) and (EB.StartingColumn = EP.Column) then
  begin
//    EB.Style := btNonInclusive;
    EP.Move(EB.EndingRow, EB.EndingColumn);
    EB.EndBlock;
    EP.Move(1, 1);
    EB.BeginBlock;
  end else
  begin
    EB.Reset;
//    EB.Style := btNonInclusive;
    EB.EndBlock;
    EP.Move(1, 1);
    EB.BeginBlock;
  end;
  BindingResult := krHandled;
end;

procedure TClassicBinding.ClassicMarkToEOF(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EV: IOTAEditView;
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
begin
  EV := Context.EditBuffer.TopView;
  EP := EV.Position;
  EB := EV.Block;
  if (EB.StartingRow = EP.Row) and (EB.StartingColumn = EP.Column) then
  begin
//    EB.Style := btNonInclusive;
    EP.Move(EB.StartingRow, EB.StartingColumn);
    EB.EndBlock;
    EP.MoveEOF;
    EB.BeginBlock;
  end else
  begin
    EB.Reset;
//    EB.Style := btNonInclusive;
    EB.EndBlock;
    EP.MoveEOF;
    EB.BeginBlock;
  end;
  BindingResult := krHandled;
end;

procedure TClassicBinding.MarkToRelativeHoriz(const Context: IOTAKeyContext; KeyCode: TShortCut;
  var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.ExtendRelative(0, Integer(Context.Context));
  BindingResult := krHandled;
end;

procedure TClassicBinding.MarkToRelativeVert(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.ExtendRelative(Integer(Context.Context), 0);
  BindingResult := krHandled;
end;

procedure TClassicBinding.ClassicMarkToBOL(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EV: IOTAEditView;
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  EndRow, EndCol: Integer;
begin
  EV := Context.EditBuffer.TopView;
  EP := EV.Position;
  EB := EV.Block;
  EB.Save;
  try
    EP.Save;
    try
      EP.MoveBOL;
      EndRow := EP.Row;
      EndCol := EP.Column;
    finally
      EP.Restore;
    end;
  finally
    EB.Restore;
  end;
  EB.Extend(EndRow, EndCol);
  BindingResult := krHandled;
end;

procedure TClassicBinding.ClassicMarkToEOL(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
var
  EV: IOTAEditView;
  EP: IOTAEditPosition;
  EB: IOTAEditBlock;
  EndRow, EndCol: Integer;
begin
  EV := Context.EditBuffer.TopView;
  EP := EV.Position;
  EB := EV.Block;
  EB.Save;
  try
    EP.Save;
    try
      EP.MoveEOL;
      EndRow := EP.Row;
      EndCol := EP.Column;
    finally
      EP.Restore;
    end;
  finally
    EB.Restore;
  end;
  EB.Extend(EndRow, EndCol);
  BindingResult := krHandled;
end;

procedure TClassicBinding.MarkToPageDown(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.ExtendPageDown;
  BindingResult := krHandled;
end;

procedure TClassicBinding.MarkToPageUp(const Context: IOTAKeyContext;
  KeyCode: TShortCut; var BindingResult: TKeyBindingResult);
begin
  Context.EditBuffer.EditBlock.ExtendPageUp;
  BindingResult := krHandled;
end;

end.
