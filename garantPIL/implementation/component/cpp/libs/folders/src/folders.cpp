#include "shared/Core/fix/mpcxc.h"
#include <cstdlib> // GARANT_GCC
#include <algorithm>

#include "folders.h"

#ifdef	__DPMI16__
#include "instutil.h"
#else
#endif

TTreeObject :: TTreeObject( TFolder *AOwner, char *AName )
{
	Owner = AOwner;

	Name = new char[ strlen( AName ) + 1 ];
	strcpy( Name, AName );

	if ( Owner == 0 )
	{
		Level = 0;
		FullName = new char[ strlen( AName ) + 1 ];
		strcpy( FullName, AName );
	}
	else
	{
		FullName = new char[ strlen( Owner -> FullName ) + strlen( Name ) + 2  ];
		strcpy( FullName, Owner -> FullName );
		strcat( FullName, "\\" );
		strcat( FullName, Name );

		Level = Owner -> Level + 1;
	}

	hIndexKey = (HIndex::HIndexKey*) malloc( std::max<unsigned int>( 128, strlen( AName ) + sizeof( HIndex::HIndexKey ) + 1 ) ); // GARANT_STL
}

TTreeObject :: ~TTreeObject()
{
	if ( Name ) delete( Name );
	if ( FullName ) delete( FullName );
	free( hIndexKey );
}

void	TTreeObject :: CalcKey( long& id, long parent )
{
	hIndexKey -> id = id;
	hIndexKey -> parent = parent;
	hIndexKey -> level = Level;
	hIndexKey -> achCount = AllChildrenCount();
	hIndexKey -> chCount = ChildrenCount();
	strcpy( hIndexKey -> text, Name );
	FindManager() -> NotifyObjectAdd( this );
}

TTreeObject*	TTreeObject :: FindObject( char *AName )
{
	if ( strcmp( AName, FullName ) == 0 ) return this;
	return 0;
}

TFolderManager* TTreeObject :: FindManager()
{
	if ( Owner )
	{
		TFolder* aOwner = Owner;
		while ( aOwner -> Owner ) aOwner = aOwner -> Owner;
		return (TFolderManager*) aOwner;
	}
	else
		return (TFolderManager*) this;
}

void	TTreeObject :: Rename( char* aName )
{
	if ( Name ) delete Name;
	Name = new char [ strlen( aName ) + 1 ];
	strcpy( Name, aName );

	if ( FullName ) delete FullName;
	FullName = new char[ strlen( Owner -> FullName ) + strlen( Name ) + 2  ];
	strcpy( FullName, Owner -> FullName );
	strcat( FullName, "\\" );
	strcat( FullName, Name );

	HIndex::HIndexKey* aOldKey = hIndexKey;
	hIndexKey = (HIndex::HIndexKey*) malloc( std::max<unsigned int>( 128, strlen( Name ) + sizeof( HIndex::HIndexKey ) + 1 ));
	memcpy( hIndexKey, aOldKey, sizeof( HIndex::HIndexKey ));
	strcpy( hIndexKey -> text, Name );
	free( aOldKey );
}

void	TTreeObject :: Delete( int )
{
	if ( Owner ) Owner -> NotifyDelete( this );
}

////////////////////////////////////////////////////////////////////////////////

void	TList :: CalcKey( long &id, long parent )
{
	id++;
	TTreeObject :: CalcKey( id, parent );
}

void	TList :: Delete( int aRealDelete )
{
	if ( aRealDelete )
	{
		char	AFullFileName[ MAXPATH ], AFileName[ 9 ];

		#ifdef	__DPMI16__
		MakePath( AFullFileName, FindManager() -> FoldersPath, mpcxc_ltoa( File, AFileName, 10 ));
		Del( AFullFileName );
		#else
		mpcxc_makepath(AFullFileName, 0, FindManager() -> FoldersPath, mpcxc_ltoa( File, AFileName, 10 ), 0);
	    remove( AFullFileName );
	    #endif
		FindManager() -> NotifyFileDel( File );
	}

	TTreeObject :: Delete();
}

void	TList :: Get( Store* str )
{
	long aFile; str -> Read( &aFile, sizeof( aFile ));
	SetFile( aFile );
}

void	TList :: Put( Store* str )
{
	str -> Write( &File, sizeof( File ));
}

void	TList :: SetFile( long AFile )
{
	File = AFile;
	FindManager() -> NotifyFileAdd( AFile );
}

void	TList :: StoreRefList( RefList* aRefList )
{
	char	AFullFileName[ MAXPATH ], AFileName[ 9 ];

#ifdef	__DPMI16__
	MakePath( AFullFileName, FindManager() -> FoldersPath, mpcxc_ltoa( File, AFileName, 10 ));
#else
	mpcxc_makepath(AFullFileName, 0, FindManager() -> FoldersPath, mpcxc_ltoa( File, AFileName, 10 ), 0);
#endif

	DOSFile	file( AFullFileName );
	aRefList -> Put( &file );
}

RefList*	TList :: GetRefList( Base* base )
{
	char	AFullFileName[ MAXPATH ], AFileName[ 9 ];

#ifdef	__DPMI16__
	MakePath( AFullFileName, FindManager() -> FoldersPath, mpcxc_ltoa( File, AFileName, 10 ));
#else
	mpcxc_makepath(AFullFileName, 0, FindManager() -> FoldersPath, mpcxc_ltoa( File, AFileName, 10 ), 0);
#endif

	DOSFile file( AFullFileName );
	if ( file.Length() > 0 )
	{
		RefList* refs = new RefList( base );
		refs -> Get( &file );
		return refs;
	}
	else
		return new RefList( base );
}

////////////////////////////////////////////////////////////////////////////////

TFolder :: TFolder( TFolder* AOwner, char* AName ) : TTreeObject( AOwner, AName )
{
	Folders = new TNameSortedCollection( sizeof( TTreeObject* ), 2000 );
	Lists   = new TNameSortedCollection( sizeof( TTreeObject* ), 2000 );
}

void	TFolder :: CalcKey( long& id, long parent )
{
	long aID = ++id;
	long I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < FoldersCount(); I++ )
	{
		TFolder* aFolder = (TFolder*)*(void**)(*Folders)[ I ];
		aFolder -> CalcKey( id, aID );
	}
	for ( I = 0; I < ListsCount(); I++ )
	{
		TList* aList = (TList*)*(void**)(*Lists)[ I ];
		aList -> CalcKey( id, aID );
	}
	TTreeObject :: CalcKey( aID, parent );
}

long	TFolder :: ChildrenCount()
{
	return ListsCount() + FoldersCount();
}

long	TFolder :: AllChildrenCount()
{
	long aCount = 0;
	for ( long I = 0; I < FoldersCount(); I++ )
	{
		TFolder* aFolder = (TFolder*)*(void**)(*Folders)[ I ];
		aCount += aFolder -> AllChildrenCount() + 1;
	}
	return aCount + ListsCount();
}

long	TFolder :: FoldersCount()
{
	return Folders -> ItemCount;
}

long	TFolder :: ListsCount()
{
	return Lists -> ItemCount;
}

TTreeObject*	TFolder :: FindObject( char* AName )
{
	TTreeObject* AResult = TTreeObject :: FindObject( AName );
	if ( !AResult ) for ( long I = 0; I < FoldersCount(); I++ )
	{
		TFolder* aFolder = (TFolder*)*(void**)(*Folders)[ I ];
		AResult = aFolder -> FindObject( AName );
		if ( AResult ) break;
	}
	if ( !AResult ) for ( long I = 0; I < ListsCount(); I++ )
	{
		TList* aList = (TList*)*(void**)(*Lists)[ I ];
		AResult = aList -> FindObject( AName );
		if ( AResult ) break;
	}
	return AResult;
}

void	TFolder :: Delete( int aRealDelete )
{
	long I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < FoldersCount(); I++ )
	{
		TFolder* aFolder = (TFolder*)*(void**)(*Folders)[ I ];
		aFolder -> Delete( aRealDelete );
		delete aFolder;
	}
	for ( I = 0; I < ListsCount(); I++ )
	{
		TList* aList = (TList*)*(void**)(*Lists)[ I ];
		aList -> Delete( aRealDelete );
		delete aList;
	}

	TTreeObject :: Delete();
}

void	TFolder :: NotifyDelete( TTreeObject* AObject )
{
	Collection* ACollection = AObject -> Tag() == FLD_FOLDER ? Folders : Lists;

	for ( long I = 0; I < ACollection -> ItemCount; I++ )
	{
		TTreeObject* aObject = (TTreeObject*)*(void**)(*ACollection)[ I ];
		if ( !strcmp( aObject -> Name, AObject -> Name ))
		{
			ACollection -> atDelete( I );
			break;
		}
	}

	//! FindManager() -> ReCalc();
}

void	TFolder :: Rename( char* aName )
{
	TTreeObject :: Rename( aName );

	long I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < FoldersCount(); I++ )
	{
		TFolder* aFolder = (TFolder*)*(void**)(*Folders)[ I ];
		aFolder -> Rename( aFolder -> Name );
	}
	for ( I = 0; I < ListsCount(); I++ )
	{
		TList* aList = (TList*)*(void**)(*Lists)[ I ];
		aList -> Rename( aList -> Name );
	}
}

void	TFolder :: Get( Store* str )
{
	long aFolders; str -> Read( &aFolders, sizeof( aFolders ));
	if( (aFolders < 0) || (aFolders > 64000) )
		return;
	long I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < aFolders; I++ )
	{
		char aFolderName[ 128 ]; 
		str -> Read( aFolderName, sizeof(aFolderName) );
		aFolderName[sizeof(aFolderName)-1]='\0';
		TFolder* aFolder = AddFolder( aFolderName );
		aFolder -> Get( str );
	}

	long aLists; str -> Read( &aLists, sizeof( aLists ));
	for ( I = 0; I < aLists; I++ )
	{
		char aListName[ 128 ]; 
		str -> Read( aListName, sizeof(aListName) );
		aListName[sizeof(aListName)-1]='\0';
		TList* aList = AddList( aListName );
		aList -> Get( str );
	}
}

void	TFolder :: Put( Store* str )
{
	long aFolders = FoldersCount(); str -> Write( &aFolders, sizeof( aFolders ));
	long I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < aFolders; I++ )
	{
		TFolder* aFolder = (TFolder*)*(void**)(*Folders)[ I ];
		char aFolderName[128]=""; 
		if (strlen(aFolder->Name)<sizeof(aFolderName)) {
			strcpy(aFolderName, aFolder->Name);
		} else {
			strncpy(aFolderName, aFolder->Name, sizeof(aFolderName)-1);
			aFolderName[sizeof(aFolderName)-1]='\0'; // на всякий случай
		}
		str -> Write( aFolderName, sizeof(aFolderName) );
		aFolder -> Put( str );
	}

	long aLists = ListsCount(); str -> Write( &aLists, sizeof( aLists ));
	for ( I = 0; I < aLists; I++ )
	{
		TList* aList = (TList*)*(void**)(*Lists)[ I ];
		char aListName[128]=""; 
		if (strlen(aList->Name)<sizeof(aListName)) {
			strcpy(aListName, aList->Name);
		} else {
			strncpy(aListName, aList->Name, sizeof(aListName)-1);
			aListName[sizeof(aListName)-1]='\0'; // на всякий случай
		}
		str -> Write( aListName, sizeof(aListName) );
		aList -> Put( str );
	}
}

TFolder* TFolder :: AddFolder( char* AFolderName )
{
	TTreeObject* aResult = FolderExist( AFolderName );
	if ( aResult ) return (TFolder*) aResult;
	TFolder* aFolder = new TFolder( this, AFolderName );
	Folders -> Insert( &aFolder );
	aFolder -> FindManager() -> NotifyObjectAdd( aFolder );
	return aFolder;
}

TList*	TFolder :: AddList( char* AListName )
{
	TList* aList = new TList( this, AListName );
	Lists -> Insert( &aList );
	aList -> FindManager() -> NotifyObjectAdd( aList );
	return aList;
}

TList*	TFolder :: NewList( char* AListName )
{
	TTreeObject* aResult = ListExist( AListName );
	if ( aResult ) return (TList*) aResult;
	TList* aList = new TList( this, AListName );
	Lists -> Insert( &aList );
	aList -> SetFile( aList -> FindManager() -> FirstAvailFile() );
	aList -> FindManager() -> NotifyObjectAdd( aList );
	return aList;
}

TList*	TFolder :: ListExist( char* AName )
{
	for ( long I = 0; I < ListsCount(); I++ )
	{
		TList* aList = (TList*)*(void**)(*Lists)[ I ];
		if ( !strcmp( aList -> Name, AName ))
			return aList;
	}

	return	0;
}

TFolder*	TFolder :: FolderExist( char* AName )
{
	for ( long I = 0; I < FoldersCount(); I++ )
	{
		TFolder* aFolder = (TFolder*)*(void**)(*Folders)[ I ];
		if ( !strcmp( aFolder -> Name, AName ))
			return aFolder;
	}

	return	0;
}

TTreeObject*	TFolder :: Exist( char* AName )
{
        TTreeObject*	aResult = FolderExist( AName );
        if ( aResult )
        	return aResult;
	else
		return ListExist( AName );
}

////////////////////////////////////////////////////////////////////////////////

TFolderManager :: TFolderManager( char* aUserPath, char* aBaseName, short aLanguage, int flg ) : TFolder( 0, ( aLanguage ? "Contents" : "ЋЈ« ў«Ґ­ЁҐ" ))
{
	FileNames = new Collection( sizeof( long ), 2000 );
	TreeObjects = new TTreeObjectsCollection( sizeof( TTreeObject* ), 2000 );

	if( flg == 0 )
	{
#ifdef	__DPMI16__
	MakePath( FoldersPath, aUserPath, "FOLDERS" );
	ace_os_mkdir( FoldersPath );
#else
	mpcxc_makepath(FoldersPath, 0, aUserPath, "FOLDERS", 0);
	ace_os_mkdir( FoldersPath );
#endif
	} else {
		strcpy(FoldersPath, aUserPath);
		int	i = strlen(FoldersPath) - 1;

		while( (i != 0) && (FoldersPath[i] != '\\') )
		{
			FoldersPath[i] = 0;
			i --;
		}
	}

	if(flg == 0)
		Load();
	else
		Load(aUserPath);
	ReCalc();
}

////////////////////////////////////////////////////////////////////////////////

TFolderManager :: ~TFolderManager()
{
	delete FileNames;
	delete TreeObjects;
	Delete( 0 );
}

void	TFolderManager :: ReCalc()
{
	long id = 0l;
	TreeObjects -> FreeAll();
	TFolder :: CalcKey( id, 0 );
}

void	TFolderManager :: Load(char *aFileName)
{
	char	*aFoldersFileName;

	if( aFileName == 0 )
	{
		aFoldersFileName = new char[ MAXPATH ];
#ifdef	__DPMI16__
		MakePath( aFoldersFileName, FoldersPath, "FOLDERS.BIN" );
#else
		mpcxc_makepath(aFoldersFileName, 0, FoldersPath, "FOLDERS", "BIN");
#endif
	} else
		aFoldersFileName = aFileName;

	DOSFile file( aFoldersFileName );
	if ( file.Length() > 0 ) TFolder :: Get( &file );
}

void	TFolderManager :: Save()
{
	char	aFoldersFileName[ MAXPATH ];
	char	bakFile[MAXPATH];

#ifdef	__DPMI16__
	MakePath( aFoldersFileName, FoldersPath, "FOLDERS.BIN" );
	MakePath( bakFile, FoldersPath, "FOLDERS.BAK" );
#else
	mpcxc_makepath(aFoldersFileName, 0, FoldersPath, "FOLDERS", "BIN");
	mpcxc_makepath(bakFile, 0, FoldersPath, "FOLDERS", "BAK");
	ace_os_unlink(bakFile);
	ace_os_rename(aFoldersFileName, bakFile);
#endif

	DOSFile file( aFoldersFileName );
	TFolder :: Put( &file );
}

long	TFolderManager :: FirstAvailFile()
{
	for ( long aFile = 0; ; aFile++ )
	{
		int aFound = 0;
		for ( long I = 0; I < FileNames -> ItemCount; I++ )
		{
			aFound = *(long*)(*FileNames)[ I ] == aFile;
			if ( aFound ) break;
		}
		if ( !aFound ) return aFile;
	}
}

void	TFolderManager :: NotifyFileAdd( long aFile )
{
	int	aFound = 0;
	for ( long I = 0; I < FileNames -> ItemCount && !aFound; I++ )
	{
		long atI = *(long*)(*FileNames)[ I ];
		aFound = atI == aFile;
	}

	if ( !aFound ) FileNames -> Add( &aFile );
}

void	TFolderManager :: NotifyFileDel( long aFile )
{
	for ( long I = 0; I < FileNames -> ItemCount; I++ )
	{
		long atI = *(long*)(*FileNames)[ I ];
		if ( atI == aFile )
		{
			FileNames -> atDelete( I );
			break;
		}
	}
}

void	TFolderManager :: NotifyObjectAdd( TTreeObject* aObject )
{
	TreeObjects -> Insert( &aObject );
}

char*	TFolderManager :: AddRefList( long aId, char* aListName, RefList* aRefList )
{
	TTreeObject* aObject = FindObjectById( aId );
	if ( aObject -> Tag() == FLD_FOLDER )
	{
		TList*	aList = ((TFolder*) aObject) -> NewList( aListName );
		aList -> StoreRefList( aRefList );
		return aList -> FullName;
	}
	else
	{
	        TList* aList = aObject -> Owner -> ListExist( aListName );
	        if ( aList )
	        {
	        	aList -> StoreRefList( aRefList );
	        	return aList -> FullName;
		}
	        else
	        {
			((TList*) aObject ) -> StoreRefList( aRefList );
			aObject -> Rename( aListName );
			return aObject -> FullName;
		}
	}
}

char*	TFolderManager :: AddFolder( long aId, char* aFolderName )
{
	TTreeObject *aObject = FindObjectById( aId );
	if ( aObject && aObject -> Tag() == FLD_FOLDER )
		return ( (TFolder*) aObject ) -> AddFolder( aFolderName ) -> FullName;
	else
		return 0;
}

void	TFolderManager :: DeleteObject( long aId )
{
	FindObjectById( aId ) -> Delete();
}

TTreeObject*	TFolderManager :: FindObjectById( long aId )
{
	for ( long I = 0; I < TreeObjects -> ItemCount; I++ )
	{
		TTreeObject *aObject = (TTreeObject*)*(void**)(*TreeObjects)[ I ];
		if ( aObject -> hIndexKey -> id == static_cast<unsigned int>(aId) )
			return aObject;
	}
	return 0;
}

TTreeObject*	TFolderManager :: FindObjectByName( char* aName )
{
	for ( long I = 0; I < TreeObjects -> ItemCount; I++ )
	{
		TTreeObject *aObject = (TTreeObject*)*(void**)(*TreeObjects)[ I ];
		if ( !strcmp( aObject -> FullName, aName ))
			return aObject;
	}
	return 0;
}

int	TFolderManager :: IsFolder( long aId )
{
	TTreeObject* aObject = FindObjectById( aId );
	if ( aObject )
		return aObject -> Tag() == FLD_FOLDER;
	else
		return 0;
}

RefList*	TFolderManager :: GetRefList( Base* base, long aId )
{
	TTreeObject *aObject = FindObjectById( aId );
	if ( aObject && aObject -> Tag() == FLD_LIST )
		return ( (TList*)aObject ) -> GetRefList( base );
	else
		return new RefList( base );
}

char*	TFolderManager :: Name( long aId )
{
	return FindObjectById( aId ) -> FullName;
}

void	TFolderManager :: RenameObject( long aId, char* aName )
{
	FindObjectById( aId ) -> Rename( aName );
}

////////////////////////////////////////////////////////////////////////////////

TBookmarksManager :: TBookmarksManager( char* aUserPath, char* aBaseName, int flg)
{

	if( flg == 0 )
	{
#ifdef	__DPMI16__
		MakePath( BookmarksPath, aUserPath, "FOLDERS" );
		ace_os_mkdir( BookmarksPath );
#else
		mpcxc_makepath(BookmarksPath, 0, aUserPath, "FOLDERS", 0);
		ace_os_mkdir( BookmarksPath );
#endif
	}

	BookmarkNames = new Collection( 80, 32 );
	Bookmarks     = new Collection( sizeof( MBookmark ), 32 );

	if( flg == 0)
		Load();
	else
		Load(aUserPath);
}

TBookmarksManager :: ~TBookmarksManager()
{
	delete BookmarkNames;
	delete Bookmarks;
}

int	TBookmarksManager :: IndexOfBookmark( char* aName )
{
	for ( int I = 0; I < BookmarkNames -> ItemCount; I++ )
	{
		char* atI = (char*)(*BookmarkNames)[ I ];
		if ( !strcmp( atI, aName )) return I;
	}

	return -1;
}

char*	TBookmarksManager :: GetBookmark( int aIndex )
{
	return (char*)(*BookmarkNames)[ aIndex ];
}

int	TBookmarksManager :: AddBookmark( char* aName, MBookmark mark )
{
	int	aIndex = IndexOfBookmark( aName );
	int	retv;

	retv = 1;

	if ( aIndex != -1 )
	{
		BookmarkNames -> atDelete( aIndex );
		Bookmarks     -> atDelete( aIndex );

		retv = 0;
	}

	BookmarkNames -> Add( aName );
	Bookmarks     -> Add( &mark );

	return retv;
}

void	TBookmarksManager :: DeleteBookmark( char* aName )
{
	int aIndex = IndexOfBookmark( aName );
	BookmarkNames -> atDelete( aIndex );
	Bookmarks     -> atDelete( aIndex );
}

void	TBookmarksManager :: Rename( char *aName, char* aNewName )
{
	int aIndex = IndexOfBookmark( aName );
	if ( aIndex != -1 )
	{
		BookmarkNames -> atDelete( aIndex );
		BookmarkNames -> atInsert( aIndex, aNewName );
	}
}

void TBookmarksManager::Reset( const char* aName, const MBookmark::Ver& data)
{
	int aIndex = IndexOfBookmark( (char*)aName );
	if ( aIndex != -1 )
	{
        MBookmark bmk=*(MBookmark*)(*Bookmarks)[aIndex];
        bmk.ver=data;
        Bookmarks->atDelete(aIndex);
        Bookmarks->atInsert(aIndex, &bmk);
	}
}

MBookmark TBookmarksManager :: GetBookmark( char* aName )
{
	return *(MBookmark*)(*Bookmarks)[ IndexOfBookmark( aName ) ];
}

void	TBookmarksManager :: Load(char *aFileName)
{
	char	*aBookmarksFileName;

	// Open from
	if( aFileName == 0 )
	{
		aBookmarksFileName = new char[MAXPATH];
#ifdef	__DPMI16__
		MakePath(aBookmarksFileName, BookmarksPath, "BOOKMARK.BIN" );
#else
		mpcxc_makepath(aBookmarksFileName, 0, BookmarksPath, "BOOKMARK","BIN");
#endif
	} else {
		aBookmarksFileName = aFileName;
	}

	DOSFile file( aBookmarksFileName );

	if ( file.Length() > 0 )
	{
		long aCount; file.Read( &aCount, sizeof( aCount ));
		if( (aCount < 0) || (aCount > 64000) )
			return;
		long I = 0; // GARANT_FORSCOPING
		for ( I = 0; I < aCount; I++ )
		{
			char aName[ 80 ]; 
            file.Read( aName, 80 );
			MBookmark  aMark;

			long aDocId; file.Read( &aDocId, sizeof( aDocId ));
			long aTopPara; file.Read( &aTopPara, sizeof( aTopPara ));
			short aTopLine; file.Read( &aTopLine, sizeof( aTopLine ));
			aMark.DocId = aDocId;
			aMark.TopPara = aTopPara;
			aMark.TopLine = aTopLine;
            //file.Read( &aMark, sizeof( aMark )-sizeof(aMark.ver));
            aMark.ver.init=0;
			AddBookmark( aName, aMark );
		}
		for (I = 0; I < aCount; I++ )
		{
            char* aName = GetBookmark( I );
            MBookmark::Ver aVer; 
            //if (file.Read(&aVer, sizeof(aVer))!=sizeof(aVer))
            //    break;
			Reset(aName, aVer);
		}
	}
}

void	TBookmarksManager :: Save()
{
	char	aBookmarksFileName[ MAXPATH ];

#ifdef	__DPMI16__
	MakePath( aBookmarksFileName, BookmarksPath, "BOOKMARK.BIN" );
#else
	mpcxc_makepath(aBookmarksFileName, 0, BookmarksPath, "BOOKMARK", "BIN");
#endif

	DOSFile file( aBookmarksFileName );

	long aCount = BookmarksCount(); file.Write( &aCount, sizeof( aCount ));
	long I = 0; // GARANT_FORSCOPING
	for ( I = 0; I < aCount; I++ )
	{
		char* aName = GetBookmark( I ); 
        file.Write( aName, 80 );
		MBookmark aMark = GetBookmark( aName ); 
        file.Write( &aMark, sizeof( aMark )-sizeof(aMark.ver));
	}
	for (I = 0; I < aCount; I++ )
	{
		char* aName = GetBookmark( I ); 
		MBookmark aMark = GetBookmark( aName ); 
        file.Write( &aMark.ver, sizeof( aMark.ver ));
	}
}

long	TBookmarksManager :: BookmarksCountInBase( Base* aBase )
{
	long	aCount = 0;
	for ( long I = 0; I < BookmarksCount(); I++ )
	{
		MBookmark	aMark = GetBookmark( GetBookmark( I ));
		if ( aBase -> FindDoc( aMark.DocId ))
			aCount++;
	}
	return aCount;
}

int	TBookmarksManager :: BookmarksInBase( Base* aBase )
{
	for ( long I = 0; I < BookmarksCount(); I++ )
	{
		MBookmark	aMark = GetBookmark( GetBookmark( I ));
		if ( aBase -> FindDoc( aMark.DocId ))
			return 1;
	}
	return 0;
}
