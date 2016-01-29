{ ********************************************************************* }
{                                                                       }
{               Gnostice mouse wheel message re-director                }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }

{$I gtDefines.inc}

unit gtMouseWheelRectifier;

interface

  { Simply add this unit to your uses list to receive mouse wheel
    messages at the control the mouse is over (mouse cursor within its
    bounds) through the DoMouseWheel method, even if the control does not
    have the keyboard focus.

    Only one of the units or controls in your application need to use this
    unit to get this benefit across all controls of the application,
    but it does not matter if multiple units use this unit. Care has been
    taken to avoid duplication of the redirection process.
  }

implementation

uses
  Windows, Messages, Classes, Controls, Forms;

var
  MouseHookHandle: HHOOK = 0;

type
  THackWinControl = class(TWinControl);

  {$IFNDEF gtDelphi2009Up}
    PMouseHookStructEx = ^TMouseHookStructEx;
    {$EXTERNALSYM tagMOUSEHOOKSTRUCTEX}
    tagMouseHookStructEx = packed record
        MouseHookStruct: TMouseHookStruct;
        mouseData: DWord;
    end;
    TMouseHookStructEx = tagMouseHookStructEx;
  {$ENDIF}

function DoCtrlMouseWheel(ACtrl: TWinControl; AWheelDelta: Integer;
  APoint: TPoint): Boolean;
var
  LKeyState: TKeyboardState;
  LShiftState: TShiftState;
begin
  GetKeyboardState(LKeyState);
  LShiftState := KeyboardStateToShiftState(LKeyState);
  with THackWinControl(ACtrl) do
  begin
    Result := DoMouseWheel(LShiftState, AWheelDelta, APoint)
    // If control did not override DoMouseWheel, try DoMouseWheelUp/DoMouseWheelDown

//    if not Result then
//    begin
        //Todo: Call DoMouseWheelUp/DoMouseWheelDown appropriately
//    end;
  end;
end;

function MouseHookProc(Code: Integer; MessageID: WPARAM;
  MsgData: LPARAM): LRESULT stdcall;
var
  LCtrl: TWinControl;
  LMsgStruct: TMouseHookStructEx;
  LWheelDelta: Integer;
  LPt: TPoint;
begin
  // Code less than 0, must pass it on to CallNextHookEx without further processing
  // That's what the WinAPI reference says
  // And when Code >= 0, we'll process only mouse wheel messages
  if (Code >= 0) and (MessageID = WM_MOUSEWHEEL) then
  begin
    LMsgStruct := PMouseHookStructEx(MsgData)^;

    // Get the control under the mouse cursor
    LPt := LMsgStruct.MouseHookStruct.pt;
    LCtrl := FindVCLWindow(LPt);

    if LCtrl <> nil then
    begin
      // Assuming that the wheel delta won't be beyond -120..120 and casting to
      // ShortInt calls for trouble... the erratic mouse wheel scroll.
      // 120 is the value for rolling the wheel one click (detent)
      // Accumulated Delta can be beyond the -128..127 range, hence casting to
      // ShortInt gives improper delta values.
      // Either declare var as SmallInt or cast to SmallInt
      LWheelDelta := SmallInt(LMsgStruct.mouseData shr 16);

      // Call the control's DoMouseWheel method bypassing other message handling
      // Note: control needs to implement appropriate DoMouseWheel.. methods
      if DoCtrlMouseWheel(LCtrl, LWheelDelta, LPt) then
      begin
        // The control we sent the message to handled the message,
        // so don't send it down the chain
        Result := 1;
        Exit;
      end;
    end;
  end;
  // We didn't process it. Send it down the chain
  Result := CallNextHookEx(MouseHookHandle, Code, MessageID, MsgData);
end;

initialization
  // Register a mouse hook to intercept all mouse messages
  // If it's not already been done
  if MouseHookHandle = 0 then
    MouseHookHandle := SetWindowsHookEx(WH_MOUSE, @MouseHookProc,
      HInstance, GetCurrentThreadId);

finalization
  // Unregister the mouse hook
  if MouseHookHandle <> 0 then
    UnhookWindowsHookEx(MouseHookHandle);

end.
