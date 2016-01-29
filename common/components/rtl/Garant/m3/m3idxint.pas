unit    m3IdxInt;
{* ���������� �����������. }

(*
//
//
// .Author: Mickael P. Golovin.
// .Copyright: 1997-2001 by Archivarius Team, _free for non commercial use.
//
//
*)
// $Id: m3idxint.pas,v 1.6 2014/11/05 16:59:31 lulin Exp $

// $Log: m3idxint.pas,v $
// Revision 1.6  2014/11/05 16:59:31  lulin
// - ������������� ���.
//
// Revision 1.5  2014/11/05 12:28:57  lulin
// - ������������� ���.
//
// Revision 1.4  2014/09/10 16:02:08  lulin
// - ��� ��������, ��� ���������� ������������ ������.
//
// Revision 1.3  2011/12/28 09:29:10  lulin
// {RequestLink:325257155}
// - ������ ���.
//
// Revision 1.2  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.1  2004/09/02 08:09:49  law
// - cleanup.
//
// Revision 1.12  2003/02/19 13:08:08  law
// - cleanup.
//
// Revision 1.11  2002/09/12 14:51:04  law
// - cleanup: comments.
//
// Revision 1.10  2002/04/15 12:20:21  law
// - new method: GetFlags.
//
// Revision 1.9  2002/04/11 14:35:43  law
// - new param: UseAlternate.
// - new method: IsAlternate.
//
// Revision 1.8  2002/03/28 17:43:59  law
// - bug fix.
//
// Revision 1.7  2002/03/28 16:51:12  law
// - bug fix: ������������ ������� � ��������� ��������.
//
// Revision 1.6  2002/02/26 08:31:54  law
// - new method: Im3NormalizaterResult.Reset.
// - bug fix: Catastrophic Fail ��� �������� �������.
//
// Revision 1.5  2002/02/21 15:58:16  law
// - optimization.
//
// Revision 1.4  2001/12/21 13:12:42  law
// - new behavior: ������ ����� � ������ ����� * � ?.
//
// Revision 1.3  2001/11/20 17:37:29  law
// - new behavior: ������� "����" ��� �������� ������ �����������.
//
// Revision 1.2  2001/10/26 17:43:32  law
// - comments: xHelpGen.
//

{$I m3Define.inc}

interface

uses
         ActiveX,
  m3StorageInterfaces
  ;


 type
        Im3IndexComparer=         interface;
        Im3IndexReader=           interface;
        Im3IndexWriter=           interface;
        Im3IndexUpdater=          interface;
        Im3IndexSearcher=         interface;
        Im3IndexSearcherResult=   interface;
        Im3Normalizater=          interface;
        Im3NormalizaterResult=    interface;


        Tm3NormalizaterType=      (Cm3NormalizaterInternal,
                                   Cm3NormalizaterUseIndex
                                  );
         {* ��� �������������. }                         


        Im3IndexComparer=         interface(IUnknown) ['{9820EEC9-CD10-443B-99FF-815E0A06C9F0}']
         {* ��������� ��� ����������� ���� �������. }


                function          Compare             (const AVal1: Pointer;
                                                       const AVal2: Pointer;
                                                       const ASize: LongInt
                                                      ): Integer;
                  {* - ���������� ��� ������. }


        end;


        Im3IndexReader=           interface(IUnknown) ['{6DA47056-9186-4209-B861-9E48CF8EF2AC}']
         {* �������� ������ �������. }


                function          Get                 (const AStream: IStream;
                                                       const AItem: Pointer;
                                                       const AItemSize: LongInt
                                                      ): LongBool;
                  {* - ������� �����. }


        end;


        Im3IndexWriter=           interface(IUnknown) ['{EAB47259-C956-4B07-93C1-15D9C5ABDC2B}']
         {* �������� ������ �������. }


                procedure         Put                 (const AStream: IStream;
                                                       const AItem: Pointer;
                                                       const AItemSize: LongInt
                                                      );
                  {* - �������� �����. }


        end;


        Im3IndexUpdater=          interface(IUnknown) ['{7FD96322-8B38-471B-97A3-E276C3737E6F}']
         {* ����������� �������. }


                function          GetNormalizater     (const ANormalizaterType: Tm3NormalizaterType = Cm3NormalizaterInternal
                                                      ): Im3Normalizater;
                  {* - ���������� ������������. }


                procedure         AddMainValue        (const ANormalizater: Im3Normalizater;
                                                       const AValue: WideString;
                                                       const AItem: Pointer;
                                                       const AItemSize: LongInt
                                                      );
                  {* - ��������� ��������. }


(*                procedure         AddStopValue        (const ANormalizater: Im3Normalizater;
                                                       const AValue: WideString
                                                      );
                  {* - ��������� �������� � ����-����. }*)


        end;


        Im3IndexSearcher = interface(IUnknown)
         {* ��������� ������. }
         ['{8415E223-14A7-499E-AC89-0F91B7D8E39F}']
          // public methods
            function GetNormalizater(const ANormalizaterType: Tm3NormalizaterType = Cm3NormalizaterInternal): Im3Normalizater;
              {* - ���������� ������������. }
            function GetResult(const ANormalizater : Im3Normalizater;
                               const AValue        : WideString): Im3IndexSearcherResult;
              {* - ���������� ��������� ������. }
            function GetWordsByMask(const aMask: WideString): Im3NormalizaterResult;
              {* - ���������� ������ ���� �� �����. }
        end;//Im3IndexSearcher

  Im3IndexSearcherResult = interface(IUnknown)
   {* ��������� ������. }
    ['{9260F54C-D381-4B19-8FEA-AC46EA4033D6}']
    // public methods
      procedure Reset;
        {* - ������������� �� ������. }
      function  GetCount: LongInt;
        {* - �������� ���������� ���������. }
      function  Get(const AItem     : Pointer;
                    const AItemSize : LongInt): LongBool;
        {* - �������� ������� �������. }
  end;//Im3IndexSearcherResult

  Im3IndexStorageManager = interface(IUnknown)
   {* �������� ��������� ��� �������. }
    ['{AA10EE17-D956-4520-86AF-63BA267F1680}']
    // public methods
      function  GetRootStorage(const AReadOnly: LongBool): Im3IndexedStorage;
        {* - ���������� ��������� ��� �������. }
  end;//Im3IndexStorageManager

  Im3Normalizater = interface(IUnknown)
   {* ������������ �����. }
    ['{5235AFCE-6FAA-4C84-95B8-E26D98163859}']
    // public methods
      function GetResult(const AValue : WideString;
                         UsePseudo    : Boolean = true;
                         UseAlternate : Boolean = false): Im3NormalizaterResult;
        {* - ���������� ������ ���������� ����. }
  end;//Im3Normalizater

  Tm3NormFlag = (m3_nfPseudo, m3_nfAlternate, m3_nfError);
  Tm3NormFlags = set of Tm3NormFlag;

        Im3NormalizaterResult = interface(IUnknown) ['{92D5A655-D7C9-4954-9EE8-6045A9C191F0}']
         {* ��������� ������ �������������. }
            function GetFlags: Tm3NormFlags;
              {* - ����� ���������� ������������. }
                function          GetCount            (
                                                      ): Integer;
                  {* - ���������� ���������� ���������� ����. }

                function          GetValue            (
                                                      ): WideString;
                  {* - ���������� ������� ���������� �����. }
                procedure Reset;
                  {-}
        end;//Im3NormalizaterResult


 implementation


end.

