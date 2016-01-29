unit elCustomEdit;

interface

uses
 l3IntfUses
 , evCustomEdit
 , nevTools
 , l3Interfaces
 , Classes
 , Messages
 , evEditorWithOperations
 , nevBase
 , l3InternalInterfaces
 , l3Core
 , Controls
 , l3StringIDEx
;

type
 TelCustomEdit = class(TevCustomEdit, IelEditStrings)
  procedure Change;
  procedure DoChange;
  function DeleteSelection(aFakeDelete: Boolean): Il3CString;
  procedure TriggerTextChangedEvent(Sender: TObject;
   var aText: Il3CString;
   var Allow: Boolean);
  procedure UnSelect;
  procedure SelectAll;
  procedure SetSelText(const aValue: Il3CString);
  procedure ClearUndoRedoLists;
  procedure CheckDoc;
  procedure TriggerCaretXChangedEvent(var Value: Integer;
   var Allow: Boolean);
  procedure NotifyPosChange;
  procedure PaintMistakes(const aWords: Il3StringsEx);
  procedure WMNCPaint(var Message: TWMNCPaint);
  function ParagraphStrings: Il3CString;
 end;//TelCustomEdit
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , Forms
 , l3Const
 , evSearch
 , evdStyles
 , evTypes
 , evdTypes
 , k2Tags
 , l3Units
 , Graphics
 , Windows
 , l3MessageID
 , TtfwClassRef_Proxy
;

end.
