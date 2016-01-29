unit evHighLevelDocumentGenerator;

{ ���������� "�������"    }
{ �����: ����� �.�.       }
{ ������: evHighLevelDocumentGenerator - }
{ �����: 22.06.2005 20:50 }
{ $Id: evHighLevelDocumentGenerator.pas,v 1.14 2013/10/21 15:42:58 lulin Exp $ }

// $Log: evHighLevelDocumentGenerator.pas,v $
// Revision 1.14  2013/10/21 15:42:58  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.13  2013/10/21 10:30:41  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.12  2009/06/02 18:55:08  lulin
// - �������������� ������ � �����.
//
// Revision 1.11  2009/03/04 13:32:46  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.10  2008/10/09 13:37:34  lulin
// - <K>: 121145547.
//
// Revision 1.9  2008/06/09 12:16:49  lulin
// - bug fix: �� ��������� �������.
//
// Revision 1.8  2008/04/02 11:35:35  lulin
// - ������� �������� ���������������� ��������� � ���������� ���������� � ������� �1.
//
// Revision 1.7  2008/03/20 09:48:08  lulin
// - cleanup.
//
// Revision 1.6  2008/02/07 14:44:22  lulin
// - ����� _Tl3LongintList �������� � ����������� ������.
//
// Revision 1.5  2007/12/05 18:25:39  lulin
// - ������ �������� ���.
//
// Revision 1.4  2007/12/04 12:47:02  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.1.2.10  2007/12/03 15:51:40  lulin
// - cleanup.
//
// Revision 1.1.2.9  2007/10/09 13:09:12  lulin
// - ��������� ���� ��������� �������� � ����� ���������� �����.
//
// Revision 1.1.2.8  2007/10/09 11:31:08  lulin
// - bug fix: ��������� ��������� ��� ������� ������, ��� ���������, ������������ � ���� ����� - � ���������� AV (CQ OIT5-26978).
//
// Revision 1.1.2.7  2005/10/18 07:19:40  lulin
// - new behavior: ������ ������ ������� � ���������� �������� ����� ����� ��������� ����������� ����.
//
// Revision 1.1.2.6  2005/07/21 13:33:13  lulin
// - � ���������� ��������� ������ ������ ��� ��������� ���������.
//
// Revision 1.1.2.5  2005/07/04 07:39:44  lulin
// - ������������� ������ � ������� ��������� ���������� � "����������" ����������.
//
// Revision 1.1.2.4  2005/06/22 17:53:03  lulin
// - ���� ������������� � ������������ � ��������� ����������.
//
// Revision 1.1.2.3  2005/06/22 17:34:09  lulin
// - ��������� ��������� � ������ ��������� � "����������" ����������.
//
// Revision 1.1.2.2  2005/06/22 17:14:52  lulin
// - cleanup.
//
// Revision 1.1.2.1  2005/06/22 17:05:17  lulin
// - new unit: evHighLevelDocumentGenerator.
//

{$Include evDefine.inc }

interface

uses
  l3Types,

  l3Base,

  k2Types,
  k2Interfaces,
  k2DocumentGenerator,

  nevTools
  ;

type
  TevHighLevelDocumentGenerator = class(Tk2DocumentGenerator)
   {*! ��������� ��������� "�������� ������". }
    private
    // property fields
      f_LoadFlags     : TevLoadDocFlags;
    public
    // public methods
      constructor CreateWithTarget(const aTarget: Ik2GeneratorTarget);
        {-}
    public
    // public properties
      property LoadFlags: TevLoadDocFlags
        read f_LoadFlags
        write f_LoadFlags;
        {* - ����� ���������. }
  end;//TevHighLevelDocumentGenerator
  {* ��������� ��������� "�������� ������". ������������ ��� �������� ��������� � ������, �������� � _TevCustomTextSource. }

  TevPreAddHighLevelDocumentGenerator = class(TevHighLevelDocumentGenerator)
    protected
    // internal methods
      function  NeedPreAddChild(const aChild: Tk2StackAtom): Boolean;
        override;
        {-}
  end;//TevPreAddHighLevelDocumentGenerator

implementation

uses
  SysUtils,
  
  k2Tags,

  evdTypes,

  ParaList_Const
  ;

// start class TevHighLevelDocumentGenerator 

constructor TevHighLevelDocumentGenerator.CreateWithTarget(const aTarget: Ik2GeneratorTarget);
  {-}
begin
 inherited Create;
 Target := aTarget;
end;
  
// start class TevPreAddHighLevelDocumentGenerator

function TevPreAddHighLevelDocumentGenerator.NeedPreAddChild(const aChild: Tk2StackAtom): Boolean;
  //override;
  {-}
begin
 Result := aChild.IsKindOf(k2_typParaList);
 // - ���� ��� - ����� ��������� � ���������� �� ������������, �.�. ��� ��������
 //   ������ �� ������ ������, ��� ���� ����� ��������� Reader.
(* {$Else  _evFormatOnDraw}
 Result := aChild.IsKindOf(k2_idPara);
 // - ��������� ���� ��������� ����� �� ��� ��� ���������
 {$EndIf _evFormatOnDraw}*)
end;

end.

