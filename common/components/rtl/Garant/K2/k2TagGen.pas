unit k2TagGen;
{* ������� ����������� ����� ��� ����������� �����. }

{ ���������� "K-2"        }
{ �����: ����� �.�.       }
{ ������: k2TagGen -      }
{ �����: 01.12.1998 18:48 }
{ $Id: k2TagGen.pas,v 1.155 2015/10/14 15:32:25 lulin Exp $ }

// $Log: k2TagGen.pas,v $
// Revision 1.155  2015/10/14 15:32:25  lulin
// - �����������.
//
// Revision 1.154  2015/05/21 12:02:11  lulin
// - ����������� �����������.
//
// Revision 1.153  2015/05/21 11:37:08  lulin
// - ����������� �����������.
//
// Revision 1.152  2015/05/19 15:45:35  lulin
// - ������ ���.
//
// Revision 1.151  2015/04/13 16:33:52  lulin
// - ��������������.
//
// Revision 1.150  2014/07/03 14:33:15  lulin
// - �������� ��� ��������������� ������������� ����� � �����.
//
// Revision 1.149  2014/05/14 13:11:46  lulin
// {RequestLink:517789752}.
//
// Revision 1.148  2014/04/30 15:03:20  lulin
// - ���������� �����������.
//
// Revision 1.147  2014/04/30 11:24:07  lulin
// - ���������� �����������.
//
// Revision 1.146  2014/04/29 13:38:56  lulin
// - �������� �������� �����������.
//
// Revision 1.145  2014/04/23 11:13:52  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.144  2014/04/22 17:32:36  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.143  2014/04/22 10:56:18  lulin
// - ������ �������� �����.
//
// Revision 1.142  2014/04/21 17:21:26  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.141  2014/04/08 17:13:26  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.140  2014/04/07 17:57:11  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.139  2014/04/03 17:10:39  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.138  2014/03/27 14:20:07  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.137  2014/03/20 12:24:03  lulin
// - ������������� ������ � ������.
//
// Revision 1.136  2014/03/18 09:59:12  lulin
// - ������������� ������ � ������.
//
// Revision 1.135  2014/03/05 15:19:39  lulin
// - bug fix: ����������� ��������� ��������� ����.
//
// Revision 1.134  2014/02/28 17:04:27  lulin
// - ����������� ���.
//
// Revision 1.133  2014/02/28 14:54:26  lulin
// - ������������� ����������.
//
// Revision 1.132  2014/02/24 13:59:43  lulin
// - �������� ��������.
//
// Revision 1.131  2014/02/24 13:38:28  lulin
// {RequestLink:518433323}
//
// Revision 1.130  2014/02/21 18:33:02  lulin
// - ����������� �� ������ ��� ������.
//
// Revision 1.129  2014/02/21 16:28:28  lulin
// - ����������� �� ������ ��� ������.
//
// Revision 1.128  2014/02/14 15:33:47  lulin
// - ����������� �� ������ ���������.
//
// Revision 1.127  2013/10/22 16:45:06  lulin
// - ������������ ������� �����, ����� ��������� �� "���������" � ����������������.
//
// Revision 1.126  2013/10/18 14:11:33  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.125  2013/04/08 18:03:18  lulin
// - �������� ���������� ��� XE.
//
// Revision 1.124  2013/04/04 11:21:38  lulin
// - ���������.
//
// Revision 1.123  2012/02/10 15:50:03  lulin
// {RequestLink:329646242}
//
// Revision 1.122  2011/09/19 15:24:34  lulin
// {RequestLink:283615304}.
//
// Revision 1.121  2011/09/19 13:17:14  lulin
// - ������� ��������� Filer'�.
//
// Revision 1.120  2011/07/28 11:46:48  lulin
// {RequestLink:276535082}.
//
// Revision 1.119  2010/06/18 16:04:16  lulin
// {RequestLink:182452717}.
//
// Revision 1.118  2010/06/18 14:49:26  lulin
// {RequestLink:182452717}.
// - ������ ��� ������ ������� ����� ����� ��������� �� �������.
//
// Revision 1.117  2010/05/26 14:32:05  lulin
// {RequestLink:216072357}.
// - ������ ������� ��� ��������� ������������� ��������� ��������� ������������� ����������� �����.
//
// Revision 1.116  2010/04/14 16:34:39  lulin
// {RequestLink:191730233}.
//
// Revision 1.115  2010/01/19 10:38:01  dinishev
// [$178324283]
//
// Revision 1.114  2010/01/18 07:36:05  dinishev
// [$178324283]
//
// Revision 1.113  2009/08/07 09:28:18  lulin
// {RequestLink:159353531}.
//
// Revision 1.112  2009/07/03 16:24:13  lulin
// - ��� � �������� �� ����������� � ��������.
//
// Revision 1.111  2009/03/04 17:38:13  lulin
// - <K>: 137470629. ����� �������� ���������.
//
// Revision 1.110  2009/03/04 13:33:12  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.109  2009/02/26 12:25:11  lulin
// - <K>: 137465982. �1
//
// Revision 1.108  2008/12/12 19:19:28  lulin
// - <K>: 129762414.
//
// Revision 1.107  2008/05/20 10:55:38  lulin
// - bug fix: �� �������������� ����������.
// - <K>: 90443881.
//
// Revision 1.106  2008/02/05 18:20:40  lulin
// - ������� �������� �������� �����.
//
// Revision 1.105  2008/02/05 17:39:37  lulin
// - ����������� �� ��������� ������������ �������.
//
// Revision 1.104  2008/02/05 16:13:16  lulin
// - ��������� ������� ������ �� ������� ��������.
//
// Revision 1.103  2008/02/05 12:49:23  lulin
// - �������� ������� �������.
//
// Revision 1.102  2007/12/21 15:21:56  lulin
// - cleanup.
//
// Revision 1.101  2007/09/14 13:26:19  lulin
// - ��������� � ������ B_Tag_Clean.
//
// Revision 1.100.4.1  2007/09/12 18:44:36  lulin
// - ������ �������� ��������.
//
// Revision 1.100  2007/08/30 08:48:49  lulin
// - ������ �������� �������������.
//
// Revision 1.99  2007/08/30 08:34:34  narry
// - ������������� ����������
//
// Revision 1.98  2007/08/29 17:33:41  lulin
// - ��������� ����� ����������.
//
// Revision 1.97  2007/08/28 15:27:09  lulin
// - cleanup.
//
// Revision 1.96  2007/08/14 14:30:10  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.95  2007/08/13 15:19:37  lulin
// - ����������� �� ���������� ����.
//
// Revision 1.94  2007/08/10 19:17:26  lulin
// - cleanup.
//
// Revision 1.93  2007/08/09 13:41:56  lulin
// - ����������� �� �������� ��������.
//
// Revision 1.92  2007/08/09 12:38:17  lulin
// - ������� ������������ ������ � ����������� ������� �����.
//
// Revision 1.91  2007/08/09 11:55:33  lulin
// - cleanup.
//
// Revision 1.90  2007/08/09 11:46:39  lulin
// - cleanup.
//
// Revision 1.89  2007/01/30 15:24:21  lulin
// - ����� ���� - ������ ����� �������� ����.
//
// Revision 1.88  2006/11/25 16:59:45  lulin
// - bug fix: �� ��������������� ����������.
//
// Revision 1.87  2006/11/25 16:50:32  lulin
// - ������� ������,������ ����� ����������� �����.
//
// Revision 1.86  2006/11/25 16:35:45  lulin
// - � ���������� ���������� ������� �������� ��� ������.
//
// Revision 1.85  2006/04/18 07:45:23  lulin
// - cleanup.
//
// Revision 1.84  2006/04/18 07:41:53  lulin
// - cleanup.
//
// Revision 1.83  2006/04/11 17:55:28  lulin
// - ������������ ��� ������ ��������� ����� (�� ������ ���� ��� ����� ������� � �������� 20% ������������������).
//
// Revision 1.82  2006/01/25 09:08:17  lulin
// - cleanup.
//
// Revision 1.81  2005/11/15 14:11:31  lulin
// - cleanup.
//
// Revision 1.80  2005/11/15 12:23:26  lulin
// - cleanup.
//
// Revision 1.79  2005/11/09 15:28:38  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.78  2005/08/25 14:35:19  lulin
// - bug fix: �������������� �������������������� ���������.
//
// Revision 1.77  2005/03/29 15:25:20  lulin
// - new method: Tk2TagGenerator.Make.
//
// Revision 1.76  2005/03/29 15:02:36  lulin
// - ���������� ��������� ������ ������.
//
// Revision 1.75  2005/03/29 14:49:00  lulin
// - �������� Ik2TagGenerator.Generator ������������� � _NextGenerator - �� ��������� �������� � ������ ���������� with.
//
// Revision 1.74  2005/03/28 14:30:09  lulin
// - �� ������ ����������� ��������� � ����������.
//
// Revision 1.73  2005/03/24 18:39:30  lulin
// - remove object: Tk2AtomR.
//
// Revision 1.72  2005/03/18 15:00:20  lulin
// - new interface: Ik2TagGenerator.
//
// Revision 1.71  2005/02/15 15:19:46  lulin
// - new method version: Tk2CustomFileReader.SetTo.
//
// Revision 1.70  2005/02/15 15:12:59  lulin
// - ��������� ������������.
//
// Revision 1.69  2004/11/26 13:30:27  lulin
// - new unit: k2ForkGenerator.
//
// Revision 1.68  2004/11/26 10:14:09  lulin
// - new behavior: ��� ������� ������ "����" ����������� - "�����������" ��� � �����������.
//
// Revision 1.67  2004/10/19 15:49:43  lulin
// - new behavior: � ������ TevCustomTextSource.GetGenerator � ������� ����������� ������������ TevDocumentContainerRestorer - ����� ���� ����������� � ������� ������������ ��������� ���������, ����� ���������� ��������.
//
// Revision 1.66  2004/09/21 12:04:26  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.65  2004/06/08 12:13:52  law
// - ������� �������� ��������� �������, �������� ������ �� ��������.
//
// Revision 1.64  2004/06/03 17:15:47  law
// - new interface: _Ik2Base.
//
// Revision 1.63  2004/05/14 14:49:04  law
// - ���������� �������� � ��������.
//
// Revision 1.62  2004/05/14 14:08:57  law
// - change: TevVariant ������������ � Tk2Variant � �������� � k2Types.
//
// Revision 1.61  2004/04/12 13:29:32  law
// - new: �������� ��� ���������� "��������� ������", �� �������� ShortName ������ �������������� �� �������, � �������� �����.
//
// Revision 1.60  2004/04/02 11:46:55  law
// - new behavior: � Tk2TagGenerator �� ��������� Exception '������� Finish ������ ��� ������� _Start' ��� ���������� �������� ���������.
//
// Revision 1.59  2003/12/03 13:17:01  law
// - new method: Tk2TagGenerator.SetTo - ��� ���������� ���������� ����������� � �������.
//
// Revision 1.58  2003/11/29 15:36:30  law
// - new class: TeeHyperlinkFilter.
// - new proc: eeSetHyperlinkFilter.
//
// Revision 1.57  2003/10/14 13:12:04  law
// - new method: IeeGenerator._AddRawData.
//
// Revision 1.56  2003/06/03 09:54:39  law
// - new type: Rk2TagGenerator.
//
// Revision 1.55  2002/12/24 13:02:02  law
// - change: ��������� Int64_Seek c �������� ������.
//
// Revision 1.54.2.1  2002/12/23 15:51:27  law
// - bug fix: �� �������� � ���������� > 2��.
//
// Revision 1.54  2002/11/27 10:25:52  voba
// - add class Tk2FakeGenerator
//
// Revision 1.53  2002/11/21 18:33:09  law
// - _move and rename class: evStrGen.TevBaseFileGenerator -> k2StackGenerator.Tk2CustomStackGeneratorEx.
//
// Revision 1.52  2002/09/18 06:03:33  law
// - cleanup: ������ �������� IsDefault.
//
// Revision 1.51  2002/07/09 12:02:25  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.50  2002/04/17 12:39:08  narry
// - bug fix: AV ������ ����� WriteDatarEx.
//
// Revision 1.49  2002/03/26 16:31:57  law
// - cleanup.
//
// Revision 1.48  2002/01/29 16:18:49  law
// - bug fix: Range Check Error ��� ����������� ������� �����.
//
// Revision 1.47  2001/12/27 15:03:31  law
// - new constructors: ��������� ��� ������������ _Tl3String.Make.
//
// Revision 1.46  2001/12/18 14:12:26  law
// - new behavior: �������������� ����������� �� �������� ����������.
//
// Revision 1.45  2001/08/31 07:16:24  law
// - cleanup: ������ �������� ������ �� Windows.
//
// Revision 1.44  2001/08/29 07:01:09  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.43  2001/07/17 14:59:02  law
// - bug fix: � ������������ � ������� �722.
//
// Revision 1.42  2001/06/14 12:23:14  law
// - new behavior; ��������� ���������� ������ ���������� � BeforeRelease.
//
// Revision 1.41  2001/06/14 11:43:55  voba
// - new behavior: ������ ��������� �� ������ ����������� log.
//
// Revision 1.40  2001/06/05 13:42:34  law
// - comments: ��� ����������� ��� xHelpGen.
//
// Revision 1.39  2001/05/31 09:23:40  law
// - cleanup: ������ ������ �� ������ ������� ����� �����.
//
// Revision 1.38  2001/05/31 08:30:33  law
// - cleanup: ������ ������ ���������.
// - comments: ��������� ����������� ��� xHelpGen.
//
// Revision 1.37  2001/05/30 09:11:19  law
// - new behavior: �������� �������������� ��������� ������ ������ ����������.
//
// Revision 1.36  2001/05/04 10:59:39  law
// - new behavior: ��������� ��������������� ��������� GeneratorChanged.
//
// Revision 1.35  2001/04/27 11:36:09  voba
// - new prop: ��������� �������� CurrentStartLevel.
// - undo behavior: ����� ����������� Exception ��� ������� ������� Finish ������, ��� _Start*.
//
// Revision 1.34  2001/04/25 14:48:18  voba
// - new behavior: ������� �������� ������ ������ ������� �����������.
//
// Revision 1.33  2001/04/20 11:18:07  law
// - new const: ��������� ��������� ev_inch*.
//
// Revision 1.32  2001/04/18 13:25:23  law
// - comments: ��������� ����������� ��� xHelpGen.
//
// Revision 1.31  2001/03/14 13:24:55  law
// - some cleaup and tuning.
//
// Revision 1.30  2001/01/09 12:21:43  law
// - ������: Str2Log -> Msg2Log.
//
// Revision 1.29  2000/12/15 15:18:59  law
// - ��������� ��������� Log.
//

{$Include k2Define.inc }

interface

uses
  Classes,
  TypInfo,

  l3Interfaces,
  l3Types,
  l3Chars,
  l3IID,
  l3ProtoObject,
  l3ProtoObjectWithCOMQI,
  l3Base,
  {$IfDef k2GeneratorIsComponent}
  l3InterfacedComponent,
  {$EndIf k2GeneratorIsComponent}
  l3Variant,

  k2Interfaces,
  k2Types,
  k2Prim,
  k2Base
  ;

type
  Tk2TagGenerator = class;

  Ik2TagGeneratorWrap = interface(Ik2Base)
   {* ������� ������ ���������� �����. }
    ['{ED2482DF-51DC-47A3-A77E-A147B246F7E4}']
    function Generator: Tk2TagGenerator;
      {-}
  end;//Ik2TagGeneratorWrap

  Ik2TagGeneratorChainEnd = interface(Ik2Base)
    ['{7E05B506-F173-4DA5-B99E-D78D17037138}']
    procedure Link(const G: Ik2TagGenerator);
      {-}
    procedure UnLink(const G: Ik2TagGenerator);
      {-}
  end;//Ik2TagGeneratorChainEnd

  {$IfDef k2GeneratorIsComponent}
  Tk2TagGeneratorAncestor = Tl3InterfacedComponent;
  Tk2TagGeneratorOwner = TComponent;
  {$Else  k2GeneratorIsComponent}
  Tk2TagGeneratorAncestor = {Tl3ProtoObjectWithCOMQI}Tl3Base;
  Tk2TagGeneratorOwner = TObject;
  {$EndIf k2GeneratorIsComponent}

  Rk2TagGenerator = class of Tk2TagGenerator;

  Tk2TagGenerator = class(Tk2TagGeneratorAncestor,
                          Ik2TagGeneratorWrap,
                          Ik2TagGeneratorChainEnd,
                          Ik2TagGenerator)
   {* ������� ����������� ����� ��� ����������� �����. }
    private
    // property fields
      f_Context          : Il3OpPack;
      f_FakeStarts       : Long;
      f_CharsInLine      : Long;
      f_TT               : Tk2TypeTable;
      f_TypeTable        : Tk2TypeTable;
      f_Version        : Long;
    protected
    // internal fields
      f_Generator        : Ik2TagGenerator;
      f_Starts           : Long;
    protected
    // property methods
      function  pm_GetCurrentStartLevel: Long;
        {-}
      function  pm_GetContext: Il3OpPack;
      procedure pm_SetContext(const aValue: Il3OpPack);
        {-}
      function  pm_GetNextGenerator: Ik2TagGenerator; virtual;
      procedure pm_SetNextGenerator(const Value: Ik2TagGenerator); virtual;
        {-}
      function  pm_GetStreamOpened: Bool;
        {-}
      procedure pm_SetCharsInLine(Value: Long);
        virtual;
        {-}
(*      function  pm_GetTypeTable: Ik2TypeTable;*)
      procedure pm_SetTypeTable(const Value: Tk2TypeTable);
        {-}
      function  pm_GetCurrentType: Tk2Type;
        virtual;
        //abstract;
        {-}
    protected
    // internal methods
      function  NeedsCheckBrackets: Boolean;
        virtual;
        {-}
      procedure BeforeRelease;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
      procedure OpenStream;
        virtual;
        {* - ���������� ���� ��� ��� ������ ���������. ��� ���������� � ��������. }
      procedure CloseStream(NeedUndo: Bool);
        virtual;
        {* - ���������� ���� ��� � ����� ���������. ��� ���������� � ��������. }
      procedure CloseStructure(NeedUndo: Bool);
        virtual;
        {* - ���������� �� ������������� "������". ��� ���������� � ��������. }
      procedure GeneratorChanged;
        virtual;
        {* - ����������� � ����� ���������� ����������. ��� ���������� � ��������. }
      procedure ConvertErrorEx(TypeKind: Tk2VarKind);
        {* - ��������� �� ������ �����������. }
      {$IfDef k2GeneratorIsComponent}
      procedure Notification(aComponent: TComponent; Operation: TOperation);
        override;
        {-}
      {$EndIf k2GeneratorIsComponent}  
      procedure TranslateAddAtom(AtomIndex: Long; aValue: Tl3Variant);
        {-}
   function Get_CurrentVersion: Integer;
   procedure Set_CurrentVersion(aValue: Integer);
     virtual;
    protected
    // protected properties
      property Generator: Ik2TagGenerator
        read f_Generator
        write pm_SetNextGenerator;
        {* - ��������� ��������� � �������. }
      property CurrentVersion: Long
        read f_Version
        write Set_CurrentVersion;
        {-}
    public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        {$IfDef k2GeneratorIsComponent}override{$Else}virtual{$EndIf};
        //override;
        {-}
      class function Make: Ik2TagGenerator;
        reintroduce;
        virtual;
        {-}
      class function SetTo(var theGenerator: Tk2TagGenerator): Pointer;
        overload;
        {* - ������� ��������� ����� � ������� ��� � ����������. }
      class function SetTo(var theGenerator: Ik2TagGenerator): Ik2TagGenerator;
        overload;
        {* - ������� ��������� ����� � ������� ��� � ����������. }
      procedure Start;
        {* - ������ ���������. }
      procedure Finish(NeedUndo: Bool = false);
        {* - ������� ������ ����� ���������. }
      procedure StartObject(ID: Long);
        {-}
      function  GetObjectID(const Name: AnsiString; Child: Bool): Long;
        virtual;
        {-}
      procedure StartTag(TagID: Long);
        virtual;
        {* - ������ �������� ���. }
      procedure StartChild(TypeID: Tl3VariantDef);
        virtual;
        {* - ������ �������� ������ ����. }
      procedure StartDefaultChild;
        {-}
      procedure AddAtom(AtomIndex: Long; aValue: Tl3Variant);
        virtual;
        {* - �������� ����. }
      procedure AddTransparentAtom(TagID: Long);
        {* - �������� "����������" ����. }
      procedure AddInt64Atom(TagID: Long; aValue: Int64);
        {* - �������� ������������� ����. }
      procedure AddIntegerAtom(TagID: Long; Value: Long);
        {* - �������� ������������� ����. }
      procedure AddBoolAtom(TagID: Long; Value: Bool);
        {* - �������� ��������� ����. }
      procedure AddStringAtom(TagID: Long; const Value: AnsiString; aCodePage: Long = CP_ANSI);
        overload;
        {* - �������� ��������� ����. }
      procedure AddStringAtom(TagID: Long; const Value: Tl3WString); overload;
        {* - �������� ��������� ����. }
      procedure AddStreamAtom(TagID: Long; aStream: TStream);
        {* - �������� ���� �� ������. }
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        virtual;
        {-}
      procedure AfterStreamOpened;
        virtual;
        {-}
      function  Pixel2Char(Pixel: Long): Long;
        {-}
      function  Char2Pixel(Ch: Long): Long;
        {-}
      procedure Error(const Message: AnsiString; NeedException : Bool = true);
        virtual;
        {-}
      procedure Msg2Log(const Message: AnsiString);
        {-}
      // Ik2TagGeneratorWrap
      function  GetGenerator: Tk2TagGenerator;
        {-}
      function  Ik2TagGeneratorWrap.Generator = GetGenerator;
        {-}
      // Ik2TagGeneratorChainEnd  
      procedure Link(const G: Ik2TagGenerator);
        {-}
      procedure UnLink(const G: Ik2TagGenerator);
        {-}
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
      procedure Rollback(CheckBrackets: Bool = false);
        {* - �������� ��� �������� "������". }
      procedure FindGeneratorByDesiredClass(aClass : Rk2TagGenerator;
                                            var aRef);
       {-}                                           
    public
    // public properties
      property Context: Il3OpPack
        read f_Context
        write f_Context;
        {* - �������� � ������� �������� ���������. }
      property StreamOpened: Bool
        read pm_GetStreamOpened;
        {* - ��������� ������?}
      property CharsInLine: Long
        read f_CharsInLine
        write pm_SetCharsInLine
        default 73;
        {-}
      property CurrentStartLevel: Long
        read f_Starts;
        {* - ���������� �������� "������". }
      property OpenStreamLevel: Long
        read f_FakeStarts;
        {* - ���������� ������� Start. }    
      property TypeTable: Tk2TypeTable
        read f_TypeTable;
        {* - ������� �������� ����� �����. }
      property TT: Tk2TypeTable
        read f_TT
        write pm_SetTypeTable;
        {* - ������� �������� ����� �����. }
    public
    // public events
      property CurrentType: Tk2Type
        read pm_GetCurrentType;
        {* - ��� �������� �������. }
  end;//Tk2TagGenerator
  {* ������� ����� ��� ��������� ��������� ����������������� �������� (�����).
     ������ �
     | <a href="MetaFormat.txt">������������</a>
     ������ ������ �������
     ��� �������������� ��������� �������� ���� � �����
     (��� ������� ���� Reader/Writer), � ����� ���
     ���������� � �������� ����������������� ��������. }

  Tk2FakeGenerator = class(Tk2TagGenerator)
  end;

implementation

uses
  SysUtils,

  l3Except,
  l3Memory,
  l3Stream,
  l3String,
  l3Math,
  l3InterfacesMisc,
  l3Defaults,
  l3Units,
  l3_Base,
  l3BaseStream,

  k2Facade,
  k2Const,
  k2Tags,
  k2InternalInterfaces,
  k2Strings,
  k2String,
  k2VariantImpl,

  k2Ver,
  
  //evDef,
  //Document_Const,
  k2Long_Const,

  k2SizedMemoryPool,
  ComObj

  {$If not defined(NoScripts)}
  ,
  kwFiltersAndGeneratorsPack
  {$IfEnd}
  ;

// start class Tk2TagGenerator 

function Tk2TagGenerator.pm_GetCurrentStartLevel: Long;
  {-}
begin
 Result := f_Starts;
end;

function Tk2TagGenerator.pm_GetContext: Il3OpPack;
  {-}
begin
 Result := f_Context;
end;

procedure Tk2TagGenerator.pm_SetContext(const aValue: Il3OpPack);
  {-}
begin
 f_Context := aValue;
end;

function Tk2TagGenerator.pm_GetNextGenerator: Ik2TagGenerator;
  {-}
begin
 Result := f_Generator;
end;

procedure Tk2TagGenerator.pm_SetNextGenerator(const Value: Ik2TagGenerator);
  {-}
begin
 if (f_Generator <> Value) then
 begin
  f_Generator := Value;
  GeneratorChanged;
 end;//f_Generstor <> Value
 if (Generator <> nil) then
 begin
  Generator.CharsInLine := CharsInLine;
  Generator.CurrentVersion := CurrentVersion;
 end;//Generator <> nil
end;

function Tk2TagGenerator.pm_GetStreamOpened: Bool;
  {-}
begin
 Result := (f_Starts > 0);
end;

procedure Tk2TagGenerator.pm_SetCharsInLine(Value: Long);
  {-}
begin
 if (f_CharsInLine <> Value) then
 begin
  f_CharsInLine := Value;
  if (Generator <> nil) then
   Generator.CharsInLine := Value;
 end;//f_CharsInLine <> Value
end;

(*function Tk2TagGenerator.pm_GetTypeTable: Tk2TypeTable;
  {-}
begin
 Result := f_TT;
end;*)

procedure Tk2TagGenerator.pm_SetTypeTable(const Value: Tk2TypeTable);
  {-}
begin
 f_TT := Value;
 f_TypeTable := Value;
end;

function Tk2TagGenerator.pm_GetCurrentType: Tk2Type;
  //virtual;
begin
 Result := nil;
end;
  
function Tk2TagGenerator.NeedsCheckBrackets: Boolean;
  //virtual;
  {-}
begin
 Result := true;
end;

procedure Tk2TagGenerator.BeforeRelease;
  //override;
  {-}
begin
 Rollback(NeedsCheckBrackets);
 inherited;
end;

procedure Tk2TagGenerator.Cleanup;
  {override;}
  {-}
begin
 try
  Context := nil;
 finally
  Generator := nil;
  inherited;
  TT := nil;
 end;//try..finally
end;

procedure Tk2TagGenerator.Rollback(CheckBrackets: Bool = false);
  {-}
var
 BC : Long;
begin
 BC := 0;
 while StreamOpened do
 begin
  Finish(true);
  Inc(BC);
 end;//while StreamOpened
 if CheckBrackets then
 begin
  if (BC > 0) then
   Error(Format(k2_errBracketsNotClosed, [BC, ClassName]), false);
 end//CheckBrackets
 else
 if (Generator <> nil) then
  Generator.Rollback;
end;

procedure Tk2TagGenerator.FindGeneratorByDesiredClass(aClass : Rk2TagGenerator;
                                                      var aRef);
 {-}
var
 l_G : Tk2TagGenerator;
 l_N : Ik2TagGenerator;
begin
 l_G := Self;
 while (l_G <> nil) do
 begin
  if l_G.InheritsFrom(aClass) then
  begin
   l_G.SetRefTo(aRef);
   break;
  end;//l_G.InheritsFrom(aClass)
  l_N := l_G.Generator;
  if (l_N = nil) then
   break;
  l_G := (l_N As Ik2TagGeneratorWrap).Generator; 
 end;//l_G <> nil
end;
 
function Tk2TagGenerator.Get_CurrentVersion: Integer;
begin
 Result := f_Version;
end;

procedure Tk2TagGenerator.Set_CurrentVersion(aValue: Integer);
begin
 f_Version := aValue;
 if (Generator <> nil) then
  Generator.CurrentVersion := aValue;
end;

function Tk2TagGenerator.Pixel2Char(Pixel: Long): Long;
  {-}
begin
 Result := l3MulDiv(Pixel, CharsInLine, def_inchPrintableWidth);
end;

function Tk2TagGenerator.Char2Pixel(Ch: Long): Long;
  {-}
begin
 Result := l3MulDiv(Ch, def_inchPrintableWidth, CharsInLine);
end;

procedure Tk2TagGenerator.Error(const Message: AnsiString; NeedException : Bool = true);
var
 E : Exception;
begin
 if NeedException then
 begin
  E := Exception.Create(Message);
  l3System.Msg2Log(E.Message);
  raise E;
 end//NeedException
 else
  l3System.Msg2Log(Message);
end;

procedure Tk2TagGenerator.Msg2Log(const Message: AnsiString);
  {-}
begin
 Error(Message, false);
end;

function Tk2TagGenerator.GetGenerator: Tk2TagGenerator;
  {-}
begin
 Result := Self;
end;

procedure Tk2TagGenerator.Link(const G: Ik2TagGenerator);
  {-}
var
 l_G : Ik2TagGenerator;
begin
 l_G := Self;
 while (l_G <> nil) AND (l_G.NextGenerator <> nil) do
  l_G := l_G.NextGenerator;
 if (l_G <> nil) then
  l_G.NextGenerator := G;
end;

procedure Tk2TagGenerator.UnLink(const G: Ik2TagGenerator);
  {-}
var
 l_G : Ik2TagGenerator;
begin
 l_G := Self;
 while (l_G <> nil) do begin
  if l3IEQ(l_G.NextGenerator, G) then
  begin
   l_G.NextGenerator := nil;
   Exit;
  end;//l3IEQ..
  l_G := l_G.NextGenerator;
 end;//while (l_G <> nil)
end;

function Tk2TagGenerator.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  {override;}
  {-}
begin
 if IID.EQ(Ik2FilerSource) AND (f_Generator <> nil) then
  Result := Tl3HResult_C(f_Generator.QueryInterface(IID.IID, Obj))
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

procedure Tk2TagGenerator.AfterStreamOpened;
  {virtual;}
  {-}
begin
end;

procedure Tk2TagGenerator.OpenStream;
  {virtual;}
  {-���������� ���� ��� ��� ������ ���������}
begin
end;

procedure Tk2TagGenerator.CloseStream(NeedUndo: Bool);
  {virtual;}
  {-���������� ���� ��� � ����� ���������}
begin
end;

procedure Tk2TagGenerator.CloseStructure(NeedUndo: Bool);
  {virtual;}
  {-���������� �� ������������� ������}
begin
end;

procedure Tk2TagGenerator.GeneratorChanged;
  //virtual;
  {-}
begin
end;
  
constructor Tk2TagGenerator.Create(anOwner: Tk2TagGeneratorOwner = nil);
  {override;}
  {-}
begin
 {$IfDef k2GeneratorIsComponent}
 inherited;
 {$Else  k2GeneratorIsComponent}
 inherited Create;
 {$EndIf k2GeneratorIsComponent}
 CurrentVersion := k2FormatCurVersionI;
 f_CharsInLine := 73;
 TT := k2.TypeTable;
end;

class function Tk2TagGenerator.Make: Ik2TagGenerator;
  //reintroduce;
  //virtual;
  {-}
var
 l_Gen : Tk2TagGenerator;
begin
 l_Gen := Create;
 try
  Result := l_Gen;
 finally
  l3Free(l_Gen);
 end;//try..finally
end;

class function Tk2TagGenerator.SetTo(var theGenerator: Tk2TagGenerator): Pointer;
  {-}
var
 l_Filter : Tk2TagGenerator;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

class function Tk2TagGenerator.SetTo(var theGenerator: Ik2TagGenerator): Ik2TagGenerator;
  //overload;
  {* - ������� ��������� ����� � ������� ��� � ����������. }
var
 l_Filter : Tk2TagGenerator;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  theGenerator := l_Filter;
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

procedure Tk2TagGenerator.Start;
  {-}
begin
 if (Self <> nil) then begin
  Inc(f_Starts);
  Inc(f_FakeStarts);
  if (f_Starts = 1) then
  begin
   OpenStream;
   AfterStreamOpened;
  end;//f_Starts = 1
 end;{Self <> nil}
end;

procedure Tk2TagGenerator.Finish(NeedUndo: Bool = false);
  {-}

 procedure RaiseBadFinishCall;
 begin//RaiseBadFinishCall
  raise Exception.Create(k2_errBadFinishCall);
 end;//RaiseBadFinishCall

begin
 if (Self <> nil) then
 begin
  if (f_Starts <= 0) then
  begin
   if not (ExceptObject Is El3AbortLoad) then
   // - �� ���� ��������� exception ���� �������� ��������
    RaiseBadFinishCall;
  end//f_Starts <= 0
  else
  begin
   Dec(f_Starts);
   if (f_Starts >= f_FakeStarts) then
    // - ������� ������ ��� ������� ������ Start
    CloseStructure(NeedUndo)
   else
   begin
    Dec(f_FakeStarts);
    if (f_FakeStarts = 0) then
     CloseStream(NeedUndo);
   end;//f_Starts >= f_FakeStarts
  end;//f_Starts <= 0
 end;//Self <> nil
end;

procedure Tk2TagGenerator.StartObject(ID: Long);
  {-}
begin
 if (ID >= 0) then
  StartTag(ID)
 else
  StartChild(TypeTable.TypeByHandle[-ID]);
end;

function Tk2TagGenerator.GetObjectID(const Name: AnsiString; Child: Bool): Long;
  {virtual;}
  {-}
begin
 Result := 0;
end;

procedure Tk2TagGenerator.StartTag(TagID: Long);
  {virtual;}
  {-}
begin
 Inc(f_Starts);
end;

procedure Tk2TagGenerator.StartChild(TypeID: Tl3VariantDef);
  {virtual;}
  {-}
begin
 Inc(f_Starts);
end;

procedure Tk2TagGenerator.StartDefaultChild;
  {-}
var
 l_T : Tk2TypePrim;
begin
 l_T := CurrentType;
 if (l_T = nil) then
 begin
  //StartChild(k2_typDocument);
  Assert(false);
 end//l_T = nil
 else
  StartChild(Tk2Type(l_T.DefaultChildTypeID)); 
end;

procedure Tk2TagGenerator.AddAtom(AtomIndex: Long; aValue: Tl3Variant);
  {virtual;}
  {-}
begin
 if (AtomIndex < 0) then
 begin
  Assert(false);
  StartChild(TypeTable.TypeByHandle[-AtomIndex]);
  try
   AddAtom(k2_tiValue, aValue);
  finally
   Finish;
  end;//try..finally
 end;//AtomIndex < 0
end;

procedure Tk2TagGenerator.AddTransparentAtom(TagID: Long);
  {-}
begin
 AddAtom(TagID, Tk2Type(CurrentType.Prop[TagID].AtomType).TransparentTag);
end;

procedure Tk2TagGenerator.AddInt64Atom(TagID: Long; aValue: Int64);
  {* - �������� ������������� ����. }
type
 Tk2In64Converter = packed record
   rLo : Integer;
   rHi : Integer;
 end;//Tk2In64Converter
var
 l_V : Tk2In64Converter absolute aValue;
begin
 StartTag(TagID);
 try
  AddIntegerAtom(k2_tiDocID, l_V.rLo);
  AddIntegerAtom(k2_tiSubID, l_V.rHi);
 finally
  Finish;
 end;//try..finally
end;

procedure Tk2TagGenerator.AddIntegerAtom(TagID: Long; Value: Long);
  {-}
var
 l_Prop : Tk2Prop;
 l_CT : Tk2Type;  
begin
 if (TagID = k2_tiChildren) then
  AddAtom(TagID, k2_typLong.MakeTag(Value).AsObject)
 else
 begin
  l_CT := CurrentType;
  if (l_CT = nil) then
   AddAtom(TagID, k2_typLong.MakeTag(Value).AsObject)
  else
  begin
   l_Prop := Tk2Prop(l_CT.Prop[TagID]);
   if (l_Prop = nil) then
    AddAtom(TagID, k2_typLong.MakeTag(Value).AsObject)
   else
   begin
    Assert(l_Prop.AtomType <> nil);
    AddAtom(TagID, l_Prop.MakeTag(Value).AsObject);
   end;//l_Prop = nil
  end;//l_CT = nil
 end;//TagID = k2_tiChildren
end;

procedure Tk2TagGenerator.AddBoolAtom(TagID: Long; Value: Bool);
  {-}
begin
 if Value then
  AddIntegerAtom(TagID, 1)
 else
  AddIntegerAtom(TagID, 0);
end;

procedure Tk2TagGenerator.AddStringAtom(TagID: Long; const Value: AnsiString; aCodePage: Long = CP_ANSI);
  {overload;}
  {-}
begin
 AddStringAtom(TagID, l3PCharLen(Value, aCodePage));
end;

procedure Tk2TagGenerator.AddStringAtom(TagID: Long; const Value: Tl3WString);
  {-}
var
 S : Tk2String;
 l_Prop : Tk2Prop;
 l_CT : Tk2Type;  
begin
 l_CT := CurrentType;
 if (l_CT <> nil) then
 begin
  l_Prop := Tk2Prop(l_CT.Prop[TagID]);
  if (l_Prop <> nil) then
  begin
   if l_Prop.TagType.IsOrd then
   begin
    AddAtom(TagID, Tk2Type(l_Prop.TagType).StrToTag(l3Str(Value)));
    Exit;
   end;//l_Prop.TagType.IsOrd
  end;//l_Prop <> nil
 end;//l_CT <> nil
 S := Tk2String.Make(Value);
 try
  AddAtom(TagID, S)
 finally
  l3Free(S);
 end;{try..finally}
end;

procedure Tk2TagGenerator.AddStreamAtom(TagID: Long; aStream: TStream);
  {-}
var
 l_Tag  : Il3TagRef;
 l_Pool : Tk2RawData;
(* l_Stream : IStream;
 l_Read : Large;
 l_Written : Large;
 l_Position : Large;*)
begin
 if (aStream = nil) then
  AddAtom(TagID, nil)
 else 
 if aStream.GetInterface(Il3TagRef, l_Tag) then
  AddAtom(TagID, l_Tag.AsObject)
 else
 begin
//  l_Stream := l3Stream2IStream(aStream);
//  Assert(l_Stream <> nil);
  l_Pool := Tk2RawData.CreateFromStream(aStream);
  try
(*   OleCheck(l_Stream.Seek(0, STREAM_SEEK_SET, l_Position));
   {$IfDef nsTest}
   Dec(g_IStreamCopyTo_Guard);
   try
   {$EndIf nsTest}
    OleCheck(l_Stream.CopyTo(l_Pool As IStream, High(Large), l_Read, l_Written));
   {$IfDef nsTest}
   finally
    Inc(g_IStreamCopyTo_Guard);
   end;//try..finally
   {$EndIf nsTest}*)
   AddAtom(TagID, l_Pool)
  finally
   FreeAndNil(l_Pool);
  end;//try..finally
 end;//aStream.GetInterface(Il3TagRef, l_Tag)
// AddAtom(TagID, k2_tkStream, aStream);
end;

procedure Tk2TagGenerator.TranslateAddAtom(AtomIndex: Long; aValue: Tl3Variant);
  {-}
begin
 AddAtomEx(AtomIndex, Tk2VariantImpl.Make(aValue));
end;
(*var
 Obj        : _Ik2Tag absolute Value;
 AsPChar    : PAnsiChar absolute Value;
 AsPCharLen : Tl3PCharLen absolute Value;
 AsLong     : Long absolute Value;
 AsByte     : Byte absolute Value;
 AsString   : AnsiString absolute Value;
 NewValue   : Tk2Variant;
begin
 Case TK of
  k2_tkInteger, k2_tkBool:
  begin
   if (AsLong = k2_TransparentValue) then
   begin
    NewValue.Kind := k2_vkTransparent;
    AddAtomEx(AtomIndex, NewValue);
   end
   else
   begin
    NewValue.Kind := k2_vkInteger;
    if (TK = k2_tkBool) then
     NewValue.AsInteger := AsByte
    else
     NewValue.AsInteger := AsLong;
    AddAtomEx(AtomIndex, NewValue);
   end;{AsLong = k2_TransparentValue}
  end;//k2_tkInteger, k2_tkBool
  k2_tkObject:
  begin
   if (AsLong = k2_TransparentValue) then
   begin
    Assert(false);
    NewValue.Kind := k2_vkTransparent;
    AddAtomEx(AtomIndex, NewValue);
   end//AsLong = k2_TransparentValue
   else
   if (Obj = nil) then
   begin
    NewValue.Kind := k2_vkString;
    NewValue.AsString := nil;
    AddAtomEx(AtomIndex, NewValue);
   end//Obj = nil
   else
   if (Obj.AsObject Is Tl3PrimString) then
   begin
    NewValue.Kind := k2_vkString;
    NewValue.AsString := Tl3PrimString(Obj.AsObject);
    AddAtomEx(AtomIndex, NewValue);
   end//Obj Is Tl3Base
   else
   if (Obj.AsObject Is TStream) then
   begin
    NewValue.Kind := k2_vkStream;
    NewValue.AsStream := TStream(Obj.AsObject);
    AddAtomEx(AtomIndex, NewValue);
   end//Obj Is TStream
   else
    ConvertError(Obj.AsObject.ClassName, ClassName);
  end;//k2_tkObject
  k2_tkTransparent:
  begin
   NewValue.Kind := k2_vkTransparent;
   AddAtomEx(AtomIndex, NewValue);
  end;//k2_tkTransparent
  k2_tkStream:
  begin
   NewValue.Kind := k2_vkStream;
   NewValue.AsStream := TStream(Value);
   AddAtomEx(AtomIndex, NewValue);
  end;//k2_tkStream
  else
   ConvertError(GetEnumName(TypeInfo(Tk2TypeKind), Ord(TK)), ClassName);
 end;//Case TK
end;*)

procedure Tk2TagGenerator.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  {virtual;}
  {-}
var
 l_Tag : Il3TagRef;
 l_Str : Tk2String; 
begin
 //Assert(false, '����� AddAtomEx ������ ���� �������� � ' + ClassName);
 if Value.AsVariant.IsNull then
  Exit;
 Case Value.Kind of
  k2_vkInteger:
   AddIntegerAtom(AtomIndex, Value.AsInteger);
  k2_vkString:
  begin
   if Value.AsString.GetInterface(Il3TagRef, l_Tag) then
    AddAtom(AtomIndex, Value.AsString)
   else
   begin
    l_Str := Tk2String.Create;
    try
     l_Str.AssignString(Value.AsString);
     AddAtom(AtomIndex, l_Str)
    finally
     FreeAndNil(l_Str);
    end;//try..finally
   end;//Value.AsString.GetInterface(Il3TagRef, l_Tag
  end;//k2_vkString
  k2_vkTransparent:
   AddTransparentAtom(AtomIndex);
  k2_vkStream:
   AddStreamAtom(AtomIndex, Value.AsStream);
  else
   ConvertErrorEx(Value.Kind);
 end;{Case TK}
end;

procedure Tk2TagGenerator.ConvertErrorEx(TypeKind: Tk2VarKind);
  {-}
begin
 try
  ConvertError(GetEnumName(TypeInfo(Tk2VarKind), Ord(TypeKind)), ClassName);
 except
  on E: Exception do
  begin
   Msg2Log(E.Message);
   raise;
  end;//on E: Exception
 end;//try..except
end;

{$IfDef k2GeneratorIsComponent}
procedure Tk2TagGenerator.Notification(aComponent: TComponent; Operation: TOperation);
  //override;
  {-}
begin
 inherited;
 if (Operation = opRemove) AND l3IEQ(aComponent, Generator) then
  Generator := nil;
end;
{$EndIf k2GeneratorIsComponent}

end.

