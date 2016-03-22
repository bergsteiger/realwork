Imports System.Windows.Forms
Public Class frmRegion
    Private filename As String
    Private Sub Dialog1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        smiCopyNumer.Enabled = False                                'Видимость кнопки меню
        Me.Height = 107                                             'Задаём размеры окна по высоте
        Me.AutoSizeMode = Windows.Forms.AutoSizeMode.GrowAndShrink  'Фиксируем размер по высоте, не даём изменять принудительно

        With ListComboBox
            .Items.Add("НПП")
            .Items.Add("НПП Тверь")
            .Items.Add("Абакан")
            .Items.Add("Архангельск")
            .Items.Add("Астрахань")
            .Items.Add("Барнаул")
            .Items.Add("Благовещенск")
            .Items.Add("Владивосток")
            .Items.Add("Владимир")
            .Items.Add("Волгоград")
            .Items.Add("Вологда")
            .Items.Add("Воронеж")
            .Items.Add("Екатеринбург")
            .Items.Add("Иваново")
            .Items.Add("Ижевск")
            .Items.Add("Иркутск")
            .Items.Add("Казань")
            .Items.Add("Калининград")
            .Items.Add("Калуга")
            .Items.Add("Краснодар")
            .Items.Add("Кубань")
            .Items.Add("Лермонтов")
            .Items.Add("Мурманск")
            .Items.Add("Нижний Новгород")
            .Items.Add("Новгород")
            .Items.Add("Новосибирск")
            .Items.Add("Омск")
            .Items.Add("Орел")
            .Items.Add("Оренбург")
            .Items.Add("Пенза")
            .Items.Add("Петропавловск-Камчатский")
            .Items.Add("Псков")
            .Items.Add("Ростов")
            .Items.Add("Рязань")
            .Items.Add("Самара")
            .Items.Add("Санкт-Петербург")
            .Items.Add("Саранск")
            .Items.Add("Саратов")
            .Items.Add("Смоленск")
            .Items.Add("Сургут")
            .Items.Add("Тамбов")
            .Items.Add("Тверь")
            .Items.Add("Томск")
            .Items.Add("Тула")
            .Items.Add("Тюмень")
            .Items.Add("Ульяновск")
            .Items.Add("Уфа")
            .Items.Add("Химки")
            .Items.Add("Чебоксары")
            .Items.Add("Челябинск")
            .Items.Add("Чита")
            .Items.Add("Ярославль")
        End With
    End Sub
    Private Sub smiExit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles smiExit.Click
        Me.Close()
    End Sub
    Private Sub smiAbout_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles smiAbout.Click
        frmAboutBox.Show()
    End Sub
    Private Sub tsCopyNumer_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles tsCopyNumer.Click
        copyNumer()
    End Sub
    Private Sub ListComboBox_SelectedValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListComboBox.SelectedValueChanged
        smiCopyNumer.Enabled = True    'Видимость кнопки меню
        Me.Height = 139                'Задаём размеры окна по высоте

        Dim reg(51) As String          'Формируем список
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
        reg(30) = "Петропавловск-Камчатский"
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

        Select Case ListComboBox.Text
            Case reg(0)
                lbNumer.Text = "0"
            Case reg(1)
                lbNumer.Text = "1"
            Case reg(2)
                lbNumer.Text = "10"
            Case reg(3)
                lbNumer.Text = "11"
            Case reg(4)
                lbNumer.Text = "12"
            Case reg(5)
                lbNumer.Text = "13"
            Case reg(6)
                lbNumer.Text = "14"
            Case reg(7)
                lbNumer.Text = "15"
            Case reg(8)
                lbNumer.Text = "16"
            Case reg(9)
                lbNumer.Text = "17"
            Case reg(10)
                lbNumer.Text = "18"
            Case reg(11)
                lbNumer.Text = "19"
            Case reg(12)
                lbNumer.Text = "20"
            Case reg(13)
                lbNumer.Text = "21"
            Case reg(14)
                lbNumer.Text = "22"
            Case reg(15)
                lbNumer.Text = "23"
            Case reg(16)
                lbNumer.Text = "24"
            Case reg(17)
                lbNumer.Text = "25"
            Case reg(18)
                lbNumer.Text = "26"
            Case reg(19)
                lbNumer.Text = "27"
            Case reg(20)
                lbNumer.Text = "28"
            Case reg(21)
                lbNumer.Text = "29"
            Case reg(22)
                lbNumer.Text = "31"
            Case reg(23)
                lbNumer.Text = "32"
            Case reg(24)
                lbNumer.Text = "33"
            Case reg(25)
                lbNumer.Text = "34"
            Case reg(26)
                lbNumer.Text = "35"
            Case reg(27)
                lbNumer.Text = "36"
            Case reg(28)
                lbNumer.Text = "37"
            Case reg(29)
                lbNumer.Text = "38"
            Case reg(30)
                lbNumer.Text = "39"
            Case reg(31)
                lbNumer.Text = "40"
            Case reg(32)
                lbNumer.Text = "41"
            Case reg(33)
                lbNumer.Text = "42"
            Case reg(34)
                lbNumer.Text = "43"
            Case reg(35)
                lbNumer.Text = "44"
            Case reg(36)
                lbNumer.Text = "45"
            Case reg(37)
                lbNumer.Text = "46"
            Case reg(38)
                lbNumer.Text = "47"
            Case reg(39)
                lbNumer.Text = "48"
            Case reg(40)
                lbNumer.Text = "49"
            Case reg(41)
                lbNumer.Text = "50"
            Case reg(42)
                lbNumer.Text = "51"
            Case reg(43)
                lbNumer.Text = "52"
            Case reg(44)
                lbNumer.Text = "53"
            Case reg(45)
                lbNumer.Text = "54"
            Case reg(46)
                lbNumer.Text = "55"
            Case reg(47)
                lbNumer.Text = "56"
            Case reg(48)
                lbNumer.Text = "57"
            Case reg(49)
                lbNumer.Text = "58"
            Case reg(50)
                lbNumer.Text = "59"
            Case reg(51)
                lbNumer.Text = "60"
        End Select
    End Sub
    Private Sub smiSaveList_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles smiSaveList.Click
        SaveList()     'Сохраняем из меню
    End Sub
    Private Sub tsSaveNumer_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles tsSaveNumer.Click
        SaveList()     'Сохраняем из контекстного меню
    End Sub
    Sub SaveList()
        Try
            With SaveFileRegions
                .AddExtension = True
                .CheckPathExists = True
                .CreatePrompt = False
                .OverwritePrompt = True
                .ValidateNames = True
                .ShowHelp = True
                .DefaultExt = "txt"
                .FileName = filename & ("IDRegions")
                .Filter = _
                "Текстовые файлы (*.txt)|*.txt|" & "All files|*.*"
                .FilterIndex = 1

                If .ShowDialog() = Windows.Forms.DialogResult.OK Then
                    My.Computer.FileSystem.WriteAllText(.FileName, My.Resources.regions, True)
                End If

            End With
        Catch ex As Exception
            MsgBox(ex.Message, MsgBoxStyle.Exclamation, Me.Text)
        End Try
    End Sub
    Sub copyNumer()
        My.Computer.Clipboard.SetText(lbNumer.Text)      'Забираем данные в буфер обмена (копируем номер)
    End Sub
    Private Sub smiCopyNumer_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles smiCopyNumer.Click
        copyNumer()
    End Sub
    Private Sub СправкаToolStripMenuItem_Click(sender As Object, e As EventArgs) Handles СправкаToolStripMenuItem.Click
        MsgBox("Руководство к утилите RegionTool расположено на ftp-сервере по адресу - ftp://partner.garant.ru/archi-utils/Manual/Archivarius.Utils/RegionTool.AdminGuide.pdf", MsgBoxStyle.Information)
    End Sub
End Class




