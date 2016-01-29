unit nsErrorReport;

// $Id: nsErrorReport.pas,v 1.2 2008/08/12 14:08:15 lulin Exp $

// $Log: nsErrorReport.pas,v $
// Revision 1.2  2008/08/12 14:08:15  lulin
// - не падаем в режиме отладки.
//
// Revision 1.1  2007/09/20 13:00:59  oman
// - new: Поддержка WER для Vista (cq26750)
//

interface

uses
 SysUtils
 ;

 function nsReportError(anException: Exception): Boolean;

implementation

uses
 Windows
 ;

type
 PRaiseFrame = ^TRaiseFrame;
 TRaiseFrame = packed record
   NextRaise: PRaiseFrame;
   ExceptAddr: Pointer;
   ExceptObject: TObject;
   ExceptionRecord: PExceptionRecord;
 end;

 PExceptionPointers = ^TExceptionPointers;

 EFaultRepRetVal = (
   frrvOk,
   frrvOkManifest,
   frrvOkQueued,
   frrvErr,
   frrvErrNoDW,
   frrvErrTimeout,
   frrvLaunchDebugger,
   frrvOkHeadless
 );

 TReportFaultFunc = function (pep: PExceptionPointers; dwMode: DWord): EFaultRepRetVal; stdcall;

function nsReportError(anException: Exception): Boolean;
var
 l_DLL: THandle;
 l_Func: TReportFaultFunc;
 l_ExceptionPointers: TExceptionPointers;
 l_Context: TContext;
begin
 Result := False;
 {$IfOpt D-}
 if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 6) and (ExceptObject = anException) then
 begin
  l_DLL := LoadLibrary('Faultrep.dll');
  if l_DLL <> 0 then
  try
   l_Func := TReportFaultFunc(GetProcAddress(l_DLL, 'ReportFault'));
   if Assigned(l_Func) then
   begin
    GetThreadContext(GetCurrentThreadId,l_Context);
    l_ExceptionPointers.ContextRecord := @l_Context;
    l_ExceptionPointers.ExceptionRecord := Windows.PExceptionRecord(Pointer(PRaiseFrame(RaiseList)^.ExceptionRecord));
    l_Func(@l_ExceptionPointers, 0);
    Result := True;
   end;//Assigned(l_Func
  finally
   FreeLibrary(l_DLL);
  end;//try..finally
 end;//Win32Platform = VER_PLATFORM_WIN32_NT
 {$EndIf}
end;

end.
