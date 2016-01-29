#include "stdafx.h"
#include <string.h>
#include <stdio.h>

#include "Collection.h"

//////////////////////////////////////////////////////////////////////////////

TNSCollection :: TNSCollection( short aLimit, short aDelta )
{
	count = 0;
	items = 0;
	limit = 0;
	delta = aDelta;
	setLimit( aLimit );
}

TNSCollection :: ~TNSCollection()
{
	freeAll();
	delete items;
}

void*	TNSCollection :: at( short index )
{
	if ( index >= 0 && index < count )
		return items[ index ];
	else
		return NULL;
}

short	TNSCollection :: indexOf( void *item )
{
	for ( short I = 0; I < count; I++ ) if ( item == items[ I ] ) return I;
	return -1;
}

void	TNSCollection :: atFree( short index )
{
	void *item = at( index );
	atRemove( index );
	freeItem( item );
}

void	TNSCollection :: atRemove( short index )
{
	if ( index >= 0 && index < count )
	{
		count--;
		/*
		for ( short i = 0; i < count - index; i++ )
			items[ index + i ] = items[ index + i + 1 ];
		*/
		memmove( &items[ index ], &items[ index + 1 ], ( count - index ) * sizeof( void * ));
	}
}

void	TNSCollection :: remove( void *item )
{
	atRemove( indexOf( item ));
}

void	TNSCollection :: removeAll()
{
	count = 0;
}

void	TNSCollection :: free( void *item )
{
	remove( item );
	freeItem( item );
}

void	TNSCollection :: freeAll()
{
	for ( short I =  0; I < count; I++ ) freeItem( at( I ));
	count = 0;
}

void	TNSCollection :: atInsert( short index, void *item )
{
	if ( index >= 0 )
	{
		if ( count == limit ) setLimit( count + delta );

		/*
		for ( short i = 0; i < count - index; i++ )
			items[ count - i + 1 ] = items[ count - i ];
		*/
		memmove( &items[ index + 1 ], &items[ index ], ( count - index ) * sizeof( void * ));
		count++;

		items[ index ] = item;
	}
}

void	TNSCollection :: atPut( short index, void *item )
{
	if ( index < count ) items[ index ] = item;
}

void	TNSCollection :: add( void *item )
{
	atInsert( count, item );
}

void	TNSCollection :: setLimit( short aLimit )
{
	if ( aLimit < count ) aLimit =  count;
	if ( aLimit > maxCollectionSize ) aLimit = maxCollectionSize;
	if ( aLimit != limit )
	{
		void **aItems;
		if ( aLimit == 0 )
			aItems = 0;
		else
		{
			aItems = new void* [ aLimit ];
			if ( count !=  0 )
				/*
				for ( short i = 0; i < count; i++ )
					aItems[ i ] = items[ i ];
				*/
				memcpy( aItems, items, count * sizeof( void * ));
		}
		delete items;
		items =  aItems;
		limit =  aLimit;
	}
}

short	TNSCollection :: getCount()
{
	return count;
}

void	TNSCollection :: freeItem( void *item )
{
	delete item;
}

//////////////////////////////////////////////////////////////////////////////

TStringCollection :: TStringCollection( short aLimit, short aDelta ) : TNSCollection( aLimit, aDelta )
{
}

short	TStringCollection :: indexOf( char *item )
{
	for ( short I = 0; I < count; I++ )
	{
		char *s1 = item;
		char *s2 = TStringCollection::at( I );
		if ( strcmp( s1, s2 ) == 0 ) return I;
	}
	return -1;
}

char*	TStringCollection :: at( short index )
{
	return (char *) TNSCollection::at( index );
}

//////////////////////////////////////////////////////////////////////////////

short	TNSSortedCollection :: indexOf( void *item )
{
	short I;

	if( search( keyOf( item ), I ) == 0 )
		return ccNotFound;
	else
	{
		if( I < count )
			return I;
		else
			return ccNotFound;
	}
}

short	TNSSortedCollection :: insert( void *item )
{
	short	I;
	if( search( keyOf( item ), I ) == 0 )
		atInsert( I, item );
	return I;
}

void	*TNSSortedCollection :: keyOf( void *item )
{
	return item;
}

int	TNSSortedCollection :: search( void *key, short& index )
{
	short	l = 0;
	short	h = count - 1;
	int	res = 0;
	while( l <= h )
	{
		short I = ( l +  h ) >> 1;
		short c = compare( keyOf( items[ I ] ), key );
		if( c < 0 )
		    l = I + 1;
		else
		{
			h = I - 1;
			if( c == 0 )
			{
				res = 1;
				l = I;
			}
		}
	}
	index = l;
	return res;
}

//////////////////////////////////////////////////////////////////////////////

TSortedStringCollection :: TSortedStringCollection( short aLimit, short aDelta ) : TSortedCollection( aLimit, aDelta )
{
}

int	TSortedStringCollection :: compare( void *key1, void *key2 )
{
	return strcmp( (char *)key1, (char *)key2 );
}

void	TSortedStringCollection :: freeItem( void* item )
{
	delete item;
}

char*	TSortedStringCollection :: at( short index )
{
	return (char *) TSortedCollection::at( index );
}

//////////////////////////////////////////////////////////////////////////////

char*	newStr( const char *s )
{
	if ( s == 0 ) return 0;
	char *temp = new char[ strlen( s ) + 1 ];
	strcpy( temp, s );
	return temp;
}

void	freeStr( char *s )
{
	if ( s != NULL ) delete s;
}

unsigned short*	newShort( const unsigned short aShort )
{
	unsigned short *temp = new unsigned short;
	*temp = aShort;
	return temp;
}

long*	newLong( const long aLong )
{
	long *temp = new long;
	*temp = aLong;
	return temp;
}
