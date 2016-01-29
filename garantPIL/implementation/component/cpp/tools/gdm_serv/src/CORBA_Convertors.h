/*
 * $Id: CORBA_Convertors.h,v 1.5 2000/11/13 08:33:32 max Exp $
 */

#ifndef __CORBA_CONVERTORS_H__
#define __CORBA_CONVERTORS_H__ 1

#include "merger_i.h"
#include "SplaySet.h"
#include "deltamerger.h"

template <class Corba, class Ansi>
class Sequence_SplaySet_Convertor 
{
public:
	SplaySet<Ansi> operator () ( const Corba& c );
	Corba operator () ( const SplaySet<Ansi>& a );
};

template <class Corba, class Ansi>
SplaySet<Ansi> Sequence_SplaySet_Convertor<Corba, Ansi>::operator () ( const Corba& c )
{
	SplaySet<Ansi> set;

	for ( CORBA::ULong l = 0; l < c.length(); l++ ) {
		Ansi a ( c[l] );
		set.add ( a );
	}
	return set;
};

template <class Corba, class Ansi>
Corba Sequence_SplaySet_Convertor<Corba, Ansi>::operator () ( const SplaySet<Ansi>& a )
{
	Corba seq;//( a.length() );
	long len = a.length();
	seq.length( len );

	long l = 0;
	for ( Point p = a.first(); p; a.next(p) )
		seq[l++] = a(p);
	
	return seq;
};

template <class Data>
void operator<<=(CORBA::Any& _a, const SplaySet<Data>& _sp)
{
	Sequence_SplaySet_Convertor<ShortArr, unsigned short> conv;
	ShortArr _sa;
	_sa = conv ( _sp );	
	_a <<= _sa;
}

void operator <<=(CORBA::Any& _a, const Period& _per)
{
	StrPeriod sper = _per;
	_a <<= sper.old_date.date;
	_a <<= sper.old_date.time;
	_a <<= sper.new_date.date;
	_a <<= sper.new_date.date;
}

revision::operator StrRevision () const
{
	StrRevision s;
	char buf[128];
	sprintf ( buf, "%02d-%02d-%04d", RevisionDate.da_mon, 
		RevisionDate.da_day, RevisionDate.da_year );
	s.date = (const char*) buf;

	sprintf ( buf, "%02d-%02d-%02d-%02d", RevisionTime.ti_hour, 
		RevisionTime.ti_min, RevisionTime.ti_sec, RevisionTime.ti_hund);
	s.time = (const char*) buf;
	return s;
}

revision& revision::operator = ( const StrRevision& c )
{
	unsigned int s1, s2, s3, s4;
	sscanf ( c.date, "%2d-%2d-%4d", &s1, &s2, &s3 );
	RevisionDate.da_mon = (unsigned char)s1;
	RevisionDate.da_day = (unsigned char)s2;
	RevisionDate.da_year = s3;
	sscanf ( c.time, "%2d-%2d-%2d-%2d", &s1, &s2, &s3, &s4 );
	RevisionTime.ti_hour = (unsigned char)s1;
	RevisionTime.ti_min = (unsigned char)s2;
	RevisionTime.ti_sec = (unsigned char)s3;
	RevisionTime.ti_hund = (unsigned char)s4;
	return *this;
}

Period::operator StrPeriod () const
{
	StrPeriod s;
	s.old_date = old_date;
	s.new_date = new_date;
	return s;	
}

Period& Period::operator = ( const StrPeriod& c )
{
	old_date = c.old_date;
	new_date = c.new_date;
	return *this;
}

DeltaMerger::Settings::operator StrSettings () const
{
	StrSettings s;
	s.out_name = out_name;
	s.pic_enable = (CORBA::Short) pic_enable;
	s.rtf_enable = (CORBA::Short) rtf_enable;		
	Sequence_SplaySet_Convertor<ShortArr, unsigned short> conv;
	s.mrg_segs = conv(mrg_segs);
	s.period = period;
	return s;
}
DeltaMerger::Settings&  DeltaMerger::Settings::operator = ( const StrSettings& c ) 
{
	out_name = c.out_name;
	pic_enable = (int) c.pic_enable;
	rtf_enable = (int) c.rtf_enable;
	Sequence_SplaySet_Convertor<ShortArr, unsigned short> conv;
	mrg_segs = conv(c.mrg_segs);
	period = c.period;
	
	return *this;
}

DeltaMerger::InvalidVersion::operator Merger::LoadingExcept () const
{
	Merger::LoadingExcept ex;
	ex.ex_type = exInvalidVersion;
	ex.filename = m_filename;
	ex.ex_data <<= m_rightver;
	return ex;
}

DeltaMerger::InvalidSize::operator Merger::LoadingExcept () const
{
	Merger::LoadingExcept ex;
	ex.ex_type = exInvalidSize;
	ex.filename = m_filename;
	ex.ex_data <<= (short)0;
	return ex;
}

DeltaMerger::DifferentRev::operator Merger::LoadingExcept () const
{
	Merger::LoadingExcept ex;
	ex.ex_type = exDifferentRev;
	ex.filename = m_filename;
	ex.ex_data <<= m_diffrev;
	ex.ex_data <<= m_isOld;
	return ex;
}

DeltaMerger::DifferentClass::operator Merger::LoadingExcept () const
{
	Merger::LoadingExcept ex;
	ex.ex_type = exDifferentClass;
	ex.filename = m_filename;
	ex.ex_data <<= m_classId;
	return ex;
}

DeltaMerger::MultySegs::operator Merger::LoadingExcept () const
{
	Merger::LoadingExcept ex;
	ex.ex_type = exMultySegs;
	ex.filename = m_filename;
	ex.ex_data <<= (short)0;
	return ex;
}

DeltaMerger::Overlapping::operator Merger::LoadingExcept () const
{
	Merger::LoadingExcept ex;
	ex.ex_type = exOverlapping;
	ex.filename = m_filename;
	ex.ex_data <<= m_segs;
	return ex;
}

DeltaMerger::DifferentBody::operator Merger::LoadingExcept () const
{
	Merger::LoadingExcept ex;
	ex.ex_type = exDifferentBody;
	ex.filename = m_filename;
	ex.ex_data <<= m_id;
	return ex;
}

DeltaMerger::OpenError::operator Merger::LoadingExcept () const
{
	Merger::LoadingExcept ex;
	ex.ex_type = exFileOpenError;
	ex.filename = m_filename;
	ex.ex_data <<= (short)0;
	return ex;
}

DeltaMerger::UnexistPeriod::operator Merger::AssemblingExcept () const
{
	Merger::AssemblingExcept ex;
	ex.ex_type = exUnexistPeriod;
	ex.ex_data <<= (short)0;
	return ex;
}

DeltaMerger::UnexistSegs::operator Merger::AssemblingExcept () const
{
	Merger::AssemblingExcept ex;
	ex.ex_type = exUnexistSegs;
	ex.ex_data <<= m_segs;	
	return ex;
}

DeltaMerger::CreateError::operator Merger::AssemblingExcept () const
{
	Merger::AssemblingExcept ex;
	ex.ex_type = exFileOpenError;
	ex.ex_data <<= m_filename;
	return ex;
}

DeltaMerger::UnknownError::operator Merger::UnknownExcept  () const
{
	Merger::UnknownExcept  ex;
	ex.ex_type = exUnknownError;
	return ex;
}

DeltaMerger::UnknownError::operator Merger::AssemblingExcept () const
{
	Merger::AssemblingExcept ex;
	ex.ex_type = exUnknownError;
	return ex;
}

DeltaMerger::UnknownError::operator Merger::LoadingExcept () const
{
	Merger::LoadingExcept ex;
	ex.ex_type = exUnknownError;
	return ex;
}

#endif