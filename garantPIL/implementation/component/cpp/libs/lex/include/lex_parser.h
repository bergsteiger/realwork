///////////////////////////////////////////////////////////////////////////////
#ifndef	LEX_PARSER_H
#define	LEX_PARSER_H

typedef void (*CallAction)(const char *buf, long length);

///////////////////////////////////////////////////////////////////////////////

class	Match {
public:
	Match();
	Match(long ok, long length = 0);
	~Match();

			operator bool();
	char	*operator+(Match &match);
	bool	operator==(Match &match);
	long	length(void);
	void	length(long);
	long	ok(void);
	void	ok(long);
private:
	long	m_length;
	long	m_ok;
};

///////////////////////////////////////////////////////////////////////////////

class	Parser {
public:
	Parser();
	Parser(Parser &parser);
	~Parser();

	Parser	&operator [] (CallAction callAction);
virtual	Parser	&operator = (Parser &parser);

virtual	Match	Parse(const char *buf);
private:
	Parser	*m_parser;
};

#endif
///////////////////////////////////////////////////////////////////////////////
