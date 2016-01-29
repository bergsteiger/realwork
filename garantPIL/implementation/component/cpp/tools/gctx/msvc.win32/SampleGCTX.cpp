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
			// ������������ ����������� ������ � ����������� �� GKDB //
			///////////////////////////////////////////////////////////
			NContxtIndex *ind= (NContxtIndex *)base->FindContxtIndexByNumber(Nm16);
									//////////////////////////////////////////////////
			LocalOuter *pLocalPut	// ������������ ��������� ������ GKDB			//
									//= NULL;
									// ������������ �������������� ��������� ������ //
									= new LocalOuter();
									//////////////////////////////////////////////////
											//////////////////////////////////////////
			LocalDocIterator *pLocalIter	// ������������ �������� �� �����������	//
											// ������ ��������� ����������, �������	//
											// "������" ������ base					//
											//= new LocalDocIterator();
											// ������������ �������� �� ���������	//
											// ���������� "���������" ������ base	//
											= new LocalDocIterator(base);
			if(!pLocalPut){
				{
					// ���������� ������ ��������� ��� ���������� �� ��������� //
					ind->Build(base, pLocalIter);
				}
				{
					// ���������� ��������� ��� ���������� �� ��������� //

						// ��������� ��� ����� ���� ������� //
						long	Deleted[]= { 1000001, 0x7ffffffc };
						ind->Build(base, pLocalIter, NULL, (long*)Deleted);
				}
			}else{
				// ��������� ������ ��������� ��� ���������� �� ��������� //
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

