unit HCAdapter; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapter/HCAdapter.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<AdapterTarget::Category>> garant6x::HCAdapter
//
// Библиотека для взаимодействия сервера консультаций и ПО отдела правовой поддержки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysConst
	, SysUtils
	, Windows
	, Classes
	, ActiveX
	, IOUnit
	, HCInterfacesUnit;

const
	CLibraryVersion: LongWord = 237;
	CLibraryName: PAnsiChar = 'HCAdapter.dll';

{$IF DEFINED(UseNoServerExceptionEvent)}
var
	g_NoServerExceptionEvent: procedure (var a_Exception: Exception) = nil;
{$IFEND} // UseNoServerExceptionEvent

type
	// Системные исключения.
	ELoadLibraryError = class (Exception); // используется при загрузке dll; 
	EGetProcAddressError = class (Exception); // используется при вызове операции dll; 
	EStdException = class (Exception); // используется при мапинге неизвестных Sdt исключений; 
	ECorbaException = class (Exception); // используется при мапинге неизвестных CORBA исключений;
	EWrongVersion = class (Exception); // выбрасывается в случае не соответствия версии клиента и dll
	EUnknownFactoryKey = class (Exception); // выбрасывается в случае, если нет ни одного зарегестрированного серванта c заданным ключом для запрашиваемого интерфейса
	
	ECantFindServer = class (Exception); // client-server DLL can't find corresponding server
	
	// exported root factory interface
	IHCAdapterRoot = interface (IInterface) ['{FA9E7DCD-7E2B-43FF-8715-865704C0C74B}']
		procedure MakeStream (
			out aRet {: IStream}
		); stdcall; overload;

		procedure MakeStream (
			const aPath: PAnsiChar;
			out aRet {: IStream}
		); stdcall; overload;

		procedure AllocString (
			aMaximum: Longword;
			out aRet {: IString}
		); stdcall; overload;

		procedure MakeString (
			const aStr: PAnsiChar;
			out aRet {: IString}
		); stdcall; overload;

		procedure MakeBusinessLogicLifeCycle (
			out aRet {: IBusinessLogicLifeCycle}
		); stdcall; overload;

		procedure MakeConsultingRequests (
			out aRet {: IConsultingRequests}
		); stdcall; overload;

	end;

	// DLL wrapper interface
	IHCAdapterDll = interface (IInterface)
		function GetVersion (): LongWord;

		function MakeStream (
		) : IStream; overload;

		function MakeStream (
			const aPath: PAnsiChar
		) : IStream; overload;

		function AllocString (
			aMaximum: Longword
		) : IString; overload;

		function MakeString (
			const aStr: PAnsiChar
		) : IString; overload;

		function MakeBusinessLogicLifeCycle (
		) : IBusinessLogicLifeCycle; overload;

		function MakeConsultingRequests (
		) : IConsultingRequests; overload;


	end;

	// DLL wrapper impl
	THCAdapterDll = class (TInterfacedObject, IHCAdapterDll)
	private
		f_HModule: HModule;
		f_DllRoot: IHCAdapterRoot;

	private
		procedure DllLoad;
		procedure DllFree;
		procedure RootInit(aClientVersion: LongWord); overload;
		procedure RootInit(aClientVersion: LongWord; const aLocale: PAnsiChar); overload;
		procedure RootDone;
		function GetRoot: IHCAdapterRoot;
	
	public
		constructor Create (aClientVersion: LongWord); reintroduce; overload;
		constructor Create (aClientVersion: LongWord; const aLocale: PAnsiChar); reintroduce; overload;
		destructor Destroy; override;

		class function Make(): IHCAdapterDll; overload; // can raise ECantFindServer;
		class function Make(const aLocale: PAnsiChar): IHCAdapterDll; overload; // can raise ECantFindServer;

		function GetVersion: LongWord;
	public
		function MakeStream (
		) : IStream; overload;

		function MakeStream (
			const aPath: PAnsiChar
		) : IStream; overload;

		function AllocString (
			aMaximum: Longword
		) : IString; overload;

		function MakeString (
			const aStr: PAnsiChar
		) : IString; overload;

		function MakeBusinessLogicLifeCycle (
		) : IBusinessLogicLifeCycle; overload;

		function MakeConsultingRequests (
		) : IConsultingRequests; overload;

	end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
implementation
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	function THCAdapterDll.MakeStream (
	) : IStream;
	var
		aRes: IStream;
	begin
		GetRoot().MakeStream(aRes);
		Result := aRes;
	end;

	function THCAdapterDll.MakeStream (
		const aPath: PAnsiChar
	) : IStream;
	var
		aRes: IStream;
	begin
		GetRoot().MakeStream(aPath, aRes);
		Result := aRes;
	end;

	function THCAdapterDll.MakeString (
		const aStr: PAnsiChar
	) : IString;
	var
		aRes: IString;
	begin
		GetRoot().MakeString(aStr, aRes);
		Result := aRes;
	end;

	function THCAdapterDll.AllocString (
		aMaximum: Longword
	) : IString;
	var
		aRes: IString;
	begin
		GetRoot().AllocString(aMaximum, aRes);
		Result := aRes;
	end;

	function THCAdapterDll.MakeBusinessLogicLifeCycle (
	) : IBusinessLogicLifeCycle;
	var
		aRes: IBusinessLogicLifeCycle;
	begin
		GetRoot().MakeBusinessLogicLifeCycle(aRes);
		Result := aRes;
	end;

	function THCAdapterDll.MakeConsultingRequests (
	) : IConsultingRequests;
	var
		aRes: IConsultingRequests;
	begin
		GetRoot().MakeConsultingRequests(aRes);
		Result := aRes;
	end;



procedure THCAdapterDll.DllLoad;

	function GetOsDependentCatalog: string;
	begin
		if (Longint (Windows.GetVersion) < 0) then
			Result := ExtractFilePath (ParamStr (0))+'win9X'
		else
			Result := ExtractFilePath (ParamStr (0))+'winNT';
	end;

var
	l_CurrentDir: string;
	l_ErrorMode: UINT;
	l_OsDependentCatalog: string;
begin
	l_ErrorMode := SetErrorMode (SEM_FAILCRITICALERRORS);
	try
		l_CurrentDir := GetCurrentDir;

		l_OsDependentCatalog := GetOsDependentCatalog;
		if SetCurrentDir (l_OsDependentCatalog) then
			try
				f_HModule := LoadLibraryA (CLibraryName);
				(* K: 384075072 *)
				if (f_HModule = HMODULE (0)) then
					f_HModule := LoadLibraryExA (PAnsiChar (l_OsDependentCatalog+'\'+CLibraryName), 0, LOAD_WITH_ALTERED_SEARCH_PATH);
			finally
				SetCurrentDir (l_CurrentDir);
			end
		else
			f_HModule := LoadLibraryA (PAnsiChar (l_OsDependentCatalog+'\'+CLibraryName));
		
		if (f_HModule = HMODULE (0)) then
		begin
			f_HModule := LoadLibraryA (CLibraryName);
		
			if (f_HModule = HMODULE (0)) then
				raise ELoadLibraryError.Create ('Dynamic library "'+CLibraryName+'" not found');
		end;
	finally
		SetErrorMode (l_ErrorMode);
	end;
end;

procedure THCAdapterDll.DllFree;
begin
	if (f_HModule <> HMODULE (0)) then
	begin
		try
			FreeLibrary (f_HModule);
		except
		end;
	end;
end;

constructor THCAdapterDll.Create(aClientVersion: LongWord);
begin
	inherited Create;
	DllLoad;
	RootInit(aClientVersion);
end;

constructor THCAdapterDll.Create (aClientVersion: LongWord; const aLocale: PAnsiChar);
begin
	inherited Create;
	DllLoad;
	RootInit(aClientVersion, aLocale);
end;

destructor THCAdapterDll.Destroy;
begin
	f_DllRoot := nil;
	RootDone;
	DllFree;
	inherited;
end;

class function THCAdapterDll.Make(const aLocale: PAnsiChar): IHCAdapterDll;
begin
	Result := THCAdapterDll.Create(CLibraryVersion, aLocale);
end;

class function THCAdapterDll.Make: IHCAdapterDll;
begin
	Result := THCAdapterDll.Create(CLibraryVersion);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// plain DLL method's wrappers
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function THCAdapterDll.GetVersion: LongWord;
const
	CProcName = '_tie_dll_version@0';
type
	TProcType = function: Integer; stdcall;
var
	l_ProcAddress: Pointer;
begin
	l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));
	if (not Assigned (l_ProcAddress)) then
		raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);

	Result := TProcType (l_ProcAddress);
end;

function THCAdapterDll.GetRoot: IHCAdapterRoot;
const
	CProcName = '_tie_dll_get_root@4';
type
	TProcType = procedure (out aRoot{: IHCAdapterRoot}); stdcall;
var
	l_ProcAddress: Pointer;
begin
	if (not Assigned (f_DllRoot)) then
	begin
		l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));
	
		if (not Assigned (l_ProcAddress)) then
			raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);
	
		TProcType (l_ProcAddress)(f_DllRoot);
	end;
	
	Result := f_DllRoot;
end;

procedure THCAdapterDll.RootInit (aClientVersion: LongWord; const aLocale: PAnsiChar);
const
	CProcName = '_tie_dll_init_with_locale@8';
type
	TProcType = procedure (aClientVersion: LongWord; const aLocale: PAnsiChar); stdcall;
var
	l_ProcAddress: Pointer;
begin
	l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));

	if (not Assigned (l_ProcAddress)) then
		raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);

	TProcType (l_ProcAddress) (aClientVersion, aLocale);
end;

procedure THCAdapterDll.RootInit(aClientVersion: LongWord);
const
	CProcName = '_tie_dll_init@4';
type
	TProcType = procedure (aClientVersion: LongWord); stdcall;
var
	l_ProcAddress: Pointer;
begin
	l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));

	if (not Assigned (l_ProcAddress)) then
		raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);

	TProcType (l_ProcAddress) (aClientVersion);
end;

procedure THCAdapterDll.RootDone;
const
	CProcName = '_tie_dll_done@0';
type
	TProcType = procedure; stdcall;
var
	l_ProcAddress: Pointer;
begin
	if f_HModule <> HMODULE (0) then
	begin
		l_ProcAddress := GetProcAddress (f_HModule, PAnsiChar (CProcName));
	
		if (not Assigned (l_ProcAddress)) then
			raise EGetProcAddressError.Create ('DLL method not found: '+CLibraryName+'.'+CProcName);
			
		TProcType (l_ProcAddress);
	end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
// exception maping support
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
type
	TExceptionIdMapItem = record
		rId: AnsiString;
		rEClass: ExceptClass;
		rMessage: string;
	end;

resourcestring
	// "Нормальные" текстовые сообщения для исключений, которые "видит" пользователь.
	// (!) Общий формат для имен: строка с именем `S<ИмяИсключения>` соответствует классу с именем `E<ИмяИсключения>`.
	//
	_SNotImplemented = 'функция не реализована';

	_SOperationError = 'Во время выполнения операции copy_to один из потоков, участвовавших в операции перешёл в некорректное состояние.';
	_SCantFindXerces = 'Не смогли загрузить библиотеку для работы с XML';

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

const
	// Карта [map] перекодировки: текстовой строке ставиться в соответствие нужный мета-класс исключения и сообщение.
	//
	cIdToExceptionMapMaxItems = 8; // максимальное количество элементов в таблице

type
	TIdToExceptionMapArray = array [0..cIdToExceptionMapMaxItems - 1] of TExceptionIdMapItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

type
	TIdToExceptionMap = class(TObject)
	private
		f_Map: TIdToExceptionMapArray;
	public
		constructor Create;
			reintroduce;
		function ConvertIdToIndex(const aId: PAnsiChar; out aIndex: Longword): Boolean;
		function GetExceptionClass(anIndex: Longword): ExceptClass;
		function CreateException(anIndex: Longword): Exception;
end;

{TIdToExceptionMap}

function TIdToExceptionMap.ConvertIdToIndex(const aId: PAnsiChar; out aIndex: Longword): Boolean;
var
	l_Index: Longword;
begin
	Result := False;
	aIndex := 0;
	for l_Index := Low (f_Map) to High (f_Map) do
		if (StrComp (aId, PAnsiChar (f_Map[l_Index].rId)) = 0) then
		begin
			aIndex := l_Index;
			Result := True;
			
			Break;
		end;
end;

constructor TIdToExceptionMap.Create;
	procedure lp_Init(anIndex: Longword; const aGUID, aMessage: string; const aClass: ExceptClass);
	begin
		with f_Map[anIndex] do
		begin
			rId := aGUID;
			rEClass := aClass;
			rMessage := aMessage;
		end;
	end;

begin
	inherited Create;
	// заполнение f_Map
	
	lp_Init (0, '0000-0000-0000-0000-000000000000', 'dummy exception', EStdException);
	lp_Init (1, '4DDEBC97-3F88-4811-9423-8BDEE07A9C21', 'Выход за границы массива', EListError);
	lp_Init (2, '69708A24-C2D3-4685-8016-7E2FD8A5888C', 'Неправильная версия ДЛЛ', EWrongVersion);
	lp_Init (3, '42540CD0-2B0C-45F2-82DB-0474D2D29867', 'No one servant was registers in factory with a given key', EUnknownFactoryKey);
	lp_Init (4, 'F11331C9-6903-4F59-9876-78B3CCEE3209', 'DLL can''t find corresponding server', ECantFindServer);
	lp_Init (5, 'F5A55B66-C39A-4758-BE4D-844DE9E142A4', '_SOperationError', EOperationError);
	lp_Init (6, 'BA9EDABD-A788-46FF-B5C3-45E967EFEE3C', '_SNotImplemented', ENotImplemented);
	lp_Init (7, '55D0E5EB-A193-459C-B12C-8C926D673910', '_SCantFindXerces', ECantFindXerces);
end;

function TIdToExceptionMap.CreateException(anIndex: Longword): Exception;
begin
	with f_Map [anIndex] do
		Result := rEClass.Create (rMessage);
end;

function TIdToExceptionMap.GetExceptionClass(anIndex: Longword): ExceptClass;
begin
	Result := f_Map [anIndex].rEClass;
end;

var
	g_ExceptionMap: TIdToExceptionMap = nil;

var
	gExceptClsProc: Pointer;
	gExceptObjProc: Pointer;


function GetExceptionClass (aExceptionRecord: PExceptionRecord): ExceptClass;
type
	TExceptClsProc = function (aExceptionRecord: PExceptionRecord): ExceptClass;
var
	lIndex: Cardinal;
begin
	Result := nil;
	case aExceptionRecord^.ExceptionCode of
		DWORD ($E0040200):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 0)
			) then
			begin
				Result := EOutOfMemory;
			end;
		end;
		DWORD ($E0040201):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 1)
				and (aExceptionRecord^.ExceptionInformation [0] <> 0)
			) then
			begin
				Result := EStdException;
			end;
		end;
		DWORD ($E0040202):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 1)
				and (aExceptionRecord^.ExceptionInformation [0] <> 0)
			) then
			begin
				Result := ECorbaException;
			end;
		end;
		DWORD ($E0040203):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 1)
				and (aExceptionRecord^.ExceptionInformation [0] <> 0)
				and g_ExceptionMap.ConvertIdToIndex (PAnsiChar (aExceptionRecord^.ExceptionInformation [0]), lIndex)
			) then
				begin
					Result := g_ExceptionMap.GetExceptionClass(lIndex);
				end
			else
				if (
					((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
					and (aExceptionRecord^.NumberParameters = 2)
					and (aExceptionRecord^.ExceptionInformation [0] = 0)
					and (aExceptionRecord^.ExceptionInformation [1] <> 0)
				) then
					begin
						Result := g_ExceptionMap.GetExceptionClass(aExceptionRecord^.ExceptionInformation [1]);
					end;
		end;
	end;
	if (
		Result = nil
	) then
	begin
		Result := TExceptClsProc (gExceptClsProc) (aExceptionRecord);
	end;
end;

var
	g_CorbaExceptionMessage : String = '';
	g_StdExceptionMessage : String = '';

function GetExceptionObject (aExceptionRecord: PExceptionRecord): Exception;
type
	TExceptObjProc = function (aExceptionRecord: PExceptionRecord): Exception;
var
	lIndex: Cardinal;
begin
	Result := nil;
	case aExceptionRecord^.ExceptionCode of
		DWORD ($E0040200):
		begin
			if (
				((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0)
				and (aExceptionRecord^.NumberParameters = 0)
			) then
			begin
				// (!) Специальный трюк: это исключение о "нехватке" памяти и оно не может быть создано динамически.
				try
					OutOfMemoryError ();
				except
					on l_Exception: EOutOfMemory do Result := l_Exception;
				end;
			end;
		end;
		DWORD ($E0040201):
		begin
			if ((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0) then
			begin
				if (
					(aExceptionRecord^.NumberParameters = 1)
					and (aExceptionRecord^.ExceptionInformation [0] <> 0)
				) then
				begin
					try
						g_StdExceptionMessage := PAnsiChar (aExceptionRecord^.ExceptionInformation [0]);
						Result := EStdException.Create (g_StdExceptionMessage);
					finally
						try
							CoTaskMemFree (Pointer (aExceptionRecord^.ExceptionInformation [0]));
						finally
							aExceptionRecord^.NumberParameters := 2;
							aExceptionRecord^.ExceptionInformation [0] := 0;
							aExceptionRecord^.ExceptionInformation [1] := DWORD (-1);
						end;
					end;
				end
				else
				begin
					if (
						(aExceptionRecord^.NumberParameters = 2)
						and (aExceptionRecord^.ExceptionInformation [0]  = 0)
						and (aExceptionRecord^.ExceptionInformation [1] = DWORD (-1))
					) then
					begin
						Result := EStdException.Create (g_StdExceptionMessage);
					end;
				end;
			end;
		end;
		DWORD ($E0040202):
		begin
			if ((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0) then
			begin
				if (
					(aExceptionRecord^.NumberParameters = 1)
					and (aExceptionRecord^.ExceptionInformation [0] <> 0)
				) then
				begin
					try
						g_CorbaExceptionMessage := PAnsiChar (aExceptionRecord^.ExceptionInformation [0]);
						Result := ECorbaException.Create (g_CorbaExceptionMessage);
					finally
						try
							CoTaskMemFree (Pointer (aExceptionRecord^.ExceptionInformation [0]));
						finally
							aExceptionRecord^.NumberParameters := 2;
							aExceptionRecord^.ExceptionInformation [0] := 0;
							aExceptionRecord^.ExceptionInformation [1] := DWORD (-1);
						end;
					end;
				end
				else
				begin
					if (
						(aExceptionRecord^.NumberParameters = 2)
						and (aExceptionRecord^.ExceptionInformation [0]  = 0)
						and (aExceptionRecord^.ExceptionInformation [1] = DWORD (-1))
					) then
					begin
						Result := ECorbaException.Create (g_CorbaExceptionMessage);
					end;
				end;
			end;
		end;
		DWORD ($E0040203):
		begin
			if ((aExceptionRecord^.ExceptionFlags and EXCEPTION_NONCONTINUABLE) <> 0) then
			begin
				if (
					(aExceptionRecord^.NumberParameters = 1)
					and (aExceptionRecord^.ExceptionInformation [0] <> 0)
				) then
				begin
					try
						if (
							g_ExceptionMap.ConvertIdToIndex (PAnsiChar (aExceptionRecord^.ExceptionInformation [0]), lIndex)
						) then
						begin
							Result := g_ExceptionMap.CreateException(lIndex);
						end;
					finally
						try
							CoTaskMemFree (Pointer (aExceptionRecord^.ExceptionInformation [0]));
						finally
							aExceptionRecord^.NumberParameters := 2;
							aExceptionRecord^.ExceptionInformation [0] := 0;
							aExceptionRecord^.ExceptionInformation [1] := DWORD (lIndex);
						end;
					end;
				end
				else
				begin
					if (
						(aExceptionRecord^.NumberParameters = 2)
						and (aExceptionRecord^.ExceptionInformation [0]  = 0)
						and (aExceptionRecord^.ExceptionInformation [1] <> 0)
					) then
					begin
						lIndex := Longword (aExceptionRecord^.ExceptionInformation [1]);
						Result := g_ExceptionMap.CreateException(lIndex);
					end;
				end;
			end;
		end;
	end;

	if (Result = nil) then
	begin
		Result := TExceptObjProc (gExceptObjProc) (aExceptionRecord);
	end
	else
	begin
		{$IF DEFINED(UseNoServerExceptionEvent)}
		if ((Result is ENoServer) and Assigned(g_NoServerExceptionEvent)) then
		begin
			g_NoServerExceptionEvent(Result);
		end;
		{$IFEND} // UseNoServerExceptionEvent
	end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

procedure ExitProc;
begin
	ExceptObjProc := gExceptObjProc;
	ExceptClsProc := gExceptClsProc;
	FreeAndNil(g_ExceptionMap);
end;

procedure InitProc;
begin
	g_ExceptionMap := TIdToExceptionMap.Create;
	gExceptClsProc := ExceptClsProc;
	gExceptObjProc := ExceptObjProc;
	//
	ExceptClsProc := @GetExceptionClass;
	ExceptObjProc := @GetExceptionObject;
end;

//#UC START# *442BEE8500AB_CUSTOM_MAPPINHG_IMPL*
//#UC END# *442BEE8500AB_CUSTOM_MAPPINHG_IMPL*

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

initialization
	InitProc;

finalization
	ExitProc;
	Finalize(g_CorbaExceptionMessage);
	Finalize(g_StdExceptionMessage);

end.