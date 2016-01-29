unit afwBaseControl;

interface

uses
 l3IntfUses
 , afwControlPrim
 , l3InternalInterfaces
 , l3Interfaces
 , afwInterfaces
 , Controls
 , l3WinControlCanvas
 , Classes
 , Forms
 , StdCtrls
 , afwTypes
 , l3IID
 , Messages
 , l3Units
 , l3Types
 , Windows
;

type
 TafwBaseControl = class(TafwControlPrim, Il3CommandTarget, Il3DropTarget, Il3ChangeRecipient, IafwControl, IafwMenuUnlockedPostBuild)
  {* ��������� ��������� IUnknown � ������� ���������� ������. ����� ������������� �������� Canvas ��� ���������� ��������� ��������� - Paint. ������������� ���������� ����������� ��� ��������� drag and drop }
  function GetCommands: TafwCommands;
  function ProcessMessage(var aMessage: TMessage;
   aTime: Cardinal): Boolean;
  function DoProcessCommand(Cmd: Tl3OperationCode;
   aForce: Boolean;
   aCount: Integer): Boolean;
  procedure DoChanging;
  procedure DoChanged;
  function IsInChange: Boolean;
  procedure ChangeNotifyOff;
   {* ������������� ����������� �� ��������� ���������. }
  procedure ChangeNotifyOn(aChange: Boolean);
   {* �������������� ����������� �� ��������� ���������. }
  procedure UpdateDragImage(const aPoint: TPoint);
  function DoDoDragOver(const aData: IDataObject;
   const aPoint: TPoint): Boolean;
  function DoGetAcceptableFormats: Tl3ClipboardFormats;
  function DoDoDrop(aFormat: Tl3ClipboardFormat;
   const aMedium: Tl3StoragePlace;
   var dwEffect: Integer): Boolean;
  function DoKeys2Effect(aKeys: Integer): Integer;
  procedure DoDoDragLeave;
  procedure DoUpdateScrollRange(WhatUpdate: TafwScrollBars);
  procedure RevokeDragDrop;
  procedure WMDestroy(var Message: TWMDestroy);
  function DoDragDrop(const aDataObject: IDataObject;
   anEffect: Integer;
   out theEffect: Integer): Integer;
  procedure FreeCanvas;
  function GetCaret: Il3Caret;
  procedure DoDrawSub(aSubTarget: TObject;
   const Canvas: Il3Canvas;
   const R: Tl3Rect;
   SubType: Tl3Handle;
   aSub: TObject);
  procedure DoDrawSpecialChange(Sender: TObject);
  procedure Paint(const CN: Il3Canvas);
   {* ��������� ��������� �������� ���� ������������ �������� }
  function InUpdating: Boolean;
  procedure ShowMenu(const aPoint: TPoint); overload;
  procedure ShowMenu; overload;
  procedure CMCOLORCHANGED(var Msg: TMessage);
  procedure CMCtl3DChanged(var Message: TMessage);
  procedure AdjustColors(Bevel: TBevelCut;
   var TopColor: Tl3Color;
   var BottomColor: Tl3Color);
  function DataCodePage: Integer;
   {* ��������� ������ � ��� �����, ���� ���������� ������� }
  function DropFormattedData(aFormat: Tl3ClipboardFormat;
   const aData: IDataObject): Boolean;
  function GetAcceptableFormatsFor(const aData: IDataObject): Tl3ClipboardFormats;
  procedure SetCommands(const aCommands: array of AnsiString;
   out theCommands: TafwCommands);
  function PasteFromClipboard(aFormat: Tl3ClipboardFormat;
   const aData: IDataObject): Boolean;
   {* �������� ����� �� ������ ������ � ������� aFormat }
  function Paste: Boolean;
   {* �������� �� ������ ������. }
  function COMQueryInterface(const IID: Tl3GUID;
   out Obj): Tl3HResult;
  procedure CancelHint;
  procedure ActivateHint(const aPt: TPoint); overload;
  procedure ActivateHint; overload;
  procedure DoMenuUnlockedFixUp;
  function IsMenuLocked: Boolean;
  procedure DoAfterCreateCanvas;
   {* ����������� ����� �������� ����� ��� ���������, ��������, Zoom'� � �����������. }
  procedure WMSetFocus(var Msg: TWMSetFocus);
  procedure WMKillFocus(var Msg: TWMKillFocus);
  function GetAcceptableFormats: Tl3ClipboardFormats;
   {* ������ ���������� ��������. }
  function DoDrop(aFormat: Tl3ClipboardFormat;
   const aMedium: Tl3StoragePlace;
   var dwEffect: Integer): Boolean;
  function DoDragOver(const aData: IDataObject;
   const aPoint: TPoint): Boolean;
  procedure DoDragEnter(const aData: IDataObject;
   const aPoint: TPoint);
  procedure DoDragLeave;
  function Keys2Effect(aKeys: Integer): Integer;
  function ProcessCommand(Cmd: Tl3OperationCode;
   aForce: Boolean;
   aCount: Integer): Boolean;
  procedure UpdateScrollRange(WhatUpdate: TafwScrollBars);
  procedure Changing;
   {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
  procedure Changed;
   {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
  procedure MenuUnlockedFixUp;
  function IsA(anObj: TObject): Boolean;
 end;//TafwBaseControl
 
implementation

uses
 l3ImplUses
 , l3Operations
 , l3Bitmap
 , l3SysUtils
 , l3DropTarget
 , l3DropSource
 , l3Base
 , afwFacade
 , afwVCL
 , Graphics
 , l3Chars
 , afwHintManager
 , k2OperationContainer
 , l3CustomControlCanvas
 , TtfwClassRef_Proxy
 , SysUtils
;

end.
