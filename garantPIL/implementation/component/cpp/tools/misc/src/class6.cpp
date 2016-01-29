#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "osdep.h"
#include "stdbase.h"
#include "garver.h"
#include "gardefs.h"
#include "btiter.h"

Base* aBase;
HIndex* aClass6;

int	ProcessTopic( long aTopic, long parent, char level, char* aKeyText, long &aId )
{
	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)alloca(512);
	char aText[CLASS_KEY_SIZE], aNewText[CLASS_KEY_SIZE];
	RefCollection aRefs;

	strcpy(aKey->text,aKeyText);
	aKey->id=aId;
	aKey->level=level;
	aKey->parent=parent;
	aKey->chCount=aKey->achCount=0;

	bool	anythingAdded = false;

	Document* aDoc = aBase->GetDoc(aTopic);
	for ( int I = 0; I < aDoc->Stat.ParaCount; I++ ) {
		char* ptr = aDoc -> GetPara( I );
		if ( !ptr || !TextSize(ptr) ) continue;

		ptr = ParaText( ptr );
		gk_bzero(aText,sizeof(aText));

		aId++;
		if (!strchr(ptr+1,4)) {
			//�� ���� ������ ������� ��������� �� ����
			continue;
		}

		char* aSpace;
		for ( aSpace = ptr + 1; *aSpace == ' '; aSpace++ ) ;
		sprintf(aNewText,"%03d=%s",++aKey->chCount,strncpy(aText,aSpace,strchr(aSpace,4)-aSpace));
		for ( aSpace = &aNewText[ strlen( aNewText ) - 1 ]; *aSpace == ' '; aSpace-- ) *aSpace = '\0';
		//� aNewText - ��� ������ �����. �� ����� ���� ��� ���������, ��� � ��������

		ptr=strchr(strchr(ptr,4)+1,4)+2;
		short aRefCount = GetHTRefCount(*(short*)ptr);
		ptr+=2;
		if ( aRefCount == 1 && ((Ref*)ptr)->DocId < ID_BORDER && ((Ref*)ptr)->DocId > 0 ) {
			u_int32_t chCount = ProcessTopic(((Ref*)ptr)->DocId,aKey->id,aKey->level+1,aNewText,aId);
			if ( chCount )
				aKey->achCount += chCount + 1;
			else
				aKey->chCount--;
		} else {
			if ( aRefCount == 1 && ((Ref*)ptr)->DocId == -6 ) {
				aKey->chCount--;
				continue; // ��������� ����� ��������� �� www.garant.ru
			}

			//������������ ��� ��� �� gl��� �����
			aKey->achCount++;

			HIndex::HIndexKey* aLastKey = (HIndex::HIndexKey*)alloca(512);
			strcpy( aLastKey->text, aNewText );
			aLastKey->level = level+1;
			aLastKey->id = aId;
			aLastKey->parent = aKey->id;
			aLastKey->chCount=aLastKey->achCount=0;
			for ( int aRef = 0; aRef < aRefCount; aRef++, ptr += sizeof( Ref ) )
				aRefs.Collection::Add(ptr);

			Stream* str = aClass6->Index::OpenN(aLastKey,0,1);
			aRefs.Put(str);
			aClass6->Close(str);

			aRefs.FreeAll();
		}

		anythingAdded = true;
	}
	delete aDoc;

	if ( anythingAdded ) {
		Ref aRef; aRef.DocId=aTopic; aRef.Sub = 0;
		aRefs.Collection::Add(&aRef);
		Stream* str = aClass6->Index::OpenN(aKey,0,1);
		aRefs.Put(str);
		aClass6->Close(str);
	}

	return aKey->achCount;
}

void	CreateNode( long aId, long parent, char level, char* aKeyText, long chCount, long achCount )
{
	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)alloca(512);
	RefCollection aRefs;

	strcpy(aKey->text,aKeyText);
	aKey->id=aId;
	aKey->level=level;
	aKey->parent=parent;
	aKey->chCount=chCount;
	aKey->achCount=achCount;

	Stream* str = aClass6->Index::OpenN(aKey,0,1);
	aRefs.Put(str);
	aClass6->Close(str);
}

long	FindAux( char* aKey )
{
	ContextIndex* ind = (ContextIndex*) aBase->FindIndex( "Aux" );
	Stream* str = ind -> Open( aKey );
	if ( str == 0 )
		return 0L;

	long aDocId;
	long size = str->Length();
	if ( str -> Read( &aDocId, sizeof( aDocId )) < sizeof( aDocId ))
		aDocId = 0;

	ind -> Close( str );
	return aDocId;
}

long	CreateAuxNode( char* aAuxKey, long& aId, long parent, char level, char* aKeyText )
{
	long aDocId = FindAux( aAuxKey );
	if ( !aDocId )
		return 0;

	aId++;

	HIndex::HIndexKey* aKey = (HIndex::HIndexKey*)alloca(512);
	RefCollection aRefs;
	Ref aRef; aRef.DocId = aDocId; aRef.Sub = 0;
	aRefs.Collection::Add(&aRef);

	aKey->id=aId;
	aKey->level=level;
	aKey->parent=parent;
	strcpy(aKey->text,aKeyText);

	if ( aDocId < ID_BORDER ) {
		return ProcessTopic(aDocId,parent,level,aKeyText,aId);
	} else {
		aKey->chCount=aKey->achCount=0;
		Stream* str = aClass6->Index::OpenN(aKey,0,1);
		aRefs.Put(str);
		aClass6->Close(str);
		return 1;
	}
}

int main(int argc, char* argv[])
{
	if ( argc < 2 )
		return 0;

	aBase = new YBase( argv[ 1 ], ACE_OS_O_RDWR );
	aClass6 = (HIndex*)aBase->FindIndex("Class6");

	BTIterator* it;
	int zeros = 0;
	char* zeroparents = 0;
	for ( it = new BTIterator( aClass6 ); !it->End(); ++*it ) {
		if ( ((HIndex::HIndexKey*)it->Key())->parent == 0 ) {
			zeros++;
			if ( !zeroparents )
				zeroparents = (char*)malloc( CLASS_KEY_SIZE + sizeof( HIndex::HIndexKey ));
			else
				zeroparents = (char*)realloc( zeroparents, ( CLASS_KEY_SIZE + sizeof( HIndex::HIndexKey )) * zeros );
			memcpy( zeroparents + (zeros-1)*(CLASS_KEY_SIZE + sizeof( HIndex::HIndexKey )), it->Key(), CLASS_KEY_SIZE + sizeof( HIndex::HIndexKey ));
		}
	}
	delete it;
	for ( int akey = 0; akey < zeros; akey++ )
		aClass6->DeleteTree( zeroparents + (CLASS_KEY_SIZE + sizeof( HIndex::HIndexKey ))*akey );
	if ( zeroparents ) free( zeroparents );

	long aId = 1;
	long achCount = 0;
	long chCount = 0;

	if ( aBase->FindDoc(MAINMENU) ) {
		aId++;
		chCount++;
		achCount += ProcessTopic(MAINMENU, 1,1,"001=���㬥���",aId);
	}
	if ( aBase->FindDoc(PRAKMENU) ) {
		aId++;
		chCount++;
		achCount += ProcessTopic(PRAKMENU,1,1,"010=�㤥���� � �ࡨ�ࠦ��� �ࠪ⨪�",aId);
	}
	if ( aBase->FindDoc(INTMENU) ) {
		aId++;
		chCount++;
		achCount += ProcessTopic(INTMENU,1,1,"011=����㭠த�� ��������",aId);
	}
	if ( aBase->FindDoc(COMMENU) ) {
		aId++;
		chCount++;
		achCount += ProcessTopic(COMMENU,1,1,"004=�����᭥��� � ��������⥫����",aId);
	}
	if ( aBase->FindDoc(PROJMENU) ) {
		aId++;
		chCount++;
		achCount += ProcessTopic(PROJMENU,1,1,"009=�஥��� �������",aId);
	}
	if ( aBase->FindDoc(FORMENU) ) {
		aId++;
		chCount++;
		achCount += ProcessTopic(FORMENU,1,1,"005=���� �ࠢ���� ���㬥�⮢",aId);
	}
	if ( chCount ) CreateNode(1,0,0,"001=�ࠢ���� ��������",chCount,achCount+chCount);

	bool ecoPresent = false;
	long aEcoId = ++aId;
	achCount = chCount = 0;
	long aAuxCount=0;

	char	aBusNode[ 64 ];
	sprintf( aBusNode, "%d=������-�ࠢ��, �����ਭ�", FindAux( "Bus" ));	
	if ( aAuxCount=CreateAuxNode( "Bus",aId, aEcoId,1, aBusNode )) {
		chCount++;
		if ( aAuxCount > 1 ) achCount += aAuxCount;
	}
	char	aCaleNode[ 64 ];
	sprintf( aCaleNode, "%d=��������� ��壠���", FindAux( "Cale" ));	
	if ( aAuxCount=CreateAuxNode( "Cale",aId, aEcoId,1, aCaleNode )) {
		chCount++;
		if ( aAuxCount > 1 ) achCount += aAuxCount;
	}
	if ( chCount ) {
		CreateNode(aEcoId,0,0,"002=��ࠢ�筠� ���ଠ��",chCount,achCount+chCount);
		ecoPresent = true;
		++aId;
	}

	long aUpdateId = aId;
	achCount = chCount = aAuxCount = 0;
	if ( aBase->FindDoc(NEWMENU) ) {
		aId++;
		chCount++;
		achCount += ProcessTopic(NEWMENU,aUpdateId,1,"003=���� ���㬥���",aId);
	}
	char	aUserNode[ 64 ];
	sprintf( aUserNode, "%d=������ ���ଠ��", FindAux( "User" ));	
	if ( aAuxCount=CreateAuxNode( "User",aId, aUpdateId,1, aUserNode )) {
		chCount++;
		if ( aAuxCount > 1 ) achCount += aAuxCount;
	}

	char* 	aUpdateNode1 = "003=����������";
	char*	aUpdateNode2 = "002=����������";
	if ( chCount ) CreateNode(aUpdateId,0,0, ecoPresent ? aUpdateNode1 : aUpdateNode2,chCount,achCount+chCount);

	delete aBase;

	return 0;
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}




