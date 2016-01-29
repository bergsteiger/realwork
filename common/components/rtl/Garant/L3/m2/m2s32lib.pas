unit    m2S32Lib;
{* ������� ��� ������ �� ��������� 32-������� �������. }

(*
//
//
// .Author: Mickael P. Golovin.
// .Copyright: 1997-2001 by Archivarius Team, free for non commercial use.
//
//
*)
// $Id: m2s32lib.pas,v 1.1 2008/02/22 17:10:08 lulin Exp $

// $Log: m2s32lib.pas,v $
// Revision 1.1  2008/02/22 17:10:08  lulin
// - ���������� ���������.
//
// Revision 1.2  2007/12/10 15:33:04  lulin
// - cleanup.
//
// Revision 1.1  2007/12/07 11:51:05  lulin
// - �������.
//
// Revision 1.2  2001/10/18 12:10:32  law
// - comments: xHelpGen.
//

{$I m2Define.inc}

interface


 function    m2S32Min             (const AParamA: LongInt;
                                   const AParamB: LongInt
                                  ): LongInt; register;
   {* - ���������� ����������� �� ���� �����. }

 function    m2S32Max             (const AParamA: LongInt;
                                   const AParamB: LongInt
                                  ): LongInt; register;
   {* - ���������� ������������ �� ���� �����. }


 function    m2S32Compare         (const AParamA: LongInt;
                                   const AParamB: LongInt
                                  ): Integer; register;
   {* - ���������� ��� �����. }

 implementation


 function    m2S32Min(const AParamA: LongInt;
                      const AParamB: LongInt
                     ): LongInt;
 asm

                cmp   eax,edx
                jle   @@01
                mov   eax,edx

  @@01:

 end;

 function    m2S32Max(const AParamA: LongInt;
                      const AParamB: LongInt
                     ): LongInt;
 asm

                cmp   eax,edx
                jnle  @@01
                mov   eax,edx

  @@01:

 end;

 function    m2S32Compare(const AParamA: LongInt;
                          const AParamB: LongInt
                         ): Integer;
 asm

                mov   ecx,eax
                xor   eax,eax
                cmp   ecx,edx
                je    @@02
                jl    @@01
                inc   eax
                jmp   @@02

  @@01:         dec   eax

  @@02:

 end;


end.

