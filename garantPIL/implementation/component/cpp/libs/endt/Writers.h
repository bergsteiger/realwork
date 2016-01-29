//
// Writers.h : header file
//

#ifndef __DATA_WRITERS_H
#define __DATA_WRITERS_H

#include "shared/Core/sys/IObject.h"

#include "stdbase.h"

namespace EndtTools {

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// Инфо о сабе

	struct SubInfo {
		size_t level;

		SubDescEx data;

		std::string name;

		SubInfo (long sub, long para, unsigned short flags, long id, size_t level_value) {
			data.Sub = sub;
			data.Para = para;
			data.Flags = flags;
			data.Id = id;
			level = level_value; 
		}
	};

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// Инфо о гиперссылке

	struct RefInfo {
		RespRef data;

		RefInfo (long para_id, short offset) {
			data.ParaId = para_id;
			data.Offset = offset;
			data.DocId = 0;
			data.Sub = 0;
		}
	};

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// Интерфейс писателя данных в базу

	enum DataType { dt_Sub, dt_Ref, dt_Evd };

	class IBaseWriter
		: virtual public ::Core::IObject {
	public:
		virtual void set_document (unsigned long doc_id) = 0;

		virtual void write (const void* data, DataType type) = 0;

		virtual void write_sub (const SubInfo& info) = 0;
		virtual void write_ref (const RefInfo& info) = 0;
		virtual void write_table_info (const char* buffer, size_t size) = 0;
		virtual void set_table_id (unsigned long value) = 0;
	};

	typedef ::Core::Var <IBaseWriter> IBaseWriter_var;
	typedef ::Core::Var <const IBaseWriter> IBaseWriter_cvar;

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// Интерфейс писателя в формат ENDT

	class IEndtWriter
		: virtual public ::Core::IObject {
	public:
		virtual void set_document (unsigned long doc_id) = 0;
		virtual void create_para () = 0;
		virtual void add_text (const char* text, short code_page) = 0;
		virtual void add_style (const char* style, size_t style_len) = 0;
		virtual void flush () = 0;
	};

	typedef ::Core::Var <IEndtWriter> IEndtWriter_var;
	typedef ::Core::Var <const IEndtWriter> IEndtWriter_cvar;

	////////////////////////////////////////////////////////////////////////////////////////////////////
	// Фабрики

	struct BaseWriterFactory {
		static IBaseWriter* make (Base* base);
	};

	struct EndtWriterFactory {
		static IEndtWriter* make (Base* base);
	};

} // namespace 

#endif // __DATA_WRITERS_H
