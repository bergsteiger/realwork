////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/sys/MdaGenSupport.h"
// C++ header files (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::sys::MdaGenSupport
//
// поддержка механизма фабрик интерфейсов используемых при генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_SYS_MDAGENSUPPORT_H__
#define __SHARED_CORE_SYS_MDAGENSUPPORT_H__

#include "ace/ACE.h"
#include "shared/Core/sys/Exception.h"

//#UC START# *450035C4008C_USER_INCLUDES*
#include <string>
//#UC END# *450035C4008C_USER_INCLUDES*

namespace Core {

// Method is generated but not implemented
class MDAGenNotImplemented : public ::Core::Exception {
public:
	MDAGenNotImplemented () : m_message ("MDAGenNotImplemented (Method is generated but not implemented)") {
		//#UC START# *45169212034B*
		//#UC END# *45169212034B*
	}
	// Создает исключение с указанием нереализованного элемента
	MDAGenNotImplemented (const char* message)
	//#UC START# *4516933B01A5_BASE_INIT*
	//#UC END# *4516933B01A5_BASE_INIT*
	{
		//#UC START# *4516933B01A5_BODY*
		m_message = "MDAGenNotImplemented (";
		m_message += message;
		m_message += " - generated, but not implemented)";
		//GDS_ASSERT_MSG (0, ("%s", m_message.data()));
		//#UC END# *4516933B01A5_BODY*
	}

	virtual ~MDAGenNotImplemented () throw () {
	}

	const char* what () const throw () {
		return m_message.data();
	}

private:
	const char* uid () const /*throw ()*/ {
		return "FB20AC5D-5615-4B58-953F-6FEC4F5636C2";
	}

protected:
	std::string m_message;
};

// Группа исключений связанных с работой фремворка фабрик
class FactoryEx : public ::Core::Exception {
public:

	virtual ~FactoryEx () throw () {
	}

	const char* what () const throw () {
		return m_message.data();
	}


protected:
	std::string m_message;
};

// No one servant was registers in factory
class UnknownFactoryKey : public FactoryEx {
public:
	// Создает исключение с указанием фабрики и ненайденного ключа
	UnknownFactoryKey (const char* factory_name, const char* key_name)
	//#UC START# *45169E2A0213_BASE_INIT*
	//#UC END# *45169E2A0213_BASE_INIT*
	{
		//#UC START# *45169E2A0213_BODY*
		m_message = "No one servant was registers in factory (";
		m_message += factory_name;
		m_message += ") with a given key (";
		m_message += key_name;
		m_message += ")";
		//#UC END# *45169E2A0213_BODY*
	}

	virtual ~UnknownFactoryKey () throw () {
	}

private:
	const char* uid () const /*throw ()*/ {
		return "42540CD0-2B0C-45F2-82DB-0474D2D29867";
	}
};

// No one servant was registers in factory
class NoActiveFactory : public FactoryEx {
public:
	// Создает исключение с указанием неактивированной фабрики
	NoActiveFactory (const char* factory_name)
	//#UC START# *4516A0060261_BASE_INIT*
	//#UC END# *4516A0060261_BASE_INIT*
	{
		//#UC START# *4516A0060261_BODY*
		m_message = "No one servant was registers in factory (";
		m_message += factory_name;
		m_message += ")";
		//#UC END# *4516A0060261_BODY*
	}

	virtual ~NoActiveFactory () throw () {
	}

private:
	const char* uid () const /*throw ()*/ {
		return "8C36CFDA-BB6F-4918-8A2D-730DCC298BD9";
	}
};

// Just one servant can registers in one factory
class DuplicatedFactoryKey : public FactoryEx {
public:
	// Создает исключение с указанием фабрики и дубицированного ключа
	DuplicatedFactoryKey (const char* factory_name, const char* key_name)
	//#UC START# *4516A06003D8_BASE_INIT*
	//#UC END# *4516A06003D8_BASE_INIT*
	{
		//#UC START# *4516A06003D8_BODY*
		m_message = "Just one servant can registers in one factory (";
		m_message += factory_name;
		m_message += ") with a same key (";
		m_message += key_name;
		m_message += ")";
		//#UC END# *4516A06003D8_BODY*
	}

	virtual ~DuplicatedFactoryKey () throw () {
	}

private:
	const char* uid () const /*throw ()*/ {
		return "61D48B2D-1A08-4261-9DE3-9396F3356539";
	}
};

// Class attributes accessed by cached functiuon was not initialized
class CachedAttrUninitialized : public ::Core::Exception {
public:
	CachedAttrUninitialized () : m_message ("CachedAttrUninitialized (Class attributes accessed by cached functiuon was not initialized)") {
		//#UC START# *452A33970236*
		//#UC END# *452A33970236*
	}
	// Создает исключение с указанием кешированной функции
	CachedAttrUninitialized (const char* func)
	//#UC START# *452A33CA0071_BASE_INIT*
	//#UC END# *452A33CA0071_BASE_INIT*
	{
		//#UC START# *452A33CA0071_BODY*
		m_message = "Class attributes accessed by cached functiuon (";
		m_message += func;
		m_message += ") was not initialized";
		//#UC END# *452A33CA0071_BODY*
	}

	virtual ~CachedAttrUninitialized () throw () {
	}

	const char* what () const throw () {
		return m_message.data();
	}

private:
	const char* uid () const /*throw ()*/ {
		return "0621C617-F979-4458-A14E-F3FAB4E2A587";
	}

protected:
	std::string m_message;
};

//#UC START# *450035C4008C_USER_DEFINITION*
//#UC END# *450035C4008C_USER_DEFINITION*

} // namespace Core


#endif //__SHARED_CORE_SYS_MDAGENSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
