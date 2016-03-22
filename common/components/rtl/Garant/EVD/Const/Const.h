////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/common/components/rtl/Garant/EVD/Const/Const.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Low Level::EVD::Const
//
// Константы физического представления формата evd.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_DELPHI_LOW_LEVEL_EVD_CONST_H__
#define __SHARED_DELPHI_LOW_LEVEL_EVD_CONST_H__

#include "shared/Core/sys/std_inc.h"

namespace EVD {

// Тип данных тега.
enum TevTypeID {
	id_Child
	, id_Atom
	, id_Long
	, id_String32
	, id_Component
	, id_SInt8
	, id_UInt8
	, id_SInt16
	, id_UInt16
	, id_SInt32
	, id_UInt32
	, id_SInt64
	, id_UInt64
	, id_String8
	, id_String16
	, id_Stream
	, id_Transparent
	, id_CodePage
	, id_FontName
	, id_FontID
	, id_ShortCodePage
};

static const long unpack_id_Fill = 0; // заполнитель выравнивания.
static const long unpack_id_Finish = 65535; // закрывающая скобка тега.
static const long unpack_id_Key1 = 0x6525; // признак завершения бинарных данных.
static const long unpack_id_Key2 = 0x4525; // признак завершения бинарных данных.
static const long unpack_id_Key3 = 0x6225; // признак начала бинарных данных.
static const long unpack_id_Key4 = 0x4225; // признак начала бинарных данных.
static const long unpack_id_Mask = unpack_id_Finish - 2; // маска распределения памяти.
static const long unpack_id_Children = unpack_id_Finish - 3; // признак начала списка дочерних тегов.
static const long unpack_id_Rollback = unpack_id_Finish - 4; // признак отката тега.
static const long unpack_id_MaskEx = unpack_id_Finish - 5; // расширенная маска распределения памяти.
static const long unpack_id_Link = unpack_id_Finish - 6; // ссылка на объект в другом IStorage.
static const long unpack_id_DefaultChild = unpack_id_Finish - 7; // дочерний тег с типом по умолчанию.

static const long pack_id_Fill = 0; // заполнитель выравнивания.
static const long pack_id_Finish = 255; // закрывающая скобка тега.
static const long pack_id_Percent = 37; // символ %
static const long pack_id_SmallE = 101; // символ e
static const long pack_id_CapitalE = 69; // символ E
static const long pack_id_SmallB = 98; // символ b
static const long pack_id_CapitalB = 66; // символ B
static const long pack_id_SmallP = 112; // символ p
static const long pack_id_CapitalP = 80; // символ P
static const long pack_id_Children = pack_id_Finish - 1; // признак начала списка дочерних тегов.
static const long pack_id_Rollback = pack_id_Finish - 2; // признак отката тега.
static const long pack_id_Link = pack_id_Finish - 3; // ссылка на объект в другом IStorage.
static const long pack_id_DefaultChild = pack_id_Finish - 4; // дочерний тег с типом по умолчанию.

} // namespace EVD


#endif //__SHARED_DELPHI_LOW_LEVEL_EVD_CONST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
