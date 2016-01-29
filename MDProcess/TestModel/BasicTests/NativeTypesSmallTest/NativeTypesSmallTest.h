////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NativeTypesSmallTest/NativeTypesSmallTest.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NativeTypesSmallTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __TESTMODEL_BASICTESTS_NATIVETYPESSMALLTEST_H__
#define __TESTMODEL_BASICTESTS_NATIVETYPESSMALLTEST_H__

#include "shared/Core/sys/std_inc.h"

namespace BasicTests {
namespace NativeTypesSmallTest {

static const long LONG = 1;
static const char* STRING = "this is string";
static const std::string ASTRING = "this is a-string";

static const char CharConstantsArray [] = {a, b, c};

enum NewEnum {
	A
	, B
	, C
};

class NewException : public ::Core::Exception {
public:
	NewException ();	virtual ~NewException () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_property () const;

	void set_property (const std::string& property);

	const std::string& get_ro_property () const;

	void set_wo_property (const std::string& wo_property);

private:
	mutable char m_message[256];
	std::string m_attr;
	std::string m_property;
	std::string m_ro_property;
	std::string m_wo_property;
};

#pragma pack (push, 1)

// CONSTRAINT ERROR: "Cant use this type of attributes (FullCharStruct::char,ref-const,ref)"
// CONSTRAINT ERROR: "Cant use this type of attributes (FullCharStruct::char,ref-ref)"
struct FullCharStruct {
	char char_agr;
	const char const_char_agr;
	char& ref_char_agr;
	const char& constref_char_agr;
	Core::Box<char> char_ref;
	Core::Box<const char> const_char_ref;
	char* char_lnk;
	const char* const_char_lnk;
	char*& ref_char_lnk;
	const char*& constref_char_lnk;

	~FullCharStruct ();

	FullCharStruct (
		char char_agr_
		, char const_char_agr_
		, char ref_char_agr_
		, char constref_char_agr_
		, char char_ref_
		, char const_char_ref_
		, char* char_lnk_
		, const char* const_char_lnk_
		, char*& ref_char_lnk_
		, const char*& constref_char_lnk_
	);

	FullCharStruct (const FullCharStruct& copy);

	FullCharStruct& operator = (const FullCharStruct& copy);

	FullCharStruct ();
};

#pragma pack (pop)

typedef NewEnum NewEnumT;

/*union*/ class NewUnion {
public:
	class InvalidDiscrimenant: public Core::Exception {
		const char* what () const throw () {
			return "NewUnion - access to data by invalid discrimenant";
		}

		const char* uid () const /*throw ()*/ {
			return "NewUnion::InvalidDiscrimenant";
		}
	};

	NewUnion () : m_d ((NewEnum)-1) {
	}

	NewUnion (const NewUnion& c) : m_d ((NewEnum)-1) {
			switch (c.m_d) {
			case A:
				this->a_long (c.a_long());
				break;
			
			case B:
				this->b_new_enum_t (c.b_new_enum_t());
				break;
			
			case C:
				this->c_astring (c.c_astring());
				break;
			}
	}

	~NewUnion () {
		this->reset();
	}

	NewEnum d_ () const {
		return m_d;
	}

	long a_long () const /*throw (NewUnion::InvalidDiscrimenant)*/ {
		if (m_d != A) {
			throw InvalidDiscrimenant ();
		} else {
			return m_u.a_long;
		}
	}

	long& a_long () /*throw (NewUnion::InvalidDiscrimenant)*/ {
		if (m_d != A) {
			throw InvalidDiscrimenant ();
		} else {
			return m_u.a_long;
		}
	}
		
	void a_long (long val) {
		this->reset ();
		m_d = A;
		m_u.a_long = val;
	}

	NewEnumT b_new_enum_t () const /*throw (NewUnion::InvalidDiscrimenant)*/ {
		if (m_d != B) {
			throw InvalidDiscrimenant ();
		} else {
			return m_u.b_new_enum_t;
		}
	}

	NewEnumT& b_new_enum_t () /*throw (NewUnion::InvalidDiscrimenant)*/ {
		if (m_d != B) {
			throw InvalidDiscrimenant ();
		} else {
			return m_u.b_new_enum_t;
		}
	}
		
	void b_new_enum_t (NewEnumT val) {
		this->reset ();
		m_d = B;
		m_u.b_new_enum_t = val;
	}

	const std::string& c_astring () const /*throw (NewUnion::InvalidDiscrimenant)*/ {
		if (m_d != C) {
			throw InvalidDiscrimenant ();
		} else {
			return *m_u.c_astring;
		}
	}

	std::string& c_astring () /*throw (NewUnion::InvalidDiscrimenant)*/ {
		if (m_d != C) {
			throw InvalidDiscrimenant ();
		} else {
			return *m_u.c_astring;
		}
	}
		
	void c_astring (const std::string& val) {
		this->reset ();
		m_d = C;
		m_u.c_astring = new std::string (val);
	}

private:
	void reset () {
		switch (m_d) {
		case C:
			if(m_u.c_astring) {
				delete m_u.c_astring;
			}
			break;
		}
	}

private:
	NewEnum m_d;

	union {
		long a_long;
		NewEnumT b_new_enum_t;
		std::string* c_astring;
	} m_u;
};

} // namespace NativeTypesSmallTest
} // namespace BasicTests


#endif //__TESTMODEL_BASICTESTS_NATIVETYPESSMALLTEST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
