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
      ToolTipText     =   "Выберите из списка имя Вашего региона"
      Top             =   360
      Width           =   3735
   End
   Begin VB.Frame Frame1 
      Caption         =   "Выбор региона"
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
      ToolTipText     =   "Отображает текущий ID выбранного региона"
      Top             =   960
      Width           =   3855
   End
   Begin VB.Menu File 
      Caption         =   "Файл"
      Begin VB.Menu Clos 
         Caption         =   "Выйти"
         Shortcut        =   ^{F4}
      End
   End
   Begin VB.Menu Help 
      Caption         =   "Помощь"
      Begin VB.Menu HelpReguios 
         Caption         =   "Справка"
         Shortcut        =   {F1}
      End
      Begin VB.Menu about 
         Caption         =   "О программе..."
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

'Формируем список

With Combo1
.AddItem ("НПП")
.AddItem ("НПП Тверь")
.AddItem ("Абакан")
.AddItem ("Архангельск")
.AddItem ("Астрахань")
.AddItem ("Барнаул")
.AddItem ("Благовещенск")
.AddItem ("Владивосток")
.AddItem ("Владимир")
.AddItem ("Волгоград")
.AddItem ("Вологда")
.AddItem ("Воронеж")
.AddItem ("Екатеринбург")
.AddItem ("Иваново")
.AddItem ("Ижевск")
.AddItem ("Иркутск")
.AddItem ("Казань")
.AddItem ("Калининград")
.AddItem ("Калуга")
.AddItem ("Краснодар")
.AddItem ("Кубань")
.AddItem ("Лермонтов")
.AddItem ("Мурманск")
.AddItem ("Нижний Новгород")
.AddItem ("Новгород")
.AddItem ("Новосибирск")
.AddItem ("Омск")
.AddItem ("Орел")
.AddItem ("Оренбург")
.AddItem ("Пенза")
.AddItem ("Петропаловск-Камчатский")
.AddItem ("Псков")
.AddItem ("Ростов")
.AddItem ("Рязань")
.AddItem ("Самара")
.AddItem ("Санкт-Петербург")
.AddItem ("Саранск")
.AddItem ("Саратов")
.AddItem ("Смоленск")
.AddItem ("Сургут")
.AddItem ("Тамбов")
.AddItem ("Тверь")
.AddItem ("Томск")
.AddItem ("Тула")
.AddItem ("Тюмень")
.AddItem ("Ульяновск")
.AddItem ("Уфа")
.AddItem ("Химки")
.AddItem ("Чебоксары")
.AddItem ("Челябинск")
.AddItem ("Чита")
.AddItem ("Ярославль")
.AddItem ("")
End With
    
End Sub

Private Sub Combo1_Click()
     'Размер формы после выбора имя региона
    Form1.Height = 2050
    Form1.Width = 4350

Dim reg(51) As String
reg(0) = "НПП"
reg(1) = "НПП Тверь"
reg(2) = "Абакан"
reg(3) = "Архангельск"
reg(4) = "Астрахань"
reg(5) = "Барнаул"
reg(6) = "Благовещенск"
reg(7) = "Владивосток"
reg(8) = "Владимир"
reg(9) = "Волгоград"
reg(10) = "Вологда"
reg(11) = "Воронеж"
reg(12) = "Екатеринбург"
reg(13) = "Иваново"
reg(14) = "Ижевск"
reg(15) = "Иркутск"
reg(16) = "Казань"
reg(17) = "Калининград"
reg(18) = "Калуга"
reg(19) = "Краснодар"
reg(20) = "Кубань"
reg(21) = "Лермонтов"
reg(22) = "Мурманск"
reg(23) = "Нижний Новгород"
reg(24) = "Новгород"
reg(25) = "Новосибирск"
reg(26) = "Омск"
reg(27) = "Орел"
reg(28) = "Оренбург"
reg(29) = "Пенза"
reg(30) = "Петропаловск-Камчатский"
reg(31) = "Псков"
reg(32) = "Ростов"
reg(33) = "Рязань"
reg(34) = "Самара"
reg(35) = "Санкт-Петербург"
reg(36) = "Саранск"
reg(37) = "Саратов"
reg(38) = "Смоленск"
reg(39) = "Сургут"
reg(40) = "Тамбов"
reg(41) = "Тверь"
reg(42) = "Томск"
reg(43) = "Тула"
reg(44) = "Тюмень"
reg(45) = "Ульяновск"
reg(46) = "Уфа"
reg(47) = "Химки"
reg(48) = "Чебоксары"
reg(49) = "Челябинск"
reg(50) = "Чита"
reg(51) = "Ярославль"

Select Case Combo1
    Case reg(0)
    Label1.Caption = "ID Вашего региона: 0"
    Case reg(1)
    Label1.Caption = "ID Вашего региона: 1"
    Case reg(2)
    Label1.Caption = "ID Вашего региона: 10"
    Case reg(3)
    Label1.Caption = "ID Вашего региона: 11"
    Case reg(4)
    Label1.Caption = "ID Вашего региона: 12"
    Case reg(5)
    Label1.Caption = "ID Вашего региона: 13"
    Case reg(6)
    Label1.Caption = "ID Вашего региона: 14"
    Case reg(7)
    Label1.Caption = "ID Вашего региона: 15"
    Case reg(8)
    Label1.Caption = "ID Вашего региона: 16"
    Case reg(9)
    Label1.Caption = "ID Вашего региона: 17"
    Case reg(10)
    Label1.Caption = "ID Вашего региона: 18"
    Case reg(11)
    Label1.Caption = "ID Вашего региона: 19"
    Case reg(12)
    Label1.Caption = "ID Вашего региона: 20"
    Case reg(13)
    Label1.Caption = "ID Вашего региона: 21"
    Case reg(14)
    Label1.Caption = "ID Вашего региона: 22"
    Case reg(15)
    Label1.Caption = "ID Вашего региона: 23"
    Case reg(16)
    Label1.Caption = "ID Вашего региона: 24"
    Case reg(17)
    Label1.Caption = "ID Вашего региона: 25"
    Case reg(18)
    Label1.Caption = "ID Вашего региона: 26"
    Case reg(19)
    Label1.Caption = "ID Вашего региона: 27"
    Case reg(20)
    Label1.Caption = "ID Вашего региона: 28"
    Case reg(21)
    Label1.Caption = "ID Вашего региона: 29"
    Case reg(22)
    Label1.Caption = "ID Вашего региона: 31"
    Case reg(22)
    Label1.Caption = "ID Вашего региона: 31"
    Case reg(23)
    Label1.Caption = "ID Вашего региона: 32"
    Case reg(24)
    Label1.Caption = "ID Вашего региона: 33"
    Case reg(25)
    Label1.Caption = "ID Вашего региона: 34"
    Case reg(26)
    Label1.Caption = "ID Вашего региона: 35"
    Case reg(27)
    Label1.Caption = "ID Вашего региона: 36"
    Case reg(28)
    Label1.Caption = "ID Вашего региона: 37"
    Case reg(29)
    Label1.Caption = "ID Вашего региона: 38"
    Case reg(30)
    Label1.Caption = "ID Вашего региона: 39"
    Case reg(31)
    Label1.Caption = "ID Вашего региона: 40"
    Case reg(32)
    Label1.Caption = "ID Вашего региона: 41"
    Case reg(33)
    Label1.Caption = "ID Вашего региона: 42"
    Case reg(34)
    Label1.Caption = "ID Вашего региона: 43"
    Case reg(35)
    Label1.Caption = "ID Вашего региона: 44"
    Case reg(36)
    Label1.Caption = "ID Вашего региона: 45"
    Case reg(37)
    Label1.Caption = "ID Вашего региона: 46"
    Case reg(38)
    Label1.Caption = "ID Вашего региона: 47"
    Case reg(39)
    Label1.Caption = "ID Вашего региона: 48"
    Case reg(40)
    Label1.Caption = "ID Вашего региона: 49"
    Case reg(41)
    Label1.Caption = "ID Вашего региона: 50"
    Case reg(42)
    Label1.Caption = "ID Вашего региона: 51"
    Case reg(43)
    Label1.Caption = "ID Вашего региона: 52"
    Case reg(44)
    Label1.Caption = "ID Вашего региона: 53"
    Case reg(45)
    Label1.Caption = "ID Вашего региона: 54"
    Case reg(46)
    Label1.Caption = "ID Вашего региона: 55"
    Case reg(47)
    Label1.Caption = "ID Вашего региона: 56"
    Case reg(48)
    Label1.Caption = "ID Вашего региона: 57"
    Case reg(49)
    Label1.Caption = "ID Вашего региона: 58"
    Case reg(50)
    Label1.Caption = "ID Вашего региона: 59"
    Case reg(51)
    Label1.Caption = "ID Вашего региона: 60"
    
    'Else
    'MsgBox "Имя региона не выбрано", vbInformation, "Regions"

    End Select
End Sub

Private Sub Form_Initialize()
    'Цвет шрифта
    Label1.Font.Bold = True
    Label1.ForeColor = &H0&

    'Размер формы
    Form1.Height = 1800
    Form1.Width = 4350

With Combo1
.AddItem ("НПП")
.AddItem ("НПП Тверь")
.AddItem ("Абакан")
.AddItem ("Архангельск")
.AddItem ("Астрахань")
.AddItem ("Барнаул")
.AddItem ("Благовещенск")
.AddItem ("Владивосток")
.AddItem ("Владимир")
.AddItem ("Волгоград")
.AddItem ("Вологда")
.AddItem ("Воронеж")
.AddItem ("Екатеринбург")
.AddItem ("Иваново")
.AddItem ("Ижевск")
.AddItem ("Иркутск")
.AddItem ("Казань")
.AddItem ("Калининград")
.AddItem ("Калуга")
.AddItem ("Краснодар")
.AddItem ("Кубань")
.AddItem ("Лермонтов")
.AddItem ("Мурманск")
.AddItem ("Нижний Новгород")
.AddItem ("Новгород")
.AddItem ("Новосибирск")
.AddItem ("Омск")
.AddItem ("Орел")
.AddItem ("Оренбург")
.AddItem ("Пенза")
.AddItem ("Петропаловск-Камчатский")
.AddItem ("Псков")
.AddItem ("Ростов")
.AddItem ("Рязань")
.AddItem ("Самара")
.AddItem ("Санкт-Петербург")
.AddItem ("Саранск")
.AddItem ("Саратов")
.AddItem ("Смоленск")
.AddItem ("Сургут")
.AddItem ("Тамбов")
.AddItem ("Тверь")
.AddItem ("Томск")
.AddItem ("Тула")
.AddItem ("Тюмень")
.AddItem ("Ульяновск")
.AddItem ("Уфа")
.AddItem ("Химки")
.AddItem ("Чебоксары")
.AddItem ("Челябинск")
.AddItem ("Чита")
.AddItem ("Ярославль")

End With

End Sub


Private Sub HelpReguios_Click()
MsgBox "Утилита используется для получения ID региона по его имени. Применяется совместно с программой RegionTool, добавляющей код региона к номеру пользователя. ", vbInformation

End Sub
