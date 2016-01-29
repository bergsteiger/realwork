unit l3CharsEx;

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. �                 }
{ ������: l3CharsEx -                 }
{ �����: 22.11.2000 21:03             }
{ $Id: l3CharsEx.pas,v 1.5 2007/08/02 10:37:10 lulin Exp $ }

// $Log: l3CharsEx.pas,v $
// Revision 1.5  2007/08/02 10:37:10  lulin
// - ��������� ��������� ��� ����������� �������� �����.
//
// Revision 1.4  2001/12/27 16:06:34  law
// - change: ������� ������� ����� Tl3PCharLen.
//
// Revision 1.3  2000/12/15 15:18:59  law
// - ��������� ��������� Log.
//

{$I l3Define.inc }

interface

uses
  l3Types,
  l3Chars
  ;

const
  cc_FrameParts : array [Bool, // - ����
                         Bool, // - ���
                         Bool, // - ����
                         Bool] // - �����
                  of Tl3StrPair =
    (
     ( // - ��� �����
      ( // - ��� ����
       ( // - ��� ����
         ((S: cc_HardSpace; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_HardSpace; SLen: 1; SCodePage: CP_OEM;  )),    // - ��� �����
         ((S: #151; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_HLine; SLen: 1; SCodePage: CP_OEM;  ))          // - ���� �����
       ),
       ( // -���� ����
         ((S: #151; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_HLine; SLen: 1; SCodePage: CP_OEM;  )),         // - ��� �����
         ((S: #151; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_HLine; SLen: 1; SCodePage: CP_OEM;  ))          // - ���� �����
       )
      ),
      ( // - ���� ���
       ( // - ��� ����
         ((S: '|'; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_VLine; SLen: 1; SCodePage: CP_OEM;  )),    // - ��� �����
         ((S: '�'; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_TopLeft; SLen: 1; SCodePage: CP_OEM;  ))     // - ���� �����
       ),
       ( // -���� ����
         ((S: #172; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_TopRight; SLen: 1; SCodePage: CP_OEM;  )),    // - ��� �����
         ((S: 'T'; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_UpCross; SLen: 1; SCodePage: CP_OEM;  ))     // - ���� �����
       )
      )
     ),
     ( // - ���� ����
      ( // - ��� ����
       ( // - ��� ����
         ((S: '|'; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_VLine; SLen: 1; SCodePage: CP_OEM;  )),    // - ��� �����
         ((S: 'L'; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_BottomLeft; SLen: 1; SCodePage: CP_OEM;  ))     // - ���� �����
       ),
       ( // -���� ����
         ((S: 'J'; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_BottomRight; SLen: 1; SCodePage: CP_OEM;  )),   // - ��� �����
         ((S: cc_DownCross; SLen: 1; SCodePage: CP_OEM;  ),
          (S: cc_DownCross; SLen: 1; SCodePage: CP_OEM;  ))      // - ���� �����
       )
      ),
      ( // - ���� ���
       ( // - ��� ����
         ((S: '|'; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_VLine; SLen: 1; SCodePage: CP_OEM;  )),    // - ��� �����
         ((S: cc_Plus; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_LeftCross; SLen: 1; SCodePage: CP_OEM;  ))     // - ���� �����
       ),
       ( // -���� ����
         ((S: cc_Plus; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_RightCross; SLen: 1; SCodePage: CP_OEM;  )),    // - ��� �����
         ((S: cc_Plus; SLen: 1; SCodePage: CP_ANSI; ),
          (S: cc_Cross; SLen: 1; SCodePage: CP_OEM;  ))          // - ���� �����
       )
      )
     )
    );

implementation

end.

