#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: document.cpp,v 2.114 2014/05/13 04:45:02 young Exp $
 */
//
// Class for access to paragraph-based documents
// supports infinite-sized documents, various para styles
//
// Author : Alex V. Boreskoff
//

#include "pack.h"
#include "check.h"
#include "base.h"
#include "gardefs.h"
#include "garutils.h"

#include "stdbase.h"

#include <cstring>

Document :: Document ( Base * b, long id, const DocInfo* OnlyTextDocByDoc)
{
	markDummy = 0;
	base     = b;
	runs     = 0;
	blocks   = 0;
	subs     = 0;

	runsT= 0;
	blocksT= 0;
	m_OnlyTextDocByDoc= 0;

	if( ADD_BLOCK_SIZE > b->currentBlockSize)
		m_currentBlockSize= ADD_BLOCK_SIZE;
	else
		m_currentBlockSize= b->currentBlockSize;

	if(OnlyTextDocByDoc){
		Stat= *OnlyTextDocByDoc;
		m_OnlyTextDocByDoc= 1;
		if(!b->new_docBuf)
			b->new_docBuf= (char *) malloc ( 2 * m_currentBlockSize + 1024 );
		Buf= b->new_docBuf;
	}else
		Buf      = (char *) malloc ( 2 * m_currentBlockSize + 1024 );

	hideMask = 0;

	Load( id, OnlyTextDocByDoc );
}

Document :: ~Document ()
{
	this->destroy ();
}

void Document::destroy () {
	if (!Buf)
		return;

	if (!base || (Buf != base->new_docBuf))
		free (Buf);

	if (base && !RunCount)
		for ( long i = 0; i < SubCount; i++ )
			for ( long j = 0; j < runs [i].Count; j++ )
				base->textFile -> DelPage ( runs [i].StartPage + j );

	heap ();
	FreeStructs ();
}

void	Document :: FreeStructs ()
{
	if(runsT){
		free(runsT);
		runsT= 0;
	}
	if(blocksT){
		free(blocksT);
		blocksT= 0;
	}
	markDummy = 0;
	if ( runs != 0 )
		gk_free ( runs );
	runs= 0;
	RunCount = 0;

	if ( blocks != 0 )
		gk_free ( blocks );
	blocks= 0;

	if ( subs != 0 )
		gk_free ( subs );

	SubCount = 0;
	subs = 0;
	subsLoaded = 0;
}

void	Document :: Reset ()
{
	markDummy = 0;
	CurBlock  = -10;// so every request for para will cause block reading
	FirstPara = -10;// so every request for para will cause block reading
	BlockParaCount = 0;			// no paragraphs yet
}

int	Document :: Load ( long id, const DocInfo* p_DocInfo )
{
	if ( Buf == 0 )
		return 0;

	FreeStructs ();
	Reset       ();

	DocId = id;
	if ( p_DocInfo ) {
		if ( !m_OnlyTextDocByDoc ) {
			DocId = -1;			// mark it as illegal
			return 0;
		}
	} else {
		if ( base -> FindDocInfo( DocId, Stat ) != sizeof ( DocInfo ) && !m_OnlyTextDocByDoc) {
			DocId = -1;			// mark it as illegal
			return 0;
		}
	}

	/*
	std::pair <void gk_huge*, void gk_huge*> data;
	base->LoadRunsBlocks (DocId, RunCount, BlockCount, data);
	runs = (PageRun*) data.first;
	blocks = (BlockRec*) data.second;
	*/
	runs   = (PageRun*)base ->LoadAttr( DocId, IDD_RUNS,   RunCount );
	blocks = (BlockRec*)base ->LoadAttr(DocId, IDD_BLOCKS, BlockCount );

	blocks= (BlockRec*)realloc(blocks, BlockCount * 2);
	memcpy((char*)blocks + BlockCount, (char*)blocks, BlockCount);

	RunCount   /= sizeof ( PageRun );
	BlockCount /= sizeof ( BlockRec );

	return 1;
}

int	Document :: IsOk () const
{
	return DocId > 0 && Buf != 0 && runs != 0 && blocks != 0;
}

unsigned char protected_para [81] = "\x10\x4A\x0\x8\x0\x0\x0\x0\x0\x8\x16\x0\x1\x0\x4\x0\x0\x0\x16\x0\x5\xFE\x32\x0\x0\x0\x31\x32\x33\x34\x35\x36\x37\x38\x39\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x30\x31\x32\x33\x34\x20\x20\x20\x20\x20\x20\x0\x0\x0\x0";

char  * Document :: GetPara ( long para )
{
	if ( para < 0 )
		return 0;

	if (!LockPara ( para ))
		return 0;

#ifdef	_GCD_SERVER
	if (DocId == PROTECTED_DOCID && para == Stat.ParaCount - 1)
		return (char*) protected_para;
#endif

	if ( para < FirstPara + ParaCount [0] )
		return Buf + ParaOffs1 [para - FirstPara];
	else
		return Buf + ParaOffs2 [para - FirstPara - ParaCount [0]];
}

long	Document :: GetParaOffs ( long para )
{
	LockPara ( para );

	if ( para < FirstPara + ParaCount [0] ){
		return CurBlock*(long)m_currentBlockSize+ParaOffs1 [para - FirstPara];
	}else{
		return CurBlock*(long)m_currentBlockSize+ParaOffs2[para-FirstPara-ParaCount[0]];
	}
}

void	Document :: LoadSubs()
{
	subsLoaded = 1;
	subs = (SubDesc*) base->LoadAttr (DocId, IDD_SUBS, SubCount);
	SubCount /= sizeof (SubDesc);
}

long	Document :: FindSub (long sub)
{
	if (sub == 0)
		return 0;

	if (!subsLoaded)
		LoadSubs ();

	SubDesc* result = (SubDesc*) bsearch (&sub, subs, SubCount, sizeof (SubDesc), compare_subdesc_subs);
	if (result)
		return result->Para;

	return 0;
}

bool	Document :: FindSub (long sub, long &para)
{
	para = 0;
	if (sub == 0)
		return true;

	if (!subsLoaded)
		LoadSubs ();

	SubDesc* result = (SubDesc*) bsearch (&sub, subs, SubCount, sizeof (SubDesc), compare_subdesc_subs);
	if (result) {
		para = result->Para;
		return true;
	}

	return false;
}

long	Document :: FindPara ( long Offs )
{
	LockBlock ( (int) ( Offs / m_currentBlockSize ) );

	Offs -= CurBlock * (long) m_currentBlockSize;
	int para;
	for ( para = 0; para < ParaCount [0]; para++ )
		if ( ParaOffs1 [para] > Offs )
			return FirstPara + para - 1;

	for ( para = 0; para < ParaCount [1]; para++ )
		if ( ParaOffs2 [para] > Offs )
			break;

	return FirstPara + ParaCount [0] + para - 1;
}

void	Document :: ProcBlock ( int no )
{
	int *paraOffs = ( no == 0 ? ParaOffs1 : ParaOffs2 );
	int	offs = no > 0 ? m_currentBlockSize + 512 : 0;
	int	count = 0;
	int size;

	for ( int i = 0; i < BlockSize[ no ]; i += HeaderSize( Buf + offs + i ) + size ) {
		size = TextSize( Buf + offs + i );

		paraOffs[count++] = offs + i;

		if ( size == 0 ) {
			if ( markDummy ) ParaStyle( Buf + offs + i ) |= PS_DUMMYBIT;
			continue;
		}

		if ( ParaStyle( Buf + offs + i ) != PS_EVD ) {
			int iStripSize = StripPara ( offs + i );

			if ( iStripSize ) {
				markDummy = 0;
				char *pTxt = ParaText( Buf + offs + i );
				if ( iStripSize > 1 || pTxt[ iStripSize - 1 ] == ' ' )
		        		while ( pTxt[--iStripSize] == ' ' )
						;
			}

			if ( iStripSize <= 0 ) { // paragraph cancelled, mark as dummy
				markDummy = 1;
				ParaStyle( Buf + offs + i ) |= PS_DUMMYBIT;
			}
		}
	}

	ParaCount[no] = count;
}

void	Document :: BuildParaTable ()
{
	ProcBlock ( 0 );
	ProcBlock ( 1 );

	BlockParaCount = ParaCount [0] + ParaCount [1];
	assert    ( BlockParaCount < MAX_PARA_PER_BLOCK );
}

int	Document :: StripPara ( int offs )
{
	char* text = ParaText(Buf + offs);
	int	size = TextSize(Buf + offs);
	int	attr = 0;

	assert ( size < m_currentBlockSize );
	int i, j;
	for ( i = 0, j = 0; i < size; i++) {
		if (IsAttr(text [i])) {
			attr ^= AttrFlag ( text [i] );

			if (AttrFlag(text[i]) & hideMask)	// toggle on/off inv. state
				continue;

			if (text[i] == AT_XREF && !(attr & AttrFlag(AT_XREF))) {
				if (text[i+1] == REFTYPE_REFLIST || text[i+1] == REFTYPE_BLOB) {

					int count = *(short*)(text+i+1+1);
					if (!count) count = 1;
					count *= sizeof ( Ref );

					if (!(attr&hideMask)) {
						assert ( i+count+3+1 <= size );
						assert ( count>0 );
	
						if ( j != i )
							memmove ( text + j, text + i, 1+3 + count );
	
						j += 3+1+count;
					}
					i += 2+1+count;
			
				} else {
					// assume we at REFTYPE_CLASS
					int count = strlen(text+i+2);
					count++; //nul
					if (!( attr & hideMask)) {
						if ( j != i )
							memmove ( text + j, text + i, 1+1+count );
						j += 2 + count;
					}
					i += 1 + count;
				}
			} else
				if (!(attr & hideMask))
					text [j++] = text [i];
		}
		else
		if ( ! ( attr & hideMask ) )
			text [j++] = text [i];
	}

//	while ( j > 0 && text [j-1] == ' ' )		// remove trailing spaces
//		j--;

	SetTextSize ( Buf + offs, j );

	return j;
}

int	Document :: FindBlock ( long para )
{
	if ( para < 0 || para >= Stat.ParaCount )
		return -1;
	int no;
	for ( no = 1; no < BlockCount && para >= blocks [no].FirstPara; no++ )
		;

	return no - 1;
}

#include "ncpf.h"

int Document :: read_block(int ino, char *iout)
{
	int ioffset= blocks [ino].Pos1, irun= 0
#ifdef NEW_PACK_BLOCKS
											, tagIndex= 0
#endif
															;
	while( ioffset >= runs [irun].Count)
		ioffset -= runs [irun++].Count;

#ifdef NEW_PACK_BLOCKS
	#if defined(GU)
		// только для одного последовательного чтения блоков за блоками в GU//
		if(m_currentBlockSize == ADD_BLOCK_SIZE && blocks [ino].Pos2 < 0){
			tagIndex= -blocks [ino].Pos2;
			blocks [ino].Pos2= blocks [ino].Pos1 + runs [irun].Count - 1;
		}
	#else
		if(m_currentBlockSize == ADD_BLOCK_SIZE && blocks [BlockCount+ino].Pos2 < 0){
			tagIndex= -blocks [BlockCount+ino].Pos2;
			blocks [ino].Pos2= blocks [ino].Pos1 + runs [irun].Count - 1;
		}
	#endif
#endif
	BlockHeader *ioutFirst= (BlockHeader *)iout;
	for ( int pos = blocks [ino].Pos1; pos <= blocks [ino].Pos2; pos++ )
	{	// page by page
		base -> textFile -> GetPage ( runs [irun].StartPage + ioffset, iout );

		if ( m_currentBlockSize == ADD_BLOCK_SIZE &&  ioutFirst->InPrePage ){
			memmove((char*)ioutFirst + sizeof(BlockHeader) + ioutFirst->InPrePage, (char*)ioutFirst + sizeof(BlockHeader) 
						, base -> textFile -> PageSize - sizeof(BlockHeader));
			char *pageBuff= (char*)alloca(base -> textFile -> PageSize);
			base -> textFile -> GetPage ( runs [irun].StartPage + ioffset - 1, pageBuff );
			memcpy((char*)ioutFirst + sizeof(BlockHeader),pageBuff + base -> textFile -> PageSize - ioutFirst->InPrePage
					, ioutFirst->InPrePage);
			iout += ioutFirst->InPrePage;
			ioutFirst->InPrePage= 0;
		}
		iout += base -> textFile -> PageSize;

		if ( ++ioffset >= runs [irun].Count )  // end of run
		{
			ioffset = 0;			// switch to next run
			irun++;
		}
	}
	return ioffset;
}

int	Document :: LoadBlock ( int no, char * buf )
{
	if ( no < 0 || no >= BlockCount || !IsOk ())
		return 0;

	char	    * ptr = buf;		// use given buffer to load packed data
	BlockHeader * Hdr = (BlockHeader *) ptr;// header of the block
						// locate PageRun containing 1st page of this block
	int i, run;
	/*i= */read_block(no,ptr);
	heap ();

	run=	Hdr -> SrcSize;
	i=		m_currentBlockSize + 512 - run;

	if ( Hdr -> Method == PM_ZIP )	{
		if (	base->utmp == 0 &&
				(base->utmp= (char*)malloc ( m_currentBlockSize )) == 0){
			MemoryError ();
		}else if(G_UNZIP(buf+sizeof(BlockHeader),run,base->utmp,run)){
#ifdef NEW_PACK_BLOCKS
			if(tagIndex){
				char *pArray= base->utmp;
				tagIndex--;
				while(tagIndex--){
					run= *(unsigned short*)pArray;
					pArray += sizeof(unsigned short) + run;
				}
				run= *(unsigned short*)pArray;
				memmove ( buf, pArray + sizeof(unsigned short), run );
				i= m_currentBlockSize + 512 - run;
			}else
#endif
				memmove ( buf, base->utmp, run );
			//memset ( buf+run, '\0', i );
		}else{
			OkBox ( "Attention", "Error unpacking" );
		}
	}else if ( Hdr -> Method == PM_STORED ){
		memmove ( buf, buf + sizeof ( BlockHeader ), run );
		memset ( buf+run, '\0', i );
	}else {
		OkBox ( "Attention", "Document : Unknown packing method %02d", 
				Hdr -> Method );
		return 0;
	}
	heap ();
	return run;
}

int	Document :: LoadNext ()
{
	if ( CurBlock + 1 >= BlockCount )
		return 1;

	CurBlock++;
	memmove ( Buf, Buf + m_currentBlockSize +  512, m_currentBlockSize + 512 );
	memmove ( ParaOffs1, ParaOffs2, MAX_PARA_PER_BLOCK * sizeof ( int ) );
	BlockSize [0]  = BlockSize [1];
	ParaCount [0]  = ParaCount [1];
	BlockSize [1]  = LoadBlock ( CurBlock + 1, Buf + m_currentBlockSize + 512 );
	FirstPara      = blocks [CurBlock].FirstPara;
	BlockParaCount = ParaCount [0];

	ProcBlock ( 1 );		// build para table for loaded block

	for ( int para = 0; para < ParaCount [0]; para++ )
		ParaOffs1 [para] -= m_currentBlockSize + 512;

	return 1;
}

int	Document :: LoadPrev ()
{
	if ( CurBlock < 1 )
		return 1;

	CurBlock--;
	memmove ( Buf + m_currentBlockSize + 512, Buf, m_currentBlockSize + 512 );
	memmove ( ParaOffs2, ParaOffs1, MAX_PARA_PER_BLOCK * sizeof ( int ) );

	ParaCount [1]  = ParaCount [0];
	BlockSize [1]  = BlockSize [0];
	BlockSize [0]  = LoadBlock ( CurBlock, Buf );
	FirstPara      = blocks [CurBlock].FirstPara;
	BlockParaCount = 0;

	ProcBlock ( 0 );

	BlockParaCount += ParaCount [1];

	for ( int para = 0; para < ParaCount [1]; para++ )
		ParaOffs2 [para] += m_currentBlockSize + 512;

	return 1;
}

int	Document :: LockPara ( long para )
{
	if ( para < FirstPara || para >= FirstPara + BlockParaCount ){
		if(!LockBlock ( FindBlock ( para ) ))
			return 0;
	}
	return 1;
}

int Document :: blocks_from_base( int no )
{
	if ( no == CurBlock - 1 )
		LoadPrev ();
	else if ( no == CurBlock + 2 )
		LoadNext ();
	else
	{
		if(	!(BlockSize [0] = LoadBlock ( no, Buf )))
			return 0;
		BlockSize [1] = LoadBlock ( no + 1, Buf + m_currentBlockSize + 512 );
		FirstPara     = blocks [no].FirstPara;
		CurBlock      = no;

		BuildParaTable ();
	}
	return 1;
}

int	Document :: LockBlock ( int no )
{
	if ( no < 0 )
		return 0;

	if ( no >= CurBlock && no <= CurBlock + 1 )
		return 1;

	return blocks_from_base(no);
}

char * Document :: GetParaTextBytes(long ID_Para, int *pRetStyle, long* pRetFlag, int *pRetSize)
{
	char  * ptr = GetPara ( ID_Para );
	if(!ptr)
		return 0;

	*pRetSize = EVDTextSize ( ptr );
	*pRetFlag = EVDFlags( ptr );
	*pRetStyle= (int)ParaStyle ( ptr );
	if(*pRetSize && (*pRetStyle == PS_EVD) && EVDCodePage(ptr) != CP_ANSI)
		*pRetStyle = PS_SIDEBYSIDE;
	return EVDParaText ( ptr, 0 );
}

long Document :: GetParaCount()
{
	return Stat.ParaCount;
}
long Document :: GetDocTextSize()
{
	return Stat.Size;
}
void *Document :: SetDocInfo( DocInfo *pNewInfo, long Id )
{
	return memcpy(&Stat, pNewInfo, sizeof(Stat));
}

static unsigned char Win2Dos[ 256 ] = {
/*0-15*/	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
		0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F,
/*32-*/		0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
		0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F,
/*64-*/		0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
		0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F,
/*96-*/		0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
		0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F,
/*128-*/	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D, 0x8E, 0x8F,
		0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9A, 0x9B, 0x9C, 0x9D, 0x9E, 0x9F,
/*160-*/	0xFF, 0xAD, 0x9B, 0x9C, 0x0F, 0x9D, 0xDD, 0x15,  240, 0x63, 242, 0xAE, 0xAA, 0x2D, 0x72, 244,
		0xF8, 0xFD, 0xFD, 0x33, 0x27, 0xE6, 0x14, 0xFA,  241, 0xFC, 243, 0xAF, 0xAC, 0xAB, 0x5F, 245,
/*192-*/	0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x8B, 0x8C, 0x8D, 0x8E, 0x8F,
		0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9A, 0x9B, 0x9C, 0x9D, 0x9E, 0x9F,
/*224-*/	0xA0, 0xA1, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xAB, 0xAC, 0xAD, 0xAE, 0xAF,
		0xE0, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xEB, 0xEC, 0xED, 0xEE, 0xEF 
};

void	EVDWin2Dos( char* aBuffer, long aLen )
{
	for ( long I = 0; I < aLen; I++, aBuffer++ ) {
		*aBuffer = Win2Dos[ (unsigned char)(*aBuffer) ];
	}
}

short	Document :: EVDCodePage( char* aPara )
{
	char	aParaStyle = ParaStyle( aPara );
	aPara = ParaText( aPara );
	if ( aParaStyle != PS_EVD )
		return CP_ANSI;

	long	flags = *(long*)aPara;
	aPara += ENDT_FLAGS_LEN;
	if ( *(short*)aPara == -1 )
		return CP_OEM;
	else
		return *(short*)aPara;
}

long	Document :: EVDFlags( char* aPara )
{
	char	aParaStyle = ParaStyle( aPara );
	aPara = ParaText( aPara );
	if ( aParaStyle != PS_EVD )
		return CP_ANSI;

	return *(long*)aPara;
}

char*	Document :: EVDParaText( char* aPara, bool convert2Dos )
{
	char	aParaStyle = ParaStyle (aPara);
	aPara = ParaText (aPara);
	if (aParaStyle != PS_EVD)
		return aPara;

	long	flags = *(long*)aPara;
	aPara += ENDT_FLAGS_LEN;
	short	codePage = *(short*)aPara;
	aPara += ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aPara += sizeof( long );
	long	aEVDLen = *(long*)aPara;
	aPara += aEVDLen + sizeof( aEVDLen );
	long aTextLen = *(long*)aPara;
	aPara += sizeof( aTextLen );

	/*
	if ( flags & ENDT_SBS ) {
		memcpy( EVDPara, aPara, aTextLen );
		EVDPara[ aTextLen ] = ' ';
		aPara += aTextLen;
		aEVDLen = *(long*)aPara;
		aPara += aEVDLen + sizeof( aEVDLen );
		long aTextLen2 = *(long*)aPara;
		aPara += sizeof( aTextLen2 );
		memcpy( EVDPara + aTextLen + 1, aPara, aTextLen2 );
		aTextLen += aTextLen2;
		aTextLen++;
	} else {
		memcpy( EVDPara, aPara, aTextLen );
	}
	*/
	memcpy (EVDPara, aPara, aTextLen);
	EVDPara [aTextLen] = 0;

	if (convert2Dos && codePage == CP_ANSI)
		EVDWin2Dos (EVDPara, aTextLen);
	return EVDPara;
}

short	Document :: EVDTextSize( char* aPara )
{
	char	aParaStyle = ParaStyle( aPara );
	if( aParaStyle != PS_EVD )
		return TextSize( aPara );

	aPara = ParaText( aPara );
	long	flags = *(long*)aPara;
	long	aENDTSize = ENDT_FLAGS_LEN + ENDT_CP_LEN;
	if ( flags & ENDT_HAS_BMP )
		aENDTSize += sizeof( long );
	aPara += aENDTSize;
	long	aEVDLen = *(long*)aPara;
	aPara += aEVDLen + sizeof( aEVDLen );
	long aTextLen = *(long*)aPara;
	aPara += sizeof( aTextLen );
	if ( flags & ENDT_SBS ) {
		aPara += aTextLen;
		aEVDLen = *(long*)aPara;
		aPara += aEVDLen + sizeof( aEVDLen );
		aTextLen += *(long*)aPara;
		aTextLen++;
	}
	return (short)aTextLen;
}
