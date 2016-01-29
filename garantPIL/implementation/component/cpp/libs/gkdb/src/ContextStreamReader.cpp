
#include "ace/ACE.h"

#include "gar_defs.hpp"
#include "ContextStreamReader.h"
#include "refcol.h"

ContextStreamReader::ContextStreamReader ()
	: m_saved_data (0), m_pPosDocs(0), m_ii(-1), m_pre_pos(0), m_is_bindoc(true)
{
}

void ContextStreamReader::nextRef()
{
	lasted[0]= lasted[1];
	if(m_str2){
		if(m_str2->Read(lasted+1, sizeof(Ref)) == sizeof(Ref)){
			m_ii++;
		}else{
			m_ii= -1;
			if(m_str->Buf)
				free(m_str->Buf);
			m_str->Buf= 0;
			delete m_str;
			m_str2= 0;
		}
	}else{
		if((++m_ii) == m_pPosDocs->ItemCount)
			m_ii= -1;
		else
			lasted[1]= *(Ref*)(m_pPosDocs->Collection::GetItem(m_ii));
	}
}

long ContextStreamReader::Read(long Count)
{
	if(m_ii > -1){
		char *data= m_data+m_tail;
		long length= Count, m_pos;
		nextRef();
		if(m_ii > -1){
			long docIdLen;
			Ref *pNxt;

				pNxt= lasted+1;
				docIdLen= sizeof(pNxt->DocId);
				m_pos= (pNxt->Sub) - m_pre_pos;

					if(length >= docIdLen){
						delete [] m_saved_data;
						m_length= m_pos + docIdLen;
						data= m_saved_data= m_data = new char [m_length + 4]; //4
						m_data [m_length] = 0; //gk_bzero (m_data + m_length, 4);

						memcpy(data, &(pNxt->DocId), docIdLen);
						data += docIdLen;
						length -= docIdLen;
						length= m_str->Read (data, m_pos);
						data += length;
						m_pre_pos += length;
					}else{
						data += length;
					}

		}
		return (data - m_data) - m_tail;
	}else if(m_pPosDocs){
		return 0;
	}
	return m_str->Read(m_data+m_tail, Count);

}

ContextStreamReader::ContextStreamReader (Stream* str, char form, bool is_titles, RefCollection *pPosDocs)
{
	this->init (str, form, is_titles, pPosDocs);
}

void ContextStreamReader::init (Stream* str, char form, bool is_titles, RefCollection *pPosDocs)
{
	if(!str){
		m_saved_data= 0;
		return;
	}
	m_pPosDocs= pPosDocs;
	m_ii= -1;
	m_pre_pos= 0;
	m_is_bindoc= true;

	m_str2= 0;
	m_str = str;
	m_form = form;
	m_is_titles = is_titles;
	m_re= 0;

	if(m_pPosDocs){
		m_ii= 0;
		if(!m_pPosDocs->ItemCount){
			m_str2 = m_str;
			m_str= new Stream(m_str2->GetStreamsFile(), m_str2->GetRec()+ 2, 4, 12,0);
			if((m_str2->GetRec()+1)->header.realDataLength > 32)
				m_is_multi= true;
			else
				m_is_multi= false;
			m_length = sizeof(lasted->DocId)+((Ref*)(m_str2->Buf))[m_ii].Sub;
		}else{
			m_length = sizeof(lasted->DocId)+(((Ref*)(m_pPosDocs->Collection::GetItem(m_ii)))->Sub); // GARANT_STL
		}
	}else{
		m_tail= str->Length ();
		m_length = std::min <long> (0x10000, m_tail); // GARANT_STL
	}
	m_tail= 0;

	m_data = new char [m_length + 4];
	m_data [m_length] = 0;

	m_saved_data = m_data;

	if(m_ii > -1){
		lasted->Sub= 0;
		if(m_str2){
			m_str2->Read(lasted+1, sizeof(Ref));
		}else
			lasted[1]= *(Ref*)(m_pPosDocs->Collection::GetItem(m_ii));

		*(long*)m_data= lasted[1].DocId;
		m_pre_pos= lasted[1].Sub;
		if(m_str->Read (m_data+sizeof(lasted->DocId), m_pre_pos) != m_pre_pos){
			assert(0);
		}
		m_length= sizeof(lasted->DocId) + m_pre_pos;
	}else
		m_length= this->Read (m_length);
	m_tail = m_length;
}

ContextStreamReader::~ContextStreamReader () {
	if (m_saved_data) {
		delete [] m_saved_data;
	}
}

bool ContextStreamReader::readMore () {
	char* new_data = m_saved_data;
	long i;
	for (i = 0; i < m_tail; ++i) {
		*new_data = *m_data;
		++new_data;
		++m_data;
	}
	m_data = m_saved_data;
	m_length = this->Read (m_length - m_tail);

	if (m_length) {
		m_length += i;
		m_tail = m_length;
		return true;
	}

	return false;
}

bool ContextStreamReader::getNextRef (Ref& ref) {
	char form;
	bool result;

	if (m_form == -1) {
		if (m_is_titles) {
			do {
				result = this->getNextRef (ref, form);
			} while (ref.Sub > ContextSearch::DOC_BEGIN_WORD && result);
		} else {
			do {
				result = this->getNextRef (ref, form);
			} while (ref.Sub <= ContextSearch::DOC_BEGIN_WORD && result);
		}
	} else {
		if (m_is_titles) {
			do {
				result = this->getNextRef (ref, form);
			} while ((m_form != form || ref.Sub > ContextSearch::DOC_BEGIN_WORD) && result);

		} else {
			do {
				result = this->getNextRef (ref, form);
			} while ((m_form != form || ref.Sub <= ContextSearch::DOC_BEGIN_WORD) && result);
		}
	}

	return result;
}

void ContextStreamReader::transferSub(long &out)
{
	out = 0x3fffff & ((((*(long*)m_data) >> 15) << 14) | ((*(long*)m_data) & 0x3fff));

	if ((*(long*)m_data) & 0x800000) { // is blast word
		m_is_bindoc = true;
	}
	m_tail -= 3;
	m_data += 3;
}

bool ContextStreamReader::getNextRef (Ref& ref, char& form) {
	if (m_is_bindoc) {
		if (m_tail < 4 && !this->readMore ()) { //???!!!!!
			return false;
		}
		m_is_bindoc = false;
		ref.DocId = *(int*)m_data;
		m_data += 4;
		m_tail -= 4;
		m_re= 0;
	}
	if (m_tail < 2 && !this->readMore ()) {
		return false;
	}
	transferSub(ref.Sub);

	if (m_is_multi){
		if (m_tail < 1 && !this->readMore ()) {
			return false;
		}
		form = *m_data;
		m_data++;
		m_tail--;
	}else{ // is not form
		form = 0;
	}
	return true;
}

