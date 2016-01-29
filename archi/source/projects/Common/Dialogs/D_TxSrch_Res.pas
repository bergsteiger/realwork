unit D_TxSrch_Res;

// ������� ��� ������� ������

{ $Id: D_TxSrch_Res.pas,v 1.3 2005/02/18 13:34:11 lulin Exp $}

// $Log: D_TxSrch_Res.pas,v $
// Revision 1.3  2005/02/18 13:34:11  lulin
// - ����� ������� � ������ ������.
//
// Revision 1.2  2004/11/30 09:41:06  fireton
// - ����������� ������� ������
//

interface

uses
  SysUtils, Classes, ImgList, Controls;


resourcestring
 sidNotValidHyperAddress    = '������������ ����� ����������� %d.%d.';
 sidCannotAddHyperLink      = '�� ������� �������� ������. :(';
 sidDoubletHyperAddress     = '����������� ��� ��������� �� ����� %d.%d.';
 sidQstDelDoublet           = '������� ������?';

const
  picSrchAnchor       = 0;
  picSrchText         = 1;
  picSrchStyle        = 2;
  picSrchHLink        = 3;



type
  TSrchRes = class(TDataModule)
    CommonImageList: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function SrchRes: TSrchRes;
  {-}

implementation

{$R *.dfm}

var
  g_SrchRes: TSrchRes;

function SrchRes: TSrchRes;
  {-}
begin
 g_SrchRes := TSrchRes.Create(nil);
 Result := g_SrchRes;
end;

initialization

finalization
  FreeAndNil(g_SrchRes);
  
end.
