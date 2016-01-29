///////////////////////////////////////////////////////////////////////////////
#ifndef	LEX_OPERATOR_H
#define	LEX_OPERATOR_H

#include "lex_parser.h"

///////////////////////////////////////////////////////////////////////////////

class	Sequence : public Parser {
public:
	Sequence(Parser &prev, Parser &next);
	~Sequence();

virtual	Match	Parse(const char *buf);

private:
	Parser	*m_prev;
	Parser	*m_next;
};

///////////////////////////////////////////////////////////////////////////////

class	Or : public Parser {
public:
	Or(Parser &a, Parser &b);
	~Or();

virtual	Match	Parse(const char *buf);

private:
	Parser	*m_a;
	Parser	*m_b;
};

///////////////////////////////////////////////////////////////////////////////

class	Not : public Parser {
public:
	Not(Parser &yes, Parser &no);
	~Not();

virtual	Match	Parse(const char *buf);

private:
	Parser	*m_yes;
	Parser	*m_no;
};

///////////////////////////////////////////////////////////////////////////////

class	Repeat : public Parser {
public:
	Repeat(Parser &parser, long minCount, long maxCount);
	~Repeat();

virtual	Match	Parse(const char *buf);

private:
	long	m_min;
	long	m_max;
	Parser	*m_parser;
};

///////////////////////////////////////////////////////////////////////////////

class	Action : public Parser {
public:
	Action(Parser &parser, CallAction callAction);
	~Action();

virtual	Match	Parse(const char *buf);

private:
	CallAction	m_callAction;
	Parser		*m_parser;
};

///////////////////////////////////////////////////////////////////////////////

Parser	&operator >> (Parser &prev, Parser &next);
Parser	&operator | (Parser &a, Parser &b);
Parser	&operator + (Parser &a);
Parser	&operator * (Parser &a);
Parser	&operator ! (Parser &a);
Parser	&operator - (Parser &yes, Parser &no);

#endif
///////////////////////////////////////////////////////////////////////////////
