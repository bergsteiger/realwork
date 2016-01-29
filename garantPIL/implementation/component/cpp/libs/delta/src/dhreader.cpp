#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: dhreader.cpp,v 2.40 2014/04/28 04:12:16 young Exp $
 */

#include "dhr_ver.h"
#include "dhreader.h"

#include <cstring> // GARANT_GCC

short DELTA_DATA_VERSION = DEFINE_DELTA_DATA_VERSION;

DHReader :: DHReader ( FILE* pfDelta, int iRewind ) : DeltaHeader ( pfDelta ) 
{
	fread ( &m_lTextSize, sizeof ( m_lTextSize ), 1, m_pfDelta );
	fseek ( m_pfDelta, m_lTextSize, SEEK_SET );

	fread ( &m_siDeltaVersion, sizeof ( m_siDeltaVersion ), 1, m_pfDelta );
	
	if ( false/*m_siDeltaVersion != DELTA_DATA_VERSION*/ ) {
		m_siSegCount = 0;
		m_pSegs = 0;
	} else {
		//
		// Проверочный байт
		//
		fread ( &m_lCRC, sizeof ( m_lCRC ), 1, m_pfDelta );
		fread ( &m_siCrypt, sizeof ( m_siCrypt ), 1, m_pfDelta );
		//
		// Количество сегментов
		//
		fread ( &m_siSegCount, sizeof ( m_siSegCount ), 1, m_pfDelta );
		//
		// Считываем сегменты
		//
		if (m_siSegCount > 0 && m_siSegCount < 600) {
			m_pSegs = (short*) malloc ( sizeof ( short ) * m_siSegCount );
			assert ( m_pSegs );
			fread ( m_pSegs, sizeof ( short ), m_siSegCount, m_pfDelta );
		} else {
			m_pSegs = 0;
		}

		//
		// Классы и ревизии
		//
		fread ( &m_lClassId, sizeof ( m_lClassId ), 1, m_pfDelta );
		fread ( &m_OldRev, sizeof ( m_OldRev ), 1, m_pfDelta );
		fread ( &m_NewRev, sizeof ( m_NewRev ), 1, m_pfDelta );
		
		//
		// Количество документов
		//
		fread ( &m_lDocCount, sizeof ( m_lDocCount ), 1, m_pfDelta );	

		//
		// Размер дельты
		//
		unsigned long	lOffset, lControlOffset;
		fpos_t		fpPos;

		//
		// Считываем размер дельты
		//
		fread ( &lOffset, sizeof ( lOffset ), 1, m_pfDelta );
		// запоминаем позицию
		fgetpos ( m_pfDelta, &fpPos );
#ifdef	linux
		if( fseek ( m_pfDelta, lOffset, SEEK_SET ) == 0 ) {
#else
		if (_fseeki64 ( m_pfDelta, lOffset, SEEK_SET ) == 0 ) {
#endif
			// читаем размер
			fread ( &lControlOffset, sizeof ( lControlOffset ), 1, m_pfDelta );
			// возвращаемся на старое место
			fsetpos ( m_pfDelta, &fpPos );
			m_iValidSize = ( lOffset == lControlOffset );
		} else {
			m_iValidSize = 0;
		}

		// Читаем размер заголовка
		long tellPos = ftell(m_pfDelta);
		m_ulHeaderSize = (tellPos == -1) ? 0 : static_cast<unsigned long>(tellPos);
	}
	if ( iRewind ) rewind ( m_pfDelta );
}

DHReader :: ~DHReader () 
{
	if ( m_pSegs ) free ( m_pSegs );
}

short* DHReader :: LoadSegs ( short & siCount ) 
{
	if ( !m_pSegs ) return 0;

	short * pRet = ( short* ) malloc ( m_siSegCount * sizeof ( short ) );
	assert ( pRet );

	memcpy ( pRet, m_pSegs, m_siSegCount * sizeof ( short ) );
	siCount = m_siSegCount;
	return pRet;
}

int DHReader :: IsOK () 
{
	if ( m_siDeltaVersion != DELTA_DATA_VERSION )
		 return DHRS_BADVER;
	if ( !m_iValidSize ) return DHRS_BADSIZE;
	return DHRS_OK; 
}


long DHProtWriter :: WriteProt ( long crc, short crypt )
{
	fpos_t fpPos;
	fgetpos ( m_pfDelta, &fpPos );
	
	fseek ( m_pfDelta, 0, SEEK_SET );
	
	long lTextSize;
	short siDeltaVersion;
	fread ( &lTextSize, sizeof ( lTextSize ), 1, m_pfDelta );
	fseek ( m_pfDelta, lTextSize, SEEK_SET );
	fread ( &siDeltaVersion, sizeof ( siDeltaVersion ), 1, m_pfDelta );
	
	/*
	if ( m_siDeltaVersion != DELTA_DATA_VERSION )
		 return DHRS_BADVER;
	 */

	m_lCRC = crc;
	m_siCrypt = crypt;
	if ( fwrite ( &m_lCRC, sizeof ( m_lCRC ), 1, m_pfDelta ) != 
		sizeof ( m_lCRC ) ) return DHRS_WRERR;
	if ( fwrite ( &m_siCrypt, sizeof ( m_siCrypt ), 1, m_pfDelta ) != 
		sizeof ( m_siCrypt ) ) return DHRS_WRERR;
		
	fflush ( m_pfDelta );
	fsetpos ( m_pfDelta, &fpPos);
	return DHRS_OK;
}
