////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/AsynchronousCalls.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::AsynchronousCalls
//
// класс для работы обеспечения работы в асинхронном режиме
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/AsynchronousCalls.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RationalRoseTlb.h"

//#UC START# *45B9F39802BF_CUSTOM_INCLUDES*
//#include "shared/Core/fix/win_afx.h"
//#UC END# *45B9F39802BF_CUSTOM_INCLUDES*


//#UC START# *45B9F39802BF*
//#UC END# *45B9F39802BF*

//////////////////////////////////////////////////////////////////////////////////////////
// static member and methods

// рабочая функция потока
void AsynchronousCalls::thread_func (void* ptr) {
	//#UC START# *45B9F4B4004E*
	if (SUCCEEDED (CoInitialize (0))) {
		extern HANDLE g_hevent;		
		AsynchronousCalls::ComModuleAutoLock lock (_Module);
		IStream* stream_ptr = reinterpret_cast<IStream*> (ptr);
		// read marshaled object reference from global variable 
		// читаем маршалированную объектную ссылку из глобальной переменной 		
		IRoseApplicationPtr app;
		HRESULT hr = CoGetInterfaceAndReleaseStream(stream_ptr, __uuidof (app), (void**) &app); 
		stream_ptr = 0;

		if (app) {
			for (int i = 0; i < 100; i++) {
				if (WaitForSingleObject(g_hevent, 100) == WAIT_OBJECT_0) {
					//app->WriteErrorLog ("Exit signal handled");
					//_Module.Unlock ();
					//s_rose_app = 0;
					_endthread ();
				}
				IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();
				//s_rose_data.push_back (RoseAbstractDumper::IRoseItemWrapper (sel_items));
				/*(IRoseItemCollection*)s_rose_data.insert (
					s_rose_data.begin ()
					, RoseAbstractDumper::IRoseItemWrapper (
						s_rose_app->CurrentModel->GetSelectedItems()
					)
				);*/
				
				IRoseCategoryPtr cat = sel_items->GetAt(1);
				//s_rose_data.push_back (RoseAbstractDumper::IRoseItemWrapper (cat));
				if (cat) {
					if (cat->IsControlled () && cat->IsLoaded ()){
						cat->Modifiable (!cat->IsModifiable ());
					}
				}
				//ACE_OS::sleep (5);
			}
		}
		//_Module.Unlock ();
	}
	//s_rose_app = 0;
	_endthread ();
	//#UC END# *45B9F4B4004E*
}

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

