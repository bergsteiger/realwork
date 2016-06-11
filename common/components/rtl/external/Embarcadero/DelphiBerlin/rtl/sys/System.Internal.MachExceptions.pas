{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Internal.MachExceptions;

{
 <code>MachExceptions</code> contains the OS specific code for setting up Mach
 exception handlers.  These handlers catch hardware exceptions, such as
 floating point errors, memory access violations, and illegal instructions.<p>

 The Mach exception API is used for these exceptions instead of sigaction and
 friends because of GDB issues.  There is a long standing bug with GDB that
 prevents signal handlers for the above exceptions from being invoked when
 the child process is run under GDB.<p>

 Note that Ctrl-C handling doesn't come through this layer of support.  The
 Mach exception handling ports never see such user interrupt methods.  Instead
 we use the POSIX signal APIs to deal with those.  GDB is well behaved for those
 signals.<p>

 On initialization, the exception handling code allocates a Mach exception
 handling port, and spins up a pthread to watch that port.  Mach uses a message
 passing model to inform the watcher thread of exceptions on other threads.
 The watcher thread processes the exception, and then modifies the pending
 thread to cause it to transfer control to the RTL, where somewhat more
 platform independent code can take over to raise a standard language
 exception.<p>
}

interface

{
 Initializes the Mach exception handling system.  This will allocate a
 Mach exception port, and spin up a POSIX thread.  This API should only
 be called once per process.
}
procedure MachExceptionsInit;

{
 Shuts down the Mach exception handling system for the task.  This API
 should only be called once per process.
}
procedure MachExceptionsShutdown;

implementation

uses Macapi.Mach, System.SysUtils, Posix.SysTypes, Posix.Pthread, Posix.Sched, System.Internal.ExcUtils, System.SysConst;


const
{$IFDEF UNDERSCOREIMPORTNAME}
  _PU = '_';
{$ELSE}
  _PU = '';
{$ENDIF}  
type
  NDR_record_t = record
    mig_vers,
    if_vers,
    reserved1,
    mig_encoding,
    int_rep,
    char_rep,
    float_rep,
    reserved2 : UInt8;
  end;

const
  NDR_PROTOCOL_2_0 = 0;
  NDR_INT_LITTLE_ENDIAN = 1;
  NDR_CHAR_ASCII = 0;
  NDR_FLOAT_IEEE = 0;

  NDR_record : NDR_record_t = (
    mig_vers: 0;            // mig_reserved */
    if_vers:  0;            // mig_reserved */
    reserved1: 0;           // mig_reserved */
    mig_encoding: NDR_PROTOCOL_2_0;
    int_rep: NDR_INT_LITTLE_ENDIAN;
    char_rep:  NDR_CHAR_ASCII;
    float_rep: NDR_FLOAT_IEEE;
    reserved2: 0
  );

type
  mach_msg_port_descriptor_t = record
    name: mach_port_t;     // 16
    pad1: mach_msg_size_t; // 16
    pad2: uint16;          // 16
    disposition: uint8;    //  8
    _type: uint8;          //  8
  end;

  {
   The reply message structure for Mach messages.  The actual maximum
   payload size for messages is not defined in Mach.  The values below
   are drawn from the source code for Xnu, apparently.  These values
   were obtained from an example found on the web.
  }
  MachMsgReply = record
    header: mach_msg_header_t;
    data: array [0..255] of Byte;
  end;
  {
   The send message structure for Mach messages.  See the comment
   on <code>MachMsgReply</code> for information about the structure size.
  }
  MachMsgSend = record
    header: mach_msg_header_t;
    body: mach_msg_body_t;
    thread: mach_msg_port_descriptor_t;
    task: mach_msg_port_descriptor_t;
    NDR: NDR_record_t;
    exception: exception_type_t;
    codeCnt: mach_msg_type_number_t;
    code: array[0..1] of Int32;
    flavor: Int32;
    old_stateCnt: mach_msg_type_number_t;
{$IF     Defined(CPUARM)}
    old_state: array[0..143] of natural_t; // 144*4 = 576bytes
{$ELSEIF Defined(CPUX86) or Defined(CPUX64)}
    old_state: array[0..223] of natural_t;
{$ENDIF }
  end;

{
 This is our POSIX thread function.  It watches for messages on the exception
 port, and dispatches them as needed.<p>

 Some Mach exception APIs are used here, and these can fail.  If they do, we
 have no really viable options for recovering, and we just abort the task.
 Presumably, the relevant APIs can only fail under some catastrophic
 circumstances, in which case, the definition of 'recovery' would be pretty
 subjective anyway.
}
{$IF defined(CPUARM)}
// Should be move into Macapi.Mach.pas (from mig_errors.h)
type
  mig_reply_error_t = record
    Head: mach_msg_header_t;
    NDR: NDR_record_t;
    RetCode: kern_return_t;
  end;
  Pmig_reply_error_t = ^mig_reply_error_t;

const
  MIG_BAD_ID = -303;

type
  Pmach_msg_header_t = ^mach_msg_header_t;

  TReply_exception_raise_state_identity = record
    Head: mach_msg_header_t;
    NDR: NDR_record_t;
    RetCode: kern_return_t;
    flavor: Int32;
    new_stateCnt: Integer;
    new_state: array[0..223] of natural_t;
  end;
  PReply = ^TReply_exception_raise_state_identity;

function catch_exception_raise_state_identity(
  ExceptionPort: mach_port_name_t;
  Thread: mach_port_t;
  Task: mach_port_t;
  ExceptionType: exception_type_t;
  Code: exception_data_t;
  CodeCount: mach_msg_type_number_t;
  var Flavor: Integer;
  OldState: thread_state_t;
  OldStateCount: Integer;
  NewState: thread_state_t;
  var NewStateCount: Integer): kern_return_t; cdecl; forward;


procedure internal_exception_raise_state_identity(
  InHeaderP: Pmach_msg_header_t;
  OutHeaderP: Pmach_msg_header_t);
type
  PMachMsgSend = ^MachMsgSend;
var
  InMsg: PMachMsgSend;
  OutMsg: PReply;
begin
  InMsg :=  PMachMsgSend(InHeaderP);
  OutMsg := PReply(OutHeaderP);

  OutMsg.new_stateCnt := 224;

  OutMsg.RetCode :=
    catch_exception_raise_state_identity(
     InMsg.Header.msgh_local_port,
     InMsg.thread.name,
     InMsg.task.name,
     InMsg.exception,
     @InMsg.code[0],
     InMsg.codeCnt,
     InMsg.flavor,
     @InMsg.old_state[0],
     InMsg.old_stateCnt,
     @OutMsg.new_state[0],
     OutMsg.new_stateCnt );

  OutMsg.NDR := NDR_record;
  OutMsg.flavor := InMsg.flavor;
  OutMsg.Head.msgh_size := sizeof(TReply_exception_raise_state_identity) - (sizeof(natural_t) * 224) + (sizeof(natural_t) * OutMsg.new_stateCnt);
end;

function ExcThread(Parameter: Pointer): Pointer; cdecl;
var
  R: mach_msg_return_t;
  Reply: MachMsgReply;
  Msg: MachMsgSend;
  Param: sched_param;
  Policy: Integer;
begin
  {
    Raise exception handler thread priority to maximize
    its chances to set exception port to original value
    before any OS exception occurs in any application thread 
    (see below). This thread sleeps most of its lifetime, so
    overall application performance will not degrade.
  }
  if pthread_getschedparam(pthread_self(), Policy, Param) = 0 then
  begin
    Param.sched_priority := 47;
    pthread_setschedparam(pthread_self(), Policy, Param);
  end;

  while true do
  begin
    Msg.header.msgh_local_port := RTLExceptionPort;
    Msg.header.msgh_size := sizeof(Msg);
    R := mach_msg(Msg.header, MACH_RCV_MSG or MACH_RCV_LARGE or MACH_RCV_INTERRUPT,
                  0, SizeOf(Msg), RTLExceptionPort,
                  MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
    { 
      We (should) get MACH_RCV_INTERRUPTED when LLDB continues execution
      after evaluating at least one function call on target. To handle
      OS exceptions, which may happen during function call, LLDB replaces
      RTL mach exception port with debugserver's (see __lldb_fcall_wrapper)
    }      
    if R = MACH_RCV_INTERRUPTED then
    begin
      task_set_exception_ports(mach_task_self(), EXC_MASK_BAD_ACCESS or EXC_MASK_ARITHMETIC or EXC_MASK_BAD_INSTRUCTION, 
                               RTLExceptionPort, EXCEPTION_STATE_IDENTITY, MACHINE_THREAD_STATE);
      continue;
    end
    else if R <> MACH_MSG_SUCCESS then
      abort;
  
    Reply.header.msgh_bits := Msg.header.msgh_bits and $FF;
    Reply.header.msgh_remote_port := Msg.header.msgh_remote_port;
    Reply.header.msgh_size := sizeof(mig_reply_error_t);
    Reply.header.msgh_local_port := MACH_PORT_NULL;
    Reply.header.msgh_id := Msg.header.msgh_id + 100;

    // from mach\exc.h
    // exception_raise_state_identity, 2403
    if (Msg.header.msgh_id <> 2403) then
    begin
      Pmig_reply_error_t(@Reply.header).NDR := NDR_record;
      Pmig_reply_error_t(@Reply.header).RetCode := MIG_BAD_ID;
      abort;
    end;

    internal_exception_raise_state_identity(@Msg.header, @Reply.header);

    R := mach_msg(Reply.header, MACH_SEND_MSG, Reply.header.msgh_size,
                  0, MACH_PORT_NULL, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);

    if R <> MACH_MSG_SUCCESS then
      abort;
  end;
end;
{$ELSEIF defined(CPUX86) or defined(CPUX64)}
function ExcThread(Parameter: Pointer): Pointer; cdecl;
var
  R: mach_msg_return_t;
  Reply: MachMsgReply;
  Msg: MachMsgSend;
begin
//  Writeln('Mach Exception thread started');
  while true do
  begin
    Msg.header.msgh_local_port := RTLExceptionPort;
    Msg.header.msgh_size := sizeof(Msg);
    R := mach_msg(Msg.header, MACH_RCV_MSG or MACH_RCV_LARGE,
                  0, SizeOf(Msg), RTLExceptionPort,
                  MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
    if R <> MACH_MSG_SUCCESS then
      abort;
    {
     exc_server is not documented anywhere, really.  It isn't defined
     in any Mach header files.  It handles all the book-keeping on the
     Mach messages to dispatch messages to the appropriate catch_*
     APIs, which the client application may have defined.
    }
    if not exc_server(Msg.header, Reply.header) then
      abort;
    R := mach_msg(Reply.header, MACH_SEND_MSG, Reply.header.msgh_size,
                  0, MACH_PORT_NULL, MACH_MSG_TIMEOUT_NONE, MACH_PORT_NULL);
    if R <> MACH_MSG_SUCCESS then
      abort;
  end;
end;
{$ENDIF }

procedure MachExceptionsInit;
var
  Task: mach_port_t;
  KRes: kern_return_t;
  Mask: exception_mask_t;
  Attr: pthread_attr_t;
  Thread: pthread_t;
begin
//  Writeln('Initializing Mach Exceptions');
  Task := mach_task_self;
  KRes := mach_port_allocate(Task, MACH_PORT_RIGHT_RECEIVE, RTLExceptionPort);
  if KRes <> MACH_MSG_SUCCESS then
    raise Exception.CreateRes(@SOSExceptionHandlingFailed);
  KRes := mach_port_insert_right(Task, RTLExceptionPort, RTLExceptionPort, MACH_MSG_TYPE_MAKE_SEND);
  if KRes <> MACH_MSG_SUCCESS then
    raise Exception.CreateRes(@SOSExceptionHandlingFailed);
  Mask := EXC_MASK_BAD_ACCESS or EXC_MASK_ARITHMETIC or EXC_MASK_BAD_INSTRUCTION;
  KRes := OrigEHData.Get(Task, Mask);
  if KRes <> MACH_MSG_SUCCESS then
    raise Exception.CreateRes(@SOSExceptionHandlingFailed);
  KRes := task_set_exception_ports(Task, Mask, RTLExceptionPort, EXCEPTION_STATE_IDENTITY, MACHINE_THREAD_STATE);
  if KRes <> MACH_MSG_SUCCESS then
    raise Exception.CreateRes(@SOSExceptionHandlingFailed);

  if pthread_attr_init(Attr) <> 0 then
    raise Exception.CreateRes(@SOSExceptionHandlingFailed);
  if pthread_attr_setdetachstate(Attr, PTHREAD_CREATE_DETACHED) <> 0 then
    raise Exception.CreateRes(@SOSExceptionHandlingFailed);
  if pthread_create(Thread, Attr, @ExcThread, nil) <> 0 then
    raise Exception.CreateRes(@SOSExceptionHandlingFailed);  
{$IFDEF MACOS}
  ExcThreadPort := pthread_mach_thread_np(Thread);
{$ENDIF MACOS}
  pthread_attr_destroy(Attr);
end;

procedure MachExceptionsShutdown;
begin
  {
   We're keeping this as a placeholder in case we do decide to shut down the
   POSIX thread watching the exception ports, or free up the Mach resources
   for the exception ports.  Currently, we don't see the need for it, so we
   will allow the OS to dispose of those resources when it shuts down the
   task.
  }
end;

{
 Some floating point status word constants.  These same constants
 work for the MXCSR, too.
}
const
  PRECISION_MASK = 1 shl 5;
  UNDERFLOW_MASK = 1 shl 4;
  OVERFLOW_MASK = 1 shl 3;
  ZERODIVIDE_MASK = 1 shl 2;
  DENORMAL_MASK = 1 shl 1;
  INVALIDOP_MASK = 1 shl 0;

{
 Floating point exceptions for both the FPU and SSE are masked and have
 their status represented in the same bit order, but at different bit offsets
 in their respective status and control words.  The FPU has the floating point
 status word, and the floating point control word.  The control word holds the
 exception masks, and the status word holds the signalled exceptions.  In both
 words, the bits of interest are 0-5, which is convenient.

 The SSE unit has just the one control/status word, with mask and status bits
 in different bit positions, but in the same bit order as for the FPU control
 and status words.  So we can use a single function to test for the masking
 state and status state of a given floating point exception by just passing
 shifted bits of the various words to this little support function.

 @param StatusBits - holds the floating point exception status bits.
 These are bits 0-5 of the respective status registers.
 @param Mask - holds bits 0-5 of the floating point mask bits.  If a bit in the
 mask is 1, then it means that exception is masked.
}
function UnmaskedExceptions(StatusBits: UInt16; Mask: UInt16): UInt16;
begin
  Result := StatusBits and (not Mask);
end;

procedure __dbk_mach_exception(Thread: mach_port_t); export;
begin
end;

exports
  __dbk_mach_exception;

{
 This function will be dispatched to from <code>exc_server</code>.  This is
 where we decode the exception, and set up the dispatch to the RTL on the
 faulting thread.<p>

 We call Mach support methods to inquire into the thread state.  It's extremely
 unlikely that these could ever fail, but if they do, then we have no way to
 recover.  In that event, we return a code which will cause the Mach exception
 server to kill off the task.

 The name of this function, as it is exported is important.  See the comment
 at the export statement at the end of this unit for more detail.
}
function catch_exception_raise_state_identity(
  ExceptionPort: mach_port_name_t;
  Thread: mach_port_t;
  Task: mach_port_t;
  ExceptionType: exception_type_t;
  Code: exception_data_t;
  CodeCount: mach_msg_type_number_t;
  var Flavor: Integer;
  OldState: thread_state_t;
  OldStateCount: Integer;
  NewState: thread_state_t;
  var NewStateCount: Integer): kern_return_t; cdecl;
{$IF   defined(CPUARM)}
var
  ExceptionStateCount: mach_msg_type_number_t;
{$IF     Defined(CPUARM32)}
  ExceptionState: arm_exception_state32_t;
  ThreadState: Parm_thread_state32_t;
{$ELSEIF Defined(CPUARM64)}
  ExceptionState: arm_exception_state64_t;
  ThreadState: Parm_thread_state64_t;
{$ENDIF}
  KRes: kern_return_t;
  ExcCode: Integer;
  NextInst: UIntPtr;
begin
  __dbk_mach_exception(Thread);
  ExceptionStateCount := sizeof(ExceptionState) div sizeof(natural_t);
{$IF     Defined(CPUARM32)}
  KRes := thread_get_state(Thread, ARM_EXCEPTION_STATE,
                           thread_state_t(@ExceptionState), ExceptionStateCount);
{$ELSEIF Defined(CPUARM64)}
  KRes := thread_get_state(Thread, ARM_EXCEPTION_STATE64,
                           thread_state_t(@ExceptionState), ExceptionStateCount);
{$ENDIF}
  if KRes <> KERN_SUCCESS then
  begin
    // Fatal
    Result := KERN_INVALID_ARGUMENT;
    Exit;
  end;

{$IF     Defined(CPUARM32)}
  if OldStateCount = ARM_UNIFIED_THREAD_STATE_COUNT then
    ThreadState := @(Parm_unified_thread_state_t(OldState)^.ts_32)
  else
    ThreadState := Parm_thread_state32_t(OldState);
{$ELSEIF Defined(CPUARM64)}
  ThreadState := @(Parm_unified_thread_state_t(OldState)^.ts_64);
{$ENDIF}

  Result := KERN_SUCCESS;
  if ExceptionType = EXC_BAD_ACCESS then
  begin
    {
     Memory access violation.  E.g. segv.  We don't care, really, what the
     actual fault was - they all get dispatched the same way to the user.
    }
    ExcCode := Integer(System.reAccessViolation);
  end
  else if ExceptionType = EXC_BAD_INSTRUCTION then
  begin
    {
     Illegal instruction, or privileged instruction.  We don't discriminate.
    }
    ExcCode := Integer(System.rePrivInstruction);
  end
  else
  begin
    ExcCode := 0;
    { This can't happen. We do the equivalent of asserting here.  If we return
      this value, the kernel will take down the process.
    }
    Result := KERN_INVALID_ARGUMENT;
  end;

  if DeferSegmentationViolation and (ExceptionType = EXC_BAD_ACCESS) then
  begin
    SIGSEGVIssued := True;
    SIGSEGVFaultInstPtr := ThreadState.__PC;
    SIGSEGVFaultAddrPtr := ExceptionState.__far;

    NextInst := ThreadState.__PC;
{$IF     Defined(CPUARM32)}
    if (ThreadState.__cpsr and $20) = 0 then // $20 is Thumb execution state bit
      NextInst := NextInst + 4 // ARM mode.
    else
      NextInst := NextInst + CalcThumbInstructionSize(NextInst);
{$ELSEIF Defined(CPUARM64)}
    NextInst := NextInst + 4;
{$ENDIF}
    ThreadState.__PC := NextInst;
  end
  else
  begin
    {
     Now we set up the thread state for the faulting thread so that when we
     return, control will be passed to the exception dispatcher on that thread,
     and this POSIX thread will continue watching for Mach exception messages.
     See the documentation at <code>DispatchMachException()</code> for more
     detail on the parameters loaded in EAX, EDX, and ECX.
    }
{$IF     Defined(CPUARM32)}
    ThreadState.__R[0] := ThreadState.__PC;
    ThreadState.__R[1] := ExceptionState.__far;
    ThreadState.__R[2] := ExcCode;
    // r7 is a frame pointer on ARM-v7
    if PCardinal(ThreadState.__R[7] + 4)^ = ThreadState.__LR then
      ThreadState.__LR := ThreadState.__PC;
    ThreadState.__PC := UIntPtr(@SignalConverter);
{$ELSEIF Defined(CPUARM64)}
    ThreadState.__x[0] := ThreadState.__pc;
    ThreadState.__x[1] := ExceptionState.__far;
    ThreadState.__x[2] := ExcCode;
    {
      There are 3 possible cases, where runtime error can occur:
        a) Leaf function (function which doesn't have frame and doesn't call any subroutine)
        b) Non-leaf function, before any subroutine has been called
        c) Non-leaf function, after at least one subroutine has been called
      Let's use following abbreviations:
        lr : link register value on crash site
        pc : crash site pointer
        fp : frame pointer
        F : crash site function
        P : means caller (or parent) function, P(F) is parent of F
        '->' : means points to
        FA : frame address - FA(F) is frame address of function F
        LR : link register value saved in fp + 8
  
      Obviously pc -> F, lr value is different in each case
      Case (a):
        lr -> P(F), fp -> FA(P(F)), LR -> P(P(F)), lr != LR        
        We cannot set lr -> F, because F is leaf function and 
        stack unwinding will not work correctly. Do nothing in this case
      Case (b):
        lr -> P(F), fp -> FA(F), LR -> P(F), lr == LR
        Set lr -> F, so that stack unwinder hits F and calls personality routine of F
        If we do not do this, we can miss 'except' block in function F.
      Case (c):
        lr -> F, fp -> FA(F), LR -> P(F), lr != LR
        The value of lr is correct, do nothing in this case
    }
    if PUInt64(ThreadState.__fp + 8)^ = ThreadState.__lr then
      ThreadState.__lr := ThreadState.__pc;
    ThreadState.__pc := UIntPtr(@SignalConverter);
{$ENDIF}
  end;
{$IF     Defined(CPUARM32)}
  if OldStateCount = ARM_UNIFIED_THREAD_STATE_COUNT then
  begin
    Parm_unified_thread_state_t(NewState)^.ash := Parm_unified_thread_state_t(OldState)^.ash;
    Parm_unified_thread_state_t(NewState)^.ts_32 := ThreadState^;
  end
  else
    Parm_thread_state32_t(NewState)^ := ThreadState^;
{$ELSEIF Defined(CPUARM64)}
  Parm_unified_thread_state_t(NewState)^.ash := Parm_unified_thread_state_t(OldState)^.ash;
  Parm_unified_thread_state_t(NewState)^.ts_64 := ThreadState^;
{$ENDIF}
  NewStateCount := OldStateCount;
end;
{$ELSEIF defined(CPUX86) or defined(CPUX64)}
var
  ExceptionStateCount: mach_msg_type_number_t;
  //ThreadStateCount: mach_msg_type_number_t;
  FloatStateCount: mach_msg_type_number_t;
  ExceptionState: x86_exception_state_t;
  ThreadState: Px86_thread_state_t;
  FloatState: x86_float_state_t;
  KRes: kern_return_t;
  ExcCode: Integer;
  FPExceptions: UInt16;
begin
  ExceptionStateCount := sizeof(ExceptionState) div sizeof(natural_t);
//Assert(ExceptionStateCount = 6);
  KRes := thread_get_state(Thread, x86_EXCEPTION_STATE,
                           thread_state_t(@ExceptionState), ExceptionStateCount);
  if KRes <> KERN_SUCCESS then
  begin
    // Fatal
    Result := KERN_INVALID_ARGUMENT;
    Exit;
  end;
  FloatStateCount := sizeof(x86_float_state_t) div  sizeof(natural_t);
  KRes := thread_get_state(Thread, x86_FLOAT_STATE,
                           thread_state_t(@FloatState), FloatStateCount);
  if KRes <> KERN_SUCCESS then
  begin
    // Fatal
    Result := KERN_INVALID_ARGUMENT;
    Exit;
  end;
  ThreadState := Px86_thread_state_t(OldState);
//  writeln(Format('Exception @%p, trap #%d(0x%x), err = %d(0x%x), esp = %p, fault addr=%p',
//                 [Pointer(ThreadState^.ts32.eip), ExceptionState.es32.__trapno,
//                  ExceptionState.es32.__trapno,
//                  ExceptionState.es32.__err, ExceptionState.es32.__err,
//                  Pointer(ThreadState^.ts32.esp),
//                  Pointer(ExceptionState.es32.__faultvaddr)]));

  if (ExceptionState.es32.__trapno = $E) and
       ((ThreadState^.ts32.esp and $FFFFF000) = (ExceptionState.es32.__faultvaddr and $FFFFF000)) then
  begin
//    writeln('stack fault');
     {
      Stack fault.  We can't allow the exception to be propagated back to the faulting thread,
      or we'll loop (forever).  We have to take down the app at this point.
     }
     Result := KERN_FAILURE;
     Exit;
  end;

  Result := KERN_SUCCESS;
  if ExceptionType = EXC_BAD_ACCESS then
  begin
    {
     Memory access violation.  E.g. segv.  We don't care, really, what the
     actual fault was - they all get dispatched the same way to the user.
    }
    ExcCode := Integer(System.reAccessViolation);
  end
  else if ExceptionType = EXC_ARITHMETIC then
  begin
//     writeln(format('FSW = %x, MXCSR = %x', [FloatState.fs32.fpu_fsw, FloatState.fs32.fpu_mxcsr]));
    {
     All arithmetic exceptions come here.  This includes all floating point
     violations, and integer violations.  This depends, of course, on the
     settings of the floating point and MX control words.  We'll check to see if there
     are unmasked exceptions flagged in either of them, and report on the first unmasked
     exception we see, if any.
    }
    FPExceptions := UnmaskedExceptions(FloatState.fs32.fpu_fsw, FloatState.fs32.fpu_fcw);
    FPExceptions := FPExceptions or
      UnmaskedExceptions(FloatState.fs32.fpu_mxcsr, FloatState.fs32.fpu_mxcsr shr 7);
    if (FPExceptions and PRECISION_MASK <> 0) then
      ExcCode := Integer(System.reInvalidOp)
    else if (FPExceptions and UNDERFLOW_MASK <> 0) then
      ExcCode := Integer(System.reUnderflow)
    else if (FPExceptions and OVERFLOW_MASK <> 0) then
      ExcCode := Integer(System.reOverflow)
    else if (FPExceptions and ZERODIVIDE_MASK <> 0) then
      ExcCode := Integer(System.reZeroDivide)
    else if (FPExceptions and DENORMAL_MASK <> 0) then
      ExcCode := Integer(System.reInvalidOp)
    else if (FPExceptions and INVALIDOP_MASK <> 0) then
      ExcCode := Integer(System.reInvalidOp)
    else if ExceptionState.es32.__trapno = 0 then
      ExcCode := Integer(System.reDivByZero)
    else
      ExcCode := Integer(System.reInvalidOp); // shouldn't happen
  end
  else if ExceptionType = EXC_BAD_INSTRUCTION then
  begin
    {
     Illegal instruction, or privileged instruction.  We don't discriminate.
    }
    ExcCode := Integer(System.rePrivInstruction);
  end
  else
  begin
    ExcCode := 0;
    { This can't happen. We do the equivalent of asserting here.  If we return
      this value, the kernel will take down the process.
    }
    Result := KERN_INVALID_ARGUMENT;
  end;

  {
   Now we set up the thread state for the faulting thread so that when we
   return, control will be passed to the exception dispatcher on that thread,
   and this POSIX thread will continue watching for Mach exception messages.
   See the documentation at <code>DispatchMachException()</code> for more
   detail on the parameters loaded in EAX, EDX, and ECX.
  }
  ThreadState^.ts32.eax := ThreadState^.ts32.eip;
  ThreadState^.ts32.edx := ExceptionState.es32.__faultvaddr;
  ThreadState^.ts32.ecx := ExcCode;
  ThreadState^.ts32.eip := UIntPtr(@SignalConverter);
  Px86_thread_state_t(NewState)^ := ThreadState^;
  NewStateCount := OldStateCount;
end;
{$ENDIF }

{
 This export is required, as <code>exc_server</code> expects to be able to call
 this function by this particular name.
}
{$IF defined(CPUX86) or defined(CPUX64)}
exports
  catch_exception_raise_state_identity name _PU + 'catch_exception_raise_state_identity';
{$ENDIF}
end.
