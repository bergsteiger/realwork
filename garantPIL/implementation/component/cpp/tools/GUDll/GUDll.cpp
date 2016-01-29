// GUDll.cpp : Defines the entry point for the DLL application.
//
#include "ace/ACE.h"
#include "stdbase.h"
#include "basemask.h"
#include "GUDll.h"

int main_update ( int argc, char** argv, ProgressScreen* screen );

Logger logger;

void MfcTracer :: Print( const char* str ) const
{
	
}

GUDLL_API void DoGU( char* aCmdLine, ProgressScreen *screen )
{
	/*
#if (defined (ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0))
	HMODULE module (::GetModuleHandle ("kernel32.dll"));

	if (module != (HMODULE)0) {
		typedef BOOL (WINAPI* HeapSetInformation) (HANDLE, HEAP_INFORMATION_CLASS, PVOID, SIZE_T);

		HeapSetInformation heap_set_information (
			(HeapSetInformation)::GetProcAddress (module, "HeapSetInformation")
		);

		if (heap_set_information != (HeapSetInformation)0) {
			HANDLE dummy_buffer;
			DWORD number_of_heaps (::GetProcessHeaps (0, &dummy_buffer));

			if (number_of_heaps != 0) {
				ACE_Auto_Basic_Array_Ptr <HANDLE> process_heaps (new HANDLE [number_of_heaps]);

				PHANDLE heap_handles (process_heaps.get ());

				if (
					(
						heap_handles != (PHANDLE)0
					) && (
						::GetProcessHeaps (number_of_heaps, heap_handles) == number_of_heaps
					)
				) {
					const ULONG heap_fragmentation_value = 2;

					while (number_of_heaps-- != 0) {
						HANDLE _heap (heap_handles [number_of_heaps]);
						ULONG value (heap_fragmentation_value);

						if (
							!heap_set_information (
								_heap
								, HeapCompatibilityInformation
								, &value
								, sizeof (value)
							)
						) {
							continue;
						}
					}
				}
			}
		}
	}
#endif // (defined (ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0))
	*/

	char**	argv = new char* [ 2 ];
	argv[ 0 ] = new char[ 8 ]; strcpy( argv[ 0 ], "$DUMMY$" );
	argv[ 1 ] = new char[ strlen( aCmdLine ) + 1 ]; strcpy( argv[ 1 ], aCmdLine );

	MfcTracer tracer;
	logger.Init( &tracer, cd_win, cd_win );

	main_update( 2, argv, screen );
}
