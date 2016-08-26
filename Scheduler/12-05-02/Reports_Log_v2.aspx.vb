Imports System.Data

Partial Class test_files
    Inherits System.Web.UI.Page
    Dim dvF As System.Data.DataView

    Protected Sub btnList_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnList.Click
        ReportLog.Files_Scan(Me.DirName.Text)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'ReportLog.Files_Scan("c:\inetpub\wwwroot\odgers_live\hoganreports")
    End Sub

    'Protected Sub btnImport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImport.Click
    '    Dim sFileName As String, i1 As Integer, j1 As Integer
    '    Dim sSql As String

    '    sFileName = Server.MapPath("../HoganReports/HoganImport.CSV")
    '    Trace.Warn(sFileName)
    '    dvF = CF.DataView_Get("Select ColumnName, CanFieldName from ImportSpec where CanFieldName is not Null and CanFieldName <>'ignore' order by ColumnName")

    '    Dim conn As System.Data.Odbc.OdbcConnection
    '    Dim dt As New System.Data.DataTable
    '    Dim da As System.Data.Odbc.OdbcDataAdapter
    '    Dim connectionString As String, sFieldName As String, sHoganCode As String

    '    connectionString = "Driver={Microsoft Text Driver (*.txt; *.csv)};Dbq=" + "F:\crap\ann\Odgers_live\HoganReports" + ";"
    '    conn = New Odbc.OdbcConnection(connectionString)
    '    da = New System.Data.Odbc.OdbcDataAdapter("select * from [" + "HoganImport.csv" + "]", conn)
    '    da.Fill(dt)

    '    Trace.Warn(dt.Rows.Count)
    '    sSql = ""
    '    For j1 = 0 To dt.Rows.Count - 1
    '        For i1 = 0 To dt.Columns.Count - 1
    '            'Trace.Warn(dt.Columns(i1).ColumnName & "=" & dt.Rows(j1)(dt.Columns(i1).ColumnName))
    '            sFieldName = FieldName_Get(dt.Columns(i1).ColumnName)
    '            If sFieldName <> "" Then
    '                If sFieldName = "HoganCode" Then
    '                    sHoganCode = dt.Rows(j1)(dt.Columns(i1).ColumnName)
    '                Else
    '                    sSql = sSql & ", " & sFieldName & "='" & dt.Rows(j1)(dt.Columns(i1).ColumnName) & "'"
    '                End If
    '            Else
    '                Trace.Warn("Not found " & dt.Columns(i1).ColumnName)
    '            End If
    '        Next
    '    Next
    '    sSql = "Update Candidates set " & Mid(sSql, 2) & " where CandidateID="
    '    sSql = sSql & "(select top 1 CandidateID from HoganCodes where HoganCode='" & sHoganCode & "')"
    '    Trace.Warn(sSql)
    'End Sub

    'Function FieldName_Get(ByVal sFieldName As String) As String
    '    Dim i1 As Integer
    '    For i1 = 0 To dvF.Table.Rows.Count - 1
    '        If UCase(dvF.Table.Rows(i1)("ColumnName")) = UCase(sFieldName) Then

    '            FieldName_Get = dvF.Table.Rows(i1)("CanFieldName")
    '            Exit Function
    '        End If
    '    Next
    '    'Trace.Warn("Not found")
    '    FieldName_Get = ""
    'End Function

    Protected Sub btnImport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImport.Click
        'Import1.Files_Scan("f:\crap\ann\odgers_live\hoganreports\")
        Import1.Files_Scan("c:\inetpub\wwwroot\odgers_live\hoganreports\")
    End Sub
End Class
