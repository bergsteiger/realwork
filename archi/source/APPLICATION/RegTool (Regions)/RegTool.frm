VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Regions"
   ClientHeight    =   1545
   ClientLeft      =   1815
   ClientTop       =   2520
   ClientWidth     =   4230
   Icon            =   "RegTool.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   1545
   ScaleWidth      =   4230
   StartUpPosition =   2  'CenterScreen
   WhatsThisButton =   -1  'True
   WhatsThisHelp   =   -1  'True
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   240
      Sorted          =   -1  'True
      Style           =   2  'Dropdown List
      TabIndex        =   1
      ToolTipText     =   "�������� �� ������ ��� ������ �������"
      Top             =   360
      Width           =   3735
   End
   Begin VB.Frame Frame1 
      Caption         =   "����� �������"
      Height          =   735
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3975
   End
   Begin VB.Label Label1 
      ForeColor       =   &H00000000&
      Height          =   255
      Left            =   120
      TabIndex        =   2
      ToolTipText     =   "���������� ������� ID ���������� �������"
      Top             =   960
      Width           =   3855
   End
   Begin VB.Menu File 
      Caption         =   "����"
      Begin VB.Menu Clos 
         Caption         =   "�����"
         Shortcut        =   ^{F4}
      End
   End
   Begin VB.Menu Help 
      Caption         =   "������"
      Begin VB.Menu HelpReguios 
         Caption         =   "�������"
         Shortcut        =   {F1}
      End
      Begin VB.Menu about 
         Caption         =   "� ���������..."
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub about_Click()
frmAbout.Show
End Sub

Private Sub Clos_Click()
Unload Me

End Sub

Private Sub Combo1_Change()

'��������� ������

With Combo1
.AddItem ("���")
.AddItem ("��� �����")
.AddItem ("������")
.AddItem ("�����������")
.AddItem ("���������")
.AddItem ("�������")
.AddItem ("������������")
.AddItem ("�����������")
.AddItem ("��������")
.AddItem ("���������")
.AddItem ("�������")
.AddItem ("�������")
.AddItem ("������������")
.AddItem ("�������")
.AddItem ("������")
.AddItem ("�������")
.AddItem ("������")
.AddItem ("�����������")
.AddItem ("������")
.AddItem ("���������")
.AddItem ("������")
.AddItem ("���������")
.AddItem ("��������")
.AddItem ("������ ��������")
.AddItem ("��������")
.AddItem ("�����������")
.AddItem ("����")
.AddItem ("����")
.AddItem ("��������")
.AddItem ("�����")
.AddItem ("������������-����������")
.AddItem ("�����")
.AddItem ("������")
.AddItem ("������")
.AddItem ("������")
.AddItem ("�����-���������")
.AddItem ("�������")
.AddItem ("�������")
.AddItem ("��������")
.AddItem ("������")
.AddItem ("������")
.AddItem ("�����")
.AddItem ("�����")
.AddItem ("����")
.AddItem ("������")
.AddItem ("���������")
.AddItem ("���")
.AddItem ("�����")
.AddItem ("���������")
.AddItem ("���������")
.AddItem ("����")
.AddItem ("���������")
.AddItem ("")
End With
    
End Sub

Private Sub Combo1_Click()
     '������ ����� ����� ������ ��� �������
    Form1.Height = 2050
    Form1.Width = 4350

Dim reg(51) As String
reg(0) = "���"
reg(1) = "��� �����"
reg(2) = "������"
reg(3) = "�����������"
reg(4) = "���������"
reg(5) = "�������"
reg(6) = "������������"
reg(7) = "�����������"
reg(8) = "��������"
reg(9) = "���������"
reg(10) = "�������"
reg(11) = "�������"
reg(12) = "������������"
reg(13) = "�������"
reg(14) = "������"
reg(15) = "�������"
reg(16) = "������"
reg(17) = "�����������"
reg(18) = "������"
reg(19) = "���������"
reg(20) = "������"
reg(21) = "���������"
reg(22) = "��������"
reg(23) = "������ ��������"
reg(24) = "��������"
reg(25) = "�����������"
reg(26) = "����"
reg(27) = "����"
reg(28) = "��������"
reg(29) = "�����"
reg(30) = "������������-����������"
reg(31) = "�����"
reg(32) = "������"
reg(33) = "������"
reg(34) = "������"
reg(35) = "�����-���������"
reg(36) = "�������"
reg(37) = "�������"
reg(38) = "��������"
reg(39) = "������"
reg(40) = "������"
reg(41) = "�����"
reg(42) = "�����"
reg(43) = "����"
reg(44) = "������"
reg(45) = "���������"
reg(46) = "���"
reg(47) = "�����"
reg(48) = "���������"
reg(49) = "���������"
reg(50) = "����"
reg(51) = "���������"

Select Case Combo1
    Case reg(0)
    Label1.Caption = "ID ������ �������: 0"
    Case reg(1)
    Label1.Caption = "ID ������ �������: 1"
    Case reg(2)
    Label1.Caption = "ID ������ �������: 10"
    Case reg(3)
    Label1.Caption = "ID ������ �������: 11"
    Case reg(4)
    Label1.Caption = "ID ������ �������: 12"
    Case reg(5)
    Label1.Caption = "ID ������ �������: 13"
    Case reg(6)
    Label1.Caption = "ID ������ �������: 14"
    Case reg(7)
    Label1.Caption = "ID ������ �������: 15"
    Case reg(8)
    Label1.Caption = "ID ������ �������: 16"
    Case reg(9)
    Label1.Caption = "ID ������ �������: 17"
    Case reg(10)
    Label1.Caption = "ID ������ �������: 18"
    Case reg(11)
    Label1.Caption = "ID ������ �������: 19"
    Case reg(12)
    Label1.Caption = "ID ������ �������: 20"
    Case reg(13)
    Label1.Caption = "ID ������ �������: 21"
    Case reg(14)
    Label1.Caption = "ID ������ �������: 22"
    Case reg(15)
    Label1.Caption = "ID ������ �������: 23"
    Case reg(16)
    Label1.Caption = "ID ������ �������: 24"
    Case reg(17)
    Label1.Caption = "ID ������ �������: 25"
    Case reg(18)
    Label1.Caption = "ID ������ �������: 26"
    Case reg(19)
    Label1.Caption = "ID ������ �������: 27"
    Case reg(20)
    Label1.Caption = "ID ������ �������: 28"
    Case reg(21)
    Label1.Caption = "ID ������ �������: 29"
    Case reg(22)
    Label1.Caption = "ID ������ �������: 31"
    Case reg(22)
    Label1.Caption = "ID ������ �������: 31"
    Case reg(23)
    Label1.Caption = "ID ������ �������: 32"
    Case reg(24)
    Label1.Caption = "ID ������ �������: 33"
    Case reg(25)
    Label1.Caption = "ID ������ �������: 34"
    Case reg(26)
    Label1.Caption = "ID ������ �������: 35"
    Case reg(27)
    Label1.Caption = "ID ������ �������: 36"
    Case reg(28)
    Label1.Caption = "ID ������ �������: 37"
    Case reg(29)
    Label1.Caption = "ID ������ �������: 38"
    Case reg(30)
    Label1.Caption = "ID ������ �������: 39"
    Case reg(31)
    Label1.Caption = "ID ������ �������: 40"
    Case reg(32)
    Label1.Caption = "ID ������ �������: 41"
    Case reg(33)
    Label1.Caption = "ID ������ �������: 42"
    Case reg(34)
    Label1.Caption = "ID ������ �������: 43"
    Case reg(35)
    Label1.Caption = "ID ������ �������: 44"
    Case reg(36)
    Label1.Caption = "ID ������ �������: 45"
    Case reg(37)
    Label1.Caption = "ID ������ �������: 46"
    Case reg(38)
    Label1.Caption = "ID ������ �������: 47"
    Case reg(39)
    Label1.Caption = "ID ������ �������: 48"
    Case reg(40)
    Label1.Caption = "ID ������ �������: 49"
    Case reg(41)
    Label1.Caption = "ID ������ �������: 50"
    Case reg(42)
    Label1.Caption = "ID ������ �������: 51"
    Case reg(43)
    Label1.Caption = "ID ������ �������: 52"
    Case reg(44)
    Label1.Caption = "ID ������ �������: 53"
    Case reg(45)
    Label1.Caption = "ID ������ �������: 54"
    Case reg(46)
    Label1.Caption = "ID ������ �������: 55"
    Case reg(47)
    Label1.Caption = "ID ������ �������: 56"
    Case reg(48)
    Label1.Caption = "ID ������ �������: 57"
    Case reg(49)
    Label1.Caption = "ID ������ �������: 58"
    Case reg(50)
    Label1.Caption = "ID ������ �������: 59"
    Case reg(51)
    Label1.Caption = "ID ������ �������: 60"
    
    'Else
    'MsgBox "��� ������� �� �������", vbInformation, "Regions"

    End Select
End Sub

Private Sub Form_Initialize()
    '���� ������
    Label1.Font.Bold = True
    Label1.ForeColor = &H0&

    '������ �����
    Form1.Height = 1800
    Form1.Width = 4350

With Combo1
.AddItem ("���")
.AddItem ("��� �����")
.AddItem ("������")
.AddItem ("�����������")
.AddItem ("���������")
.AddItem ("�������")
.AddItem ("������������")
.AddItem ("�����������")
.AddItem ("��������")
.AddItem ("���������")
.AddItem ("�������")
.AddItem ("�������")
.AddItem ("������������")
.AddItem ("�������")
.AddItem ("������")
.AddItem ("�������")
.AddItem ("������")
.AddItem ("�����������")
.AddItem ("������")
.AddItem ("���������")
.AddItem ("������")
.AddItem ("���������")
.AddItem ("��������")
.AddItem ("������ ��������")
.AddItem ("��������")
.AddItem ("�����������")
.AddItem ("����")
.AddItem ("����")
.AddItem ("��������")
.AddItem ("�����")
.AddItem ("������������-����������")
.AddItem ("�����")
.AddItem ("������")
.AddItem ("������")
.AddItem ("������")
.AddItem ("�����-���������")
.AddItem ("�������")
.AddItem ("�������")
.AddItem ("��������")
.AddItem ("������")
.AddItem ("������")
.AddItem ("�����")
.AddItem ("�����")
.AddItem ("����")
.AddItem ("������")
.AddItem ("���������")
.AddItem ("���")
.AddItem ("�����")
.AddItem ("���������")
.AddItem ("���������")
.AddItem ("����")
.AddItem ("���������")

End With

End Sub


Private Sub HelpReguios_Click()
MsgBox "������� ������������ ��� ��������� ID ������� �� ��� �����. ����������� ��������� � ���������� RegionTool, ����������� ��� ������� � ������ ������������. ", vbInformation

End Sub
