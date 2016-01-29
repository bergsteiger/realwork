#include "shared/Core/fix/mpcxc.h"
////////////////////////////////////////////////////////////////////////////////
//
//  Вывод сообщений на экран и/или в файл
//  log.h
//  25/X/01 sawa
//  8/XI/01 sawa
//  CODE: Windows-1251, no tabs
//
////////////////////////////////////////////////////////////////////////////////
#if !defined(AFX_LOG_H__DF862119_6AA1_4BED_8A05_157A66DBE7E5__INCLUDED_)
#define AFX_LOG_H__DF862119_6AA1_4BED_8A05_157A66DBE7E5__INCLUDED_
////////////////////////////////////////////////////////////////////////////////
#include <fstream>
#include <exception>
#include <iostream>
#include <string>
#include <map>

#ifdef _MSC_VER
# pragma warning (disable: 4786)
#endif
////////////////////////////////////////////////////////////////////////////////
namespace Log {
////////////////////////////////////////////////////////////////////////////////
    enum Code { cUnknown, cWin, cDos, cKoi };
    enum WarningLevel { wlInfo=0, wlWarning=100, wlError=200, wlFatal=300 };
////////////////////////////////////////////////////////////////////////////////
    class Coder {
    public:
        char operator() (char c) const;
        char* operator()(char* s) const;
        const char* operator() (std::string& s) const;

        bool reset(Code src, Code dst);
        static const char* name(Code);

    private:
        static const struct Charset {
            Code code;
            const char* name;
            const char* table;
        } sets[];

        static const char* get_table(Code);

        std::map<char,char> m_map;
    };
////////////////////////////////////////////////////////////////////////////////
    class Stream {
    public:
        template <class T> struct Manipulator {
            Stream& (*m_f)(Stream&, T);
            T m_v;
            Manipulator(Stream& (*f)(Stream&, T), T v);
        };
        struct X : public std::exception {
            const char *what() const { return "Can't open log file"; }
        };

        Stream(const char* fileName=0) throw(X);
        bool ace_os_open(const char* fileName);
        Code original_code() const;
        Code file_code() const;
        Code console_code() const;
        const char* file_charset() const;
        const char* console_charset() const;

        Stream& set_console_echo(bool on);
        Stream& set_file_echo(bool on);
        Stream& set_source(const char* fileName);
        Stream& source_line(int n);
        Stream& set_warning_limit(WarningLevel lim);
        Stream& set_warning_level(WarningLevel lev);
        Stream& set_original_code(Code c);
        Stream& set_console_code(Code c);
        Stream& set_file_code(Code c);
        Stream& flush();

        Stream& operator<<(Stream& (*f)(Stream&));
        Stream& operator<<(char c);
        Stream& operator<<(const char* s);
        Stream& operator<<(bool n);
        Stream& operator<<(short n);
        Stream& operator<<(unsigned short n);
        Stream& operator<<(int n);
        Stream& operator<<(unsigned int n);
        Stream& operator<<(long n);
        Stream& operator<<(unsigned long n);
        Stream& operator<<(float n);
        Stream& operator<<(double n);
        Stream& operator<<(long double n);
        Stream& operator<<(void* n);
        template <class T> Stream& operator<<(const Manipulator<T>& m) {
            return m.m_f(*this, m.m_v);
        }

    private:
        std::ofstream m_file;
        std::string m_source;
        bool m_consoleEcho, m_fileEcho;
        WarningLevel m_warnLimit, m_warnLevel;
        Code m_originalCode, m_consoleCode, m_fileCode;
        Coder m_consoleCoder, m_fileCoder;
    };
/////// MANIPULATORS //////////////////////////////////////////////////////////
    Stream& endl(Stream& s);
    Stream& flush(Stream& s);
    Stream& info(Stream& s);
    Stream& warning(Stream& s);
    Stream& error(Stream& s);
    Stream& fatal(Stream& s);
    const Stream::Manipulator<bool> console(bool echoOn);
    const Stream::Manipulator<bool> file(bool echoOn);
    const Stream::Manipulator<Code> original(Code c);
    const Stream::Manipulator<Code> console(Code c);
    const Stream::Manipulator<Code> file(Code c);
    const Stream::Manipulator<const char*> source(const char* srcFileName);
    const Stream::Manipulator<int> source(int lineNumber);
    const Stream::Manipulator<WarningLevel> limit(WarningLevel lim);
    const Stream::Manipulator<WarningLevel> level(WarningLevel level);
////////////////////////////////////////////////////////////////////////////////
#include "_log.h" // inline definition
////////////////////////////////////////////////////////////////////////////////
}; // namespace Log
////////////////////////////////////////////////////////////////////////////////
#endif // !defined(AFX_LOG_H__DF862119_6AA1_4BED_8A05_157A66DBE7E5__INCLUDED_)
////////////////////////////////////////////////////////////////////////////////

