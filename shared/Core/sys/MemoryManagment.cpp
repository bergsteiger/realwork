////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/MemoryManagment.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::MemoryManagment
// Файл реализации утилитного набора MemoryManagment
//
// вспомогательные функция для работы с памятью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "ace/ACE.h"
#include "shared/Core/sys/MemoryManagment.h"
// by <<uses>> dependencies
#include "shared/Core/sys/DebugHelper.h"
#include "shared/Core/sys/Logs.h"
#include "ace/Auto_Ptr.h"

//#UC START# *4DA7DAFF006D_CUSTOM_INCLUDES*
//#UC END# *4DA7DAFF006D_CUSTOM_INCLUDES*

namespace Core {
namespace MemoryManagment {

//#UC START# *4DA7DAFF006D*
//#UC END# *4DA7DAFF006D*

//////////////////////////////////////////////////////////////////////////////////////////
// private member declaration

// обработчик неудачного выделения памяти, size - размер запрашиваемой памяти (валиден только под
// windows)
static int new_handler (size_t size);

// обработчик неудачного выделения памяти для не windows систем
static void non_windows_handler_wrapper ();

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// инициализация специальной низкофрагментированной кучи(поддерживается только под windows).
void init_low_fragmentation_heap () {
	//#UC START# *4DA7DB1600CB*
#if (defined (ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0))
	bool ret = false;
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
						const ULONG heap_fragmentation_value = 2;//for low fragmentation heap

						LOG_I (("Current Process Heap is 0x%08X", ::GetProcessHeap ()));
						LOG_I (("Current Runtime Heap is 0x%08X", _get_heap_handle ()));

						LOG_I (("Set Heap Compatibility Information [Fragmentation Value] to %u for all available heaps", heap_fragmentation_value));

						while (number_of_heaps-- != 0) {
							HANDLE heap (heap_handles [number_of_heaps]);
							ULONG value (heap_fragmentation_value);

							if (
								!heap_set_information (
									heap
									, HeapCompatibilityInformation
									, &value
									, sizeof (value)
								)
							) {
									DWORD last_error (::GetLastError ());

									LOG_W ((
										"Heap Compatibility Information [Fragmentation Value] for Heap 0x%08X has not set - error %u, ignored"
										, heap
										, last_error
									));

									continue;
							}

							LOG_I (("Heap Compatibility Information [Fragmentation Value] for Heap 0x%08X has set", heap));
						}
				}
			}
		}
	}
#else
	LOG_E(("Low fragmentation heap is not supported"));
#endif // (defined (ACE_HAS_WINNT4) && (ACE_HAS_WINNT4 != 0))
	//#UC END# *4DA7DB1600CB*
}

// устанавливает обработчик для перехвата неудачного выделения памяти
void install_new_handler () {
	//#UC START# *4DA7DCB50196*
#if (defined (WIN32) || defined (_MSC_VER)) // GARANT_IFDEF
	AfxSetNewHandler (new_handler);
#else
	std::set_new_handler (non_windows_handler_wrapper);
#endif
	//#UC END# *4DA7DCB50196*
}

//////////////////////////////////////////////////////////////////////////////////////////
// private member implementation

// обработчик неудачного выделения памяти, size - размер запрашиваемой памяти (валиден только под
// windows)
int new_handler (size_t size) {
	//#UC START# *4DA7DCEE02BF*
	printf ("%s: size = %llu. The End of Memory !!! See log file for stack", GDS_CURRENT_FUNCTION, size);
	LOG_E (("%s: size = %d. The End of Memory !!!", GDS_CURRENT_FUNCTION, size));
	DebugHelper::dump_stack ();
	throw std::bad_alloc ();
	return 0;
	//#UC END# *4DA7DCEE02BF*
}

// обработчик неудачного выделения памяти для не windows систем
void non_windows_handler_wrapper () {
	//#UC START# *4DA7DD54002E*
	new_handler (0);
	//#UC END# *4DA7DD54002E*
}

} // namespace MemoryManagment
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

