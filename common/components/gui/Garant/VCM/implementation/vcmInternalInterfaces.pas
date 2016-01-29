unit vcmInternalInterfaces;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmInternalInterfaces - }
{ �����: 23.06.2003 18:04 }
{ $Id: vcmInternalInterfaces.pas,v 1.9 2015/03/18 11:14:07 lulin Exp $ }

// $Log: vcmInternalInterfaces.pas,v $
// Revision 1.9  2015/03/18 11:14:07  lulin
// - ������������� ��������� ������������.
//
// Revision 1.8  2012/04/13 14:37:25  lulin
// {RequestLink:237994598}
//
// Revision 1.7  2008/03/19 14:23:42  lulin
// - cleanup.
//
// Revision 1.6  2008/02/01 15:14:33  lulin
// - ����������� �� �������� ��������������� �������.
//
// Revision 1.5  2007/04/04 09:10:28  lulin
// - bug fix: �� ���������� ��������� � ���������� �������� (CQ OIT5-24865).
//
// Revision 1.4  2004/06/02 10:20:38  law
// - ������ ����������� Tl3VList.MakeIUnknown - ����������� _Tl3InterfaceList.Make.
//
// Revision 1.3  2003/09/26 15:23:58  law
// - new behavior: ����� ������ ������ ��������� ��������.
//
// Revision 1.2  2003/06/23 15:03:21  law
// - change: �������� _IvcmContainer.GUID ��������� � IvcmEntityForm.GUID - ������ ������ ����� ����� ���� �������������.
// - remove interface: IvcmGUIDSetter.
// - new param: ����������� _TvcmEntityForm.Make ���� ��� ���� �������� - aGUID - ��� �������������� �������������� ����� ��� ��������� Back/Forward.
//
// Revision 1.1  2003/06/23 14:27:04  law
// - new behavior: ������ ��������� ��������������� ���� GUID ��� ��������� Back/Forward.
//

{$Include vcmDefine.inc }

interface

uses
  vcmInterfaces,

  vcmBase
  ;

type
  IvcmForms = interface(IUnknown)
    ['{627B46F8-E5F3-41C3-9A17-808CE33C2598}']
    // public methods
      procedure GetEntityForms(aList : TvcmClassList);
        {-}
  end;//IvcmForms

implementation

end.

