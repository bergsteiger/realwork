////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/IO/IO.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::IO
//
// ����� ����������� �����-������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_H__
#define __SHARED_GCI_IO_H__

#include "shared/Core/sys/std_inc.h"

namespace GCI {
namespace IO {

// �� ����� ���������� �������� copy_to ���� �� �������, ������������� � �������� ������� �
// ������������ ���������.
class OperationError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������� �� �����������
class NotImplemented : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class String;
typedef ::Core::Var<String> String_var;
typedef ::Core::Var<const String> String_cvar;
// ��������� ��� ������ �� ��������. ��������������� ������������ ������ ���� ��� ��� ������ ��
// ����� ���������� �������.
class String
	: virtual public ::Core::IObject
{
public:
	// ������ ��������� ������
	virtual unsigned long get_length () const = 0;

	// ������ �������������� ������, ��� �������� ��������� ������
	virtual unsigned long get_maximum () const = 0;

	virtual void set_maximum (unsigned long maximum) = 0;

	// ��������� �� ������ ��������������� ������ (������)
	virtual const char* get_data () const = 0;

	// ������� ��������
	virtual short get_code_page () const = 0;

	virtual void set_code_page (short code_page) = 0;

	// ����������� ���������� ������. ���� ��������, �������� �����, ������ ��� strlen(str) + 1, ��
	// ����� ������ ����������� ������ ����� ������ + 1. ������ ��� ������������ �������� str ������
	// ���� �������� ���������� new[], ��� ��� � ����������� ���������� �������� delete[].
	virtual void reset (char* str, unsigned long maximum) = 0;

	// ������������� �������� ������ ������ ����������� (���������� ������ �����������)
	virtual void reset (const char* str) = 0;

	// ���������� �������� ����� ������
	virtual String* strdup () const = 0;

	// ��������� � ������ ���������� ���������, ���������� ��������� �� ���� �����
	virtual const char* add (const char* str) = 0;

	// ��������� � ������ ���������� ���������, ���������� ��������� �� ���� �����
	virtual const char* add (const String* str) = 0;

	// ���������� ����� ������ ������ ����������� ������� � ����������
	virtual char* join (const char* str) const = 0;

	// ���������� ����� ������ ������ ����������� ������� � ����������
	virtual char* join (const String* str) const = 0;
};

/// factory interface for String
class StringFactory {
public:
	// �������, �������� ������
	static String* make (const char* str)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// �������, �������� ������
	static String* create (const char* str, short code_page)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ����������� ���������� ������. ������ ��� ������������ �������� str ������ ���� ��������
	// ���������� new[], ��� ��� � ����������� ���������� �������� delete[].
	static String* take (char* str, short code_page)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� ������ ������, � ���������������� ������� ���������� �������
	static String* alloc (unsigned long maximum)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ����� �� ������� ��������� ��������. ��������� ������ ��������� �� �������� � MSDN-�������
enum StreamSeekDirection {
	SSD_BEGIN // �������� ������������ ������ ������
	, SSD_CURRENT // �������� ������������������� ������� � ������
	, SSD_END // �������� ������������ ����� ������
};

class Stream;
typedef ::Core::Var<Stream> Stream_var;
typedef ::Core::Var<const Stream> Stream_cvar;
// ��������� ��� ������ � �������
class Stream
	: virtual public ::Core::IObject
{
public:
	// �������� ������ �� ������, ���������� ���������� ����������� ������.
	virtual unsigned long read (void* buffer, unsigned long size) /*throw (OperationError)*/ = 0;

	// �������� ������ � �����. ���������� ���������� ���������� ������.
	virtual unsigned long write (const void* buffer, unsigned long size) = 0;

	// ����������� ������ ������. ���������� ����� ���� �� ������ ������.
	virtual unsigned long seek (long offset, unsigned long whence) /*throw (OperationError, NotImplemented)*/ = 0;

	// �������� ������ �� ������ ������ � ������.
	virtual void copy_to (
		Stream* dst
		, unsigned long size
		, unsigned long long& actually_read
		, unsigned long long& actually_written
	) /*throw (
		OperationError
	)*/ = 0;

	// ������� ���������� true ���� ��������� ����� ������.
	virtual bool eof () const = 0;

	// ���� ������������ true, ���������� ������ � ������� ����������
	virtual bool bad () const = 0;

	// ������ ����� ������
	virtual void clear () = 0;
};

/// factory interface for Stream
class StreamFactory {
public:
	// ������� ������ �����
	static Stream* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� ����� ��������� � ������
	static Stream* make (const char* path)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ��� ������������� �������� ������� ����� ������� �������, �����������.
struct DateTimeBox {
	// ���� � ������ (1-31)
	short day;
	// ����� � ���� (1-12)
	short mounth;
	// ���
	short year;
	// ��� (0-23)
	short hour;
	// ������ � ���� (0-59)
	short minute;
	// ������� � ������ (0-59)
	short second;
	// ������������ (0-999)
	short millisecond;
};

#pragma pack (pop)

class BinaryString;
typedef ::Core::Var<BinaryString> BinaryString_var;
typedef ::Core::Var<const BinaryString> BinaryString_cvar;
// ������ � ������� ����� ���� ������� �������
class BinaryString
	: virtual public String
{
};

/// factory interface for BinaryString
class BinaryStringFactory {
public:
	// �������, �������� ������ ��������� �������
	static BinaryString* make (const void* buffer, size_t size)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace IO
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::IO::String> {
	typedef GCI::IO::StringFactory Factory;
};
template <>
struct TypeTraits <GCI::IO::Stream> {
	typedef GCI::IO::StreamFactory Factory;
};
template <>
struct TypeTraits <GCI::IO::BinaryString> {
	typedef GCI::IO::BinaryStringFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_IO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
