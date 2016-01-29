#ifndef __NDTCLONE_EXCEPTIONS_H__
#define __NDTCLONE_EXCEPTIONS_H__

#include <exception>
#include "shared/Core/sys/Logs.h"

namespace NdtClone {

	class InvalidBaseVersion {
	public:
		InvalidBaseVersion (long required, long actual);
		long required ();
		long actual ();

	private:
		long m_required;
		long m_actual;
	};

	class Error : public std::exception {
	public:
		Error ();
		virtual const char* what ();
		virtual ~Error () throw ();
	};

	class RecoveredIndex : public Error {
	public:
		RecoveredIndex (const std::string& index);
		virtual const char* what ();
		virtual ~RecoveredIndex () throw ();

	private: 
		std::string m_message;
	};

}

#endif
