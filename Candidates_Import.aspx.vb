
Imports Microsoft.VisualBasic
Imports System.Data
Imports PPIExceptionHelper

Partial Class Basecamp
    Inherits System.Web.UI.Page
    Dim dvL As System.Data.DataView

    Protected Sub btnSubmit_Click(sender As Object, e As System.EventArgs) Handles btnSubmit.Click
        Dim sFileName As String

        If Not Me.CanImport1.HasFile Then
            Me.Message.Text = "Please select a file to upload."
            Exit Sub
        End If

        If UCase(Right(Me.CanImport1.FileName, 4)) <> ".CSV" Then
            Me.Message.Text = "Please choose a csv file."
            Exit Sub
        End If

        'Load Languages
        dvL = CF.DataView_Get("Select LanguageName, LanguageID from Languages order by LanguageName")

        sFileName = ConfigurationManager.AppSettings("AppRoot_FolderName")
        sFileName = sFileName & ConfigurationManager.AppSettings("CanImportFolderName")
        sFileName = sFileName & "\" & Me.CanImport1.FileName
        Me.CanImport1.SaveAs(sFileName)

        Import(Me.CanImport1.FileName)

    End Sub

    Sub Import(ByVal sFileName As String)
        Dim sSql As String, dvOne As System.Data.DataView
        Dim conn As System.Data.Odbc.OdbcConnection
        Dim dt As New System.Data.DataTable
        Dim da As System.Data.Odbc.OdbcDataAdapter
        Dim connectionString As String, sFolderName As String

        sFolderName = ConfigurationManager.AppSettings("AppRoot_FolderName")
        Trace.Warn(sFolderName)
        sFolderName = sFolderName & ConfigurationManager.AppSettings("CanImportFolderName")
        Trace.Warn(sFolderName)
        'Open file
        ReportLog.Debug_Show(sFileName)
        connectionString = "Driver={Microsoft Text Driver (*.txt; *.csv)};Dbq=" + sFolderName + ";"
        conn = New Odbc.OdbcConnection(connectionString)
        da = New System.Data.Odbc.OdbcDataAdapter("select * from [" + (sFileName) + "]", conn)
        da.Fill(dt)
        ReportLog.Debug_Show("ROWS=" & dt.Rows.Count)

        'Process data rows - one per candidate
        'Insert record in Candidates table and then also in the AssgnCandidates Table
        For j1 = 0 To dt.Rows.Count - 1
            ReportLog.Debug_Show("================================================================")
            sSql = "Insert into Candidates(FirstName, LastName, EmailAddress, Gender, LanguageID)"
            'For i1 = 0 To dt.Columns.Count - 1
            'ReportLog.Debug_Show(dt.Columns(i1).ColumnName & "=" & dt.Rows(j1)(dt.Columns(i1).ColumnName))
            'Next
            'FirstName
            sSql = sSql & " Select '" & Replace(dt.Rows(j1)(dt.Columns(0).ColumnName), "'", "''") & "'"

            'LastName
            sSql = sSql & ", '" & Replace(dt.Rows(j1)(dt.Columns(1).ColumnName), "'", "''") & "'"

            'EmailAddress
            sSql = sSql & ", '" & Replace(dt.Rows(j1)(dt.Columns(2).ColumnName), "'", "''") & "'"

            'Gender
            If UCase(dt.Rows(j1)(dt.Columns(3).ColumnName)) = "M" Then
                sSql = sSql & ", 'Male'"
            Else
                sSql = sSql & ", 'Female'"
            End If

            'Language
            sSql = sSql & ", " & LanguageID_Get(dt.Rows(j1)(dt.Columns(4).ColumnName))

            'Hogan Codes
            sSql = sSql & "; Update HoganCodes Set CandidateID=SCOPE_IDENTITY()"
            sSql = sSql & " from HoganCodes "
            sSql = sSql & " WHERE AutoID=(Select Top 1 AutoID from HoganCodes where"
            sSql = sSql & " (CandidateID IS NULL) AND (AssgnTypeID ="
            sSql = sSql & " (SELECT TOP (1) AssgnTypeID FROM Assignments"
            sSql = sSql & " WHERE (AssgnID = " & Request.QueryString("AssgnID") & "))))"

            'SCOPE_INDENTITY
            sSql = sSql & ";	Insert into AssgnCandidates(AssgnID, CandidateID) Select "
            sSql = sSql & Request.QueryString("AssgnID")
            sSql = sSql & ", Scope_Identity() "

            'Run sql
            Trace.Warn(sSql)
            CF.Runquery(sSql)

        Next
        Me.Message.Text = dt.Rows.Count & " Candidate records loaded."
    End Sub

    Function LanguageID_Get(sLanguageName As String) As Integer
        Dim i1 As Integer

        For i1 = 0 To dvL.Table.Rows.Count - 1
            If UCase(dvL.Table.Rows(i1)("LanguageName")) = UCase(sLanguageName) Then
                LanguageID_Get = dvL.Table.Rows(i1)("LanguageID")
                Exit Function
            End If
        Next
        LanguageID_Get = 1 'default to English
    End Function
End Class
