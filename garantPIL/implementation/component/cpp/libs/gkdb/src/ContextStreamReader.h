
#ifndef __CONTEXT_STREAM_READER_H
#define __CONTEXT_STREAM_READER_H

#include "index.h"

class RefCollection;

class ContextStreamReader {
public:
	ContextStreamReader ();
	ContextStreamReader (Stream*, char, bool is_titles = false, RefCollection *pPosDocs= 0);
	~ContextStreamReader ();

public:
	virtual void init (Stream* str, char form, bool is_titles, RefCollection *pPosDocs= 0);
	bool getNextRef (Ref&);

protected:
	virtual void transferSub(long &);
	bool getNextRef (Ref&, char&);
	bool readMore ();
	char* m_data;
	bool m_is_bindoc;
	long m_tail, m_re;

private:
	RefCollection *m_pPosDocs;
	long m_ii, m_pre_pos;

	long Read(long);
	void nextRef();

	Stream *m_str, *m_str2;
	Ref lasted[2];

	char* m_saved_data, m_form;

	long m_length;
	bool m_is_titles, m_is_multi;
};

#endif // __CONTEXT_STREAM_READER_H
