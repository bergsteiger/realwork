// SampleGCTX.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"

#include "LocalObj.h"

class LocalOuter: public NContextKey
{
public:
	LocalOuter();
	void PutKey(u_int64_t Nm64, long DocID, long ParaNInDoc, long WordPosInPara);
};

LocalOuter::LocalOuter()
{
}
void LocalOuter::PutKey(u_int64_t Nm64, long DocID, long ParaNInDoc, long WordPosInPara)
{
	return;
}

int main(int argc, char* argv[])
{
	if(argc < 2)
		return -2;
	{
		short Nm16= (short)2;
		LocalBase *base= new LocalBase( argv[1], O_RDWR );
		if(!base->IsOk()){
			delete base;
			base= new LocalBase( argv[1], O_CREAT|O_RDWR );
			Nm16= 1;
		}
		if(base){
			///////////////////////////////////////////////////////////
			// Гарантовская Контекстная машина с морфологией из GKDB //
			///////////////////////////////////////////////////////////
			NContxtIndex *ind= (NContxtIndex *)base->FindContxtIndexByNumber(Nm16);
									//////////////////////////////////////////////////
			LocalOuter *pLocalPut	// Используется Индексная машина GKDB			//
									//= NULL;
									// Используется альтернативная Индексная машина //
									= new LocalOuter();
									//////////////////////////////////////////////////
											//////////////////////////////////////////
			LocalDocIterator *pLocalIter	// Используется Итератор по независимой	//
											// полной коллекции документов, которую	//
											// "обязан" выдать base					//
											//= new LocalDocIterator();
											// Используется Итератор по коллекции	//
											// документов "известной" только base	//
											= new LocalDocIterator(base);
			if(!pLocalPut){
				{
					// Построение нового контекста для документов из Итератора //
					ind->Build(base, pLocalIter);
				}
				{
					// Обновление контекста для документов из Итератора //

						// документы чьи ключи надо удалить //
						long	Deleted[]= { 1000001, 0x7ffffffc };
						ind->Build(base, pLocalIter, NULL, (long*)Deleted);
				}
			}else{
				// Генерация ключей контекста для документов из Итератора //
				ind->Build(base, pLocalIter, pLocalPut);
				delete pLocalPut;
			}
			delete pLocalIter;
			delete base;
		}else
			return -1;
	}
	return 0;
}

