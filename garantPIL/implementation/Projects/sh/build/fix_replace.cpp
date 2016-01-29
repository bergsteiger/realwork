#include <string>
#include <iostream>
#include <fstream>
#include <stdexcept>
#include <map>
#include <vector>

typedef std::vector<std::string> FileLineListType;

const unsigned int MY_FILE_LINE_SIZ = 65536;

// reads a line from file stream fs and modifies line count ln
bool read_file_line(std::ifstream& fs, std::string& ret, unsigned int& ln) {
static bool my_eof = false;
  if (my_eof) return false;
  char buf[MY_FILE_LINE_SIZ];
  buf[0]=char('\0');
  ++ln;
  bool fstate = bool(fs.getline(buf, MY_FILE_LINE_SIZ));
  if(!fstate && !fs.eof()) {
    throw std::logic_error(std::string("read_file_line: can not getline"));
  }
  ret = std::string(buf);
  my_eof = fs.eof();
  return true;
}

// reads a file given name fname to file line buffer flbuf
FileLineListType stream_to_list(std::ifstream& f) {
  FileLineListType flbuf;
  std::string cur_line;
  unsigned int line_no = 0;
  while (read_file_line(f, cur_line, line_no)) {
    flbuf.push_back(cur_line);  
  }
  return flbuf;
}

void list_to_stream(const FileLineListType& flbuf, std::ofstream& f) {
  for(FileLineListType::const_iterator it = flbuf.begin(); it != flbuf.end(); ++it) {
    f << *it << std::endl;
  }
}

struct ReplaceMode {
enum RM {
  WHOLE_WORD = 1,
  INCLUDE_PATH,
  FUNC_NAME,
  BINARY_SUBSTR
};
};

template<typename _T>
bool fix_is_cident(_T ch, const std::locale& loc) {
  return std::isalnum(ch, loc) || (ch == static_cast<_T>('_'));
}

bool fix_1st_nspace_notbrace(const std::string& str, std::string::size_type pos) {
  std::string::size_type cur_pos;
  std::string::size_type str_siz = str.size();
  for (cur_pos = pos; (cur_pos < str_siz) && std::isspace(str[cur_pos], std::locale::classic()); ++cur_pos);
  if (cur_pos == str_siz) {
    return false; // no C/C++ token found till end of line - it's function name
  }
  if (str[cur_pos] == '(') {
    return false; // open brace indicates this is function name
  }
  return true; 
}

std::string::size_type fix_find_str(
  const std::string& str
  , const std::string& strfrom
  , std::string::size_type prv_pos
  , ReplaceMode::RM rmode) {

  if (rmode == ReplaceMode::INCLUDE_PATH) {
    if (str.find("#include") == std::string::npos) {
      return std::string::npos; // nothing to do because it is not include path
    }
  }

  if (prv_pos == str.size()) {
    return std::string::npos;
  }
  std::string::size_type reti = str.find(strfrom, prv_pos);
//std::cout
//<<"reti = "<<reti<<std::endl
//<<"str = "<<str<<std::endl
//<<"strfrom = "<<strfrom<<std::endl
//<<"prv_pos = "<<prv_pos<<std::endl<<std::endl;  
  if (reti == std::string::npos) {
    return std::string::npos; // not found
  }
  if (rmode == ReplaceMode::BINARY_SUBSTR) {
//std::cout<<"ReplaceMode::BINARY_SUBSTR"<<std::endl;
    return reti;
  }
  if (reti > 0 ) {
    if (fix_is_cident(str[reti-1], std::locale::classic())) {
      return fix_find_str(str, strfrom, reti+strfrom.size(), rmode); // not whole word - find next
    }
    if (reti+strfrom.size() == str.size()) {
      return reti; // str ends with strfrom 
    }
    if (fix_is_cident(str[reti+strfrom.size()], std::locale::classic())) {
      return fix_find_str(str, strfrom, reti+strfrom.size(), rmode); // not whole word - find next
    }
    if (rmode == ReplaceMode::FUNC_NAME) {
      if (fix_1st_nspace_notbrace(str, reti+strfrom.size())) {
        return fix_find_str(str, strfrom, reti+strfrom.size(), rmode); // not found becouse it seems to be not a function name
      }
    }
    return reti;
  }
  if (reti+strfrom.size() == str.size()) { 
    return reti; // str ends with strfrom
  }
  if (fix_is_cident(str[reti+strfrom.size()], std::locale::classic())) {
    return fix_find_str(str, strfrom, reti+strfrom.size(), rmode); // not whole word - find next
  }
  if (rmode == ReplaceMode::FUNC_NAME) {
    if (fix_1st_nspace_notbrace(str, reti+strfrom.size())) {
      return fix_find_str(str, strfrom, reti+strfrom.size(), rmode); // not found becouse it seems to be not a function name
    }
  }
  return reti;
} 

std::string fix_replace_str(
  const std::string& str
  , const std::string& strfrom
  , const std::string& strto 
  , ReplaceMode::RM rmode
  , unsigned int& bb) {
  
    std::string ret;
    std::string::size_type fnd_pos;
    std::string::size_type prv_pos = 0;
    while( (fnd_pos = fix_find_str(str, strfrom, prv_pos, rmode)) != std::string::npos ) {
      ret += str.substr(prv_pos, fnd_pos - prv_pos);
      ret += strto; ++bb; // replace
      prv_pos = fnd_pos + strfrom.size();
    }
    ret += str.substr(prv_pos);
    return ret;
  
  }

FileLineListType fix_replace_list(
  const FileLineListType& flbuf
  , const std::string& strfrom
  , const std::string& strto
  , ReplaceMode::RM rmode
  , unsigned int& bb) {
  
  FileLineListType flret;
  for(FileLineListType::const_iterator it = flbuf.begin(); it != flbuf.end(); ++it) {
    flret.push_back(fix_replace_str(*it, strfrom, strto, rmode, bb));
  }
  return flret;
  
}

ReplaceMode::RM argv_to_replace_mode(const std::string& strmode) {
  if (strmode == "WHOLE_WORD") {
    return ReplaceMode::WHOLE_WORD;
  }
  if (strmode == "INCLUDE_PATH") {
    return ReplaceMode::INCLUDE_PATH;
  }
  if (strmode == "FUNC_NAME") {
    return ReplaceMode::FUNC_NAME;
  }
  if (strmode == "BINARY_SUBSTR") {
    return ReplaceMode::BINARY_SUBSTR;
  }  
  throw std::logic_error("bad rmode");
}

int main(int argc, char *argv[]) {

if (argc<5) {
  std::cerr<<"Usage: fix_replace <src_file> <str_from> <str_to> <rmode>"<<std::endl;
  return 1;
}

try {
/*
std::string test = "NULL_const char *x = 0;";
std::cerr<<test<<std::endl;
std::string::size_type test_pos = fix_find_str(test, "0", 0, ReplaceMode::WHOLE_WORD);
std::cerr<<((test_pos != std::string::npos) ? test[test_pos] : '~')<<std::endl;
std::string testo = fix_replace_str(test, "0", "0", ReplaceMode::WHOLE_WORD);
std::cerr<<testo<<std::endl;
*/
  
  FileLineListType mylinelistin;
  
  {
    std::ifstream fsrcin(argv[1]);
    if (!fsrcin) {
      throw std::logic_error("!fsrcin");
    }

    mylinelistin = stream_to_list(fsrcin);
  }
  
  unsigned int bblist = 0;
  FileLineListType mylinelistout = fix_replace_list(mylinelistin, argv[2], argv[3], argv_to_replace_mode(argv[4]), bblist);
  
  if(bblist != 0) {
    std::cerr<<"file: "<<argv[1];
    std::ofstream fsrcout(argv[1]);
    if (!fsrcout) {
      throw std::logic_error("!fsrcout");
    }
    list_to_stream(mylinelistout, fsrcout);
    std::cerr<<": "<<bblist<<" replacements"<<std::endl;
  }

}
catch(std::logic_error& e) {
std::cerr<<e.what()<<std::endl;
return 2;
}

}
