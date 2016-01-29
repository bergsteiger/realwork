program SendMail; {$R *.RES}

{$APPTYPE  GUI}
{$WARNINGS ON}

uses
 Windows
 , SysUtils
 ;

var
	g_DllHModule: HMODULE;

procedure GetProcedureAddress(var aPointer: Pointer; const aProcName: AnsiString);
 //
	function GetOsDependentCatalog: string;
	begin
		if (Longint(GetVersion) < 0) then
			Result := ExtractFilePath (ParamStr(0))+'win9X'
		else
			Result := ExtractFilePath (ParamStr(0))+'winNT';
	end;
 //
var
 l_DllName: string;
 //
	l_CurrentDir: string;
	l_ErrorMode: UINT;
	l_OsDependentCatalog: string;
begin
	if not(Assigned(aPointer)) then
	begin
  l_DllName := ChangeFileExt(ExtractFileName(ParamStr(0)), '.dll');
  //
		l_ErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
		try
			if (g_DllHModule = HMODULE(0)) then
			begin
				l_CurrentDir := GetCurrentDir;
				//
				l_OsDependentCatalog := GetOsDependentCatalog;
				if SetCurrentDir(l_OsDependentCatalog) then
					try
						g_DllHModule := LoadLibrary(PChar(l_DllName));
					finally
						SetCurrentDir(l_CurrentDir);
					end
				else
					g_DllHModule := LoadLibrary(PChar(Format('%s\%s', [l_OsDependentCatalog, l_DllName])));
				//
				if (g_DllHModule = HMODULE(0)) then
					g_DllHModule := LoadLibrary(PChar(l_DllName));
			end;
			//
   if ((g_DllHModule <> HMODULE(0)) and (aPointer = nil)) then
 			aPointer := GetProcAddress(g_DllHModule, PAnsiChar(aProcName));
		finally
			SetErrorMode(l_ErrorMode);
		end;
	end;
end;


var
	g_SendPtr: Pointer = nil;

{$WARNINGS OFF}
function Send(const a_Command: LPCSTR): Integer; stdcall;
begin
	GetProcedureAddress(g_SendPtr, 'Send');
 //
	asm
		mov esp, ebp
		pop ebp
		jmp [g_SendPtr]
	end;
end;
{$WARNINGS ON}

function GetCommandLine(): string;
var
 l_Index: Integer;
begin
 Result := '';
 //
 for l_Index := 1 to ParamCount do
  if (Result = '') then
   Result := Format('"%s"', [ParamStr(l_Index)])
  else
   Result := Format('%s "%s"', [Result, ParamStr(l_Index)]);
end;

begin
 Send(PAnsiChar(Format('%s -noh2', [GetCommandLine()])));
 //
 FreeLibrary(g_DllHModule);
end.


