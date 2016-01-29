//
// WordFinder.h : header file
//

#ifndef __WORD_FINDER_H
#define __WORD_FINDER_H

#include "shared/Core/sys/std_inc.h"
#include "base.h"

class WordFinder {
	SET_OBJECT_COUNTER (WordFinder)

public:
	WordFinder (Base* base);

	virtual ~WordFinder ();

public:
	std::string execute (long doc_id, long para, short pos);

private:
	Base* m_base;
	Core::Aptr <Document> m_doc;
};

#endif // __WORD_FINDER_H
