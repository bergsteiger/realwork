//
// Common.cpp : implementation file
//

#include "ace/ACE.h"

#include <fstream>

#include "Common.h"

namespace Compiler {

TextFileParser::TextFileParser () {
}

TextFileParser::~TextFileParser () {
}

void TextFileParser::parse (const char* name, GCL::StrSet& out) {
	std::ifstream file_stream (name);

	if (!file_stream) {
		throw std::exception ();
	}

	std::string str;

	while (!file_stream.eof ()) {
		std::getline (file_stream, str);

		if (str.empty () == false) {
			out.insert (str);
		}
	}

	file_stream.close ();
}

void TextFileParser::parse_belongs (const char* name, StrIntMap& out) {
	std::ifstream file_stream (name);

	if (!file_stream) {
		throw std::exception ();
	}

	std::string str;

	while (!file_stream.eof ()) {
		std::getline (file_stream, str);

		size_t str_len = str.size (), counter = 0, first = 0;

		unsigned data = 0;

		for (size_t pos = 0; pos < str_len; ++pos) {
			if (str [pos] == ' ' || str [pos] == '\t' || pos == str_len - 1) {
				if (first) {
					std::string part (str.c_str () + first, pos - first);
					first = 0;
					++counter;

					if (counter == 1) {
						data = (unsigned) ACE_OS::atoi (part.c_str ());
					} else if (counter == 2) {
						out [part] = data;
						break;
					}
				}
			} else if (first == 0) {
				first = pos;
			}
		}
	}

	file_stream.close ();
}

/*
void TextFileParser::parse (const char* name, GCL::StrSet& out) {
	size_t len = this->read (name);

	GDS_ASSERT (len);

	const char* ptr = m_buffer.in ();

	for (size_t i = 0, first = 0; i < len; ++i) {
		if (ptr [i] == '\n' || i == len - 1) {
			out.insert (std::string (ptr + first, i - first - 1));
			first = i + 1;
		}
	}
}

void TextFileParser::parse_belongs (const char* name, StrIntMap& out) {
	size_t len = this->read (name);

	GDS_ASSERT (len);

	const char* ptr = m_buffer.in ();

	ifstream

	for (size_t i = 0, first = 0; i < len; ++i) {
		if (ptr [i] == '\n' || i == len - 1) {
			std::string str (ptr + first, i - first - 1);

			size_t str_len = str.size (), counter = 0, first_ = 0;

			unsigned data = 0;

			for (size_t pos = 0; pos < str_len; ++pos) {
				if (str [pos] == ' ' || pos == str_len - 1) {
					if (first_) {
						std::string part (str.c_str () + first_, pos - first_);
						first_ = 0;
						++counter;

						if (counter == 1) {
							data = (unsigned) ACE_OS::atoi (part.c_str ());
						} else if (counter == 2) {
							out [part] = data;
							break;
						}
					}
				} else if (first_ == 0) {
					first_ = pos;
				}
			}

			first = i + 1;
		}
	}
}

size_t TextFileParser::read (const char* name) {
	GDS_ASSERT (name);

	int ret = 0;

	try {
		int handle = ace_os_open (name, O_RDONLY);

		if (handle != -1) {
			long file_size = ace_os_filesize (handle);

			if (file_size > 0) {
				m_buffer = new char [file_size + 1];

				ret = ace_os_read (handle, m_buffer.inout (), file_size);

				ace_os_close (handle);

				if (ret > 0) {
					(m_buffer.ptr ()) [ret] = '\0';
				}
			}
		}
	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
	}

	return (size_t) ret;
}
*/

////////////////////////////////////////////////////////////////////////////////////////////////////////////

}