/*
 * $Id: SharedData.h,v 1.20 2015/10/28 13:44:30 dolgop Exp $
 */

#ifndef __SHARED_DATA_H__
#define __SHARED_DATA_H__ 1

#include <algorithm>
#include <cstdlib>
//#include <strings.h> // GARANT_GCC
#include <cstring>
#include "osdep.h"

class LinkedObj
{
protected:
	unsigned long* m_semph;

public:
	LinkedObj () : m_semph (new unsigned long(1)) {}
	LinkedObj ( const LinkedObj &copy ) : m_semph (copy.m_semph) {
		(*m_semph)++;
	}
	virtual ~LinkedObj () {
		//release ();
	}
	LinkedObj& operator = (const LinkedObj &copy) {
		release ();
		m_semph = copy.m_semph;
		(*m_semph)++;

		return *this;
	}

	virtual void last_destroy() = 0;

protected:
	void release () {
		//assert ( *m_semph );
		(*m_semph)--;
		if ( !*m_semph ) {
			last_destroy();
			delete m_semph;	
		}		
	}
};

template <class Data>
class Shared
{
public:
	struct SharedNode
	{
		SharedNode (Data* d) : data (d), counter(1) {}; 
		virtual ~SharedNode () {
			if (data) delete [] data;
		};
		
		Data* data;
		unsigned long counter;
	};

protected :
	SharedNode* m_pNode;

	void release () {
		if ( m_pNode ) {
			m_pNode->counter--;
			if ( !m_pNode->counter ) {
				delete m_pNode;
				m_pNode = 0;
			}
		}
	}

	virtual int datacmp ( SharedNode* c ) {
		return m_pNode > c ? 1 : -1;
	}


public:
	Shared () 
		: m_pNode(0) {};
	Shared ( unsigned long size ) 
		: m_pNode ( new SharedNode ( new Data [size] ) ) {};
	Shared ( Data* data ) 
		: m_pNode ( new SharedNode ( data ) ) {};
	Shared ( const Shared<Data>& copy ) {
		m_pNode = copy.m_pNode;
		if ( m_pNode ) m_pNode->counter++;
	};
	virtual ~Shared () {
		release ();		
	};

	Shared<Data>& operator = (Shared<Data>& copy) {
		release ();		
		m_pNode = copy.m_pNode;
		if ( m_pNode ) m_pNode->counter++;
		return *this;
	};
	
	operator Data*() const {
		return m_pNode ? m_pNode->data : 0;
	};

	Data* operator = (Data* data) {
		if ( !m_pNode )
			m_pNode = new SharedNode ( data );
		else {
			if ( m_pNode->data )
				delete [] m_pNode->data;
			m_pNode->data = data;
		}
 		return m_pNode->data;
	};

	long operator > ( Shared<Data>& c ) {
		if ( m_pNode == c.m_pNode ) return 0;
		else if ( !m_pNode || !c.m_pNode ) return m_pNode != 0;
		else return datacmp ( c.m_pNode ) > 0;
	}
	
	long operator < ( Shared<Data>& c ) {
		if ( m_pNode == c.m_pNode ) return 0;
		else if ( !m_pNode || !c.m_pNode ) return c.m_pNode != 0;
		else return datacmp ( c.m_pNode ) < 0;
	}

	int operator == ( Shared<Data>& c ) {
		if ( m_pNode == c.m_pNode ) return 1;
		else if ( !m_pNode || !c.m_pNode ) return 0;
		else return datacmp ( c.m_pNode ) == 0;
	}

	int operator != ( Shared<Data>& c ) {
		if ( m_pNode == c.m_pNode ) return 0;
		else if ( !m_pNode || !c.m_pNode ) return 1;
		else return datacmp ( c.m_pNode ) != 0;
	}
};

template <class Data>
class SSized : public Shared <Data>
{
	struct SSizedNode : public Shared<Data>::SharedNode
	{
		SSizedNode (Data* d, unsigned long len)
			: Shared<Data>::SharedNode (d), length(len) {};		
		unsigned long length;
	};	

public:
	SSized () {};
	SSized ( unsigned long size ) {
		this->m_pNode = new SSizedNode ( new Data [size], size ); // GARANT_GCC
	};
	SSized ( Data* data, unsigned long len ) {
		this->m_pNode =  new SSizedNode ( data, len );
	};
	SSized ( const SSized<Data>& copy ) : Shared<Data> ( copy ) {};

	unsigned long Length () {
		return this->m_pNode ? ((SSizedNode*)this->m_pNode)->length : 0;
	}
	
	Data* operator = (Data* data) { return 0; };

	void*	GetData() { return this->m_pNode->data; }
	
protected:
	virtual int datacmp ( typename Shared<Data>::SharedNode* c ) { // GARANT_GCC
		return memcmp ( this->m_pNode->data, c->data, 
			std::min (((SSizedNode*)this->m_pNode)->length, ((SSizedNode*)c)->length ) );
	}	
};

typedef SSized<char> SMem;

class SString : public Shared<char>
{
public:
	SString () {};
	SString ( const char* data ) : Shared <char> (((unsigned long)(strlen(data)&0x7fffffff))+1) {
		strcpy ( m_pNode->data, data );
	};
	SString ( unsigned long size ) : Shared <char> (size) {
		bzero (m_pNode->data, size);
	};
	SString ( const SString& copy ) : Shared<char> (copy) {}
	
	char* operator = (const char* p) {
		char* copy = new char [strlen(p)+1];
		strcpy ( copy, p );
		return Shared<char>::operator = (copy);
	}

	virtual unsigned long Length () {
		return m_pNode ? ((unsigned long)(strlen ( m_pNode->data )&0x7fffffff)) : 0;
	}

	virtual char* c_str () {
		return m_pNode ? m_pNode->data : 0;
	}

	virtual int datacmp ( SharedNode* c ) {
		return strcmp ( m_pNode->data, c->data );
	}
};

#endif
