////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Модуль: "NormDef.h"

#ifndef __NORM_DEF_H__
#define __NORM_DEF_H__

#include "stdbase.h"

namespace NormativeDefinitions {

	struct Properties {
		std::string in;   // путь к файлу с исходными данными
		std::string out;  // путь к файлу с результатом
	};

	//////////////////////////////////////////////////////////////////////////////////////////////

	class NormDef {
	public:
		NormDef (const std::string& path);

		virtual ~NormDef ();

	public:
		void execute (const Properties& properties);

	private:
		typedef std::vector <long> DocIds;

	private:
		void execute (const DocIds& ids, const std::string& out_path);

	private:
		Core::Aptr <Base> m_base;
	};

} // namespace NormativeDefinitions

#endif //__NORM_DEF_H__