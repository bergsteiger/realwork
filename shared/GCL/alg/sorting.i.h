////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/alg/sorting.i.h"
// генератор inline файлов реализации C++ (.i.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::alg::sorting
// Файл inline реализации утилитного набора sorting
//
// алгоритмы сортировки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//#UC START# *450133F10000_CUSTOM_INCLUDES*
//#UC END# *450133F10000_CUSTOM_INCLUDES*

namespace GCL {

//#UC START# *450133F10000*
// uqsort
inline void uqsort( void *base, size_t num, size_t width, int (__cdecl *compare )(const void *elem1, const void *elem2 ) ) {
	void* swap_buf = malloc (width);
	bool flag = true;
	while (flag) {
		flag = false;
		for (unsigned i =0; i < num; i++ ) {
			for (unsigned k = i+1; k < num; k++ ) {
				int res = compare( (char*)base + i*width, (char*)base + k*width);
				if ( res == 1 ) {
					memmove(swap_buf, (char*)base + i*width, width );
					memmove((char*)base + i*width, (char*)base + k*width, width );
					memmove((char*)base + k*width, swap_buf, width );

					flag = true;
					k = num;
				}
				if ( res == -1 )		
					k = num; // end
			}
		}
	}
	free (swap_buf);
}
//#UC END# *450133F10000*

} // namespace GCL

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

