unit    m3SorInt;

(*
//
//
// .Author: Mickael P. Golovin.
// .Copyright: 1997-2001 by Archivarius Team, _free for non commercial use.
//
//
*)

{$I m3Define.inc}

interface

 uses
         ActiveX,
         l3Types
         ;


 type
        Im3Sorter=                interface(IUnknown) ['{8142846B-826B-4680-8647-F189733F067E}']


                function          GetCount: Int64;


                function          GetItemSize         (
                                                      ): LongInt;


                function          Get                 (const AItem     : Pointer;
                                                       const AItemSize : LongInt;
                                                       aCount          : PLarge = nil
                                                      ): LongBool;

                procedure         Put                 (const AItem: Pointer;
                                                       const AItemSize: LongInt
                                                      );


        end;


        Im3SorterComparer=        interface(IUnknown) ['{F84E74B4-5A88-46C0-A77C-98B3F3BC33DD}']


                function          Compare             (const AVal1: Pointer;
                                                       const AVal2: Pointer;
                                                       const ASize: LongInt
                                                      ): Integer;


        end;


 implementation


end.

