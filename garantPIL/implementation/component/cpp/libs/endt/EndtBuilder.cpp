//
// EndtBuilder.cpp : implementation file
//

#include "ace/ACE.h"
#include "ace/Dirent.h"
#include "ace/Dirent_Selector.h"

#include "common/components/rtl/Garant/EVD/eeReader.h"

#include "EndtBuilder.h"
#include "EndtGenerator_i.h"
#include "Writers.h"

namespace EndtTools {

struct EvdSelector {
	#define EVD_EXT ".evd"

	static int selector (const dirent* d) {
		if (!d->d_name) {
			return false;
		}

		size_t size = ACE_OS::strlen (d->d_name);

		if (size < 5) {
			return false;
		}

		return ACE_OS::strncmp (d->d_name + size - sizeof (EVD_EXT) + 1, EVD_EXT, sizeof (EVD_EXT) - 1) == 0 ? true : false;
	}

	#undef EVD_EXT
};

/////////////////////////////////////////////////////////////////////////////////////////////////////

class EndtBuilder_i
	: virtual public IEndtBuilder
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (EndtBuilder_i)

	public:
		EndtBuilder_i (Base* base);

		virtual ~EndtBuilder_i ();

	/////////////////////////////////////////////////////////////////////////////////////////////////////
	private:

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	private:
		void build (const char* buffer, size_t size);
		void write_test (const char* buffer, size_t size);

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// implemented interface's methods
	protected:
		virtual void build_all (const std::string& dir);
		virtual void build (const char* file_name);

	//////////////////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		Base* m_base;

		Core::Aptr <char, Core::ArrayDeleteDestructor <char> > m_buffer;

		IEndtWriter_var m_endt_writer;

		IBaseWriter_var m_base_writer;
};

//////////////////////////////////////////////////////////////////////////////////////////////////////

EndtBuilder_i::EndtBuilder_i (Base* base) : m_base (base) {
	m_endt_writer = EndtWriterFactory::make (base);
	m_base_writer = BaseWriterFactory::make (base);
}

EndtBuilder_i::~EndtBuilder_i () {
}

void EndtBuilder_i::build_all (const std::string& dir) {
	std::string directory = platform_independent_path (dir);

	ACE_Dirent_Selector selector;

	int status = selector.open (directory.c_str (), EvdSelector::selector);
	int len = selector.length ();

	GDS_ASSERT (status != -1);

	std::string path;

	directory += "\\";

	for (int i = 0; i < len; ++i) {
		path = directory + selector [i]->d_name;

		ACE_OS::printf ("%d: %s\n", i, path.c_str ());

		this->build (path.c_str ());
	}

	status = selector.close ();

	GDS_ASSERT (status != -1);
}

void EndtBuilder_i::build (const char* file_name) {
	int m_handle = ace_os_open (file_name, O_RDONLY | O_BINARY);

	try {
		if (m_handle != -1) {
			long file_size = ace_os_filesize (m_handle);

			if (file_size > 0) {
				m_buffer = new char [file_size + 1];

				int size = ace_os_read (m_handle, m_buffer.inout (), file_size);

				ace_os_close (m_handle);

				if (size > 0) {
					(m_buffer.ptr ()) [size] = '\0';

					this->build (m_buffer.in (), (size_t) size);
				}
			}
		}
	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
	}
}

void EndtBuilder_i::build (const char* buffer, size_t size) {
	EndtWriteFunction end_write_function (m_endt_writer.in ());
	evd::IeeGenerator_var generator = new EndtGenerator_i (&end_write_function, size, m_base_writer.in ());

	generator->Start ();
	{
		try {
			evd::EvdReader_var reader = new evd::EvdReader (buffer, static_cast<long> (size), generator.in ());
			reader->convert ();
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
		}
	}
	generator->Finish ();
}

void EndtBuilder_i::write_test (const char* buffer, size_t size) {
	int file = ace_os_open ("C:\\TEST\\test.evd", O_WRONLY | O_BINARY | O_CREAT | O_APPEND);

	if (file != -1) {
		ace_os_lseek (file, 0, ACE_OS_SEEK_END);
		ace_os_write (file, buffer, size);
		ace_os_close (file);
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////

IEndtBuilder* EndtBuilderFactory::make (Base* base) {
	return new EndtBuilder_i (base);
}

} // namespace

