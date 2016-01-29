#ifndef		__TNSCOLLECTION__
#define		__TNSCOLLECTION__

#define		ccNotFound	-1

char*	newStr( const char *s );
void	freeStr( char *s );
unsigned short*	newShort( const unsigned short aShort );
long*	newLong( const long aLong );

const	size_t maxCollectionSize = 12000;


class	TNSCollection
{
public:
	TNSCollection( short aLimit, short aDelta );
	~TNSCollection();

	void*	at( short index );
	short	indexOf( void *item );

	void	atFree( short index );
	void	atRemove( short index );
	void	remove( void *item );
	void	removeAll();
	void	free( void *item );
	void	freeAll();

	void	atInsert( short index, void *item );
	void	atPut( short index, void *item );
	void	add( void *item );

	void	setLimit( short aLimit );

	short	getCount();

	virtual	void freeItem( void *item );

protected:

	void	**items;
	short	count;
	short	limit;
	short	delta;
};


class	TStringCollection: public TNSCollection
{
public:
	TStringCollection( short aLimit, short aDelta );

	short	indexOf( char *item );

	char*	at( short index );

	char*	operator[]( short index ) { return at( index ); }
};


class	TNSSortedCollection: public TNSCollection
{
public:
	TNSSortedCollection( short aLimit, short aDelta ) : TNSCollection( aLimit, aDelta ) { delta = aDelta; setLimit( aLimit ); }

	virtual int		search( void *key, short& index );
	virtual short	indexOf( void *item );
	virtual short	insert( void *item );

private:
	virtual void	*keyOf( void *item );

	virtual int		compare( void *key1, void *key2 ) = 0;
};


class	TSortedCollection : public TNSSortedCollection
{
public:
	TSortedCollection( short aLimit, short aDelta ) : TNSSortedCollection( aLimit, aDelta ) {}

private:
	virtual int	compare( void *key1, void *key2 ) = 0;
};


class	TSortedStringCollection : public TSortedCollection
{

public:
	TSortedStringCollection( short aLimit, short aDelta );

	char*	at( short index );

private:
	virtual void freeItem( void *item );
	virtual int compare( void *key1, void *key2 );
};


class	TShortCollection : public TNSCollection
{
public:
	TShortCollection( short aLimit, short aDelta ) : TNSCollection( aLimit, aDelta ) {}

	unsigned short at( short item ) { return * ((unsigned short*) TNSCollection::at( item )); }

	short	indexOf( unsigned short item ) {
		for ( short I = 0; I < getCount(); I++ )
			if ( item == at( I ) ) return I;
		return -1;
	}
};

class	TLongCollection: public TNSCollection
{
public:
	TLongCollection( short aLimit, short aDelta ) : TNSCollection( aLimit, aDelta ) {}

	long	at( short item ) { return * ((long*) TNSCollection::at( item )); }
	long	operator[]( short index ) { return at( index ); }

	short	indexOf( long item ) {
		for ( short I = 0; I < getCount(); I++ )
			if ( item == at( I ) ) return I;
		return -1;
	}
};

#endif
