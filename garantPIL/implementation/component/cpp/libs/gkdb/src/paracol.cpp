/*
#include "gardefs.h"
#include "paracol.h"
#include "btiter.h"
#include "FString.SplaySet.h"

#include <algorithm>

#define	TITLE_BLOCK	0x3fffffff

//предусмотреть объединение, пересечение и минус в пределах как нескольких слов, так и абзацев.
//( закон | постановление ) &5 налог   : ( "закон" или "постановление" ) и в пределах 5 слов "налог"
//( закон &5 налог ) -!1 2002          : ( "закон" и "налог" в пределах 5 слов ) в абзаце, не содержащем "2002"

long	ParaWordDifference = 1;
long	ParaParaDifference = 0;

inline  int Sign( int x )
{
	return ( x > 0 ? 1 : ( x < 0 ? -1 : 0 ) );
}

inline	int Sign( long x )
{
	return ( x > 0 ? 1 : ( x < 0 ? -1 : 0 ) );
}

int	CompParas( Ref* r1, Ref* r2 )
{
	int s = Sign( r1 -> DocId - r2 -> DocId );
	if ( s )
		return s;

	s = ( r1 -> Sub >> 15 ) - ( r2 -> Sub >> 15 );
	if ( ParaParaDifference > 0 ) {
		if ( s > 0 && s <= ParaParaDifference )
			return 0;
		else	
			return s;
	} else {
		if ( s )
			return s;
	}

	s = ( r1 -> Sub & 0x3FFF ) - ( r2 -> Sub & 0x3FFF );
	if ( ParaWordDifference > 0 ) {
		if ( s > 0 && s <= ParaWordDifference )
			return 0;
		else
			return s;
	} else {
		return s;
	}
}

int	CompParasMinus( Ref* r1, Ref* r2 )
{
	int s = Sign( r1 -> DocId - r2 -> DocId );
	if ( s )
		return s;

	s = ( r1 -> Sub >> 15 ) - ( r2 -> Sub >> 15 );
	if ( ParaParaDifference ) {
		if ( abs( s ) <= abs( ParaParaDifference ) )
			return 0;
		else
			return s;
	} else {
		if ( s )
			return s;
	}

	s = ( r1 -> Sub & 0x3FFF ) - ( r2 -> Sub & 0x3FFF );
	if ( abs( s ) <= abs( ParaWordDifference ))
		return 0;
	else
		return s;
}

bool	ParaCollection :: ReadMore( Store *str, long tail )
{
	if ( !aCount )
		return false;

	aToRead = std::min<long>( 1024*1024, aCount ); // GARANT_STL
	aCount -= aToRead;
	if ( tail ) {
		char* beginBuffer = (char*)aBuffer;
		char* tailBuffer  = (char*)aPos;
		for ( long I = 0; I < tail; I++, tailBuffer++, beginBuffer++ )
			*beginBuffer = *tailBuffer;
		str->Read( beginBuffer, aToRead - tail );
	} else {
		aToRead = str->Read( aBuffer, aToRead );
		//if ( !aToRead ) return false;
	}
	aPos = aBuffer;
	return true;
}

int ParaCollection :: Get( Store* str )
{
	if ( !str )
		return 1;

	aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];

#ifdef STORE_FORM_N
	str->Read( &aCount, sizeof( long ));
#else
	aCount  = str->Length();
#endif
	ReadMore( str );
	aRef.DocId = *aPos; aPos++; aToRead -= sizeof( long );
	aRefs = *aPos; aPos++; aToRead -= sizeof( long );

	int aPage = 0;
	while ( true ) {
		Pages[ aPage ] = AllocPage();
		if ( !Pages[ aPage ] )
			break;

		ReadRefs( (Ref*)Pages[ aPage ], str );
		if ( !aRefsReaded )
			break;
		
		ItemCount += aRefsReaded;
		Count[ aPage++ ] = aRefsReaded;
	}

	delete aBuffer;
	PageCount = aPage;

	return 1;
}

void	ParaCollection :: ReadRefs( Ref* aaRefs, Store* str )
{
	aRefsReaded = 0;
	while ( aToRead || aCount ) {
		//пока есть что читать?

		while ( aRefs && aToRead >= sizeof( long ) && aRefsReaded < REF_PAGE_SIZE ) {
			//здесь ссылки читаем
			aRef.Sub = *aPos;
			aPos++;

			aToRead -= sizeof( long );
			aaRefs[ aRefsReaded++ ] = aRef;

#ifdef STORE_FORM_N
			if ( ! ( aRef.Sub & 0x4000 )) {
				if ( !aToRead )
					if ( !ReadMore( str ))
						return;
				char*	aCharPos = (char*) aPos;
				aPos = (long*)++aCharPos;
				aToRead--;
			}
#endif

			aRefs--;
		}

		if ( aRefsReaded == REF_PAGE_SIZE ) {
			//кончился буфер для чтения Refов. Выходим, а остаток прочитанного из str на следующем проходе прочтем
			//а если мы читаем остаток - aToRead, aRefs и aCount будут равны 0, и из процедуры все равно выйдем 
			return ;
		}

		//если все ссылки прочитаны.
		//    то пытаться читать дальше. Следующий документ. Если на него не хватает памяти - дочитать буфер
		//    дочитать буфер со следующими ссылками
		if ( !aRefs ) {
			if ( aToRead < sizeof( long )) {
				if ( !ReadMore( str, aToRead ))
					return ;
			}
			aRef.DocId = *aPos; aPos++; aToRead -= sizeof( long );
			if ( aToRead < sizeof( long ))
				if ( !ReadMore( str, aToRead ))
					return;
			aRefs = *aPos; aPos++; aToRead -= sizeof( long );
			//готовы читать ссылки к новому документу. Если буфер кончился, он прочтется на след.шаге
		} else {
			if ( !aCount )
				return ;
			if ( aToRead < sizeof( long ))
				if ( !ReadMore( str, aToRead ))
					return;
		}
	}
}

int ParaCollection :: IntersectStore( Store* str )
{
	if ( !str ) {
		FreeAll();
		return 1;
	}

	Ref* aaRefs = new Ref[ REF_PAGE_SIZE ];
	aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];

#ifdef STORE_FORM_N
	str->Read( &aCount, sizeof( long ));
#else
	aCount = str->Length();
#endif
	ReadMore( str );
	aRef.DocId = *aPos; aPos++; aToRead-= sizeof( long );
	aRefs = *aPos; aPos++; aToRead -= sizeof( long );

	//прочитать первые данные
	ReadRefs( aaRefs, str );
	Ref* ptr2 = aaRefs;

	for ( int page = 0; page < PageCount; page++ ) {
		Ref* ptr = (Ref*) Pages[ page ];
		int i, j;
		for ( i = 0, j = 0; i < Count[ page ]; i++ ) {
			Ref item = ptr[ i ];
			while ( CompParas( ptr2, &item ) < 0 ) {
				ptr2++; aRefsReaded--;
				if ( !aRefsReaded ) {
					ReadRefs( aaRefs, str );
					if ( !aRefsReaded ) {
						//больше читать нечего 
						Count[ page++ ] = j;
						for ( ; page < PageCount; page++ )
							Count[ page ] = 0;
						goto Compact;
					}
					ptr2 = aaRefs;
				}
			}

            if ( !CompParas( ptr2, &item ))
				ptr[ j++ ] = *ptr2;
		}
		Count[ page ] = j;
	}


Compact:
	Compact();
	delete aaRefs;
	delete aBuffer;
	return 1;
}

int	ParaCollection :: MergeStore( Store *str )
{
	// сортировка слиянием
	ParaCollection* aResult = new ParaCollection();

	Ref* aaRefs = new Ref[ REF_PAGE_SIZE ];
	aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];

#ifdef STORE_FORM_N
	str->Read( &aCount, sizeof( long ));
#else
	aCount = str->Length();
#endif
	ReadMore( str );
	aRef.DocId = *aPos; aPos++; aToRead -= sizeof( long );
	aRefs = *aPos; aPos++; aToRead -= sizeof( long );

	//прочитать первые данные
	ReadRefs( aaRefs, str );

	long aPos1 = 0;
	int  aPage1 = 0;
	Ref* ptr1 = (Ref*) Pages[ aPage1 ];
	long aCount1 = Count[ aPage1 ];

	long aPos2 = 0;
	Ref* ptr2 = aaRefs;
	long aCount2 = aRefsReaded;

	while ( ptr1 || ptr2 ) {
		if ( ptr1 ) {
			//в первой коллекции есть элементы. Пока они меньше элементов второй, их надо вставлять
			if ( ptr2 ) {
				if ( !CompRefs( ptr1,ptr2 ) ) {
					aResult->Collection::Add( ptr1 );
					ptr1++; aPos1++;
					ptr2++; aPos2++;

					if ( aPos1 == aCount1 ) {
						if ( ++aPage1 == PageCount )
							ptr1 = 0;
						else {
							ptr1 = (Ref*) Pages[ aPage1 ];
							aPos1 = 0;
							aCount1 = Count[ aPage1 ];
						}
					}

					if ( aPos2 == aCount2 ) {
						//прочитать порцию во вторую коллекцию
						ReadRefs(aaRefs,str);
						if ( !aRefsReaded )
							ptr2 = 0;
						else {
							aPos2 = 0;
							aCount2 = aRefsReaded;
							ptr2 = aaRefs;
						}
					}

					continue;
				}
				else for ( ; CompRefs( ptr1,ptr2 ) < 0 && aPos1 < aCount1; ptr1++, aPos1++ )
					//вставляем элементы из первой коллекции
					aResult->Collection::Add( ptr1 );
			}
			else					
				for ( int I = aPos1; I < aCount1; I++, ptr1++, aPos1++ )
					aResult->Collection::Add( ptr1 );

			if ( aPos1 == aCount1 ) {
				if ( ++aPage1 == PageCount )
					ptr1 = 0;
				else {
					ptr1 = (Ref*) Pages[ aPage1 ];
					aPos1 = 0;
					aCount1 = Count[ aPage1 ];
				}
			}
		}

		if ( ptr2 ) {
			//во второй коллекции есть элементы. Пока они меньше элементов первой, их надо вставлять
			if ( ptr1 )
				for ( ; CompRefs( ptr1,ptr2 ) > 0 && aPos2 < aCount2; ptr2++, aPos2++ )
					//вставляем элементы из первой коллекции
					aResult->Collection::Add( ptr2 );
			else					
				for ( int I = aPos2; I < aCount2; I++, ptr2++, aPos2++ )
					aResult->Collection::Add( ptr2 );

			if ( aPos2 == aCount2 ) {
				ReadRefs(aaRefs,str);
				if ( !aRefsReaded )
					ptr2 = 0;
				else {
					aPos2 = 0;
					aCount2 = aRefsReaded;
					ptr2 = aaRefs;
				}
			}
		}
	}

	FreeAll();
	Move(*aResult);
	delete aResult;
	delete aBuffer;
	delete aaRefs;

	return 1;
}

int	ParaCollection :: MergeStores( Store* str1, Store* str2 )
{
	ParaCollection* aResult = new ParaCollection();

	ParaCollection* aParas1 = new ParaCollection();
	ParaCollection* aParas2 = new ParaCollection();
	aParas1->aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];
	aParas2->aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];
	Ref* aaRefs1 = new Ref[ REF_PAGE_SIZE ];
	Ref* aaRefs2 = new Ref[ REF_PAGE_SIZE ];

#ifdef STORE_FORM_N
	str1->Read( &aParas1->aCount, sizeof( long ));
#else
	aParas1->aCount = str1->Length();
#endif
	aParas1->ReadMore( str1 );
	aParas1->aRef.DocId = *aParas1->aPos; aParas1->aPos++; aParas1->aToRead -= sizeof( long );
	aParas1->aRefs = *aParas1->aPos; aParas1->aPos++; aParas1->aToRead -= sizeof( long );

#ifdef STORE_FORM_N
	str2->Read( &aParas2->aCount, sizeof( long ));
#else
	aParas2->aCount = str2->Length();
#endif
	aParas2->ReadMore( str2 );
	aParas2->aRef.DocId = *aParas2->aPos; aParas2->aPos++; aParas2->aToRead -= sizeof( long );
	aParas2->aRefs = *aParas2->aPos; aParas2->aPos++; aParas2->aToRead -= sizeof( long );

	//прочитать первые данные
	aParas1->ReadRefs( aaRefs1, str1 );
	aParas2->ReadRefs( aaRefs2, str2 );

	long aPos1 = 0;
	Ref* ptr1 = (Ref*) aaRefs1;
	long aCount1 = aParas1->aRefsReaded;

	long aPos2 = 0;
	Ref* ptr2 = aaRefs2;
	long aCount2 = aParas2->aRefsReaded;

	while ( ptr1 || ptr2 ) {
		if ( ptr1 ) {
			//в первой коллекции есть элементы. Пока они меньше элементов второй, их надо вставлять
			if ( ptr2 ) {
				if ( !CompRefs( ptr1,ptr2 ) ) {
					aResult->Collection::Add( ptr1 );
					ptr1++; aPos1++;
					ptr2++; aPos2++;

					if ( aPos1 == aCount1 ) {
						aParas1->ReadRefs(aaRefs1,str1);
						if ( !aParas1->aRefsReaded )
							ptr1 = 0;
						else {
							aPos1 = 0;
							aCount1 = aParas1->aRefsReaded;
							ptr1 = aaRefs1;
						}
					}

					if ( aPos2 == aCount2 ) {
						//прочитать порцию во вторую коллекцию
						aParas2->ReadRefs(aaRefs2,str2);
						if ( !aParas2->aRefsReaded )
							ptr2 = 0;
						else {
							aPos2 = 0;
							aCount2 = aParas2->aRefsReaded;
							ptr2 = aaRefs2;
						}
					}

					continue;
				}
				else for ( ; CompRefs( ptr1,ptr2 ) < 0 && aPos1 < aCount1; ptr1++, aPos1++ )
					//вставляем элементы из первой коллекции
					aResult->Collection::Add( ptr1 );
			}
			else					
				for ( int I = aPos1; I < aCount1; I++, ptr1++, aPos1++ )
					aResult->Collection::Add( ptr1 );

			if ( aPos1 == aCount1 ) {
				aParas1->ReadRefs(aaRefs1,str1);
				if ( !aParas1->aRefsReaded )
					ptr1 = 0;
				else {
					aPos1 = 0;
					aCount1 = aParas1->aRefsReaded;
					ptr1 = aaRefs1;
				}
			}
		}

		if ( ptr2 ) {
			//во второй коллекции есть элементы. Пока они меньше элементов первой, их надо вставлять
			if ( ptr1 )
				for ( ; CompRefs( ptr1,ptr2 ) > 0 && aPos2 < aCount2; ptr2++, aPos2++ )
					//вставляем элементы из первой коллекции
					aResult->Collection::Add( ptr2 );
			else					
				for ( int I = aPos2; I < aCount2; I++, ptr2++, aPos2++ )
					aResult->Collection::Add( ptr2 );

			if ( aPos2 == aCount2 ) {
				aParas2->ReadRefs(aaRefs2,str2);
				if ( !aParas2->aRefsReaded )
					ptr2 = 0;
				else {
					aPos2 = 0;
					aCount2 = aParas2->aRefsReaded;
					ptr2 = aaRefs2;
				}
			}
		}
	}

	FreeAll();
	Move(*aResult);
	delete aResult;
	delete aParas1->aBuffer;
	delete aParas2->aBuffer;
	delete aaRefs1;
	delete aaRefs2;
	delete aParas1;
	delete aParas2;
	return 1;
}

int ParaCollection :: IntersectStores( Store* str1, Store* str2 )
{
	if ( !str1 || !str2 ) {
		FreeAll();
		return 1;
	}

	ParaCollection* aParas2 = new ParaCollection();
	aParas2->aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];
	Ref* aaRefs2 = new Ref[ REF_PAGE_SIZE ];

	aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];
	Ref* aaRefs = new Ref[ REF_PAGE_SIZE ];

#ifdef STORE_FORM_N
	str1->Read( &aCount, sizeof( long ));
#else
	aCount = str1->Length();
#endif
	ReadMore( str1 );
	aRef.DocId = *aPos; aPos++; aToRead -= sizeof( long );
	aRefs = *aPos; aPos++; aToRead -= sizeof( long );
	ReadRefs( aaRefs, str1 );

#ifdef STORE_FORM_N
	str2->Read( &aParas2->aCount, sizeof( long ));
#else
	aParas2->aCount = str2->Length();
#endif
	aParas2->ReadMore( str2 );
	aParas2->aRef.DocId = *aParas2->aPos; aParas2->aPos++; aParas2->aToRead -= sizeof( long );
	aParas2->aRefs = *aParas2->aPos; aParas2->aPos++; aParas2->aToRead -= sizeof( long );
	aParas2->ReadRefs( aaRefs2, str2 );

	Ref* ptr1 = aaRefs;
	Ref* ptr2 = aaRefs2;

	for ( ;; ) {
		if ( !CompParas( ptr2, ptr1 ) ) {
			Collection::Add(ptr2);
			ptr1++; aRefsReaded--;
			ptr2++;	aParas2->aRefsReaded--;
		} else
		if ( CompParas( ptr2, ptr1 ) > 0 ) {
			while ( CompParas( ptr2, ptr1 ) > 0 && aRefsReaded ) {
				ptr1++;
				aRefsReaded--;
			}
		} else {
			while ( CompParas( ptr2, ptr1 ) < 0 && aParas2->aRefsReaded ) {
				ptr2++;
				aParas2->aRefsReaded--;
			}
		}

		if ( !aRefsReaded ) {
			ReadRefs( aaRefs,str1 );
			if ( aRefsReaded )
				ptr1 = aaRefs;
			else
				break;
		}
		if ( !aParas2->aRefsReaded ) {
			aParas2->ReadRefs( aaRefs2,str2 );
			if ( aParas2->aRefsReaded )
				ptr2 = aaRefs2;
			else
				break;
		}
	}

	delete aBuffer;
	delete aParas2->aBuffer;
	delete aaRefs;
	delete aaRefs2;
	delete aParas2;
	return 1;
}

int	ParaCollection :: Intersect( ParaCollection& list )
{
	int	page2 = 0;
	Ref	*ptr2 = (Ref*) list.Pages[ page2 ];

	int	k = 0;
	for ( int page = 0; page < PageCount; page++ ) {
		Ref *ptr = (Ref*) Pages[ page ];
		int i, j;
		for ( i = 0, j = 0; i < Count[ page ]; i++ ) {
			Ref	item = ptr[ i ];

			while ( CompParas( ptr2, &item ) < 0 ) {
				ptr2++;
				if ( ++k >= list.Count[ page2 ] ) {
					if ( ++page2 >= list.PageCount ) {
						Count[ page++ ] = j;
						for ( ; page < PageCount; page++ )
							Count[ page ] = 0;
						goto Compact;
					}
					ptr2 = (Ref*) list.Pages[ page2 ];
					k    = 0;
				}
			}

			if ( !CompParas( ptr2, &item ))
				ptr[ j++ ] = *ptr2;
		}

		Count[ page ] = j;
	}

Compact:
    Compact();

	return 1;
}

int	ParaCollection :: Merge( ParaCollection& list )
{
	ParaCollection* aResult = new ParaCollection();
	long	aPos1 = 0;
	long	aPos2 = 0;
	int		aPage1 = 0;
	int		aPage2 = 0;
	Ref*	ptr1 = (Ref*) Pages[ aPage1 ];
	Ref*	ptr2 = (Ref*) list.Pages[ aPage2 ];
	long	aCount1 = Count[ aPage1 ];
	long	aCount2 = list.Count[ aPage2 ];
	while ( ptr1 || ptr2 ) {
		if ( ptr1 ) {
			//в первой коллекции есть элементы. Пока они меньше элементов второй, их надо вставлять
			if ( ptr2 ) {
				if ( !CompRefs( ptr1, ptr2 ) ) {
					aResult->Collection::Add( ptr1 );
					ptr1++; aPos1++;
					ptr2++; aPos2++;

					if ( aPos1 == aCount1 ) {
						if ( ++aPage1 == PageCount )
							ptr1 = 0;
						else {
							ptr1 = (Ref*) Pages[ aPage1 ];
							aPos1 = 0;
							aCount1 = Count[ aPage1 ];
						}
					}

					if ( aPos2 == aCount2 ) {
						if ( ++aPage2 == list.PageCount )
							ptr2 = 0;
						else {
							ptr2 = (Ref*) list.Pages[ aPage2 ];
							aPos2 = 0;
							aCount2 = list.Count[ aPage2 ];
						}
					}

					continue;
				}
				else for ( ; CompRefs( ptr1, ptr2 ) < 0 && aPos1 < aCount1; ptr1++, aPos1++ )
					//вставляем элементы из первой коллекции
					aResult->Collection::Add( ptr1 );
			}
			else					
				for ( int I = aPos1; I < aCount1; I++, ptr1++, aPos1++ )
					aResult->Collection::Add( ptr1 );

			if ( aPos1 == aCount1 ) {
				if ( ++aPage1 == PageCount )
					ptr1 = 0;
				else {
					ptr1 = (Ref*) Pages[ aPage1 ];
					aPos1 = 0;
					aCount1 = Count[ aPage1 ];
				}
			}
		}

		if ( ptr2 ) {
			//во второй коллекции есть элементы. Пока они меньше элементов первой, их надо вставлять
			if ( ptr1 )
				for ( ; CompRefs( ptr1, ptr2 ) > 0 && aPos2 < aCount2; ptr2++, aPos2++ )
					//вставляем элементы из первой коллекции
					aResult->Collection::Add( ptr2 );
			else					
				for ( int I = aPos2; I < aCount2; I++, ptr2++, aPos2++ )
					aResult->Collection::Add( ptr2 );

			if ( aPos2 == aCount2 ) {
				if ( ++aPage2 == list.PageCount )
					ptr2 = 0;
				else {
					ptr2 = (Ref*) list.Pages[ aPage2 ];
					aPos2 = 0;
					aCount2 = list.Count[ aPage2 ];
				}
			}
		}
	}

	//в aResult - результат слияния. Надо перенести аккуратно в текущий объект
	FreeAll();
	Move(*aResult);
	delete aResult;
	
	return 1;
}

int ParaCollection :: StoreIntersect( Store* str )
{
	if ( !str ) {
		FreeAll();
		return 1;
	}

	//IntersectStore - список пересекаем со Store
	//StoreIntersect - Store пересекаем с текущим

	ParaCollection* aResult = new ParaCollection();

	aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];
	Ref* aaRefs = new Ref[ REF_PAGE_SIZE ];

#ifdef STORE_FORM_N
	str->Read( &aCount, sizeof( long ));
#else
	aCount = str->Length();
#endif
	ReadMore( str );
	aRef.DocId = *aPos; aPos++; aToRead -= sizeof( long );
	aRefs = *aPos; aPos++; aToRead -= sizeof( long );
	ReadRefs( aaRefs, str );

	long page = 0;
	long count = Count[ page ];
	Ref* ptr1 = aaRefs;
	Ref* ptr2 = (Ref*)Pages[ page ];

	for ( ;; ) {
		if ( !CompParas( ptr2, ptr1 ) ) {
			aResult->Collection::Add(ptr2);
			ptr1++; aRefsReaded--;
			ptr2++;	count--;
		} else
		if ( CompParas( ptr2, ptr1 ) > 0 ) {
			while ( CompParas( ptr2, ptr1 ) > 0 && aRefsReaded ) {
				ptr1++;
				aRefsReaded--;
			}
		} else {
			while ( CompParas( ptr2, ptr1 ) < 0 && count ) {
				ptr2++;
				count--;
			}
		}

		if ( !aRefsReaded ) {
			ReadRefs( aaRefs,str );
			if ( aRefsReaded )
				ptr1 = aaRefs;
			else
				break;
		}
		if ( !count ) {
			if ( ++page == PageCount )
				break;
			else {
				count = Count[ page ];
				ptr2 = (Ref*) Pages[ page ];
			}
		}
	}

	delete aBuffer;
	delete aaRefs;
	FreeAll();
	Move(*aResult);
	delete aResult;
	return 1;
}

int	ParaCollection :: Minus( ParaCollection& list )
{
	int	page2 = 0;
	Ref	*ptr2 = (Ref *) list.Pages[ page2 ];

	int	k = 0;
	for ( int page = 0; page < PageCount; page++ ) {
		Ref *ptr = (Ref*) Pages[ page ];
		int i, j;
		for ( i = 0, j = 0; i < Count[ page ]; i++ ) {
			Ref	item = ptr[i];

            while ( CompParasMinus( &ptr2[k], &item ) < 0 )
				if ( ++k >= list.Count[ page2 ] ) {
					if ( ++page2 >= list.PageCount ) {
						for ( ; i < Count[ page ]; i++ )
							ptr[ j++ ] = ptr[ i ];
						Count[ page ] = j;
						goto Compact;
					}
					ptr2 = (Ref*) list.Pages[ page2 ];
					k    = 0;
				}

            if ( CompParasMinus( &ptr2[ k ], &item ))
				ptr[ j++ ] = item;
		}

		Count[ page ] = j;
	}

Compact:
    Compact();

	return 1;
}

int ParaCollection :: MinusStore( Store* str )
{
	Ref* aaRefs = new Ref[ REF_PAGE_SIZE ];
	aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];

#ifdef STORE_FORM_N
	str->Read( &aCount, sizeof( long ));
#else
	aCount  = str->Length();
#endif
	ReadMore( str );
	aRef.DocId = *aPos; aPos++; aToRead -= sizeof( long );
	aRefs = *aPos; aPos++; aToRead -= sizeof( long );
	ReadRefs( aaRefs, str );

	int	k = 0;
	for ( int page = 0; page < PageCount; page++ ) {
		Ref* ptr = (Ref*) Pages[ page];
		int i, j;
		for ( i = 0, j = 0; i < Count[ page ]; i++ ) {
			Ref item = ptr[ i ];
			while ( CompParasMinus( &aaRefs[ k ], &item ) < 0 )
				if ( ++k > aRefsReaded ) {
					ReadRefs( aaRefs, str );
					if ( !aRefsReaded ) {
						for ( ; i < Count[ page ]; i++ )
							ptr[ j++ ] = ptr[ i ];
						Count[ page ] = j;
						goto Compact;
					}
					k = 0;
				}

            if ( CompParasMinus( &aaRefs[ k ], &item ))
				ptr[ j++ ] = item;
		}
		Count[ page ] = j;
	}

Compact:
	Compact();
	delete aaRefs;
	delete aBuffer;
	return 1;
}

int ParaCollection :: MinusStores( Store* str1, Store* str2 )
{
	ParaCollection* aParas2 = new ParaCollection();
	aParas2->aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];
	Ref* aaRefs2 = new Ref[ REF_PAGE_SIZE ];

	aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];
	Ref* aaRefs = new Ref[ REF_PAGE_SIZE ];

#ifdef STORE_FORM_N
	str1->Read( &aCount, sizeof( long ));
#else
	aCount = str1->Length();
#endif
	ReadMore( str1 );
	aRef.DocId = *aPos; aPos++; aToRead -= sizeof( long );
	aRefs = *aPos; aPos++; aToRead -= sizeof( long );

#ifdef STORE_FORM_N
	str2->Read( &aParas2->aCount, sizeof( long ));
#else
	aParas2->aCount = str2->Length();
#endif
	aParas2->ReadMore( str2 );
	aParas2->aRef.DocId = *aParas2->aPos; aParas2->aPos++; aParas2->aToRead -= sizeof( long );
	aParas2->aRefs = *aParas2->aPos; aParas2->aPos++; aParas2->aToRead -= sizeof( long );
	aParas2->ReadRefs( aaRefs2, str2 );
	Ref* ptr2 = aaRefs2;

	do {
		ReadRefs( aaRefs, str1 );
		Ref* ptr1 = aaRefs;
		for ( ; aRefsReaded; aRefsReaded--, ptr1++ ) {
			while ( CompParasMinus( ptr2, ptr1 ) < 0 ) {
				ptr2++;
				aParas2->aRefsReaded--;
				if ( !aParas2->aRefsReaded ) {
					aParas2->ReadRefs( aaRefs2, str2 );
					if ( !aParas2->aRefsReaded ) {
						do {
							for ( ; aRefsReaded; aRefsReaded--, ptr1++ )
								Collection::Add( ptr1 );
							ReadRefs( aaRefs,str1 );
							ptr1 = aaRefs;
						} while ( aRefsReaded );
						goto Compact;
					}
					ptr2 = aaRefs2;
				}
			}

			if ( CompParasMinus( ptr2, ptr1 ))
				Collection::Add(ptr1);
		}
	} while ( !aRefsReaded );

Compact:
	delete aBuffer;
	delete aParas2->aBuffer;
	delete aaRefs;
	delete aaRefs2;
	delete aParas2;
	return 1;
}

int	ParaCollection :: StoreMinus( Store* str )
{
	//читаем Store и вычитаем из него текущую коллекцию
	ParaCollection* aResult = new ParaCollection();

	aBuffer = new long[ 1024 * 1024 / sizeof( long ) ];
	Ref* aaRefs = new Ref[ REF_PAGE_SIZE ];

#ifdef STORE_FORM_N
	str->Read( &aCount, sizeof( long ));
#else
	aCount = str->Length();
#endif
	ReadMore( str );
	aRef.DocId = *aPos; aPos++; aToRead -= sizeof( long );
	aRefs = *aPos; aPos++; aToRead -= sizeof( long );

	long page = 0;
	long aaRefs2 = Count[ page ];
	Ref* ptr2 = (Ref*) Pages[ page ];
	do {
		ReadRefs( aaRefs, str );
		Ref* ptr1 = aaRefs;
		for ( ; aRefsReaded; aRefsReaded--, ptr1++ ) {
			while ( CompParasMinus( ptr2, ptr1 ) < 0 ) {
				ptr2++;
				aaRefs2--;
				if ( !aaRefs2 ) {
					if ( ++page == PageCount ) {
						do {
							for ( ; aRefsReaded; aRefsReaded--, ptr1++ )
								aResult->Collection::Add( ptr1 );
							ReadRefs( aaRefs,str );
							ptr1 = aaRefs;
						} while ( aRefsReaded );
						goto Compact;
					}
					ptr2 = (Ref*) Pages[ page ];
					aaRefs2 = Count[ page ];
				}
			}

			if ( CompParasMinus( ptr2, ptr1 ))
				aResult->Collection::Add(ptr1);
		}
	} while ( !aRefsReaded );

Compact:
	FreeAll();
	Move(*aResult);
	delete aBuffer;
	delete aaRefs;
	return 1;
}

Calc :: Calc( Base* aBase )
{
}

void	Calc :: GetToken()
{
	if ( !pCurrPos ) {
		currToken = END;
		*tokenValue = 0;
		return;
	}

	while ( *pCurrPos == ' ' )
		pCurrPos++;

	char* temp = tokenValue;
	if ( strchr( "|-&()", *pCurrPos )) {
		paraworddifference = 0;
		paraparadifference = 0;
		currToken = OPERATOR;
		*temp++ = *pCurrPos++;
		if ( *tokenValue ) {
			if ( *pCurrPos == '!' ) {
				pCurrPos++;
				paraparadifference = atoi(pCurrPos);
				for( ; isdigit(*pCurrPos); pCurrPos++ ) ;
			} else
			if ( isdigit(*pCurrPos )) {
				paraworddifference = atoi(pCurrPos);
				for( ; isdigit(*pCurrPos); pCurrPos++ ) ;
			} 
		}
	}
	else if ( IsAlNum( *pCurrPos ) ) {
		currToken = NUMBER;
		while( IsAlNum( *pCurrPos ))
			*temp++ = *pCurrPos++;
	}
	else
		currToken = END;
	*temp=0;
}

DocCollection* ParaCollection :: GetDocs()
{
	DocCollection* aResult = new DocCollection();

	Ref	*ptr = 0;
	long prevDocId = 0;

	for ( int i = 0; i < PageCount; i++ ) {
		ptr = (Ref*) Pages [i];
		for ( int j = 0; j < Count [i]; j++, ptr++ )
			if ( ptr->DocId != prevDocId ) {
				prevDocId = ptr->DocId;
				aResult->Collection::Add( &prevDocId  );
			}
	}

	return aResult;
}

int BlockCollection :: Get( Store* str, bool titles, bool ignoreForm, char form )
{
	if ( !str )
		return 1;

	char* start = (char*) malloc( str->Length() );
	str->Read( start, str->Length() );
	const char* realstart = start;
	
	long count, blck, Multi, tstM, indxs;
	const char *d = start;
	ptrdiff_t s = *(long*)d;
	realstart += sizeof(long);
	d += sizeof(long);

	Ref aRef = { 0, 0 };

	while (((ptrdiff_t)d - (ptrdiff_t)realstart) < s) {
		Multi=0;
		if(*(long*)d & 0x80000000)
			Multi++;

		aRef.DocId = *(long*)d & 0x7fffffff;

		d += sizeof(long);
		if((blck= *(long*)d) & 0x80000000){
			tstM= 2;
			count= 1;
		} else {
			tstM= 3;
			d += sizeof(long);
			count= *(long*)d;
		}

		while(count--){
			d += sizeof(long);
			if( blck & 0x40000000 ) {
				aRef.Sub = blck & TITLE_BLOCK;

				if ( ignoreForm ) {
					if ( !titles || ( titles && aRef.Sub == TITLE_BLOCK ))
						Collection::Add( &aRef );
					if( Multi )
						d++;
				} else {
					if ( Multi ) {
						if ( *d == form && ( !titles || ( titles && aRef.Sub == TITLE_BLOCK )))
							Add( aRef );
						d++;
					} else {
						if ( !form && ( !titles || ( titles && aRef.Sub == TITLE_BLOCK )))
							Add( aRef );
					}
				}
			} else {
				if( tstM == 2 ) {
					count = (long)*d; d++;
					aRef.Sub = blck & TITLE_BLOCK;
					if ( ignoreForm ) {
						if ( !titles || ( titles && aRef.Sub == TITLE_BLOCK ))
							Collection::Add( &aRef );
						while ( count-- )
							d++;
					} else {
						if ( *d == form && ( !titles || ( titles && aRef.Sub == TITLE_BLOCK )))
							Add( aRef );
						while ( count-- ) {
							d++;
							if ( *d == form && ( !titles || ( titles && aRef.Sub == TITLE_BLOCK )))
								Add( aRef );
						}
					}
					break;
				} else if ( tstM == 3 ) {
					indxs = (long)*d; d++;
					aRef.Sub = blck & TITLE_BLOCK;
					if ( ignoreForm ) {
						if ( !titles || ( titles && aRef.Sub == TITLE_BLOCK ))
							Collection::Add( &aRef );
						while ( indxs-- )
							d++;
					} else {
						if ( *d == form && ( !titles || ( titles && aRef.Sub == TITLE_BLOCK )))
							Add( aRef );
						while ( indxs-- ) {
							d++;
							if ( *d == form && ( !titles || ( titles && aRef.Sub == TITLE_BLOCK )))
								Add( aRef );
						}
					}
				}
			}

			if (((ptrdiff_t)d - (ptrdiff_t)realstart) < s)
				blck = *(long*)d;
		}
	}

	free( start );

	return 1;
}
*/