
Partial Class Hogan_UploadCodes
    Inherits System.Web.UI.Page

    Protected Sub btnUpload_Click(sender As Object, e As System.EventArgs) Handles btnUpload.Click
        If Not File1.HasFile Then
            Me.Message.Text = "Select file to upload."
            Exit Sub
        End If

        'Save file
        Dim sFileName As String
        sFileName = Second(Now()) & File1.FileName
        File1.SaveAs(Server.MapPath("uploads/" & sFileName))
        'Me.Message.Text = sFileName

        'Load
        Data_Load(sFileName)
    End Sub


    Sub Data_Load(ByVal sFileName As String)
        Dim sSql As String
        Dim sConn As String, c1 As New System.Data.Odbc.OdbcConnection
        Dim cmd1 As New System.Data.Odbc.OdbcCommand
        Dim reader As System.Data.Odbc.OdbcDataReader, iRowNo As Int32
        Dim sFrom As String, sTo As String, sSkipped As String
        Dim iUploadCount As Integer

        'Start
        sSkipped = ""

        'Read data from Excel file
        Trace.Warn(Server.MapPath("uploads"))
        sConn = "Driver={Microsoft Text Driver (*.txt; *.csv)};Dbq=" + Server.MapPath("uploads") + ";"
        c1.ConnectionString = sConn
        c1.Open()

        'Open Command
        sSql = "Select [User ID], [Password] from [" & sFileName & "]"
        Trace.Warn(sSql)
        cmd1.CommandText = sSql
        cmd1.Connection = c1
        reader = cmd1.ExecuteReader()

        'Read spreadsheet
        iRowNo = 1
        iUploadCount = 0
        While reader.Read
            iRowNo = iRowNo + 1
            sFrom = ""
            sTo = "UserName, UserPassword, AssgnTypeID"
            Trace.Warn(iRowNo & "=" & reader(0))
            If InStr(Trim(CF.NullToString(reader("User ID"))), "") = 0 Or InStr(Trim(CF.NullToString(reader("Password"))), "") = 0 Then
                sSkipped &= ", " & iRowNo
            Else
                sFrom = "'" & Replace(reader("User ID"), "'", "''") & "'"
                sFrom = sFrom & ", '" & Replace(reader("Password"), "'", "''") & "'"
                sFrom = sFrom & ", '" & Me.AssgnTypeID.SelectedValue & "'"
                
                'Insert Participant
                sSql = "Insert into HoganCodes (" & sTo & ") Select " & sFrom
                Trace.Warn(sSql)
                CF.Runquery(sSql)
                iUploadCount = iUploadCount + 1
            End If
        End While
        reader.Close()
        c1.Close()
        c1 = Nothing

        Me.Message.Text = iUploadCount & " records loaded."

    End Sub

    Protected Sub tabCan_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabCan.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Cells(0).Text = e.Row.RowIndex + 1
        End If
    End Sub
End Class
