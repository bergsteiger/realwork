#include "shared/Core/fix/mpcxc.h"
////////////////////////////////////////////////////////////////////////////////
//
//  Âûâîä ñîîáùåíèé íà ıêğàí è/èëè â ôàéë
//  log.cpp 
//  25/X/01 sawa
//  8/XI/01 sawa
//  CODE: Windows-1251, no tabs
//
////////////////////////////////////////////////////////////////////////////////
#include "log.h"

#include <cassert>

////////////////////////////////////////////////////////////////////////////////
/////// Coder //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
const Coder::Charset Coder::sets[] = {
    { cWin, "Windows-1251",
    "ÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞß"
    "àáâãäå¸æçèéêëìíîïğñòóôõö÷øùúûüışÿ" },

    { cDos, "DOS-866",
    "€‚ƒ„…ğ†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ"
    " ¡¢£¤¥ñ¦§¨©ª«¬­®¯àáâãäåæçèéêëìíîï" },

    { cKoi, "KOI-8R",
    "áâ÷çäå³öúéêëìíîïğòóôõæèãşûıÿùøüàñ"
    "ÁÂ×ÇÄÅ£ÖÚÉÊËÌÍÎÏĞÒÓÔÕÆÈÃŞÛİßÙØÜÀÑ" }
};
////////////////////////////////////////////////////////////////////////////////
char Coder::operator()(char c) const {

	std::map<char,char>::const_iterator it=m_map.find(c);
    if (it!=m_map.end()) {
        return it->second;
    } else {
        return c;
    }
}
////////////////////////////////////////////////////////////////////////////////
char* Coder::operator()(char* s) const {

    for (int i=0; s[i]; i++) {
        s[i]=(*this)(s[i]);
    }
    return s;
}
////////////////////////////////////////////////////////////////////////////////
const char* Coder::operator()(std::string& s) const {

    for (int i=0; i<s.size(); i++) {
        s[i]=(*this)(s[i]);
    }
    return s.c_str();
}
////////////////////////////////////////////////////////////////////////////////
bool Coder::reset(Code src, Code dst) {

    m_map.clear();
    if (src==dst) {
        return true;
    }
    const char* srcTable=get_table(src);
    const char* dstTable=get_table(dst);
    if (!srcTable || !dstTable) {
        return false;
    }
    assert(strlen(srcTable)==strlen(dstTable));

    while (*srcTable) {
        m_map[*srcTable++]=*dstTable++;
    }
    return true;
}
////////////////////////////////////////////////////////////////////////////////
const char* Coder::name(Code c) {

    for (int i=0; i<sizeof(sets)/sizeof(*sets); i++) {
        if (sets[i].code==c) {
            return sets[i].name;
        }
    }
    return "unknown";
}
////////////////////////////////////////////////////////////////////////////////
const char* Coder::get_table(Code c) {

    for (int i=0; i<sizeof(sets)/sizeof(*sets); i++) {
        if (sets[i].code==c) {
            return sets[i].table;
        }
    }
    return 0;
}
////////////////////////////////////////////////////////////////////////////////
/////// Stream /////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
Stream::Stream(const char* fileName) throw(X)
    : m_consoleEcho(true), m_fileEcho(false), m_warnLimit(wlInfo), 
    m_warnLevel(wlInfo), m_originalCode(cWin), m_consoleCode(cDos), 
    m_fileCode(cWin) {

    if (fileName && !ace_os_open(fileName)) {
        throw X();
    }

    m_consoleCoder.reset(m_originalCode, m_consoleCode);
    m_fileCoder.reset(m_originalCode, m_fileCode);
}
////////////////////////////////////////////////////////////////////////////////
bool Stream::ace_os_open(const char* fileName) {

    if (m_file.is_open()) {
        m_file.ace_os_close();
    }
    if (fileName) {
        m_file.ace_os_open(fileName);
    }
    if (m_file.is_open()) {
        m_fileEcho=true;
    } else {
        m_fileEcho=false;
    }
    return m_fileEcho;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::set_console_echo(bool flag) {

    m_consoleEcho=flag;
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::set_file_echo(bool flag) {

    m_fileEcho=flag;
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::set_source(const char* fileName) {

    m_source=(fileName?fileName:"");
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::source_line(int n) {

    *this << m_source.c_str() << '(' << n << ')' << ' ';
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::set_warning_limit(WarningLevel lim) {

    m_warnLimit=lim;
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::set_warning_level(WarningLevel lev) {

    m_warnLevel=lev;
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::set_original_code(Code c) {

    m_originalCode=c;
    m_consoleCoder.reset(m_originalCode, m_consoleCode);
    m_fileCoder.reset(m_originalCode, m_fileCode);
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::set_console_code(Code c) {

    m_consoleCode=c;
    m_consoleCoder.reset(m_originalCode, m_consoleCode);
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::set_file_code(Code c) {

    m_fileCode=c;
    m_fileCoder.reset(m_originalCode, m_fileCode);
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(char c) {

    if (m_warnLevel<m_warnLimit) {
        return *this;
    }
    if (m_consoleEcho) {
        cout << m_consoleCoder(c);
    }
    if (m_fileEcho) {
        m_file << m_fileCoder(c);
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(const char* s) {

    if (m_warnLevel<m_warnLimit || !s) {
        return *this;
    }
    if (m_consoleEcho) {
        string str(s);
        cout << m_consoleCoder(str);
    }
    if (m_fileEcho) {
        string str(s);
        m_file << m_fileCoder(str);
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(bool n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(short n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(unsigned short n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(int n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(unsigned int n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(long n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(unsigned long n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(float n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(double n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(long double n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
Stream& Stream::operator<<(void* n) {

    if (m_warnLevel>=m_warnLimit) {
        if (m_consoleEcho) {
            std::cout << n;
        }
        if (m_fileEcho) {
            m_file << n;
        }
    }
    return *this;
}
////////////////////////////////////////////////////////////////////////////////
/////// MANIPULATORS ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
Stream& Log::info(Stream& s) {

    s.set_warning_level(wlInfo);
    switch (s.original_code()) {
    case cWin:
        s << "ÈÍÔÎĞÌÀÖÈß";
        break;
    case cDos:
        s << "ˆ”Œ€–ˆŸ";
        break;
    case cKoi:
        s << "éîæïòíáãéñ";
        break;
    default:
        s << "INFORMATION";
    }
    return s << ':' << ' ';
}
////////////////////////////////////////////////////////////////////////////////
Stream& Log::warning(Stream& s) {

    s.set_warning_level(wlWarning);
    switch (s.original_code()) {
    case cWin:
        s << "ÏĞÅÄÓÏĞÅÆÄÅÍÈÅ";
        break;
    case cDos:
        s << "…„“…†„…ˆ…";
        break;
    case cKoi:
        s << "ğòåäõğòåöäåîéå";
        break;
    default:
        s << "WARNING";
    }
    return s << ':' << ' ';
}
////////////////////////////////////////////////////////////////////////////////
Stream& Log::error(Stream& s) {

    s.set_warning_level(wlError);
    switch (s.original_code()) {
    case cWin:
        s << "ÎØÈÁÊÀ";
        break;
    case cDos:
        s << "˜ˆŠ€";
        break;
    case cKoi:
        s << "ïûéâëá";
        break;
    default:
        s << "ERROR";
    }
    return s << ':' << ' ';
}
////////////////////////////////////////////////////////////////////////////////
Stream& Log::fatal(Stream& s) {

    s.set_warning_level(wlFatal);
    switch (s.original_code()) {
    case cWin:
        s << "ÔÀÒÀËÜÍÀß ÎØÈÁÊÀ";
        break;
    case cDos:
        s << "”€’€‹œ€Ÿ ˜ˆŠ€";
        break;
    case cKoi:
        s << "æáôáìøîáñ ïûéâëá";
        break;
    default:
        s << "FATAL ERROR";
    }
    return s << ':' << ' ';
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#ifdef TESTLOG
int main() {

    try {
        Stream log("test.txt");
        log << limit(Stream::wlInfo) << console(Stream::cDos);
        log << warning << source("text1.nsr") << source(121) << "Ïğèìåğ1\n";
        log.ace_os_open("test2.txt");
        log << console(false) << error << "Test2" << endl;
        log << console(true) << fatal << "Test3\n";
    }
    catch (std::exception& x) {
        std::cout << x.what() << std::endl;
    }
    return 0;
}
#endif // TESTLOG
////////////////////////////////////////////////////////////////////////////////



