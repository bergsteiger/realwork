unit tcInterfaces;

interface

uses
 l3Interfaces
 ;

type
 ItcItem = interface(IUnknown)
 ['{469369EC-3036-43D1-9830-0E89B5B3A0C2}']
  function pm_GetID: Il3CString;
  function pm_GetCaption: Il3CString;
  procedure pm_SetCaption(const aValue: Il3CString);
  property ID: Il3CString
    read pm_GetID;
  property Caption: Il3CString
    read pm_GetCaption
    write pm_SetCaption;
 end;

 ItcItemList = interface(IUnknown)
 ['{A8EFC637-063F-44CD-9C3F-6B2FA42469D1}']
  function pm_GetCount: Integer;
  function pm_GetItem(Index: Integer): ItcItem;
  function Add(const anID: Il3CString): ItcItem;
  procedure AddExisting(const anItem: ItcItem);
  property Count: Integer
    read pm_GetCount;
  property Item[Index: Integer]: ItcItem
    read pm_GetItem;
 end;

 ItcOperation = interface(ItcItem)
 ['{55D1D5B9-94B8-47DF-8289-E8CB5FE7F768}']
 end;

 ItcOperationsList = interface(IUnknown)
 ['{4E35BE73-8F48-43C6-9AFA-F741CA4CA652}']
  function pm_GetCount: Integer;
  function pm_GetOperation(Index: Integer): ItcOperation;
  function Add(const anID: Il3CString): ItcOperation;
  procedure AddExisting(const anOperation: ItcOperation);
  property Count: Integer
    read pm_GetCount;
  property Operation[Index: Integer]: ItcOperation
    read pm_GetOperation;
 end;

 ItcToolBarsList = interface;

 ItcToolbar = interface(ItcItem)
 ['{ADB62DA2-6D4B-402D-869B-CD526128E243}']
  function pm_GetChildToolBars: ItcToolBarsList;
  function pm_GetOperations: ItcOperationsList;
  function pm_GetEditable: Boolean;
  procedure pm_SetEditable(aValue: Boolean);
  property Editable: Boolean
    read pm_GetEditable
    write pm_SetEditable;
  property Operations: ItcOperationsList
    read pm_GetOperations;
  property ChildToolBars: ItcToolBarsList
    read pm_GetChildToolBars;
 end;

 ItcToolBarsList = interface(IUnknown)
 ['{50884580-768D-4D22-8C3E-7DBEB891EDA6}']
  function pm_GetCount: Integer;
  function pm_GetToolBar(Index: Integer): ItcToolbar;
  function Add(const anID: Il3CString): ItcToolBar;
  procedure AddExisting(const aToolBar: ItcToolBar);
  property Count: Integer
    read pm_GetCount;
  property ToolBar[Index: Integer]: ItcToolBar
    read pm_GetToolBar;
 end;

 ItcAddedToolBar = interface(ItcItem)
 ['{D41B54AE-B969-41DC-B20E-0B51451D77BD}']
  function pm_GetToolBar: ItcToolBar;
  procedure pm_SetToolBar(const aToolBar: ItcToolBar);
  property ToolBar: ItcToolBar
    read pm_GetToolBar
    write pm_SetToolBar;
 end;

 ItcAddedToolBarsList = interface(IUnknown)
 ['{C5C56F34-59B3-4140-9131-94FAE5E7BAF6}']
  function pm_GetCount: Integer;
  function pm_GetToolBar(Index: Integer): ItcAddedToolBar;
  function Add(const anID: Il3CString): ItcAddedToolBar;
  property Count: Integer
    read pm_GetCount;
  property ToolBar[Index: Integer]: ItcAddedToolBar
    read pm_GetToolBar;
 end;

 TtcEditableChange = (ecNone, ecBecomeEditable, ecRevokeEditable);

 ItcChangedToolBar = interface(ItcAddedToolBar)
 ['{F969F1B3-40FA-4B5B-BA7D-B8022EB61BEE}']
  function pm_GetEditableChange: TtcEditableChange;
  procedure pm_SetEditableChange(aValue: TtcEditableChange);
  function pm_GetOldCaption: Il3CString;
  procedure pm_SetOldCaption(const aValue: Il3CString);
  function pm_GetDeletedChildren: ItcToolBarsList;
  function pm_GetAddedChildren: ItcToolBarsList;
  function pm_GetDeletedOperations: ItcOperationsList;
  function pm_GetAddedOperations: ItcOperationsList;
  property EditableChange: TtcEditableChange
    read pm_GetEditableChange
    write pm_SetEditableChange;
  property OldCaption: Il3CString
    read pm_GetOldCaption
    write pm_SetOldCaption;
  property DeletedChildren: ItcToolBarsList
    read pm_GetDeletedChildren;
  property AddedChildren: ItcToolBarsList
    read pm_GetAddedChildren;
  property DeletedOperations: ItcOperationsList
    read pm_GetDeletedOperations;
  property AddedOperations: ItcOperationsList
    read pm_GetAddedOperations;
 end;

 ItcChangedToolBarsList = interface(IUnknown)
 ['{BFBDFF59-63C7-4479-A770-783936B95232}']
  function pm_GetCount: Integer;
  function pm_GetToolBar(Index: Integer): ItcChangedToolBar;
  function Add(const anID: Il3CString): ItcChangedToolBar;
  property Count: Integer
    read pm_GetCount;
  property ToolBar[Index: Integer]: ItcChangedToolBar
    read pm_GetToolBar;
 end;

implementation

end.
