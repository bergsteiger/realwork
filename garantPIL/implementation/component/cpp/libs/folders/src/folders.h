#ifndef	__GARANT_FOLDERS__
#define	__GARANT_FOLDERS__


#ifdef _WINDOWS
#include <direct.h>
#define MAXPATH 256
#else
   #ifdef WIN32
      #include <direct.h>
      #define MAXPATH 256
   #else
      #include <dir.h>
   #endif
//#include <dir.h>
#endif

#include "base.h"
#include "hindex.h"
#include "collect.h"
#include "reflist.h"

#define	FLD_ABSTRACT	0
#define	FLD_LIST	1
#define	FLD_FOLDER	2

struct	MBookmark
{
	long	DocId;
	long	TopPara;
	short	TopLine;
    struct Ver {
        short init;     // эшцхёыхфє■∙шх фрээ√х яЁюшэшЎшрышчшЁютрэ√ sawa
        short Status;
        struct date	LastDate;
    }       ver;
}__PACKED__;

class	TFolder;
class	TFolderManager;

class	TTreeObject
{
public:
	TFolder*		Owner;		// родитель
	char*			Name;		// короткое имя
	char*			FullName;	// полное имя
	char			Level;		// уровень дерева, на котором находится объект
	HIndex::HIndexKey*	hIndexKey;	// сформированный ключ

	TTreeObject( TFolder* AOwner, char* AName );
	~TTreeObject();

public:
	virtual	long	AllChildrenCount() { return 0; }
	virtual	long	ChildrenCount() { return 0; }

	virtual void	CalcKey( long&, long );
	virtual int	Tag() { return FLD_ABSTRACT; }
	virtual	void	Get( Store* ) {}
	virtual void	Put( Store* ) {}
	virtual void	Delete( int aRealDelete = 1 );
	virtual void	Rename( char* );

	virtual TTreeObject* FindObject( char* );

	TFolderManager*	FindManager();
};

class	TNameSortedCollection : public SortedCollection
{
public:
	TNameSortedCollection( int itemSize, int pageSize ) : SortedCollection( itemSize, pageSize ) {}
	TNameSortedCollection( const TNameSortedCollection &col ) : SortedCollection( col ) {}

	inline	virtual	int	Compare( const void * p1, const void * p2 ) const
	{
		char*	aName1 = ( (TTreeObject*)*(void**)p1 ) -> Name;
		char*	aName2 = ( (TTreeObject*)*(void**)p2 ) -> Name;
		return strcmp( aName2, aName1 );
	}
};

class	TTreeObjectsCollection : public SortedCollection
{
public:
	TTreeObjectsCollection( int itemSize, int pageSize ) : SortedCollection( itemSize, pageSize ) {}
	TTreeObjectsCollection( const TTreeObjectsCollection &col ) : SortedCollection( col ) {}

	inline	virtual	int	Compare( const void * p1, const void * p2 ) const
	{
		long	level1 = ( (TTreeObject*)*(void**)p1 ) -> hIndexKey -> level;
		long	level2 = ( (TTreeObject*)*(void**)p2 ) -> hIndexKey -> level;
		long	id1 = ( (TTreeObject*)*(void**)p1 ) -> hIndexKey -> id;
		long	id2 = ( (TTreeObject*)*(void**)p2 ) -> hIndexKey -> id;
		return level1 > level2 ? 1 : ( level1 < level2 ? -1 : ( id1 > id2 ? 1 : ( id1 < id2 ? -1 : 0 ) ) );
	}
};

class	TList : public TTreeObject
{
public:
	long	File;

	TList( TFolder* AOwner, char* AName ) : TTreeObject( AOwner, AName ) { File = -1; }

	void		StoreRefList( RefList* );
	RefList*	GetRefList( Base* );

public:
	void	SetFile( long AFile );

	virtual void	CalcKey( long&, long );
	virtual	void	Get( Store* );
	virtual void	Put( Store* );
	virtual void	Delete( int aRealDelete = 1 );
	virtual int	Tag() { return FLD_LIST; }
};

class	TFolder : public TTreeObject
{
public:
	TFolder( TFolder* AOwner, char* AName );

public:
	TNameSortedCollection	*Folders;
	TNameSortedCollection	*Lists;

	long	FoldersCount();
	long	ListsCount();

	TFolder*	AddFolder( char* );
	TList*		AddList( char* );
	TList*		NewList( char* );

	virtual long	AllChildrenCount();
	virtual	long	ChildrenCount();
	virtual void	CalcKey( long &id, long parent );
	virtual void	Delete( int aRealDelete = 1 );
	virtual int	Tag() { return FLD_FOLDER; }
	virtual void	Get( Store* );
	virtual void	Put( Store* );
	virtual	void	Rename( char* );

	virtual TTreeObject* FindObject( char* );

	void		NotifyDelete( TTreeObject* );
	TTreeObject*	Exist( char* );
	TList*		ListExist( char* );
	TFolder*	FolderExist( char* );
};

class	TFolderManager : public TFolder
{
public:
	TFolderManager( char*, char*, short, int = 0);
	~TFolderManager();

	long	ObjectsCount() { return TreeObjects -> ItemCount; }
	HIndex::HIndexKey* ObjectKey( long AIndex ) { return ( (TTreeObject*)*(void**)(*TreeObjects)[ AIndex ] ) -> hIndexKey; }

	char*		Name( long );
	int		IsFolder( long );
	char*		AddRefList( long, char*, RefList* );
	RefList*	GetRefList( Base*, long );
	char*		AddFolder( long, char* );
	void		DeleteObject( long );
	void		RenameObject( long, char* );

	void	Save();
	void	ReCalc();

	TTreeObject*	FindObjectById( long );
	TTreeObject*	FindObjectByName( char* );

public:
	char	FoldersPath[ MAXPATH ];

	long	FirstAvailFile();
	void	NotifyFileAdd( long );
	void	NotifyFileDel( long );
	void	NotifyObjectAdd( TTreeObject* );

private:
	Collection		*FileNames;
	TTreeObjectsCollection	*TreeObjects;
	
	void	Load(char *aFileName = 0);
};

class	TBookmarksManager
{
public:
	TBookmarksManager( char*, char*, int = 0 );
	~TBookmarksManager();

	void	Save();

	int		AddBookmark( char*, MBookmark );
	char*		GetBookmark( int );
	MBookmark	GetBookmark( char* );
	void		DeleteBookmark( char* );
	long		BookmarksCount() { return BookmarkNames -> ItemCount; }
	long		BookmarksCountInBase( Base* );
	int		BookmarksInBase( Base* );

	void		Rename( char*, char* );
    void		Reset( const char* name, const MBookmark::Ver& data);
	int		IndexOfBookmark( char* );

private:
	char		BookmarksPath[ MAXPATH ];
	Collection	*BookmarkNames;
	Collection	*Bookmarks;

	void	Load(char *aFileName = 0); // Load from standart path
};

#endif
