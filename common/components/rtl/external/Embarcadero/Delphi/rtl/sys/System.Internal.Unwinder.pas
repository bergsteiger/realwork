{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Internal.Unwinder;

{
 Internal only interface onto the unwinder for supplementary diagnostic information.
 Not portable to different platforms, because it requires a PC mapped unwinder
 implementation currently.
}

interface

{$IFDEF LINUX}
const
  unwind = 'libcgunwind.so.1';
  {$EXTERNALSYM unwind}
{$ENDIF LINUX}
{$IFDEF MACOS}
const
  unwind = 'libcgunwind.1.0.dylib';
  {$EXTERNALSYM unwind}
{$ENDIF MACOS}

{$IFDEF MACOS}
const
  _U = '_';
  {$EXTERNALSYM _U}
{$ELSE !MACOS}
  _U = '';
  {$EXTERNALSYM _U}
{$ENDIF}


type
  { Opaque handle into a thread context that the unwinder API understands. }
  TUnwindContext = Pointer;
  { Opaque pointer into compiler specific unwind information for a procedure. }
  TUnwindProcedureInfo = Pointer;
  { Callback function used to obtain the initial context for unwind queries. }
  TQueryFunc = procedure(Context: TUnwindContext; UserData: Pointer); cdecl;

  {
   Stack trace element.  Currently contains only the name of the procedure in
   a given frame.  Count be updated to contain more, at the cost of additional
   development work in the unwinder libraries.
  }
  TStackTraceElement = class
  private
    FProcedureName: string;
  protected
    constructor Create(Name: string);
  public
    { The name of the procedure that is running at this frame. }
    property ProcedureName: string read FProcedureName;
  end;

  TStackTraceElements = array of TStackTraceElement;

  {
   Stack trace object.  Contains an array of frame elements.  Very primitive.
  }
  TStackTrace = class
  private
    FElements: TStackTraceElements;
  protected
    procedure AddElement(Name: string);
  public
    { The stack frame elements. }
    property Elements: TStackTraceElements read FElements;
  end;

{
 Crawls the stack, returning a stack trace from the invocation point.  The
 depth of the trace is currently hardcoded to in the implementation.  This
 should be fixed.  Returns the resulting stack trace.
}
function CrawlStack: TStackTrace;

implementation

{
 This is a callback initiator that enables us to get our paws on a
 local instance of a data structure known only to the unwinder library.

 The callback can then pass that internal data structure back into the
 unwinder to get information about the stack.
}
procedure BeginQuery(Func: TQueryFunc; UserData: Pointer); cdecl;
  external unwind name _U + '_BorUnwind_BeginQuery';

{
 Gets the compiler specific implementation handle for the unwind information
 for the stack frame that the given unwind context represents.  This handle
 can be passed to other APIs to provide information.
}
function GetProcedureInfo(Context: TUnwindContext): TUnwindProcedureInfo; cdecl;
  external unwind name _U + '_BorUnwind_GetProcedureInfo';

{
 Moves up one frame in the given stack context.  The stack context is modified.
 There is no way to move back down.  Returns 0 if there are no more frames, and
 1 otherwise.
}
function UpFrame(Context: TUnwindContext): Integer; cdecl;
  external unwind name _U + '_BorUnwind_UpFrame';

{
 Gets the procedure name, if any is available, for the given procedure information.
 In debug builds, this is available.  In a final shipping build, this may return
 nil.
}
function GetProcedureName(ProcInfo: TUnwindProcedureInfo): MarshaledAString; cdecl;
  external unwind name _U + '_BorUnwind_GetProcedureName';

constructor TStackTraceElement.Create(Name: string);
begin
  FProcedureName := Name;
end;

{
 Adds an element to the stack trace.  Very primitive - we're only tracking
 names right now.
}
procedure TStackTrace.AddElement(Name: string);
var
  Idx: Integer;
begin
  Idx := Length(FElements);
  SetLength(FElements, Idx + 1);
  FElements[Idx] := TStackTraceElement.Create(Name);
end;

type
  PTStackTrace = ^TStackTrace;

{
 Helper function that is the callback function we pass to BeginQuery to get the
 stack trace going.
}
procedure StackCrawlHelper(Context: TUnwindContext; UserData: Pointer); cdecl;
var
   PI: TUnwindProcedureInfo;
   name: String;
   pname: MarshaledAString;
   trace: TStackTrace;
   I: Integer;
begin
  trace := TStackTrace.Create;
  for I := 1 to 3 do
  begin
    PI := GetProcedureInfo(Context);
    pname := GetProcedureName(PI);
    name := string(pname);
    trace.AddElement(name);
    UpFrame(Context);
  end;
  PTStackTrace(UserData)^ := trace;
end;

function CrawlStack: TStackTrace;
var
  Trace: TStackTrace;
begin
  BeginQuery(StackCrawlHelper, @Trace);
  Result := Trace;
end;

end.
