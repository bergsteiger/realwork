#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>

#include "osdep.h"
#include "garver.h"
#include "basemask.h"

#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "hnode.h"

#include "long.SplaySet.h"
#include "long.long.SplayMap.h"
#include "fstring.h"

// now we use either 1 or 2 streams per key
#define MAX_STREAMS 2

//////////////// misc functions ///////////////////

int ansi[256];

static longSplaySet Docs;
static Base *base = 0;
static int counter = 0;

class D2HProcessor : public HNodeProcessor
{
public:
	virtual void doit(HNode *);
};

union Ref2Int64 {
	struct {
		u_int32_t docid;
		u_int32_t sub;
	} asref;
	u_int32_t  asint;
};


int usage ( char *str )
{
	fprintf ( stderr, "Usage: %s <base> <filename>\n", str);
	fprintf ( stderr, "\t<base>: current base\n");
	fprintf ( stderr, "\t<filename>: file name with doc IDs.\n");
	return 0;
}

void initAnsi()
{
	int i=128; 
	int a=192; 

	while(i<=175) {
		ansi[i]=a;
		i++;
		a++;
	}
	
	a=240;    
	i=224;
	
	while(i<=239) {
		ansi[i]=a;
		i++;
		a++;
	}
}

unsigned char ToAnsi(unsigned char c)
{
	switch(c) {
		case 179: c='|';break;
		case 180: c='+';break;
		case 191: c='+';break;
		case 192: c='+';break;
		case 193: c='+';break;
		case 194: c='+';break;
		case 195: c='+';break;
		case 196: c='-';break;
		case 197: c='+';break;
		case 217: c='+';break;
		case 218: c='+';break;
		default: break;
	}

	if((c>=128 && c<=175) || (c>=224 && c<=239)) c=ansi[c];
	return c;
}

void convertString(char*& _s, int _l)
{
	for (int i=0; i<_l; i++) _s[i] = ToAnsi(_s[i]);
}

unsigned char style = 0;

void D2HProcessor::doit(HNode * node)
{
	char FileName[20];
	gk_bzero(FileName,20);
	
	sprintf(FileName,"MENU_%ld.htm",node->n);

	FILE * f = 0;
	
	if ( node->level == -1 )
		f = mpcxc_fopen( "MENU_MAIN.htm", "w" );
	else
		f = mpcxc_fopen( FileName, "w" );
	
	char href[200];
	
	if (node->level != -1) {
		if (node->level == 0)
			sprintf(href, "<A HREF=./MENU_MAIN.htm><FONT COLOR=#009900>..</FONT></A><BR>\n\0");
		else
			sprintf(href, "<A HREF=./MENU_%ld.htm><FONT COLOR=#009900>..</FONT></A><BR>\n\0",node->parent->n);
		fputs(href,f);
	}
	
	if( node->lastn ) {
		for( int i = 0; i< node->lastn; i++ ) {
			HNode *t = &(node->childs[i]);
			sprintf(href, "<A HREF=./MENU_%ld.htm><FONT COLOR=#009900><H5>%s</H5></FONT></A><BR>\n\0",t->n,t->name+4);
			fputs(href, f);
		}
	} else {
		longSplaySet * ids = (longSplaySet *)(node->p);
		for (Pix i = ids->first(); i ; ids->next(i)) {
#ifdef	VERSION61
			char aName[ DOC_NAME_SIZE ];
			base->FindDocName((*ids)(i) + ID_BORDER, aName );

			char href[10000];
			int pos = sprintf(href, "<A HREF=./DOC_%ld.htm><FONT COLOR=#606060><H4>",(*ids)(i));

			int n = strlen( aName );
			if ( n ) {
				memcpy( href+pos, aName, ++n );
				pos += n;
			} else {
				pos += sprintf(href+pos, "Document %ld", (*ids)(i)+ID_BORDER);
			}

#else
			AttrKey k;
			k.DocId = (*ids)(i) + ID_BORDER;
			k.AttrTag = IDD_NAME;
			
			Stream *str = base -> docInd -> Open ( &k );
			
			char href[10000];
			int pos = sprintf(href, "<A HREF=./DOC_%ld.htm><FONT COLOR=#606060><H4>",k.DocId-ID_BORDER);
			
			if (str) {
				int n = str -> Length ( );
				if ( n ) {
					str -> Read ( href+pos, n );
					base -> docInd -> Close ( str );
					pos += n;
				} else {
					pos += sprintf(href+pos, "Document %ld", k.DocId);
				}
			} else {
				pos += sprintf(href+pos, "Document %ld", k.DocId);
			}
#endif
			sprintf(href+pos, "</H4></FONT></A><BR><BR>\n");
			
			fputs(href, f);
		}
	}

	fclose(f);
}

void flushMenu()
{
	fprintf ( stdout, "Creating menu ...");
	HNode * root = new HNode;

	for (Pix i = Docs.first(); i; Docs.next(i)) {
		AttrKey k;
		k.DocId = Docs(i) + ID_BORDER;
		k.AttrTag = IDD_DIV;

		Stream *str = base -> FindIndex( "Attrs" )-> Open ( &k );

		char * docClass = 0;

		if (str) {
			int n = str -> Length ( );
			if ( n ) {
				docClass = (char*) malloc ( n );
				str -> Read ( docClass, n );
				base -> FindIndex( "Attrs" ) -> Close ( str );
				char * p = docClass;
				while (p-docClass < n) {
					HNode * t = 0;
					root->addNode(strchr(p,':')+1,t);
					if (t->p == 0)
						t->p = new longSplaySet;
					longSplaySet * ids = (longSplaySet *)t->p;
					ids->add(Docs(i));
					p += strlen(p) + 1;
				}
			}
		}
	}

	if (root->lastn) {
		root->collapseSingleNodes();
		D2HProcessor d2h;
		root->process(&d2h);
	}
	fprintf ( stdout, "Ok\n");
}


void flushPara( FILE* f, char* para, long aDocId, long aPara )
{
	unsigned len = TextSize( para );
	unsigned char spec[6];
	gk_bzero(spec,6);

	if (len == 0) {
		if (style != 0) {
			if (style == PS_PREFORMATTED)	fputs("</FONT></PRE>\n",f);
			else if (style == PS_SIDEBYSIDE)	fputs("</FONT></TD></TABLE>\n",f);
			else	fputs("</P>\n",f);
			style = 0;
		}
		return;
	}

	if (style != ParaStyle(para)) {
		if (style != 0)	{
			if (style == PS_PREFORMATTED)	fputs("</FONT></PRE>\n",f);
			else if (style == PS_SIDEBYSIDE)	fputs("</FONT></TD></TABLE>\n",f);
			else	fputs("</P>\n",f);
		}

		switch(ParaStyle(para)) {
		case PS_CENTERED: {
				fputs("<P ALIGN=CENTER>",f);
				break;
			}
		case PS_JUSTIFIED: {
				fputs("<P ALIGN=JUSTIFY>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",f);
				break;
			}
		case PS_RIGHT: {
				fputs("<P ALIGN=RIGHT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",f);
				break;
			}
		case PS_PREFORMATTED: {
				fputs("<PRE><FONT SIZE=2>",f);
				break;
			}
		case PS_SIDEBYSIDE: {
				fputs("<TABLE WIDTH=\"100%\"><TD ALIGN=LEFT WIDTH=\"50%\"><FONT SIZE=2 FACE=\"Arial, Helvetica, Sans Serif\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",f);
				break;
			}
		}
		style = ParaStyle(para);
	} else {
		if (style != PS_PREFORMATTED && style != PS_SIDEBYSIDE)
			fputs("<BR>\n&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",f);
		else
			fputs("<BR>\n",f);
	}

	unsigned char* src = new unsigned char[len];
	memcpy(src,ParaText ( para ),len);
	//convertString((char*&)src,len);

	for (int i = 0; i < (int)len; i++) {
		if (src[i] > 6) {
			if (src[i] == '\t' && style == PS_SIDEBYSIDE) {
				fputs("</FONT></TD><TD ALIGN=RIGHT WIDTH=\"50%\"><FONT SIZE=2 FACE=\"Arial, Helvetica, Sans Serif\">",f);
			}
			fputc(ToAnsi(src[i]),f);
			continue;
		}

		if (src[i] == 4) {
			char * p = strchr((const char*)(src+i+1),4);
			short aCount = GetHTRefCount(*(short*)(p+2));
			if (aCount==1) {
				fputs("<A HREF=",f);
				int j;
				for (j = 0; j<aCount; j++) {
					Ref2Int64 rf;
					rf.asref.docid = *(u_int32_t *)(p+4+j*8);
					rf.asref.sub = *(u_int32_t *)(p+8+j*8);

					char href[100];
					if (rf.asref.sub)
						sprintf(href,"\"./DOC_%ld.htm#sub_para_N_%ld\">\0",rf.asref.docid-ID_BORDER, rf.asref.sub);
					else
						sprintf(href,"\"./DOC_%ld.htm\">\0",rf.asref.docid-ID_BORDER);
					fputs(href,f);
				}
				fputs("<FONT COLOR=#009900>",f);
				char * s = (char*)malloc(p-(char*)src-i+10);
				memcpy(s,src+i+1,p-(char*)src-i-1);
				s[p-(char*)src-i-1] = 0;
				convertString(s,strlen(s));
				fputs(s,f);
				fputs("</FONT></A>",f);
				free(s);
				i += p-(char*)src-i+1+2+j*8;
			} else {
				/*
				это старый код, который мультиссылку делает простым комментарием, без ссылок
				char * s = (char*)malloc(p-(char*)src-i+10);
				memcpy(s,src+i+1,p-(char*)src-i-1);
				s[p-(char*)src-i-1] = 0;
				convertString(s,strlen(s));
				fputs(s,f);
				fputs("</A>",f);
				free(s);
				*/

				//html с мультиссылками имеет имя: изкакоготопика_изкакогопараграфа_изкакойпозиции
				char FileName[ 256 ];
				sprintf( FileName, "DOCREFS_%ld_%ld_%ld.htm", aDocId, aPara, i );

				fputs("<A HREF=",f);
				char href[ 100 ];
				sprintf( href, "\"./%s\">\0", FileName );
				fputs( href, f );
				fputs("<FONT COLOR=#009900>",f);
				char * s = (char*)malloc(p-(char*)src-i+10);
				memcpy(s,src+i+1,p-(char*)src-i-1);
				s[p-(char*)src-i-1] = 0;
				convertString(s,strlen(s));
				fputs(s,f);
				fputs("</FONT></A>",f);
				free(s);

				//теперь собственно надо создать файл с мультиссылками
				FILE *ff = mpcxc_fopen( FileName, "w" );
				fputs("<PRE><FONT SIZE=2>\n",ff);
				for ( long aRefs = 0; aRefs < aCount; aRefs++ ) {
					fputs("<P ALIGN=JUSTIFY>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",ff);
					fputs("<A HREF=",ff);
					Ref2Int64 rf;
					rf.asref.docid = *(u_int32_t *)(p+4+aRefs*8);
					rf.asref.sub = *(u_int32_t *)(p+8+aRefs*8);

					char href[100];
					if (rf.asref.sub)
						sprintf(href,"\"./DOC_%ld.htm#sub_para_N_%ld\">\0",rf.asref.docid-ID_BORDER, rf.asref.sub);
					else
						sprintf(href,"\"./DOC_%ld.htm\">\0",rf.asref.docid-ID_BORDER);

					fputs(href,ff);

					fputs("<FONT COLOR=#009900>",ff);

					//сформировать имя ссылки
					char	buf[ 2 * DOC_NAME_SIZE ];
					char*	ss = buf;
					memset ( buf,  '\0', 2 * DOC_NAME_SIZE );
					int nameSize = base -> FindDocName( rf.asref.docid, buf );

					char	sub[ DOC_NAME_SIZE ];
					int subNameSize = base -> FindSubName( rf.asref.docid, rf.asref.sub, sub );
					if ( subNameSize > 0 )
						strcat( strcat( buf, ". " ), sub );

					convertString( ss, strlen( ss ));
					fputs( ss, ff );

					fputs("</FONT></A>",ff);
					fputs("</P>\n",ff);
				}
				fputs("</FONT></PRE>\n", ff );
				
				fclose( ff );

				i += p-(char*)src-i+1+2+aCount*8;
			}
			continue;
		}

		if (spec[(int)(src[i])] != 0) {
			fputs("</FONT>",f);
			spec[(int)(src[i])]--;
			continue;
		}

		fputs("<FONT COLOR=",f);
		switch(src[i]) {
		case 1: {
				fputs("#000099>",f);
				spec[1]++;
				break;
			}
		case 2: {
				fputs("#009900>",f);
				spec[2]++;
				break;
			}
		case 3: {
				fputs("#800080>",f);
				spec[3]++;
				break;
			}
		case 5: {
				fputs("#808080>",f);
				spec[5]++;
				break;
			}
		case 6: {
				fputs("#808000>",f);
				spec[6]++;
				break;
			}
		}
	}

	delete[] src;
}

int main ( int argc, char **argv )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_DOC2HTML;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** DOC2HTML Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	fprintf ( stderr, "Garant DOC -> HTML converter.\n" );

	if ( argc < 3 )
	       return usage ( argv [0] );

	base = new YBase ( argv [1], ACE_OS_O_RDONLY );

	if ( !base || !base -> IsOk ( ) ) {
		fprintf ( stderr, "Base %s not ok.\n", argv [1] );
		return usage ( argv [0] );
	}
	
	FILE * fd = mpcxc_fopen( argv[2], "r" );
	
	if( fd == 0 ) {
		fprintf ( stderr, "File %s not ok.\n", argv [2] );
		return 0;
	}

	char buf[20];

	while (fgets(buf,20,fd))
		Docs.add(atoi(buf));

	fclose(fd);

	if (Docs.length() == 0) {
		fprintf(stderr, "Nothing to process\n");
		return 0;
	}

	Index * idx = base->FindIndex("Attrs");

	initAnsi();
	SubDesc subs[16384];
	int nsubs = 0;

	flushMenu();

	for (Pix i = Docs.first(); i; Docs.next(i)) {
		fprintf ( stdout, "Processing document %ld ...", Docs(i));

		Document * doc = base -> GetDoc ( Docs(i) + ID_BORDER );

		if( !doc ) {
			fprintf(stdout, "Can't find document\n", Docs(i) );
			continue;
		}

		char FileName[20];
		gk_bzero(FileName,20);

		sprintf(FileName,"DOC_%ld.htm",Docs(i));
		FILE * f = mpcxc_fopen( FileName, "w" );

		fputs("<FONT SIZE=2 FACE=\"Arial, Helvetica, Sans Serif\">\n",f);

		AttrKey k;
		k.DocId = Docs(i) + ID_BORDER;
		k.AttrTag = IDD_SUBS;

		Stream *str = base -> FindIndex( "Attrs" ) -> Open ( &k );

		if (str) {
			int n = str -> Length ( );
			if ( n ) {
				str -> Read ( subs, n );
				base -> FindIndex( "Attrs" ) -> Close ( str );
				nsubs = n/sizeof(SubDesc);
			}
		}

		int j;
		longlongSplayMap sinfo(0);

		for ( j = 0; j < nsubs; j++ )
			sinfo[subs[j].Para] = subs[j].Sub;

		char sub_name[30];
		
		for ( j = 0; j < doc -> Stat.ParaCount; j++ ) {
			sprintf(sub_name,"\"sub_para_N_%ld\"",sinfo[j]);
			fputs("<A NAME=",f);
			fputs(sub_name,f);
			fputs("></A>\n",f);

			char  * ptr  = doc -> GetPara ( j );

			flushPara(f, ptr, Docs(i), j );
		}

		if (style != 0) {
			if (style == PS_PREFORMATTED)
				fputs("</FONT></PRE>\n",f);
			else
			if (style == PS_SIDEBYSIDE)
				fputs("</FONT></TD></TABLE>\n",f);
			else
				fputs("</P>\n",f);
		}
		fputs("</FONT>",f);

		delete doc;

		fclose(f);

		fprintf ( stdout, "Ok\n", Docs(i));
	}

	fprintf ( stdout, "\nTotal %ld documents processed.\n", Docs.length());

	return 0;
}




